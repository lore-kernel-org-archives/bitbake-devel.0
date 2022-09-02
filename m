Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59007C6FA82
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 17:36:47 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.1512.1662140197595546379
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Sep 2022 10:36:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=cRw73AY0;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5CDC8E0009;
	Fri,  2 Sep 2022 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1662140196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aepDvLtfvDsxSfnGlfUoeTokwIMnBl1X3fUI0JbJg+o=;
	b=cRw73AY0qug3n6i+NlvNcMm8Tedj4xjvhccQTKFXOXloiFVOffrLoZ5N5oKAtsocwFEjz3
	CMn8ftLatssc1Ow1he6+k2x6/4pKEtdcSufjrOQHaWcdYY56+teslTZ6d8C1ragMLUIcW4
	LXK83+FvMmrrmx57yN47nQjpY6g5lQ9fh9M0yA1WXsrsmnkIELw2PMFOsX3/rRcc7hp+lm
	vC1iLKsqHCHuFaTV/tiwOE7y5ICDxoazXT3c/2jqBYspscN9s/eZ1LID/0thS48CGW2Aw0
	ryh6yFJo3LlpuZklKavZ7SicFmd8PjugRnugkx0A6M92eF6brHgWaLSaLBb0LA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Aryaman Gupta <aryaman.gupta@windriver.com>,
	Randy Macleod <Randy.Macleod@windriver.com>
Subject: [PATCH v3] doc: bitbake-user-manual: Add definition for
 BB_PRESSURE_MAX variables
Date: Fri,  2 Sep 2022 19:35:50 +0200
Message-Id: <20220902173550.89987-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: 
 <832988652fd0646394de3145564a068ba6c59b51.camel@linuxfoundation.org>
References: 
 <832988652fd0646394de3145564a068ba6c59b51.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Sep 2022 17:36:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13954

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

From: Aryaman Gupta <aryaman.gupta@windriver.com>

Add the definitions for the BB_PRESSURE_MAX{CPU|IO|MEMORY} variables in the
bitbake varibales glossary. Further information on how to determine a good
threshold will be added to the Yocto reference manual in a later commit.

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

---

Changes in V3:
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


