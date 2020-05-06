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


`ifndef SKY130_FD_SC_HD__CONB_FUNCTIONAL_PP_V
`define SKY130_FD_SC_HD__CONB_FUNCTIONAL_PP_V

/**
 * conb: Constant value, low, high outputs.
 *
 * Verilog simulation functional model.
 */

`timescale 1ns / 1ps
`default_nettype none

// Import user defined primitives.
`include "../../models/udp_pwrgood_pp_g/sky130_fd_sc_hd__udp_pwrgood_pp_g.v"
`include "../../models/udp_pwrgood_pp_p/sky130_fd_sc_hd__udp_pwrgood_pp_p.v"

`celldefine
module sky130_fd_sc_hd__conb (
    HI  ,
    LO  ,
    VPWR,
    VGND,
    VPB ,
    VNB
);

    // Module ports
    output HI  ;
    output LO  ;
    input  VPWR;
    input  VGND;
    input  VPB ;
    input  VNB ;

    // Local signals
    wire pullup0_out_HI  ;
    wire pulldown0_out_LO;

    //                                Name         Output            Other arguments
    pullup                            pullup0     (pullup0_out_HI  );
    sky130_fd_sc_hd__udp_pwrgood_pp$P pwrgood_pp0 (HI              , pullup0_out_HI, VPWR  );
    pulldown                          pulldown0   (pulldown0_out_LO);
    sky130_fd_sc_hd__udp_pwrgood_pp$G pwrgood_pp1 (LO              , pulldown0_out_LO, VGND);

endmodule
`endcelldefine

`default_nettype wire
`endif  // SKY130_FD_SC_HD__CONB_FUNCTIONAL_PP_V