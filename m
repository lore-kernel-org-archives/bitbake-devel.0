Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0061D7ED16
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Jul 2019 14:16:40 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id k20so82111564ios.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Jul 2019 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GAsD1b39mPsWKgE+EMEBgNALFqpR07QYIhpCeuc+OmU=;
	b=EDFBq5buCfOG+jTIDgwc+1NfgMFtFKKc/sJJQXE8tLzA/yp+AJvsCrLKv8GoRMPTx0
	lzScHZ//TBFuavjRZgtvyntCsJK8eRArmz18uV7V5FTuyz6j5EBw6Kloi+IF1cNRZkyF
	RbhYATcrtcPhtd3w4vj1ZXQWE6qlWFyxc11JR+uo856CJUB3rvD61tSBJUJsheKNf9cl
	I7l3GzSdiZzTbwsOdUFIcEXuizA9Dsw847az6nDHwxmjj739RB6od4gjzJp2JFSsjl0R
	DE2h2awvWI8ztXDqqeaMDib7ulaomzvBBXaTusudMH9dlAPV4iuHeMRai2fj1S9Igoez
	ztPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=GAsD1b39mPsWKgE+EMEBgNALFqpR07QYIhpCeuc+OmU=;
	b=rC+WnI6rHeUgh2R8bpYsfz9TlltPFslXzDP4MY5CxewGrAnTSpz5DSZMmd7Jw6ZiNT
	nScNhjtGf7wmkih8h6BFOdtyNOMbb2f81zOiycYLmcuo5hxaYmpjVB50r74LyWlPZ+gD
	WMKxult7su1hf75gdlgp1nh8V7bSYnFvbILmHizinshxt4aW29ZMNbw4hWI/oS7LQBgf
	QyckxKgp4U+CGro2wdAd5g8UWDv70SzTr1FHBR+z3I85pSC8bj5RKdSSkTTjbuFRqNLC
	twUwTkzZ9vKWOXyXkMwpraBKXnt3+OvCn8xlki7bBELmyX/V4P9GfjNPXkhcFwchBRBI
	/Oyw==
X-Gm-Message-State: APjAAAXatuir0JpcL7VtxCS2LVkP9cm1tnNc4YQyw/fg7bxGr+8J1S6z
	Dsifc/M7AnK5iRWCmkXMAIeKRu1A
X-Google-Smtp-Source: APXvYqyuM/1afeqetyHMpqMnknsGMHsLWHgcoDDA+OVvuhVWkZR32NQ88+om7+5LWrhh97IoI6pd/g==
X-Received: by 2002:a02:a417:: with SMTP id c23mr7873683jal.141.1563891401665; 
	Tue, 23 Jul 2019 07:16:41 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	e26sm36800360iod.10.2019.07.23.07.16.40
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 23 Jul 2019 07:16:40 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Jul 2019 09:16:37 -0500
Message-Id: <20190723141637.23356-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] bitbake: hashserv: SQL Optimizations
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
X-List-Received-Date: Tue, 23 Jul 2019 14:16:41 -0000
Content-Transfer-Encoding: 8bit

Implements a number of optimizations to the SQL used in the hash
equivalence server:

 1) Two indexes are created for the two methods (method, taskhash and
    method outhash) by which rows are found in order to speed up the
    lookup
 2) An extra SELECT to lookup the just inserted row was removed. This
    SELECT is unnecessary since all of the information about the newly
    inserted row is already available.
 3) A uniqueness constraint was added to the table. This should allow
    the server to be multithreaded in the future since duplicate inserts
    can be detected (and ignored). This change requires bumping the
    database version to '2', since a uniqueness constraint can't be
    added to an existing table.
 4) Some comments are added to clarify the trick SELECT statement used
    when inserting new equivalent hashes

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/__init__.py | 37 +++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index fdc9ced9f2b..768c5504cf2 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -1,4 +1,4 @@
-# Copyright (C) 2018 Garmin Ltd.
+# Copyright (C) 2018-2019 Garmin Ltd.
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
@@ -32,7 +32,7 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
 
             d = None
             with contextlib.closing(self.db.cursor()) as cursor:
