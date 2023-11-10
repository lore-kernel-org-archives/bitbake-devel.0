Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE1C4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 13:54:55 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web10.27573.1699624490691717507
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 05:54:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lQiJz5Cz;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so3361242a12.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699624489; x=1700229289; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI0KOUJltVijVagHWsEo8zxgJqvTT1b1HDhLCFNnixQ=;
        b=lQiJz5CzK/uRNxleTtA9MM8OQk+WpABq4Bz/FyTedVuEcPPCzQKyC0/PJ5/E+eZGRg
         bF6BmGfHOiWz50TqkweYrFb2gusjBjQV3XxZMYEhE28tJJCuS5X8/4pA3QNVhM6xSSz5
         utloQO2h1Dj7I2uqTugYdrpkZRTqPnLOaIFGfVgn2J/9eD3ZlrgQJGthFZ5FaolywoTl
         GsBpyjP4A9/FYKN+7qPI29kGpvJ1uQsYcb/4T/nLnagr2xwITJMn62Bco2iJib9bqTIp
         3xFIFzjqjj6+j4nJgApojFDiUE8OgRgpIYl67hw+RAnno2LYEWd6BfADqOqXrDR7Ju+x
         6gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624489; x=1700229289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI0KOUJltVijVagHWsEo8zxgJqvTT1b1HDhLCFNnixQ=;
        b=JP030jagfXFP+VoaOlqnkOc3nAWqoUKYxmO4kKd2DcR1YMsHQ09HCQ9oKymEx7P0QP
         pl2sJFK9M7Sk+Qn5/3pP9NJUx+HWrtuVSpdzojq6BrntVnoL18JUByHW/y5loM5PdrW3
         MNss1JHVcU6e8zJ+1nrXEffDa33BKBDcY+05+Hf+gi+6723DUe+oL/cON52Sd+7evlul
         JQJzfGiUdRm/9Ts+IVcCOs51WeA+YcFegcNYFVkMfJ2wvuPd9FSq7I8kYT0tzSeIxINH
         ERRKNfJMabe8FmCRIo4ZWkBUqYsXrHGBmCNZ0uIprYLZr/5yPkogsQUtLDnjsDhvN5qc
         XcDg==
X-Gm-Message-State: AOJu0YxoiFIaWoQCFcqfVmUa6jdtXremskeRrh4dgnKRh74iYbXvrF8/
	ZiUTVRWDXbanS9bHRpbC6YPYbON0Zzw=
X-Google-Smtp-Source: AGHT+IHkxpZ8oJK0tpbClQqWTGJP6Zf9VmKTfuXgUZxEiTMIltjAR0G6uI0Y5UWfw0GqDj9dXLkUtQ==
X-Received: by 2002:a50:9fc8:0:b0:543:6444:ef2a with SMTP id c66-20020a509fc8000000b005436444ef2amr6033449edf.32.1699624489183;
        Fri, 10 Nov 2023 05:54:49 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id s20-20020a50d494000000b005434e3d8e7bsm1195419edi.1.2023.11.10.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:54:48 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Chen Qi <Qi.Chen@windriver.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 3/5] runqueue.py: fix PSI check logic
Date: Fri, 10 Nov 2023 14:54:35 +0100
Message-ID: <20231110135437.2902924-3-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231110135437.2902924-1-martin.jansa@gmail.com>
References: <20231110135437.2902924-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 13:54:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15496

From: Chen Qi <Qi.Chen@windriver.com>

The current calculation is not correct because if tdiff is less than
1.0, it's not taken into consideration when calculating the current
pressure.

Also, make it clear that the 1.0s is the psi accumulation cycle,
which might be changed in the future. We have this cycle because it
could largely avoid the 0 result issue, that is, if the interval
between checks are too small, the result might be 0. With this
accumulation logic, which has been there but let's make it clear,
this 0 result problem could be mitigated.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ab9e3fbe8..830af8eef 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -200,7 +200,8 @@ class RunQueueScheduler(object):
                 curr_memory_pressure = memory_pressure_fds.readline().split()[4].split("=")[1]
                 now = time.time()
                 tdiff = now - self.prev_pressure_time
-                if tdiff > 1.0:
+                psi_accumulation_interval = 1.0
+                if tdiff > psi_accumulation_interval:
                     exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
                     exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
                     exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
@@ -209,9 +210,9 @@ class RunQueueScheduler(object):
                     self.prev_memory_pressure = curr_memory_pressure
                     self.prev_pressure_time = now
                 else:
-                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max_cpu_pressure
-                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_pressure
-                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > self.rq.max_memory_pressure
+                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
+                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
+                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
                 bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s" % pressure_state)
-- 
2.42.1


