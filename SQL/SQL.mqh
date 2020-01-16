// Copyright (c) 2019 Kimihiko Hirano
// Released under the MIT license
#property copyright "Copyright 2019,Kimihiko Hirano"
#property link      ""
#property version   "1.00"
#property strict

#include <Trader/SQL/SQLite3/Statement.mqh>

/** @class SQL
*   @brief SQL Class
*/
class SQL {

private:

    SQLite3* db_;
    Statement* handle_;

public:

    static int get_version_number() {return SQLite3::getVersionNumber();};
    static string get_version() {return SQLite3::getVersion();};
    static string get_sourceid() {return SQLite3::getSourceId();};

     SQL(): db_(NULL), handle_(NULL) {};
    ~SQL() {};

    bool initialize(string dbPath);
    void finalize();

    bool sqlite_exec(string query);
    void* sqlite_query(string query);
    bool sqlite_next_row(void* handle);
    int sqlite_get_col_int(void* handle, int col);
    double sqlite_get_col_double(void* handle, int col);
    string sqlite_get_col_string(void* handle, int col);
    void sqlite_free_query(void* handle);
    bool sqlite_table_exists(string table_name);
    int sqlite_get_col_count(void* handle);
};

/**
 * @initialize
 */
bool SQL::initialize(string dbPath) {

    SQLite3::initialize();
    db_ = new SQLite3(dbPath, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE);

    if(!db_.isValid()) {
        return false;
    }
    return true;
}

/**
 * @shutdown
 */
void SQL::finalize() {
    if (db_ != NULL) {
        delete db_;
    }
    SQLite3::shutdown();
}

/**
 * @sqlite_exec
 */
bool SQL::sqlite_exec(string query) {

    bool bRet = false;
    string sql = query + ";";

    if(!Statement::isComplete(sql)) {
        Print("Query incompleted : ", sql);
        return bRet;
    }

    Statement s(db_, sql);

    if(!s.isValid()) {
        Print("Query invalid : ", sql);
        return bRet;
    }

    int r = s.step();

    if (r == SQLITE_DONE || r == SQLITE_OK) {
        bRet = true;
    } else {
        Print("Query not ok : ", r);   
    }
    return bRet;
}

/**
 * @sqlite_query
 */
void* SQL::sqlite_query(string query) {

    string sql = query + ";";

    if(!Statement::isComplete(sql)) {
        Print("Query incompleted : ", sql);
        return NULL;
    }

    if (handle_ == NULL) {
        handle_ = new Statement(db_, sql);
    }

    if(!handle_.isValid()) {
        Print("Query invalid : ", sql);
        delete handle_;
        handle_ = NULL;
    }
    return handle_;
}

/**
 * @sqlite_next_row
 */
bool SQL::sqlite_next_row(void* handle) {
    
    bool bRet = false;
    if (handle == NULL) return bRet;

    if (handle_.step() == SQLITE_ROW) {
        bRet = true;
    }
    return bRet;
}

/**
 * @sqlite_get_col_int
 */
int SQL::sqlite_get_col_int(void* handle, int col) {

    int value = 0;
    if (handle == NULL) return value;
    
    int cols = ((Statement *)handle).getColumnCount();

    for (int i = 0; i < cols; i++) {
        if (i == col) {
            ((Statement *)handle).getColumn(i, value);
            break;
        }
    }
    return value;
}

/**
 * @sqlite_get_col_double
 */
double SQL::sqlite_get_col_double(void* handle, int col) {

    double value = 0;
    if (handle == NULL) return value;

    int cols = ((Statement *)handle).getColumnCount();

    for (int i = 0; i < cols; i++) {
        if (i == col) {
            ((Statement *)handle).getColumn(i, value);
            break;
        }
    }
    return value;
}

/**
 * @sqlite_get_col_string
 */
string SQL::sqlite_get_col_string(void* handle, int col) {

    string value = NULL;
    if (handle == NULL) return value;

    int cols = ((Statement *)handle).getColumnCount();

    for (int i = 0; i < cols; i++) {
        if (i == col) {
            ((Statement *)handle).getColumn(i, value);
            break;
        }
    }
    return value;
}

/**
 * @sqlite_free_query
 */
void SQL::sqlite_free_query(void* handle) {

    if (handle != NULL && handle == handle_) {
        delete handle_;
        handle_ = NULL;
    }
}

/**
 * @sqlite_table_exists
 */
bool SQL::sqlite_table_exists(string table_name) {

    bool bRet = false;
    string query =
        "select count(*) from sqlite_master where type = 'table' and name = '"
            + table_name + "';";

    if(!Statement::isComplete(query)) {
        return bRet;
    }

    Statement s(db_, query);

    if(!s.isValid()) {
        return bRet;
    }

    if (s.step() == SQLITE_ROW) {
        if (sqlite_get_col_int(&s, 0) > 0) {
            bRet = true;
        }
    }
    return bRet;
}

/**
 * @sqlite_get_col_count
 */
int SQL::sqlite_get_col_count(void* handle) {

    if (handle == NULL) return 0;
    return ((Statement *)handle).getColumnCount();
}
//------------------------------------------------------------------------------