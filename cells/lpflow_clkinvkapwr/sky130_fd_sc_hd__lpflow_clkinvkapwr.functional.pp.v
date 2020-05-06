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


`ifndef SKY130_FD_SC_HD__LPFLOW_CLKINVKAPWR_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HD__LPFLOW_CLKINVKAPWR_FUNCTIONAL_PP_V

/**
 * lpflow_clkinvkapwr: Clock tree inverter on keep-alive rail.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_pwrgood_l_pp_pg/sky130_fd_sc_hd__udp_pwrgood_l_pp_pg.v"

`celldefine
module sky130_fd_sc_hd__lpflow_clkinvkapwr (
    Y    ,
    A    ,
    KAPWR,
    VPWR ,
    VGND ,
    VPB  ,
    VNB
);

    // Module ports
    output Y    ;
    input  A    ;
    input  KAPWR;
    input  VPWR ;
    input  VGND ;
    input  VPB  ;
    input  VNB  ;

    // Local signals
    wire not0_out_Y    ;
    wire pwrgood0_out_Y;

    //                                   Name      Output          Other arguments
    not                                  not0     (not0_out_Y    , A                      );
    sky130_fd_sc_hd__udp_pwrgood$l_pp$PG pwrgood0 (pwrgood0_out_Y, not0_out_Y, KAPWR, VGND);
    buf                                  buf0     (Y             , pwrgood0_out_Y         );

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HD__LPFLOW_CLKINVKAPWR_FUNCTIONAL_PP_V