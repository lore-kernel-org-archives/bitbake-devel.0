Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2802C04A95
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 13:54:55 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.27575.1699624492287621914
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 05:54:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FHSREFiT;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so326940466b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699624491; x=1700229291; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Ssk5ZljAlHZY1sVbMulbCihTS3HypldkckMP8jM9A=;
        b=FHSREFiTTC3no9xG/FaXHaQuBKb4Bc4v4pVlvMpdUvV9HktdZvftR1hrWoBw5p5UKd
         28QoFYE+F72qhvtKA8+3umxo9s1O0ZPhVN35Rw/nezux1HJUlgjhY6t5TNx7lx6NOmyb
         AVoLZhOI+tb1ix1ZyRnJrShSJgJ/9m2OmwjbEIKUuq4jtUQPXbPYgSZwnJS2H6vLoa70
         bb8O9niEk8tws6vsuwRuu4teBTeScFjPoOquIwXNiLals99NMdbEOs0/HY69fKij079W
         jFjUCSmzn5Uml1Dy9JPjp3H6SAD31jBNLmLGfdODp9yfBUvevsDnpPRKwpjO/vUr5s58
         73ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624491; x=1700229291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/Ssk5ZljAlHZY1sVbMulbCihTS3HypldkckMP8jM9A=;
        b=LbHAiNAZaPQhiLLdE++trd9OzMZzhKXUIQMmmBwqFh7KvWSGweVnM5AfAui4ztPpEo
         +RKuMdt4DekU++lrgMWWKv+RhLTxkM3KkVabyPrsJloa7nSraAur90h5gOJsMmdTEFCg
         l+hmUQMwqgzPxXh5/LUpJXNQMnxvYEMol+uYr0Zfw4/VSlTNNKTTEASgiF4qoZzJPhzz
         XRqPCsRYaGY+2qC/9M5RDejae/Sdsc7ACZd9AaA6hqamu+JzQTVnpNB5arTe74Q63BeC
         q1OfZCqgnhpTgCvkuCexISl/kt1JwfdS62wbA0Jb/lAFQTY2p1SDnEXwWDf/84M2P+O2
         gjcw==
X-Gm-Message-State: AOJu0YxZIAq5+3deGuaIZTjiPH4Z6ecGQqcp8uqLJSJSDEP41e1q0xrP
	ZOb2f9XlI8CrVih+QAz1qAK62R3++8U=
X-Google-Smtp-Source: AGHT+IG/J3517KKxZRqOCKFpUkCWgvCsCgLJui71S1Ti7Ot04oc0FdWcIZ3tJApxtRJUTeeWODiJrA==
X-Received: by 2002:a17:906:4a95:b0:9e5:fdd7:f521 with SMTP id x21-20020a1709064a9500b009e5fdd7f521mr1469820eju.41.1699624490766;
        Fri, 10 Nov 2023 05:54:50 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906685100b009aa292a2df2sm3973000ejs.217.2023.11.10.05.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:54:50 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Martin Jansa <Martin.Jansa@gmail.com>
Subject: [2.0][PATCH 5/5] runqueue: show number of currently running bitbake threads when pressure changes
Date: Fri, 10 Nov 2023 14:54:37 +0100
Message-ID: <20231110135437.2902924-5-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231110135437.2902924-1-martin.jansa@gmail.com>
References: <20231110135437.2902924-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 13:54:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15498

From: Martin Jansa <Martin.Jansa@gmail.com>

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
index e01c496c4..0b6eddd45 100644
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
2.42.1


