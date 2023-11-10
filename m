Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E949C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 13:54:55 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.27840.1699624489014687284
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 05:54:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gD/7XR+O;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9e62f903e88so102885966b.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 05:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699624487; x=1700229287; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz+QMGfoYENFiTP4A2/snXyk8OjWOYzYu3MEMUiaKqQ=;
        b=gD/7XR+OCoDl9O12hyjyl69QlNxJtc6WCrsLIE2eG93w0VhGfbrUtlITtPVck/oSlD
         nUe5N4jr4BosqgSwxKG+/8ydUdQQqeHxlUaKeFkQjs9tQJc2g9sUi4W6hgx9OtiAfjun
         GbHCjM0mHoTuhaL4Ov0X6UWmDO/obTzCTxuYkhRZmaokeoaGenn6ANDgfL8+E8xMeGOy
         d/ZJfzru8KpO5lKu2jf0JFN6u5w53ePDlwcT7+xd+EV9EJnt8LsP9JXZjSSNWL1KkPpB
         wb0UetiHAXVOs+PhS+Um8rdbbVA9IUInW6mbGsnmNaoRSge2lipmWq4NrPfBFXmeEtJ1
         LTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624487; x=1700229287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kz+QMGfoYENFiTP4A2/snXyk8OjWOYzYu3MEMUiaKqQ=;
        b=LAGJMOjR+lX6HLkHRG7+9RxFtqCupeLxFM0akbNbwNcvph5c+cPeLTgOpFAY2iseIT
         RPLIySly60G5qVlYd/CRV6m2ub9B7Baz5nE6RhQyDLwbt8XI2JxFq9wCQ91csBfBwhoJ
         OJ6bWkPwZZ6jImfQEsWoK8wcMtHwca0S7bDfKw7xfXLGhyawO595/CFLdDMuPrKeNVUN
         0bV0Iv1sQ8zEmuiw3KfDYZDVq76zT1bnR5i4LnMwG1QxmmIFZHBffL+ZW+YaXAjjUU3d
         eza9vwbsrDqqIXDmjWI4CJBK8dZ4sZx5RqjpwMBeOwC46TV4fd9vT++dMgooPDT55ImD
         eOcg==
X-Gm-Message-State: AOJu0YzxnWnWnCUtuQmqodQ0vqh7nUgrAagTCiHBLTgjWaSj5tIutfmL
	6LMRFyPUR/WsMJAbcu5f4i/bsPRv63E=
X-Google-Smtp-Source: AGHT+IEDWNILRwLg9IzYLpjA+TBbhvVF+YYVYcGzrgKJoVtgGMBgs3b5C+TZUpouPPOJMB0hcG6UTQ==
X-Received: by 2002:a17:906:ef0c:b0:9c4:344e:b496 with SMTP id f12-20020a170906ef0c00b009c4344eb496mr7196337ejs.11.1699624487380;
        Fri, 10 Nov 2023 05:54:47 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id p27-20020a170906141b00b009adc5802d08sm3953133ejc.190.2023.11.10.05.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:54:46 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Chen Qi <Qi.Chen@windriver.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 1/5] runqueue: fix PSI check calculation
Date: Fri, 10 Nov 2023 14:54:33 +0100
Message-ID: <20231110135437.2902924-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 13:54:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15494

From: Chen Qi <Qi.Chen@windriver.com>

The current PSI check calculation does not take into consideration
the possibility of the time interval between last check and current
check being much larger than 1s. In fact, the current behavior does
not match what the manual says about BB_PRESSURE_MAX_XXX, even if
the value is set to upper limit, 1000000, we still get many blocks
on new task launch. The difference between 'total' should be divided
by the time interval if it's larger than 1s.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8605c46c8..3e89c38bc 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -198,15 +198,20 @@ class RunQueueScheduler(object):
                 curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split("=")[1]
                 curr_io_pressure = io_pressure_fds.readline().split()[4].split("=")[1]
                 curr_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
-                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
-                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
-                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
                 now = time.time()
-                if now - self.prev_pressure_time > 1.0:
+                tdiff = now - self.prev_pressure_time
+                if tdiff > 1.0:
+                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
+                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
+                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
                     self.prev_cpu_pressure = curr_cpu_pressure
                     self.prev_io_pressure = curr_io_pressure
                     self.prev_memory_pressure = curr_memory_pressure
                     self.prev_pressure_time = now
+                else:
+                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
+                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
+                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         return False
 
-- 
2.42.1


