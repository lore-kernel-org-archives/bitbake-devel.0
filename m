Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A4ED2B933
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 13:55:09 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.18534.1730814904936639527
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 05:55:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ao0+2Tfu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431481433bdso48701805e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730814903; x=1731419703; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdhzT21XL0HT/AMj3Zzo7uwKlIuBH03eQtczQ3+0Mi8=;
        b=ao0+2Tfu1a/TIgkjpmlIFed5ipZ6y/W4xz18o4OuE0Hqdpmfwkjik6AzU/a8WTr/Jl
         gIVk4EwrT6hHP24ty/Rd+k/jnPQcm7JRdW8CiT/N0MU3R46qyR2ICQrDYTx49LAh0+om
         s+XiWue8VIg3oKmbTrF/xhiM+6ojbaGrsJbr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730814903; x=1731419703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdhzT21XL0HT/AMj3Zzo7uwKlIuBH03eQtczQ3+0Mi8=;
        b=WMLFwegWsa5AxG/khnpDFSdL7P+H7nDa3Olds2p9Ue5Yqq/OiZj6ImdPr9f4Zt5I+Q
         7DUoGDBd4ZmNm+a492VjIVNWyGB0oqtYRuT8CWvcviFtudeZbxUquT2iHDBxZ2xeCaKk
         ycmkmbrerCxBwl2uv9mHQl4kVUiDVplLN7XYtytAdpcxqCuDxs/0Fvc3ok2egBQJl2+w
         +6H6l/mkASPt3COe/xd03qz7G/jy6CegK8g5EVZztn7dDCI7BPUZUHBDSdZgjMMcoBqr
         sR3hna3KbXu/8QAgh8ogXkR0EsNrQVPyJgPj5xdH129P+5bbh5fUdlfZ6BeDUGVWOGF9
         ceQQ==
X-Gm-Message-State: AOJu0Yxb+Y7zERENgwt94Cw7DerczepGiBroAsSex5G41p4PsCPB64EC
	rP6SAHSPqRc5u6wP3rKwh1ljQ2QTI9LdeMu5PPRFnhbFk3dw0X2kTMQq6bWhck/jjGSphnCm+js
	TQjM=
X-Google-Smtp-Source: AGHT+IHTPAV+F/oO7i4NG1wWROIxA/109X9BsZkLcvtb8FGDe4H/juOfyFYBeqS3OSED2+AaAbFbig==
X-Received: by 2002:a05:6000:4601:b0:381:e702:af15 with SMTP id ffacd0b85a97d-381e702b189mr134582f8f.37.1730814902675;
        Tue, 05 Nov 2024 05:55:02 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7614:7622:3cf4:a240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b65sm16634414f8f.4.2024.11.05.05.55.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:55:02 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] runqueue: Avoid dumpsigs idle loop blocking
Date: Tue,  5 Nov 2024 13:55:01 +0000
Message-ID: <20241105135501.2754494-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 13:55:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16775

We're seeing some failures on hosts where slow "idle" loop iterations are
causing bitbake server timeouts. These seem to happen particularly in the
dump_signatures() function within runqueue.

That isn't entirely surprising since it creates a pool of threads to execute
work an at best can take around 10s to execture and return control backto the
main loop. On a slow system, it is understandable this can take longer,
particularly as these functions are creating large chunks of IO.

Since the work is being done in threads, we can launch them, return to idle
and check on the results periodically as they complete.

This should hopefully address some of the remaining timeout issues we see on
the autobuilder in oe-selftest sstate tests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 73 ++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3462ed4457..1b5b58f352 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -128,6 +128,7 @@ class RunQueueStats:
 # runQueue state machine
 runQueuePrepare = 2
 runQueueSceneInit = 3
+runQueueDumpSigs = 4
 runQueueRunning = 6
 runQueueFailed = 7
 runQueueCleanUp = 8
@@ -1588,14 +1589,19 @@ class RunQueue:
             self.rqdata.init_progress_reporter.next_stage()
             self.rqexe = RunQueueExecute(self)
 
