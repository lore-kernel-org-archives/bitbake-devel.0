Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f171.google.com (mail-it1-f171.google.com
	[209.85.166.171])
	by mail.openembedded.org (Postfix) with ESMTP id CF8CC79C7A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 21:59:32 +0000 (UTC)
Received: by mail-it1-f171.google.com with SMTP id m8so2576176itk.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Dec 2018 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kzjpeGcGPpe7B7H9LAclRLcygU8YvB5ME6tjW9JYMxA=;
	b=gw7+WrkbqU3rp7X3iUchjwBvJywTGR/LKvG1258vDEceQcSzwDENgGHEfTQg8Qd88e
	OJMNIUdIqEvlTz8qOG3qzxtl7E2cLYc/DIbksYadeoYldzyUlmYjjnFL20u4+gvgI0sr
	b2pIMyH3PC/1G52xHQcKO6LvSrQZJvdp1jHceBIr5WuLuumMtwxpJzII4pNLevUrAdFj
	mf0Lw2TRyYv7X3Q5cD1xQAPOj6CLf+NveVgd1lqsvLViCQa1b/nk+XdAIgAnPGTkt2lD
	YVRzz6DEygzCfrXcUg0b2ANCfIJmBAd18NwOkJsAj560bYgV0xrn5h6QoHFtzB/Lwcjh
	UozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=kzjpeGcGPpe7B7H9LAclRLcygU8YvB5ME6tjW9JYMxA=;
	b=kKCL/ppk8ssmyb3FBXRAZIakgEVRtSUuWLkPhOwV6r7wKKi5ywluDfqJaQIWClotxb
	Y/xiihj2GOZLY31xQTKmur3zC5tK6PTjk8XhyLSygOJyg7dVfdFu3SBKYn/75EzdxdUN
	Za8ushy/HKojqo4Wq2hsyK5X9+98EWvuZ1qA5SPqG7kUmRTd3f88TvKgnqdk/eIcwgkZ
	1/t5UMGKMLHhx9Uojg8FRIlgaOCWIUBG98T5NAOdSgek6NtyfmPy4vgW75q9u3lVMmI0
	xW3OgGCAJJxE6mSqzG0heUrrneBvxrdgUgf2Ra/KVNwmd0QMtRl/+UPMRlGyoZ1kDxts
	8RbA==
X-Gm-Message-State: AA+aEWbsneUr0NlO6Q383xSpOSyHNe0vf7RLOWNwomYzRF5f9bQcFxsk
	oNbJr9h9QY4ACzwYnLVABhLtu0bW
X-Google-Smtp-Source: AFSGD/UNoIX2c05m2IoaeeQXrvVHugGAV/RbDlwSaKJVtMsXat4lUe/OX87AJGKxlT0RsXpu4SnNtQ==
X-Received: by 2002:a02:781e:: with SMTP id p30mr3525650jac.85.1544219973506; 
	Fri, 07 Dec 2018 13:59:33 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	s15sm1889362ioe.52.2018.12.07.13.59.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 07 Dec 2018 13:59:32 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Dec 2018 15:59:28 -0600
Message-Id: <20181207215928.11957-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Subject: [PATCH] bitbake: persist_data: Retry database setup
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
X-List-Received-Date: Fri, 07 Dec 2018 21:59:33 -0000
Content-Transfer-Encoding: 8bit

The configuration of the sqlite database can timeout due to locking
under heavy load and should be subject to the same retry logic as the
other statements.

