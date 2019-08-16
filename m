Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 867E57DE3D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 10:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 2D00B183E8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:58:28 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id DpwzyJq8kfUJ for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:58:27 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 706FD185B0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:58:27 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 427451A069
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:58:27 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36C091A065
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:58:27 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:58:27 +0200 (CEST)
Received: from saur.se.axis.com (saur.se.axis.com [10.92.3.10])
	by seth.se.axis.com (Postfix) with ESMTP id 2AC821766
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:58:27 +0200 (CEST)
Received: from saur.se.axis.com (localhost [127.0.0.1])
	by saur.se.axis.com (8.15.2/8.15.2) with ESMTPS id x7GAwRA1000343
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 12:58:27 +0200
Received: (from pkj@localhost)
	by saur.se.axis.com (8.15.2/8.15.2/Submit) id x7GAwRQD000338
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Aug 2019 12:58:27 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 12:58:24 +0200
Message-Id: <20190816105824.32765-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: [PATCHv2] runqueue: Add a progress meter for checking the task stamps
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
X-List-Received-Date: Fri, 16 Aug 2019 10:58:28 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/runqueue.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 7fa074f679..86dbd16def 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2672,9 +2672,16 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         stamppresent = []
         tocheck = set()
 
+        msg = "Checking task stamps"
+        bb.event.fire(bb.event.ProcessStarted(msg, len(sqdata.sq_revdeps)), cooker.data)
+
+        checked = 0
         for tid in sorted(sqdata.sq_revdeps):
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
 
+            checked = checked + 1
+            bb.event.fire(bb.event.ProcessProgress(msg, checked), cooker.data)
+
             taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
 
             if 'noexec' in taskdep and taskname in taskdep['noexec']:
@@ -2696,6 +2703,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 continue
 
             tocheck.add(tid)
+        bb.event.fire(bb.event.ProcessFinished(msg), cooker.data)
 
         valid = rq.validate_hashes(tocheck, cooker.data, len(stamppresent), False)
 
-- 
2.21.0


