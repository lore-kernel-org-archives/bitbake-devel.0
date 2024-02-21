Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D886C48BC3
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 13:21:07 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.12694.1708521666577434057
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Feb 2024 05:21:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IF2uCrbf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.175, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d243797703so34122841fa.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Feb 2024 05:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708521664; x=1709126464; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EOtWq3zwJA13VMB1p0mHo18zUOx7Yd3PtwAlknCNNU=;
        b=IF2uCrbfIym5PPCahJo5EO5Z4/9DeuR1ut9Q4OVZ1tr6MfCyXvC+38LYU0Sf9O39pK
         AWEEA8AwL4KQtJ4X52Dux9y8e67AoyXIE67i9WjcRJjmTNNvVHc/aUWN/zrWdK779lOo
         NdCCw/0pH/AuOAbJmOtG6NdU/Rz4x0TT7olFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521664; x=1709126464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EOtWq3zwJA13VMB1p0mHo18zUOx7Yd3PtwAlknCNNU=;
        b=GBAdKVI2pn6FswxpQdV3w9/4ybffjs0Mm+aDaNwa7IjUOGSxKl78vgYR14l7zDFMTO
         GWzpbvqu/MxPM4b9L0YlX8GOizF8CW3Wt4bHtqcu1O2DookY5isKKzL8+DreqmguunzF
         fN4bDim3qPwAu3KZbjDWfgcbfvr2yosTwHo2Cr2qIXmekEZ3uZ3UhEVu5G5I5J3fOP6Z
         jk8v6ZpjrmjGzCqXmYv0F0r/cnHkWpDMzTHCrvXWJ2BiVQILJBZwVRNloCqZSuwdlt5F
         V3qju9eFa7RUPoxC7RJlXgbPWaeLYaqeQhtGgWH96Ho4wXdYX77nK61l7FpjgVD6LW0P
         wiNQ==
X-Gm-Message-State: AOJu0YyUE0VX7nrHNOAu4kYUsHjilX/6RbTQLMrRIP5uOJqWKWaxMxNf
	oYhJdibNBEdgHyHKmAdaQ49BvU2djHSOTlydYtBG0UduAaZIsriUcYhLXArr93NYRATU5hIeg54
	5
X-Google-Smtp-Source: AGHT+IFw0es5jaGbogJrgvn6JJ2QOwxwW0/zNsp3RHR5hwPtO4ZFRTbG1urt+lWduMmuzz6pG6TxQQ==
X-Received: by 2002:a05:651c:509:b0:2d2:215e:157c with SMTP id o9-20020a05651c050900b002d2215e157cmr10626239ljp.7.1708521664290;
        Wed, 21 Feb 2024 05:21:04 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f7eb:cc84:5778:9052])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b0040fc56712e8sm18395431wmb.17.2024.02.21.05.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 05:21:03 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: randy.macleod@windriver.com
Subject: [PATCH] runqueue: Add support for BB_LOADFACTOR_MAX
Date: Wed, 21 Feb 2024 13:21:03 +0000
Message-Id: <20240221132103.794574-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Feb 2024 13:21:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15950

Some ditros don't enable /proc/pressure and it tends to be those which we
see bitbake timeout issues on, seemingly as load gets too high and the bitbake
processes don't get scheduled in for minutes at a time.

Add support for stopping running extra tasks if the system load average goes
above a certain threshold by setting BB_LOADFACTOR_MAX.

The value used is scaled by CPU number, so a value of 1 would be when
the load average equals the number of cpu cores of the system, under one
only starts tasks when the load average is below the number of cores.

This means you can centrally set a value such as 1.5 which will then
scale correctly to different sized machines with differing numbers
of CPUs.

The pressure regulation is probably more accurate and responsive, however
our graphs do show singificant load spikes on some workers and this
patch is aimed at trying to avoid those.

Pressure regulation is used where available in preference to this load
factor regulation when both are set.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e86ccd8c61..6987de3e29 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -220,6 +220,16 @@ class RunQueueScheduler(object):
                 bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks)))
             self.pressure_state = pressure_state
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
+        elif self.rq.max_loadfactor:
+            limit = False
+            loadfactor = float(os.getloadavg()[0]) / os.cpu_count()
+            # bb.warn("Comparing %s to %s" % (loadfactor, self.rq.max_loadfactor))
+            if loadfactor > self.rq.max_loadfactor:
+                limit = True
+            if hasattr(self, "loadfactor_limit") and limit != self.loadfactor_limit:
+                bb.note("Load average limiting set to %s as load average: %s - using %s/%s bitbake threads" % (limit, loadfactor, len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks))
+            self.loadfactor_limit = limit
+            return limit
         return False
 
     def next_buildable_task(self):
@@ -1822,6 +1832,7 @@ class RunQueueExecute:
         self.max_cpu_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_CPU")
         self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_IO")
         self.max_memory_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_MEMORY")
+        self.max_loadfactor = self.cfgData.getVar("BB_LOADFACTOR_MAX")
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1875,6 +1886,11 @@ class RunQueueExecute:
                 bb.fatal("Invalid BB_PRESSURE_MAX_MEMORY %s, minimum value is %s." % (self.max_memory_pressure, lower_limit))
             if self.max_memory_pressure > upper_limit:
                 bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_MEMORY is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_io_pressure))
+
+        if self.max_loadfactor:
+            self.max_loadfactor = float(self.max_loadfactor)
+            if self.max_loadfactor <= 0:
+                bb.fatal("Invalid BB_LOADFACTOR_MAX %s, needs to be greater than zero." % (self.max_loadfactor))
             
         # List of setscene tasks which we've covered
         self.scenequeue_covered = set()
-- 
2.40.1


