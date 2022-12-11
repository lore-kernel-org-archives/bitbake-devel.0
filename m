Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51517C4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 17:26:14 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.21906.1670779564813578962
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Dec 2022 09:26:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bO5jt+wG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso1739930wmp.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcG5+dIPD0RZv5E+Ngq1mKSVq+31phAO1ZhwJW0xuIo=;
        b=bO5jt+wG9YKneKFyzy6xAVbzwXSLMBcWOuXoK7TVkcXpmW4G9PGPUxp5MuzGugE6bb
         +NzubX77bfgsmufzH+Yk442zgMPtVnoB8Vj63N7IdC2dm/AJp17p//Q8T4bn2m6qYpq0
         lWqnTpVjIO28wd2DLm53PL5IBQNfum8FIXVJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcG5+dIPD0RZv5E+Ngq1mKSVq+31phAO1ZhwJW0xuIo=;
        b=2SivKeMJ0AA1RWDg81+1MvBdpb0J0oiXnhPIDeNI3742JkSc5av9vcg20b+nHP3A0N
         WDFRYzrRnfJGDMw82TVHUrzJscx70O/E0oydvhs7kQoIIy5j72vkiWwG2i8r0QCT5dWJ
         HFYG/crvYRk0QYDGUzxUY2qcg8sDOpRJSQH9S8Ujwf1H0Thls8mIRJXj4vlS7H1BnmHD
         F45KsU+tulONorMNhm9Oo0rNy1ADQbHp9RERcVwsrlzaw+QCu20KdYa1C2Uxp6/F29Vo
         /flkTWL1nk0Iub2Sv/K+Z9u6YT66BbCioUoKqqb1a85fmpcmRIykjliwVNtEjf4PBJya
         nFmQ==
X-Gm-Message-State: ANoB5pnSivwH3ZqsYMDR1g+Blirte6l7V+XaXwULM8QlNqFZcI7a7uJL
	6ODjTUZ4FTBqc9o7RSO7X6E80R1pfdifR8YT
X-Google-Smtp-Source: AA0mqf4KW2Dn2jbtxaeNhkkuC+jX24URmbgI5qUNIuDl5jhVmYrMFLjDBaYRr0RMUz8MeLXxFk9sGg==
X-Received: by 2002:a05:600c:1826:b0:3cf:4eae:d59b with SMTP id n38-20020a05600c182600b003cf4eaed59bmr10586825wmp.34.1670779562458;
        Sun, 11 Dec 2022 09:26:02 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:db5:b2f0:a022:4502])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c7906000000b003cf4eac8e80sm7592804wme.23.2022.12.11.09.26.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 09:26:01 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/4] build/siggen: Rework stamps functions
Date: Sun, 11 Dec 2022 17:25:57 +0000
Message-Id: <20221211172557.21956-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221211172557.21956-1-richard.purdie@linuxfoundation.org>
References: <20221211172557.21956-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 17:26:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14174

The current method of passing either a task's datastore, or
dataCaches and a filename into the stamp functions is rather
horrible.

Due to the different contexts, fixing this is hard but we do control
the bitbake side of the API usage so we can migrate those to use other
functions and then only support a datastore in the public bb.build API
which is only called from task context in OE-Core.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py    | 149 +++++++++++++--------------------------------
 lib/bb/cooker.py   |   2 +-
 lib/bb/runqueue.py |  25 ++++----
 lib/bb/siggen.py   |  57 +++++++++++++++--
 4 files changed, 109 insertions(+), 124 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 5ac191647c..5a1727116a 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -772,44 +772,7 @@ def exec_task(fn, task, d, profile = False):
             event.fire(failedevent, d)
         return 1
 
