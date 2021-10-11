Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C1DC4332F
	for <webhook@archiver.kernel.org>; Mon, 11 Oct 2021 09:59:01 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.9863.1633946339681143682
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Oct 2021 02:59:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bevNcFvL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id e12so54294818wra.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Oct 2021 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PiDeeRnbY9PNQ7O0c5iOXNvu+ezOPZiqctIRy2P1Isc=;
        b=bevNcFvLC28QN/VtqTlepG0nOml41y1BFg1ijGJUOvbQMTjVBKXHgFSjYFbMz3NRWr
         M7H6Aj0PFOedGn5fqTMTSb2LioLLMwhtCKkUSKhRc5CBlQUuAz3dA8ZdKO1O8EC4sAzp
         vZIS425dVLjaEtjknMbNY9xeAhpoiWMzYppig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PiDeeRnbY9PNQ7O0c5iOXNvu+ezOPZiqctIRy2P1Isc=;
        b=zGP61AGGTlsEkj/FS1qW44yuvQjGo7TBD0Czy8U59NT0w4VPcvVi1QnC6EktgFkM1j
         dtyV9FsSX4xmNkPwSoEN72LGyAP3wrqDgxAEoWpCNBF41AsDxk63kbXKUNoPSiDmRV5U
         8Q2KjLmiNtspT7nnVwU2MarhsJXnGVgxHEU+u/FB/kL4QNUuRtUWxjiJB+YQXLUYGVsJ
         bvnGqZU6+ke/jsE2GCdsImz44LqBXyp0ASpXGT6SsCpBzLYswV+N34ajWqDfRZ+3fYfp
         J6bmIB1adlf582elgivTZk4rCe0HBoL21B/6iCoiWx1wBGNDUe5LJFYwVNOqqJuGbwoj
         ouEw==
X-Gm-Message-State: AOAM530Q54/Ak3KCbt7lPM4lJEV+Ma4RI9kP0Y6j9a/7DcEfHNEEkODF
	kxmWNwVa9miURUQhP5PO3geYBHHSYoMjPw==
X-Google-Smtp-Source: 
 ABdhPJwkf/MLbJsd5DIbmiVLIM6O43+LV/huKyXztcSVayf/YdVxlW2NNIRpN8COUQixbehiTseNKw==
X-Received: by 2002:a5d:4f8d:: with SMTP id
 d13mr22616909wru.239.1633946337575;
        Mon, 11 Oct 2021 02:58:57 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:86d0:36d0:28d3:a79a])
        by smtp.gmail.com with ESMTPSA id
 k22sm7533057wrd.59.2021.10.11.02.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:58:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH 3/4] hashserv: Fix diverging report race condition
Date: Mon, 11 Oct 2021 10:58:54 +0100
Message-Id: <20211011095855.2720493-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211011095855.2720493-1-richard.purdie@linuxfoundation.org>
References: <20211011095855.2720493-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Oct 2021 09:59:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12763

From: Joshua Watt <JPEWhacker@gmail.com>

Fixes the hashequivalence server to resolve the diverging report race
error. This error occurs when the same task(hash) is run simultaneous on
two different builders, and then the results are reported back but the
hashes diverge (e.g. have different outhashes), and one outhash is
equivalent to a hash and another is not. If taskhash was not originally
in the database, the client will fallback to using the taskhash as the
suggested unihash and the server will see reports come in like:

    taskhash: A
    unihash: A
    outhash: B

    taskhash: C
    unihash: C
    outhash: B

    taskhash: C
    unihash: C
    outhash: D

Note that the second and third reports are the same taskhash, with
diverging outhashes.

Taskhash C should be equivalent to taskhash (and unihash) A because they
share an outhash B, but the server would not do this when tasks were
reported in the order shown.

It became clear while trying to fix this that single large table to
store all reported hashes was going to make these updates difficult
since updating the unihash of all entries would be complex and time
consuming. Instead, it makes more sense to split apart the database into
two tables: One that maps taskhashes to unihashes and one that maps
outhashes to taskhashes. This should hopefully improve the parsing query
times as well since they only care about the taskhashes to unihashes
table, at the cost of more complex INNER JOIN queries on the lesser used
API.

