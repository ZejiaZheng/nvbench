/*
 *  Copyright 2021 NVIDIA Corporation
 *
 *  Licensed under the Apache License, Version 2.0 with the LLVM exception
 *  (the "License"); you may not use this file except in compliance with
 *  the License.
 *
 *  You may obtain a copy of the License at
 *
 *      http://llvm.org/foundation/relicensing/LICENSE.txt
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#pragma once

// Defined if NVBench has been built with NVML support.
#define NVBENCH_HAS_NVML

// Defined if NVBench has been built with CUPTI support.
#define NVBENCH_HAS_CUPTI

#ifdef _MSC_VER
#define NVBENCH_MSVC_PUSH_DISABLE_WARNING(code)                                                    \
  __pragma(warning(push)) __pragma(warning(disable : code))
#define NVBENCH_MSVC_POP_WARNING() __pragma(warning(pop))
#else
#define NVBENCH_MSVC_PUSH_DISABLE_WARNING(code)
#define NVBENCH_MSVC_POP_WARNING()
#endif

// MSVC does not define __cplusplus correctly. _MSVC_LANG is used instead.
#ifdef _MSVC_LANG
#define NVBENCH_CPLUSPLUS _MSVC_LANG
#else
#define NVBENCH_CPLUSPLUS __cplusplus
#endif

// Detect current dialect:
#if NVBENCH_CPLUSPLUS < 201703L
#error "NVBench requires a C++17 compiler."
#elif NVBENCH_CPLUSPLUS < 202002L
#define NVBENCH_CPP_DIALECT 2017
#elif NVBENCH_CPLUSPLUS == 202002L
#define NVBENCH_CPP_DIALECT 2020
#elif NVBENCH_CPLUSPLUS > 202002L // unknown, but is higher than C++20.
#define NVBENCH_CPP_DIALECT 2023
#endif
