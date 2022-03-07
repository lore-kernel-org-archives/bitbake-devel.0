Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9518C433FE
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 16:50:44 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web08.199.1646671843033915177
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 08:50:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=aYarVVmp;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 583B724000D;
	Mon,  7 Mar 2022 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646671840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dEBDeZMkZWv4TwOwIO9aD1RT8KWpJr0H6NUYEW3qpDY=;
	b=aYarVVmp+xootbusLdmdD/U1TxYMHz12y7GUJILWnOaQ7zG1E7dEMKveXC4jc1/gQ4Dgz3
	2H7t6shfrnySPNdop3JzVgAs7OxbE+qY4cjvpbGfJDBXx2C79h0nDAfoWahlbWA/ez3vjX
	CVgZxOH0PLPCxllFyjh8BSl/P8GdD5XsUXHH4iQMv1YwX+uucMoXneBsn/JSaX2ts9hkJH
	1Xg1BPcBB1ZxjClymbx7KaL6HZ0qTYYXis6+dIbb+Rr53eO1WC+ziMjkqfVb1hixO/L3S/
	bzkoqc4SyTz6B+QgCp7FmLlNWSqxUMl3Wtp5VIqC1TZWNWKqmXvoat9rOnP99w==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: yet another overrides syntax update
Date: Mon,  7 Mar 2022 17:50:36 +0100
Message-Id: <20220307165036.532204-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 16:50:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13436

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b90e5cf0..714632f9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -530,7 +530,7 @@ variable.
    variable lists three overrides: "architecture", "os", and "machine".
    The variable ``TEST`` by itself has a default value of "default". You
    select the os-specific version of the ``TEST`` variable by appending
-   the "os" override to the variable (i.e. ``TEST_os``).
+   the "os" override to the variable (i.e. ``TEST:os``).
 
    To better understand this, consider a practical example that assumes
    an OpenEmbedded metadata-based Linux kernel recipe file. The
-- 
2.25.1


