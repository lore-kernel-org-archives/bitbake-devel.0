Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9C7C77B7A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 13:22:00 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.31406.1685625712833902166
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Jun 2023 06:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=dxSfhJDu;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
X-GND-Sasl: michael.opdenacker@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1685625711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=exCrUXg8uN3nXYAuqr1UYOb8VxfdwNP46P5qutniTJU=;
	b=dxSfhJDuCdFZsmcvBvJotxeRmogNSGnSmvxJD8H85Zx5iE6yvkoDGaHuTCi84X90g63b2B
	Sr3bSOpdfO4YuQm4/3BWrmj52Nx3PpSQOxzD6YDtqLWJMLZpv0YxCPFwUhcMua/W5cGGmT
	hEMpwdVA/ui/Ttg8658QH7NckTbHuAM9sPf/jCGJ/0JaGZd5A4qGtN70zorrhv/3yRArC4
	qiRa8BxcEBoaQUbyI0OQpGbWyJXM0vZ7IW3bSxdVlwQzGVyubBNTCXdBZZza/a4jINVJz0
	uCf/Lb249oYDbNAijHj/qSwpBvOa7qOzG6mf8mKnRdyPV4NI9/VH//sU65ZAbg==
X-GND-Sasl: michael.opdenacker@bootlin.com
X-GND-Sasl: michael.opdenacker@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D018AC000B;
	Thu,  1 Jun 2023 13:21:50 +0000 (UTC)
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: document "network" task flag
Date: Thu,  1 Jun 2023 15:21:17 +0200
Message-Id: <20230601132117.2988856-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 01 Jun 2023 13:22:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14826

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This addresses [YOCTO #15127]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b35c332c..58975f4c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1519,6 +1519,12 @@ functionality of the task:
    released. You can use this variable flag to accomplish mutual
    exclusion.
 
+-  ``[network]``: When set to "1", allows a task to access the network. By
+   default, only the ``do_fetch`` task is granted network access. Recipes
+   shouldn't access the network outside of ``do_fetch`` as it usually
+   undermines fetcher source mirroring, image and licence manifests, software
+   auditing and supply chain security.
+
 -  ``[noexec]``: When set to "1", marks the task as being empty, with
    no execution required. You can use the ``[noexec]`` flag to set up
    tasks as dependency placeholders, or to disable tasks defined
-- 
2.34.1


