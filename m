Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F0CD1283
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:38 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.34.1711723229161607166
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=SmVEtKZX;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB5701BF208;
	Fri, 29 Mar 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uthPN0jwdMaTY5ZEVk3jHfzsliVnONZ7KSDMw0YcN6w=;
	b=SmVEtKZXZ0E63Hb6K1gkCrmSpI4gPhO1UcT4c9DmdvIwhQ1d6itrD8onASedbT2/eubp+b
	0EW/knAC3p/FGgUg2kWM0RVi3Bo/ob0y6FtkODhL5D1AJKCJFhvddBo2Rsqg7k384XQu8R
	i6i/H2R0OhnUNtKXzqY5D6NzRHWQNMXoNwoeK8pG02hY1MbER1gdGRteVIxMx2rMpnlBar
	Yb6GJYtbIwDU2nU7JAn+yBBanFOaoyUqoiaPa0e+80ZNh4erwD1bMVM+g9TBTEmyoQ8yU3
	MVR72INsWVhY2ed9Fky8X0kIr1KfzW7d6jQo1vR3v2W3p36H69UIymW8iJCVww==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 11/12] prserv: remove unnecessary code
Date: Fri, 29 Mar 2024 15:39:55 +0100
Message-Id: <20240329143956.1602707-12-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16033

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

In db.py, the ifnull() statement guarantees that the SQL request will
return a value. It's therefore unnecessary to test the case when no
value is found.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 lib/prserv/db.py | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 14b36ea6c9..fddea923de 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -135,11 +135,7 @@ class PRTable(object):
             if self.read_only:
                 data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
                                    (version, pkgarch))
-                row = data.fetchone()
-                if row is not None:
-                    return row[0]
-                else:
-                    return 0
+                return data.fetchone()[0]
 
             try:
                 self._execute("INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
@@ -172,11 +168,7 @@ class PRTable(object):
             if self.read_only:
                 data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
                                    (version, pkgarch))
-                row = data.fetchone()
-                if row is not None:
-                    return row[0]
-                else:
-                    return 0
+                return data.fetchone()[0]
 
             try:
                 self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
-- 
2.34.1


