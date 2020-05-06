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
if ((!A1&!A2&!A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((!A1&!A2&A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((!A1&A2&!A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((!A1&A2&A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((A1&!A2&!A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((A1&!A2&A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((A1&A2&!A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((A1&A2&A3&!S0&!S1)) (A0 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A2&!A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A2&A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((!A0&A2&!A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((!A0&A2&A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((A0&!A2&!A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((A0&!A2&A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((A0&A2&!A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((A0&A2&A3&S0&!S1)) (A1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&!A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&A3&!S0&S1)) (A2 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&!A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&A2&S0&S1)) (A3 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&!A2&A3&S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&!A3&S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&!A3&!S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&A3&!S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&A3&S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&!A3&!S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&!A3&S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&A3&!S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&!A3&!S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&A3&!S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&A3&S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&!A3&!S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&!A3&S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&A3&!S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&A3&S1)) (S0 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&A2&!A3&S1)) (S0 -=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&!A2&A3&S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&!A3&!S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&A3&!S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&!A1&A2&A3&S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&!A2&!A3&S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&!A3&!S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&!A3&S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((!A0&A1&A2&A3&!S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&!A3&!S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&A3&!S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&!A1&!A2&A3&S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((A0&!A1&A2&A3&S0)) (S1 +=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&!A3&!S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&!A3&S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&A1&!A2&A3&!S0)) (S1 -=> X) = (0:0:0,0:0:0);
if ((A0&A1&A2&!A3&S0)) (S1 -=> X) = (0:0:0,0:0:0);
endspecify