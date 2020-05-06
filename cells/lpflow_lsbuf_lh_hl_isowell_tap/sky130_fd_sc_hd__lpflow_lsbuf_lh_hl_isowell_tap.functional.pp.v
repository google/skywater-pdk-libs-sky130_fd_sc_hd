/*
 * Copyright 2020 The SkyWater PDK Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
*/


`ifndef SKY130_FD_SC_HD__LPFLOW_LSBUF_LH_HL_ISOWELL_TAP_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HD__LPFLOW_LSBUF_LH_HL_ISOWELL_TAP_FUNCTIONAL_PP_V

/**
 * lpflow_lsbuf_lh_hl_isowell_tap: Level-shift buffer, low-to-high,
 *                                 isolated well on input buffer,
 *                                 vpb/vnb taps, double-row-height
 *                                 cell.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_pwrgood_l_pp_pg/sky130_fd_sc_hd__udp_pwrgood_l_pp_pg.v"

`celldefine
module sky130_fd_sc_hd__lpflow_lsbuf_lh_hl_isowell_tap (
    X     ,
    A     ,
    VPWRIN,
    VPWR  ,
    VGND  ,
    VPB
);

    // Module ports
    output X     ;
    input  A     ;
    input  VPWRIN;
    input  VPWR  ;
    input  VGND  ;
    input  VPB   ;

    // Local signals
    wire pwrgood0_out_A;
    wire buf0_out_X    ;

    //                                   Name      Output          Other arguments
    sky130_fd_sc_hd__udp_pwrgood$l_pp$PG pwrgood0 (pwrgood0_out_A, A, VPWRIN, VGND       );
    buf                                  buf0     (buf0_out_X    , pwrgood0_out_A        );
    sky130_fd_sc_hd__udp_pwrgood$l_pp$PG pwrgood1 (X             , buf0_out_X, VPWR, VGND);

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HD__LPFLOW_LSBUF_LH_HL_ISOWELL_TAP_FUNCTIONAL_PP_V