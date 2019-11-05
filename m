Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 284057F8F4
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Nov 2019 11:58:58 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id n1so21025073wra.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Nov 2019 03:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Fl/srODFlB3eoTgTe2tca+sRgvDCAlHhzqnHnHZLrA0=;
	b=MYgyE1/RbvgsAjy9zgHEiyoO3CsnbP2sSokj/hFtFMMcEZMe1VcQBPVA/qAbKlGLkO
	3yt49f8sOyr2Kc4akWDeguhl2yewlM8HuPne6El9/kebTO4mu6YBfjoc/pabCl24IduW
	gi+XKBMOopNw8e4FguKPhrmMMARgP4mHaQ8rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Fl/srODFlB3eoTgTe2tca+sRgvDCAlHhzqnHnHZLrA0=;
	b=SqSdqHdF6ZV7qcV1erm+78wXSvcPqW5KKPpVvXysGv0xfz+HOsgweEm81E3xPASTOI
	3x0V2h2mFLKdTtpzB2ZGFcXaeLjcXQ9KhqKoms8oq3PQqTh5zAfUWO/lW5VBfdZtBtoR
	u7UOFOYYFq8S9/OJoSqJBiEZJEzZ/mOyMnYJRofvPUSOWQfULpNWe7u/eJ/y6o21J+O/
	Sp7LHPJs7iqOrElLF8AoHzVAcrXQKqC4ydc2gO9bZ+x4UZaDDYGX2kFfe184z4BWWNQ0
	i9oleupESmGJpu8QumDnNDvNVgtgVenK70hVJrv550JSRrTXI5YUYTGxlevv3UgDghf2
	mP/A==
X-Gm-Message-State: APjAAAWU61jCIMSyfP9YKjv6RgU6v1z9FFU9d6GTnfTHkhwKY32hgIBN
	DCX3wjUqqtHPG+oOSkubvEcMifNqL6g=
X-Google-Smtp-Source: APXvYqxGrFfAyUSYhoaM6O4hq4q1C3/A+QVNGqBCM9xBY739brkbXJGIYVrFgoyZ9hHbg/mOiOm8Ng==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr28496389wrw.176.1572955138521; 
	Tue, 05 Nov 2019 03:58:58 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	v128sm26887278wmb.14.2019.11.05.03.58.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 05 Nov 2019 03:58:58 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Nov 2019 11:58:56 +0000
Message-Id: <20191105115856.14129-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] runqueue: Improve sstate rehashing output
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
X-List-Received-Date: Tue, 05 Nov 2019 11:58:58 -0000
Content-Transfer-Encoding: 8bit

Bibake is currently too 'chatty' when hash equivalence is enabled. Fix
this by only printing the log output if a rehash happens and it matches
an sstate object.

Also, pass a summary option to the hash checking function. This was
already changed to a mechanism which allows addition of new parameters
so this should be backwards and forwards compatible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 18049436fd..8622738fd9 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1397,7 +1397,7 @@ class RunQueue:
             cache[tid] = iscurrent
         return iscurrent
 
-    def validate_hashes(self, tocheck, data, currentcount=0, siginfo=False):
+    def validate_hashes(self, tocheck, data, currentcount=0, siginfo=False, summary=True):
         valid = set()
         if self.hashvalidate:
             sq_data = {}
@@ -1410,15 +1410,15 @@ class RunQueue:
                 sq_data['hashfn'][tid] = self.rqdata.dataCaches[mc].hashfn[taskfn]
                 sq_data['unihash'][tid] = self.rqdata.runtaskentries[tid].unihash
 
-            valid = self.validate_hash(sq_data, data, siginfo, currentcount)
+            valid = self.validate_hash(sq_data, data, siginfo, currentcount, summary)
 
         return valid
 
-    def validate_hash(self, sq_data, d, siginfo, currentcount):
-        locs = {"sq_data" : sq_data, "d" : d, "siginfo" : siginfo, "currentcount" : currentcount}
+    def validate_hash(self, sq_data, d, siginfo, currentcount, summary):
+        locs = {"sq_data" : sq_data, "d" : d, "siginfo" : siginfo, "currentcount" : currentcount, "summary" : summary}
 
         # Metadata has **kwargs so args can be added, sq_data can also gain new fields
-        call = self.hashvalidate + "(sq_data, d, siginfo=siginfo, currentcount=currentcount)"
+        call = self.hashvalidate + "(sq_data, d, siginfo=siginfo, currentcount=currentcount, summary=summary)"
 
         return bb.utils.better_eval(call, locs)
 
@@ -1605,7 +1605,7 @@ class RunQueue:
 
             tocheck.add(tid)
 
-        valid_new = self.validate_hashes(tocheck, self.cooker.data, 0, True)
+        valid_new = self.validate_hashes(tocheck, self.cooker.data, 0, True, summary=False)
 
         # Tasks which are both setscene and noexec never care about dependencies
         # We therefore find tasks which are setscene and noexec and mark their
@@ -1986,7 +1986,7 @@ class RunQueueExecute:
                             continue
                         logger.debug(1, "Task %s no longer deferred" % nexttask)
                         del self.sq_deferred[nexttask]
-                        valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, 0, False)
+                        valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, 0, False, summary=False)
                         if not valid:
                             logger.debug(1, "%s didn't become valid, skipping setscene" % nexttask)
                             self.sq_task_failoutright(nexttask)
@@ -2361,9 +2361,13 @@ class RunQueueExecute:
             if tid in self.build_stamps:
                 del self.build_stamps[tid]
 
-            logger.info("Setscene task %s now valid and being rerun" % tid)
+            origvalid = False
+            if tid in self.sqdata.valid:
+                origvalid = True
             self.sqdone = False
-            update_scenequeue_data([tid], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
+            update_scenequeue_data([tid], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+            if tid in self.sqdata.valid and not origvalid:
+                logger.info("Setscene task %s became valid" % tid)
 
         if changed:
             self.holdoff_need_update = True
@@ -2692,9 +2696,9 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     sqdata.stamppresent = set()
     sqdata.valid = set()
 
-    update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq)
+    update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True)
 
-def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq):
+def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True):
 
     tocheck = set()
 
@@ -2728,7 +2732,7 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
         tocheck.add(tid)
 
-    sqdata.valid |= rq.validate_hashes(tocheck, cooker.data, len(sqdata.stamppresent), False)
+    sqdata.valid |= rq.validate_hashes(tocheck, cooker.data, len(sqdata.stamppresent), False, summary=summary)
 
     sqdata.hashes = {}
     for mc in sorted(sqdata.multiconfigs):
-- 
2.20.1


