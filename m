Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
	[209.85.215.177])
	by mail.openembedded.org (Postfix) with ESMTP id DF07C7F873
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:53 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id x7so8180859pgl.11
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=z3BpS/1gBAAJoN6dx7XC5e98ZxFQJQ1aN39OyvRizDY=;
	b=DhEv4Z+2elrgXYZlGGXVwP4cYBhz1B+QheiPun8TxbwZ9toOeupQMjIrju4q/LqLJI
	1FuAo8b+8QYmctRl1Z+kXKGVIBaQdbxJzNeYEPzqB7nhrUVJwKFala3XRBff0UpS6eFJ
	UU8qijqFZ4AxZzHe0StxEQstG+wgk1iXNwgtSTuj1Fhvv7pqWesGJEW3eQsHhy0V2i6u
	sl+ehp/I81rAyLw4rjn3gDauCHMC/AdfM8S+OcTRfENpBPA3OLUunZDYatGRMxiZfIIb
	UTLYw6d26XqsSkEGxJTXBao0KRWpNzs74/Lc7IBTzj8rEZVweMlZjxbHrej/7aIZBW8X
	YF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=z3BpS/1gBAAJoN6dx7XC5e98ZxFQJQ1aN39OyvRizDY=;
	b=Rs2r4b2PeeUWLR9oq5WQARV5Ulhnw5V8GemaHDZKTIuHWo8ti2NIgEeA+QYWvpPEyW
	L2UlCk50bX9ietcp1TpoNVadtQ2Hz+8FOlR7dJFMnf84jL+cshRLkPVvdMmNO7rucEYv
	zhl0/pQm6ySBG0IsDxQnc38hazxh1BXlJfErunf6pRRyvmzyvfvOJXy3LVtx37fdFDIN
	49JIBVH+4g24tF1SBmpli9XW5LBxGeZSx7CeZpygOlxDvJbee/ZQy4FBD9Fm6AZPArxE
	Yf++6uJeJtVdpPPRUZB8jEkKJnW/80A3Ct6So8k+60VsySYaG/C1jOtEMD+tuq2obkhH
	Hvhw==
X-Gm-Message-State: APjAAAWggSYI9C1HWmSj3HB+sUh+X1qUyFeQOjuVBb4LuypGV00cBBQ+
	fYSzzSfwxn3o64yFcV2FJGUOJkqYa5E=
X-Google-Smtp-Source: APXvYqyTGebGjA56LsMuuNCPit9o1mAOL1PsV+AuVw38ET5MS6Mpzesvc1fpD/o8grlCesS+uco4sQ==
X-Received: by 2002:a62:1883:: with SMTP id 125mr29704604pfy.166.1577076654750;
	Sun, 22 Dec 2019 20:50:54 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:54 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:34 -0800
Message-Id: <c9ab598f6f1ea3ae3a0713dc6692b4c4bafbfb50.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 10/18] runqueue: Rework process_possible_migrations() to improve performance
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:54 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The looping over multiple changed hashes causes many calls to get_taskhash
and get_unihash which are potentially slow and then overwritten.

Instead, batch up all the tasks which have changed unihashes and then
do one big loop over the changed tasks rather than each in turn.

This makes worlds of difference to the performance graphs and should speed
up build where many tasks are being rehashed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c9c68d898985cf0bec6fc95f54c151cc50255cac)
---
 lib/bb/runqueue.py | 103 +++++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index cb499a1..a45b27c 100644
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
2.7.4


