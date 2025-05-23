Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF36C54ED0
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 14:52:21 +0000 (UTC)
Received: from smarthost01c.ixn.mail.zen.net.uk (smarthost01c.ixn.mail.zen.net.uk [212.23.1.22])
 by mx.groups.io with SMTP id smtpd.web10.49917.1748011934905084983
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 May 2025 07:52:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=ZZxeSIIT;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.22, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01c.ixn.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uITkr-001nLz-4k;
	Fri, 23 May 2025 14:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	In-Reply-To:References; bh=4E6JmUrGUjwj0zrDWZl5tflA6RQtconiFsLF9VzEeVo=; b=ZZ
	xeSIITJ1FDXksEGTYldvMvXKR0Ge8YWdWPN/gXn4IPoBV+4gMrutzPgxKtjqBbb2VEEd8IXJJMH8W
	6JMKfML1Vl00Ylod1i0tYBTGVd/oXcfZOG8fJoU+aqY0Krdg+RMK8xCBB4N0n37ksi2nqDFim9o6D
	FKye3uGZTLCk6kp7tx6uKVVdg+ZaWXtrpdBLuBpi+K9vZSJ9qr+vXI7Sn2g9ttzfCL0KwZUK4oOgd
	crLZhJHMlVHKHZ6lfsITj3x/1cJsZg/LMC5yFNOjUYDl0XAe98hm5S5OKB+LCq01j5GqAqRMj8Gmy
	LH4CQc6VcOuLPjbPjpDbYQJJLXh1Mr+w==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uITkp-00DhP0-1q;
	Fri, 23 May 2025 15:52:11 +0100
From: Mike Crowe <mac@mcrowe.com>
To: bitbake-devel@lists.openembedded.org
Cc: Mike Crowe <mac@mcrowe.com>,
	Jack Mitchell <jack@embed.me.uk>
Subject: [PATCH] runqueue: Allow pressure state change notifications to be disabled
Date: Fri, 23 May 2025 15:52:05 +0100
Message-Id: <20250523145205.3542264-1-mac@mcrowe.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01c-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 May 2025 14:52:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17635

Allow setting BB_PRESSURE_NOTE_CHANGE = "0" to disable NOTE messages
being emitted every time the pressure state changes. The previous
default behaviour is not changed.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
Reviewed-by: Jack Mitchell <jack@embed.me.uk>
---
 .../bitbake-user-manual-ref-variables.rst                  | 7 +++++++
 lib/bb/runqueue.py                                         | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 477443e22..cd81a586e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -574,6 +574,13 @@ overview of their function and contents.
       might be useful as a last resort to prevent OOM errors if they are
       occurring during builds.
 
+   :term:`BB_PRESSURE_NOTE_CHANGE`
+
+      By default Bitbake emits a note message each time the scheduler
+      decides to stop or start scheduling new tasks due to pressure
+      changes. Setting :term:`BB_PRESSURE_NOTE_CHANGE` to "0" stops these
+      messages.
+
    :term:`BB_RUNFMT`
       Specifies the name of the executable script files (i.e. run files)
       saved into ``${``\ :term:`T`\ ``}``. By default, the
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8fadc8338..306814fd6 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -218,7 +218,7 @@ class RunQueueScheduler(object):
 
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             pressure_values = (round(cpu_pressure,1), self.rq.max_cpu_pressure, round(io_pressure,1), self.rq.max_io_pressure, round(memory_pressure,1), self.rq.max_memory_pressure)
-            if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
+            if self.rq.note_pressure_state_change and hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
                 bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks)))
             self.pressure_state = pressure_state
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
@@ -1864,6 +1864,7 @@ class RunQueueExecute:
         self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_IO")
         self.max_memory_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_MEMORY")
         self.max_loadfactor = self.cfgData.getVar("BB_LOADFACTOR_MAX")
+        self.note_pressure_state_change = (self.cfgData.getVar("BB_PRESSURE_NOTE_CHANGE") or "1") != "0"
 
         self.sq_buildable = set()
         self.sq_running = set()
-- 
2.39.5


