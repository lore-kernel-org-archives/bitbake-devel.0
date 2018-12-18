Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f180.google.com (mail-it1-f180.google.com
	[209.85.166.180])
	by mail.openembedded.org (Postfix) with ESMTP id 01F517C04B;
	Tue, 18 Dec 2018 15:31:16 +0000 (UTC)
Received: by mail-it1-f180.google.com with SMTP id c9so4801101itj.1;
	Tue, 18 Dec 2018 07:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Ne/qp1D/s9l7jgaNmCR1FjiK/j+XVu85O/dEaCDDaP8=;
	b=PceHYU9bov2aQS6Mp8Wx/yAMYgeilkx4gv+JnUpCDqGn8VrFclMRTcoPT7yIwFQcSN
	LFUH+tTiI/rp+/kIEg5IHApFGUUhDLnnGZARYvuR71WxhQHhDOMprooKZhiP9F+wSkkB
	Fdg5DvRkv9WNeNp6XYLeBsd/TfsG5cKZivoOQjDlkW60rKcKvlHYaDfA6Ia5fXtKcxGI
	xKauFkuvGZ2ll1bSX5reetpWu9r8zSQFPII18kJSD1X/B2IRoL+4QUCbFsDW7inc/55o
	O2Hsc6Wp35bt7t8RygmXRETHICNK4FkRQkf4uE9ADyK69kxj4F28BSDv8Po8nCSQA9k2
	jtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Ne/qp1D/s9l7jgaNmCR1FjiK/j+XVu85O/dEaCDDaP8=;
	b=YCD3PFNozwEvQvxzCaxkeCF0DeQSbCgXZn5zU1+sh0FXoC3XHZ94prABxLREMOTheM
	YxBZ4KFw2IxW8uafgo8QV/8RBzY9CrTSmNanWvpH6HmhT+j0DZlHGgmihN5PqQqMF/c0
	cvcRBU+SmHHGKgnd1x41uRSpRiP3Q1fI7OZVmPqnxW0bXSFNTeot91U6hiwHZg+uJ2/G
	6qQyb6blhnvq8MhMBJYofWtHJCCgSsTT0au7on/KdLB8SwhxsndGkmx2K4Hdsl/ShNqf
	sw84gEJkClxn/xAlqUorqQjTFSbPM8wLDr63AAprmZQnwi+r5xYQc5kjlnTHyi+3yFYX
	oSXQ==
X-Gm-Message-State: AA+aEWaHv8i7uGZaeInZQ80Du++USBKB5c2KKfS0UkLOSz0PWJisNnAT
	Je/0jfdiZEozdeqvu3IALO7ke8Tb
X-Google-Smtp-Source: AFSGD/V6qAxOxqFBfrNUBXNIaBOquD80a4h5CFdhy/jZrHew8dBNNKxc8ElozqxpYuGm1kImMxaKGA==
X-Received: by 2002:a24:37ca:: with SMTP id r193mr2896253itr.168.1545147077363;
	Tue, 18 Dec 2018 07:31:17 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:16 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:58 -0600
Message-Id: <20181218153101.9212-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 07/10] bitbake: runqueue: Pass unique hash to hash validate
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:17 -0000
Content-Transfer-Encoding: 8bit

If the unique hash is being used to track task dependencies, the hash
validation function needs to know about it in order to properly validate
the hash.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index de57dcb37b8..161f53c7cb1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1378,6 +1378,23 @@ class RunQueue:
             cache[tid] = iscurrent
         return iscurrent
 
+    def validate_hash(self, *, sq_fn, sq_task, sq_hash, sq_hashfn, siginfo, sq_unihash, d):
+        locs = {"sq_fn" : sq_fn, "sq_task" : sq_task, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn,
+                "sq_unihash" : sq_unihash, "siginfo" : siginfo, "d" : d}
+
+        for hashvalidate_args in ("(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=siginfo, sq_unihash=sq_unihash)",
+                                  "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=siginfo)"):
+            try:
+                call = self.hashvalidate + hashvalidate_args
+                return bb.utils.better_eval(call, locs)
+            except TypeError:
+                continue
+
+        # If none of the hash validate functions worked, try one more time
+        # with the oldest type
+        call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_unihash, d)"
+        return bb.utils.better_eval(call, locs)
+
     def _execute_runqueue(self):
         """
         Run the tasks in a queue prepared by rqdata.prepare()
@@ -1549,6 +1566,7 @@ class RunQueue:
         valid = []
         sq_hash = []
         sq_hashfn = []
+        sq_unihash = []
         sq_fn = []
         sq_taskname = []
         sq_task = []
@@ -1567,16 +1585,13 @@ class RunQueue:
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
 
@@ -2293,6 +2308,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.rq.hashvalidate:
             sq_hash = []
             sq_hashfn = []
+            sq_unihash = []
             sq_fn = []
             sq_taskname = []
             sq_task = []
@@ -2324,14 +2340,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
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


