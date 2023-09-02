Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894CCCA0FF8
	for <webhook@archiver.kernel.org>; Sat,  2 Sep 2023 07:23:32 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web10.4230.1693639408780092655
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Sep 2023 00:23:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=hYC+jl31;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99c1f6f3884so336953666b.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 02 Sep 2023 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693639407; x=1694244207; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/fHktZC/oSXsePXCgPnnK/t7GHdfMc+Zmi42lSUghA=;
        b=hYC+jl31oYN1hWd/wsS5DdsfbKcd8vka1zHMsK8xOoc0swiDKxcuzZLC27HQe9p8Tw
         IpZD9FRI4JCohQkoTJDQuiABkbCp+nMcwsWKutBq5oPbELn6BetXcHfq7xzkB1BOuGk3
         nSZiEdFXQvRINIi1ctx4fAcESeXjoPr7OjiMXmmmreurOt+BgeDGRlgyxVzhzgz7qKDU
         eXkaH+fpjC4c1qZvl29UBDFOfdnfl6D7SojQCHQLfv+LcW9w10wuOqtr+dYo1utWOVlJ
         f9vLZA8xW/fl1fAkKoRSEd2IJT9zAnlFdOo5Ik/F83h8qfOf/WnZg4e9Rwa0Aq8S5EYX
         cUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693639407; x=1694244207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/fHktZC/oSXsePXCgPnnK/t7GHdfMc+Zmi42lSUghA=;
        b=SBveeSYYodMSZkD0e7H+hh0PpQuz0Se/o54URytXFjIZdNtIG+SydlR67o+hQPjEhe
         q/ZxCZrmMGLT1XCVwERUcwAcHW/IOSPW2SsyYTVCK6WE69mo/x60nzyaLR7nTtLfnE1V
         woNrWLhd3rXAFLD0Gnev9V0F6VcizmsqfCiUw7tUfixPaUuUS+AMyxc2+XgmuP3AJ3qP
         5gC0pTDPw/VzkIZGs65QaQlg+9Jxv0Ls1Da7/tJLsSJk4tarnPqH3ScC0bdoB/VoxTjZ
         4pe5CAbAJ7CTvnKRb5AZpUbHL/f0jrpdRLh4KwKIcS+iMIkplYc7GDNoMiAnXCR3KJg4
         EiIA==
X-Gm-Message-State: AOJu0YyBlx9vPoNIelapDwkKca6D36iJDXr75WYtkIMcEQLGwRQH0ydd
	7f+o/EaA1aEi3fUhoF9Rt2cfrHTNDxo=
X-Google-Smtp-Source: AGHT+IGXLNrqhNxCSW2Xe+wl5ArfhnbNyNb3THhmROpaaltL/7jjox5P7sFC1sFZfO1ZsR7z+SLC1A==
X-Received: by 2002:a17:906:23ea:b0:9a1:be5b:f4aa with SMTP id j10-20020a17090623ea00b009a1be5bf4aamr3501441ejg.0.1693639406895;
        Sat, 02 Sep 2023 00:23:26 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id qc8-20020a170906d8a800b009a5f7fb51dcsm3014911ejb.42.2023.09.02.00.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 00:23:26 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] runqueue: show number of currently running bitbake threads when pressure changes
Date: Sat,  2 Sep 2023 09:23:05 +0200
Message-ID: <20230902072305.709389-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 Sep 2023 07:23:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15003

* it might be a bit confusing as it shows number of threads before making
  the decision to start more tasks and also it can show only a few tasks
  running, but not because of pressure when there just aren't many tasks
  left or wait for their dependencies to be finished first

* example output:
  NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 297589.5/200000.0, IO: 5522.2/None, Mem: 779.2/None) - using 7/8 bitbake threads
  NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 196381.2/200000.0, IO: 2667.9/None, Mem: 556.2/None) - using 2/8 bitbake threads

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index eaf7472e0..d2bd41d0b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -217,7 +217,7 @@ class RunQueueScheduler(object):
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             pressure_values = (round(cpu_pressure,1), self.rq.max_cpu_pressure, round(io_pressure,1), self.rq.max_io_pressure, round(memory_pressure,1), self.rq.max_memory_pressure)
             if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
-                bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s)" % (pressure_state + pressure_values))
+                bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s) - using %s/%s bitbake threads" % (pressure_state + pressure_values + (len(self.rq.runq_running.difference(self.rq.runq_complete)), self.rq.number_tasks)))
             self.pressure_state = pressure_state
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         return False
-- 
2.42.0


