Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C80C25B75
	for <webhook@archiver.kernel.org>; Sat, 11 May 2024 11:03:25 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.12294.1715425404695609344
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 May 2024 04:03:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bBdKVppQ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49BA340004;
	Sat, 11 May 2024 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715425403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoQbZoRO+6uY2CILaBtuqnVI4zezx0rUWnRLlmd21v0=;
	b=bBdKVppQWLr/yqZOn+bwyt2lVI4WpNME57Kv2WoLUBz2cHCQ72f9Z7IP41GxAUr9LRM2Vj
	E7g+RNtEnJF3FZcSxJ4M2Pdmh8aKnb8baPQ2YHq30TraXI3uC1IUWkEicD+9199qSPug3n
	b8we7dzbPK4/Ar7A9LGEwBPPAbiRpldSQiFlZOLlRuwVygBhkMURcF1F4u56jkv1z+Hdx9
	6A7A25y1icF2BuT51qlivV1VTD4eS3whulLpchMK4y0gtnggpAAC4lb7aCPtvstJpSmWyU
	2nRpjeWMj+F5g8CkcHmDn8XOv2qwR/KxyinpFOVxfoAkkZFO8AQD04GrrKfiJQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 6/8] prserv: store_value() improvements
Date: Sat, 11 May 2024 16:31:33 +0530
Message-Id: <20240511110135.1887578-7-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
References: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 May 2024 11:03:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16205

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Add a test_checksum_value() to test whether
a (version, pkgarch, checksum, value) entry already
exists in the database.

This is used to protect the store_value() function from
an error when trying to store a duplicate entry in the database.

Also check whether the current database is open in read-only mode.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/db.py | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 79c9001bf5..88ed8e2125 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -78,6 +78,18 @@ class PRTable(object):
             else:
                 return False
 
+    def test_checksum_value(self, version, pkgarch, checksum, value):
+        """Returns whether the specified value is found in the database for the specified package, architecture and checksum"""
+
+        with closing(self.conn.cursor()) as cursor:
+            data=cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=? and checksum=? and value=?;" % self.table,
+                               (version, pkgarch, checksum, value))
+            row=data.fetchone()
+            if row is not None:
+                return True
+            else:
+                return False
+
     def test_value(self, version, pkgarch, value):
         """Returns whether the specified value is found in the database for the specified package and architecture"""
 
@@ -143,15 +155,13 @@ class PRTable(object):
                 return base + ".0"
 
     def store_value(self, version, pkgarch, checksum, value):
-        """Store new value in the database"""
+        """Store value in the database"""
 
-        with closing(self.conn.cursor()) as cursor:
-            try:
+        if not self.read_only and not self.test_checksum_value(version, pkgarch, checksum, value):
+            with closing(self.conn.cursor()) as cursor:
                 cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
                            (version, pkgarch, checksum, value))
-            except sqlite3.IntegrityError as exc:
-                logger.error(str(exc))
-            self.conn.commit()
+                self.conn.commit()
 
     def _get_value(self, version, pkgarch, checksum, history):
 
-- 
2.34.1


