// Copyright (c) 2019 Kimihiko Hirano
// Released under the MIT license
// Orig: https://github.com/dingmaotu/mql-sqlite3/blob/master/LICENSE
//+------------------------------------------------------------------+
//|                                                       Backup.mqh |
//|                                          Copyright 2017, Li Ding |
//|                                                dingmaotu@126.com |
//+------------------------------------------------------------------+
#property strict

#include "SQLite3.mqh"

class Backup {

private:

   intptr_t m_ref;

public:

    Backup(const SQLite3 &dest, string destDbName,
        const SQLite3 &src, string srcDbName)
    {
        uchar destDbNameBuf[];
        uchar srcDbNameBuf[];
        StringToUtf8(destDbName, destDbNameBuf);
        StringToUtf8(srcDbName, srcDbNameBuf);
        m_ref = sqlite3_backup_init(dest.ref(),
                                destDbNameBuf, src.ref(), srcDbNameBuf);
    }
    ~Backup() {sqlite3_backup_finish(m_ref);}

    bool isValid() const {return m_ref != NULL;}
    intptr_t ref() const {return m_ref;}

    int step(int pages) {return sqlite3_backup_step(m_ref, pages);}
    int getPageCount() const {return sqlite3_backup_pagecount(m_ref);}
    int getRemaining() const {return sqlite3_backup_remaining(m_ref);}
};