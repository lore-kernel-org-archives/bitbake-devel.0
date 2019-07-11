Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id 52AFF7EFE9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 16:12:26 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id 31so6962789wrm.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=eWWX3L0aRgE9sLDCKq4RP5Fnzggv86Cpj1TGrqOpoqY=;
	b=MZnjZyQpTtU738S68sCmUqcnXVCaL9MVTFaGfkwggDdRTcwZa3s4qXw+xB1WQEK3Z+
	N/4l2uUssexhFz1JBhRJa2Cm3ifovTWz4Z/QFa4LqheCsREJbaiOqfKC1Nvtv9f771wj
	sATbRVOJmREFNvqeTsKZtLWTgCqxkx2Q2g2hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eWWX3L0aRgE9sLDCKq4RP5Fnzggv86Cpj1TGrqOpoqY=;
	b=HMLM0NIdmbKB+3ORdZ0Daps4dbLB0MCgIK0iQFu/1jHG9S5oFu21qp/C0u7AxKRk7c
	r71dJbV5eDU/mZYg1BBwHVmtBP6aGRc+wwdgwbFHhy2Kw2QjYSnYqoOZpQ6aB8JDEqZ1
	2JNDU3t3jFaQnBmuWKA4ErxryDPjM5lP4MedNTEcvigo5fdjoeOJG5ctoOxZsg/d5wnH
	fsaJZ3F2YVgTYEw0AXIdYBL1DJmrKQQJF2e1P/TW0eWjDjO2RgbTJSFfGu6X2lmaZDHz
	nVDINJUVN6ATCWRzcah6PzRQIHtXQJg6JCHtj8lZREFLdxZ0ihP0wUJgqszb4NpxVUTS
	07jA==
X-Gm-Message-State: APjAAAWy8g0A/O+tWBpxpIgx2hz5JnqXbpTI6j+NtFicsT7HPlweR/wC
	Jufdqgv4wHI08ri3guUA7FNLxR6Pjpg=
X-Google-Smtp-Source: APXvYqzgPB/gSw+TnoJ28e04CDc6Yziq0XSyeaQIMZ9FSlf7Hdxl7f6A1/QbLGrjBaW9rk30yZ1w5w==
X-Received: by 2002:adf:efc5:: with SMTP id i5mr6034131wrp.158.1562861546831; 
	Thu, 11 Jul 2019 09:12:26 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c7sm4841279wro.70.2019.07.11.09.12.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 09:12:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 17:12:21 +0100
Message-Id: <20190711161223.12376-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
References: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/5] runqueue: Whitespace fix
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
X-List-Received-Date: Thu, 11 Jul 2019 16:12:26 -0000
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