-def stamp_internal(taskname, d, file_name, baseonly=False, noextra=False):
-    """
-    Internal stamp helper function
-    Makes sure the stamp directory exists
-    Returns the stamp path+filename
-
-    In the bitbake core, d can be a CacheData and file_name will be set.
-    When called in task context, d will be a data store, file_name will not be set
-    """
-    taskflagname = taskname
-    if taskname.endswith("_setscene"):
-        taskflagname = taskname.replace("_setscene", "")
-
-    if file_name:
-        stamp = d.stamp[file_name]
-        extrainfo = d.stamp_extrainfo[file_name].get(taskflagname) or ""
-    else:
-        stamp = d.getVar('STAMP')
-        file_name = d.getVar('BB_FILENAME')
-        extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info') or ""
-
-    if baseonly:
-        return stamp
-    if noextra:
-        extrainfo = ""
-
-    if not stamp:
-        return
-
-    stamp = bb.parse.siggen.stampfile(stamp, file_name, taskname, extrainfo)
-
-    stampdir = os.path.dirname(stamp)
-    if cached_mtime_noerror(stampdir) == 0:
-        bb.utils.mkdirhier(stampdir)
-
-    return stamp
-
-def stamp_cleanmask_internal(taskname, d, file_name):
+def _get_cleanmask(taskname, mcfn):
     """
     Internal stamp helper function to generate stamp cleaning mask
     Returns the stamp path+filename
@@ -817,27 +780,14 @@ def stamp_cleanmask_internal(taskname, d, file_name):
     In the bitbake core, d can be a CacheData and file_name will be set.
     When called in task context, d will be a data store, file_name will not be set
     """
-    taskflagname = taskname
-    if taskname.endswith("_setscene"):
-        taskflagname = taskname.replace("_setscene", "")
-
-    if file_name:
-        stamp = d.stampclean[file_name]
-        extrainfo = d.stamp_extrainfo[file_name].get(taskflagname) or ""
-    else:
-        stamp = d.getVar('STAMPCLEAN')
-        file_name = d.getVar('BB_FILENAME')
-        extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info') or ""
-
-    if not stamp:
-        return []
-
-    cleanmask = bb.parse.siggen.stampcleanmask(stamp, file_name, taskname, extrainfo)
-
-    return [cleanmask, cleanmask.replace(taskflagname, taskflagname + "_setscene")]
-
-def clean_stamp(task, d, file_name = None):
-    cleanmask = stamp_cleanmask_internal(task, d, file_name)
+    cleanmask = bb.parse.siggen.stampcleanmask_mcfn(taskname, mcfn)
+    taskflagname = taskname.replace("_setscene", "")
+    if cleanmask:
+        return [cleanmask, cleanmask.replace(taskflagname, taskflagname + "_setscene")]
+    return []
+
+def clean_stamp_mcfn(task, mcfn):
+    cleanmask = _get_cleanmask(task, mcfn)
     for mask in cleanmask:
         for name in glob.glob(mask):
             # Preserve sigdata files in the stamps directory
@@ -847,33 +797,46 @@ def clean_stamp(task, d, file_name = None):
             if name.endswith('.taint'):
                 continue
             os.unlink(name)
-    return
 
-def make_stamp(task, d, file_name = None):
+def clean_stamp(task, d):
+    mcfn = d.getVar('BB_FILENAME')
+    clean_stamp_mcfn(task, mcfn)
+
+def make_stamp_mcfn(task, mcfn):
+
+    basestamp = bb.parse.siggen.stampfile_mcfn(task, mcfn)
+
+    stampdir = os.path.dirname(basestamp)
+    if cached_mtime_noerror(stampdir) == 0:
+        bb.utils.mkdirhier(stampdir)
+
+    clean_stamp_mcfn(task, mcfn)
+
+    # Remove the file and recreate to force timestamp
+    # change on broken NFS filesystems
+    if basestamp:
+        bb.utils.remove(basestamp)
+        open(basestamp, "w").close()
+
+def make_stamp(task, d):
     """
     Creates/updates a stamp for a given task
-    (d can be a data dict or dataCache)
     """
-    clean_stamp(task, d, file_name)
+    mcfn = d.getVar('BB_FILENAME')
 
