Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
	[209.85.223.182])
	by mail.openembedded.org (Postfix) with ESMTP id 5E3D078E50;
	Thu,  9 Aug 2018 22:10:53 +0000 (UTC)
Received: by mail-io0-f182.google.com with SMTP id l7-v6so2238228iok.6;
	Thu, 09 Aug 2018 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BaNEUA44dyX7rz6Hu3sNfMeimU99MyJOFDSExhgCMQ4=;
	b=h4qpoerm3pUIA2HdnZK8wzCJu6jQCRCatmv9xKhfEvgrnBc3Wh3cjxbSerZfYhmUuT
	6RDyY8wWg0zvUTpnm/ugZ/jq1QcVdZDi4AKZNPZeEaypPO4R2VVBggUNn4+M0trCTDpJ
	Lijyy/dPCJFeFONUtRpN5ZM0EUHBlrPj4g8xxQ+Bx1KfRXlYHcvnSogS4/JU5+MeEp2B
	KOx8wiLWxO0LB9GjuF465T5eyB4z4FjguNfFk93J43WqNgURDkT33TdcV0k9eeRSDoEI
	nX83gA00dHd6ah6+x72UvMVdAWkAmxdvlECI6ApGNs/3uaamTrIYp5Mt/MSq+pnBTuhL
	PHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BaNEUA44dyX7rz6Hu3sNfMeimU99MyJOFDSExhgCMQ4=;
	b=XPXtTxuSwtCwQNhZ0DgDaoSk/McJ506lMmMvcnrhmoam7NCWOpUcsMvKxO9AEMycCq
	t6Yonmi9rSEcSqfvcgdpXb8JYOIcDALfiSPAzmE9P5Gyh2wU6zZEpc1VUGHppd/ph9ZF
	5GRldr8bzzQ1GHaJ0SqpUFNJbDtASRlPRKw8okK41038ieiTtMYnqn11K9ZrUcVo5TTA
	XV2/ByDfQj05fNO145h4Ozzy4AsK4Fvn5dUvT6CFjhC5d2Tk6p+7ZKnshWKT7wej/g3I
	DwM4njLcWwthgH84A8wK1SFxsKg56JjhohgAmIvOPoxIsHaWA8PFGfwqEBdClwdxMpBj
	dmww==
X-Gm-Message-State: AOUpUlGoE2QzOBgzO8dKMDNVUxqjK3VwWLfDlNvHj4pW7K2N7fnViSEO
	h+jd4UyHOipp/Pfe+LnlvywziT9L
X-Google-Smtp-Source: AA+uWPzfZnn9KwwD9/QeDLu/XzL9kJfBSJI3bjoOcIOk06Gk826OmEiandJlfUTLMCCQEM7EcjNAwg==
X-Received: by 2002:a6b:ce19:: with SMTP id
	p25-v6mr3479527iob.243.1533852654438; 
	Thu, 09 Aug 2018 15:10:54 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:53 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:37 -0500
Message-Id: <20180809220840.26697-14-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 13/16] bitbake: runqueue: Pass dependency ID to hash validate
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:53 -0000

If the dependency ID is being used to track task dependencies, the hash
validation function needs to know about it in order to properly validate
the hash.

TODO: This currently isn't going to be backward compatible with older
hashvalidate functions. Is that necessary, and if so are there any
suggestions for a good approach?

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 909fa3aec22..707baed2125 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1548,6 +1548,7 @@ class RunQueue:
         valid = []
         sq_hash = []
         sq_hashfn = []
+        sq_depid = []
         sq_fn = []
         sq_taskname = []
         sq_task = []
@@ -1566,15 +1567,16 @@ class RunQueue:
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
@@ -2286,6 +2288,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.rq.hashvalidate:
             sq_hash = []
             sq_hashfn = []
+            sq_depid = []
             sq_fn = []
             sq_taskname = []
             sq_task = []
@@ -2317,13 +2320,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
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
2.17.1


