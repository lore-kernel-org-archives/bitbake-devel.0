Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E558C4167B
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 17:26:04 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.21904.1670779562634862616
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Dec 2022 09:26:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bByg9hiY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id o15so3385549wmr.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 09:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzJKhI5x2wM0KlfreQ/LG9B3ZKXbCajAiy2YsNECXeQ=;
        b=bByg9hiYylQSbUWir1krn8blXzF+1BHLsTm65J0P0VO1ClDa1jOoe4vjwUxSgV9KCP
         iAs95O4QA+En+JZ09CvGV6w8rRjXZd2lpss+LSzJffbV3JSBdSoQRkhFvCLaXuv4Ku0z
         l6qZugqMVKD3o3tbZrlbUba2445+feIwU9E3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzJKhI5x2wM0KlfreQ/LG9B3ZKXbCajAiy2YsNECXeQ=;
        b=7Mp1sYUdi35dcp2npW/kAinMttWHln1oLoTZm8MTmR8eZWIlq3OoA40x4FVOYHyjPr
         N+mOfjwuSN5S4SiWtRddZquj7oBSWcCDENFUOI7dSkGti7t8frytFDfxFupmBrpFvcXm
         35uQQwAJ3YP6eS4N1bevi8OvHwuCSM4WCi6B/QGqp8GClogIfXU8DZFNCX7ARp2brYn8
         gzn/+t4NxJ+q28uUBOr1YYLyLivwCCeV9CE5jsVN3QS5QwW5QAoRdmqZ8Y6Dhyot4dL0
         lBFphCqO7B01w2tk2DyAAZphbP8ChSZi5XKCIE+8lX680131SRbBJQLFm2rZAD4tO4oS
         06Cg==
X-Gm-Message-State: ANoB5pmIOLV/5Sr4e9STtyaOSMK0FgdLLU+VvIna/UOK8wMMi/SMfUt+
	+b2FlhF70yGGRWMVxt3F9/VKPebz6pB1rs6V
X-Google-Smtp-Source: AA0mqf43XFGqBhs5XBUff/YirtDISBq4f5TJnESGFy+Yrk1rixLDfWo+4NSlQIcmLk+rzrs+BoFkoA==
X-Received: by 2002:a05:600c:3d12:b0:3cf:7903:5646 with SMTP id bh18-20020a05600c3d1200b003cf79035646mr10655804wmb.24.1670779560978;
        Sun, 11 Dec 2022 09:26:00 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:db5:b2f0:a022:4502])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c7906000000b003cf4eac8e80sm7592804wme.23.2022.12.11.09.26.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 09:26:00 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] siggen/runqueue: Switch to using RECIPE_SIGGEN_INFO feature for signature dumping
Date: Sun, 11 Dec 2022 17:25:55 +0000
Message-Id: <20221211172557.21956-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221211172557.21956-1-richard.purdie@linuxfoundation.org>
References: <20221211172557.21956-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 17:26:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14172

Now that we have cache support for the taskdep/gendep/lookupcache data,
we can switch to use that cooker feature and skip the secondary reparse to
write the sig files. This does make the initial parse longer but means the
secondary one isn't needed.

At present parsing with the larger cache isn't optimal but we have plans
in place which will make this faster than the current reparse code being
removed here.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py     |  5 +++++
 lib/bb/runqueue.py | 34 ++++++----------------------------
 lib/bb/siggen.py   | 39 +++++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 1e38d04bcf..ee12256bc8 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -395,6 +395,11 @@ def setup_bitbake(configParams, extrafeatures=None):
         # In status only mode there are no logs and no UI
         logger.addHandler(handler)
 
+    if configParams.dump_signatures:
+        if extrafeatures is None:
+            extrafeatures = []
+        extrafeatures.append(bb.cooker.CookerFeatures.RECIPE_SIGGEN_INFO)
+
     if configParams.server_only:
         featureset = []
         ui_module = None
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 991aa94f67..3f9c131fa0 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1608,39 +1608,17 @@ class RunQueue:
         else:
             self.rqexe.finish()
 
-    def rq_dump_sigfn(self, fn, options):
-        mc = bb.runqueue.mc_from_tid(fn)
-        the_data = self.cooker.databuilder.parseRecipe(fn, self.cooker.collections[mc].get_file_appends(fn))
-        siggen = bb.parse.siggen
-        dataCaches = self.rqdata.dataCaches
-        siggen.dump_sigfn(fn, dataCaches, options)
-
     def dump_signatures(self, options):
