Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCEC04E83
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 13:54:55 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.27841.1699624490132443519
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 05:54:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=faSgUVY+;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9e28724ac88so341238666b.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 05:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699624488; x=1700229288; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bE4iSbRE95DYeQJn9m9ODF0mx/nr33IC05l3IylHnVg=;
        b=faSgUVY+oOPmGD9W8lMZ7P/cXnd5IcaMXDaBSd5fOcSp8BwTaXwsNniXkcde40oT8K
         q1YWfScGnw7B1gixHO5esUJuAgXcsQNi2nAipRoaUez0hyBBLZhPObgsbVrt0vY0NTy9
         iZt0r4jpLk5asubAu88bpPlPqLFr6WKbFd2+36Ak2/TvHkmNJEih40ce9Iy8p0jCycDe
         8jXeWDKJ1l6WyQ55lgHy4W6eZwgFgcImN1RTVahqqm8gQhq2IHQY58cF09Fxv51R8Na9
         r4zRlckU0MXKjsbTZX3NZoXeLaawu1ABLdy6+EW6TVeIqA1r1bNwXDAAim5doUHShaFf
         Gjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699624488; x=1700229288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE4iSbRE95DYeQJn9m9ODF0mx/nr33IC05l3IylHnVg=;
        b=RuLuPDIi7RUjdBvvRg+AFh7sU+aEBGEHDoN5AqLSOv3Tj4JSgTsnmrpmHOjCVtWXfb
         OdkXxXcgRZEf0Qt3bHJNvMqpCypv9rGKIqUBnADQMSs44vuqlKJD4WsuNjAzra7ldR4m
         /gUBFxe9zVwZjgnoSJE0M9Fvl/J+f3FjL8S9Z3N+RpsIrAXSQprVB+qhWphpYtgaBBDN
         /RIsN8pzzU4MunmF1M/rvPTp7JEWhl1EDvU777bYG+tgvUKmFJeJMuZYT695wzfcSK2/
         TrGnZaiHEKL1BqU+j+z+PtaaGxonK1Gu32KUIvWUZjkppQLfEgfLtv/uInEUoneT5RWX
         VH8Q==
X-Gm-Message-State: AOJu0Yx2oVXYFVCcv6o5ACXiB40vngYJfD93IjJTTPSLt3wQoS2s7HzT
	p+MhYGEqcG9cnM97gzb4dfgaJ4xBwXI=
X-Google-Smtp-Source: AGHT+IGBV4Mt8nIT/m+VCC2SqmUzCYM0bJDbmz64CmPIbicyme1L4+cYgx0mgkIWhr9Jutg/mLdZJA==
X-Received: by 2002:a17:907:7255:b0:9de:dc3d:3b2 with SMTP id ds21-20020a170907725500b009dedc3d03b2mr7228319ejc.16.1699624488384;
        Fri, 10 Nov 2023 05:54:48 -0800 (PST)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090791cd00b009e5f5efac10sm1070923ejz.208.2023.11.10.05.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:54:47 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH 2/5] runqueue: Add pressure change logging
Date: Fri, 10 Nov 2023 14:54:34 +0100
Message-ID: <20231110135437.2902924-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231110135437.2902924-1-martin.jansa@gmail.com>
References: <20231110135437.2902924-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 13:54:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15495

From: Richard Purdie <richard.purdie@linuxfoundation.org>

It is currently hard to tell when bitbake is throttling task execution
due to system pressure changes. Add notes to the console output to make
this clearer, only generating output when the values change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3e89c38bc..ab9e3fbe8 100644
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
2.42.1


