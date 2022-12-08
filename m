Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0390CC3A5A7
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 10:36:35 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.10192.1670495793476998647
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Dec 2022 02:36:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Se+toktF;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id D820C40005;
	Thu,  8 Dec 2022 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1670495791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IE9J24lq+SeZcVNv8ARG8JfjIdEbAOkiYBllTq+jK1Y=;
	b=Se+toktFV8mbWbWz79nJ+Nu2e9Kg5lJU6ih9aB8TaIvMaPuM05Ftm/6y81Fy/kLc3CDiPS
	PqZo+VIF2WmKJcojx/ORYuyfHT7oT29SCRQy9yITsazj89GxN/4udpKf8AUATJO8LHvgqh
	uzO8ty7c27AxE65LZxjFwFoPJ2s32zb4wqepltOaYCo3Fd06TgDGdzoxNsfm+Z8dMKtYym
	9g/4ngNDhwOKHiNJqJFo6XxSrGq11eyU7lqPOfm0tZGT+r4HRyNuPAHnTIKenWjq7+9w9M
	MQsk5FPqHezKNGwrYSm8OqCyr2lyszEhpf8z+VJDCE30SdSz3RsQE71iE1jKTg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: add reference to bitbake git repository
Date: Thu,  8 Dec 2022 11:36:23 +0100
Message-Id: <20221208103623.1496208-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 10:36:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14149

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

In the HTML page footer.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/_templates/footer.html | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 doc/_templates/footer.html

diff --git a/doc/_templates/footer.html b/doc/_templates/footer.html
new file mode 100644
index 00000000..1398f20d
--- /dev/null
+++ b/doc/_templates/footer.html
@@ -0,0 +1,9 @@
+<footer>
+  <hr/>
+  <div role="contentinfo">
+    <p>&copy; Copyright {{ copyright }}
+       <br>Last updated on {{ last_updated }} from the <a href="https://git.openembedded.org/bitbake/">bitbake</a> git repository.
+    </p>
+  </div>
+</footer>
+
-- 
2.37.2


