Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
	[209.85.223.193])
	by mail.openembedded.org (Postfix) with ESMTP id 0653778C13;
	Thu,  9 Aug 2018 22:10:44 +0000 (UTC)
Received: by mail-io0-f193.google.com with SMTP id y10-v6so6069269ioa.10;
	Thu, 09 Aug 2018 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6s/whIuXs/p9OOhtZyMuw3MHTKu2NPMdztZoLOyGu1Q=;
	b=GzKoecmt8GWw3l9ywFTf6tTOLMZ+XdtuwhX+pCRJM8l+cp4Fx5/BDWQeLp/TL4OUim
	MReD+BUMUIspA2V6Vz8CKsz5aCVIpFBmz2s5Lb38EwMUoxMStUwew2Kx9/QeEl3GeZfL
	x/rKc62Otka8FfC4BprpWGm7Zcctm2sJn0wpUw0cAPgwjBG3916tI0PzfmXD78FztDIW
	WN9zXgFV61637V4xgGfiKuu8wRlvj15p8RdGvFnVU+ilWbzDBmzgnb0KYTzlAzIDE+uj
	tAlEJ3WTQi1drtsz3tUNROvrXsDqiS3/goRiN/9CJZIsoC8utWxjc5bd7NFc1CEA97c6
	0jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6s/whIuXs/p9OOhtZyMuw3MHTKu2NPMdztZoLOyGu1Q=;
	b=l2b4b6Zpwl09VGjmdpy8cCpo9d1TZ7eirgzj026YQBGHgUDaImU8iZYgvAp+dS2m3x
	FDXJdpCCrjICn9aJsFyJBoUdHi/bXTk2yuq9L1f1fziaAnG2rGf/kzmM4HdYsbQqn930
	eKQqzVyotbcnzbFLLbOLp/bY1Lt5u7jjap3iBr/WoFWIEDeq2Nr+6W4g7R7E26KRH42U
	eznmMYSYnVAiBpM5TTZpmPd9i+7ExNpsZ0q9gvlDBHSwjg1n5fjxhG76dUD+JcWRrpXj
	o89+hpIuNp9M84GIVM5eU3aebNHcyTaMQ07S3+nl+XIBgWO3CDxIxk8+yOgOAfDSUfY7
	X2ww==
X-Gm-Message-State: AOUpUlFNHckXYgUo0c1u9CTNmtGQRUbaJt9UUL0VOFTaOENCGECGjYHr
	Un7qLHIwVx0hpmW9NEJ9gicQbKDC
X-Google-Smtp-Source: AA+uWPzxrVtV68eiuVNbbQ0Zkbtj9lAT/y/uVBWMaR4X9sWerWT0MKNxOQr13XLb3M4CGRUvfYq24g==
X-Received: by 2002:a6b:8c08:: with SMTP id
	o8-v6mr3492607iod.195.1533852645912; 
	Thu, 09 Aug 2018 15:10:45 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:45 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:26 -0500
Message-Id: <20180809220840.26697-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 02/16] bitbake: persist_data: Fix leaking cursors causing deadlock
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 09 Aug 2018 22:10:45 -0000

The original implementation of persistent data executed all SQL
statements via sqlite3.Connection.execute(). Behind the scenes, this
function created a sqlite3 Cursor object, executed the statement, then
returned the cursor. However, the implementation did not account for
this and failed to close the cursor object when it was done. The cursor
would eventually be closed when the garbage collector got around to
destroying it. However, sqlite has a limit on the number of cursors that
can exist at any given time, and once this limit is reached it will
block a query to wait for a cursor to be destroyed. Under heavy database
queries, this can result in Python deadlocking with itself, since the
SQL query will block waiting for a free cursor, but Python can no longer
run garbage collection (as it is blocked) to free one.

This restructures the SQLTable class to use two decorators to aid in
performing actions correctly. The first decorator (@retry) wraps a
member function in the retry logic that automatically restarts the
function in the event that the database is locked.

The second decorator (@transaction) wraps the function so that it occurs
in a database transaction, which will automatically COMMIT the changes
on success and ROLLBACK on failure. This function additionally creates
an explicit cursor, passes it to the wrapped function, and cleans it up
when the function is finished.

Note that it is still possible to leak cursors when iterating. This is
much less frequent, but can still be mitigated by wrapping the iteration
in a `with` statement:

 with db.iteritems() as it:
     for (k, v) in it:
         ...

