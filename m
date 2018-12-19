Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com
	[209.85.166.45])
	by mail.openembedded.org (Postfix) with ESMTP id 32E457BEB8;
	Wed, 19 Dec 2018 03:10:42 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id l14so14473349ioj.5;
	Tue, 18 Dec 2018 19:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DOztZptPuqxun+W5ivyycWdPZl2ZBIGCcpXJMldQAo4=;
	b=m6AvtxOz/gW1otZdARmw6LxUuZ+DArQMXN7ar4CZuX1XBLMDyV1ILu0OOYC8dyp6Ro
	HXmrSpM3IKWbQoCHNug0E4q9rruSFsvQp0Drok+QK58zk7xFRiVH3WXI3iIzuVQSnS2r
	r7RORPgayuswUJIu46dJJibINWnMzCYdekY3WNbB1jFm7e/QKmxo/+7IgKZFffCRL98E
	0OHSbsUNZZujoy2fBtvVopgcqGJnqlcYVahIi0Qw+RBJHBJ9EW3MXuGCaZS615vl7srr
	r67rrR0a3Ri9qSAFXfXLKEMDhDYTAzRnOizC94UNyWuUwBDKmcqMqOHiy1iX6REtjUR0
	NnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DOztZptPuqxun+W5ivyycWdPZl2ZBIGCcpXJMldQAo4=;
	b=Z9mplO6Gl0E2Abbluxdr83lf3FCMxmGS4tpasZnaRPYZx/ppZ0hrh4RpTQKE6xlGKp
	+gsDwBndwdDE2eqNlRQb2XAt6k5cGM+vPsgAMunZzcA/bXDjHu89vTEPB4bKfY+DcrN5
	MuJHr3qGMe/cYrUpK8dCYJeA8gjiV/lrtHaQEuw3yymZ9/0koORU/5iVgXIFWjJ9tsCU
	2+aHj+Gj2HrkvFIYZ5N27xRNlcjC3NvACnkr3cdqJJGeRhhGR2DUW0G3UyWQZOwsD/tY
	67HgvB2UDPMtMYAiCb1paxDaq08mlwa6ZFtSZ6ga4SsH+0NNBVvu3dYkHFJM0Ko6siJJ
	XUWw==
X-Gm-Message-State: AA+aEWbPQHT7raorV9lqyKzRyh1G6BIzv8J9EtSN7yPeA6oLu4bkor0X
	s5j1WxSzeLeSeS15lGHECYpvaMiN
X-Google-Smtp-Source: AFSGD/W4z9UoMRZRC5Pfzx2tn427OnZ0+zhbuVDlaaXnEjUwO1MqALI4Ywy2fTRGVIDw0209QKpkBg==
X-Received: by 2002:a5e:cb0b:: with SMTP id p11mr17539071iom.60.1545189042916; 
	Tue, 18 Dec 2018 19:10:42 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r63sm2795992ita.2.2018.12.18.19.10.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 19:10:42 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 21:10:30 -0600
Message-Id: <20181219031033.28045-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219031033.28045-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v5 5/8] bitbake: runqueue: Pass unique hash to hash validate
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
X-List-Received-Date: Wed, 19 Dec 2018 03:10:42 -0000
Content-Transfer-Encoding: 8bit

If the unique hash is being used to track task dependencies, the hash
validation function needs to know about it in order to properly validate
the hash.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 41 ++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index de57dcb37b8..f44eff46759 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1378,6 +1378,26 @@ class RunQueue:
             cache[tid] = iscurrent
         return iscurrent
 
+    def validate_hash(self, *, sq_fn, sq_task, sq_hash, sq_hashfn, siginfo, sq_unihash, d):
+        locs = {"sq_fn" : sq_fn, "sq_task" : sq_task, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn,
+                "sq_unihash" : sq_unihash, "siginfo" : siginfo, "d" : d}
+
+        hashvalidate_args = ("(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=siginfo, sq_unihash=sq_unihash)",
+                             "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=siginfo)",
+                             "(sq_fn, sq_task, sq_hash, sq_hashfn, d)")
+
+        for args in hashvalidate_args[:-1]:
+            try:
+                call = self.hashvalidate + args
+                return bb.utils.better_eval(call, locs)
+            except TypeError:
+                continue
+
+        # Call the last entry without a try...catch to propagate any thrown
+        # TypeError
+        call = self.hashvalidate + hashvalidate_args[-1]
+        return bb.utils.better_eval(call, locs)
+
     def _execute_runqueue(self):
         """
         Run the tasks in a queue prepared by rqdata.prepare()
@@ -1549,6 +1569,7 @@ class RunQueue:
         valid = []
         sq_hash = []
         sq_hashfn = []
+        sq_unihash = []
         sq_fn = []
         sq_taskname = []
         sq_task = []
@@ -1567,16 +1588,13 @@ class RunQueue:
             sq_fn.append(fn)
             sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
             sq_hash.append(self.rqdata.runtaskentries[tid].hash)
+            sq_unihash.append(self.rqdata.runtaskentries[tid].unihash)
             sq_taskname.append(taskname)
             sq_task.append(tid)
-        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
-        try:
-            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=True)"
-            valid = bb.utils.better_eval(call, locs)
-        # Handle version with no siginfo parameter
-        except TypeError:
-            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
-            valid = bb.utils.better_eval(call, locs)
+
+        valid = self.validate_hash(sq_fn=sq_fn, sq_task=sq_taskname, sq_hash=sq_hash, sq_hashfn=sq_hashfn,
+                siginfo=True, sq_unihash=sq_unihash, d=self.cooker.data)
+
         for v in valid:
             valid_new.add(sq_task[v])
 
@@ -2293,6 +2311,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.rq.hashvalidate:
             sq_hash = []
             sq_hashfn = []
+            sq_unihash = []
             sq_fn = []
             sq_taskname = []
             sq_task = []
@@ -2324,14 +2343,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_fn.append(fn)
                 sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
                 sq_hash.append(self.rqdata.runtaskentries[tid].hash)
+                sq_unihash.append(self.rqdata.runtaskentries[tid].unihash)
                 sq_taskname.append(taskname)
                 sq_task.append(tid)
 
             self.cooker.data.setVar("BB_SETSCENE_STAMPCURRENT_COUNT", len(stamppresent))
 
-            call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
-            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
-            valid = bb.utils.better_eval(call, locs)
+            valid = self.rq.validate_hash(sq_fn=sq_fn, sq_task=sq_taskname, sq_hash=sq_hash, sq_hashfn=sq_hashfn,
+                    siginfo=False, sq_unihash=sq_unihash, d=self.cooker.data)
 
             self.cooker.data.delVar("BB_SETSCENE_STAMPCURRENT_COUNT")
 
-- 
2.19.2


