Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA5C25B10
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 17:15:41 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.21665.1714497337817769415
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 10:15:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=SqxHn11k;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 488DFFF804;
	Tue, 30 Apr 2024 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714497336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3wQKXgZzP30OmOUXKmT7rHM/gRMcV/K5giGfMjDUDk=;
	b=SqxHn11khdE9w5V8HcBAYGtpFyk6cbHXgeOh2IUxmzjBG74K7HarNGFzSyX57DnQG/nFDi
	j4Or6Cxdk7++sizDf+hbr3h03CB2Eidl59HXVp3fNSH0zcxV8gWK5CcS+JsQcre3g/jDLQ
	7UFe98Z1edXALJc2xswJ49OqDw8anYEDvgOh5XRah2JNIQ5vgTD3Pa9XQA0Ghz7Etm+3Pu
	6z1w3sKxg2SHYeaoQ6nCX018TE/YtCasNfKlftMPuMiAp2A9wTqbh4w7LmHXKZCQHisfe2
	BH07TP5AzIIlPfQ9dCRdFA96ghOV+4sfMa/ZrNdUVG6Kc6AqAvnmlU8A4B+bAA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 7/8] prserv: import simplification
Date: Tue, 30 Apr 2024 19:15:11 +0200
Message-Id: <20240430171512.936371-8-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430171512.936371-1-michael.opdenacker@bootlin.com>
References: <20240430171512.936371-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 17:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16172

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Simplify the importone() hook:
- to make it independent from the "history" mode which is
  client specific.
- remove the "history" parameter
- we want all values to be imported for binary
  reproducibility purposes.
- using the store_value() function (which warrants
  you don't save the same value twice and doesn't write
  when you're using a read-only server) is enough.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/client.py |  4 +--
 lib/prserv/db.py     | 64 +++-----------------------------------------
 lib/prserv/serv.py   |  3 +--
 3 files changed, 6 insertions(+), 65 deletions(-)

diff --git a/lib/prserv/client.py b/lib/prserv/client.py
index 565c6f3872..9f5794c433 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -42,9 +42,9 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
         if response:
             return response["value"]
 
-    async def importone(self, version, pkgarch, checksum, value, history=False):
+    async def importone(self, version, pkgarch, checksum, value):
         response = await self.invoke(
-            {"import-one": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "value": value, "history": history}}
+            {"import-one": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "value": value}}
         )
         if response:
             return response["value"]
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 88ed8e2125..2da493ddf5 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -192,67 +192,9 @@ class PRTable(object):
             self.store_value(version, pkgarch, checksum, value)
         return value
 
-    def _import_hist(self, version, pkgarch, checksum, value):
-        if self.read_only:
-            return None
-
-        val = None
-        with closing(self.conn.cursor()) as cursor:
-            data = cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                           (version, pkgarch, checksum))
-            row = data.fetchone()
-            if row is not None:
-                val=row[0]
-            else:
-                #no value found, try to insert
-                try:
-                    cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
-                               (version, pkgarch, checksum, value))
-                except sqlite3.IntegrityError as exc:
-                    logger.error(str(exc))
-
-                self.conn.commit()
-
-                data = cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                           (version, pkgarch, checksum))
-                row = data.fetchone()
-                if row is not None:
-                    val = row[0]
-        return val
-
-    def _import_no_hist(self, version, pkgarch, checksum, value):
-        if self.read_only:
-            return None
-
-        with closing(self.conn.cursor()) as cursor:
-            try:
-                #try to insert
-                cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
-                               (version, pkgarch, checksum, value))
-            except sqlite3.IntegrityError as exc:
-                #already have the record, try to update
-                try:
-                    cursor.execute("UPDATE %s SET value=? WHERE version=? AND pkgarch=? AND checksum=? AND value<?"
-                                  % (self.table),
-                                   (value, version, pkgarch, checksum, value))
-                except sqlite3.IntegrityError as exc:
-                    logger.error(str(exc))
-
-                self.conn.commit()
-
-            data = cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
-                            (version, pkgarch, checksum, value))
-            row=data.fetchone()
-            if row is not None:
-                return row[0]
-            else:
-                return None
-
-    def importone(self, version, pkgarch, checksum, value, history=False):
-        if history:
-            return self._import_hist(version, pkgarch, checksum, value)
-        else:
-            return self._import_no_hist(version, pkgarch, checksum, value)
+    def importone(self, version, pkgarch, checksum, value):
+        self.store_value(version, pkgarch, checksum, value)
+        return value
 
     def export(self, version, pkgarch, checksum, colinfo, history=False):
         metainfo = {}
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index fd673b1851..d3ee43dcb5 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -180,9 +180,8 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             pkgarch = request["pkgarch"]
             checksum = request["checksum"]
             value = request["value"]
-            history = request["history"]
 
-            value = self.server.table.importone(version, pkgarch, checksum, value, history)
+            value = self.server.table.importone(version, pkgarch, checksum, value)
             if value is not None:
                 response = {"value": value}
 
-- 
2.34.1