As a side effect, since most statements are wrapped in a transaction,
setting the isolation_level when the connection is created is no longer
necessary.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 188 +++++++++++++++++++++++----------
 1 file changed, 135 insertions(+), 53 deletions(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index bef7018614d..1a6319f9498 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -29,6 +29,7 @@ import warnings
 from bb.compat import total_ordering
 from collections import Mapping
 import sqlite3
+import contextlib
 
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
@@ -45,75 +46,154 @@ if hasattr(sqlite3, 'enable_shared_cache'):
 
 @total_ordering
 class SQLTable(collections.MutableMapping):
+    class _Decorators(object):
+        @staticmethod
+        def retry(f):
+            """
+            Decorator that restarts a function if a database locked sqlite
+            exception occurs.
+            """
+            def wrap_func(self, *args, **kwargs):
+                count = 0
+                while True:
+                    try:
+                        return f(self, *args, **kwargs)
+                    except sqlite3.OperationalError as exc:
+                        if 'is locked' in str(exc) and count < 500:
+                            count = count + 1
+                            self.connection.close()
+                            self.connection = connect(self.cachefile)
+                            continue
+                        raise
+            return wrap_func
+
+        @staticmethod
+        def transaction(f):
+            """
+            Decorator that starts a database transaction and creates a database
+            cursor for performing queries. If no exception is thrown, the
+            database results are commited. If an exception occurs, the database
+            is rolled back. In all cases, the cursor is closed after the
+            function ends.
+
+            Note that the cursor is passed as an extra argument to the function
+            after `self` and before any of the normal arguments
+            """
+            def wrap_func(self, *args, **kwargs):
+                # Context manager will COMMIT the database on success,
+                # or ROLLBACK on an exception
+                with self.connection:
+                    # Automatically close the cursor when done
+                    with contextlib.closing(self.connection.cursor()) as cursor:
+                        return f(self, cursor, *args, **kwargs)
+            return wrap_func
+
     """Object representing a table/domain in the database"""
     def __init__(self, cachefile, table):
         self.cachefile = cachefile
         self.table = table
-        self.cursor = connect(self.cachefile)
-
-        self._execute("CREATE TABLE IF NOT EXISTS %s(key TEXT, value TEXT);"
-                      % table)
-
-    def _execute(self, *query):
-        """Execute a query, waiting to acquire a lock if necessary"""
-        count = 0
-        while True:
-            try:
-                return self.cursor.execute(*query)
-            except sqlite3.OperationalError as exc:
-                if 'database is locked' in str(exc) and count < 500:
-                    count = count + 1
+        self.connection = connect(self.cachefile)
+
+        self._execute_single("CREATE TABLE IF NOT EXISTS %s(key TEXT, value TEXT);" % table)
+
+    @_Decorators.retry
+    @_Decorators.transaction
+    def _execute_single(self, cursor, *query):
+        """
+        Executes a single query and discards the results. This correctly closes
+        the database cursor when finished
+        """
+        cursor.execute(*query)
+
+    @_Decorators.retry
+    def _row_iter(self, f, *query):
+        """
+        Helper function that returns a row iterator. Each time __next__ is
+        called on the iterator, the provided function is evaluated to determine
+        the return value
+        """
+        class CursorIter(object):
+            def __init__(self, cursor):
+                self.cursor = cursor
+
+            def __iter__(self):
+                return self
+
+            def __next__(self):
+                row = self.cursor.fetchone()
+                if row is None:
                     self.cursor.close()
-                    self.cursor = connect(self.cachefile)
-                    continue
-                raise
+                    raise StopIteration
+                return f(row)
+
+            def __enter__(self):
+                return self
+
+            def __exit__(self, typ, value, traceback):
+                self.cursor.close()
+                return False
+
+        cursor = self.connection.cursor()
+        try:
+            cursor.execute(*query)
+            return CursorIter(cursor)
+        except:
+            cursor.close()
 
     def __enter__(self):
-        self.cursor.__enter__()
+        self.connection.__enter__()
         return self
 
     def __exit__(self, *excinfo):
-        self.cursor.__exit__(*excinfo)
-
-    def __getitem__(self, key):
-        data = self._execute("SELECT * from %s where key=?;" %
-                             self.table, [key])
-        for row in data:
+        self.connection.__exit__(*excinfo)
+
+    @_Decorators.retry
+    @_Decorators.transaction
+    def __getitem__(self, cursor, key):
+        cursor.execute("SELECT * from %s where key=?;" % self.table, [key])
+        row = cursor.fetchone()
+        if row is not None:
             return row[1]
         raise KeyError(key)
 
-    def __delitem__(self, key):
+    @_Decorators.retry
+    @_Decorators.transaction
+    def __delitem__(self, cursor, key):
         if key not in self:
             raise KeyError(key)
-        self._execute("DELETE from %s where key=?;" % self.table, [key])
+        cursor.execute("DELETE from %s where key=?;" % self.table, [key])
 
-    def __setitem__(self, key, value):
+    @_Decorators.retry
+    @_Decorators.transaction
+    def __setitem__(self, cursor, key, value):
         if not isinstance(key, str):
             raise TypeError('Only string keys are supported')
         elif not isinstance(value, str):
             raise TypeError('Only string values are supported')
 
-        data = self._execute("SELECT * from %s where key=?;" %
-                                   self.table, [key])
-        exists = len(list(data))
-        if exists:
-            self._execute("UPDATE %s SET value=? WHERE key=?;" % self.table,
-                          [value, key])
+        cursor.execute("SELECT * from %s where key=?;" % self.table, [key])
+        row = cursor.fetchone()
+        if row is not None:
+            cursor.execute("UPDATE %s SET value=? WHERE key=?;" % self.table, [value, key])
         else:
-            self._execute("INSERT into %s(key, value) values (?, ?);" %
-                          self.table, [key, value])
-
-    def __contains__(self, key):
-        return key in set(self)
-
-    def __len__(self):
-        data = self._execute("SELECT COUNT(key) FROM %s;" % self.table)
-        for row in data:
+            cursor.execute("INSERT into %s(key, value) values (?, ?);" % self.table, [key, value])
+
+    @_Decorators.retry
+    @_Decorators.transaction
+    def __contains__(self, cursor, key):
+        cursor.execute('SELECT * from %s where key=?;' % self.table, [key])
+        return cursor.fetchone() is not None
+
+    @_Decorators.retry
+    @_Decorators.transaction
+    def __len__(self, cursor):
+        cursor.execute("SELECT COUNT(key) FROM %s;" % self.table)
+        row = cursor.fetchone()
+        if row is not None:
             return row[0]
 
     def __iter__(self):
-        data = self._execute("SELECT key FROM %s;" % self.table)
-        return (row[0] for row in data)
+        return self._row_iter(lambda row: row[0], "SELECT key from %s;" % self.table)
 
     def __lt__(self, other):
         if not isinstance(other, Mapping):
@@ -122,25 +202,27 @@ class SQLTable(collections.MutableMapping):
         return len(self) < len(other)
 
     def get_by_pattern(self, pattern):
-        data = self._execute("SELECT * FROM %s WHERE key LIKE ?;" %
-                             self.table, [pattern])
-        return [row[1] for row in data]
+        return self._row_iter(lambda row: row[1], "SELECT * FROM %s WHERE key LIKE ?;" %
+                              self.table, [pattern])
 
     def values(self):
         return list(self.itervalues())
 
     def itervalues(self):
-        data = self._execute("SELECT value FROM %s;" % self.table)
-        return (row[0] for row in data)
+        return self._row_iter(lambda row: row[0], "SELECT value FROM %s;" %
+                              self.table)
 
     def items(self):
         return list(self.iteritems())
 
     def iteritems(self):
-        return self._execute("SELECT * FROM %s;" % self.table)
+        return self._row_iter(lambda row: (row[0], row[1]), "SELECT * FROM %s;" %
+                              self.table)
 
-    def clear(self):
-        self._execute("DELETE FROM %s;" % self.table)
+    @_Decorators.retry
+    @_Decorators.transaction
+    def clear(self, cursor):
+        cursor.execute("DELETE FROM %s;" % self.table)
 
     def has_key(self, key):
         return key in self
@@ -195,7 +277,7 @@ class PersistData(object):
         del self.data[domain][key]
 
 def connect(database):
-    connection = sqlite3.connect(database, timeout=5, isolation_level=None)
+    connection = sqlite3.connect(database, timeout=5)
     connection.execute("pragma synchronous = off;")
     connection.text_factory = str
     return connection
-- 
2.17.1


