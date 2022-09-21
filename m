Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BFFC32771
	for <webhook@archiver.kernel.org>; Wed, 21 Sep 2022 12:37:32 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web09.5729.1663763848560336336
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Sep 2022 05:37:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ET3iyH7r;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4AE8810000C;
	Wed, 21 Sep 2022 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1663763846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tgDxOgxW2D07KDc5T+FDv8XGUV3YAwuHdF8+rGGxtqE=;
	b=ET3iyH7r2Wnh2Bn1vnYf59wo16yaMX+Vxy1qHcFieeAI2hDQ/ApSoU+4u67He9z9zhjHGs
	rwWAelRD2AinQemfHJSjX0gIl82I+KS+MmFpivcGj6IQHO57du5rFGiTsIvirdyiTt5Kwl
	ZIUraOjNV2HGCx1BDonqgZohRwj3/KlfzYwr2K1gOCP6ooTOZ77P5wAHywQr7XPKFuv9yE
	ENm8BWiYU/2ZoegKxam+ADZhiNgLB9fkwR/2U409GASnW4meY6Tx8aTlrCFrX3FlJgDtl+
	9K2eDGNq3j5MFxR/yO9VGGmCe/xfYQNGkWx2INRgCtW7E7Dl0LUnxRU4pET+dA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: mention pydevshell in OE
Date: Wed, 21 Sep 2022 14:36:54 +0200
Message-Id: <20220921123654.104747-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Sep 2022 12:37:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13987

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 33782161..af994719 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1922,6 +1922,15 @@ looking at the source code of the ``bb`` module, which is in
 the commonly used functions ``bb.utils.contains()`` and
 ``bb.utils.mkdirhier()``, which come with docstrings.
 
+Testing and Debugging BitBake Python code
+-----------------------------------------
+
+The OpenEmbedded build system implements a convenient ``pydevshell`` target which
+you can use to access the BitBake datastore and experiment with your own Python
+code. See :yocto_docs:`Using a Python Development Shell
+</dev-manual/common-tasks.html#using-a-python-development-shell>` in the Yocto
+Project manual for details.
+
 Task Checksums and Setscene
 ===========================
 
-- 
2.34.1


