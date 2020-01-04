Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
	[209.85.215.179])
	by mail.openembedded.org (Postfix) with ESMTP id 95C457F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:22 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id k25so24174323pgt.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=egtj2JNCgGA1/P6JWQPprbElBWgo/PQYNInZEE79R5Y=;
	b=pY8AtVuVhnQDGWmyZrkrVidFQAAdnMEnslAWz72uasVK5ExTg17LBEaAD9crdC3wCc
	Uce824ekiiiIG5hTw79cgL9I/8mL0DR7xFUsooh8AbyK+dzueJn9PL7+c4kbLEoT+SIT
	h/y0ETufq3tZpYI9YxX0VkX1HNHpVT8HMYgFD0OT6zjCQcwcpJoXoo39mK82/llpRoCs
	zQR2xaHdRAlkrZyJvwrxjTW6FZWaaGlEGMOSlF6KSk6bV5vbN+R4ixF3kmr3EIGZiep7
	fFTLVRHsZANOknCn63jC+y8PU050LjONpaRTeZFCtvASfAx/PUTZKkhCG0s3yWY+KAt/
	sqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=egtj2JNCgGA1/P6JWQPprbElBWgo/PQYNInZEE79R5Y=;
	b=GZtTHY/eWQMUdjwXiZaWeU9cADGMwxF+O9VO/Fqo4HAEJ20Y9J1A6GxfmckLyPgnlm
	dc4F5ZdXEfplx4FsxVton28jztF6h4PrpcwC3AnEaNmTOO4up8kDs+MRCaSXmUWk8vMn
	F/F+cS+Dc11KCDa129gwpAcTBhCzklHjyIAofKXweBGqPQf97sfwm2BsZgQnoIRyceNw
	Z9SbBZYFwKEQpz8NzSG2MDSmnSEOPSxtoR25Es+UhCOb2qxCCygp2bescDYM4bKJlTFr
	G27odyywTulOx+3ZdoNnoNFRVIIXbzJmYnZc6AHruuyrrYZ6ikZ+u7NL3IqIg1Dtj1E3
	d1/w==
X-Gm-Message-State: APjAAAW0IXfLxS6phrgjdq+6byQ+Z0bSnv4R4QgOIeC7N9CI99tw4Ckc
	0lUi5upkJc03S3XxC68Lh8tRW6u3ZMM=
X-Google-Smtp-Source: APXvYqwYs0Enr0AaRqlKFNG2eqzRP56DDjhpAvkEFJKbdzMbtFudFNi/fC6ccxOGxUsLuWoX3XQzhA==
X-Received: by 2002:a63:941:: with SMTP id 62mr103122013pgj.203.1578104603744; 
	Fri, 03 Jan 2020 18:23:23 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.22
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:23 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:55 -0800
Message-Id: <c9ab598f6f1ea3ae3a0713dc6692b4c4bafbfb50.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 10/25] runqueue: Rework process_possible_migrations() to improve performance
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:23 -0000

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
 lib/bb/runqueue.py | 103 ++++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index cb499a1c..a45b27ce 100644
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
2.17.1


