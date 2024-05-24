Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B06C25B7F
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:12:12 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.18339.1716563525636364023
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 08:12:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CsjBM4X6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-351b683f2d8so2754258f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716563524; x=1717168324; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMW549WOIBzOaANNltcjbXiOT7u1/Hm53BVpCCp1Al4=;
        b=CsjBM4X65Ehg+Eq0CawcdfnurUgep0EvRRzyau37Fe3j+uXS3+80CznWAGvsqcjajZ
         ouajk2kNMLsTxx3Ckv2wfmB9OaumpRIibCjpWgTyxitFlOM/WiZl56MPQ8FkDj+oeS7b
         mCVDgbaiIfeCWWLTVBsp7rOz6J4mYLKE28gEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563524; x=1717168324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMW549WOIBzOaANNltcjbXiOT7u1/Hm53BVpCCp1Al4=;
        b=Sh8mjK2T98RvqpPAjgTqQYN1I1i55h9GjMNBtHaAAoYTKGogaH+hDcVc543PU2DxVo
         aSxDT1kJT2xH9dNQqUGbxX9UhSEFeakvyjCTl4w7FMK7353QHRiX+sAbknVJGML3/80w
         SbhCG1SuUwIwfuahRGUGTIBOJxs1xtSIAulmuyMvO2b/oekB34SfAEzN533s3CGCx+dS
         +WyrDf7vthRhb9k6jjAKMJVpoc35APUsjfE4kX6Ld6jHqk/aNRePEy8FY1ziz3FsAm4i
         KQMKV7mnLF/iKWnv8qIbSEpaPsGBuD/N8Qp4cmnVesENMBBqVw0s5WAI4cXvcTSMbcl7
         ykRA==
X-Gm-Message-State: AOJu0Yxhp/9vtjAHpX5nZsOGAmVeZIKkGO1pTJseWt8I5XGDGYI0CG4H
	3krKtIaLsKOJqqMPJ+nB8vvFOkssjlN3oBxSEef7GqC/ZfJH0Owc7MazmnU4zinEnKmM94jrUvl
	V
X-Google-Smtp-Source: AGHT+IEJLZNl3ikiBpGgP+F2mPeA6aiHEXlCpJzj4JbIHfihoKPRT7itf0hzajYmLX/uB4+xBarFsA==
X-Received: by 2002:adf:a44a:0:b0:355:41b:d38e with SMTP id ffacd0b85a97d-35527047b2dmr1610454f8f.36.1716563523929;
        Fri, 24 May 2024 08:12:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9ca4:3686:8521:57da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db23sm1841759f8f.23.2024.05.24.08.12.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:12:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/6] runqueue: Process unihashes in parallel at init
Date: Fri, 24 May 2024 16:11:58 +0100
Message-Id: <20240524151200.2449512-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
References: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16258

Improve the runqueue init code to call unihash queries in parallel since
this is faster and more efficient, particularly on slower links with longer
round trip times.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 586b11da2d..411c47eff9 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1280,11 +1280,18 @@ class RunQueueData:
         dealtwith = set()
         todeal = set(self.runtaskentries)
         while todeal:
+            ready = set()
             for tid in todeal.copy():
                 if not (self.runtaskentries[tid].depends - dealtwith):
-                    dealtwith.add(tid)
-                    todeal.remove(tid)
-                    self.prepare_task_hash(tid)
+                    self.runtaskentries[tid].taskhash_deps = bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
+                    # get_taskhash for a given tid *must* be called before get_unihash* below
+                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
+                    ready.add(tid)
+            unihashes = bb.parse.siggen.get_unihashes(ready)
+            for tid in ready:
+                dealtwith.add(tid)
+                todeal.remove(tid)
+                self.runtaskentries[tid].unihash = unihashes[tid]
 
             bb.event.check_for_interrupts(self.cooker.data)
 
@@ -1301,11 +1308,6 @@ class RunQueueData:
         #self.dump_data()
         return len(self.runtaskentries)
 
-    def prepare_task_hash(self, tid):
-        self.runtaskentries[tid].taskhash_deps = bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
-        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
-        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
-
     def dump_data(self):
         """
         Dump some debug information on the internal data structures
-- 
2.40.1


