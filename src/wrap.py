"""Some of the code below is taken from:
https://renkulab.io/gitlab/learn-renku/teaching-on-renku/advanced-teaching-automation

Copyright 2022 Cyril Matthey-Doret

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

import re
from typing import Tuple, List, Dict
import requests
import yaml 
from copy import deepcopy

def get_group_id(group_url: str) -> int:
    """Given a group's URL, return it's gitlab ID"""
    base, namespace = parse_group_url(group_url)
    if namespace.find("/") > 0:
        parent_name = namespace.split("/")[0]
        group_name = namespace.split("/")[-1]
        query = f"{base}/api/v4/groups/{parent_name}/subgroups?search={group_name}"
    else:
        query = f"{base}/api/v4/groups/{namespace}"

    response = requests.get(query)
    if response.ok:
        content = response.json()
        # Subgroup response comes as a list and must be unwrapped
        if isinstance(content, list):
            content = content[0]
        return content["id"]
    else:
        response.raise_for_status()



def get_project_id(project_url: str) -> int:
    """Given a project's URL, return it's gitlab ID"""
    base, namespace, repo = parse_repo_url(project_url)
    project = []
    page = 1
    # Gitlab only provides max 100 results/page, we need to scan all pages
    # in case the project is not on the first one
    while not len(project):
        resp = requests.get(
            f"{base}/api/v4/projects?search={repo}&per_page=100&page={page}",
        )
        if resp.ok:
            resp = resp.json()
        else:
            resp.raise_for_status()
        page += 1
        project = [p for p in resp if p["path_with_namespace"] == f"{namespace}/{repo}"]

    if len(list(project)) > 1:
        raise ValueError("More than one project matched input url")
    return project[0]["id"]


def parse_repo_url(url: str) -> Tuple[str, str, str]:
    """Decompose a full repo URL into 3 parts:
    - the organization base URL
    - the namespace (i.e. groups and subgroups
    - the name of the repository

    Examples
    --------
    >>> parse_repo_url('https://org.com/group/subgroup/repo')
    ('https://org.com', 'group/subgroup', 'repo')
    >>> parse_repo_url('https://org.com/gitlab/group/repo')
    ('https://org.com/gitlab', 'group', 'repo')
    """
    regex = re.compile(
        (
            "(?P<base>https://[^/]*(/gitlab|/projects)?)/"
            "(?P<namespace>([^/]*/)*)"
            "(?P<repo>[^/]*)$"
        ),
        re.IGNORECASE,
    )
    captured = re.match(regex, url).groupdict()
    base, namespace, repo = [captured[group] for group in ["base", "namespace", "repo"]]
    namespace = namespace.strip("/")
    return base, namespace, repo


def parse_group_url(url: str) -> Tuple[str, str]:
    """Decompose a full group URL into 2 parts:
    - the organization base URL
    - the namespace (i.e. groups and subgroups

    Examples
    --------
    >>> parse_group_url('https://org.com/group/subgroup')
    ('https://org.com', 'group/subgroup')
    >>> parse_group_url('https://org.com/gitlab/group')
    ('https://org.com/gitlab', 'group')
    """
    regex = re.compile(
        (
            "(?P<base>https://[^/]*(/gitlab|/projects)?)/"
            "(?P<namespace>([^/]*/)*[^/]*)$"
        ),
        re.IGNORECASE,
    )
    captured = re.match(regex, url).groupdict()
    base, namespace = [captured[group] for group in ["base", "namespace"]]
    return base, namespace


def get_omni_groups(group_url: str) -> List[Dict]:
    """Retrieve the metadata from all groups in input namespace"""
    base, _ = parse_group_url(group_url)
    group_id = get_group_id(group_url)
    # Collect all projects nested in input group
    page = 1
    projects = []
    has_content = True
    while has_content:
        new_projects = requests.get(
                f"{base}/api/v4/groups/{group_id}/subgroups?per_page=100&page={page}",
        ).json()
        has_content = len(new_projects) > 0
        projects += new_projects
        page += 1

    return projects

""""
if __name__ == "__dev__":
    group = 'https://renkulab.io/gitlab/omnibenchmark'
    forks = get_omni_projects(group)
    """

# fetches omnibenchmark groups
groups = get_omni_groups("https://renkulab.io/gitlab/omnibenchmark") + get_omni_groups("https://renkulab.io/gitlab/omb_benchmarks")
groupnames = [p['name'] for p in groups]
blacklist = ["utils", "bettr-deployer", "metaanalysis-dashboard-v0", 
"utils-test", "omnibenchmark", "orchestrator", "omni_dashboard", "omnibench-docs", 
"omni_batch", "omni_metric", "omni_data"]
groupnames = list(set(groupnames) - set(blacklist))

# load manif and set benchmark name
with open('manifest.yaml') as inp:
  manif = yaml.load(inp)

for tpl in manif:
  try:
    tpl['variables']['benchmark_name']['enum'] = deepcopy(groupnames)
  except IndexError:
    pass


with open("manifest.yaml", 'w') as file:
    yaml.dump(manif, file)
