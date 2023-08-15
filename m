Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B89C0015E
	for <webhook@archiver.kernel.org>; Tue, 15 Aug 2023 10:01:01 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.131013.1692093652785990818
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Aug 2023 03:00:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=ahV0rK/p;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99d90ffed68so601379966b.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Aug 2023 03:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692093651; x=1692698451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9jpqmNo/kd9yXkxl+bI4eaLiDhbiJQCWQuJo0FP6ao=;
        b=ahV0rK/p8MZZqBk6uvAePUbilPSDRBSD62DsfyOfyr/OcARvl6k7YZ5vtaQkdBZ3AT
         qoVGWKaSn9GXYo18TWYYOgHoIXUuYhGJ0jU+lm0rXKGV2rNOWK6jXgQ8Gj6Bch0p784b
         1SEM1YwAQhaYpli89YbTWn4ZQA5lfPNkH694chd4SViyc++LFfvG+f9Qb5tR5Gzw6VtQ
         0PdswGPLO9TnmKsXax3Ufq1egeOJ0I7OehxyddReFMD446AlCWZhi7ufnlou+fX7enut
         qwFYJkSVqgHSxG43xy784lQEDwVnuY/Ar031281kPNib/xtEojCyifqKj0w5bmsDAnGd
         8fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692093651; x=1692698451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9jpqmNo/kd9yXkxl+bI4eaLiDhbiJQCWQuJo0FP6ao=;
        b=I5t7XTX94yDmVVveALoiUgM9zEoJyeEW9CqZyBSZL8h53jmWnh2Z8d1whFFQogL+0g
         J1E4XBwCkgfnfhyGxOOMyhRWLIjl5lCLC5SpUu2s6LQiuw18Vhy+fYdKxM1CxHCmMFbE
         F/LV6rvZya0ukWhO3Up9dLIwjVO1TCzUeWiOEZyAPyGFWWxYt8mS7bGDXTlRSw9srxG7
         Qr8LHU0eFvAW0aYFaLvv3WHiL0aYUDckB5MgBEFJy/Ej7SSiA0SKu2klMMVXKjrCNyR7
         4MuMbllG6Yr8chMGNvtjsj4TeHzq+6fWcIz75RLoapGnjo/RaD3dZTGk7xSL0HyjmUy7
         4HGA==
X-Gm-Message-State: AOJu0Yy+b2OVp/lbBvg3VWr/EgbxacUXMrmpbukQjhGrBX7ZedzLezuk
	JuBCyPAmDr2fDmiv0wZmhXkBMw4OgY4=
X-Google-Smtp-Source: AGHT+IGLqs5dQa8D4+FhN9HHNHYQ+fCozWxvBxJhFe7mw56KEUB6cvsT2yKSNSBzmsisCNYxOU++5A==
X-Received: by 2002:a17:907:a06a:b0:99c:602b:6a6d with SMTP id ia10-20020a170907a06a00b0099c602b6a6dmr1554927ejc.11.1692093651000;
        Tue, 15 Aug 2023 03:00:51 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id gs18-20020a170906f19200b00992e14af9b9sm6757106ejb.134.2023.08.15.03.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 03:00:50 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] runqueue: show more pressure data
Date: Tue, 15 Aug 2023 12:00:42 +0200
Message-ID: <20230815100042.2001376-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Aug 2023 10:01:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14941

* with latest bitbake I'm seeing very low number of bitbake tasks
  executed in parallel, probably due to pressure regulation
  show the values this is based on in the note

* also simplify a bit by counting the pressure and exceeds signs
  only once

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/runqueue.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 17da1bc1a..26c2d5177 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -201,21 +201,23 @@ class RunQueueScheduler(object):
                 now = time.time()
                 tdiff = now - self.prev_pressure_time
                 psi_accumulation_interval = 1.0
+                cpu_pressure = (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff
+                io_pressure = (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff
+                memory_pressure = (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff
+                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and cpu_pressure > self.rq.max_cpu_pressure
+                exceeds_io_pressure =  self.rq.max_io_pressure and io_pressure > self.rq.max_io_pressure
+                exceeds_memory_pressure =  self.rq.max_memory_pressure and memory_pressure > self.rq.max_memory_pressure
+
                 if tdiff > psi_accumulation_interval:
-                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
-                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
-                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
                     self.prev_cpu_pressure = curr_cpu_pressure
                     self.prev_io_pressure = curr_io_pressure
                     self.prev_memory_pressure = curr_memory_pressure
                     self.prev_pressure_time = now
-                else:
-                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > self.rq.max_cpu_pressure
-                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq.max_io_pressure
-                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff > self.rq.max_memory_pressure
+
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
+            pressure_values = (round(cpu_pressure,1), self.rq.max_cpu_pressure, round(io_pressure,1), self.rq.max_io_pressure, round(memory_pressure,1), self.rq.max_memory_pressure)
             if hasattr(self, "pressure_state") and pressure_state != self.pressure_state:
-                bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s" % pressure_state)
+                bb.note("Pressure status changed to CPU: %s, IO: %s, Mem: %s (CPU: %s/%s, IO: %s/%s, Mem: %s/%s)" % (pressure_state + pressure_values))
             self.pressure_state = pressure_state
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         return False
-- 
2.41.0


