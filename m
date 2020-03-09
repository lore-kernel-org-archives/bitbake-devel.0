Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id 3EAA061B86
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:10 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id g126so9259948ilh.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=I6hRBaQrU0CtEhnfFtU1GRugVLn6SzzzzcyeF3Lo1Rk=;
	b=IKeONwEXGukSoDm3aTUfqZNgwy6wW3Mq8t4woeBbgB+qlML4XStcPyC+ZkSGAq6OeC
	DzGXlQ87eNLD1lBMM/P2fwCj3r6+6JBJuE6nBBBoL2bCSZ7OYHWFpRnboBb+DUpeicpK
	UcGq076iDt4gMtzh/8eEfMACBPdcyb6lr910Y2ZIdy4znhrq4G7cI5sZ+lTrGvfKePD+
	GVJLjV5q78HuHeFSDqAJJrL2qj9SxZiLGGeLZeORrFSyTt9DjU1F0eB/ZzzsOyv7IemD
	QhGBUokE1j/4ZPtLsqE16lEOav8zVhGupctl+djcfhm8wN1KKSN8OsY3773j8JKaOSLW
	K6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=I6hRBaQrU0CtEhnfFtU1GRugVLn6SzzzzcyeF3Lo1Rk=;
	b=G0S08dMXrK66T+veudHupaY9CTZqPVFC2tNitrfOCtP0G8261sFKrExBOlTasXMyzQ
	6gptbseKt8JYKS2YppPnNPVUhcqhDHV6uINpmRWImC9nFV+pwjOY+NthwA4g8Rp4QwxV
	ECrq8EKbI2jLicTiswLxuS+hS9Hsfrc9U68seQ5rjRWwF1Hz3Uw3l2f5j0X2UF9VfCez
	jlrQwMSywsh1TopjJC3+P5Zlpdye4tJRiy5DvFsTTW3J1o6HDIbE0XgUZqMJanixBf87
	XX6hRs6JdmJ30Z+r6L0TPDkmJbBq9WJGWM16CCIgdTxEXqM1qsNAR8haxA8d35dGP/+N
	IE3A==
X-Gm-Message-State: ANhLgQ0sVUvnyKJPzLVKm9+lVMt5caiBtcYEWZKd04fn1sA7TOo6wMCj
	2IEuHiHLElBkhWN0ZkbPuTH+R4gpmW0=
X-Google-Smtp-Source: ADFU+vs31TLWhYDo+9AIGz81DaZC1PhTfChUDEwWpoTwsu9NPvSwG8hHS3ch+4KiRkqOsKVz11nRMw==
X-Received: by 2002:a92:af4b:: with SMTP id n72mr16314491ili.288.1583771650878;
	Mon, 09 Mar 2020 09:34:10 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.09
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:09 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:50 -0500
Message-Id: <20200309163353.15362-13-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 12/15] bitbake: Log hash equivalence with a different logger
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
X-List-Received-Date: Mon, 09 Mar 2020 16:34:10 -0000

Switches the hash equivalence logging to use a different logger so that
it can be easily filtered out with python's structured logging.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 11 ++++++-----
 bitbake/lib/bb/siggen.py   | 17 +++++++++--------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 4106fa4bc4..e84890b8b7 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -27,6 +27,7 @@ import pprint
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
+hashequiv_logger = logging.getLogger("BitBake.RunQueue.HashEquiv")
 
 __find_sha256__ = re.compile( r'(?i)(?<![a-z0-9])[a-f0-9]{64}(?![a-z0-9])' )
 
@@ -2263,7 +2264,7 @@ class RunQueueExecute:
             self.updated_taskhash_queue.remove((tid, unihash))
 
             if unihash != self.rqdata.runtaskentries[tid].unihash:
-                logger.info("Task %s unihash changed to %s" % (tid, unihash))
+                hashequiv_logger.info("Task %s unihash changed to %s" % (tid, unihash))
                 self.rqdata.runtaskentries[tid].unihash = unihash
                 bb.parse.siggen.set_unihash(tid, unihash)
                 toprocess.add(tid)
@@ -2308,7 +2309,7 @@ class RunQueueExecute:
                 elif tid in self.scenequeue_covered or tid in self.sq_live:
                     # Already ran this setscene task or it running. Report the new taskhash
                     bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
