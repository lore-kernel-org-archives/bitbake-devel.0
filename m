Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747CDC1746D
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 09:38:01 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.14343.1713865073045725762
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 02:37:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=GRE1I3b/;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7BDDC1C0002;
	Tue, 23 Apr 2024 09:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713865071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u09emhaXKV5iICXwpx7ouC+ZCuFahsiRJA8xCLUeEug=;
	b=GRE1I3b/cIoP9RGq9XbTLKB02EoS2OP/tUTSBOrb/4W16O2sF/CaU3b60keAoY+vfuBt4H
	iKzxbP4AFz4P1+EvJW7IAwz3pb3ahpK4DAUd40G/hWS6FfMsE/eJdKZn/BNwPus3LNpP0R
	2lP5aHxyNLCHvW/c7y1Z8IEqs+0PIiUWX5SGCq1eRAUJ4pG8CJ8gkuNkMlehI6klDbN0wo
	hBmk6iVgMZAH/CGENskGLDp04PnOSEfHBe/1K68oYTvRedcXEVM0gd4Up/bf4z10ywp9Ib
	IXQB+GrInI2i7wxnNEHV0xfiQVK1sYrtyTE47ja50OqeKyKKljvv5TG4Car9wg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 4/5] prserv: sync the database after each change
Date: Tue, 23 Apr 2024 11:37:38 +0200
Message-Id: <20240423093739.364140-5-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423093739.364140-1-michael.opdenacker@bootlin.com>
References: <20240423093739.364140-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 09:38:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16127

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This removes the need for a "dirty" flag and simplifies the code.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/db.py   | 13 ++++---------
 lib/prserv/serv.py |  3 ---
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 8a613d106a..598f015138 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -37,7 +37,6 @@ class PRTable(object):
     def __init__(self, conn, table, read_only):
         self.conn = conn
         self.read_only = read_only
-        self.dirty = False
         self.table = table
 
         if self.read_only:
@@ -53,6 +52,7 @@ class PRTable(object):
                         checksum TEXT NOT NULL, \
                         value TEXT, \
                         PRIMARY KEY (version, pkgarch, checksum, value));" % self.table)
+            self.sync()
 
     def _execute(self, *query):
         """Execute a query, waiting to acquire a lock if necessary"""
@@ -71,11 +71,6 @@ class PRTable(object):
             self.conn.commit()
             self._execute("BEGIN EXCLUSIVE TRANSACTION")
 
-    def sync_if_dirty(self):
-        if self.dirty:
-            self.sync()
-            self.dirty = False
-
     def test_package(self, version, pkgarch):
         """Returns whether the specified package version is found in the database for the specified architecture"""
 
@@ -167,7 +162,7 @@ class PRTable(object):
         except sqlite3.IntegrityError as exc:
             logger.error(str(exc))
 
-        self.dirty = True
+        self.sync()
 
     def _get_value(self, version, pkgarch, checksum, history):
 
@@ -216,7 +211,7 @@ class PRTable(object):
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
-            self.dirty = True
+            self.sync()
 
             data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
@@ -242,7 +237,7 @@ class PRTable(object):
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
-        self.dirty = True
+        self.sync()
 
         data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
                             (version, pkgarch, checksum, value))
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index b4447912a8..b39957f936 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -44,8 +44,6 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         except:
             self.server.table.sync()
             raise
-        else:
-            self.server.table.sync_if_dirty()
 
     async def handle_test_pr(self, request):
         '''Finds the PR value corresponding to the request. If not found, returns None and doesn't insert a new value'''
@@ -233,7 +231,6 @@ class PRServer(bb.asyncrpc.AsyncServer):
         return tasks
 
     async def stop(self):
-        self.table.sync_if_dirty()
         self.db.disconnect()
         await super().stop()
 
-- 
2.34.1


