Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id 155C27F31F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Dec 2019 16:13:33 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id c9so7238602wrw.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Dec 2019 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=n2hbS8i/3Z9hNyq5Y8YSRp2qrVFq7UHbPAGaNoddclU=;
	b=UgZgeM4CqMGOhsk0yCNXylZ97s03lRoqzmemigrgM+ZwFWyMDHQccoBT5rdSQlD85g
	uZ4fyVT2mmk+MuvnCADqPFEYSBdtRQY4U+JucJiiYVFhJ0EieOL/WPZV79RQbNBhxZvf
	jlCB4XS165fr72tbeW4kzrEuYse3xwtu0VsDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=n2hbS8i/3Z9hNyq5Y8YSRp2qrVFq7UHbPAGaNoddclU=;
	b=KGhfMFaYGofCECoBw7XDQi5ve/ea2MxzFFG8Z9DIrFVpa4ionScBfNd3GX51QhRTkr
	/jBAZb//mSpKs+hCDT5SXZRHmdTd7Q9OIfQsM4KO/UAVbv8r+WB1ZBIyW7IMDNz55zFx
	15/d7oPIBF1dEu3822Su1zjN58+yhA1LHslfFin4/I9ueE9jqz5LwqYhCMu12+OUpNF+
	xYhMCfbLMkcbBasFtJVaU8nrMTzFJDMZPka30WyjrkFGkRgITdnzdnBWO9XFe+bap6DH
	JusTadIFG9lIhPPENqKn214enG2OYlxT3t6oALbiZl1BGL75WRKzqujb/VGuDWZFXqNT
	G1qQ==
X-Gm-Message-State: APjAAAXOHm02h7RVsMy7+qWIO3vvr6WQMTL9s+SW/tJ20zbG+V+uwLew
	GyQH+lKuwiLyWwi+xXBZsHDMcHNvEvA=
X-Google-Smtp-Source: APXvYqyzHDFVBo6oCRsF/XdeqWX17GsiRZW6y5boX/kud3GX+M8xQsVTgXmyLH2kd39By/kqa4kJ8g==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr13063299wrs.363.1576253614244;
	Fri, 13 Dec 2019 08:13:34 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s8sm10215648wrt.57.2019.12.13.08.13.33
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 13 Dec 2019 08:13:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Dec 2019 16:13:31 +0000
Message-Id: <20191213161332.28125-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/2] runqueue: Rework process_possible_migrations() to improve performance
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 13 Dec 2019 16:13:34 -0000
Content-Transfer-Encoding: 8bit

The looping over multiple changed hashes causes many calls to get_taskhash
and get_unihash which are potentially slow and then overwritten.

Instead, batch up all the tasks which have changed unihashes and then
do one big loop over the changed tasks rather than each in turn.

This makes worlds of difference to the performance graphs and should speed
up build where many tasks are being rehashed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 99 +++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index cb499a1cba..bbd585306c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2248,6 +2248,7 @@ class RunQueueExecute:
     def process_possible_migrations(self):
 
         changed = set()
+        toprocess = set()
         for tid, unihash in self.updated_taskhash_queue.copy():
             if tid in self.runq_running and tid not in self.runq_complete:
                 continue
@@ -2258,53 +2259,59 @@ class RunQueueExecute:
                 logger.info("Task %s unihash changed to %s" % (tid, unihash))
                 self.rqdata.runtaskentries[tid].unihash = unihash
                 bb.parse.siggen.set_unihash(tid, unihash)
+                toprocess.add(tid)
+
+        # Work out all tasks which depend upon these
+        total = set()
+        for p in toprocess:
+            next = set(self.rqdata.runtaskentries[p].revdeps)
+            while next:
+                current = next.copy()
+                total = total | next
+                next = set()
+                for ntid in current:
+                    next |= self.rqdata.runtaskentries[ntid].revdeps
+                    next.difference_update(total)
 
-                # Work out all tasks which depend on this one
-                total = set()
-                next = set(self.rqdata.runtaskentries[tid].revdeps)
-                while next:
-                    current = next.copy()
-                    total = total |next
-                    next = set()
-                    for ntid in current:
-                        next |= self.rqdata.runtaskentries[ntid].revdeps
-                        next.difference_update(total)
-
-                # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
-                done = set()
-                next = set(self.rqdata.runtaskentries[tid].revdeps)
-                while next:
-                    current = next.copy()
-                    next = set()
-                    for tid in current:
-                        if not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
-                            continue
-                        procdep = []
-                        for dep in self.rqdata.runtaskentries[tid].depends:
-                            procdep.append(dep)
-                        orighash = self.rqdata.runtaskentries[tid].hash
-                        newhash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
-                        origuni = self.rqdata.runtaskentries[tid].unihash
-                        newuni = bb.parse.siggen.get_unihash(tid)
-                        # FIXME, need to check it can come from sstate at all for determinism?
-                        remapped = False
-                        if newuni == origuni:
-                            # Nothing to do, we match, skip code below
-                            remapped = True
-                        elif tid in self.scenequeue_covered or tid in self.sq_live:
-                            # Already ran this setscene task or it running. Report the new taskhash
-                            remapped = bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
-                            logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
-
-                        if not remapped:
-                            logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
-                            self.rqdata.runtaskentries[tid].hash = newhash
-                            self.rqdata.runtaskentries[tid].unihash = newuni
-                            changed.add(tid)
-
-                        next |= self.rqdata.runtaskentries[tid].revdeps
-                        total.remove(tid)
-                        next.intersection_update(total)
+        # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
+        done = set()
+        next = set()
+        for p in total:
+            if not self.rqdata.runtaskentries[p].depends.isdisjoint(total):
+                next.add(p)
+
+        while next:
+            current = next.copy()
+            next = set()
+            for tid in current:
+                if not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
+                    continue
+                procdep = []
+                for dep in self.rqdata.runtaskentries[tid].depends:
+                    procdep.append(dep)
+                orighash = self.rqdata.runtaskentries[tid].hash
+                newhash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
+                origuni = self.rqdata.runtaskentries[tid].unihash
+                newuni = bb.parse.siggen.get_unihash(tid)
+                # FIXME, need to check it can come from sstate at all for determinism?
+                remapped = False
+                if newuni == origuni:
+                    # Nothing to do, we match, skip code below
+                    remapped = True
+                elif tid in self.scenequeue_covered or tid in self.sq_live:
+                    # Already ran this setscene task or it running. Report the new taskhash
+                    remapped = bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
+                    logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
+
+                if not remapped:
+                    logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
+                    self.rqdata.runtaskentries[tid].hash = newhash
+                    self.rqdata.runtaskentries[tid].unihash = newuni
+                    changed.add(tid)
+
+                next |= self.rqdata.runtaskentries[tid].revdeps
+                total.remove(tid)
+                next.intersection_update(total)
 
         if changed:
             for mc in self.rq.worker:
-- 
2.20.1


