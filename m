Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C8C433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 13:20:31 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web08.26210.1646659229629783376
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 05:20:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lRJqhXP0;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6AD6440010;
	Mon,  7 Mar 2022 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646659227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+WoXv7wGWfHFzGDyet5oTXuJJTJJkV/fo8T3aTJcMxw=;
	b=lRJqhXP0z2rPM5gEMjbbAH7kXafXW44jf3SGXHwTQERQ8J9dsvaTqDZ4uYiglteqFAtxFD
	j/PPGglA7UlygRWxFB0pyd8XDTmz0q6O/nEXXtJTRV4lG+Ty4eezWvASMrPOVV3U8XUkJu
	Dhq1DPC0VbG/VoXprltvTPweeek2OhMoJGGdEzoOV6kkS5lP7/W26TzN2y22BfmXNdFmJY
	RIU6xdQRcqpERPHXUYRR+ucfEbU2VJYidpWrO8uyzK3BZHyjtla6bG7fL+q+PcVV6NBP88
	JVVgXr9c7CQ0a7KXyDi+DsItu7u++2xGJm2FffeNYcfgkZX9rQQVjxz7/hRGGw==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v2] bitbake-user-manual: add recent release manuals
Date: Mon,  7 Mar 2022 14:20:25 +0100
Message-Id: <20220307132025.523940-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 13:20:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13426

Add links corresponding to recent releases
Align the title of sections with yocto-docs' releases.rst

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/releases.rst | 63 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index d68d7159..9a644873 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -1,32 +1,53 @@
 .. SPDX-License-Identifier: CC-BY-2.5
 
-=========================
- Current Release Manuals
-=========================
+===========================
+ Supported Release Manuals
+===========================
+
+******************************
+Release Series 3.4 (honister)
+******************************
+
+- :yocto_docs:`3.4.x BitBake 1.52 User Manual </bitbake/1.52/>`
+
+******************************
+Release Series 3.3 (hardknott)
+******************************
+
+- :yocto_docs:`3.3.x BitBake 1.50 User Manual </bitbake/1.50/>`
 
 ****************************
-3.1 'dunfell' Release Series
+Release Series 3.1 (dunfell)
 ****************************
 
 - :yocto_docs:`3.1 BitBake User Manual </3.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.1 BitBake User Manual </3.1.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.2 BitBake User Manual </3.1.2/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`3.1.3 BitBake User Manual </3.1.3/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`3.1.x BitBake 1.46 User Manual </bitbake/1.46/>`
 
 ==========================
- Previous Release Manuals
+ Outdated Release Manuals
 ==========================
 
+*******************************
+Release Series 3.2 (gatesgarth)
+*******************************
+
+- :yocto_docs:`3.2.x BitBake User Manual </bitbake/1.48/>`
+
 *************************
