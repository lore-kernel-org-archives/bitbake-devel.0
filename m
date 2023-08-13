Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B60C001B0
	for <webhook@archiver.kernel.org>; Sun, 13 Aug 2023 09:32:05 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.82371.1691919116640762375
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 13 Aug 2023 02:31:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZTPA8hiX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so34265865e9.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 13 Aug 2023 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691919115; x=1692523915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNn0jfJrdmDy68NjEk7eWcCKOlVI19CdtLqutPLgEkU=;
        b=ZTPA8hiXJ0pxAvchH/BJAtmbE0zUgS78BBYBVgE/8bxtvMivhWk22WHV55Cm7C49d2
         mo94tl8jQB1DYL9N78/OYGVe0x0lHjCBoW+KeAyL1+suke2pi6ZEpPA3l7fChts0pI9N
         s9xMZ2zwojb/g7h34cm7dDg+GopwioNPnDu50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691919115; x=1692523915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNn0jfJrdmDy68NjEk7eWcCKOlVI19CdtLqutPLgEkU=;
        b=bLaaxsITR3KUuUKWFEinB5XVZ20rRGvfZJeg6FQh5wJ8YWl1Ygux3FYpVluofpFPkh
         bvfy1cyoC0+KH2hEQtv0fE2kbFV4Sh5iSC0NISrb+5XKcypN7JeM3/2BWWH2d2GP4HB1
         +Alo6dbbd7BMTLo2NyIIeEf8RTu+WTZ6bsJRQAtFUMWXqFAIzVm597uNx2CC06cTC4vT
         mh/a4UmjBdKS9+9tlTQH1MdnTqVVw0zOH0S8ENn25w2yD+j7tFyXoDgt0+hlKf9dTzZD
         W2idqCeeB+TdHYcCR9QTfvDm2wZ5vnkW1isVqcckRgsVIxlJ6P6OuBwErjS2qFuNOO3e
         ittw==
X-Gm-Message-State: AOJu0YzaFEPebgGEajze2yQNK31LOW6TMYLnMyaEn/gQcbCIu1hZeEtI
	JR48GFXwQNZ10QlaVqbA37c4elLcSmCp71I+8d0=
X-Google-Smtp-Source: AGHT+IEkENnD87KzxsaKKdmYMo9U+OvfY2/9D9o1kquwuOLo2mfFXsFXEiVbY+uRrdqIOrjmupGgdw==
X-Received: by 2002:a7b:cd99:0:b0:3fe:63ca:ccf6 with SMTP id y25-20020a7bcd99000000b003fe63caccf6mr5427681wmj.16.1691919114516;
        Sun, 13 Aug 2023 02:31:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:17a:7286:2cf2:8a86])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003fe20533a1esm10821993wml.44.2023.08.13.02.31.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 02:31:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Update debug
Date: Sun, 13 Aug 2023 10:31:53 +0100
Message-Id: <20230813093153.129876-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 13 Aug 2023 09:32:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14939

The debug in the comments was out of date. It is still useful so update the
code sample to the new code needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index dcb1334e8d..879c136e18 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -261,10 +261,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
             bb.warn("Error during finalise of %s" % mcfn)
             raise
 
-        #Slow but can be useful for debugging mismatched basehashes
-        #for task in self.taskdeps[mcfn]:
-        #    self.dump_sigtask(mcfn, task, d.getVar("STAMP"), False)
-
         basehashes = {}
         for task in taskdeps:
             basehashes[task] = self.basehash[mcfn + ":" + task]
@@ -274,6 +270,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
         d.setVar("__siggen_varvals", lookupcache)
         d.setVar("__siggen_taskdeps", taskdeps)
 
+        #Slow but can be useful for debugging mismatched basehashes
+        #self.setup_datacache_from_datastore(mcfn, d)
+        #for task in taskdeps:
+        #    self.dump_sigtask(mcfn, task, d.getVar("STAMP"), False)
+
     def setup_datacache_from_datastore(self, mcfn, d):
         super().setup_datacache_from_datastore(mcfn, d)
 
-- 
2.39.2