Note this change does delete existing hash equivlance data and starts a
new database table rather than converting existing data.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/hashserv/__init__.py |  66 +++++---
 lib/hashserv/client.py   |   1 +
 lib/hashserv/server.py   | 340 +++++++++++++++++++++++++--------------
 lib/hashserv/tests.py    |  60 +++++--
 4 files changed, 314 insertions(+), 153 deletions(-)

diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 5f2e101e52..9cb3fd57a5 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -22,46 +22,68 @@ ADDR_TYPE_TCP = 1
 # is necessary
 DEFAULT_MAX_CHUNK = 32 * 1024
 
-TABLE_DEFINITION = (
-    ("method", "TEXT NOT NULL"),
-    ("outhash", "TEXT NOT NULL"),
-    ("taskhash", "TEXT NOT NULL"),
-    ("unihash", "TEXT NOT NULL"),
-    ("created", "DATETIME"),
+UNIHASH_TABLE_DEFINITION = (
+    ("method", "TEXT NOT NULL", "UNIQUE"),
+    ("taskhash", "TEXT NOT NULL", "UNIQUE"),
+    ("unihash", "TEXT NOT NULL", ""),
+)
+
+UNIHASH_TABLE_COLUMNS = tuple(name for name, _, _ in UNIHASH_TABLE_DEFINITION)
+
+OUTHASH_TABLE_DEFINITION = (
+    ("method", "TEXT NOT NULL", "UNIQUE"),
+    ("taskhash", "TEXT NOT NULL", "UNIQUE"),
+    ("outhash", "TEXT NOT NULL", "UNIQUE"),
+    ("created", "DATETIME", ""),
 
     # Optional fields
-    ("owner", "TEXT"),
-    ("PN", "TEXT"),
-    ("PV", "TEXT"),
-    ("PR", "TEXT"),
-    ("task", "TEXT"),
-    ("outhash_siginfo", "TEXT"),
+    ("owner", "TEXT", ""),
+    ("PN", "TEXT", ""),
+    ("PV", "TEXT", ""),
+    ("PR", "TEXT", ""),
+    ("task", "TEXT", ""),
+    ("outhash_siginfo", "TEXT", ""),
 )
 
-TABLE_COLUMNS = tuple(name for name, _ in TABLE_DEFINITION)
+OUTHASH_TABLE_COLUMNS = tuple(name for name, _, _ in OUTHASH_TABLE_DEFINITION)
+
+def _make_table(cursor, name, definition):
+    cursor.execute('''
+        CREATE TABLE IF NOT EXISTS {name} (
+            id INTEGER PRIMARY KEY AUTOINCREMENT,
+            {fields}
+            UNIQUE({unique})
+            )
+        '''.format(
+            name=name,
+            fields=" ".join("%s %s," % (name, typ) for name, typ, _ in definition),
+            unique=", ".join(name for name, _, flags in definition if "UNIQUE" in flags)
+    ))
+
 
 def setup_database(database, sync=True):
     db = sqlite3.connect(database)
     db.row_factory = sqlite3.Row
 
     with closing(db.cursor()) as cursor:
-        cursor.execute('''
-            CREATE TABLE IF NOT EXISTS tasks_v2 (
-                id INTEGER PRIMARY KEY AUTOINCREMENT,
-                %s
-                UNIQUE(method, outhash, taskhash)
-                )
-            ''' % " ".join("%s %s," % (name, typ) for name, typ in TABLE_DEFINITION))
+        _make_table(cursor, "unihashes_v2", UNIHASH_TABLE_DEFINITION)
+        _make_table(cursor, "outhashes_v2", OUTHASH_TABLE_DEFINITION)
+
         cursor.execute('PRAGMA journal_mode = WAL')
         cursor.execute('PRAGMA synchronous = %s' % ('NORMAL' if sync else 'OFF'))
 
         # Drop old indexes
         cursor.execute('DROP INDEX IF EXISTS taskhash_lookup')
         cursor.execute('DROP INDEX IF EXISTS outhash_lookup')
+        cursor.execute('DROP INDEX IF EXISTS taskhash_lookup_v2')
+        cursor.execute('DROP INDEX IF EXISTS outhash_lookup_v2')
+
+        # TODO: Upgrade from tasks_v2?
+        cursor.execute('DROP TABLE IF EXISTS tasks_v2')
 
         # Create new indexes
-        cursor.execute('CREATE INDEX IF NOT EXISTS taskhash_lookup_v2 ON tasks_v2 (method, taskhash, created)')
-        cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup_v2 ON tasks_v2 (method, outhash)')
+        cursor.execute('CREATE INDEX IF NOT EXISTS taskhash_lookup_v3 ON unihashes_v2 (method, taskhash)')
+        cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup_v3 ON outhashes_v2 (method, outhash)')
 
     return db
 
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 8cfd90d6a8..b2aa1026ac 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -111,6 +111,7 @@ class Client(bb.asyncrpc.Client):
             "report_unihash",
             "report_unihash_equiv",
             "get_taskhash",
+            "get_outhash",
             "get_stats",
             "reset_stats",
             "backfill_wait",
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index a059e52115..ef8227d430 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -5,11 +5,12 @@
 
 from contextlib import closing, contextmanager
 from datetime import datetime
+import enum
 import asyncio
 import logging
 import math
 import time
-from . import create_async_client, TABLE_COLUMNS
+from . import create_async_client, UNIHASH_TABLE_COLUMNS, OUTHASH_TABLE_COLUMNS
 import bb.asyncrpc
 
 
@@ -106,56 +107,64 @@ class Stats(object):
         return {k: getattr(self, k) for k in ('num', 'total_time', 'max_time', 'average', 'stdev')}
 
 
-def insert_task(cursor, data, ignore=False):
+@enum.unique
+class Resolve(enum.Enum):
+    FAIL = enum.auto()
+    IGNORE = enum.auto()
+    REPLACE = enum.auto()
+
+
+def insert_table(cursor, table, data, on_conflict):
+    resolve = {
+        Resolve.FAIL: "",
+        Resolve.IGNORE: " OR IGNORE",
+        Resolve.REPLACE: " OR REPLACE",
+    }[on_conflict]
+
     keys = sorted(data.keys())
-    query = '''INSERT%s INTO tasks_v2 (%s) VALUES (%s)''' % (
-        " OR IGNORE" if ignore else "",
-        ', '.join(keys),
-        ', '.join(':' + k for k in keys))
+    query = 'INSERT{resolve} INTO {table} ({fields}) VALUES({values})'.format(
+        resolve=resolve,
+        table=table,
+        fields=", ".join(keys),
+        values=", ".join(":" + k for k in keys),
+    )
+    prevrowid = cursor.lastrowid
     cursor.execute(query, data)
-
-async def copy_from_upstream(client, db, method, taskhash):
-    d = await client.get_taskhash(method, taskhash, True)
+    logging.debug(
+        "Inserting %r into %s, %s",
+        data,
+        table,
+        on_conflict
+    )
+    return (cursor.lastrowid, cursor.lastrowid != prevrowid)
+
+def insert_unihash(cursor, data, on_conflict):
+    return insert_table(cursor, "unihashes_v2", data, on_conflict)
+
+def insert_outhash(cursor, data, on_conflict):
+    return insert_table(cursor, "outhashes_v2", data, on_conflict)
+
+async def copy_unihash_from_upstream(client, db, method, taskhash):
+    d = await client.get_taskhash(method, taskhash)
     if d is not None:
-        # Filter out unknown columns
-        d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
-
         with closing(db.cursor()) as cursor:
-            insert_task(cursor, d)
+            insert_unihash(
+                cursor,
+                {k: v for k, v in d.items() if k in UNIHASH_TABLE_COLUMNS},
+                Resolve.IGNORE,
+            )
             db.commit()
-
     return d
 
-async def copy_outhash_from_upstream(client, db, method, outhash, taskhash):
-    d = await client.get_outhash(method, outhash, taskhash)
-    if d is not None:
-        # Filter out unknown columns
-        d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
 
-        with closing(db.cursor()) as cursor:
-            insert_task(cursor, d)
-            db.commit()
+class ServerCursor(object):
+    def __init__(self, db, cursor, upstream):
+        self.db = db
+        self.cursor = cursor
+        self.upstream = upstream
 
-    return d
 
 class ServerClient(bb.asyncrpc.AsyncServerConnection):
-    FAST_QUERY = 'SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
-    ALL_QUERY =  'SELECT *                         FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
-    OUTHASH_QUERY = '''
-        -- Find tasks with a matching outhash (that is, tasks that
-        -- are equivalent)
-        SELECT * FROM tasks_v2 WHERE method=:method AND outhash=:outhash
-
-        -- If there is an exact match on the taskhash, return it.
-        -- Otherwise return the oldest matching outhash of any
-        -- taskhash
-        ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
-            created ASC
-
-        -- Only return one row
-        LIMIT 1
-        '''
-
     def __init__(self, reader, writer, db, request_stats, backfill_queue, upstream, read_only):
         super().__init__(reader, writer, 'OEHASHEQUIV', logger)
         self.db = db
@@ -210,36 +219,102 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     async def handle_get(self, request):
         method = request['method']
         taskhash = request['taskhash']
+        fetch_all = request.get('all', False)
 
-        if request.get('all', False):
-            row = self.query_equivalent(method, taskhash, self.ALL_QUERY)
-        else:
-            row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
+        with closing(self.db.cursor()) as cursor:
+            d = await self.get_unihash(cursor, method, taskhash, fetch_all)
 
-        if row is not None:
-            logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
-            d = {k: row[k] for k in row.keys()}
-        elif self.upstream_client is not None:
-            d = await copy_from_upstream(self.upstream_client, self.db, method, taskhash)
+        self.write_message(d)
+
+    async def get_unihash(self, cursor, method, taskhash, fetch_all=False):
+        d = None
+
+        if fetch_all:
+            cursor.execute(
+                '''
+                SELECT *, unihashes_v2.unihash AS unihash FROM outhashes_v2
+                INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
+                WHERE outhashes_v2.method=:method AND outhashes_v2.taskhash=:taskhash
+                ORDER BY outhashes_v2.created ASC
+                LIMIT 1
+                ''',
+                {
+                    'method': method,
+                    'taskhash': taskhash,
+                }
+
+            )
+            row = cursor.fetchone()
+
+            if row is not None:
+                d = {k: row[k] for k in row.keys()}
+            elif self.upstream_client is not None:
+                d = await self.upstream_client.get_taskhash(method, taskhash, True)
+                self.update_unified(cursor, d)
+                self.db.commit()
         else:
-            d = None
+            row = self.query_equivalent(cursor, method, taskhash)
+
+            if row is not None:
+                d = {k: row[k] for k in row.keys()}
+            elif self.upstream_client is not None:
+                d = await self.upstream_client.get_taskhash(method, taskhash)
+                d = {k: v for k, v in d.items() if k in UNIHASH_TABLE_COLUMNS}
+                insert_unihash(cursor, d, Resolve.IGNORE)
+                self.db.commit()
 
-        self.write_message(d)
+        return d
 
     async def handle_get_outhash(self, request):
+        method = request['method']
+        outhash = request['outhash']
+        taskhash = request['taskhash']
+
         with closing(self.db.cursor()) as cursor:
-            cursor.execute(self.OUTHASH_QUERY,
-                           {k: request[k] for k in ('method', 'outhash', 'taskhash')})
+            d = await self.get_outhash(cursor, method, outhash, taskhash)
 
-            row = cursor.fetchone()
+        self.write_message(d)
+
+    async def get_outhash(self, cursor, method, outhash, taskhash):
+        d = None
+        cursor.execute(
+            '''
+            SELECT *, unihashes_v2.unihash AS unihash FROM outhashes_v2
+            INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
+            WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash
+            ORDER BY outhashes_v2.created ASC
+            LIMIT 1
+            ''',
+            {
+                'method': method,
+                'outhash': outhash,
+            }
+        )
+        row = cursor.fetchone()
 
         if row is not None:
-            logger.debug('Found equivalent outhash %s -> %s', (row['outhash'], row['unihash']))
             d = {k: row[k] for k in row.keys()}
-        else:
-            d = None
+        elif self.upstream_client is not None:
+            d = await self.upstream_client.get_outhash(method, outhash, taskhash)
+            self.update_unified(cursor, d)
+            self.db.commit()
 
-        self.write_message(d)
+        return d
+
+    def update_unified(self, cursor, data):
+        if data is None:
+            return
+
+        insert_unihash(
+            cursor,
+            {k: v for k, v in data.items() if k in UNIHASH_TABLE_COLUMNS},
+            Resolve.IGNORE
+        )
+        insert_outhash(
+            cursor,
+            {k: v for k, v in data.items() if k in OUTHASH_TABLE_COLUMNS},
+            Resolve.IGNORE
+        )
 
     async def handle_get_stream(self, request):
         self.write_message('ok')
@@ -267,7 +342,12 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
                 (method, taskhash) = l.split()
                 #logger.debug('Looking up %s %s' % (method, taskhash))
-                row = self.query_equivalent(method, taskhash, self.FAST_QUERY)
+                cursor = self.db.cursor()
+                try:
+                    row = self.query_equivalent(cursor, method, taskhash)
+                finally:
+                    cursor.close()
+
                 if row is not None:
                     msg = ('%s\n' % row['unihash']).encode('utf-8')
                     #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
@@ -294,55 +374,82 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
     async def handle_report(self, data):
         with closing(self.db.cursor()) as cursor:
-            cursor.execute(self.OUTHASH_QUERY,
-                           {k: data[k] for k in ('method', 'outhash', 'taskhash')})
+            outhash_data = {
+                'method': data['method'],
+                'outhash': data['outhash'],
+                'taskhash': data['taskhash'],
+                'created': datetime.now()
+            }
 
-            row = cursor.fetchone()
+            for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
+                if k in data:
+                    outhash_data[k] = data[k]
+
+            # Insert the new entry, unless it already exists
+            (rowid, inserted) = insert_outhash(cursor, outhash_data, Resolve.IGNORE)
+
+            if inserted:
+                # If this row is new, check if it is equivalent to another
+                # output hash
+                cursor.execute(
+                    '''
+                    SELECT outhashes_v2.taskhash AS taskhash, unihashes_v2.unihash AS unihash FROM outhashes_v2
+                    INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
+                    -- Select any matching output hash except the one we just inserted
+                    WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash AND outhashes_v2.taskhash!=:taskhash
+                    -- Pick the oldest hash
+                    ORDER BY outhashes_v2.created ASC
+                    LIMIT 1
+                    ''',
+                    {
+                        'method': data['method'],
+                        'outhash': data['outhash'],
+                        'taskhash': data['taskhash'],
+                    }
+                )
+                row = cursor.fetchone()
 
-            if row is None and self.upstream_client:
-                # Try upstream
-                row = await copy_outhash_from_upstream(self.upstream_client,
-                                                       self.db,
-                                                       data['method'],
-                                                       data['outhash'],
-                                                       data['taskhash'])
-
-            # If no matching outhash was found, or one *was* found but it
-            # wasn't an exact match on the taskhash, a new entry for this
-            # taskhash should be added
-            if row is None or row['taskhash'] != data['taskhash']:
-                # If a row matching the outhash was found, the unihash for
-                # the new taskhash should be the same as that one.
-                # Otherwise the caller provided unihash is used.
-                unihash = data['unihash']
                 if row is not None:
+                    # A matching output hash was found. Set our taskhash to the
+                    # same unihash since they are equivalent
                     unihash = row['unihash']
+                    resolve = Resolve.REPLACE
+                else:
+                    # No matching output hash was found. This is probably the
+                    # first outhash to be added.
+                    unihash = data['unihash']
+                    resolve = Resolve.IGNORE
+
+                    # Query upstream to see if it has a unihash we can use
+                    if self.upstream_client is not None:
+                        upstream_data = await self.upstream_client.get_outhash(data['method'], data['outhash'], data['taskhash'])
+                        if upstream_data is not None:
+                            unihash = upstream_data['unihash']
+
+
+                insert_unihash(
+                    cursor,
+                    {
+                        'method': data['method'],
+                        'taskhash': data['taskhash'],
+                        'unihash': unihash,
+                    },
+                    resolve
+                )
+
+            unihash_data = await self.get_unihash(cursor, data['method'], data['taskhash'])
+            if unihash_data is not None:
+                unihash = unihash_data['unihash']
+            else:
+                unihash = data['unihash']
 
-                insert_data = {
-                    'method': data['method'],
-                    'outhash': data['outhash'],
-                    'taskhash': data['taskhash'],
-                    'unihash': unihash,
-                    'created': datetime.now()
-                }
-
-                for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
-                    if k in data:
-                        insert_data[k] = data[k]
-
-                insert_task(cursor, insert_data)
-                self.db.commit()
-
-                logger.info('Adding taskhash %s with unihash %s',
-                            data['taskhash'], unihash)
+            self.db.commit()
 
-                d = {
-                    'taskhash': data['taskhash'],
-                    'method': data['method'],
-                    'unihash': unihash
-                }
-            else:
-                d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
+            d = {
+                'taskhash': data['taskhash'],
+                'method': data['method'],
+                'unihash': unihash,
+            }
 
         self.write_message(d)
 
@@ -350,23 +457,16 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         with closing(self.db.cursor()) as cursor:
             insert_data = {
                 'method': data['method'],
-                'outhash': "",
                 'taskhash': data['taskhash'],
                 'unihash': data['unihash'],
-                'created': datetime.now()
             }
-
-            for k in ('owner', 'PN', 'PV', 'PR', 'task', 'outhash_siginfo'):
-                if k in data:
-                    insert_data[k] = data[k]
-
-            insert_task(cursor, insert_data, ignore=True)
+            insert_unihash(cursor, insert_data, Resolve.IGNORE)
             self.db.commit()
 
             # Fetch the unihash that will be reported for the taskhash. If the
             # unihash matches, it means this row was inserted (or the mapping
             # was already valid)
-            row = self.query_equivalent(data['method'], data['taskhash'], self.FAST_QUERY)
+            row = self.query_equivalent(cursor, data['method'], data['taskhash'])
 
             if row['unihash'] == data['unihash']:
                 logger.info('Adding taskhash equivalence for %s with unihash %s',
@@ -399,14 +499,16 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         await self.backfill_queue.join()
         self.write_message(d)
 
-    def query_equivalent(self, method, taskhash, query):
+    def query_equivalent(self, cursor, method, taskhash):
         # This is part of the inner loop and must be as fast as possible
-        try:
-            cursor = self.db.cursor()
-            cursor.execute(query, {'method': method, 'taskhash': taskhash})
-            return cursor.fetchone()
-        except:
-            cursor.close()
+        cursor.execute(
+            'SELECT taskhash, method, unihash FROM unihashes_v2 WHERE method=:method AND taskhash=:taskhash',
+            {
+                'method': method,
+                'taskhash': taskhash,
+            }
+        )
+        return cursor.fetchone()
 
 
 class Server(bb.asyncrpc.AsyncServer):
@@ -435,7 +537,7 @@ class Server(bb.asyncrpc.AsyncServer):
                         self.backfill_queue.task_done()
                         break
                     method, taskhash = item
-                    await copy_from_upstream(client, self.db, method, taskhash)
+                    await copy_unihash_from_upstream(client, self.db, method, taskhash)
                     self.backfill_queue.task_done()
             finally:
                 await client.close()
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 1fcfb6b929..efaf3bdf42 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -19,10 +19,10 @@ import time
 import signal
 
 def server_prefunc(server, idx):
-    logging.basicConfig(level=logging.DEBUG, filename='bbhashserv.log', filemode='w',
+    logging.basicConfig(level=logging.DEBUG, filename='bbhashserv-%d.log' % idx, filemode='w',
                         format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
     server.logger.debug("Running server %d" % idx)
-    sys.stdout = open('bbhashserv-%d.log' % idx, 'w')
+    sys.stdout = open('bbhashserv-stdout-%d.log' % idx, 'w')
     sys.stderr = sys.stdout
 
 class HashEquivalenceTestSetup(object):
@@ -140,12 +140,17 @@ class HashEquivalenceCommonTests(object):
         })
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
-        result = self.client.get_taskhash(self.METHOD, taskhash, True)
-        self.assertEqual(result['taskhash'], taskhash)
-        self.assertEqual(result['unihash'], unihash)
-        self.assertEqual(result['method'], self.METHOD)
-        self.assertEqual(result['outhash'], outhash)
-        self.assertEqual(result['outhash_siginfo'], siginfo)
+        result_unihash = self.client.get_taskhash(self.METHOD, taskhash, True)
+        self.assertEqual(result_unihash['taskhash'], taskhash)
+        self.assertEqual(result_unihash['unihash'], unihash)
+        self.assertEqual(result_unihash['method'], self.METHOD)
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertEqual(result_outhash['taskhash'], taskhash)
+        self.assertEqual(result_outhash['method'], self.METHOD)
+        self.assertEqual(result_outhash['unihash'], unihash)
+        self.assertEqual(result_outhash['outhash'], outhash)
+        self.assertEqual(result_outhash['outhash_siginfo'], siginfo)
 
     def test_stress(self):
         def query_server(failures):
@@ -260,6 +265,39 @@ class HashEquivalenceCommonTests(object):
         result = down_client.report_unihash(taskhash6, self.METHOD, outhash5, unihash6)
         self.assertEqual(result['unihash'], unihash5, 'Server failed to copy unihash from upstream')
 
+        # Tests read through from server with
+        taskhash7 = '9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74'
+        outhash7 = '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69'
+        unihash7 = '05d2a63c81e32f0a36542ca677e8ad852365c538'
+        self.client.report_unihash(taskhash7, self.METHOD, outhash7, unihash7)
+
+        result = down_client.get_taskhash(self.METHOD, taskhash7, True)
+        self.assertEqual(result['unihash'], unihash7, 'Server failed to copy unihash from upstream')
+        self.assertEqual(result['outhash'], outhash7, 'Server failed to copy unihash from upstream')
+        self.assertEqual(result['taskhash'], taskhash7, 'Server failed to copy unihash from upstream')
+        self.assertEqual(result['method'], self.METHOD)
+
+        taskhash8 = '86978a4c8c71b9b487330b0152aade10c1ee58aa'
+        outhash8 = 'ca8c128e9d9e4a28ef24d0508aa20b5cf880604eacd8f65c0e366f7e0cc5fbcf'
+        unihash8 = 'd8bcf25369d40590ad7d08c84d538982f2023e01'
+        self.client.report_unihash(taskhash8, self.METHOD, outhash8, unihash8)
+
+        result = down_client.get_outhash(self.METHOD, outhash8, taskhash8)
+        self.assertEqual(result['unihash'], unihash8, 'Server failed to copy unihash from upstream')
+        self.assertEqual(result['outhash'], outhash8, 'Server failed to copy unihash from upstream')
+        self.assertEqual(result['taskhash'], taskhash8, 'Server failed to copy unihash from upstream')
+        self.assertEqual(result['method'], self.METHOD)
+
+        taskhash9 = 'ae6339531895ddf5b67e663e6a374ad8ec71d81c'
+        outhash9 = 'afc78172c81880ae10a1fec994b5b4ee33d196a001a1b66212a15ebe573e00b5'
+        unihash9 = '6662e699d6e3d894b24408ff9a4031ef9b038ee8'
+        self.client.report_unihash(taskhash9, self.METHOD, outhash9, unihash9)
+
+        result = down_client.get_taskhash(self.METHOD, taskhash9, False)
+        self.assertEqual(result['unihash'], unihash9, 'Server failed to copy unihash from upstream')
+        self.assertEqual(result['taskhash'], taskhash9, 'Server failed to copy unihash from upstream')
+        self.assertEqual(result['method'], self.METHOD)
+
     def test_ro_server(self):
         (ro_client, ro_server) = self.start_server(dbpath=self.server.dbpath, read_only=True)
 
@@ -287,10 +325,8 @@ class HashEquivalenceCommonTests(object):
 
 
     def test_slow_server_start(self):
-        """
-        Ensures that the server will exit correctly even if it gets a SIGTERM
-        before entering the main loop
-        """
+        # Ensures that the server will exit correctly even if it gets a SIGTERM
+        # before entering the main loop
 
         event = multiprocessing.Event()
 
-- 
2.32.0


