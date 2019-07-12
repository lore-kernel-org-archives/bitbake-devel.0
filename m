Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
	[209.85.221.53])
	by mail.openembedded.org (Postfix) with ESMTP id 9C8CA7F105
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 13:13:52 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id n4so9969038wrs.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=eWWX3L0aRgE9sLDCKq4RP5Fnzggv86Cpj1TGrqOpoqY=;
	b=SE7u8F/1rOY65ND9Tj3hIXsFVoLztT9mBfwV39CxcODRcTe4IiAPngF+hq2B+6PeSx
	PzJh8SuyeMlkNbC3sUMbkgsg5DTe4/D7JGmXyARQYWKDeFIZ4s0ITGKtFj7gOtYI+zDX
	OcA2QLllUeX40sq6jzev4KbEJKiFGbCj1p/I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eWWX3L0aRgE9sLDCKq4RP5Fnzggv86Cpj1TGrqOpoqY=;
	b=StowIimL1z8jmL6xI3SbQVrE5SDMA/C+Ri6mDJb4pvqaR1INXUZboO6SnSNoeEkKoM
	YqBc+hKXvfTWZpv9OZrzGZuNkQi69OHUGWf79xK9Q1lCNInVHEFb2KBhRxH8npnHaN/4
	MsWc/n0lA+1TuSYBtDZw0b+wwzOBkmQj4GwDQobFRtnt9UHtabnARMyVr3HSaUYZw5AO
	f1wzUOuzivdHNDfA/tJJyI4ZdDi7N1Y8oUHCAguuTTp3ddZedlkOmWO+Nc2XHYp18lO1
	JPSs0bBPYNyjiqXHObx4wIVUdkvs5XvCEju11vu1qXPNigPilmYC881xMctl5CFfB6O5
	9Rmg==
X-Gm-Message-State: APjAAAU2EfkplC4wsgdm0mjxuJS74ImW+4mEyje+ZO4B1VqRHbyJqkw7
	dZqqU6/Kq3RSgvfwWjoqS0bSxWwkrRs=
X-Google-Smtp-Source: APXvYqy0lOWhrLM37HV/GnUelOlSqrqHWWLvU65tcUwywKnyUj7gLMedtgTM2we1rB+R6Y1RnQnKSw==
X-Received: by 2002:a5d:4cca:: with SMTP id c10mr11219770wrt.233.1562937232909;
	Fri, 12 Jul 2019 06:13:52 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	k9sm6015169wmi.33.2019.07.12.06.13.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 06:13:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jul 2019 14:13:45 +0100
Message-Id: <20190712131349.29918-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
References: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/7] runqueue: Whitespace fix
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
X-List-Received-Date: Fri, 12 Jul 2019 13:13:52 -0000
Content-Transfer-Encoding: 8bit

Fix some unwanted extra indentation.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2d52ef3190..624cc756fd 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2438,29 +2438,29 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
     # Note that anything explicitly depended upon will have its reverse dependencies removed to avoid circular dependencies
     for tid in rqdata.runq_setscene_tids:
-            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-            realtid = tid + "_setscene"
-            idepends = rqdata.taskData[mc].taskentries[realtid].idepends
-            sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", rqdata.dataCaches[mc], taskfn, noextra=True)
-            for (depname, idependtask) in idepends:
+        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+        realtid = tid + "_setscene"
+        idepends = rqdata.taskData[mc].taskentries[realtid].idepends
+        sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", rqdata.dataCaches[mc], taskfn, noextra=True)
+        for (depname, idependtask) in idepends:
 
-                if depname not in rqdata.taskData[mc].build_targets:
-                    continue
+            if depname not in rqdata.taskData[mc].build_targets:
+                continue
 
-                depfn = rqdata.taskData[mc].build_targets[depname][0]
-                if depfn is None:
-                     continue
-                deptid = depfn + ":" + idependtask.replace("_setscene", "")
-                if deptid not in rqdata.runtaskentries:
-                    bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (realtid, depfn, idependtask))
+            depfn = rqdata.taskData[mc].build_targets[depname][0]
+            if depfn is None:
+                continue
+            deptid = depfn + ":" + idependtask.replace("_setscene", "")
+            if deptid not in rqdata.runtaskentries:
+                bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (realtid, depfn, idependtask))
 
-                if not deptid in sqdata.sq_harddeps:
-                    sqdata.sq_harddeps[deptid] = set()
-                sqdata.sq_harddeps[deptid].add(tid)
+            if not deptid in sqdata.sq_harddeps:
+                sqdata.sq_harddeps[deptid] = set()
+            sqdata.sq_harddeps[deptid].add(tid)
 
-                sq_revdeps_squash[tid].add(deptid)
-                # Have to zero this to avoid circular dependencies
-                sq_revdeps_squash[deptid] = set()
+            sq_revdeps_squash[tid].add(deptid)
+            # Have to zero this to avoid circular dependencies
+            sq_revdeps_squash[deptid] = set()
 
     rqdata.init_progress_reporter.next_stage()
 
-- 
2.20.1


