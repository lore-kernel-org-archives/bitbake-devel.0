Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96392C4167B
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 22:57:40 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.107243.1699484254803375558
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Nov 2023 14:57:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=gqIGEtcR;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.171, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso209038b3a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 14:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1699484254; x=1700089054; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paRCHmTjl/nRAYAvObadS4SjMzK40IWkYOKYb8S02QE=;
        b=gqIGEtcR2Pk2Zfsp0LQmKm6U4QLq9/oblSL1Euu5dlEZgkxtokJqvG2TKcN6BWCrFs
         pQmHL9gRgYoVCFZ7SyrFf6Z9bzol26fUAYX2Scuaa5b0t6fgDJJ/sQJhc2JX/8o0MzqS
         SKxx/U2NYdVOfXMm+5TuURykIeVtRtNHKwG9v4TxHKUJTDO9HfOIWOkXZ/xoiPoTP9q3
         SrMuekzYuDU1sGr99ydG/IQS4TV7KH58RewqDB3Y6hiobAl4DZwh5JaeeXxPNG/i3Tiq
         ZuECny0Fc4ntuY5ob8n+8TpPUVU+UKXhX3VTTexsi6Ulb1RcukwrWjuGQ3K5MP2qPno1
         GJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699484254; x=1700089054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paRCHmTjl/nRAYAvObadS4SjMzK40IWkYOKYb8S02QE=;
        b=gdfus3BMNs89qjjQN7eVww8sB8cmHu89gkAoqPTECnFD35CMG98/MehuQ4EGZNqjNB
         0WdazMVxtuznKnHyYS2rH0eDN0KwfpRpz7mMjSRALyg+q38Cyp1Iq09IkDgQJD3MW5XI
         9cDIJea6HGIn9mRbDBLK1Pw6KCL05I66PJaLgbI8BIow5NKl7ZOj1AvO1nLFDDUYnHrD
         gZdLE6d/ihxZVKUOW69BCli+jZsFoOBj14o0Mw4ZQ5+r2KPH7DI4jY8DBFP18O0+HAq3
         8CyFkkBldadHOBWbdHozFa9k8QyGXE3SSyDuba+AyVQ1xUcSVKV+0h09JpifawpseuQA
         Wigg==
X-Gm-Message-State: AOJu0YzhX9FUbc9m5tRf5HLMfB6lsmUJcETqZDlwlwpe0IDDuY/aRN5u
	p4mJIJ0JTaksXpYZFokeKYdwvn+LJAmt3Tz+e5Gb3Q==
X-Google-Smtp-Source: AGHT+IH6y/osyXYlEXFZe2kp1ynOji9AGEHY1D3s1CO5D7nQR9rUb2u51MB8Gd3suXqoaIhgxSCW3Q==
X-Received: by 2002:a05:6a21:35c4:b0:180:d66b:7f1 with SMTP id ba4-20020a056a2135c400b00180d66b07f1mr3348991pzc.62.1699484253981;
        Wed, 08 Nov 2023 14:57:33 -0800 (PST)
Received: from hexa.lan (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a000bc600b006862b2a6b0dsm9798063pfu.15.2023.11.08.14.57.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:57:33 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 3/3] runqueue: convert deferral messages from bb.note to bb.debug
Date: Wed,  8 Nov 2023 12:57:21 -1000
Message-Id: <3505d8d8c02b041946670ab6bc5751e54fe292ff.1699484095.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699484095.git.steve@sakoman.com>
References: <cover.1699484095.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 22:57:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15455

From: Denys Dmytriyenko <denis@denix.org>

Using multiconfig to target baremetal pieces of the system and building
corresponding toolchains for them results in hundreds and hundreds of
"Deferring %s after %s" and "Deferred task %s now buildable".

To clean up the output and to reduce risk of missing important warnings,
convert these notice messages to debug messages.

Signed-off-by: Denys Dmytriyenko <denis@denix.org>
Signed-off-by: Denys Dmytriyenko <denys@konsulko.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 64bc00a46d1aacc23fe7e8d9a46a126f3a4bc318)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 46ff30a7..8605c46c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1980,12 +1980,12 @@ class RunQueueExecute:
                 # Allow the next deferred task to run. Any other deferred tasks should be deferred after that task.
                 # We shouldn't allow all to run at once as it is prone to races.
                 if not found:
-                    bb.note("Deferred task %s now buildable" % t)
+                    bb.debug(1, "Deferred task %s now buildable" % t)
                     del self.sq_deferred[t]
                     update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
                     found = t
                 else:
-                    bb.note("Deferring %s after %s" % (t, found))
+                    bb.debug(1, "Deferring %s after %s" % (t, found))
                     self.sq_deferred[t] = found
 
     def task_complete(self, task):
@@ -2892,7 +2892,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 sqdata.hashes[h] = tid
             else:
                 sqrq.sq_deferred[tid] = sqdata.hashes[h]
-                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
+                bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashes[h]))
 
     update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True)
 
-- 
2.34.1


