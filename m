Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
	[209.85.214.175])
	by mail.openembedded.org (Postfix) with ESMTP id 6A2337F881
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:47 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id f20so6704505plj.5
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=6jlWjogoIX0rYFx9k9fgto4Jb7E867ovD66tQsR8wDo=;
	b=fqTJ7+M3NUCClrDvcoz33iJIXKAXYW1563zb/Ex127Kb1VgYXS8N8RR0ufVqULRWVy
	vD6OcftBzg5H0G2DTwYGMmQQq4BxKPAPC0KF7jZFUPhiWoUsRgqviDnRg6+BQDXZfEA2
	bFjIwcV+EJPyEznrmCpZsAAcLvUfI49Vgtk/uAIYt98i1vfNcbFxBRchxuZ9k0QrV9HB
	+h697rKry+Q/moeBRdIeUvlSOSBXJTp9dN4qYcIr4lxIanYbz+XAK0nfHSJbW21Kh9BB
	72uL9r4jLXbBV8WZmfv+Mq/Wbw3kTDmnH1oFWHl35P+Vn2/mAFNTFsrcT1sPUIpqHcnq
	tPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=6jlWjogoIX0rYFx9k9fgto4Jb7E867ovD66tQsR8wDo=;
	b=FNTfKL0ibKw7k93b2qCK1beeGlteVjmNEZjM4XhgwFvbNh13H3eKpOq1W2AGj3gg0H
	0qlYQUigZcDa1p/6rYIDR4uw0sbAjgYvf0Pil6fGsWsrIZolwgkGJXUbdzNSdeiq76Fu
	vAi+jTe9UcFuTcgBOlU4XLG2x7gXRVMTW6+aP74UPoUK76jePy71OlV3qiKtWwwrD3Vf
	+/NS+m/FtIadVBe49jVVTKjTdtGYJhfgRehl6SnceCCMchiuzTOBjm1T7r8makq/Jcet
	M0NLYqh1+ebfNuzFrEpZKY410vJekpjvsWj46qvSWMlXo93QZZrsRcIBzZo842k4ASrD
	Q+Lw==
X-Gm-Message-State: APjAAAWI+AdShs/CKAZouQQp0XIsGi1hBhfOMhb7NE48KG1QXqj5XjvH
	JNz/GvK4fjineSunCM9PoJj4c5dUlo0=
X-Google-Smtp-Source: APXvYqx6iIKVz2uxqfe6fpk/tzBFhxQVVybNE81pTqRtnDMfVrdIN0c6N5qIgCOrFl3gIjOmSFp2vQ==
X-Received: by 2002:a17:902:8685:: with SMTP id
	g5mr29316627plo.5.1577076648328; 
	Sun, 22 Dec 2019 20:50:48 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.47
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:47 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:26 -0800
Message-Id: <222df6d6b832868c6e87334f8acdd74b730a91d6.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 02/18] runqueue/siggen: Allow handling of equivalent hashes
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:47 -0000

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
index bd7f03f..a869ba5 100644
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
index e19812b..edf1010 100644
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
2.7.4


