Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15767.1794915954037210414
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 03:45:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gmXfVE9r;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb61185057so20782185e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 03:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794915952; x=1795520752; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4YTeCKI1vFObnOYKhg6m5upGXBqhtQnTUK3Z65y/ckA=;
        b=gmXfVE9rDjkYDXV0ywLNCZOWkUnfArYi/0jum4U+I/aHAtozYLyU+ckgpP+q3NkgGX
         0H0rQIyCnZg81+i7TyjqQES/+Pvm9FFQRtsYIKbvHge4R74abbb+Gs1AMsLre0z/xTw5
         RA42mMR0ZOdogIDZPzWMK6ohH970k35K/a7Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915952; x=1795520752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4YTeCKI1vFObnOYKhg6m5upGXBqhtQnTUK3Z65y/ckA=;
        b=FEruD2XIRdkcbkGs+t52T1qVUiumVOaHog1fDqW3JUQx8rkb9Qr8O8qiFnhiCx+0AA
         zn5U4q0SgRShteWbt2H6wd8zZ/kU1p+kuGV4nEhkYpBCQTzGm6c7luYaac9EALF6cafx
         48X0+uYnJDiW/qpULfKqEk+MG3RXcWCe0Up/OKiY125+gGjmSXoX4FDWckeaSWYTicD7
         IcKVU3TI3nxOtOAvqno/HMto628wXahSQRySN9Gtl/oDe2DrgEIrTDVdI24hG3zcDS5K
         0+/9anQ3kp8uLJDfXjfc9BQgjZ2h0o7FL3gxZCixsrUNt9hNrjkPozyYgEQvX2m3PlO6
         eBnA==
X-Gm-Message-State: APuU4Z/ml5Y5KtoPzU8VDGK6F1yzvK/AHtAzQIqWisp/huU86253FK7m
	ap1PemQPgZ8BVIiZzN+OYRVoopaAEXYY6ZguJQYUjbGz7EQk3iq7EQExpVRgA6wPnm8mHrZyVx+
	fu3VxGVk=
X-Gm-Gg: AYBFou2X6IuifOEY30/jLjV9EzTm3TLX2KOLC3lYZkGZ3u6eE01IIdVnSm82qlAhPr/
	3CyaN5pugyQhK+xNbMn3I479Md2LBKKdMgPQJzJHHEcsSRDrB2xGX0GuDBA7U/E9Bm5WVzV4QPR
	7U9FKarLDPfdkvduAgKlUfen0NhrTWTmDW5zeCpm7HEF5tvVpJfCOwtOv90FfrkqVROiE5iWgCA
	iXRdu+VaFZApV5j6751cnvcXK1W91D4C5SI257zk6niOfsK9NWvL+VZT/Uf4Qp4hrM4GsSFZD0p
	8haqGlXl5/Y2DNrjiKdpt4BURxH1gfLMIakKNZ0j812zeAlDaIW7stm5D5O9QmLk13Jvme7DG16
	P08ApHnMcY0k/gS08ocRQUJDobbyHFW+uZ0BcdPUlwHvqnkrh5lvgxAHSGWbRfN5fGTfkpmyjUr
	WfYLiY6HyqNlqnsZWebtQH3SyE5pFiAM0r8C/8gG4fOw62m4ocqcZcNja+pH1nNST2Jqm6slNq0
	m8lZFZxlXc9Pr0Wl9k6VFFVr9qmiyw+TYtfrC1xLeex3BVyEvKxFfmSYiUSxZxEM/zKGLzRKOhH
	F0Bp2wF4X1RkJqsmIGcFzwJQMdlmepA7Wyue8bUDyWdZ6tQMKBFBtb8xvljkl+B9pecvoHVHjdx
	epYo=
X-Received: by 2002:a05:600c:6309:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4bb559f3bb9mr277695395e9.3.1794915951757;
        Tue, 17 Nov 2026 03:45:51 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5769:a004:a5af:24bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad9426asm23650525e9.4.2026.11.17.03.45.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:45:51 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: Improve deferred task sorting
