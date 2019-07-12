Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id EF5157F11A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 13:13:54 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c2so6749274wrm.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=qOsx7/DzxxSencgE/p+HzvV1MyVfKRY3dV5AQPdPc6E=;
	b=F4w8Sz1YaNlXh8rItB9jM4MVVYwcSYidNc46qrp61MFKzq9dQMzvgSpjpZWzbK/adG
	zi8xGrvoj9q6Elbd+8Ay/RlEQBMbeZBk/Al+uD7nwpURMeIepvqgJ2N2fCq1jIiuakf8
	iNaFaz56gGNSMBydCwVSrPNZgP8Kx2wgFjYj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qOsx7/DzxxSencgE/p+HzvV1MyVfKRY3dV5AQPdPc6E=;
	b=izHbn4e4MJzvIxCBZasmM9BZisOyN22zh3bqau5q+K7jnbCNsxm1ZlR0czIrFYw2UT
	BuIDy2xk/FrM13kjd8cVFY+0dTNFO1pkJl1X6HrrAULEEslH3kA9Ihduag8l7ZnuPFDl
	ll0aXYNP5IW7qRzz33vx7USD5QCmr4EA7rQMCAf1t+C721HHC8rOANnH8CNHvheCrcSA
	fEhrNAF3P3maoUz1TQpUHaDl/RB+Ut9LDPIrDNUYoN9/5IZwxNEQBE7rqikE2s7wQJXc
	wnrtCdz30cpZx5W7twSZzH6B7qZPwhWPFZl/PD7UQqAFdx9lY8Tl4mCIvrgS2SAf/KEx
	rrgg==
X-Gm-Message-State: APjAAAXKsXwhsh3lb1s+XDrz9JhphFs7fwnqrZZLtymNDS6AdQFgzsC3
	pHBu13CuisvCcCz7Ml6Loxq8XRdn714=
X-Google-Smtp-Source: APXvYqy9Nox0ImrKouYpaa7vavpEg2j29EyIc0lniAg1JtrgL4YKyzDoRQGAsKI8o1ZlyTW6Ow+tVA==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr6766254wrj.16.1562937235341;
	Fri, 12 Jul 2019 06:13:55 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	k9sm6015169wmi.33.2019.07.12.06.13.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 06:13:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jul 2019 14:13:47 +0100
Message-Id: <20190712131349.29918-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
References: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 5/7] runqueue: Abstract hash verification function
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
X-List-Received-Date: Fri, 12 Jul 2019 13:13:55 -0000
Content-Transfer-Encoding: 8bit

Pull the common pieces of the hash verification code into a single function
and reduce code duplication.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 82 ++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 624cc756fd..1cc2bf267c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1376,10 +1376,43 @@ class RunQueue:
             cache[tid] = iscurrent
         return iscurrent
 
-    def validate_hash(self, *, sq_fn, sq_task, sq_hash, sq_hashfn, siginfo, sq_unihash, d):
+    def validate_hashes(self, tocheck, data, presentcount=None, siginfo=False):
+        valid = set()
+        if self.hashvalidate:
+            sq_hash = []
+            sq_hashfn = []
+            sq_unihash = []
+            sq_fn = []
+            sq_taskname = []
+            sq_task = []
+            for tid in tocheck:
+                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+
+                sq_fn.append(fn)
+                sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
+                sq_hash.append(self.rqdata.runtaskentries[tid].hash)
+                sq_unihash.append(self.rqdata.runtaskentries[tid].unihash)
+                sq_taskname.append(taskname)
+                sq_task.append(tid)
+
+            if presentcount is not None:
+                data.setVar("BB_SETSCENE_STAMPCURRENT_COUNT", presentcount)
+
+            valid_ids = self.validate_hash(sq_fn, sq_taskname, sq_hash, sq_hashfn, siginfo, sq_unihash, data, presentcount)
+
+            if presentcount is not None:
+                data.delVar("BB_SETSCENE_STAMPCURRENT_COUNT")
+
+            for v in valid_ids:
+                valid.add(sq_task[v])
+
+        return valid
+
+    def validate_hash(self, sq_fn, sq_task, sq_hash, sq_hashfn, siginfo, sq_unihash, d, presentcount):
         locs = {"sq_fn" : sq_fn, "sq_task" : sq_task, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn,
                 "sq_unihash" : sq_unihash, "siginfo" : siginfo, "d" : d}
 
