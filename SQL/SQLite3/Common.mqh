// Copyright (c) 2019 Kimihiko Hirano
// Released under the MIT license
// Orig: https://github.com/dingmaotu/mql-sqlite3/blob/master/LICENSE
//+------------------------------------------------------------------+
//|                                                       Common.mqh |
//|                                          Copyright 2017, Li Ding |
//|                                                dingmaotu@126.com |
//+------------------------------------------------------------------+
#property strict

#ifdef __MQL5__
#define __X64__
#endif

#ifdef __X64__
#define intptr_t long
#define uintptr_t ulong
#define size_t long
#else
#define intptr_t int
#define uintptr_t uint
#define size_t int
#endif

#import "kernel32.dll"
void RtlMoveMemory(intptr_t dest, const uchar &array[], size_t length);
void RtlMoveMemory(uchar &array[], intptr_t src, size_t length);
int lstrlen(intptr_t psz);
int MultiByteToWideChar(uint codePage, uint flags,
                                const intptr_t multiByteString,
                                int lengthMultiByte, string &str, int length);
#import

void ArrayFromPointer(uchar &array[], intptr_t src, int count = WHOLE_ARRAY) {
    int size = (count == WHOLE_ARRAY) ? ArraySize(array) : count;
    RtlMoveMemory(array, src, (size_t)size);
}

void ArrayToPointer(const uchar &array[], intptr_t dest, int count = WHOLE_ARRAY) {
    int size = (count == WHOLE_ARRAY)? ArraySize(array) : count;
    RtlMoveMemory(dest, array, (size_t)size);
}

string StringFromUtf8Pointer(intptr_t psz, int len) {

    if(len < 0) return NULL;

    string res;
    int required = MultiByteToWideChar(CP_UTF8, 0, psz, len, res, 0);
    StringInit(res, required + 1);

    int resLength = MultiByteToWideChar(CP_UTF8, 0, psz, len, res, required);
    if(resLength != required) {
        return NULL;
    } else {
        return res;
    }
}

string StringFromUtf8Pointer(intptr_t psz) {

    if(psz == 0) return NULL;
    int len = lstrlen(psz);
    if(len == 0) return NULL;
    return StringFromUtf8Pointer(psz, len);
}

string StringFromUtf8(const uchar &utf8[]) {
    return CharArrayToString(utf8, 0, -1, CP_UTF8);
}

void StringToUtf8(const string str, uchar &utf8[], bool ending = true) {

    if(!ending && str == "") return;
    int count = ending ? -1 : StringLen(str);
    StringToCharArray(str, utf8, 0, count, CP_UTF8);
}