Date: Tue, 17 Nov 2026 11:45:48 +0000
Message-ID: <20261117114550.2306278-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 11:45:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20445
Content-Type: text/plain; charset="utf-8"

Whilst looking for other problems, I noticed the sorting used for deferring
tasks isn't always consistent. It needs to be so that same multiconfig is
always preferred over the others, which gives a much lower chance of
deadlocking.

Add a helper sorting function and use it in all the locations we need this
sorting.

That means we can remove the weird looking looping code from the locations
which did get this right.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 63615ac6c92..4f80f1fde21 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -85,6 +85,13 @@ def build_tid(mc, fn, taskname):
         return "mc:" + mc + ":" + fn + ":" + taskname
     return fn + ":" + taskname
 
+def sort_tids_by_mc(tids, multiconfigs):
+    """
+    Return tids grouped by multiconfig, with the groups in sorted mc order
+    and the tids sorted within each group.
+    """
+    return [tid for _, tid in sorted(((mc_from_tid(tid), tid) for tid in tids))]
+
 # Index used to pair up potentially matching multiconfig tasks
 # We match on PN, taskname and hash being equal
 def pending_hash_index(tid, rqdata):
@@ -2109,7 +2116,7 @@ class RunQueueExecute:
                 logger.debug("Marking task %s as buildable", revdep)
 
         found = None
-        for t in sorted(self.sq_deferred.copy()):
+        for t in sort_tids_by_mc(self.sq_deferred.copy(), self.sqdata.multiconfigs):
             if self.sq_deferred[t] == task:
                 # Allow the next deferred task to run. Any other deferred tasks should be deferred after that task.
                 # We shouldn't allow all to run at once as it is prone to races.
@@ -2738,14 +2745,11 @@ class RunQueueExecute:
 
         if update_tasks2:
             self.sqdone = False
-            for mc in sorted(self.sqdata.multiconfigs):
-                for tid in sorted([t[0] for t in update_tasks2]):
-                    if mc_from_tid(tid) != mc:
-                        continue
-                    h = pending_hash_index(tid, self.rqdata)
-                    if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
-                        self.sq_deferred[tid] = self.sqdata.hashes[h]
-                        bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
+            for tid in sort_tids_by_mc([t[0] for t in update_tasks2], self.sqdata.multiconfigs):
+                h = pending_hash_index(tid, self.rqdata)
+                if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
+                    self.sq_deferred[tid] = self.sqdata.hashes[h]
+                    bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
             update_scenequeue_data([t[0] for t in update_tasks2], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
 
         for (tid, harddepfail, origvalid) in update_tasks2:
@@ -3101,6 +3105,9 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
         if not sqdata.sq_revdeps[tid]:
             sqrq.sq_buildable.add(tid)
 
+    # Fix the ordering for determinism, sets are unordered
+    sqdata.multiconfigs = sorted(sqdata.multiconfigs)
+
     rqdata.init_progress_reporter.next_stage()
 
     sqdata.noexec = set()
@@ -3109,16 +3116,13 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
 
     sqdata.hashes = {}
     sqrq.sq_deferred = {}
-    for mc in sorted(sqdata.multiconfigs):
-        for tid in sorted(sqdata.sq_revdeps):
-            if mc_from_tid(tid) != mc:
-                continue
-            h = pending_hash_index(tid, rqdata)
-            if h not in sqdata.hashes:
-                sqdata.hashes[h] = tid
-            else:
-                sqrq.sq_deferred[tid] = sqdata.hashes[h]
-                bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashes[h]))
+    for tid in sort_tids_by_mc(sqdata.sq_revdeps, sqdata.multiconfigs):
+        h = pending_hash_index(tid, rqdata)
+        if h not in sqdata.hashes:
+            sqdata.hashes[h] = tid
+        else:
+            sqrq.sq_deferred[tid] = sqdata.hashes[h]
+            bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashes[h]))
 
 def check_setscene_stamps(tid, rqdata, rq, stampcache, noexecstamp=False):
 
