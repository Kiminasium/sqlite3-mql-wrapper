// Copyright (c) 2019 Kimihiko Hirano
// Released under the MIT license
// Orig: https://github.com/dingmaotu/mql-sqlite3/blob/master/LICENSE
//+------------------------------------------------------------------+
//|                                                      Imports.mqh |
//|                                          Copyright 2017, Li Ding |
//|                                                dingmaotu@126.com |
//+------------------------------------------------------------------+
#property strict

#include "Common.mqh"
#include "Defines.mqh"

#import "sqlite3.dll"

intptr_t sqlite3_libversion(void);
intptr_t sqlite3_sourceid(void);
int sqlite3_libversion_number(void);

int sqlite3_config(int);
int sqlite3_config(int, int);
int sqlite3_config(int, long);
int sqlite3_config(int, int, int);
int sqlite3_threadsafe(void);
int sqlite3_enable_shared_cache(bool);
int sqlite3_extended_result_codes(intptr_t, bool onoff);
int sqlite3_enable_load_extension(intptr_t, bool onoff);
int sqlite3_load_extension(intptr_t,
                        const char &zFile[],
                        const char &zProc[],
                        intptr_t &pzErrMsg);
int sqlite3_load_extension(intptr_t,
                        const char &zFile[],
                        intptr_t zProc,
                        intptr_t &pzErrMsg);
int sqlite3_get_autocommit(intptr_t);
int sqlite3_initialize(void);
int sqlite3_shutdown(void);
int sqlite3_release_memory(int);
long sqlite3_soft_heap_limit64(long);
long sqlite3_memory_used(void);
long sqlite3_memory_highwater(bool resetFlag);
void sqlite3_free(intptr_t);
int sqlite3_open_v2(const char &filename[],
                    intptr_t &pDb,
                    int flags,
                    intptr_t zVfs);
int sqlite3_open_v2(const char &filename[],
                    intptr_t &pDb,
                    int flags,
                    const char &zVfs[]);
int sqlite3_limit(intptr_t, int id, int newVal);
int sqlite3_busy_timeout(intptr_t, int ms);
intptr_t sqlite3_db_filename(intptr_t, const char &zDbName[]);
int sqlite3_db_readonly(intptr_t, const char &zDbName[]);
int sqlite3_table_column_metadata(intptr_t,
                                const char &zDbName[],
                                const char &zTableName[],
                                const char &zColumnName[],
                                intptr_t   &pzDataType,
                                intptr_t   &pzCollSeq,
                                bool &isNotNull,
                                bool &isPrimaryKey,
                                bool &isAutoinc);
int sqlite3_status(int op, int &pCurrent, int &pHighwater, bool reset=false);
int sqlite3_status64(int op, long &pCurrent, long &pHighwater, bool reset=false);
int sqlite3_complete(const char &sql[]);
void sqlite3_interrupt(intptr_t);
int sqlite3_db_cacheflush(intptr_t);
int sqlite3_db_release_memory(intptr_t);
int sqlite3_db_status(intptr_t, int op, int &pCurrent, int &pHighwater, bool reset=false);
int sqlite3_db_config(intptr_t, int op, int, intptr_t&);
int sqlite3_db_config(intptr_t, int op, bool, intptr_t);
int sqlite3_db_config(intptr_t, int op, const uchar &dbName[]);
int sqlite3_db_config(intptr_t, int op, intptr_t, int, int);
long sqlite3_last_insert_rowid(intptr_t);
void sqlite3_set_last_insert_rowid(intptr_t, long);
int sqlite3_changes(intptr_t);
int sqlite3_total_changes(intptr_t);
int sqlite3_errcode(intptr_t);
int sqlite3_extended_errcode(intptr_t);
intptr_t sqlite3_errmsg(intptr_t);
intptr_t sqlite3_errstr(int);
int sqlite3_wal_autocheckpoint(intptr_t, int);
int sqlite3_wal_checkpoint_v2(intptr_t,
                              const char &zDb[],
                              int eMode,
                              int &pnLog,
                              int &pnCkpt);
int sqlite3_wal_checkpoint_v2(intptr_t,
                              intptr_t,
                              int eMode,
                              int &pnLog,
                              int &pnCkpt);
int sqlite3_close(intptr_t);
int sqlite3_prepare_v2(intptr_t handle,
                    const char &sql[],
                    int bytes,
                    intptr_t &pStmt,
                    intptr_t pzTail);
