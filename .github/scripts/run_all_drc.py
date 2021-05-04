#!/usr/bin/env python3
# Copyright 2020 Efabless Corporation
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
#-------------------------------------------------------------------------
# run_all_drc.py --- A script that will run run_standard_drc
# for all .gds files under the cells/ folder. Must be run from repository
# root. Author: Mohamed Gaber
# 
# Usage:
#
#   run_all_drc.py [optional subdirectory filter]
#
# Results:
#
#   Prints a report to standard output.
# 	
#-------------------------------------------------------------------------

import os
import re
import sys
import subprocess
import concurrent.futures as fut

ACCEPTABLE_ERRORS = [
    "All nwells must contain metal-connected N+ taps (nwell.4)",
    "P-diff distance to N-tap must be < 15.0um (LU.3)",
    "N-diff distance to P-tap must be < 15.0um (LU.2)",
]

KNOWN_BAD = [
    "sky130_fd_sc_hd__tapvgnd_1",
    "sky130_fd_sc_hd__clkdlybuf4s15_1",
    "sky130_fd_sc_hd__buf_16",
    "sky130_fd_sc_hd__a2111oi_0",
    "sky130_fd_sc_hd__tapvgnd2_1",
    "sky130_fd_sc_hd__clkdlybuf4s18_1",
    "sky130_fd_sc_hd__probe_p_8"
]

def parse_drc_report(report):    
    components = list(map(lambda x: x.split("\n"), report.split("\n\n")))
    
    header = components[0]
    cell_name = header[0][28:]

    errors = []
    for error in components[1:]:
        error_name = error[0]
        if error_name in ACCEPTABLE_ERRORS:
            continue
        errors.append(error)
    
    return errors

def drc_gds(path):
    cell_name = os.path.basename(path)[:-4]

    res = subprocess.run([
        "python3",
        "./.github/scripts/run_standard_drc.py",
        path
    ], env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    
    report_path = path[:-4] + "_drc.txt"
    try:
        report = open(report_path).read()

        return cell_name, parse_drc_report(report)
    except FileNotFoundError:
        return cell_name, [["Magic did not produce a report.", res.stdout.decode("utf8"), res.stderr.decode("utf8")]]

if len(sys.argv) > 2:
    print("Usage: %s [optional: directory filter regex]" % sys.argv[0])
    exit(64)

directory_filter = "."
if len(sys.argv) == 2:
    directory_filter = sys.argv[1]

print("Testing cells in directories matching /%s/…" % directory_filter)

nproc = os.cpu_count()
with fut.ThreadPoolExecutor(max_workers=nproc) as executor:
    futures = []

    cells_dir = "./cells"
    cells = os.listdir(cells_dir)

    env = os.environ.copy()
    env["PDKPATH"] = "%s/.github/pdk_subset" % os.getenv("PWD")

    print("Submitting futures…")
    for cell in cells:
        if not re.match(directory_filter, cell):
            print("Skipping directory %s…" % cell)
            continue

        cell_dir = os.path.join(cells_dir, cell)

        gds_list = list(filter(lambda x: x.endswith(".gds"), os.listdir(cell_dir)))


        for gds_name in gds_list:
            gds_path = os.path.join(cell_dir, gds_name)

            futures.append(executor.submit(drc_gds, gds_path))

    print("Claiming futures…")
    successes = 0
    total = 0
    exit_code = 0
    for future in futures:
        total += 1
        cell_name, errors = future.result()
        symbol = "❌"
        message = "ERROR"
        if len(errors) == 0:
            successes += 1
            symbol = "⭕️"
            message = "CLEAN"
        print("%-64s %s %s" % (cell_name, symbol, message))
        if len(errors) != 0:
            if not cell_name in KNOWN_BAD:
                exit_code = 1
            for error in errors:
                print("* %s" % error[0])
                for line in error[1:]:
                    print("  %s" % line)
    
    success_rate = (successes / total * 100)
    print("%i/%i successes (%f%%)" % (successes, total, success_rate))

    exit(exit_code)