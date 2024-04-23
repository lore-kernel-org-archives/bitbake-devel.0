Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD724C4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 18:27:45 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web10.2703.1713896855846006464
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 11:27:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YC0Pi5V+;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7daa6bfe4c8so125086639f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713896853; x=1714501653; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HTc+sEwEgKikbGg8yBmYlX7d0o8ECc0IMvkizkLypQ=;
        b=YC0Pi5V+09d1sH8WR14yvbM5z+6zxHthi+CmQMwMzxqfq3AQgiJNKzhW/E/G6Hu1WG
         XgTbeI59Jb5vl/wSWQujBhugUhGrmLJkzQULFG/eXXDKzXUegKJNceIMvLT95psLuXpH
         BaF8GW2RUztRNH2J1WSWGP5zZi16Dvfn5h2TiTAt1BDpNmkvC0W18/1CXJzFlzI4H9P7
         T2C/s6xSxQ9kqp6FmQ3oxV3i8NmOn8F1n32l/1M/EItSbkvXT6PfTUca1wjTFquCXzpO
         cjID+ntpMZYx7Lsm2N17iuw+swZSwixMLtWe5kBjMbR7937c5SYBS1UxsVct+vN4Yx3w
         6s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713896853; x=1714501653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HTc+sEwEgKikbGg8yBmYlX7d0o8ECc0IMvkizkLypQ=;
        b=JANVGSTiRc9PILeNASZyBWT0FdnsY6oWXsM22fK4HmrvzKaHFaXCs9h8K1FPDU8RzO
         Gry2pLEGx3rP8mBwRml05xNil2xF7d9CR8Cr3i7zVcc50x99FqQjLJBHY1aR4h6AnphI
         nmy539pxCoV84IgwchI9bv5iuWVAcZ6FF/JWiLOAvk9Id3Xv+xYtRAaQ7MZRkHXZbDVn
         Uimb9GxDCQqYBBs4I+bWYOX81qA7gMV09a9/Y7Lpra7JtoPf3m7cVPLgtg91NBy6iUS2
         lM5YwhAGMKa56Y7wwZKES4dfhkuey7N5CuZ1pJ1+mx+i4WWfPalt38/q4rfbjfZsFZa7
         obPg==
X-Gm-Message-State: AOJu0Yy9nlnRVXcAEYZdRr4pIJ7R2kUNb88duFpCMGmuD/VQj6gVnXAE
	QhBXX1UMPKSsAQ4KGDNhzgNfjPh6w/GN1WcMyzoQXTti+5kBgZtltVQd5Q==
X-Google-Smtp-Source: AGHT+IHAeynT592unL0hjOyYulO7+TuoHXp2QZZUhMxFxWNoqgbZxGIndAjzzQtFf04upjvIJM+FMg==
X-Received: by 2002:a6b:7d48:0:b0:7da:bc23:ac16 with SMTP id d8-20020a6b7d48000000b007dabc23ac16mr275364ioq.14.1713896853532;
        Tue, 23 Apr 2024 11:27:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::d802])
        by smtp.gmail.com with ESMTPSA id u16-20020a056638305000b004830b70971asm3779844jak.122.2024.04.23.11.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:27:32 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2] prserv: Enable database sharing
Date: Tue, 23 Apr 2024 12:27:29 -0600
Message-Id: <20240423182729.226345-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423182543.226113-1-JPEWhacker@gmail.com>
References: <20240423182543.226113-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 18:27:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16136

sqlite3 can allow multiple processes to access the database
simultaneously, but it must be opened correctly. The key change is that
the database is no longer opened in "exclusive" mode (defaulting to
shared mode). In addition, the journal is set to "WAL" mode, as this is
the most efficient for dealing with simultaneous access between
different processes. In order to keep the database performance,
synchronous mode is set to "off". The WAL journal will protect against
incomplete transactions in any given client, however the database will
not be protected against unexpected power loss from the OS (which is a
fine trade off for performance, and also the same as the previous
implementation).

Finally, the _execute() API now uses a database cursor. The cursor
automatically makes sure that the query happens in an atomic transaction
and commits when finished.

NOTE: THIS MAY BE INCOMPLETE; All APIs need to be evaluated to see if
the transaction (cursor) needs to cover mode than one "execute"
statement.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/prserv/db.py | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index b4bda7078cd..8ee8d458194 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -9,6 +9,7 @@ import os.path
 import errno
 import prserv
 import time
+from contextlib import closing
 
 try:
     import sqlite3
@@ -62,21 +63,18 @@ class PRTable(object):
         end = start + 20
         while True:
             try:
-                return self.conn.execute(*query)
+                with closing(self.conn.cursor()) as cursor:
+                    return cursor.execute(*query)
             except sqlite3.OperationalError as exc:
                 if 'is locked' in str(exc) and end > time.time():
                     continue
                 raise exc
 
     def sync(self):
-        if not self.read_only:
-            self.conn.commit()
-            self._execute("BEGIN EXCLUSIVE TRANSACTION")
+        pass
 
     def sync_if_dirty(self):
-        if self.dirty:
-            self.sync()
-            self.dirty = False
+        pass
 
     def _getValueHist(self, version, pkgarch, checksum):
         data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
@@ -292,11 +290,10 @@ class PRData(object):
                 raise e
         uri = "file:%s%s" % (self.filename, "?mode=ro" if self.read_only else "")
         logger.debug("Opening PRServ database '%s'" % (uri))
-        self.connection=sqlite3.connect(uri, uri=True, isolation_level="EXCLUSIVE", check_same_thread = False)
+        self.connection=sqlite3.connect(uri, uri=True)
         self.connection.row_factory=sqlite3.Row
-        if not self.read_only:
-            self.connection.execute("pragma synchronous = off;")
-            self.connection.execute("PRAGMA journal_mode = MEMORY;")
+        self.connection.execute("pragma synchronous = off;")
+        self.connection.execute("PRAGMA journal_mode = WAL;")
         self._tables={}
 
     def disconnect(self):
-- 
2.34.1


