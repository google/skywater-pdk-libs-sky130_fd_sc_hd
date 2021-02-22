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

import os
import subprocess
import sys
import time

libraries = {
    "sky130_fd_pr": 'SKY130 Primitive Models and Cells',
    "sky130_fd_io": 'IO and periphery cells provided by the SkyWater foundry.',

    #
    "sky130_fd_sc_hd":   'SKY130 High Density Digital Standard Cells (SkyWater Provided)',
    "sky130_fd_sc_hdll": 'SKY130 High Density Low Leakage Digital Standard Cells (SkyWater Provided)',
    #
    "sky130_fd_sc_hs":   'SKY130 High Speed Digital Standard Cells (SkyWater Provided)',
    "sky130_fd_sc_ms":   'SKY130 Medium Speed Digital Standard Cells (SkyWater Provided)',
    "sky130_fd_sc_ls":   'SKY130 Low Speed Digital Standard Cells (SkyWater Provided)',
    #
    "sky130_fd_sc_hvl":  'SKY130 High Voltage Digital Standard Cells (SkyWater Provided)',
    "sky130_fd_sc_lp":   'SKY130 Low Power Digital Standard Cells (SkyWater Provided)',
}


def run(cmd, **kw):
    sys.stdout.flush()
    sys.stderr.flush()
    print(cmd, '-'*5, flush=True)
    subprocess.check_call(cmd, shell=True, stderr=subprocess.STDOUT, **kw)
    print('-'*5, flush=True)
    sys.stdout.flush()
    sys.stderr.flush()


DATE = None # 'Mon Oct 06 16:55:02 2020 -0700'

def git(cmd, gitdir, can_fail=False, **kw):
    env = dict(os.environ)
    if DATE:
        env['GIT_AUTHOR_DATE'] = DATE
        env['GIT_COMMITTER_DATE'] = DATE
    env['GIT_COMMITTER_NAME'] = "GitHub Actions Bot"
    env['GIT_COMMITTER_EMAIL'] = 'actions_bot@github.com'

    if 'push' in cmd:
        cmd += ' --verbose --progress'

    i = 0
    while True:
        try:
            run('git '+cmd, cwd=gitdir, env=env, **kw)
            break
        except subprocess.CalledProcessError as e:
            if can_fail:
                return False
            i += 1
            if i < 5:
                time.sleep(10)
                continue
            raise


def out_v(v, versions):
    if (0,0,0) in versions:
        return (v[0],v[1],v[2]+1)
    return v


def previous_v(v, versions):
    assert v in versions, (v, versions)
    vers = [(0,0,0)]+[out_v(x, versions) for x in list(versions)]
    ov = out_v(v, versions)
    assert ov in vers, (ov, vers)
    i = vers.index(ov)
    assert i > 0, (i, ov, vers)
    return vers[i-1]
