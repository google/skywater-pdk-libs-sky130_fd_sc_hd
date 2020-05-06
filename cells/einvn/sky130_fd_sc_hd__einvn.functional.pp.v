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


`ifndef SKY130_FD_SC_HD__EINVN_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HD__EINVN_FUNCTIONAL_PP_V

/**
 * einvn: Tri-state inverter, negative enable.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_pwrgood_pp_pg/sky130_fd_sc_hd__udp_pwrgood_pp_pg.v"

`celldefine
module sky130_fd_sc_hd__einvn (
    Z   ,
    A   ,
    TE_B,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output Z   ;
    input  A   ;
    input  TE_B;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire pwrgood_pp0_out_A  ;
    wire pwrgood_pp1_out_teb;

    //                                 Name         Output               Other arguments
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_A  , A, VPWR, VGND                         );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp1 (pwrgood_pp1_out_teb, TE_B, VPWR, VGND                      );
    notif0                             notif00     (Z                  , pwrgood_pp0_out_A, pwrgood_pp1_out_teb);

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HD__EINVN_FUNCTIONAL_PP_V