#!/usr/bin/env python3
# Copyright 2020 SkyWater PDK Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

# Originally written by Tim 'mithro' Ansell
# Slightly modified for Github Actions use by Ahmed Ghazy (ax3ghazy) & Amr Gouhar (agorararmard)

import datetime
import os
import pprint
import shutil
import subprocess
import sys
import tempfile
import time

from library_submodules import *


__dir__ = os.path.dirname(__file__)


def header(l, s, *args, **kw):
    s1 = s.format(*args, **kw)
    s2 = l*len(s1)
    return '{}\n{}\n'.format(s1, s2)



def main(args):
    assert len(args) == 1

    patchfile = os.path.abspath(args.pop(0))

    assert os.path.exists(patchfile), patchfile
    assert os.path.isfile(patchfile), patchfile

    print()
    print()

    git_root = subprocess.check_output('git rev-parse --show-toplevel', shell=True)
    git_root = git_root.decode('utf-8').strip()

    print()

    print()

    git('fetch origin', git_root)

    git('fetch origin --tags', git_root)

    git('status', git_root)

    print('-'*20, flush=True)

    tags = subprocess.check_output('git tag -l', shell=True, cwd=git_root)

    tags = tags.decode('utf-8')

    versions = [tuple(int(i) for i in v[1:].split('.')) for v in tags.split()]
    if (0,0,0) in versions:
        versions.remove((0,0,0))
    apply_idx=0
    for i, v in enumerate(versions):
        pv = previous_v(v, versions)
        ov = out_v(v, versions)

        v_branch = "branch-{}.{}.{}".format(*ov)
        v_tag = "v{}.{}.{}".format(*ov)

        print()
        print("Was:", pv, "Now patching", (v_branch, v_tag), "with", patchfile)
        print('-'*20, flush=True)

        # Get us back to a very clean tree.
        # git('reset --hard HEAD', git_root)
        git('clean -f', git_root)
        git('clean -x -f', git_root)

        # Checkout the right branch
        git('checkout {0}'.format(v_branch), git_root)
        if v in [(0,0,9)]:
            continue
        elif v in [(0, 10, 0), (0, 10, 1), (0, 11, 0), (0, 12, 0), (0, 12, 1), (0, 13, 0)]:
            npatchfile = patchfile.replace('-2', '-1')
        else:
            npatchfile = patchfile

        diff_pos = 'branch-{}.{}.{}'.format(*pv)

        # Update the contents
        if v == versions[apply_idx]:
            if git('am {}'.format(patchfile), git_root, can_fail=True) == False:
                apply_idx+=1
            continue

        # Create the merge commit
        git('merge {} --no-ff --no-commit --strategy=recursive'.format(diff_pos), git_root)
        git('commit -C HEAD@{1}', git_root)

    git('branch -D master', git_root, can_fail=True)
    git('branch master', git_root)

    print('='*75, flush=True)



if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