-                cursor.execute('SELECT taskhash, method, unihash FROM tasks_v1 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1',
+                cursor.execute('SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1',
                         {'method': method, 'taskhash': taskhash})
 
                 row = cursor.fetchone()
@@ -63,15 +63,29 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
 
             with contextlib.closing(self.db.cursor()) as cursor:
                 cursor.execute('''
-                    SELECT taskhash, method, unihash FROM tasks_v1 WHERE method=:method AND outhash=:outhash
+                    -- Find tasks with a matching outhash (that is, tasks that
+                    -- are equivalent)
+                    SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND outhash=:outhash
+
+                    -- If there is an exact match on the taskhash, return it.
+                    -- Otherwise return the oldest matching outhash of any
+                    -- taskhash
                     ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
                         created ASC
+
+                    -- Only return one row
                     LIMIT 1
                     ''', {k: data[k] for k in ('method', 'outhash', 'taskhash')})
 
                 row = cursor.fetchone()
 
+                # If no matching outhash was found, or one *was* found but it
+                # wasn't an exact match on the taskhash, a new entry for this
+                # taskhash should be added
                 if row is None or row['taskhash'] != data['taskhash']:
+                    # If a row matching the outhash was found, the unihash for
+                    # the new taskhash should be the same as that one.
+                    # Otherwise the caller provided unihash is used.
                     unihash = data['unihash']
                     if row is not None:
                         unihash = row['unihash']
@@ -88,18 +102,17 @@ class HashEquivalenceServer(BaseHTTPRequestHandler):
                         if k in data:
                             insert_data[k] = data[k]
 
-                    cursor.execute('''INSERT INTO tasks_v1 (%s) VALUES (%s)''' % (
+                    cursor.execute('''INSERT INTO tasks_v2 (%s) VALUES (%s)''' % (
                             ', '.join(sorted(insert_data.keys())),
                             ', '.join(':' + k for k in sorted(insert_data.keys()))),
                         insert_data)
 
                     logger.info('Adding taskhash %s with unihash %s', data['taskhash'], unihash)
-                    cursor.execute('SELECT taskhash, method, unihash FROM tasks_v1 WHERE id=:id', {'id': cursor.lastrowid})
-                    row = cursor.fetchone()
 
                     self.db.commit()
-
-                d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
+                    d = {'taskhash': data['taskhash'], 'method': data['method'], 'unihash': unihash}
+                else:
+                    d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
 
                 self.send_response(200)
                 self.send_header('Content-Type', 'application/json; charset=utf-8')
@@ -120,7 +133,7 @@ def create_server(addr, db, prefix=''):
 
     with contextlib.closing(db.cursor()) as cursor:
         cursor.execute('''
-            CREATE TABLE IF NOT EXISTS tasks_v1 (
+            CREATE TABLE IF NOT EXISTS tasks_v2 (
                 id INTEGER PRIMARY KEY AUTOINCREMENT,
                 method TEXT NOT NULL,
                 outhash TEXT NOT NULL,
@@ -134,9 +147,13 @@ def create_server(addr, db, prefix=''):
                 PV TEXT,
                 PR TEXT,
                 task TEXT,
-                outhash_siginfo TEXT
+                outhash_siginfo TEXT,
+
+                UNIQUE(method, outhash, taskhash)
                 )
             ''')
+        cursor.execute('CREATE INDEX IF NOT EXISTS taskhash_lookup ON tasks_v2 (method, taskhash)')
+        cursor.execute('CREATE INDEX IF NOT EXISTS outhash_lookup ON tasks_v2 (method, outhash)')
 
     logger.info('Starting server on %s', addr)
     return HTTPServer(addr, Handler)
-- 
2.21.0


