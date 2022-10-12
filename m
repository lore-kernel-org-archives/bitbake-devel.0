Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D12C4332F
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 12:43:19 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web12.19859.1665578595966327528
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Oct 2022 05:43:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=iwSfnYHd;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 02EC960007;
	Wed, 12 Oct 2022 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1665578593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uWMnZrNLmy7tjwhE8NZcAY8MRNexNdQGLf/PIKa8bvw=;
	b=iwSfnYHdT/yKQNrL8+jbmRHvnals//yWFenaWaCk/QxK7Tt8e3lqBmmlAAhcUlc2A7/r5K
	e6ekgEq0PoxC4084wcjFsYZMVrPso9OueYFIP0HvVuM/Yjz3LvPEEybj0YxXG1KVVCZxgf
	hckDAAud3Rc0eYf5Kgups09ZLM3uh8uRIYnUvqhJKx8L95BGBZfa8/Qni+PySk0QqyarAS
	RavALU00rhxikRiUGASfMHwQs2BhxrqMsNaUjDKo2izd64Z8Xsubzi0JVD4fXQmHEISx+P
	ed7oHFw4KXEOA96Dcxtod9wXXr1TURDJ20LZFnzqwUc8isvcEC7AtIP4Qn8kJQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Paul Eggleton <paul.eggleton@microsoft.com>
Subject: [PATCH] doc: bitbake-user-manual: expand description of BB_PRESSURE_MAX variables
Date: Wed, 12 Oct 2022 14:43:04 +0200
Message-Id: <20221012124304.2926858-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Oct 2022 12:43:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14033

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Paul Eggleton <paul.eggleton@microsoft.com>
Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-ref-variables.rst     | 60 +++++++++++++------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 725e6c2c..b9c1b75d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -484,29 +484,55 @@ overview of their function and contents.
          for it to work.
 
    :term:`BB_PRESSURE_MAX_CPU`
-      The threshold for maximum CPU pressure before BitBake prevents the
-      scheduling of new tasks. Once the :term:`BB_PRESSURE_MAX_CPU` threshold
-      is exceeded, new tasks are not started until the pressure subsides to
-      below the threshold. If :term:`BB_PRESSURE_MAX_CPU` is not set, CPU
-      pressure is not monitored. A threshold can be set in ``conf/local.conf``
-      as::
+      Specifies a maximum CPU pressure threshold, above which BitBake's
+      scheduler will not start new tasks (providing there is at least
+      one active task). If no value is set, CPU pressure is not
+      monitored when starting tasks.
+
+      The pressure data is calculated based upon what (recent) Linux
+      kernels expose under ``/proc/pressure``. The threshold represents
+      the difference in "total" pressure from the previous second. The
+      minimum value is 1.0 (extremely slow builds) and the maximum is
+      1000000 (a pressure value unlikely to ever be reached).
+
+      This threshold can be set in ``conf/local.conf`` as::
 
          BB_PRESSURE_MAX_CPU = "500"
 
    :term:`BB_PRESSURE_MAX_IO`
-      The threshold for maximum IO pressure experienced before BitBake
-      prevents the scheduling of new tasks. The IO pressure is regulated in the
-      same way as :term:`BB_PRESSURE_MAX_CPU`. At this point in time,
-      experiments show that IO pressure tends to be short-lived and regulating
-      just the CPU can help to reduce it.
+      Specifies a maximum I/O pressure threshold, above which BitBake's
+      scheduler will not start new tasks (providing there is at least
+      one active task). If no value is set, I/O pressure is not
+      monitored when starting tasks.
+
+      The pressure data is calculated based upon what (recent) Linux
+      kernels expose under ``/proc/pressure``. The threshold represents
+      the difference in "total" pressure from the previous second. The
+      minimum value is 1.0 (extremely slow builds) and the maximum is
+      1000000 (a pressure value unlikely to ever be reached).
+
+      At this point in time, experiments show that IO pressure tends to
+      be short-lived and regulating just the CPU with
+      :term:`BB_PRESSURE_MAX_CPU` can help to reduce it.
 
    :term:`BB_PRESSURE_MAX_MEMORY`
-      The threshold for maximum memory pressure experienced before BitBake
-      prevents the scheduling of new tasks. The memory pressure is regulated in
-      the same way as :term:`BB_PRESSURE_MAX_CPU`. Note that any memory
-      pressure indicates that a system is being pushed beyond its capacity. At
-      this point in time, experiments show that memory pressure tends to be
-      short-lived and regulating just the CPU can help to reduce it.
+
+      Specifies a maximum memory pressure threshold, above which BitBake's
+      scheduler will not start new tasks (providing there is at least
+      one active task). If no value is set, memory pressure is not
+      monitored when starting tasks.
+
+      The pressure data is calculated based upon what (recent) Linux
+      kernels expose under ``/proc/pressure``. The threshold represents
+      the difference in "total" pressure from the previous second. The
+      minimum value is 1.0 (extremely slow builds) and the maximum is
+      1000000 (a pressure value unlikely to ever be reached).
+
+      Memory pressure is experienced when time is spent swapping,
+      refaulting pages from the page cache or performing direct reclaim.
+      This is why memory pressure is rarely seen, but setting this variable
+      might be useful as a last resort to prevent OOM errors if they are
+      occurring during builds.
 
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
-- 
2.34.1


