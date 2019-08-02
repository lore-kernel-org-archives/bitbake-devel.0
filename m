Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id 956CB7F357
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:21:00 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id r1so77542030wrl.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Qd1fjmWjucj5cbb6OyMepEn07J2dd1e+q/Shrzcw+Sc=;
	b=HbYrmCHCg3abWvMLz6vQAiQrHDw1Pb8QDu25kj9JP/3lU3GSB/G89okh1hzOnMI1nz
	ZJ/QJZOlOpcuZwu8EksIR5FzY91Yu4R+TuFJ/YJPhSvG/1w9b//u/abPY6hwoD/QhPUo
	pt3d9Bk0XT7VvXcjyQbQfKglI1RV2+4+RaQw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Qd1fjmWjucj5cbb6OyMepEn07J2dd1e+q/Shrzcw+Sc=;
	b=aPpc8jxV1HKuMhqwVDMiBkow6uZoVAY6HalA8liX3sCKiB88rBpClu3xbeLGyhBD2e
	kjU3ud8gh360yAVSzZjnS64Woe6afArQtxadRtSbeytboLSRSA+0zkYJ+Fks4w0atb3O
	2v4CqM2lv8SzS03uJVeV2MqBkS/ZIhuqJTOpRB7ZgccK5tl/RMJZbTQVtM4DoGw06Sox
	jVmGoMbo2ifOAA8tQztj9fY8OT/qivDooJUfoIL6Ev9XJ7Wttw7PEjDQ9ZxxCuSD/Wtp
	ih1jUCxemfsJLMkp68mQ6H/qp4BJvLGl5yr/3fookwV+RPSAVo0NBA6JH0rdYB4gRb4M
	Y7xw==
X-Gm-Message-State: APjAAAXAMbGTPEXijjihRMqbEB4eYhBK64jjh7wrrvpJQAOMKqKybwbQ
	5bblYa6JKpH3kZoJaAX74oZSJw/cTTk=
X-Google-Smtp-Source: APXvYqwliYO03s1k/EyLrsuKwE8UIosyal4wMOFGxpUxU+a4TtucfBZ7K4WGfg1F2u/Fxqgw/cfbsQ==
X-Received: by 2002:a5d:5152:: with SMTP id u18mr9253214wrt.9.1564759261041;
	Fri, 02 Aug 2019 08:21:01 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.21.00
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:21:00 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:45 +0100
Message-Id: <20190802152049.16529-12-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 12/16] runqueue: Clean up BB_HASHCHECK_FUNCTION API
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
X-List-Received-Date: Fri, 02 Aug 2019 15:21:01 -0000
Content-Transfer-Encoding: 8bit

This function uses an old API which uses offsets into lists as a communication
mechanism. Update the API to use "tid" which is used universally in runqueue now.

We can also add kwargs support to the funciton definition to drop some of the
backwards compaiblility hoops we had to jump though with different function
argument combinations.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py                            | 54 +++++--------------
 .../tests/runqueue-tests/classes/base.bbclass | 22 ++++----
 2 files changed, 23 insertions(+), 53 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8b9cb688fd..07dc5c0003 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1388,57 +1388,29 @@ class RunQueue:
             cache[tid] = iscurrent
         return iscurrent
 
-    def validate_hashes(self, tocheck, data, presentcount=None, siginfo=False):
+    def validate_hashes(self, tocheck, data, currentcount=None, siginfo=False):
         valid = set()
         if self.hashvalidate:
