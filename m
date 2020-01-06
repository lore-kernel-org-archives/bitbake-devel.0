Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
	[209.85.215.181])
	by mail.openembedded.org (Postfix) with ESMTP id F2D7C7FCA5
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:50 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id s64so27082091pgb.9
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=k9ZyNUuiC36uAN/Sng+356HGD2srYnobKKWY+SqLtBg=;
	b=X4aU7gLm93Y1aIDMYGDqRcIsfYH7/ZMRGV+SSH1K55UqrBq8tj3YGiNyP9xibjBLub
	geftWne8PuvM5xpbW+W51iB3OkC7a/iVNZYjRKgD3Ha2gj3gCxl25bVnLYj4RkJa/yJl
	EulX541jddxEZ342+NcuXPY3YauC/iCGyAFt1yKO2WkMBTTsg5SG453QUS1155ShwoRV
	MWe8gNKCCcJ19CTovrOeGBZDSNEnn4Oy9zWflb8b9KdM7YxBsA76vMAFL69B1FzS7EDz
	rpg7c6Nxax1ykzAa+CtjQphVay7Jvko9cBwOTbxKLqL/vt1UwR+HkGMg3TWXbNyzzK59
	voFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=k9ZyNUuiC36uAN/Sng+356HGD2srYnobKKWY+SqLtBg=;
	b=i92V1/gTd8hUNO2ji+PInY9zHXLKuVZCqHemkpqKLDxalwc+OYxTo3hietm+Ws/MDg
	njlMQ2OHUS41psasEXOCniok+AMNqilnj83oJckd+qcpdHWVoeu1UupdUQfoi91X1GVq
	vimbpxUHZn+51pu8cKWhDNZALVcg5XHe/z84Dh44b0L09tOTId/uOEmfBNuyHX8Gs8bj
	WCvgveRumVM+WqTdg0hxBOFBTBE0ZxToAb1/SNSZX/BJrIhx+iHK3oYSUdujEx6rODaF
	hbyWKtUEFGjCwc3gz2wCjSXV3JBS/rYQcP7NZx7ABoNKLkTSvA0BaiBjIikt6xeFHaTy
	9kNA==
X-Gm-Message-State: APjAAAVY4NwOl34yWtRrnoQyZ0F7GpkcR/AXxsrALQ5dBGNUCV09BOjV
	P4gYuIpEPxQvg8Nld0XTyZ8+axA+
X-Google-Smtp-Source: APXvYqx/dOHnDYhomvTOiw+RRERuZfMhg0FIY/efpUJxFEMEbR1Q4l3QJAuAxnDgVVLq+itYjzlWtQ==
X-Received: by 2002:a65:644b:: with SMTP id
	s11mr112491092pgv.332.1578328011680; 
	Mon, 06 Jan 2020 08:26:51 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.50
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:51 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:23 -0800
Message-Id: <222df6d6b832868c6e87334f8acdd74b730a91d6.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 02/25] runqueue/siggen: Allow handling of equivalent hashes
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:51 -0000

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


