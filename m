Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A2DC64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 18:15:25 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.1722.1677521714308585170
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 10:15:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=kXeFf0HD;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 3C3A71C000A;
	Mon, 27 Feb 2023 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677521712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LKibVOuuegZsqzLvQ83T0HPsg1qj0h48kDjq6yksBnQ=;
	b=kXeFf0HDHMb08TVXUyLnv+vEhcq2XBSsCpwzHng9BBgxNZrjvKuJyqDsv1Hpz81zFoI19q
	ZYDmAN68dAAM2v8TzT/QcPGzgY4JjGU9stuJ5lTq/D6vB2ZD9g+ldDwUMOuo4Z1j7kmNSq
	9HV3DFF1JAtkrIfAZvhaStP1CuAz8RF0ZY/v1ZHKtX9QpgzVebWs8E8AE9/ig+/L0Rq49f
	8rcJU/+uB703p280vGi0J9k90uJtYjwWKx+DH61hv2OUIdzdw6xfFILYeTy+M0H3B/yl1K
	f76Q3BkwYesDvvgtsEkK8G1odCiMj7rZ1VuinB18iNH3VGUdNtXXFoZaawsZPA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: fix reference to "Obtaining BitBake" section
Date: Mon, 27 Feb 2023 19:14:57 +0100
Message-Id: <20230227181457.288088-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 18:15:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14504

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

The section making this reference was making a reference to itself
instead of referring to the section in bitbake-user-manual-intro.rst.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-hello.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
index 722dc5a2..ccaef5f8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
@@ -18,7 +18,7 @@ it.
 Obtaining BitBake
 =================
 
-See the :ref:`bitbake-user-manual/bitbake-user-manual-hello:obtaining bitbake` section for
+See the :ref:`bitbake-user-manual/bitbake-user-manual-intro:obtaining bitbake` section for
 information on how to obtain BitBake. Once you have the source code on
 your machine, the BitBake directory appears as follows::
 
-- 
2.37.2


