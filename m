Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D57C52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 05:47:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web10.10154.1724391999867418793
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Aug 2024 22:46:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: lgo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lgo@pengutronix.de>)
	id 1shN89-0003Ym-T5; Fri, 23 Aug 2024 07:46:37 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lgo@pengutronix.de>)
	id 1shN89-002Psr-Fw; Fri, 23 Aug 2024 07:46:37 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1shN89-000NnL-11;
	Fri, 23 Aug 2024 07:46:37 +0200
From: =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: yocto@pengutronix.de,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH] fetch2/npm: allow the '@' character in package names
Date: Fri, 23 Aug 2024 07:46:34 +0200
Message-Id: <20240823054634.91441-1-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 05:47:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16518

The '@types/ramda' [1] npm package has recently gained a dependency on
the 'types-ramda' [2] npm package. Both have the same version number.

The name mangling results in the tarballs of both packages sharing the same
name, but different contents.

Fix that by accepting '@' as valid character in the package name,
resulting in one package named @types-ramda and one called types-ramda.

[1]: https://www.npmjs.com/package/@types/ramda
[2]: https://www.npmjs.com/package/types-ramda

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 lib/bb/fetch2/npm.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 15f3f19bc..ac76d64cd 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -42,11 +42,12 @@ from bb.utils import is_semver
 
 def npm_package(package):
     """Convert the npm package name to remove unsupported character"""
-    # Scoped package names (with the @) use the same naming convention
-    # as the 'npm pack' command.
+    # For scoped package names ('@user/package') the '/' is replaced by a '-'.
+    # This is similar to what 'npm pack' does, but 'npm pack' also strips the
+    # leading '@', which can lead to ambiguous package names.
     name = re.sub("/", "-", package)
     name = name.lower()
-    name = re.sub(r"[^\-a-z0-9]", "", name)
+    name = re.sub(r"[^\-a-z0-9@]", "", name)
     name = name.strip("-")
     return name
 
-- 
2.39.2


