Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0970EC87FCA
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 15:47:01 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.55778.1754581618651928824
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Aug 2025 08:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=ci4w91Rd;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-202508071546559bf17916c89dc2d58c-6nvrly@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202508071546559bf17916c89dc2d58c
        for <bitbake-devel@lists.openembedded.org>;
        Thu, 07 Aug 2025 17:46:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=EnRigztA9DftcjOOMJvubtTj7swFgp6Tj/DgpauCxss=;
 b=ci4w91RdbYPJ5sZlMJCiumAWT0U9aXVBx/ja0jGisVMWITC+FhCDaCcOS4gky1kZOCJ5U/
 Avoe0CRv+Gj8DFNNlztx74Rla/WmVU54rBuUInkStxftWVkolCmmi/uEuCyrXOVaruYIO5J8
 MKPIdR4HmeO6xqPzEj+2BcHDSPj7Y+f70pizdL8LGuY5ZRZ9EhUF2gby/bvJWdA8+DkbrovV
 9PpkhjLTKUAUX93hUAEXSMrj8Fffx9RseHzbZlW+Hi9kXTsVMWLyLR+hcCfxEowQsjTILMIJ
 /vrvaWTzANg39R0bg2Mspss2tYX2wknRfZiFkEUej3UVAk9N2VyzONnw==;
From: Peter Marko <peter.marko@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Peter Marko <peter.marko@siemens.com>
Subject: [PATCH] doc/bitbake-user-manual-ref-variables: update BB_TASK_IONICE_LEVEL
Date: Thu,  7 Aug 2025 17:46:03 +0200
Message-Id: <20250807154603.10581-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Aug 2025 15:47:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17846

From: Peter Marko <peter.marko@siemens.com>

Provided example does not work due to two problems.

CFQ scheduler was removed in kernel 4.20 (per [1])
Replace it with BFQ scheduler.

Also fix typo "queu" -> "queue".

[1] https://en.wikipedia.org/wiki/I/O_scheduling

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 1545c914cc..810f886897 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -770,11 +770,11 @@ overview of their function and contents.
       .. note::
 
          In order for your I/O priority settings to take effect, you need the
-         Completely Fair Queuing (CFQ) Scheduler selected for the backing block
+         Budget Fair Queuing (BFQ) Scheduler selected for the backing block
          device. To select the scheduler, use the following command form where
          device is the device (e.g. sda, sdb, and so forth)::
 
-            $ sudo sh -c "echo cfq > /sys/block/device/queu/scheduler"
+            $ sudo sh -c "echo bfq > /sys/block/device/queue/scheduler"
 
    :term:`BB_TASK_NICE_LEVEL`
       Allows specific tasks to change their priority (i.e. nice level).

