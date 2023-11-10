Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D678C4167B
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 13:54:55 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.27574.1699624491601403220
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 05:54:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jt0zmJ1E;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-991c786369cso349506866b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699624490; x=1700229290; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0CC3wgvi5i52KcqgzGTU3OvQVAPBOJAc1whAOehGbU=;
        b=jt0zmJ1EDyHMi56JHP2dEU1vROmqGtCUfNOSeNlBFoTAKopPuLs8WJmDr5yDbDsMDu
         pq2+LKXiWUGuxEJXE4SumQjgW01oHO8Z4vGKoMQk8qsMpJh9qafAhNOZYF+ZUsOXR374
         NtnNkqvaLqXWunKV6XKcMJSZ7VeIPNvR4uiKL+v8wHPeaiUuRbyxlhiyBVEPw9dCo84p
         v4CZlnpRFSDNmAjWPSi42JFEt5hdvrqBd01+8CVEbZl+ylaQDHuxMHg9yN65UhJxKV6E
         rGPl2qHFA23pZEuljlPvKuvJoUC7mcv93D0E36tK38mL+fvurIWQzPOfA/ae7UmP4Av0
         m3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624490; x=1700229290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0CC3wgvi5i52KcqgzGTU3OvQVAPBOJAc1whAOehGbU=;
        b=WYQpwgduUZHNlRNCNddlCcb/u/8n8011PuNPO9lgDMWe5gjF+defz3Ug7u7JxlJSJk
         dQHQBplUusr7drq7OXt/doH6n4Y7XsLLvnnrksgRZxsdrZXQKgl3bXJ6WIhL0TMbKlZt
         UBGQwWRwjN/QsByKKyo/+RjPYphug7b1cWuRf0OqgTc7l2bKgWsPKc1aVW+83+KPa8Or
         DtEUwzgVY8dz2E0whGctn1a5ru5M5olt2GhPAImjMKcdCLAIJC9eaQ+ka0NDa+30uhVI
         jPaumjtLYI0PXVUQOMAhpPWOhgMeHjDzUFqA9NWlxHWq7aq2ugmFMt9Q7B9/Yxl4Nyr/
         0jgQ==
X-Gm-Message-State: AOJu0YwSpA0gz19viybEFW0zDoLI8WhK9loNADgPVwrsj9kFmuVdiTtj
	gYK2i3fhVY4V4hQKA/mIbSVvDFMZwbY=
X-Google-Smtp-Source: AGHT+IG09bz+yJL8wIylN5CRInDndUabq4hhODxlScu62Ccab3EbP1okC47d3kLtkkjV8ceZCa851Q==
X-Received: by 2002:a17:906:fe4c:b0:9d2:5cf8:e61 with SMTP id wz12-20020a170906fe4c00b009d25cf80e61mr6176482ejb.35.1699624489940;
        Fri, 10 Nov 2023 05:54:49 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906c08d00b009b928eb8dd3sm3936724ejz.163.2023.11.10.05.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:54:49 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Martin Jansa <Martin.Jansa@gmail.com>
Subject: [2.0][PATCH 4/5] runqueue: show more pressure data
Date: Fri, 10 Nov 2023 14:54:36 +0100
Message-ID: <20231110135437.2902924-4-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231110135437.2902924-1-martin.jansa@gmail.com>
References: <20231110135437.2902924-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 13:54:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15497

From: Martin Jansa <Martin.Jansa@gmail.com>

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
index 830af8eef..e01c496c4 100644
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
2.42.1


