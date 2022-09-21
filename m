Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FF6C6FA8E
	for <webhook@archiver.kernel.org>; Wed, 21 Sep 2022 13:31:32 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.6424.1663767088128925762
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Sep 2022 06:31:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=U7ZkhVnv;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 2A22E2000D;
	Wed, 21 Sep 2022 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1663767085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KLhFqTB9eo3VSNMhsQs/1i6DdEj4QTc/ghKe37c04GU=;
	b=U7ZkhVnvAchjd7vLCUTn2IA2U2vxYQNZOyLuXUw2a6OOxByEdoHh6WYZCj2KbQPnv5TiUp
	1aaHxXNwu6Ysibb5rFCVHL4R9fNA46v3Hg320irreKVcZ9Jj9WKGDxs1dH/9aMeg4uJZWW
	Bl3UBThAFV/pwilh+gqurHSFasM3C+f86k26I5g4QI0O6GqNaaciqJJJWcjFtTpFME8vPb
	vPP+1szaVu/mBdk9f0cK+fDPQGuAKHfUN6puno4W4fDzJHs6GU6pcEh0KLkAA302kUEJv3
	OX0BkL0olml0r58t1LS0qIpEKW8+n6t3N0H2O3UVmNApHqA920ZmvJYpufmndw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: details about variable flags starting
 with underscore
Date: Wed, 21 Sep 2022 15:31:18 +0200
Message-Id: <20220921133118.109417-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Sep 2022 13:31:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13988

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Fixes [YOCTO #14140]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 33782161..94e457f3 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -421,6 +421,12 @@ documentation to a BitBake variable as follows::
 
    CACHE[doc] = "The directory holding the cache of the metadata."
 
+.. note::
+
+   Variable flag names starting with an underscore (``_``) character
+   are allowed but are ignored by ``d.getVarFlags("VAR")``
+   in Python code. Such flag names are used internally by BitBake.
+
 Inline Python Variable Expansion
 --------------------------------
 
-- 
2.34.1