-            dump = self.cooker.configuration.dump_signatures
-            if dump:
+            dumpsigs = self.cooker.configuration.dump_signatures
+            if dumpsigs:
                 self.rqdata.init_progress_reporter.finish()
-                if 'printdiff' in dump:
-                    invalidtasks = self.print_diffscenetasks()
-                self.dump_signatures(dump)
-                if 'printdiff' in dump:
-                    self.write_diffscenetasks(invalidtasks)
+                if 'printdiff' in dumpsigs:
+                    self.invalidtasks_dump = self.print_diffscenetasks()
+                self.state = runQueueDumpSigs
+
+        if self.state is runQueueDumpSigs:
+            dumpsigs = self.cooker.configuration.dump_signatures
+            retval = self.dump_signatures(dumpsigs)
+            if retval is False:
+                if 'printdiff' in dumpsigs:
+                    self.write_diffscenetasks(self.invalidtasks_dump)
                 self.state = runQueueComplete
 
         if self.state is runQueueSceneInit:
@@ -1686,33 +1692,42 @@ class RunQueue:
             bb.parse.siggen.dump_sigtask(taskfn, taskname, dataCaches[mc].stamp[taskfn], True)
 
     def dump_signatures(self, options):
-        if bb.cooker.CookerFeatures.RECIPE_SIGGEN_INFO not in self.cooker.featureset:
-            bb.fatal("The dump signatures functionality needs the RECIPE_SIGGEN_INFO feature enabled")
-
-        bb.note("Writing task signature files")
-
-        max_process = int(self.cfgData.getVar("BB_NUMBER_PARSE_THREADS") or os.cpu_count() or 1)
-        def chunkify(l, n):
-            return [l[i::n] for i in range(n)]
-        tids = chunkify(list(self.rqdata.runtaskentries), max_process)
-        # We cannot use the real multiprocessing.Pool easily due to some local data
-        # that can't be pickled. This is a cheap multi-process solution.
-        launched = []
-        while tids:
-            if len(launched) < max_process:
-                p = Process(target=self._rq_dump_sigtid, args=(tids.pop(), ))
+        if not hasattr(self, "dumpsigs_launched"):
+            if bb.cooker.CookerFeatures.RECIPE_SIGGEN_INFO not in self.cooker.featureset:
+                bb.fatal("The dump signatures functionality needs the RECIPE_SIGGEN_INFO feature enabled")
+
+            bb.note("Writing task signature files")
+
+            max_process = int(self.cfgData.getVar("BB_NUMBER_PARSE_THREADS") or os.cpu_count() or 1)
+            def chunkify(l, n):
+                return [l[i::n] for i in range(n)]
+            dumpsigs_tids = chunkify(list(self.rqdata.runtaskentries), max_process)
+
+            # We cannot use the real multiprocessing.Pool easily due to some local data
+            # that can't be pickled. This is a cheap multi-process solution.
+            self.dumpsigs_launched = []
+
+            for tids in dumpsigs_tids:
+                p = Process(target=self._rq_dump_sigtid, args=(tids, ))
                 p.start()
-                launched.append(p)
-            for q in launched:
-                # The finished processes are joined when calling is_alive()
-                if not q.is_alive():
-                    launched.remove(q)
-        for p in launched:
+                self.dumpsigs_launched.append(p)
+
+            return 1.0
+
+        for q in self.dumpsigs_launched:
+            # The finished processes are joined when calling is_alive()
+            if not q.is_alive():
+                self.dumpsigs_launched.remove(q)
+
+        if self.dumpsigs_launched:
+            return 1.0
+
+        for p in self.dumpsigs_launched:
                 p.join()
 
         bb.parse.siggen.dump_sigs(self.rqdata.dataCaches, options)
 
-        return
+        return False
 
     def print_diffscenetasks(self):
         def get_root_invalid_tasks(task, taskdepends, valid, noexec, visited_invalid):

