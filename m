Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C8BC3F6B0
	for <webhook@archiver.kernel.org>; Fri, 19 Aug 2022 20:59:52 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web09.281.1660942782789265601
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Aug 2022 13:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=E+zlmZz5;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.179,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f179.google.com with SMTP id u22so5071162plq.12
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Aug 2022 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=4YMXdo+Ob3CZgjBcrMioUTDW0X05RG2sfhblTfyPINo=;
        b=E+zlmZz5XhRmrxKwE7BJ/YtBVLBqNEXuXM/eSAesWyN1ic8x55KgVF4AVtAF35k9T2
         I8KdS38Ex0UBGyGE+b04IIx/czMdZzcpe6UYiejWU5WsD0EwSgaC2vr5ycAxxjbyazVB
         4EltVQndo+OqlwByR8gGMFLMxTPiJlmJUOZ+mIF/TQhjyssfCXsWGwpXSqRKWdeIAgNg
         87vL99Dfaq82C/HX55brh+lnyb5vSg10zWptdKQCV5XxAwjJpkpbLNfJtEMjp5Uozc4L
         4PiLjSLh0omh4BMmHDA7NV02YzK3j5ZArLn11AdmvHELzfiaYqU5HdXhUC0jdSwgug7h
         aRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=4YMXdo+Ob3CZgjBcrMioUTDW0X05RG2sfhblTfyPINo=;
        b=trvpabbxzh94IRFWhK4gIRjZQPmmyzCC8y5Ved6IRBMOfSaa/GmJRCuHgJsbXA5Is4
         QgMdSZCISAHKqppEKG7cHfoWvWzrKEZ8g6THBiPRqZuz/PnEn8/7KdI4JRfwZIJgHcWc
         5RYj1rsTcZMtTx22WV8AabEdnsNS8k8GuGhZiFIVWD7eW9FlEyHn6rKdXwe9hIYgXn5a
         BKKm7DV4i+Z/CjRKsGM9zRtaiqS3JqwqMKf6dRBXlBGxQJkQYRxKOHySZOqqfTvwQVuD
         1GABas6OFnQHlXcAPRgO9l6hR7PkC2StC3NZna05A7316QfAyRRygBwGOVzmU3B0SN43
         K/Fg==
X-Gm-Message-State: ACgBeo3HVoSB3uRVhXMg+OVBT8Wzyk6GVhwMx5sK0fSaNyagKhkWuTue
	cPHi5n7YYPz/7OBUQtmJClY1dmceCCIAj+LH
X-Google-Smtp-Source: 
 AA6agR4a38oazUYeQqhMbnwjjGi/a2QCjhkgHRL6T8GqSCXO3NgSPylIDyASLg74UT+kgs3QrGXTEQ==
X-Received: by 2002:a17:90b:4c07:b0:1f5:40a:8040 with SMTP id
 na7-20020a17090b4c0700b001f5040a8040mr15781365pjb.121.1660942781648;
        Fri, 19 Aug 2022 13:59:41 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 q12-20020a170902dacc00b0017269cc60d7sm3556879plx.214.2022.08.19.13.59.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:59:41 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/2] bitbake: runqueue: add cpu/io
 pressure regulation
Date: Fri, 19 Aug 2022 10:59:22 -1000
Message-Id: 
 <f4954b878d404a72156fe98609387aa9c5747af0.1660942636.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660942636.git.steve@sakoman.com>
References: <cover.1660942636.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Aug 2022 20:59:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13906

From: Aryaman Gupta <aryaman.gupta@windriver.com>

Prevent the scheduler from starting new tasks if the current cpu or io
pressure is above a certain threshold and there is at least one active
task. This threshold can be specified through the
"BB_PRESSURE_MAX_{CPU|IO}" variables in conf/local.conf.

The threshold represents the difference in "total" pressure from the
previous second. The pressure data is discussed in this oe-core commit:
   061931520b buildstats.py: enable collection of /proc/pressure data
where one can see that the average and "total" values are available.
From tests, it was seen that while using the averaged data was somewhat
useful, the latency in regulating builds was too high. By taking the
difference between the current pressure and the pressure seen in the
previous second, better regulation occurs. Using a shorter time period
is appealing but due to fluctations in pressure, comparing the current
pressure to 1 second ago achieves a reasonable compromise. One can look
at the buildstats logs, that usually sample once per second, to decide a
sensible threshold.

If the thresholds aren't specified, pressure is not monitored and hence
there is no impact on build times. Arbitary lower limit of 1.0 results
in a fatal error to avoid extremely long builds. If the limits are higher
than 1,000,000, then warnings are issued to inform users that the specified
limit is very high and unlikely to result in any regulation.