int sqlite3_reset(intptr_t pStmt);
int sqlite3_clear_bindings(intptr_t pStmt);
intptr_t sqlite3_db_handle(intptr_t pStmt);
intptr_t sqlite3_sql(intptr_t pStmt);
intptr_t sqlite3_expanded_sql(intptr_t pStmt);
int sqlite3_bind_parameter_count(intptr_t pStmt);
intptr_t sqlite3_bind_parameter_name(intptr_t pStmt, int);
int sqlite3_bind_parameter_index(intptr_t pStmt, const char &name[]);
int sqlite3_bind_blob(intptr_t, int, const uchar &value[], int, intptr_t);
int sqlite3_bind_blob64(intptr_t, int, const uchar &value[], ulong, intptr_t);
int sqlite3_bind_text(intptr_t, int, const char &value[], int, intptr_t);
int sqlite3_bind_text64(intptr_t, int, const char &value[], ulong, intptr_t, uchar encoding);
int sqlite3_bind_double(intptr_t, int, double);
int sqlite3_bind_int(intptr_t, int, int);
int sqlite3_bind_int64(intptr_t, int, long);
int sqlite3_bind_null(intptr_t, int);
int sqlite3_bind_zeroblob(intptr_t, int, int);
int sqlite3_bind_zeroblob64(intptr_t, int, ulong);
bool sqlite3_stmt_busy(intptr_t pStmt);
bool sqlite3_stmt_readonly(intptr_t pStmt);
int sqlite3_step(intptr_t pStmt);
int sqlite3_stmt_status(intptr_t, int op, bool resetFlg);
int sqlite3_data_count(intptr_t pStmt);
int sqlite3_column_count(intptr_t pStmt);
intptr_t sqlite3_column_name(intptr_t pStmt, int);
int sqlite3_column_type(intptr_t pStmt, int i);
int sqlite3_column_bytes(intptr_t pStmt, int i);
double sqlite3_column_double(intptr_t pStmt, int i);
int sqlite3_column_int(intptr_t pStmt, int i);
long sqlite3_column_int64(intptr_t pStmt, int i);
intptr_t sqlite3_column_text(intptr_t pStmt, int i);
intptr_t sqlite3_column_blob(intptr_t pStmt, int i);
intptr_t sqlite3_column_decltype(intptr_t pStmt, int);
intptr_t sqlite3_column_database_name(intptr_t, int);
intptr_t sqlite3_column_table_name(intptr_t, int);
intptr_t sqlite3_column_origin_name(intptr_t, int);
int sqlite3_finalize(intptr_t pStmt);
int sqlite3_blob_open(intptr_t,
                    const char &zDb[],
                    const char &zTable[],
                    const char &zColumn[],
                    long row,
                    int flags,
                    intptr_t &pBlob);
int sqlite3_blob_reopen(intptr_t, long row);
int sqlite3_blob_bytes(intptr_t);
int sqlite3_blob_read(intptr_t, uchar &buf[], int n, int offset);
int sqlite3_blob_write(intptr_t, const uchar &buf[], int n, int offset);
int sqlite3_blob_close(intptr_t);
intptr_t sqlite3_backup_init(intptr_t pDest,
                            const char &zDestName[],
                            intptr_t pSource,
                            const char &zSourceName[]);
int sqlite3_backup_step(intptr_t, int page);
int sqlite3_backup_finish(intptr_t);
int sqlite3_backup_remaining(intptr_t);
int sqlite3_backup_pagecount(intptr_t);
intptr_t sqlite3_vfs_find(const char &zVfsName[]);
intptr_t sqlite3_vfs_find(intptr_t);
int sqlite3_vfs_register(intptr_t, bool);
int sqlite3_vfs_unregister(intptr_t);
#import

int sqlite3_open(const string &filename, intptr_t &handle, int flags, string vfs = "") {

    uchar u8filename[];
    StringToUtf8(filename, u8filename);
    int res = 0;
    if(vfs == "") {
        res = sqlite3_open_v2(u8filename, handle, flags, 0);
    } else {
        uchar u8vfs[];
        StringToUtf8(vfs, u8vfs);
        res = sqlite3_open_v2(u8filename, handle, flags, u8vfs);
    }
    return res;
}

int sqlite3_prepare(const intptr_t handle, const string &sql, intptr_t &stmt) {

   uchar u8sql[];
   StringToUtf8(sql, u8sql);
   int res = sqlite3_prepare_v2(handle, u8sql, ArraySize(u8sql), stmt, 0);

   return res;
}