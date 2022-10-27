Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4EEECAAA1
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 14:08:29 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web10.6930.1666879702778476507
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Oct 2022 07:08:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fhAim7lJ;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 114DE240006;
	Thu, 27 Oct 2022 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1666879701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ut/NU3g6ZYfnuwKAmSSqmY2z+oPyaHaqAH5hpuNfoRg=;
	b=fhAim7lJ/++7izFmzYbyyssq3/ko1Jnms6PQLKubsmpNJOwnwyeg2aBFX2HpJv8KhEHch6
	YkMf/zMgf83QJ0w9m4fCL46U5oREqkg3ZWe7ZSaiHrNFL+MiCpwZoMy0SG+vQS2RINMN7v
	dzvpxmJohlcCUwrvk0he4yHU/ISoFO2O+A2YzAX5N0A8KJStG/xP23vLsETznLyymyHPTG
	vXBulGzGmd4dvN53vadvy3CS/18EepgbBS1zyo/79KazvKGggKL2NJTGcXmmYr0qViz0+Q
	oEw9R20Nz0av9YxPtdK+NpFJ2N7lKal/sNYgT+csc2mt2VaGENw3IYtIX7TcLQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH RESEND] bitbake-user-manual: details about variable flags starting with underscore
Date: Thu, 27 Oct 2022 16:08:07 +0200
Message-Id: <20221027140808.46669-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Oct 2022 14:08:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14053

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Fixes [YOCTO #14140]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b533d9dc..b7c3d809 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -422,6 +422,12 @@ documentation to a BitBake variable as follows::
 
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


