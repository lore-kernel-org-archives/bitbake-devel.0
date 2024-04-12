Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B0DC46467
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 09:03:02 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.42184.1712912577130436861
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 02:02:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=NuiF9REa;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 08EEA2000E;
	Fri, 12 Apr 2024 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712912575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnS/XMM2EAxboZahss1+koAN4pt6RPYMMv3S5FXrEdo=;
	b=NuiF9REa/GikVWxaSDRyiLtWLFn1lkxl7paK9B4Tc1zZYDpYQxtMDAW9jgxIHIf2uIEU+r
	aYGY7XJ74PlutloRC6xwKxJi9aeyw86L2mCPs7Lz0xzAgjMaMpKcHK1RZfejlCuUn1N5xG
	qic9DwhL1QrLElKVeCfHqdI2XIPpVxNeOLoa9RA7RbSsM1ulFOSeCEbV7IBUoPvt/djtzf
	gJPUETSS2EjDtZZd77urDpSsP6C66fZQfes4OXKzOrrX8FZIp5I45e5gGxSXpVEox2v7nV
	bGdKcnIM65uOa+UN6DeX0/TpSid/EcwgfSmrP2Lseq82rkL9m9anjd55S9rA6Q==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 10/12] prserv: remove unnecessary code
Date: Fri, 12 Apr 2024 11:02:32 +0200
Message-Id: <20240412090234.4110915-11-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 09:03:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16085

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

In db.py, the ifnull() statement guarantees that the SQL request will
return a value. It's therefore unnecessary to test the case when no
value is found.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/db.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 7c200602ed..eb41508198 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -172,11 +172,7 @@ class PRTable(object):
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


