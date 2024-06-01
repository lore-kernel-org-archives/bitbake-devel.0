Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D98C25B76
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:47 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.36153.1717244857739931887
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Q+h+Lkmt;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.181, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c8c880f526so178370a12.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244857; x=1717849657; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQ0ieBxiPaIdymhADC8YdicpJmdMNn4nMX++jkAN9Lw=;
        b=Q+h+LkmtyfNR5Wpcev8yatVIIeqWe1DSJgfF+rx5YJhkVgfgkmQsC7B5M+iAbpEsDb
         4/2jrI1/Gczdg5CHOfnVo8VLPlqTjTZvO0ip2gyGxCRx+ttNIn+nTvXuaIBuS8N5lTJw
         reudfO9/BYNtHAI3GkHm/tF0rjJml1uhc6raxVqfhm0hceCCLIhCCM/9znhu6oykLmSj
         N1Dp/Ak6lKagE4nizilIMGzQr1T+KbAj3jGNY3TSnHJR2OhJU9snRpR4LDHBgxfrSgqf
         u0VTt0B6FQsi2C6o06P9If6oKgKsytKmLo4l3P59HNUCF/eHfO99THn2TMVzgpZOcR5D
         yOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244857; x=1717849657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQ0ieBxiPaIdymhADC8YdicpJmdMNn4nMX++jkAN9Lw=;
        b=MRsyUo7TRuOLDrNbcGq8PChxX31Kw89qVW9C1jqW1zDvgGWIIZTT7atFKn0EyNXE4u
         OMuuJecVDMgs6dte69XYZG42ahWccXXRDA9rUAw0f94AobWoCS5KXipYc/EHTEGraxcC
         oljBJob3qJ06dM9cfCIWMBjrN4u5COIECFZjjpjis7wgfPtibhdnCdyufoAgNoE4bNVW
         phCVrVicBCwTgzzpfcXF4pk+GuDYMKLhk73mxUD4vh2tOpxghZB1R9n2VuT7zvrrpMQv
         OBe1X+i0UnTXgt8VlGO44bhXIdqtkJOnCuIufir4J35ocp+Hsqso9aie5UA9Gy+eOeLZ
         5EVA==
X-Gm-Message-State: AOJu0YyNymKh5nTAMVSLPhR+sVbHfZ3U4FC0kDDDCv7FbYelwXeF32Mv
	LYUaiUUgEBGVsuwsdjehfwyXM5RpZ+YjZGIRIbIXsBnZm9T4ljUn/NHpNm/niVAIl19gTAwyuhK
	g
X-Google-Smtp-Source: AGHT+IF3WtO0Sc5zsxVsglsGHO9wcXI3/fpw7gyGZyu4K9u/5nLIXFcrbvKV8W0YqPCdr2fBf/JFDw==
X-Received: by 2002:a05:6a20:6a21:b0:1ae:4264:a324 with SMTP id adf61e73a8af0-1b26f0f1b35mr5474654637.11.1717244857019;
        Sat, 01 Jun 2024 05:27:37 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:36 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 5/8] runqueue: Improve rehash get_unihash parallelism
Date: Sat,  1 Jun 2024 05:27:20 -0700
Message-Id: <37a94ab4ebdb34463394d714ca0b349547392b41.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717244760.git.steve@sakoman.com>
References: <cover.1717244760.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16309

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Improve the rehash code to query unihashes in parallel since this is more
efficient on slower links.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 999868dd7..47f48304e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2578,13 +2578,21 @@ class RunQueueExecute:
         while next:
             current = next.copy()
             next = set()
+            ready = {}
             for tid in current:
                 if self.rqdata.runtaskentries[p].depends and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
+                # get_taskhash for a given tid *must* be called before get_unihash* below
+                ready[tid] = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
+
+            unihashes = bb.parse.siggen.get_unihashes(ready.keys())
+
+            for tid in ready:
                 orighash = self.rqdata.runtaskentries[tid].hash
-                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
+                newhash = ready[tid]
                 origuni = self.rqdata.runtaskentries[tid].unihash
-                newuni = bb.parse.siggen.get_unihash(tid)
+                newuni = unihashes[tid]
+
                 # FIXME, need to check it can come from sstate at all for determinism?
                 remapped = False
                 if newuni == origuni:
-- 
2.34.1