-    stamp = stamp_internal(task, d, file_name)
-    # Remove the file and recreate to force timestamp
-    # change on broken NFS filesystems
-    if stamp:
-        bb.utils.remove(stamp)
-        open(stamp, "w").close()
+    make_stamp_mcfn(task, mcfn)
 
     # If we're in task context, write out a signature file for each task
     # as it completes
-    if not task.endswith("_setscene") and not file_name:
-        stampbase = stamp_internal(task, d, None, True)
-        file_name = d.getVar('BB_FILENAME')
-        bb.parse.siggen.dump_sigtask(file_name, task, stampbase, True)
-
-def find_stale_stamps(task, d, file_name=None):
-    current = stamp_internal(task, d, file_name)
-    current2 = stamp_internal(task + "_setscene", d, file_name)
-    cleanmask = stamp_cleanmask_internal(task, d, file_name)
+    if not task.endswith("_setscene"):
+        stampbase = bb.parse.siggen.stampfile_base(mcfn)
+        bb.parse.siggen.dump_sigtask(mcfn, task, stampbase, True)
+
+
+def find_stale_stamps(task, mcfn):
+    current = bb.parse.siggen.stampfile_mcfn(task, mcfn)
+    current2 = bb.parse.siggen.stampfile_mcfn(task + "_setscene", mcfn)
+    cleanmask = _get_cleanmask(task, mcfn)
     found = []
     for mask in cleanmask:
         for name in glob.glob(mask):
@@ -887,38 +850,14 @@ def find_stale_stamps(task, d, file_name=None):
             found.append(name)
     return found
 
-def del_stamp(task, d, file_name = None):
-    """
-    Removes a stamp for a given task
-    (d can be a data dict or dataCache)
-    """
-    stamp = stamp_internal(task, d, file_name)
-    bb.utils.remove(stamp)
-
-def write_taint(task, d, file_name = None):
+def write_taint(task, d):
     """
     Creates a "taint" file which will force the specified task and its
     dependents to be re-run the next time by influencing the value of its
     taskhash.
-    (d can be a data dict or dataCache)
-    """
-    import uuid
-    if file_name:
-        taintfn = d.stamp[file_name] + '.' + task + '.taint'
-    else:
-        taintfn = d.getVar('STAMP') + '.' + task + '.taint'
-    bb.utils.mkdirhier(os.path.dirname(taintfn))
-    # The specific content of the taint file is not really important,
-    # we just need it to be random, so a random UUID is used
-    with open(taintfn, 'w') as taintf:
-        taintf.write(str(uuid.uuid4()))
-
-def stampfile(taskname, d, file_name = None, noextra=False):
-    """
-    Return the stamp for a given task
-    (d can be a data dict or dataCache)
     """
-    return stamp_internal(taskname, d, file_name, noextra=noextra)
+    mcfn = d.getVar('BB_FILENAME')
+    bb.parse.siggen.invalidate_task(task, mcfn)
 
 def add_tasks(tasklist, d):
     task_deps = d.getVar('_task_deps', False)
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ac7ac20c04..d96afcc669 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1453,7 +1453,7 @@ class BBCooker:
         # Invalidate task for target if force mode active
         if self.configuration.force:
             logger.verbose("Invalidate task %s, %s", task, fn)
-            bb.parse.siggen.invalidate_task(task, self.recipecaches[mc], fn)
+            bb.parse.siggen.invalidate_task(task, fn)
 
         # Setup taskdata structure
         taskdata = {}
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3f9c131fa0..a336528785 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -155,7 +155,7 @@ class RunQueueScheduler(object):
         self.stamps = {}
         for tid in self.rqdata.runtaskentries:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-            self.stamps[tid] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
+            self.stamps[tid] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
             if tid in self.rq.runq_buildable:
                 self.buildable.append(tid)
 
@@ -937,7 +937,7 @@ class RunQueueData:
                     bb.debug(1, "Task %s is marked nostamp, cannot invalidate this task" % taskname)
             else:
                 logger.verbose("Invalidate task %s, %s", taskname, fn)