+        # Backwards compatibility
         hashvalidate_args = ("(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=siginfo, sq_unihash=sq_unihash)",
                              "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=siginfo)",
                              "(sq_fn, sq_task, sq_hash, sq_hashfn, d)")
@@ -1564,16 +1597,8 @@ class RunQueue:
 
     def print_diffscenetasks(self):
 
-        valid = []
-        sq_hash = []
-        sq_hashfn = []
-        sq_unihash = []
-        sq_fn = []
-        sq_taskname = []
-        sq_task = []
         noexec = []
-        stamppresent = []
-        valid_new = set()
+        tocheck = set()
 
         for tid in self.rqdata.runtaskentries:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
@@ -1583,18 +1608,9 @@ class RunQueue:
                 noexec.append(tid)
                 continue
 
-            sq_fn.append(fn)
-            sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
-            sq_hash.append(self.rqdata.runtaskentries[tid].hash)
-            sq_unihash.append(self.rqdata.runtaskentries[tid].unihash)
-            sq_taskname.append(taskname)
-            sq_task.append(tid)
+            tocheck.add(tid)
 
-        valid = self.validate_hash(sq_fn=sq_fn, sq_task=sq_taskname, sq_hash=sq_hash, sq_hashfn=sq_hashfn,
-                siginfo=True, sq_unihash=sq_unihash, d=self.cooker.data)
-
-        for v in valid:
-            valid_new.add(sq_task[v])
+        valid_new = self.validate_hashes(tocheck, self.cooker.data, None, True)
 
         # Tasks which are both setscene and noexec never care about dependencies
         # We therefore find tasks which are setscene and noexec and mark their
@@ -2496,14 +2512,10 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     rqdata.init_progress_reporter.finish()
 
     if rq.hashvalidate:
-        sq_hash = []
-        sq_hashfn = []
-        sq_unihash = []
-        sq_fn = []
-        sq_taskname = []
-        sq_task = []
         noexec = []
         stamppresent = []
+        tocheck = set()
+
         for tid in sqdata.sq_revdeps:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
 
@@ -2527,23 +2539,13 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 sqrq.sq_task_skip(tid)
                 continue
 
-            sq_fn.append(fn)
-            sq_hashfn.append(rqdata.dataCaches[mc].hashfn[taskfn])
-            sq_hash.append(rqdata.runtaskentries[tid].hash)
-            sq_unihash.append(rqdata.runtaskentries[tid].unihash)
-            sq_taskname.append(taskname)
-            sq_task.append(tid)
-
-        cooker.data.setVar("BB_SETSCENE_STAMPCURRENT_COUNT", len(stamppresent))
-
-        valid = rq.validate_hash(sq_fn=sq_fn, sq_task=sq_taskname, sq_hash=sq_hash, sq_hashfn=sq_hashfn,
-                siginfo=False, sq_unihash=sq_unihash, d=cooker.data)
+            tocheck.add(tid)
 
-        cooker.data.delVar("BB_SETSCENE_STAMPCURRENT_COUNT")
+        valid = rq.validate_hashes(tocheck, cooker.data, len(stamppresent), False)
 
         valid_new = stamppresent
         for v in valid:
-            valid_new.append(sq_task[v])
+            valid_new.append(v)
 
         for tid in sqdata.sq_revdeps:
             if tid not in valid_new and tid not in noexec:
-- 
2.20.1


