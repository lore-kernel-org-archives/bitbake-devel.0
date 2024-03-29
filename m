Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B9ACD1283
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:28 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.22.1711723223857771072
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=JLUFDxQY;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F10F4E000D;
	Fri, 29 Mar 2024 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcAuSysxNjBs7+HkBokLy2YPGfNy6cxGuQF67J+GqaY=;
	b=JLUFDxQY0BNs+0+Eyk+0+1Hub8DKt7JUZNYZkvDqx9PMLP441tUoiqR2CoeLeVcu/1Zw+B
	jFAJ7CwcrDEbrdt1mhkLa1+1zo33HduTU2WfRvx1lVv23sZsqSWTe+Wzkkfa6X0vzIXE+l
	bM+/qT7GXoC7FkqQOQyAMxSSBCdcpstr52Ik2ram+XlWAxHZLjS8G5ihm2s7TxIwGkD4Do
	0ZTFu8f02TpEMVrxuaKroTNSrcRLojdZzw1UNoz1Z0JhCYIRHWCduuCOhi3OO3apQIefuD
	aIo0ux786QRM58YddjUtWlUaH8f3tkT2tvLtqKy/HHGct+yGhUi1O2IoXteo3g==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 01/12] prserv: simplify the PRServerClient() interface
Date: Fri, 29 Mar 2024 15:39:45 +0100
Message-Id: <20240329143956.1602707-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16023

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

serv.py: simplify the PRServerClient() interface by passing the
server object instead of multiple arguments, and then retrieving
the data through this object.

This replicates what is done for ServerClient() in hashserv/server.py

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 lib/prserv/serv.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5fc8863f70..8b1bdc0250 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -20,16 +20,16 @@ PIDPREFIX = "/tmp/PRServer_%s_%s.pid"
 singleton = None
 
 class PRServerClient(bb.asyncrpc.AsyncServerConnection):
-    def __init__(self, socket, table, read_only):
-        super().__init__(socket, 'PRSERVICE', logger)
+    def __init__(self, socket, server):
+        super().__init__(socket, 'PRSERVICE', server.logger)
+        self.server = server
+
         self.handlers.update({
             'get-pr': self.handle_get_pr,
             'import-one': self.handle_import_one,
             'export': self.handle_export,
             'is-readonly': self.handle_is_readonly,
         })
-        self.table = table
-        self.read_only = read_only
 
     def validate_proto_version(self):
         return (self.proto_version == (1, 0))
@@ -38,10 +38,10 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         try:
             return await super().dispatch_message(msg)
         except:
-            self.table.sync()
+            self.server.table.sync()
             raise
         else:
-            self.table.sync_if_dirty()
+            self.server.table.sync_if_dirty()
 
     async def handle_get_pr(self, request):
         version = request['version']
@@ -50,7 +50,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
 
         response = None
         try:
-            value = self.table.getValue(version, pkgarch, checksum)
+            value = self.server.table.getValue(version, pkgarch, checksum)
             response = {'value': value}
         except prserv.NotFoundError:
             logger.error("can not find value for (%s, %s)",version, checksum)
@@ -67,7 +67,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             checksum = request['checksum']
             value = request['value']
 
-            value = self.table.importone(version, pkgarch, checksum, value)
+            value = self.server.table.importone(version, pkgarch, checksum, value)
             if value is not None:
                 response = {'value': value}
 
@@ -80,7 +80,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         colinfo = request['colinfo']
 
         try:
-            (metainfo, datainfo) = self.table.export(version, pkgarch, checksum, colinfo)
+            (metainfo, datainfo) = self.server.table.export(version, pkgarch, checksum, colinfo)
         except sqlite3.Error as exc:
             logger.error(str(exc))
             metainfo = datainfo = None
@@ -88,7 +88,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         return {'metainfo': metainfo, 'datainfo': datainfo}
 
     async def handle_is_readonly(self, request):
-        return {'readonly': self.read_only}
+        return {'readonly': self.server.read_only}
 
 class PRServer(bb.asyncrpc.AsyncServer):
     def __init__(self, dbfile, read_only=False):
@@ -98,7 +98,7 @@ class PRServer(bb.asyncrpc.AsyncServer):
         self.read_only = read_only
 
     def accept_client(self, socket):
-        return PRServerClient(socket, self.table, self.read_only)
+        return PRServerClient(socket, self)
 
     def start(self):
         tasks = super().start()
-- 
2.34.1


