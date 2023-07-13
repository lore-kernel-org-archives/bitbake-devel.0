Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9B2EB64DD
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 10:53:12 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.5491.1689245587281217601
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jul 2023 03:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=WKAV9aU0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso1005926e87.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Jul 2023 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689245585; x=1691837585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EzShrS5+KgSQKz1X0v3f+j+OHAQYcPnmRo1bo1ck45E=;
        b=WKAV9aU0lsHkiY+S04Rn/uVD5VZaHoZ49O6EyxQIr6ijPMmAtJYtnlp/dzsHQ0oK+N
         TNx2rc10BW1+akMUe4JZ90c63HulKUc7WS3Y2mfPTfPq/Jiq4RbpBPOpf9b1TIhTNtzn
         qEWj74d7zA0ecVGrLoEbwmTjDLIsPiBRvdPm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689245585; x=1691837585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzShrS5+KgSQKz1X0v3f+j+OHAQYcPnmRo1bo1ck45E=;
        b=aDlGtcyhaKanbE67Eefbc550M8UZ0/las2ys1g5S6IjcL/bJNheMzJV+/QOuit4Xlb
         yfiJpoYU2uN72oe7C7u30jLiGJBJA8gbQH37X+e4E+SomgV+rjPhneD2dfVDWFhlVO6o
         lgNEI3xLYfcztvsT8OlhH9Nk9/N63AhsNgSofKxwH/AK5kgVSiYpSWGpsviivcmKge4B
         737UbhBhnbzt6MDfgtCybF/eudUztwMqmL8NGrvHvKS/HlKQriiqW/6cetMWsXkHo7Ri
         Gc8DESrbunchUo98xRAhpGx78uugcAvodRE+C+MxvE0BOKbUK+pLNKJCaW5y7XZ6qs5l
         vwMw==
X-Gm-Message-State: ABy/qLaVDgoZ4iCxKBPiCk+T2e9uL4O407TCWQCOQUHw9DSADjtmdH74
	jHvAyeBuxiw5fkFOczamyLXHLfr32bQIOM5uye0=
X-Google-Smtp-Source: APBJJlEiDD42JUw2o7Gk0y/g59TF3R5PsqgIsYavJqLm4H2rvJqozGSsYnRseWak4aydesfX7jfFlw==
X-Received: by 2002:a19:ee0d:0:b0:4fb:822d:83ab with SMTP id g13-20020a19ee0d000000b004fb822d83abmr807468lfb.20.1689245585041;
        Thu, 13 Jul 2023 03:53:05 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:63d8:38f2:4435:df11])
        by smtp.gmail.com with ESMTPSA id q4-20020adfcd84000000b0031134bcdacdsm7651644wrj.42.2023.07.13.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:53:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Randy MacLeod <Randy.MacLeod@windriver.com>
Subject: [PATCH] runqueue: Add pressure change logging
Date: Thu, 13 Jul 2023 11:53:03 +0100
Message-Id: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jul 2023 10:53:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14881

It is currently hard to tell when bitbake is throttling task execution
due to system pressure changes. Add notes to the console output to make
this clearer, only generating output when the values change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 241a746ebb..020ad210d8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -212,6 +212,10 @@ class RunQueueScheduler(object):
                     exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
                     exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
                     exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
+            pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
+            if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
+                bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s" % pressure_state)
+            self.pressure_state = pressure_state
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         return False
 
-- 
2.39.2