-        fns = set()
-        bb.note("Reparsing files to collect dependency data")
+        if bb.cooker.CookerFeatures.RECIPE_SIGGEN_INFO not in self.cooker.featureset:
+            bb.fatal("The dump signatures functionality needs the RECIPE_SIGGEN_INFO feature enabled")
 
+        bb.note("Writing task signature files")
         for tid in self.rqdata.runtaskentries:
-            fn = fn_from_tid(tid)
-            fns.add(fn)
-
-        max_process = int(self.cfgData.getVar("BB_NUMBER_PARSE_THREADS") or os.cpu_count() or 1)
-        # We cannot use the real multiprocessing.Pool easily due to some local data
-        # that can't be pickled. This is a cheap multi-process solution.
-        launched = []
-        while fns:
-            if len(launched) < max_process:
-                p = Process(target=self.rq_dump_sigfn, args=(fns.pop(), options))
-                p.start()
-                launched.append(p)
-            for q in launched:
-                # The finished processes are joined when calling is_alive()
-                if not q.is_alive():
-                    launched.remove(q)
-        for p in launched:
-                p.join()
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            dataCaches = self.rqdata.dataCaches
+            bb.parse.siggen.dump_sigtask(taskfn, taskname, dataCaches[mc].stamp[fn], True)
 
         bb.parse.siggen.dump_sigs(self.rqdata.dataCaches, options)
-
         return
 
     def print_diffscenetasks(self):
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index e57f1ffe69..6b73843c67 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -335,8 +335,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.unihash_cache.copyfile(targetdir)
 
     def dump_sigtask(self, fn, task, stampbase, runtime):
-
         tid = fn + ":" + task
+        mc = bb.runqueue.mc_from_tid(fn)
         referencestamp = stampbase
         if isinstance(runtime, str) and runtime.startswith("customfile"):
             sigfile = stampbase
@@ -353,16 +353,27 @@ class SignatureGeneratorBasic(SignatureGenerator):
         data['task'] = task
         data['basehash_ignore_vars'] = self.basehash_ignore_vars
         data['taskhash_ignore_tasks'] = self.taskhash_ignore_tasks
-        data['taskdeps'] = self.taskdeps[fn][task]
+        if hasattr(self, "datacaches"):
+            data['taskdeps'] = self.datacaches[mc].siggen_taskdeps[fn][task]
+        else:
+            data['taskdeps'] = self.taskdeps[fn][task]
         data['basehash'] = self.basehash[tid]
         data['gendeps'] = {}
         data['varvals'] = {}
-        data['varvals'][task] = self.lookupcache[fn][task]
-        for dep in self.taskdeps[fn][task]:
-            if dep in self.basehash_ignore_vars:
-                continue
-            data['gendeps'][dep] = self.gendeps[fn][dep]
-            data['varvals'][dep] = self.lookupcache[fn][dep]
+        if hasattr(self, "datacaches"):
+            data['varvals'][task] = self.datacaches[mc].siggen_varvals[fn][task]
+            for dep in self.datacaches[mc].siggen_taskdeps[fn][task]:
+                if dep in self.basehash_ignore_vars:
+                   continue
+                data['gendeps'][dep] = self.datacaches[mc].siggen_gendeps[fn][dep]
+                data['varvals'][dep] = self.datacaches[mc].siggen_varvals[fn][dep]
+        else:
+            data['varvals'][task] = self.lookupcache[fn][task]
+            for dep in self.taskdeps[fn][task]:
+                if dep in self.basehash_ignore_vars:
+                    continue
+                data['gendeps'][dep] = self.gendeps[fn][dep]
+                data['varvals'][dep] = self.lookupcache[fn][dep]
 
         if runtime and tid in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[tid]
@@ -409,18 +420,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 pass
             raise err
 
-    def dump_sigfn(self, fn, dataCaches, options):
-        if fn in self.taskdeps:
-            for task in self.taskdeps[fn]:
-                tid = fn + ":" + task
-                mc = bb.runqueue.mc_from_tid(tid)
-                if tid not in self.taskhash:
-                    continue
-                if dataCaches[mc].basetaskhash[tid] != self.basehash[tid]:
-                    bb.error("Bitbake's cached basehash does not match the one we just generated (%s)!" % tid)
-                    bb.error("The mismatched hashes were %s and %s" % (dataCaches[mc].basetaskhash[tid], self.basehash[tid]))
-                self.dump_sigtask(fn, task, dataCaches[mc].stamp[fn], True)
-
 class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
     name = "basichash"
 
-- 
2.37.2


