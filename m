Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com
	[209.85.166.178])
	by mail.openembedded.org (Postfix) with ESMTP id 7E1796E47A;
	Tue, 18 Dec 2018 15:31:09 +0000 (UTC)
Received: by mail-it1-f178.google.com with SMTP id g85so4728510ita.3;
	Tue, 18 Dec 2018 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=5ezNzWiUHXgjxfzTF04aQmX69IKPGkPOB+9DByRZcl0=;
	b=FNNayzgS8bGw66HSFb/msfmDowv97s754mgaa4R+CU9ZWlXijj3YENGcINqFq+YqKD
	ksZ8ir71n8aQi4zsamFikHBLBlzWRsX0oIa42T6shqbiE/ZxiI4wZZ/JPmcJIU8+RN1x
	o3mZg+4zLT0CGDjss99zsUTIxEJ9CQWFfYDupcM6srGxnxLmAYcAxDUScHRdBJelkViF
	fd1xv4kIAL0nxsic4DElCUH6GeGSOuCAYjEPRrTXd2KgDip+JDb+qHJzlDukjAeLBVs9
	8CAR6nUzb87CqRyO84l7i+Xvr82B7pBA0JSE4oXUM5o4OyQqtrPaBNFo0MIa9ZkLptC5
	QUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5ezNzWiUHXgjxfzTF04aQmX69IKPGkPOB+9DByRZcl0=;
	b=AWo4YvKDaDNXk5l8TO6yWMq7i15fcwI2wjXXgQipSPvsEqHyCGWwu4UTDLZ6Ic35q4
	u4Zc+v/Ods70cLb0p7N1+mSrtlHhB5sgdZ2HsaSEEQt0pk21qH2JBkcGrpzJVl9uLBOM
	dBO5kQRcvmWS6VctHDrc+qOgoSauypVdUH378aLTK6s0ezTiROUlXXFHqaIbyoMXw9ju
	wS2guuzMw3TwRME4wggbb2kikj4a2qkYzIhz5yvHCd8r9V5kS5J6GaBmEUdU/hTkJpGp
	WB2rf3/3Cl58ZjjKnzYawH2xoBcq1eJpNiJ6hH7thco7Zr58UHnn1VgMAOHYbo4TwcIT
	UVnQ==
X-Gm-Message-State: AA+aEWas9MY87bhp89qmtM/kI6jR0C3i0lcNEEQDoSnfDs8N4NGEZ3cs
	E4sDLhOGfzGkZ3s+G2bJT3+4U6Vm
X-Google-Smtp-Source: AFSGD/WRn/NdASDLLSku2sjo5R1ue8GAYY0C9DPzyloxdDS8FXl4KMG4wkVK6mhdsH4eiuMHtDHWxg==
X-Received: by 2002:a24:2f08:: with SMTP id j8mr3554266itj.42.1545147069873;
	Tue, 18 Dec 2018 07:31:09 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:08 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:53 -0600
Message-Id: <20181218153101.9212-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 02/10] bitbake: persist_data: Close databases across fork
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:09 -0000
Content-Transfer-Encoding: 8bit

sqlite gets really angry if a database is open across a fork() call,
and will give all sorts of messages ranging from I/O errors to database
corruption errors. To deal with this, close all database connections
before forking, and reopen them (lazily) on the other side.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 4468facd18f..27ffb1ddaa4 100644
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
@@ -305,4 +329,10 @@ def persist(domain, d):
 
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
2.19.2