The current bitbake scheduling algorithm requires that at least one
task be active. This means that if high pressure is seen, then new tasks
will not be started and pressure will be checked only for as long as at
least one task is active. When there are no active tasks, an additional task
will be started and pressure checking resumed. This behaviour means that
if an external source is causing the pressure to exceed the threshold,
bitbake will continue to make some progress towards the requested target.
This violates the intent of limiting pressure but, given the current
scheduling algorithm as described above, there seems to be no other option.
In the case where only one bitbake build is running, the implications of
the scheduler requirement will likely result in pressure being higher
than the threshold. More work would be required to ensure that
the pressure threshold is never exceeded, for example by adding pressure
monitoring to make and ninja.

(Bitbake rev: 502e05cbe67fb7a0e804dcc2cc0764a2e05c014f)

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <randy.macleod@windriver.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f34f1568..203ef8c1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -24,6 +24,7 @@ import pickle
 from multiprocessing import Process
 import shlex
 import pprint
+import time
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -159,6 +160,46 @@ class RunQueueScheduler(object):
                 self.buildable.append(tid)
 
         self.rev_prio_map = None
+        self.is_pressure_usable()
+
+    def is_pressure_usable(self):
+        """
+        If monitoring pressure, return True if pressure files can be open and read. For example
+        openSUSE /proc/pressure/* files have readable file permissions but when read the error EOPNOTSUPP (Operation not supported)
+        is returned.
+        """
+        if self.rq.max_cpu_pressure or self.rq.max_io_pressure:
+            try:
+                with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                    self.prev_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
+                    self.prev_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
+                    self.prev_pressure_time = time.time()
+                self.check_pressure = True
+            except:
+                bb.warn("The /proc/pressure files can't be read. Continuing build without monitoring pressure")
+                self.check_pressure = False
+        else:
+            self.check_pressure = False
+
+    def exceeds_max_pressure(self):
+        """
+        Monitor the difference in total pressure at least once per second, if
+        BB_PRESSURE_MAX_{CPU|IO} are set, return True if above threshold.
+        """
+        if self.check_pressure:
+            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                # extract "total" from /proc/pressure/{cpu|io}
+                curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
+                curr_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
+                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
+                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
+                now = time.time()
+                if now - self.prev_pressure_time > 1.0:
+                    self.prev_cpu_pressure = curr_cpu_pressure
+                    self.prev_io_pressure = curr_io_pressure
+                    self.prev_pressure_time = now
+            return (exceeds_cpu_pressure or exceeds_io_pressure)
+        return False
 
     def next_buildable_task(self):
         """
@@ -172,6 +213,12 @@ class RunQueueScheduler(object):
         if not buildable:
             return None
 
+        # Bitbake requires that at least one task be active. Only check for pressure if
+        # this is the case, otherwise the pressure limitation could result in no tasks
+        # being active and no new tasks started thereby, at times, breaking the scheduler.
+        if self.rq.stats.active and self.exceeds_max_pressure():
+            return None
+
         # Filter out tasks that have a max number of threads that have been exceeded
         skip_buildable = {}
         for running in self.rq.runq_running.difference(self.rq.runq_complete):
@@ -1699,6 +1746,8 @@ class RunQueueExecute:
 
         self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
+        self.max_cpu_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_CPU")
+        self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_IO")
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1733,6 +1782,22 @@ class RunQueueExecute:
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
 
+        lower_limit = 1.0
+        upper_limit = 1000000.0
+        if self.max_cpu_pressure:
+            self.max_cpu_pressure = float(self.max_cpu_pressure)
+            if self.max_cpu_pressure < lower_limit:
+                bb.fatal("Invalid BB_PRESSURE_MAX_CPU %s, minimum value is %s." % (self.max_cpu_pressure, lower_limit))
+            if self.max_cpu_pressure > upper_limit:
+                bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_CPU is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_cpu_pressure))
+
+        if self.max_io_pressure:
+            self.max_io_pressure = float(self.max_io_pressure)
+            if self.max_io_pressure < lower_limit:
+                bb.fatal("Invalid BB_PRESSURE_MAX_IO %s, minimum value is %s." % (self.max_io_pressure, lower_limit))
+            if self.max_io_pressure > upper_limit:
+                bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_IO is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_io_pressure))
+
         # List of setscene tasks which we've covered
         self.scenequeue_covered = set()
         # List of tasks which are covered (including setscene ones)
-- 
2.25.1


