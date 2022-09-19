Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B109DC6FA86
	for <webhook@archiver.kernel.org>; Mon, 19 Sep 2022 14:58:31 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web08.53.1663599510486944546
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Sep 2022 07:58:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=po2mQk3f;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 2FE021C0002;
	Mon, 19 Sep 2022 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1663599507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y45iuFmajc7JbGljfPRyTpsknHt3+Yl8lug2lubTDh8=;
	b=po2mQk3fphZ06+EzOQLC26eLCSzqBvsAijs7xjsrld3fSMBEP7AIHsd/0Qmar0ngkxuNBZ
	RyIsKAeKUOnGxFCdoma30PnD/I34en1E5eMHD5wAe2+YBJHY2wOUQxO17Z/qpO75QNB5R6
	o3YqIaSTeRSpaE3i94A1TPPlv5gjghfNpsTxLMQquM66ytjd3I7MwA8wQM6GhP/Pta/KH2
	PvOapLfC4nl1sO6Zq6kyC8tIGAQvF4BqXidr+/JxpNBeaTNfCZVTyKupnspoDoA+ykrgtf
	2abxAmyumqPJKvbWTkiy7qZZ+TIsZJ6MjcD99cv5X6UUda6lvkDaog8AbccURw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Aryaman Gupta <aryaman.gupta@windriver.com>,
	Randy Macleod <Randy.Macleod@windriver.com>,
	Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH RESEND v3] doc: bitbake-user-manual: Add definition for
 BB_PRESSURE_MAX variables
Date: Mon, 19 Sep 2022 16:58:12 +0200
Message-Id: <20220919145812.38756-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <17111BB47189E793.5304@lists.yoctoproject.org>
References: <17111BB47189E793.5304@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Sep 2022 14:58:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13981

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

From: Aryaman Gupta <aryaman.gupta@windriver.com>

Add the definitions for the BB_PRESSURE_MAX{CPU|IO|MEMORY} variables in the
bitbake varibales glossary. Further information on how to determine a good
threshold will be added to the Yocto reference manual in a later commit.

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

---

Changes in V3 (Michael Opdenacker):
- Remove reference to Yocto Project manual, not documenting
  the variables yet.
- Fix a typo ("it's" -> "its")
- Simplify syntax (":" followed by "::" replaced by "::"
---
 .../bitbake-user-manual-ref-variables.rst     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 12aef3cb..725e6c2c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -483,6 +483,31 @@ overview of their function and contents.
          You must set this variable in the external environment in order
          for it to work.
 
+   :term:`BB_PRESSURE_MAX_CPU`
+      The threshold for maximum CPU pressure before BitBake prevents the
+      scheduling of new tasks. Once the :term:`BB_PRESSURE_MAX_CPU` threshold
+      is exceeded, new tasks are not started until the pressure subsides to
+      below the threshold. If :term:`BB_PRESSURE_MAX_CPU` is not set, CPU
+      pressure is not monitored. A threshold can be set in ``conf/local.conf``
+      as::
+
+         BB_PRESSURE_MAX_CPU = "500"
+
+   :term:`BB_PRESSURE_MAX_IO`
+      The threshold for maximum IO pressure experienced before BitBake
+      prevents the scheduling of new tasks. The IO pressure is regulated in the
+      same way as :term:`BB_PRESSURE_MAX_CPU`. At this point in time,
+      experiments show that IO pressure tends to be short-lived and regulating
+      just the CPU can help to reduce it.
+
+   :term:`BB_PRESSURE_MAX_MEMORY`
+      The threshold for maximum memory pressure experienced before BitBake
+      prevents the scheduling of new tasks. The memory pressure is regulated in
+      the same way as :term:`BB_PRESSURE_MAX_CPU`. Note that any memory
+      pressure indicates that a system is being pushed beyond its capacity. At
+      this point in time, experiments show that memory pressure tends to be
+      short-lived and regulating just the CPU can help to reduce it.
+
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
       saved into ``${``\ :term:`T`\ ``}``. By default, the
-- 
2.34.1


