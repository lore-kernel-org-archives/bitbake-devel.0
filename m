Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F63C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 10:36:42 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.24842.1646649395589855414
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 02:36:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=pkGLt/pI;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BA0D840002;
	Mon,  7 Mar 2022 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646649393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6ebbULTGLmJYwya0XSeQTsToV719pvEcSCSkJjnr7OA=;
	b=pkGLt/pIDZhaGHcQqMkCLmy190M2ZTP0z6aRG3zm4rKzg7GnJ83FTtSbJDChfjM3nd24yI
	21JdAoT12Q5i3mhtn72MKaOIZAipW89iugblWm76oULJiAL/TKWNvoJ4M3OZCkFfMJ4gym
	JlhzWWWBDC7+F4AxS24WmpOqrpbk5rgvTaUCczMuOnzSEeUrNfEI30242S3NE4LBgqmsYN
	KuRnMlQWRz0vYB31shOrNltj5fJjKalH8Up53w6d4vIWxgFFXFGoTG0aWS23RyRyYDtXoC
	g9Z5kowiSrhtUWw1ZjfHsrk9GR+Z1XPi2Y742M+7YYOTRDfAQPh77tC7PvUO5A==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH RESEND] bitbake-user-manual: stop mentioning the Angstrom
 distribution
Date: Mon,  7 Mar 2022 11:36:26 +0100
Message-Id: <20220307103626.517820-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 10:36:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13423

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


