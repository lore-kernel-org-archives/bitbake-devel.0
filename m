Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
	[209.85.166.53])
	by mail.openembedded.org (Postfix) with ESMTP id 3D26D6C637;
	Tue,  4 Dec 2018 03:46:26 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id l14so12409712ioj.5;
	Mon, 03 Dec 2018 19:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Aoeh7rC01WxDfPslyd//IDiKL3fmnWYY+7HVdWbfUOo=;
	b=oAp9TwWIV11xuFRC2eXLwrphq9WTjyWSLzJKJ4dphDq2Rxk6I04aLKBaRGT/mM0GIa
	1L6nVpfP63d5trgav7RCX6MPghGwp409ynl1fWeccCqt6I41RZXP+zI94gCBatwSC2jE
	mA5jbg+eWkJOSCbl6E/cGQDX/IrH6XXM71Rnc3uJ/JXEaL3x2HDfO1fYP2h1yDrdpCLK
	8RriwUuVzFUNmJ9yyW2IphvD9MyOgwIQgMcNdrIrBvl4WH5mGaKGEroxJXzA8RQaZVNy
	WFpjmYHzh4mUWLFXLZPQFF9plvwIKhm2/9nQ3WUh9TwDCcE7rj9XWpUx2nYChPSXWTX5
	kpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Aoeh7rC01WxDfPslyd//IDiKL3fmnWYY+7HVdWbfUOo=;
	b=cQODGA388TZ4Qpz1LpUhuPZI7eUeqA9jTjHQCOg1tOFyhbXPYUDNR4LbYEzoohh5eH
	FU+xI+6241TNSVtGmTltDS9YXJCYH6C0XDXX8vM2Fj9q7f12wh56nWkn5TCs1R70Jxnb
	vmieW7PC/uBqK/9pYd83fX0kUSK4wXgRcVGj2l/Nosi0wpnM0SI2kh7eM9V0zh+7jvDk
	+hcD/t40E+CuA+lwSGAieQMXZl2u5QneJVXALXQZXu7X8pLFPHjNyXyWf6d1YR6Vh+XE
	m7rbXgPguflo61TmsWkPfDUrE5qW8NfGPybDOnZRM5oT17OM8E90FsOJD6LRe1PrDrFR
	K+cg==
X-Gm-Message-State: AA+aEWYtnylGet8fX2D6yi+yQWoxisw9rmbcai1GXtOQ5aV+9OKMaHgo
	AlgzPyLaA4dBPjxA6/K9DIlilr0FN50=
X-Google-Smtp-Source: AFSGD/XxVGDulUOXTly4+c4joaDcQLJqB0+8msU9wTij74ezEs4ujvtp+3obXct7ibwwnik18zBfLA==
X-Received: by 2002:a6b:3c17:: with SMTP id k23mr11389011iob.182.1543895186833;
	Mon, 03 Dec 2018 19:46:26 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:26 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:34 -0600
Message-Id: <20181204034245.25461-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 06/17] bitbake: persist_data: Close databases across fork
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:26 -0000
Content-Transfer-Encoding: 8bit

sqlite gets really angry if a database is open across a fork() call,
and will give all sorts of messages ranging from I/O errors to database
corruption errors. To deal with this, close all database connections
before forking, and reopen them (lazily) on the other side.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 44 +++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 41fcf2a41c4..29feb78203b 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -30,6 +30,8 @@ from bb.compat import total_ordering
 from collections import Mapping
 import sqlite3
 import contextlib
+import bb.fork
+import weakref
 
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
@@ -38,6 +40,28 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 
 logger = logging.getLogger("BitBake.PersistData")
 
+# Carrying an open database connection across a fork() confuses sqlite and
+# results in fun errors like 'database disk image is malformed'.
+# To remedy this, close all connections before forking, then they will be
+# (lazily) reopen them on the other side. This will cause a lot of problems if
+# there are threads running and trying to access the database at the same time,
+# but if you are mixing threads and fork() you have no one to blame but
+# yourself. If that is discovered to be a problem in the future, some sort of
+# per-table reader-writer lock could be used to block the fork() until all
+# pending transactions complete
+sql_table_weakrefs = []
+def _fork_before_handler():
+    for ref in sql_table_weakrefs:
+        t = ref()
+        if t is not None and t.connection is not None:
+            t.connection.close()
+            t.connection = None
+
+bb.fork.register_at_fork(before=_fork_before_handler)
+
+def _remove_table_weakref(ref):
+    sql_table_weakrefs.remove(ref)
+
 @total_ordering
 class SQLTable(collections.MutableMapping):
     class _Decorators(object):
@@ -48,6 +72,10 @@ class SQLTable(collections.MutableMapping):
             exception occurs.
             """
             def wrap_func(self, *args, **kwargs):
+                # Reconnect if necessary
+                if self.connection is None:
+                    self.reconnect()
+
                 count = 0
                 while True:
                     try:
@@ -55,8 +83,7 @@ class SQLTable(collections.MutableMapping):
                     except sqlite3.OperationalError as exc:
                         if 'is locked' in str(exc) and count < 500:
                             count = count + 1
-                            self.connection.close()
-                            self.connection = connect(self.cachefile)
+                            self.reconnect()
                             continue
                         raise
             return wrap_func
@@ -90,6 +117,11 @@ class SQLTable(collections.MutableMapping):
 
         self._execute_single("CREATE TABLE IF NOT EXISTS %s(key TEXT PRIMARY KEY NOT NULL, value TEXT);" % table)
 
+    def reconnect(self):
+        if self.connection is not None:
+            self.connection.close()
+        self.connection = connect(self.cachefile)
+
     @_Decorators.retry
     @_Decorators.transaction
     def _execute_single(self, cursor, *query):
@@ -292,4 +324,10 @@ def persist(domain, d):
 
     bb.utils.mkdirhier(cachedir)
     cachefile = os.path.join(cachedir, "bb_persist_data.sqlite3")
-    return SQLTable(cachefile, domain)
+    t = SQLTable(cachefile, domain)
+
+    # Add a weak reference to the table list. The weak reference will not keep
+    # the object alive by itself, so it prevents circular reference counts
+    sql_table_weakrefs.append(weakref.ref(t, _remove_table_weakref))
+
+    return t
-- 
2.19.1


