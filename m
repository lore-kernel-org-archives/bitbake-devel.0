Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EB4C04FFE
	for <webhook@archiver.kernel.org>; Sat, 11 May 2024 11:03:25 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.12405.1715425400275332875
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 May 2024 04:03:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=nE19kYHu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E8FFC0002;
	Sat, 11 May 2024 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715425399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GtxRIPKaNXoiIt6N50JuWAbFzQ/N6lr3/u+WkEfw6M=;
	b=nE19kYHuhXxNRP4R8V+FF/R7gUvyjSUhbm9LD7m4zPyOdHW3DNoH+Xc8xLYv+/HvCzAtTm
	wsR9dRmX/hYXc/BND24QS9MiuWoFM82voM0z2JvAyzO0lrL8kA92FQIJo64/4JHF6MafMF
	U9ZDjzOYMyLhlsXagPiYT0vxlKSO5R22p4wFV63aTde2Se2HHV3Vzm6Q5k45ZSK+GCiglA
	1VUN/Rzpo+cj/QssS5bx/Tcmube3SfcDGVsJmDaOum07vN6C5oevuE908FzU6bb1thq3WP
	s5FTtjB7js6CwvXAntUWw/SHrStMQqUSYdEdGWST2/P3ZbClwRcKJRGOFQl8wA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <jpewhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 5/8] prserv: avoid possible race condition in database code
Date: Sat, 11 May 2024 16:31:32 +0530
Message-Id: <20240511110135.1887578-6-michael.opdenacker@bootlin.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16204

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Remove a possible race condition by allowing a read-only
server to create the PR table anyway. This avoids a failure
if both a read-only and read-write server try to access
an empty database at the same time.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Suggested-by: Joshua Watt <jpewhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/db.py | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index f430586d73..79c9001bf5 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -30,21 +30,18 @@ class PRTable(object):
         self.read_only = read_only
         self.table = table
 
+        # Creating the table even if the server is read-only.
+        # This avoids a race condition if a shared database
+        # is accessed by a read-only server first.
+
         with closing(self.conn.cursor()) as cursor:
-            if self.read_only:
-                table_exists = cursor.execute(
-                            "SELECT count(*) FROM sqlite_master \
-                            WHERE type='table' AND name='%s'" % (self.table))
-                if not table_exists:
-                    raise prserv.NotFoundError
-            else:
-                cursor.execute("CREATE TABLE IF NOT EXISTS %s \
-                            (version TEXT NOT NULL, \
-                            pkgarch TEXT NOT NULL,  \
-                            checksum TEXT NOT NULL, \
-                            value TEXT, \
-                            PRIMARY KEY (version, pkgarch, checksum, value));" % self.table)
-                self.conn.commit()
+            cursor.execute("CREATE TABLE IF NOT EXISTS %s \
+                        (version TEXT NOT NULL, \
+                        pkgarch TEXT NOT NULL,  \
+                        checksum TEXT NOT NULL, \
+                        value TEXT, \
+                        PRIMARY KEY (version, pkgarch, checksum, value));" % self.table)
+            self.conn.commit()
 
     def _extremum_value(self, rows, is_max):
         value = None
-- 
2.34.1


