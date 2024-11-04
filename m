Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A40D1BDD4
	for <webhook@archiver.kernel.org>; Mon,  4 Nov 2024 17:46:36 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.1837.1730742394118716779
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Nov 2024 09:46:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dfOtXs68;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fe76e802so5279444e87.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 Nov 2024 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730742392; x=1731347192; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rTaBb6ja2JoMBbc2vA7FZi9V2wo1fpimMOSw641ZluQ=;
        b=dfOtXs68sDMMS2p5bLsCDx3exR72kQPILOT50HnEwTAXKm9+40c4osbqe/w0i7zaGb
         QO+Z6AEmrMnFg69+zzTiXm6aNy+33aDmLb33+jOUsJUn3R1Mm9XcY+J7TWrd3+Fiii+c
         pdumHtHazuYsYZpvd6ex6NTBHep5O1gdBfosQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742392; x=1731347192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTaBb6ja2JoMBbc2vA7FZi9V2wo1fpimMOSw641ZluQ=;
        b=scRneFC330IbV5J+Kj8129MOtbRRJ+qWdMbH3b/aMeHtwMTkKblH6D2LriMGQznENP
         +loHEsQOCaeQs90vEfCIyRfmBNckbRVnNKOXKpMJg7Gm37HjKfKZS5WWP0nfQiM8WU8f
         FHx6oR2r396BEFaC23KIlY7yRm1HkHDLD9aAC7cu/og8TaYTGy7sa45D12PyrjV8EhDB
         4UWjVkusr6Upz/4Ik1rDoyCQFzkiy1wAciuUcFWQj/y8GHcydEZHUyYJEOxBZkLU7Dpk
         JdVqTPjIh1mBi44b2AXhtxk9kdriDwRG1/qH9IMEBIgyxa/g5LsZ02InFXcFtzf/Wcz/
         goBA==
X-Gm-Message-State: AOJu0Yx4fdeMQALkJTv0mEMwoDTuodidTj6qp8Y7B5tiW3LpjgszgwsR
	JccciHzAJtzFI9jGM8Y0mHIxkRDS2ZceLh7rJbEtE0FUr8n1Qq57qsYNyD5W33z9jZdOeUKt1rA
	25d4=
X-Google-Smtp-Source: AGHT+IEsbZx4wHs2T9+KAeT+fArQ8lHj62zQLDQQIYUmSm5i9Q9cM7C8l7/c2r0kQnyKMxQLvZ/fhg==
X-Received: by 2002:a05:6512:3d21:b0:53c:7363:90c with SMTP id 2adb3069b0e04-53d65df7d34mr6268708e87.35.1730742391324;
        Mon, 04 Nov 2024 09:46:31 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ce35:7d7b:4b91:8e7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca7ebsm190851955e9.42.2024.11.04.09.46.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:46:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Avoid dumpsigs idle loop blocking
Date: Mon,  4 Nov 2024 17:46:30 +0000
Message-ID: <20241104174630.1274186-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Nov 2024 17:46:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16774

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
 lib/bb/runqueue.py | 69 ++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3462ed4457..bee315c36d 100644
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
@@ -1588,13 +1589,18 @@ class RunQueue:
             self.rqdata.init_progress_reporter.next_stage()
             self.rqexe = RunQueueExecute(self)
 
-            dump = self.cooker.configuration.dump_signatures
-            if dump:
+            dumpsigs = self.cooker.configuration.dump_signatures
+            if dumpsigs:
                 self.rqdata.init_progress_reporter.finish()
-                if 'printdiff' in dump:
+                if 'printdiff' in dumpsigs:
                     invalidtasks = self.print_diffscenetasks()
-                self.dump_signatures(dump)
-                if 'printdiff' in dump:
+                self.state = runQueueDumpSigs
+
+        if self.state is runQueueDumpSigs:
+            dumpsigs = self.cooker.configuration.dump_signatures
+            retval = self.dump_signatures(dumpsigs)
+            if retval is False:
+                if 'printdiff' in dumpsigs:
                     self.write_diffscenetasks(invalidtasks)
                 self.state = runQueueComplete
 
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
+            for tid in dumpsigs_tids:
+                p = Process(target=self._rq_dump_sigtid, args=(dumpsigs_tids.pop(), ))
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

