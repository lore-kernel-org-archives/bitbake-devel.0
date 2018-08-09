Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id 35E7A78E86;
	Thu,  9 Aug 2018 22:10:48 +0000 (UTC)
Received: by mail-io0-f175.google.com with SMTP id l7-v6so2238058iok.6;
	Thu, 09 Aug 2018 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9GnhHa5MXnlOuLF1kOB/CzFCqRrPstWtTlBmGn4zeiQ=;
	b=c2DjGd6k96wirrwA+rmDf0G22VI8W4TOLDagcgdFlt9K+u9YpIIhdzgARoEir8ybD5
	howhHiwmZatnes2t/kSPVgJ1hi1w5LPJvvNfIkPFrvo5QtrAdpdJrZKrpevGEPALz3Rh
	pqj5rgyjs0xF+VnjF1n+GnxXf5qZHcbtgFODjqEiEZL1DVczq92Hj1ZFOqZoKqRfzBye
	BEswsPeg+F0U4rv1W2FpVZDWhF+KFOKH7GtWT7kAX5UCjUXxzkmVlbeRfl0xpjZHJ0W/
	xpV2Q9wfWDzMsAq8W/zq5Gw61Mbs7oW2YLTq8N5zNZ24JXVMbL17oazrdrt92XcFwHMs
	dWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=9GnhHa5MXnlOuLF1kOB/CzFCqRrPstWtTlBmGn4zeiQ=;
	b=JoM2M/6JW4E0PfMBR3js9o8fWf7NUL4A5AHANcA3ysu3k/3m3XAEIgv9xVrE6pzD/5
	VkapKddEahP3w03rDgM03v8JapJvh3ZChzjgnhj6R27XQf9bNjyBSaZc9LFBmn9qcCsA
	K7MTucv8x2KG7p78ERXchD0RiEr7SeFOxdst6yUes25+1Stj5jILE/BiYA6ORieHFcEo
	PT3ibKHBBsewCxejiXiwsvWt2nWeTtyWQqKWJwY91QmiftDtCyq/XLTMPGus7zRoqvsA
	t4Yen/f/6IXgv9BzkeWrsqNjUKhq18ap0upq/H6U0xwsK+jkWTGnoUjMWNZk48XtptAu
	JKrQ==
X-Gm-Message-State: AOUpUlFSiCWSFXtap5G4viNXQAVRyBEruPTHg5sTfgPY+YhAhYdWh8kg
	rncIpgYrwflrmISnel7w8JZ4MfsM
X-Google-Smtp-Source: AA+uWPxmozncLgnx4fe2Y3XpOpou6Z2KYm3V4Vu9vRWsQ3Psknub58mMqdMaP1Lzq6FKNO+k6IvrxQ==
X-Received: by 2002:a6b:7208:: with SMTP id n8-v6mr2822305ioc.82.1533852649097;
	Thu, 09 Aug 2018 15:10:49 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:48 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:30 -0500
Message-Id: <20180809220840.26697-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 06/16] bitbake: persist_data: Close databases across fork
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:48 -0000

sqlite gets really angry if a database is closed across a fork() call,
and will give all sorts of messages ranging from I/O errors to database
corruption errors. To deal with this, close all database connections
before forking, and reopen them (lazily) on the other side.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 44 +++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index f0d3ce665d9..6bd3924ffb3 100644
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
2.17.1


