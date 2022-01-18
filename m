Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C90C433F5
	for <webhook@archiver.kernel.org>; Tue, 18 Jan 2022 14:32:48 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web11.13392.1642516366896760840
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Jan 2022 06:32:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C0A37240004;
	Tue, 18 Jan 2022 14:32:44 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: stop mentioning the Angstrom
 distribution
Date: Tue, 18 Jan 2022 15:32:42 +0100
Message-Id: <20220118143242.3467811-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Jan 2022 14:32:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13242

Now defunct.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
index 1c31c1f9..35ffb88b 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
@@ -61,10 +61,9 @@ member Chris Larson split the project into two distinct pieces:
 
 Today, BitBake is the primary basis of the
 `OpenEmbedded <https://www.openembedded.org/>`__ project, which is being
-used to build and maintain Linux distributions such as the `Angstrom
-Distribution <http://www.angstrom-distribution.org/>`__, and which is
-also being used as the build tool for Linux projects such as the `Yocto
-Project <https://www.yoctoproject.org>`__.
+used to build and maintain Linux distributions such as the `Poky
+Reference Distribution <https://www.yoctoproject.org/software-item/poky/>`__,
+developed under the umbrella of the `Yocto Project <https://www.yoctoproject.org>`__.
 
 Prior to BitBake, no other build tool adequately met the needs of an
 aspiring embedded Linux distribution. All of the build systems used by
-- 
2.25.1


