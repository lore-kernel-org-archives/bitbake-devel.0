Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 8F83B7F7C0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 09:41:14 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id z7so3483202wrl.13
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 01:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=QAF/inI75fw/daV+EbIbrvTvo5+rI/vxIxocvtp+jpk=;
	b=FVI8M4WW1+0CkuiCJdiH4NGmuebzf/jKY2iFvXa5M1klcnwb0357o5aUyPcAyAhp1m
	qqS5RIBX4G4NzwOY9DBzI6rziZmG/AcHDoBrTsJDhkdvoYN4A/umVNBeniDESvu3B2wQ
	f6mgM+9R5FlF7Ad/E79x3AJ7uxbfec8nYeC2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=QAF/inI75fw/daV+EbIbrvTvo5+rI/vxIxocvtp+jpk=;
	b=npQClBWtdUJSmV1Qv6twuI+sN+I+zhOO+AseEz4An6ayMnkJb2U8ajs4sOJIZuci1U
	eQV+vQI2+Tkvwh8XWcGrrhHfcMjI08ut2OjjYFqk5RJQxYNJlqBPrZ8c092X9lFNapV+
	1Ccl/Zq31XQz5WaN6Y9I43Y2SusSrLhue+qt4YQHLfm/xDy1tvcP/KNjSWwVKTMt5TEx
	FWSrhvoN/ird5gVROG4OiWDkUx3Gg/x/r6RGzbPwqp62gDy5MRbjQfCfK+mGguDGfnPu
	AO3FaLh/onVH9SLIsjG3m91gajVVPDeDufXKxM05A1IIEmwQFl8IkZuMTCdK0JMw1ET9
	B5Pg==
X-Gm-Message-State: APjAAAUhrxCQltxCtbFcAa8oO3dG/if1VfQGcy9u4xvJx5V9w0vAcDSs
	i4NJ5nOo/AHIRUvsBHcOo/Aq8IrKjz0=
X-Google-Smtp-Source: APXvYqxC6k1/HAK79X0aZ+fYITStADr3oXPa4xr1THJoUENjW7dqoC+gSeHHG7YbwyPHl9gIkV9v1Q==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr24038032wru.181.1576402874542;
	Sun, 15 Dec 2019 01:41:14 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e8sm16877572wrt.7.2019.12.15.01.41.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 15 Dec 2019 01:41:13 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Dec 2019 09:41:08 +0000
Message-Id: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/5] runqueue: Rework process_possible_migrations() to improve performance
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
X-List-Received-Date: Sun, 15 Dec 2019 09:41:14 -0000
Content-Transfer-Encoding: 8bit

The looping over multiple changed hashes causes many calls to get_taskhash
and get_unihash which are potentially slow and then overwritten.

Instead, batch up all the tasks which have changed unihashes and then
do one big loop over the changed tasks rather than each in turn.

This makes worlds of difference to the performance graphs and should speed
up build where many tasks are being rehashed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 103 ++++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index cb499a1cba..a45b27ce51 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2248,6 +2248,7 @@ class RunQueueExecute:
     def process_possible_migrations(self):
 
         changed = set()
+        toprocess = set()
         for tid, unihash in self.updated_taskhash_queue.copy():
             if tid in self.runq_running and tid not in self.runq_complete:
                 continue
@@ -2258,53 +2259,61 @@ class RunQueueExecute:
                 logger.info("Task %s unihash changed to %s" % (tid, unihash))
                 self.rqdata.runtaskentries[tid].unihash = unihash
                 bb.parse.siggen.set_unihash(tid, unihash)
-
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
+
+        # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
+        next = set()
+        for p in total:
+            if len(self.rqdata.runtaskentries[p].depends) == 0:
+                next.add(p)
+            elif self.rqdata.runtaskentries[p].depends.isdisjoint(total):
+                next.add(p)
+
+        # When an item doesn't have dependencies in total, we can process it. Drop items from total when handled
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
+                    #logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
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


