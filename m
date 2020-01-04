Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
	[209.85.216.50])
	by mail.openembedded.org (Postfix) with ESMTP id 94F367FA28
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:15 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id s7so5398164pjc.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=k9ZyNUuiC36uAN/Sng+356HGD2srYnobKKWY+SqLtBg=;
	b=KRy3HULWBS5HWKLovHdCE12Tw8zcBUbtNBFiPHzGaNlD6iyFVf0d7GyfcMopZJyiSb
	4CGtWB9IMg7vOotiNtyy2Z6RIuMGQgi0OwpoQE/VHdgLBiBAV/OuBXBfSDyuOAyN0eEU
	S3xn9tgs+iXztorXtX4yFGqkwiV4qmrIkXcAIKPXUnhzJecE44MnvFmolFKqLvueVgoz
	5Rw/Y7nFvhrvIIQAHkI6sHgR+IbTjGkVwYTTPUkan+A5GSMBT9wdDFH6JZE9TKGVvvI9
	FacTnnxHVXRGsWv2Og3laGlC1Kj/fRa7Z9Ba6Hfj0ilg5jue6/iFvqEcIvwDLWS4mQXQ
	Z4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=k9ZyNUuiC36uAN/Sng+356HGD2srYnobKKWY+SqLtBg=;
	b=TsExmX7HKQF+wHcZe5IgoN4nPRmnPzwF0stdLmJRcGQQNaqLAnjwG4SfD95tYtRsI4
	bmVXMDPRZdANZ8TYiMSQFUbYpf9Tg+7m4hOu2cGB/gjGvhR5C8ioQLflzy922umYrU1I
	eRdSsqLL265zQZWr/GJkD7s5uf7GLfXvHXCOA+7otl2yhED0GqnsZo1lyicZhtwz2uGg
	ZTgHPEuB/GPnsnGPXZTIhz9D4N0gZSi+graBBCYqfNQFpTm85K8FNnSiAvUZkKLUN0hp
	DB9ssNaprlRLSrPfno/bnJ+mME0Dab/SYUAFujqxudC0YzZdThlzJliKJx74OclJrDB5
	BjTQ==
X-Gm-Message-State: APjAAAXjBmvaXWa2buMeaB3emAa3cKx4MmTD02Xe7yY0rAapjU6yTb10
	eG8ydYXfdazAxyBvpRQQWEJJs6nZfOI=
X-Google-Smtp-Source: APXvYqwkV+tQZlO3Zx1gLYXC7/hZxNm8YGtgFnrec3EGnrDJenENs4n7qdNoDv87iJQPU2KGBObtYg==
X-Received: by 2002:a17:902:b187:: with SMTP id
	s7mr95149358plr.104.1578104596678; 
	Fri, 03 Jan 2020 18:23:16 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.15
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:16 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:47 -0800
Message-Id: <222df6d6b832868c6e87334f8acdd74b730a91d6.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 02/25] runqueue/siggen: Allow handling of equivalent hashes
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:16 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Based on the hashserv's new ability to accept hash mappings, update runqueue
to use this through a helper function in siggen.

This addresses problems with meta-extsdk-toolchain and its dependency on
gdb-cross which caused errors when building eSDK. See the previous commit
for more details.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 39098b4ba2133f4d9229a0aa4fcf4c3e1291286a)
---
 lib/bb/runqueue.py | 31 +++++++++++++++++++------------
 lib/bb/siggen.py   | 26 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bd7f03f9..a869ba52 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2283,12 +2283,26 @@ class RunQueueExecute:
                         for dep in self.rqdata.runtaskentries[tid].depends:
                             procdep.append(dep)
                         orighash = self.rqdata.runtaskentries[tid].hash
-                        self.rqdata.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
+                        newhash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
                         origuni = self.rqdata.runtaskentries[tid].unihash
-                        self.rqdata.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
-                        logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, self.rqdata.runtaskentries[tid].hash, origuni, self.rqdata.runtaskentries[tid].unihash))
+                        newuni = bb.parse.siggen.get_unihash(tid)
+                        # FIXME, need to check it can come from sstate at all for determinism?
+                        remapped = False
+                        if newuni == origuni:
+                            # Nothing to do, we match, skip code below
+                            remapped = True
+                        elif tid in self.scenequeue_covered or tid in self.sq_live:
+                            # Already ran this setscene task or it running. Report the new taskhash
+                            remapped = bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
+                            logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
+
+                        if not remapped:
+                            logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
+                            self.rqdata.runtaskentries[tid].hash = newhash
+                            self.rqdata.runtaskentries[tid].unihash = newuni
+                            changed.add(tid)
+
                         next |= self.rqdata.runtaskentries[tid].revdeps
-                        changed.add(tid)
                         total.remove(tid)
                         next.intersection_update(total)
 
@@ -2307,18 +2321,11 @@ class RunQueueExecute:
                 self.pending_migrations.add(tid)
 
         for tid in self.pending_migrations.copy():
-            if tid in self.runq_running:
+            if tid in self.runq_running or tid in self.sq_live:
                 # Too late, task already running, not much we can do now
                 self.pending_migrations.remove(tid)
                 continue
 
-            if tid in self.scenequeue_covered or tid in self.sq_live:
-                # Already ran this setscene task or it running
-                # Potentially risky, should we report this hash as a match?
-                logger.info("Already covered setscene for %s so ignoring rehash" % (tid))
-                self.pending_migrations.remove(tid)
-                continue
-
             valid = True
             # Check no tasks this covers are running
             for dep in self.sqdata.sq_covered_tasks[tid]:
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index e19812b1..edf10105 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -525,6 +525,32 @@ class SignatureGeneratorUniHashMixIn(object):
                 except OSError:
                     pass
 
+    def report_unihash_equiv(self, tid, taskhash, wanted_unihash, current_unihash, datacaches):
+        try:
+            extra_data = {}
+            data = self.client().report_unihash_equiv(taskhash, self.method, wanted_unihash, extra_data)
+            bb.note('Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
+
+            if data is None:
+                bb.warn("Server unable to handle unihash report")
+                return False
+
+            finalunihash = data['unihash']
+
+            if finalunihash == current_unihash:
+                bb.note('Task %s unihash %s unchanged by server' % (tid, finalunihash))
+            elif finalunihash == wanted_unihash:
+                bb.note('Task %s unihash changed %s -> %s as wanted' % (tid, current_unihash, finalunihash))
+                self.set_unihash(tid, finalunihash)
+                return True
+            else:
+                # TODO: What to do here?
+                bb.note('Task %s unihash reported as unwanted hash %s' % (tid, finalunihash))
+
+        except hashserv.client.HashConnectionError as e:
+            bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
+
+        return False
 
 #
 # Dummy class used for bitbake-selftest
-- 
2.17.1


