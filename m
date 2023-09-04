Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A42C71153
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 17:54:26 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.3125.1693850057250318963
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Sep 2023 10:54:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=KIyw8e9X;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9DF0A20007;
	Mon,  4 Sep 2023 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1693850055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U2mVYUpKktpJDOLKeEFnWHNiL3rBZ/Nlx2sKFWTPt4A=;
	b=KIyw8e9XuZLAlqZrCs5BlXu3LwU5hs37QupZbu5/fgS1dZitGgzN0ajvh1rDen0R14PRvF
	dyWjO5Hlp1jU5SUos8TDgFhBwc9QeLtNLCuggc2yv1vS8D6d9S3PE9aZEccWr7rIhELrQV
	jfYYoQH4BPUcOA128MIwGxXhESiQHd94X79UeM6HTevWnbhddH5crvbTxyTzRnODSiuV01
	XWZIObJ8sXvkzdEVcAf6dRT+QFruyHA/j5U0/ADj+Zdlm61+zrnNwDGKR89s4REN6yfWAY
	N1VC0kfWHLgWNI/JxeL3FNqruNH/RXcWDBSlIH5aMBt5uBj/FRfLTRyzP7xbdA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: remove reference to SSTATE_MIRRORS variable
Date: Mon,  4 Sep 2023 19:53:52 +0200
Message-Id: <20230904175352.52769-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 17:54:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15012

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This variable is implemented in OE-Core, and therefore
only documented in the Yocto Project manual.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f5723d67..ec3797db 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -707,8 +707,9 @@ The fetcher requires that the machine has valid credentials for accessing the
 chosen bucket. Instructions for authentication can be found in the
 `Google Cloud documentation <https://cloud.google.com/docs/authentication/provide-credentials-adc#local-dev>`__.
 
-The fetcher can be used for fetching sstate artifacts from a GCS bucket by
-specifying the :term:`SSTATE_MIRRORS` variable as shown below::
+If it used from the OpenEmbedded build system, the fetcher can be used for
+fetching sstate artifacts from a GCS bucket by specifying the
+``SSTATE_MIRRORS`` variable as shown below::
 
    SSTATE_MIRRORS ?= "\
        file://.* gs://<bucket name>/PATH \
-- 
2.34.1


