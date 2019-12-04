Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id AC9627F2BC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2019 11:53:04 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id f4so4663546wmj.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Dec 2019 03:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=aUffIXxJQ9c8v3LIaHbCPYeFuyLHwawHrdBVZcTwQwU=;
	b=F0vYiYz1IUEbnryF8r2Z2Opjk1fxWM2LRNGksrnRFZcvpWsR+gASqUwHbnLQGsgF3r
	fWEYm6ApGzfz+k96NA7YQh6X5xWdr2xQ/QeNjpFh0wVDvSV9DO5IRWyM6/Cwu7N+bzGG
	jJ7Y/La2iFQ70HmFSTJXh8/Nv2ieaytrHlWYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aUffIXxJQ9c8v3LIaHbCPYeFuyLHwawHrdBVZcTwQwU=;
	b=KoaHngzbY7XjJrmt4/LJfpzmvh5aBsmKCaFtNE7k/ZD2xsdkE8cYATfuNy7eO/R54j
	6QptDkDOso+2yssI3DwWoxbsLhKgLwg2A0cdSXOhEL6YldtGifQWD3TmtL3kT5pKsze0
	m5yFuttwLmvzQd/w6h/9QHLl0ORuvSK+5y6FerLvko6DovQlc1DyABhXMtHYlDNj56T7
	XLc+oKhEDB0J2Qye+ZUr1APJqQl6x2semBzLk/ur8jo5rP2HiwdExRBJmsN5fBQG2aTU
	7xUPLW9Dpv2Q5vjfRNmxMCBBAO/wcN4JqehPBEBVTD81JZZnZ8pCBSwy3pogPSMzw4WL
	MlZw==
X-Gm-Message-State: APjAAAVnLX7gaqradYgv3NYJEBcNYT+099skKvbRs9cOeSeIH/+9xTOw
	P2ZAHrcyvz0r2d82s51C4ARcsLK9BHI=
X-Google-Smtp-Source: APXvYqz5hQfrayX4mDLW8NgU1QtUg8roR57HT0GZKhLXq12Rii1SCBQJ5JfZnGP7HjIVoUXZqVKR9g==
X-Received: by 2002:a1c:49c3:: with SMTP id w186mr39653442wma.53.1575460385226;
	Wed, 04 Dec 2019 03:53:05 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o4sm7813059wrw.97.2019.12.04.03.53.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Dec 2019 03:53:04 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Dec 2019 11:53:00 +0000
Message-Id: <20191204115302.24692-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
References: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/4] runqueue/siggen: Allow handling of equivalent hashes
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
X-List-Received-Date: Wed, 04 Dec 2019 11:53:05 -0000
Content-Transfer-Encoding: 8bit

Based on the hashserv's new ability to accept hash mappings, update runqueue
to use this through a helper function in siggen.

This addresses problems with meta-extsdk-toolchain and its dependency on
gdb-cross which caused errors when building eSDK. See the previous commit
for more details.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 31 +++++++++++++++++++------------
 lib/bb/siggen.py   | 26 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bd7f03f981..a869ba527a 100644
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
index e19812b17c..edf10105f9 100644
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
2.20.1


