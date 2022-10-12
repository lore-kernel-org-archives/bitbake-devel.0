Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44755C43217
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 13:21:39 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web08.19895.1665580895505198915
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Oct 2022 06:21:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=G81QRi+B;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id F0D541BF20C;
	Wed, 12 Oct 2022 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1665580893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WCiWdPulQC97V21KrtRCsyqtaZ3jcDplJFVKCxtwZ4=;
	b=G81QRi+BAqHaEAuPIEbEG7etB2xkGakn3kzQzORO8Y2YkabyClT2vxFdHtnUHueUq5fBkG
	8tuz9Bm031l/mklUQBDpt2yj2Y0QhmT+NnovILcofphBrjqqfa6S32Icsx0m+pcCxx4n2d
	7LerMGFFYb46ZlrIOx0dUIn0jimV9fmMkMzEMpnLjpYLfZdk8tIUKNHc4iix6UHww2zPGo
	mkppW/tvYHFpwDwraOzJp637tH4zpzAd1jy4w4gFozBxph1hC3ea8mOIMU2uJLgFIs0SSc
	K16RHUyjMVYUHwNorHGpkIWptGKipHa25RAiBXMNakzCzN97B2QDOKvx7brFcA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Paul Eggleton <paul.eggleton@microsoft.com>
Subject: [PATCH v2] doc: bitbake-user-manual: expand description of BB_PRESSURE_MAX variables
Date: Wed, 12 Oct 2022 15:21:20 +0200
Message-Id: <20221012132120.2930882-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171D53BFD3AD88D3.3472@lists.yoctoproject.org>
References: <171D53BFD3AD88D3.3472@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Oct 2022 13:21:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14036

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Paul Eggleton <paul.eggleton@microsoft.com>
Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

---

Changes in V2:
- Specify which version of the Linux kernel introduced /proc/pressure
  as suggested by Quentin Schulz
  (https://kernelnewbies.org/Linux_4.20#Pressure_stall_information_for_better_overview_of_system_load)
---
 .../bitbake-user-manual-ref-variables.rst     | 60 +++++++++++++------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 725e6c2c..3522d2b7 100644
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
+      The pressure data is calculated based upon what Linux kernels since
+      version 4.20 expose under ``/proc/pressure``. The threshold represents
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
+      The pressure data is calculated based upon what Linux kernels since
+      version 4.20 expose under ``/proc/pressure``. The threshold represents
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
+      The pressure data is calculated based upon what Linux kernels since
+      version 4.20 expose under ``/proc/pressure``. The threshold represents
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