-                bb.parse.siggen.invalidate_task(taskname, self.dataCaches[mc], taskfn)
+                bb.parse.siggen.invalidate_task(taskname, taskfn)
 
         self.target_tids = []
         for (mc, target, task, fn) in self.targets:
@@ -1398,7 +1398,7 @@ class RunQueue:
         if taskname is None:
             taskname = tn
 
-        stampfile = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn)
+        stampfile = bb.parse.siggen.stampfile_mcfn(taskname, taskfn)
 
         # If the stamp is missing, it's not current
         if not os.access(stampfile, os.F_OK):
@@ -1421,8 +1421,8 @@ class RunQueue:
         for dep in self.rqdata.runtaskentries[tid].depends:
             if iscurrent:
                 (mc2, fn2, taskname2, taskfn2) = split_tid_mcfn(dep)
-                stampfile2 = bb.build.stampfile(taskname2, self.rqdata.dataCaches[mc2], taskfn2)
-                stampfile3 = bb.build.stampfile(taskname2 + "_setscene", self.rqdata.dataCaches[mc2], taskfn2)
+                stampfile2 = bb.parse.siggen.stampfile_mcfn(taskname2, taskfn2)
+                stampfile3 = bb.parse.siggen.stampfile_mcfn(taskname2 + "_setscene", taskfn2)
                 t2 = get_timestamp(stampfile2)
                 t3 = get_timestamp(stampfile3)
                 if t3 and not t2:
@@ -2142,7 +2142,7 @@ class RunQueueExecute:
                 self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
-            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
+            self.build_stamps[task] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
             self.build_stamps2.append(self.build_stamps[task])
             self.sq_running.add(task)
             self.sq_live.add(task)
@@ -2202,7 +2202,7 @@ class RunQueueExecute:
                 self.runq_running.add(task)
                 self.stats.taskActive()
                 if not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
-                    bb.build.make_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
+                    bb.build.make_stamp_mcfn(taskname, taskfn)
                 self.task_complete(task)
                 return True
             else:
@@ -2241,7 +2241,7 @@ class RunQueueExecute:
                 self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
-            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
+            self.build_stamps[task] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
             self.build_stamps2.append(self.build_stamps[task])
             self.runq_running.add(task)
             self.stats.taskActive()
@@ -2498,7 +2498,7 @@ class RunQueueExecute:
                 self.scenequeue_notneeded.remove(tid)
 
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-            self.sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", self.rqdata.dataCaches[mc], taskfn, noextra=True)
+            self.sqdata.stamps[tid] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
 
             if tid in self.stampcache:
                 del self.stampcache[tid]
@@ -2814,7 +2814,8 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
         realtid = tid + "_setscene"
         idepends = rqdata.taskData[mc].taskentries[realtid].idepends
-        sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", rqdata.dataCaches[mc], taskfn, noextra=True)
+        sqdata.stamps[tid] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
+
         for (depname, idependtask) in idepends:
 
             if depname not in rqdata.taskData[mc].build_targets:
@@ -2893,7 +2894,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     found = {}
     for tid in rqdata.runq_setscene_tids:
         (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-        stamps = bb.build.find_stale_stamps(taskname, rqdata.dataCaches[mc], taskfn)
+        stamps = bb.build.find_stale_stamps(taskname, taskfn)
         if stamps:
             if mc not in found:
                 found[mc] = {}
@@ -2909,7 +2910,7 @@ def check_setscene_stamps(tid, rqdata, rq, stampcache, noexecstamp=False):
     taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
 
     if 'noexec' in taskdep and taskname in taskdep['noexec']:
-        bb.build.make_stamp(taskname + "_setscene", rqdata.dataCaches[mc], taskfn)
+        bb.build.make_stamp_mcfn(taskname + "_setscene", taskfn)
         return True, False
 
     if rq.check_stamp_task(tid, taskname + "_setscene", cache=stampcache):
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index a63e37d22f..513f3811a1 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -106,17 +106,51 @@ class SignatureGenerator(object):
         """Write/update the file checksum cache onto disk"""
         return
 
+    def stampfile_base(self, mcfn):
+        mc = bb.runqueue.mc_from_tid(mcfn)
+        return self.datacaches[mc].stamp[mcfn]
+
+    def stampfile_mcfn(self, taskname, mcfn, extrainfo=True):
+        mc = bb.runqueue.mc_from_tid(mcfn)
+        stamp = self.datacaches[mc].stamp[mcfn]
+        if not stamp:
+            return
+
+        stamp_extrainfo = ""
+        if extrainfo:
+            taskflagname = taskname
+            if taskname.endswith("_setscene"):
+                taskflagname = taskname.replace("_setscene", "")
+            stamp_extrainfo = self.datacaches[mc].stamp_extrainfo[mcfn].get(taskflagname) or ""
+
+        return self.stampfile(stamp, mcfn, taskname, stamp_extrainfo)
+
     def stampfile(self, stampbase, file_name, taskname, extrainfo):
         return ("%s.%s.%s" % (stampbase, taskname, extrainfo)).rstrip('.')
 
+    def stampcleanmask_mcfn(self, taskname, mcfn):
+        mc = bb.runqueue.mc_from_tid(mcfn)
+        stamp = self.datacaches[mc].stamp[mcfn]
+        if not stamp:
+            return []
+
+        taskflagname = taskname
+        if taskname.endswith("_setscene"):
+            taskflagname = taskname.replace("_setscene", "")
+        stamp_extrainfo = self.datacaches[mc].stamp_extrainfo[mcfn].get(taskflagname) or ""
+
+        return self.stampcleanmask(stamp, mcfn, taskname, stamp_extrainfo)
+
     def stampcleanmask(self, stampbase, file_name, taskname, extrainfo):
         return ("%s.%s.%s" % (stampbase, taskname, extrainfo)).rstrip('.')
 
     def dump_sigtask(self, fn, task, stampbase, runtime):
         return
 
-    def invalidate_task(self, task, d, fn):
-        bb.build.del_stamp(task, d, fn)
+    def invalidate_task(self, task, mcfn):
+        mc = bb.runqueue.mc_from_tid(mcfn)
+        stamp = self.datacaches[mc].stamp[mcfn]
+        bb.utils.remove(stamp)
 
     def dump_sigs(self, dataCache, options):
         return
@@ -448,9 +482,20 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
     def stampcleanmask(self, stampbase, fn, taskname, extrainfo):
         return self.stampfile(stampbase, fn, taskname, extrainfo, clean=True)
 
-    def invalidate_task(self, task, d, fn):
-        bb.note("Tainting hash to force rebuild of task %s, %s" % (fn, task))
-        bb.build.write_taint(task, d, fn)
+    def invalidate_task(self, task, mcfn):
+        bb.note("Tainting hash to force rebuild of task %s, %s" % (mcfn, task))
+
+        mc = bb.runqueue.mc_from_tid(mcfn)
+        stamp = self.datacaches[mc].stamp[mcfn]
+
+        taintfn = stamp + '.' + task + '.taint'
+
+        import uuid
+        bb.utils.mkdirhier(os.path.dirname(taintfn))
+        # The specific content of the taint file is not really important,
+        # we just need it to be random, so a random UUID is used
+        with open(taintfn, 'w') as taintf:
+            taintf.write(str(uuid.uuid4()))
 
 class SignatureGeneratorUniHashMixIn(object):
     def __init__(self, data):
@@ -693,7 +738,7 @@ def dump_this_task(outfile, d):
     import bb.parse
     fn = d.getVar("BB_FILENAME")
     task = "do_" + d.getVar("BB_CURRENTTASK")
-    referencestamp = bb.build.stamp_internal(task, d, None, True)
+    referencestamp = bb.parse.siggen.stampfile_base(fn)
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile:" + referencestamp)
 
 def init_colors(enable_color):
-- 
2.37.2