-            sq_hash = []
-            sq_hashfn = []
-            sq_unihash = []
-            sq_fn = []
-            sq_taskname = []
-            sq_task = []
+            sq_data = {}
+            sq_data['hash'] = {}
+            sq_data['hashfn'] = {}
+            sq_data['unihash'] = {}
             for tid in tocheck:
                 (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+                sq_data['hash'][tid] = self.rqdata.runtaskentries[tid].hash
+                sq_data['hashfn'][tid] = self.rqdata.dataCaches[mc].hashfn[taskfn]
+                sq_data['unihash'][tid] = self.rqdata.runtaskentries[tid].unihash
 
-                sq_fn.append(fn)
-                sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
-                sq_hash.append(self.rqdata.runtaskentries[tid].hash)
-                sq_unihash.append(self.rqdata.runtaskentries[tid].unihash)
-                sq_taskname.append(taskname)
-                sq_task.append(tid)
-
-            if presentcount is not None:
-                data.setVar("BB_SETSCENE_STAMPCURRENT_COUNT", presentcount)
-
-            valid_ids = self.validate_hash(sq_fn, sq_taskname, sq_hash, sq_hashfn, siginfo, sq_unihash, data, presentcount)
-
-            if presentcount is not None:
-                data.delVar("BB_SETSCENE_STAMPCURRENT_COUNT")
-
-            for v in valid_ids:
-                valid.add(sq_task[v])
+            valid_ids = self.validate_hash(sq_data, data, siginfo, currentcount)
 
         return valid
 
-    def validate_hash(self, sq_fn, sq_task, sq_hash, sq_hashfn, siginfo, sq_unihash, d, presentcount):
-        locs = {"sq_fn" : sq_fn, "sq_task" : sq_task, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn,
-                "sq_unihash" : sq_unihash, "siginfo" : siginfo, "d" : d}
+    def validate_hash(self, sq_data, d, siginfo, currentcount):
+        locs = {"sq_data" : sq_data, "d" : d, "siginfo" : siginfo, "currentcount" : currentcount}
 
-        # Backwards compatibility
-        hashvalidate_args = ("(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=siginfo, sq_unihash=sq_unihash)",
-                             "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=siginfo)",
-                             "(sq_fn, sq_task, sq_hash, sq_hashfn, d)")
-
-        for args in hashvalidate_args[:-1]:
-            try:
-                call = self.hashvalidate + args
-                return bb.utils.better_eval(call, locs)
-            except TypeError:
-                continue
+        # Metadata has **kwargs so args can be added, sq_data can also gain new fields
+        call = self.hashvalidate + "(sq_data, d, siginfo=siginfo, currentcount=currentcount)"
 
-        # Call the last entry without a try...catch to propagate any thrown
-        # TypeError
-        call = self.hashvalidate + hashvalidate_args[-1]
         return bb.utils.better_eval(call, locs)
 
     def _execute_runqueue(self):
diff --git a/lib/bb/tests/runqueue-tests/classes/base.bbclass b/lib/bb/tests/runqueue-tests/classes/base.bbclass
index 5b87e20bce..3a0f151c9a 100644
--- a/lib/bb/tests/runqueue-tests/classes/base.bbclass
+++ b/lib/bb/tests/runqueue-tests/classes/base.bbclass
@@ -216,27 +216,25 @@ def setscene_depvalid(task, taskdependees, notneeded, d, log=None):
 
 BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
 
-def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *, sq_unihash=None):
+def sstate_checkhashes(sq_data, d, siginfo=False, currentcount=0, **kwargs):
 
-    ret = []
-    missed = []
+    found = set()
+    missed = set()
 
     valid = d.getVar("SSTATEVALID").split()
 
-    for task in range(len(sq_fn)):
-        n = os.path.basename(sq_fn[task]).rsplit(".", 1)[0] + ":" + sq_task[task]
+    for tid in sq_data['hash']:
+        n = os.path.basename(bb.runqueue.fn_from_tid(tid)).split(".")[0] + ":do_" + bb.runqueue.taskname_from_tid(tid)[3:]
+        print(n)
         if n in valid:
             bb.note("SState: Found valid sstate for %s" % n)
-            ret.append(task)
+            found.add(tid)
         elif os.path.exists(d.expand("${TOPDIR}/%s.run" % n.replace("do_", ""))):
             bb.note("SState: Found valid sstate for %s (already run)" % n)
-            ret.append(task)
+            found.add(tid)
         else:
-            missed.append(task)
+            missed.add(tid)
             bb.note("SState: Found no valid sstate for %s" % n)
 
-    if hasattr(bb.parse.siggen, "checkhashes"):
-        bb.parse.siggen.checkhashes(missed, ret, sq_fn, sq_task, sq_hash, sq_hashfn, d)
-
-    return ret
+    return found
 
-- 
2.20.1


