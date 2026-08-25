Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EE0C61DBD
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:46:46 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (SN4PR2101CU001.outbound.protection.outlook.com [40.93.195.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30463.1787687197196140647
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 12:46:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=mvHJRMQ0;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.195.35, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNDfthDuOpWsEcLsOZOkitWPVsjAKjLRXYshLdctdaR1rX2Ry0hPFaD3pANPw/Rnn5Kbs3TrLvfXdHLe76Jckj7fJyRNlvBEWKBuw67U5tkAZkXWPLrAQK/EFjEQ099UYzJ0fr1Qt7MN+c5kKX7TcAzHBtf7eeAujUxN4wkprwMG6EgRwensIyqaiKoIOKjCRblScOngSvPG1cm9Ir7ON76qB/pjsMyEqww39wUiTSWwADm3GtwLIQhw5llKIEn30+OGSTCYdI++YIEMfhML2ybLfL6JgIRK+M3RPCZpQT5u9Lr2Yw0d22yi/FvQADCWtFCb0qg6KlHBtpkiyy4tYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RitnppaGWaGrVPJYGJS+y5CSGVZ+/Qned3jD29sojtk=;
 b=WWwO2h2FeXuudf6zZKUMEJX6FuEVOvnNoasxpFUmHmv8YNuaJLU035jfNv1yyzuNP+/t5oR/KaBGgOJMIMstMNRYhr81rXyfGWFYqt1K2oSTyGGDIl/WyaAbwPA7PVRL6pOSVdGD4/Zu3Igmc2bk/LyhcaaOYDoTOkHEFl14bxP1VLGmT6dVatkCKIiR7OCzaVr1XEl9O+cjZchprEsPpaIDfODWygONdGl4yHTchRbLMewiBU2o03NXa/Pn3HernibIQHkr+tNaoL+7kUoW0FwtcRCs96fwzGQSCg2+hK5HdHezxaba6OR/f0L+5gPR0kd1pm2xUvuKuSOoOK/1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RitnppaGWaGrVPJYGJS+y5CSGVZ+/Qned3jD29sojtk=;
 b=mvHJRMQ0hCmCkOwA8khLAwHQyR2RJjGXWifPtLg+YgDeKE5kYJME22KdjhxLQ/Br9lnZeHndOwi41jO6yjQs4gVON9+yccOU7f4/bljqpNAZn/AQPZhEN4bGKuVD7fCkzsd7Vjxqzv5xJVSnxnaTkRjmJ9BlKVOkwhItxN2keU+28Z9cEMBn48w2CSVnczdMSjIbM51iWCJ471OF/ZdW/WMXYwmupER+W5bv+UJqEGout0Mb1Drxgo8iQ9k/8tPUWNHyOXzfzTvlYqaDb7lvZtQqI2LOy89K7cqf3WVCnruXi3r2XWSwPodGz81dfb6neh2NipCqp8Od5wt61GLLqg==
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 19:46:30 +0000
Received: from BY1PEPF000264B5.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::19) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 19:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BY1PEPF000264B5.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 19:46:29 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 25 Aug 2026 13:45:58 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 3/6] runqueue: use set 'discard' method instead of 'in' followed by 'remove'
Date: Tue, 25 Aug 2026 15:45:46 -0400
Message-ID: <20260825194549.152553-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825194549.152553-1-chris.laplante@agilent.com>
References: <20260825194549.152553-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B5:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 811e7899-bc97-411d-5454-08df02e18f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	WXFGj62tdBQKBW5PKNRVX1osLydruCg2J5266OryyKZC1Aamd8ijhc9lLnFvG0jV5R2yPynjq3B3WcHRgJMb1AkA1+yUJNNUk24QL9LEr3M7Nsx3lzFMIK8zwUbjgzJVl4uwYgrYeBT7xEIM6gJEru5VLxo3zPb7uKW5bSzt8+e1yZ5EfNdiQx1Uo3UvjvmKp/GKzoNTXHugNVdPaPjECxFmTtKLCNJwMDWmqmrTSBy4Qx4NlSfky0rG6+KxZrpMJ9CfH+npnXeVPBdpBc/UtjcFUEY0qBXcy0XhncrbrWuHAQ+IdIgISB9JAvV732DfMapmIwO8AqvORtFDOt9kLFWtcYNPninwK/kJglvWovapoxyvTbo6AcdqVGh54Z/+oit90yAoF7GPWdpMFWjvJCJwXO6M2+Uiiwy5d19IKVAhEKYkipjo/6g8swF6KI4xSg6hGpQEFgBQhIXrQnkJewrR53Ccp/QnCUffvvDz9B0n+QDZpHOgukNaP0F96FNJVOBss89uFkdlhTZfzmFq2pFs0CeTxl0jFq9blc5kxzjC57Ao1YMv7bdNNyumkVcEjWhCkKQcpnekEz/6BRelsQ/A86zXNf9NwSaw7HjKd9e2kT2Sk4MNrgKjoxpDs/hLDsyNZJoP6aHgVFIpTwLhng+quPZjU6PJy2ohzpy3MRFkHzeR3upIfZRktUIagH0m
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	bdb8MtWADc6q/29T91uTd88eW33TTZqIqYZ3TCgDIzRVqaaXVEP9CUN+U7Q2LZzPmr296EZoVivU77hsjvkogEa2LwK40qjKhtB67KDC8t9b2IqrEB/26FfFXcQp+lbIoSVkypCzsyXJqbCEcrhhhkhrm9Zn2EZlv3glJLzqdipd7gf+h2QaQAO2Ec9h5Gg8UwrsiQphuILjeF69agMgjefy5N4C42mKLiMo0eiHJkc6LHisKb04cOGqd5++rahqTws8/+AqaTNvWvZHApChoGU4mCOd7Zfj23FeS6k9VIRX/umMwGhdViO+wufAMaL2Sxo+sFu0szNkSJeZduOv0I9dc+vP2xFFv4xq1RUrZ1/aZpqU5vTt7gChAoDFw5JYQUgK7SsuZXrYPkz3kJGeAyncxghOoi7YPFRomeX5yE5U2KpqOW9ksTVd1+46t7Oc
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 19:46:29.9552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811e7899-bc97-411d-5454-08df02e18f0a
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BY1PEPF000264B5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 19:46:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20043

