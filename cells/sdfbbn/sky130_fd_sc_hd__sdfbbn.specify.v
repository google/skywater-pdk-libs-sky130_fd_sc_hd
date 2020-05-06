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

specify
( negedge RESET_B => ( Q +: RESET_B ) ) = 0:0:0 ;   // delay is tfall
( negedge RESET_B => ( Q_N -: RESET_B ) ) = 0:0:0 ;  // delay is tris
( SET_B => ( Q -: SET_B ) ) = ( 0:0:0 , 0:0:0 ) ;       // delay is tris , tfall
( SET_B => ( Q_N +: SET_B ) ) = ( 0:0:0 , 0:0:0 ) ;      // delay is tris , tfall
( negedge CLK_N => ( Q +: D ) ) = ( 0:0:0 , 0:0:0 ) ;  // delays are tris , tfall
( negedge CLK_N => ( Q_N -: D ) ) = ( 0:0:0 , 0:0:0 ) ; // delays are tris , tfall
$recrem ( posedge SET_B , negedge CLK_N , 0:0:0 , 0:0:0 , notifier , COND0 , COND0 , SETB_delayed , CLKN_delayed ) ;
$recrem ( posedge RESET_B , negedge CLK_N , 0:0:0 , 0:0:0 , notifier , COND1 , COND1 , RESETB_delayed , CLKN_delayed ) ;
$setuphold ( negedge CLK_N , posedge D , 0:0:0 , 0:0:0 , notifier , COND_D , COND_D , CLKN_delayed , D_delayed ) ;
$setuphold ( negedge CLK_N , negedge D , 0:0:0 , 0:0:0 , notifier , COND_D , COND_D , CLKN_delayed , D_delayed ) ;
$setuphold ( negedge CLK_N , posedge SCD , 0:0:0 , 0:0:0 , notifier , COND_SCD , COND_SCD , CLKN_delayed , SCD_delayed ) ;
$setuphold ( negedge CLK_N , negedge SCD , 0:0:0 , 0:0:0 , notifier , COND_SCD , COND_SCD , CLKN_delayed , SCD_delayed ) ;
$setuphold ( negedge CLK_N , posedge SCE , 0:0:0 , 0:0:0 , notifier , COND_SCE , COND_SCE , CLKN_delayed , SCE_delayed ) ;
$setuphold ( negedge CLK_N , negedge SCE , 0:0:0 , 0:0:0 , notifier , COND_SCE , COND_SCE , CLKN_delayed , SCE_delayed ) ;
$setuphold ( posedge SET_B , posedge RESET_B , 0:0:0 , 0:0:0 , notifier , AWAKE , AWAKE , SETB_delayed , RESETB_delayed  ) ;
$setuphold ( posedge RESET_B , posedge SET_B , 0:0:0 , 0:0:0 , notifier , AWAKE , AWAKE , RESETB_delayed  , SETB_delayed ) ;
$width ( negedge CLK_N &&& CONDB , 1.0:1.0:1.0 , 0 , notifier ) ;
$width ( posedge CLK_N &&& CONDB , 1.0:1.0:1.0 , 0 , notifier ) ;
$width ( negedge SET_B &&& AWAKE , 1.0:1.0:1.0 , 0 , notifier ) ;
$width ( negedge RESET_B &&& AWAKE , 1.0:1.0:1.0 , 0 , notifier ) ;
endspecify