-3.0 'zeus' Release Series
+Release Series 3.0 (zeus)
 *************************
 
 - :yocto_docs:`3.0 BitBake User Manual </3.0/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.0.1 BitBake User Manual </3.0.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.0.2 BitBake User Manual </3.0.2/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.0.3 BitBake User Manual </3.0.3/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`3.0.4 BitBake User Manual </3.0.4/bitbake-user-manual/bitbake-user-manual.html>`
 
 ****************************
-2.7 'warrior' Release Series
+Release Series 2.7 (warrior)
 ****************************
 
 - :yocto_docs:`2.7 BitBake User Manual </2.7/bitbake-user-manual/bitbake-user-manual.html>`
@@ -36,7 +57,7 @@
 - :yocto_docs:`2.7.4 BitBake User Manual </2.7.4/bitbake-user-manual/bitbake-user-manual.html>`
 
 *************************
-2.6 'thud' Release Series
+Release Series 2.6 (thud)
 *************************
 
 - :yocto_docs:`2.6 BitBake User Manual </2.6/bitbake-user-manual/bitbake-user-manual.html>`
@@ -46,16 +67,16 @@
 - :yocto_docs:`2.6.4 BitBake User Manual </2.6.4/bitbake-user-manual/bitbake-user-manual.html>`
 
 *************************
-2.5 'sumo' Release Series
+Release Series 2.5 (sumo)
 *************************
 
-- :yocto_docs:`2.5 BitBake User Manual </2.5/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.5.1 BitBake User Manual </2.5.1/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.5.2 BitBake User Manual </2.5.2/bitbake-user-manual/bitbake-user-manual.html>`
-- :yocto_docs:`2.5.3 BitBake User Manual </2.5.3/bitbake-user-manual/bitbake-user-manual.html>`
+- :yocto_docs:`2.5 Documentation </2.5>`
+- :yocto_docs:`2.5.1 Documentation </2.5.1>`
+- :yocto_docs:`2.5.2 Documentation </2.5.2>`
+- :yocto_docs:`2.5.3 Documentation </2.5.3>`
 
 **************************
-2.4 'rocko' Release Series
+Release Series 2.4 (rocko)
 **************************
 
 - :yocto_docs:`2.4 BitBake User Manual </2.4/bitbake-user-manual/bitbake-user-manual.html>`
@@ -65,7 +86,7 @@
 - :yocto_docs:`2.4.4 BitBake User Manual </2.4.4/bitbake-user-manual/bitbake-user-manual.html>`
 
 *************************
-2.3 'pyro' Release Series
+Release Series 2.3 (pyro)
 *************************
 
 - :yocto_docs:`2.3 BitBake User Manual </2.3/bitbake-user-manual/bitbake-user-manual.html>`
@@ -75,7 +96,7 @@
 - :yocto_docs:`2.3.4 BitBake User Manual </2.3.4/bitbake-user-manual/bitbake-user-manual.html>`
 
 **************************
-2.2 'morty' Release Series
+Release Series 2.2 (morty)
 **************************
 
 - :yocto_docs:`2.2 BitBake User Manual </2.2/bitbake-user-manual/bitbake-user-manual.html>`
@@ -84,7 +105,7 @@
 - :yocto_docs:`2.2.3 BitBake User Manual </2.2.3/bitbake-user-manual/bitbake-user-manual.html>`
 
 ****************************
-2.1 'krogoth' Release Series
+Release Series 2.1 (krogoth)
 ****************************
 
 - :yocto_docs:`2.1 BitBake User Manual </2.1/bitbake-user-manual/bitbake-user-manual.html>`
@@ -93,7 +114,7 @@
 - :yocto_docs:`2.1.3 BitBake User Manual </2.1.3/bitbake-user-manual/bitbake-user-manual.html>`
 
 ***************************
-2.0 'jethro' Release Series
+Release Series 2.0 (jethro)
 ***************************
 
 - :yocto_docs:`1.9 BitBake User Manual </1.9/bitbake-user-manual/bitbake-user-manual.html>`
@@ -103,7 +124,7 @@
 - :yocto_docs:`2.0.3 BitBake User Manual </2.0.3/bitbake-user-manual/bitbake-user-manual.html>`
 
 *************************
-1.8 'fido' Release Series
+Release Series 1.8 (fido)
 *************************
 
 - :yocto_docs:`1.8 BitBake User Manual </1.8/bitbake-user-manual/bitbake-user-manual.html>`
@@ -111,7 +132,7 @@
 - :yocto_docs:`1.8.2 BitBake User Manual </1.8.2/bitbake-user-manual/bitbake-user-manual.html>`
 
 **************************
-1.7 'dizzy' Release Series
+Release Series 1.7 (dizzy)
 **************************
 
 - :yocto_docs:`1.7 BitBake User Manual </1.7/bitbake-user-manual/bitbake-user-manual.html>`
@@ -120,7 +141,7 @@
 - :yocto_docs:`1.7.3 BitBake User Manual </1.7.3/bitbake-user-manual/bitbake-user-manual.html>`
 
 **************************
-1.6 'daisy' Release Series
+Release Series 1.6 (daisy)
 **************************
 
 - :yocto_docs:`1.6 BitBake User Manual </1.6/bitbake-user-manual/bitbake-user-manual.html>`
-- 
2.25.1


