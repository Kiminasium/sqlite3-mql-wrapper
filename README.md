# sqlite3-mql-wrapper

SQLite3 binding for the MQL language (both 32bit MT4 and 64bit MT5)

The library is for the Latest 2020 MT4 and MT5 users who are using:

- https://github.com/Shmuma/sqlite3-mt4-wrapper
    * Only for 32bit DLL and 6 years ago. It dosen't work on MT5.
- https://github.com/dingmaotu/mql-sqlite3
    * Unfamiliar to sqlite3-mt4-wrapper users. Sometimes didn't work properly.

## Introduction

This is a complete binding of the [SQLite3](http://sqlite.org/) library
(latest version 33001000) for the MQL4/5 language used by MetaTrader4/5.

## How To

### Getting DLL

1. Download Windows DLL from https://sqlite.org/download.html such as:
    - sqlite-dll-win32-x86-3300100.zip (32bit for MT4)
    - sqlite-dll-win64-x64-3300100.zip (64bit for MT5)
2. Extract and place "sqlite3.dll" in your MT4/MT5 "Library" folder.

### Getting Source code

1. Download the source code from https://github.com/kiminasium/sqlite3-mql.git
2. Place "SQL" folder in your MT4/MT5 "Include" folder.

## Example

### experts/SQLiteTest.mq5

```MQL5
#include <SQL/SQL.mqh>

SQL sql_;

/**
* @OnInit
*/
int OnInit()
{
    // Print version
    Print(SQL::get_version_number());
    Print(SQL::get_version());
    Print(SQL::get_sourceid());

#ifdef __MQL5__
   string fpath = TerminalInfoString(TERMINAL_DATA_PATH) + "\\MQL5\\Files\\SQLite\\";
#else
   string fpath = TerminalInfoString(TERMINAL_DATA_PATH) + "\\MQL4\\Files\\SQLite\\";
#endif

    // Initialize DB
    if (!sql_.initialize(fpath + "test.db")) {
        return INIT_FAILED;
    }

    // Drop table if exists
    if (sql_.sqlite_table_exists("test")) {
        string query = "drop table test";

        if (!sql_.sqlite_exec(query)) {
            return INIT_FAILED;
        }
    }

    // Create table
    string query = "create table test (a int, b text)";
    if (!sql_.sqlite_exec(query)) {
        return INIT_FAILED;
    }

    // Insert Data 1
    query = "insert into test values (12345, 'ABCDE')";
    if (!sql_.sqlite_exec(query)) {
        return INIT_FAILED;
    }

    // Insert Data 2
    query = "insert into test values (67891, 'FGHIJ')";
    if (!sql_.sqlite_exec(query)) {
        return INIT_FAILED;
    }

    // Select Data
    query = "select a, b from test";
    void* handle = sql_.sqlite_query(query);

    if (handle == NULL) {
        return INIT_FAILED;
    }

    // Search next row
    while (sql_.sqlite_next_row(handle)) {
        Print("cols = ", sql_.sqlite_get_col_count(handle));

        int a = sql_.sqlite_get_col_int(handle, 0);
        Print("a = ", a);

        string b = sql_.sqlite_get_col_string(handle, 1);
        Print("b = ", b);
    }
    // Call the free function after sqlite_query()
    sql_.sqlite_free_query(handle);

    // Update Data
    query = "update test set a = 77777, b = 'XXXXX' where a = 67891";
    if (!sql_.sqlite_exec(query)) {
        return INIT_FAILED;
    }

    query = "select a, b from test";
    handle = sql_.sqlite_query(query);

    if (handle == NULL) {
        return INIT_FAILED;
    }

    while (sql_.sqlite_next_row(handle)) {
        Print("cols = ", sql_.sqlite_get_col_count(handle));

        int a = sql_.sqlite_get_col_int(handle, 0);
        Print("a = ", a);

        string b = sql_.sqlite_get_col_string(handle, 1);
        Print("b = ", b);
    }
    sql_.sqlite_free_query(handle);

    // Finalize
    sql_.finalize();
    return 0;
}
//------------------------------------------------------------------------------
```
### Results

2020.01.15 22:29:23.842	SQLiteTest (USDJPY,M5)	3030001  
2020.01.15 22:29:23.843	SQLiteTest (USDJPY,M5)	3.30.1  
2020.01.15 22:29:23.843	SQLiteTest (USDJPY,M5)	2019-10-10 20:19:45  18db032d058f1436ce3dea84081f4ee5a0f2259ad97301d43c426bc7f3df1b0b  
2020.01.15 22:29:23.880	SQLiteTest (USDJPY,M5)	cols = 2  
2020.01.15 22:29:23.880	SQLiteTest (USDJPY,M5)	a = 12345  
2020.01.15 22:29:23.880	SQLiteTest (USDJPY,M5)	b = ABCDE  
2020.01.15 22:29:23.880	SQLiteTest (USDJPY,M5)	cols = 2  
2020.01.15 22:29:23.880	SQLiteTest (USDJPY,M5)	a = 67891  
2020.01.15 22:29:23.880	SQLiteTest (USDJPY,M5)	b = FGHIJ  
2020.01.15 22:29:23.890	SQLiteTest (USDJPY,M5)	cols = 2  
2020.01.15 22:29:23.890	SQLiteTest (USDJPY,M5)	a = 12345  
2020.01.15 22:29:23.890	SQLiteTest (USDJPY,M5)	b = ABCDE  
2020.01.15 22:29:23.890	SQLiteTest (USDJPY,M5)	cols = 2  
2020.01.15 22:29:23.890	SQLiteTest (USDJPY,M5)	a = 77777  
2020.01.15 22:29:23.890	SQLiteTest (USDJPY,M5)	b = XXXXX  

## Note

- Just tested only the Example APIs. I'm not sure if other APIs work.
- Easily use and test SQLite3 wrapper APIs, so check for yourself and add functions to "SQL.mqh".
