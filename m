Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f174.google.com (mail-it1-f174.google.com
	[209.85.166.174])
	by mail.openembedded.org (Postfix) with ESMTP id C2E366C5DA;
	Tue,  4 Dec 2018 03:46:32 +0000 (UTC)
Received: by mail-it1-f174.google.com with SMTP id i7so13181849iti.2;
	Mon, 03 Dec 2018 19:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=67dKCRuoMDH4nMfvwspeQp0VbcR1ybMRGmdS2StrsHs=;
	b=dqj97us72f/apJr9xnKUrEdQxsgv24ZCT0VpO3yf0Xsp7housUR0yU+KnnrLp9RQkm
	cpkl31dZ41FaBd3jfw91jvijgOVNaq14XiCuo+9YTXohBcIC+fa5bTG9Kv9dFIUlPE19
	huLtUg6wcIA9otXKe8+53xZFXFvYnPKVsEeOWgv2AGRWq/6tgJglkbDC+wyjdV23nyPV
	prn4yKXLMbcqxKUGf/7FE8O6bPE2kp0/3dwMMi5AHtuiq6n6+MiDgtzz93YJn1PurUfM
	bypTPY1yCX4YaDF3eYcY+etQ9OhDU4Tqk4KgtqCRKPfGxoJhBCeMrPOm4TUDxDFsVPrx
	gOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=67dKCRuoMDH4nMfvwspeQp0VbcR1ybMRGmdS2StrsHs=;
	b=qrQSDdupxrURH6LTp1d9v80jEEEpJlDwxSIbnIXGlAAWRs4G3z0TzSkQ/6e9EfwDM3
	/H5ceUKFxdblEyp3Owl3cAEYfigxL+idTigbgsI9j6VJaATevQ9psUTBhdbIPhPKWtHS
	DxYpauLjEe1QO6l0pVGJam/SO0SF8DcOiXSjYYyXHTFbvg0dG3KyXn8JftC7Vl2IdGYu
	FwLdYzX9GE2LRlS0jSB+X/OhtwQ6D+6Kkztzwpa9YYU4JWRfAv1BOUPDs2krOwQdDBKa
	ETzGD35kSD4qBRtOBGxXJ66suRr3y4auYRO1IAMFe0KqHV/ywLLLLXpMvDoDBXS3bZax
	gl3A==
X-Gm-Message-State: AA+aEWZ75xfZfkgj0W05gDcoS70zwFHXL0KkkpFs8xq1b/UllpZbnd51
	PZTaYiOKQTOEavW4RWf2NIHtqOkWuFI=
X-Google-Smtp-Source: AFSGD/WhyI6ukT9UnDdSkL6jSnZaL4Q+th8UMBKCB0E1Cybpj/3BUqmP6Snq9D+OYWOyr7J9DOzuGQ==
X-Received: by 2002:a24:4483:: with SMTP id
	o125mr10129367ita.106.1543895193490; 
	Mon, 03 Dec 2018 19:46:33 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:32 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:41 -0600
Message-Id: <20181204034245.25461-14-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 13/17] bitbake: runqueue: Pass dependency ID to hash validate
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:33 -0000
Content-Transfer-Encoding: 8bit

If the dependency ID is being used to track task dependencies, the hash
validation function needs to know about it in order to properly validate
the hash.

TODO: This currently isn't going to be backward compatible with older
hashvalidate functions. Is that necessary, and if so are there any
suggestions for a good approach?

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index c5e4573b278..dd6c0208daf 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1549,6 +1549,7 @@ class RunQueue:
         valid = []
         sq_hash = []
         sq_hashfn = []
+        sq_depid = []
         sq_fn = []
         sq_taskname = []
         sq_task = []
@@ -1567,15 +1568,16 @@ class RunQueue:
             sq_fn.append(fn)
             sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
             sq_hash.append(self.rqdata.runtaskentries[tid].hash)
+            sq_depid.append(self.rqdata.runtaskentries[tid].depid)
             sq_taskname.append(taskname)
             sq_task.append(tid)
-        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
+        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "sq_depid" : sq_depid, "d" : self.cooker.data }
         try:
-            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=True)"
+            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=True)"
             valid = bb.utils.better_eval(call, locs)
         # Handle version with no siginfo parameter
         except TypeError:
-            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
+            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d)"
             valid = bb.utils.better_eval(call, locs)
         for v in valid:
             valid_new.add(sq_task[v])
@@ -2293,6 +2295,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.rq.hashvalidate:
             sq_hash = []
             sq_hashfn = []
+            sq_depid = []
             sq_fn = []
             sq_taskname = []
             sq_task = []
@@ -2324,13 +2327,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_fn.append(fn)
                 sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
                 sq_hash.append(self.rqdata.runtaskentries[tid].hash)
+                sq_depid.append(self.rqdata.runtaskentries[tid].depid)
                 sq_taskname.append(taskname)
                 sq_task.append(tid)
 
             self.cooker.data.setVar("BB_SETSCENE_STAMPCURRENT_COUNT", len(stamppresent))
 
-            call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
-            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
+            call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d)"
+            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "sq_depid": sq_depid, "d" : self.cooker.data }
             valid = bb.utils.better_eval(call, locs)
 
             self.cooker.data.delVar("BB_SETSCENE_STAMPCURRENT_COUNT")
-- 
2.19.1