[YOCTO #13069]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 85 ++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 29feb78203b..4b37227cfd1 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -66,27 +66,31 @@ def _remove_table_weakref(ref):
 class SQLTable(collections.MutableMapping):
     class _Decorators(object):
         @staticmethod
-        def retry(f):
+        def retry(*, reconnect=True):
             """
             Decorator that restarts a function if a database locked sqlite
-            exception occurs.
+            exception occurs. If reconnect is True, the database connection
+            will be closed and reopened each time a failure occurs
             """
-            def wrap_func(self, *args, **kwargs):
-                # Reconnect if necessary
-                if self.connection is None:
-                    self.reconnect()
-
-                count = 0
-                while True:
-                    try:
-                        return f(self, *args, **kwargs)
-                    except sqlite3.OperationalError as exc:
-                        if 'is locked' in str(exc) and count < 500:
-                            count = count + 1
-                            self.reconnect()
-                            continue
-                        raise
-            return wrap_func
+            def retry_wrapper(f):
+                def wrap_func(self, *args, **kwargs):
+                    # Reconnect if necessary
+                    if self.connection is None and reconnect:
+                        self.reconnect()
+
+                    count = 0
+                    while True:
+                        try:
+                            return f(self, *args, **kwargs)
+                        except sqlite3.OperationalError as exc:
+                            if 'is locked' in str(exc) and count < 500:
+                                count = count + 1
+                                if reconnect:
+                                    self.reconnect()
+                                continue
+                            raise
+                return wrap_func
+            return retry_wrapper
 
         @staticmethod
         def transaction(f):
@@ -113,16 +117,28 @@ class SQLTable(collections.MutableMapping):
     def __init__(self, cachefile, table):
         self.cachefile = cachefile
         self.table = table
-        self.connection = connect(self.cachefile)
-
+        self.connection = None
         self._execute_single("CREATE TABLE IF NOT EXISTS %s(key TEXT PRIMARY KEY NOT NULL, value TEXT);" % table)
 
+
+    @_Decorators.retry(reconnect=False)
+    @_Decorators.transaction
+    def _setup_database(self, cursor):
+        cursor.execute("pragma synchronous = off;")
+        # Enable WAL and keep the autocheckpoint length small (the default is
+        # usually 1000). Persistent caches are usually read-mostly, so keeping
+        # this short will keep readers running quickly
+        cursor.execute("pragma journal_mode = WAL;")
+        cursor.execute("pragma wal_autocheckpoint = 100;")
+
     def reconnect(self):
         if self.connection is not None:
             self.connection.close()
-        self.connection = connect(self.cachefile)
+        self.connection = sqlite3.connect(self.cachefile, timeout=5)
+        self.connection.text_factory = str
+        self._setup_database()
 
-    @_Decorators.retry
+    @_Decorators.retry()
     @_Decorators.transaction
     def _execute_single(self, cursor, *query):
         """
@@ -131,7 +147,7 @@ class SQLTable(collections.MutableMapping):
         """
         cursor.execute(*query)
 
-    @_Decorators.retry
+    @_Decorators.retry()
     def _row_iter(self, f, *query):
         """
         Helper function that returns a row iterator. Each time __next__ is
@@ -173,7 +189,7 @@ class SQLTable(collections.MutableMapping):
     def __exit__(self, *excinfo):
         self.connection.__exit__(*excinfo)
 
-    @_Decorators.retry
+    @_Decorators.retry()
     @_Decorators.transaction
     def __getitem__(self, cursor, key):
         cursor.execute("SELECT * from %s where key=?;" % self.table, [key])
@@ -182,14 +198,14 @@ class SQLTable(collections.MutableMapping):
             return row[1]
         raise KeyError(key)
 
-    @_Decorators.retry
+    @_Decorators.retry()
     @_Decorators.transaction
     def __delitem__(self, cursor, key):
         if key not in self:
             raise KeyError(key)
         cursor.execute("DELETE from %s where key=?;" % self.table, [key])
 
-    @_Decorators.retry
+    @_Decorators.retry()
     @_Decorators.transaction
     def __setitem__(self, cursor, key, value):
         if not isinstance(key, str):
@@ -204,13 +220,13 @@ class SQLTable(collections.MutableMapping):
         else:
             cursor.execute("INSERT into %s(key, value) values (?, ?);" % self.table, [key, value])
 
-    @_Decorators.retry
+    @_Decorators.retry()
     @_Decorators.transaction
     def __contains__(self, cursor, key):
         cursor.execute('SELECT * from %s where key=?;' % self.table, [key])
         return cursor.fetchone() is not None
 
-    @_Decorators.retry
+    @_Decorators.retry()
     @_Decorators.transaction
     def __len__(self, cursor):
         cursor.execute("SELECT COUNT(key) FROM %s;" % self.table)
@@ -245,7 +261,7 @@ class SQLTable(collections.MutableMapping):
         return self._row_iter(lambda row: (row[0], row[1]), "SELECT * FROM %s;" %
                               self.table)
 
-    @_Decorators.retry
+    @_Decorators.retry()
     @_Decorators.transaction
     def clear(self, cursor):
         cursor.execute("DELETE FROM %s;" % self.table)
@@ -302,17 +318,6 @@ class PersistData(object):
         """
         del self.data[domain][key]
 
-def connect(database):
-    connection = sqlite3.connect(database, timeout=5)
-    connection.execute("pragma synchronous = off;")
-    # Enable WAL and keep the autocheckpoint length small (the default is
-    # usually 1000). Persistent caches are usually read-mostly, so keeping
-    # this short will keep readers running quickly
-    connection.execute("pragma journal_mode = WAL;")
-    connection.execute("pragma wal_autocheckpoint = 100;")
-    connection.text_factory = str
-    return connection
-
 def persist(domain, d):
     """Convenience factory for SQLTable objects based upon metadata"""
     import bb.utils
-- 
2.19.2


