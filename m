Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0066C32771
	for <webhook@archiver.kernel.org>; Fri, 19 Aug 2022 20:59:52 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.282.1660942784769636750
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Aug 2022 13:59:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=F25USg2T;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id x23so5082288pll.7
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Aug 2022 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=0UxBP0Vf0EKrsprCSydA6n9dEjrY50IK5Krx0go5bqk=;
        b=F25USg2TE8/u+MDcxa5xd4J6n8s6lPDolQQbWiHikTbr7N7A3ke0Ee0DljxQsf09TP
         MzepFXwijXVbgbv01yaGRk74rE1cFBcYAr9Mji3rHc6hqSiMp7AFY3YYn0fRMOsBQo/s
         aTfPCPSvwxswEce0i3YaaZTsCLYOBtyzE8t2y1cA6Ckdpm1m/wNMVKwBwEToXHq3YwqD
         6gBnJUNJGUeWSQT3Q0LKjmx1pXFpcCvFWnKe449zBEeH3FCW8MQ3EPmn4o7cnvHu/s0Q
         gMvWXGo8N94RPBg9P/385MsztjT4nD/MA4b7oo/q9GAfogGO5Vcfk9ihay1f+8TgHAyD
         A5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=0UxBP0Vf0EKrsprCSydA6n9dEjrY50IK5Krx0go5bqk=;
        b=svCclfRCB2DOYeqotKy7131+b/GjQG5p2WLEpKGVAdwKEo+s0iEHt8iUdZqwTzfcUi
         RDfNIdFz866oTohPnZXTmBgsyJ6RstjX8yQtErTsoepXkhhNOEzaespwhVkyl1nJFANS
         TLgJ4FW8y0WbTSJZQOGPs/JGG5tQ2PM1VMbP9bdIiR1hVehGLPcvhWbf/0yt+XJlfAP7
         Kygzk4Ka8D5GLNukMGQnYx6Ile7F3gBhrgpfH2Lbd39oh0u+0fusc9i6zsP1JgZoFing
         DHFgBiciW8aA1aWBlLXiZr8RmITaOcjlXbvAsP7q5JWCBHNIh6g0rmtuzVCiUOhexxRc
         QICQ==
X-Gm-Message-State: ACgBeo2pW2TmX+IaC0sSs+ZBmfL4tBKEW9PwK9N7ZBe9zXXDf37i8qCM
	0suFB+g1OdFSePPg77ufP6CuGMIesXg6RsMW
X-Google-Smtp-Source: 
 AA6agR7xJT6OXbEfBmmy1Z3axAzYis2Y+EfrfGUe2DYdSm72ttOtEtDt2ACUMGDFhtO9PVVRTzMJKg==
X-Received: by 2002:a17:90a:7805:b0:1fa:bdab:7d59 with SMTP id
 w5-20020a17090a780500b001fabdab7d59mr10159644pjk.37.1660942783539;
        Fri, 19 Aug 2022 13:59:43 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 q12-20020a170902dacc00b0017269cc60d7sm3556879plx.214.2022.08.19.13.59.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:59:43 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/2] bitbake: runqueue: add memory
 pressure regulation
Date: Fri, 19 Aug 2022 10:59:23 -1000
Message-Id: 
 <4ada86cb6b05e6e3aabc8015a6e73aacb14a3388.1660942636.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660942636.git.steve@sakoman.com>
References: <cover.1660942636.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Aug 2022 20:59:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13907

From: Aryaman Gupta <aryaman.gupta@windriver.com>

Prevent new tasks from being scheduled if the memory pressure is above
a certain threshold, specified through the "BB_MAX_PRESSURE_MEMORY"
variable in the conf/local.conf file. This is an extension to the
following commit and hence regulates pressure in the same way:
   48a6d84de1 bitbake: runqueue: add cpu/io pressure regulation

Memory pressure is experienced when time is spent swapping, refaulting
pages from the page cache or performing direct reclaim. This is why
memory pressure is rarely seen but might be useful as a last resort to
prevent OOM errors.

(Bitbake rev: 44c395434c7be8dab968630a610c8807f512920c)

Signed-off-by: Aryaman Gupta <aryaman.gupta@windriver.com>
Signed-off-by: Randy Macleod <Randy.Macleod@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 203ef8c1..9b009262 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -168,11 +168,15 @@ class RunQueueScheduler(object):
         openSUSE /proc/pressure/* files have readable file permissions but when read the error EOPNOTSUPP (Operation not supported)
         is returned.
         """
-        if self.rq.max_cpu_pressure or self.rq.max_io_pressure:
+        if self.rq.max_cpu_pressure or self.rq.max_io_pressure or self.rq.max_memory_pressure:
             try:
-                with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+                with open("/proc/pressure/cpu") as cpu_pressure_fds, \
+                    open("/proc/pressure/io") as io_pressure_fds, \
+                    open("/proc/pressure/memory") as memory_pressure_fds:
+
                     self.prev_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
                     self.prev_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
+                    self.prev_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
                     self.prev_pressure_time = time.time()
                 self.check_pressure = True
             except:
@@ -184,21 +188,26 @@ class RunQueueScheduler(object):
     def exceeds_max_pressure(self):
         """
         Monitor the difference in total pressure at least once per second, if
-        BB_PRESSURE_MAX_{CPU|IO} are set, return True if above threshold.
+        BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above threshold.
         """
         if self.check_pressure:
-            with open("/proc/pressure/cpu") as cpu_pressure_fds, open("/proc/pressure/io") as io_pressure_fds:
+            with open("/proc/pressure/cpu") as cpu_pressure_fds, \
+                open("/proc/pressure/io") as io_pressure_fds, \
+                open("/proc/pressure/memory") as memory_pressure_fds:
                 # extract "total" from /proc/pressure/{cpu|io}
                 curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
                 curr_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
+                curr_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
                 exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
                 exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
+                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
                 now = time.time()
                 if now - self.prev_pressure_time > 1.0:
                     self.prev_cpu_pressure = curr_cpu_pressure
                     self.prev_io_pressure = curr_io_pressure
+                    self.prev_memory_pressure = curr_memory_pressure
                     self.prev_pressure_time = now
-            return (exceeds_cpu_pressure or exceeds_io_pressure)
+            return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         return False
 
     def next_buildable_task(self):
@@ -1748,6 +1757,7 @@ class RunQueueExecute:
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
         self.max_cpu_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_CPU")
         self.max_io_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_IO")
+        self.max_memory_pressure = self.cfgData.getVar("BB_PRESSURE_MAX_MEMORY")
 
         self.sq_buildable = set()
         self.sq_running = set()
@@ -1798,6 +1808,13 @@ class RunQueueExecute:
             if self.max_io_pressure > upper_limit:
                 bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_IO is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_io_pressure))
 
+        if self.max_memory_pressure:
+            self.max_memory_pressure = float(self.max_memory_pressure)
+            if self.max_memory_pressure < lower_limit:
+                bb.fatal("Invalid BB_PRESSURE_MAX_MEMORY %s, minimum value is %s." % (self.max_memory_pressure, lower_limit))
+            if self.max_memory_pressure > upper_limit:
+                bb.warn("Your build will be largely unregulated since BB_PRESSURE_MAX_MEMORY is set to %s. It is very unlikely that such high pressure will be experienced." % (self.max_io_pressure))
+            
         # List of setscene tasks which we've covered
         self.scenequeue_covered = set()
         # List of tasks which are covered (including setscene ones)
-- 
2.25.1


