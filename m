Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1913C77B7E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 12:34:59 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.29860.1685622892095074722
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Jun 2023 05:34:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=pYggDFS2;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1685622890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eg43c7F09s22CYh6O9lqmCGX+9DymEl5PVOO+nbSSNE=;
	b=pYggDFS2VpuZ+YAJCSIXeT+yf4oLgh3ZZzy2dplEwE9lnygT4LXqNYg3lTp8m7LBkOvD+c
	sPCggtcSr1vgoMuglQijMFU5XVV5UTeIOLvvuxP5hXB8MAsciRbA/Aj5EoPCup4DzdQU8Q
	CDpo22kMfk6DN5/G8Gs4iWA0MueeJ2dq0ghhnXeXtNFP17+3efL+luLUb071hT4k7NWNBC
	5SVqShtBnEXWXxwzAtV7f4uFS2PPwYqNC1EmXkdiLi7QrZaV8QF9C/ew+4uBjLnso33weG
	PmzKfBCY+XHP/XPamyisawDrd1Tn+mZDKxQdW2l3FuMvIo0ioP4uMxX4LHqOow==
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40CAFE0003;
	Thu,  1 Jun 2023 12:34:48 +0000 (UTC)
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: update releases.rst
Date: Thu,  1 Jun 2023 14:34:38 +0200
Message-Id: <20230601123438.2984206-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Jun 2023 12:34:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14825

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

- Move "langdale" link to outdated section
- Add link to "mickledore" manual
- Fix typo in "kirkstone" name

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/releases.rst | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index 6a9774d4..b38b1c06 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -4,15 +4,15 @@
 BitBake Supported Release Manuals
 =================================
 
-*****************************
-Release Series 4.1 (langdale)
-*****************************
+*******************************
+Release Series 4.2 (mickledore)
+*******************************
 
-- :yocto_docs:`BitBake 2.2 User Manual </bitbake/2.2/>`
+- :yocto_docs:`BitBake 2.4 User Manual </bitbake/2.4/>`
 
-*****************************
-Release Series 4.0 (kirstone)
-*****************************
+******************************
+Release Series 4.0 (kirkstone)
+******************************
 
 - :yocto_docs:`BitBake 2.0 User Manual </bitbake/2.0/>`
 
@@ -26,6 +26,12 @@ Release Series 3.1 (dunfell)
 BitBake Outdated Release Manuals
 ================================
 
+*****************************
+Release Series 4.1 (langdale)
+*****************************
+
+- :yocto_docs:`BitBake 2.2 User Manual </bitbake/2.2/>`
+
 ******************************
 Release Series 3.4 (honister)
 ******************************
-- 
2.34.1