From: Chris Laplante <chris.laplante@agilent.com>

It makes the code easier to read and is slightly faster.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c2e6561ec..245492de7 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -873,8 +873,7 @@ class RunQueueData:
                 for dep in revdeps[tid]:
                     cumulativedeps[dep].add(fn_from_tid(tid))
                     cumulativedeps[dep].update(cumulativedeps[tid])
-                    if tid in deps[dep]:
-                        deps[dep].remove(tid)
+                    deps[dep].discard(tid)
                     if not deps[dep]:
                         next.add(dep)
             endpoints =3D next
@@ -2687,8 +2686,7 @@ class RunQueueExecute:
             self.pending_migrations.remove(tid)
             changed =3D True
=20
-            if tid in self.tasks_scenequeue_done:
-                self.tasks_scenequeue_done.remove(tid)
+            self.tasks_scenequeue_done.discard(tid)
             for dep in self.sqdata.sq_covered_tasks[tid]:
                 if dep in self.runq_complete and dep not in self.runq_task=
srun:
                     bb.error("Task %s marked as completed but now needing =
to rerun? Halting build." % dep)
@@ -2700,18 +2698,12 @@ class RunQueueExecute:
                     if dep in self.tasks_scenequeue_done and dep not in se=
lf.sqdata.unskippable:
                         self.tasks_scenequeue_done.remove(dep)
=20
-            if tid in self.sq_buildable:
-                self.sq_buildable.remove(tid)
-            if tid in self.sq_running:
-                self.sq_running.remove(tid)
-            if tid in self.sqdata.outrightfail:
-                self.sqdata.outrightfail.remove(tid)
-            if tid in self.scenequeue_notcovered:
-                self.scenequeue_notcovered.remove(tid)
-            if tid in self.scenequeue_covered:
-                self.scenequeue_covered.remove(tid)
-            if tid in self.scenequeue_notneeded:
-                self.scenequeue_notneeded.remove(tid)
+            self.sq_buildable.discard(tid)
+            self.sq_running.discard(tid)
+            self.sqdata.outrightfail.discard(tid)
+            self.scenequeue_notcovered.discard(tid)
+            self.scenequeue_covered.discard(tid)
+            self.scenequeue_notneeded.discard(tid)
=20
             (mc, fn, taskname, taskfn) =3D split_tid_mcfn(tid)
             self.sqdata.stamps[tid] =3D bb.parse.siggen.stampfile_mcfn(tas=
kname, taskfn, extrainfo=3DFalse)
@@ -2975,8 +2967,7 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
         sq_collated_deps[tid] =3D set()
         #bb.warn("Added endpoint 2 %s" % (tid))
         for dep in rqdata.runtaskentries[tid].depends:
-                if tid in sq_revdeps[dep]:
-                    sq_revdeps[dep].remove(tid)
+                sq_revdeps[dep].discard(tid)
                 if dep not in endpoints:
                     endpoints[dep] =3D set()
                 #bb.warn("  Added endpoint 3 %s" % (dep))
@@ -3000,8 +2991,7 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
                 sq_revdeps_squash[point] =3D tasks
                 continue
             for dep in rqdata.runtaskentries[point].depends:
-                if point in sq_revdeps[dep]:
-                    sq_revdeps[dep].remove(point)
+                sq_revdeps[dep].discard(point)
                 if tasks:
                     sq_revdeps_squash[dep] |=3D tasks
                 if not sq_revdeps[dep] and dep not in rqdata.runq_setscene=
_tids:
@@ -3150,12 +3140,9 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq,=
 cooker, stampcache, sqrq, s
     tocheck =3D set()
=20
     for tid in sorted(tids):
-        if tid in sqdata.stamppresent:
-            sqdata.stamppresent.remove(tid)
-        if tid in sqdata.valid:
-            sqdata.valid.remove(tid)
-        if tid in sqdata.outrightfail:
-            sqdata.outrightfail.remove(tid)
+        sqdata.stamppresent.discard(tid)
+        sqdata.valid.discard(tid)
+        sqdata.outrightfail.discard(tid)
=20
         noexec, stamppresent =3D check_setscene_stamps(tid, rqdata, rq, st=
ampcache, noexecstamp=3DTrue)
=20
--=20
2.43.0


