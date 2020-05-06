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


`ifndef SKY130_FD_SC_HD__FAH_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HD__FAH_FUNCTIONAL_PP_V

/**
 * fah: Full adder.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_pwrgood_pp_pg/sky130_fd_sc_hd__udp_pwrgood_pp_pg.v"

`celldefine
module sky130_fd_sc_hd__fah (
    COUT,
    SUM ,
    A   ,
    B   ,
    CI  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output COUT;
    output SUM ;
    input  A   ;
    input  B   ;
    input  CI  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire xor0_out_SUM        ;
    wire pwrgood_pp0_out_SUM ;
    wire a_b                 ;
    wire a_ci                ;
    wire b_ci                ;
    wire or0_out_COUT        ;
    wire pwrgood_pp1_out_COUT;

    //                                 Name         Output                Other arguments
    xor                                xor0        (xor0_out_SUM        , A, B, CI                );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp0 (pwrgood_pp0_out_SUM , xor0_out_SUM, VPWR, VGND);
    buf                                buf0        (SUM                 , pwrgood_pp0_out_SUM     );
    and                                and0        (a_b                 , A, B                    );
    and                                and1        (a_ci                , A, CI                   );
    and                                and2        (b_ci                , B, CI                   );
    or                                 or0         (or0_out_COUT        , a_b, a_ci, b_ci         );
    sky130_fd_sc_hd__udp_pwrgood_pp$PG pwrgood_pp1 (pwrgood_pp1_out_COUT, or0_out_COUT, VPWR, VGND);
    buf                                buf1        (COUT                , pwrgood_pp1_out_COUT    );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HD__FAH_FUNCTIONAL_PP_V