-                    logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
+                    hashequiv_logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
                     remapped = True
 
                 if not remapped:
@@ -2327,7 +2328,7 @@ class RunQueueExecute:
             for mc in self.rq.fakeworker:
                 self.rq.fakeworker[mc].process.stdin.write(b"<newtaskhashes>" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
 
-            logger.debug(1, pprint.pformat("Tasks changed:\n%s" % (changed)))
+            hashequiv_logger.debug(1, pprint.pformat("Tasks changed:\n%s" % (changed)))
 
         for tid in changed:
             if tid not in self.rqdata.runq_setscene_tids:
@@ -2346,7 +2347,7 @@ class RunQueueExecute:
             # Check no tasks this covers are running
             for dep in self.sqdata.sq_covered_tasks[tid]:
                 if dep in self.runq_running and dep not in self.runq_complete:
-                    logger.debug(2, "Task %s is running which blocks setscene for %s from running" % (dep, tid))
+                    hashequiv_logger.debug(2, "Task %s is running which blocks setscene for %s from running" % (dep, tid))
                     valid = False
                     break
             if not valid:
@@ -2409,7 +2410,7 @@ class RunQueueExecute:
 
         for (tid, harddepfail, origvalid) in update_tasks:
             if tid in self.sqdata.valid and not origvalid:
-                logger.info("Setscene task %s became valid" % tid)
+                hashequiv_logger.info("Setscene task %s became valid" % tid)
             if harddepfail:
                 self.sq_task_failoutright(tid)
 
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index c2d0c736cf..0357b544b5 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -16,6 +16,7 @@ from bb import runqueue
 import hashserv
 
 logger = logging.getLogger('BitBake.SigGen')
+hashequiv_logger = logging.getLogger('BitBake.SigGen.HashEquiv')
 
 def init(d):
     siggens = [obj for obj in globals().values()
@@ -502,9 +503,9 @@ class SignatureGeneratorUniHashMixIn(object):
                 # A unique hash equal to the taskhash is not very interesting,
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
-                bb.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
+                hashequiv_logger.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
             else:
-                bb.debug(2, 'No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
+                hashequiv_logger.debug(2, 'No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
         except hashserv.client.HashConnectionError as e:
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
@@ -578,12 +579,12 @@ class SignatureGeneratorUniHashMixIn(object):
                 new_unihash = data['unihash']
 
                 if new_unihash != unihash:
-                    bb.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
+                    hashequiv_logger.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
                     self.set_unihash(tid, new_unihash)
                     d.setVar('BB_UNIHASH', new_unihash)
                 else:
-                    bb.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
+                    hashequiv_logger.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
             except hashserv.client.HashConnectionError as e:
                 bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
         finally:
@@ -606,7 +607,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 method = method + self.extramethod[tid]
 
             data = self.client().report_unihash_equiv(taskhash, method, wanted_unihash, extra_data)
-            bb.note('Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
+            hashequiv_logger.info('Reported task %s as unihash %s to %s (%s)' % (tid, wanted_unihash, self.server, str(data)))
 
             if data is None:
                 bb.warn("Server unable to handle unihash report")
@@ -615,14 +616,14 @@ class SignatureGeneratorUniHashMixIn(object):
             finalunihash = data['unihash']
 
             if finalunihash == current_unihash:
-                bb.note('Task %s unihash %s unchanged by server' % (tid, finalunihash))
+                hashequiv_logger.info('Task %s unihash %s unchanged by server' % (tid, finalunihash))
             elif finalunihash == wanted_unihash:
-                bb.note('Task %s unihash changed %s -> %s as wanted' % (tid, current_unihash, finalunihash))
+                hashequiv_logger.info('Task %s unihash changed %s -> %s as wanted' % (tid, current_unihash, finalunihash))
                 self.set_unihash(tid, finalunihash)
                 return True
             else:
                 # TODO: What to do here?
-                bb.note('Task %s unihash reported as unwanted hash %s' % (tid, finalunihash))
+                hashequiv_logger.info('Task %s unihash reported as unwanted hash %s' % (tid, finalunihash))
 
         except hashserv.client.HashConnectionError as e:
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
-- 
2.17.1


