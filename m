Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B3C87FDA
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 14:53:43 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.83])
 by mx.groups.io with SMTP id smtpd.web11.27435.1754492016294004637
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Aug 2025 07:53:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=Tq9HAvnN;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.100.83, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcAieypEnLjKZDFWJXTVur8BSpDax2Sut3BmD8VcIw0QdLL95UwFWmLCJIk1vQId3mhKZfB3X7PRwyIyIls6SnIXaq8AKFRxgQg9JHI1NQeG+t4s6cbZxZsv5NYlWEnu87/zNJwMF1h6wWNS7iesLcI3DQmPK+/D1Dw4LHMyl31QA+J/kidoLZB00Z0SK7f0zxaX5VURFY4N+yIUcCRGTb/78KU9egUT8WTGhtVS2gK4t1eTD9JhxwzjGxZ4xo2LqANQrNt5hzzgQnPA03QbqABDhGG/LkOg1vo8Olboi1YpcdO0wJZcrNHw0qVmdG6w5QADeDm63mloWWcxadCuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CGBAcOFHSeAeXoW4T26dlrUx9izLtDWqt9jdLS7ep8=;
 b=dekvVN9JrMbfqSAG10HzbXRx6SXzaE2mFpLjl+bVRot7/W0xLg4g43DdeUNXLU+RJN6E1DYpHjtrSa/DgK5avANkIOepGkb1u0DIj76uwbCoew5cUHKUc7Jl6uS5m7lPWRAV3kMM5jM75+ly8aNDIMeiBBf5dpe/fW91Rq/9ShEsjNPTVis+1IRtMFWfk0jGFuubxYvMdb2Qx0knyeZPA39XPWYN16PsHJO/y+gw6gN79SuRssnA8oWgHvE8CCluMYPv86e9oc9rJ7sdNcG5rFFRkTf4yH5wfQK2DVpKuoFwgeJl5SmJQ2McPGpQFBBSrCUkeSKYSHmE4M7/QXXdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CGBAcOFHSeAeXoW4T26dlrUx9izLtDWqt9jdLS7ep8=;
 b=Tq9HAvnNiIcfJLXrWQQetWJsmPw9Dlv48o/CjYRSndBuvFvZ/q7rGnwe0OHFTjVD6MOlx/ZZFJlbSdFz4nnAVXJDsizZ41Eew07wEmvLfT8nnKaEuM6N5fB9Ezfzn8ofGth1Iq4PyngCZgndI1wuZ324MbzhZwk4ISiCIoIzsFQHuSzkwi7kFtoK+C0iBLp3LASXOXxERXZsLrScirQNGGOZw50m8iGCqCg+dCZ0LwHjumzurfZ3aBBBzRyA+DqJ1Myu2BWFA+61okBBFBTZh4euAUcmj4eZEuMz6Wm4XfT1UJIc8Fg4527mmrHPMt3aMWe3F352J0UsKKMM8z8NSw==
Received: from SJ0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:a03:3a1::27)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 14:53:29 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::eb) by SJ0PR03CA0382.outlook.office365.com
 (2603:10b6:a03:3a1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Wed,
 6 Aug 2025 14:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 14:53:28 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Wed, 6 Aug 2025 08:53:18 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/3] event/runqueue: remove unused 'd' arg from check_for_interrupts
Date: Wed, 6 Aug 2025 10:53:07 -0400
Message-ID: <20250806145308.2052128-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145308.2052128-1-chris.laplante@agilent.com>
References: <20250806145308.2052128-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 888a017d-1294-446f-fdf1-08ddd4f90147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9Q9lgqt8I9fEvRQtBssOUswa9aiIQuEpiEQSL2s+Qzi1vLHE9FN2duDA+WfB?=
 =?us-ascii?Q?KvBE4Xvx0tiRx40+DEPP0/99jkq0wUfsolEwQA60UUu4vkigOweKtAinAmJl?=
 =?us-ascii?Q?ySFPsI6AMRtWFu1FH1Vxm2T6D6AmI9mb5Rf25jXx0zDhFhx60pVTtyRdJ/vd?=
 =?us-ascii?Q?YU5vpyOlO4GCkyBia6A3X5izn+qtOIy+XNV27vsCFcNyFdcDnhPwqZYN5iSI?=
 =?us-ascii?Q?Iqw631/AdqgQQSpcpyT4LKYyCONxld25imk51Vil5rDZtwTf0HkWU4qYLNPI?=
 =?us-ascii?Q?bHXWYy7Wfoky1eqCEsuWBsHXSZNtXt8Zm4ob4fN/2yPwheSsodnIui3cX21e?=
 =?us-ascii?Q?prpsN9o7wyd5W9+4rL9W9PSBmgDB3li2z0mn6QRt6Wj9yYdQEQrrG9pUUtoM?=
 =?us-ascii?Q?Uy5d/2KV+MjPqc76TtlwVYNBhmsNo8Y+QhcAb8OpGdmWXVEAWp0G3mK/cHWd?=
 =?us-ascii?Q?k63WH4OeVJo8lH/vLfH0C/GXl6xLGe1wJW24Z0cqv/FIesBqnUAdiJT49fVw?=
 =?us-ascii?Q?42HwKcE+OFENU0S4i/nfewhcU0ciUgs2m9r0YWDL49DDtmGJ+cOjnMjsGw08?=
 =?us-ascii?Q?uLIdPZZ54BI+QHCxa57iH5zCk60NiLkm7aNaXq+KUUNtXJjmZW8ZVbYkOHLJ?=
 =?us-ascii?Q?oaLrizF/47hDd4ZvqZP/iGbauPGIQ6AzhQQjJalytecXc/Oe7cB977k/q558?=
 =?us-ascii?Q?Z/e68cx8s3yruGWYwnZIQ0cqUwbjqE4hD70dzHNW0L491/DdrXEngdZgwZD2?=
 =?us-ascii?Q?L1deDxzN40/d9skID5c/IojFKMVIrY9eKs856Zpmn2e1/9RenemjKOGheMOG?=
 =?us-ascii?Q?YNO0+siub+wJaQkB9QAKugtdvbpoWCajlc5LgpBkjnxgSftwJh1EzkTK6tHM?=
 =?us-ascii?Q?6ynK7f7QJhWAdX7kYBHfmjZhgdxxKCzeDuR3QfrrpBil18mQRQXwydwfc7CT?=
 =?us-ascii?Q?FhSezq3g4uqyPgkLQ/oZEaIKWRoBuJWTkYI9Tlo1OBqfS/CSocBo8y1HCO2Y?=
 =?us-ascii?Q?TthodkcYBtJfcUd64uaIWnhc1jYm1MnQuJVSMdVM52LNaVL27BOuAn5IRVvc?=
 =?us-ascii?Q?QKQbvCFIt5fnqG8HN9tf1/UdCT6y0Aiu6TAv2Mk2haxu7/wjS8IBRpzlGw2w?=
 =?us-ascii?Q?XjRR4zShPUsxhk5IPzdghMD2E6pN78sQ+n7fUrnHeW3HZSxzZDACIZqHPITr?=
 =?us-ascii?Q?sCwcCawcPlLeTQo01SlGEpU9iUSf9zsQItMpIKzmdGJ99rLNgni+o/p5es3r?=
 =?us-ascii?Q?BF6MGHxIET00trRMT4b26zUEGdEyOhQ6kWEBAVdeH2/rhUHFl2sta0QiwSI3?=
 =?us-ascii?Q?48+Bq6htdjHs/m+0FXyOXuZbLW/6ug+bU/x0Ya86RE0frBaAfutTW7Oy0Eb2?=
 =?us-ascii?Q?n8vTHJ+/r0sSDSaNCLEN7OiE4bz3HOXADVem3UkzT6h7GwRS26S3lcLCbhlA?=
 =?us-ascii?Q?9ENMgAtT4fYlI1fQLEcdQcX0cdsg1ODITmRanYBNpfpbbL2j2HghBn8dBphQ?=
 =?us-ascii?Q?NqOIVr8Aw105rihqzU7z8YN+/dUeT9NosP6g?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:53:28.8815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888a017d-1294-446f-fdf1-08ddd4f90147
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Aug 2025 14:53:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17841

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/event.py    |  2 +-
 lib/bb/runqueue.py | 32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 2256fed76..ddf1006c2 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -90,7 +90,7 @@ def disable_heartbeat():
 # In long running code, this function should be called periodically
 # to check if we should exit due to an interuption (.e.g Ctrl+C from the U=
I)
 #
-def check_for_interrupts(d):
+def check_for_interrupts():
     global _should_exit
     if _should_exit.is_set():
         bb.warn("Exiting due to interrupt.")
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 80f3d3282..f37a0a706 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -678,7 +678,7 @@ class RunQueueData:
=20
         self.init_progress_reporter.start()
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Step A - Work out a list of tasks to run
         #
@@ -829,7 +829,7 @@ class RunQueueData:
         #self.dump_data()
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Resolve recursive 'recrdeptask' dependencies (Part B)
         #
@@ -926,7 +926,7 @@ class RunQueueData:
             self.runtaskentries[tid].depends.difference_update(recursiveta=
sksselfref)
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         #self.dump_data()
=20
@@ -1008,7 +1008,7 @@ class RunQueueData:
                 mark_active(tid, 1)
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Step C - Prune all inactive tasks
         #
@@ -1055,7 +1055,7 @@ class RunQueueData:
                 bb.msg.fatal("RunQueue", "Could not find any tasks with th=
e tasknames %s to run within the recipes of the taskgraphs of the targets %=
s" % (str(self.cooker.configuration.runall), str(self.targets)))
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Handle runonly
         if self.cooker.configuration.runonly:
@@ -1096,7 +1096,7 @@ class RunQueueData:
         logger.verbose("Assign Weightings")
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Generate a list of reverse dependencies to ease future calculati=
ons
         for tid in self.runtaskentries:
@@ -1104,7 +1104,7 @@ class RunQueueData:
                 self.runtaskentries[dep].revdeps.add(tid)
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Identify tasks at the end of dependency chains
         # Error on circular dependency loops (length two)
@@ -1121,14 +1121,14 @@ class RunQueueData:
         logger.verbose("Compute totals (have %s endpoint(s))", len(endpoin=
ts))
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Calculate task weights
         # Check of higher length circular dependencies
         self.runq_weight =3D self.calculate_task_weights(endpoints)
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Sanity Check - Check for multiple tasks building the same provid=
er
         for mc in self.dataCaches:
@@ -1229,7 +1229,7 @@ class RunQueueData:
=20
         self.init_progress_reporter.next_stage()
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Iterate over the task list looking for tasks with a 'setscene' f=
unction
         self.runq_setscene_tids =3D set()
@@ -1242,7 +1242,7 @@ class RunQueueData:
                 self.runq_setscene_tids.add(tid)
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Invalidate task if force mode active
         if self.cooker.configuration.force:
@@ -1259,7 +1259,7 @@ class RunQueueData:
                     invalidate_task(fn + ":" + st, True)
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         # Create and print to the logs a virtual/xxxx -> PN (fn) table
         for mc in taskData:
@@ -1272,7 +1272,7 @@ class RunQueueData:
                 bb.parse.siggen.tasks_resolved(virtmap, virtpnmap, self.da=
taCaches[mc])
=20
         self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
=20
@@ -1296,7 +1296,7 @@ class RunQueueData:
                 todeal.remove(tid)
                 self.runtaskentries[tid].unihash =3D unihashes[tid]
=20
-            bb.event.check_for_interrupts(self.cooker.data)
+            bb.event.check_for_interrupts()
=20
             if time.time() > (lasttime + 30):
                 lasttime =3D time.time()
@@ -1555,7 +1555,7 @@ class RunQueue:
         """
=20
         retval =3D True
-        bb.event.check_for_interrupts(self.cooker.data)
+        bb.event.check_for_interrupts()
=20
         if self.state is runQueuePrepare:
             # NOTE: if you add, remove or significantly refactor the stage=
s of this
@@ -2638,7 +2638,7 @@ class RunQueueExecute:
                 next |=3D self.rqdata.runtaskentries[tid].revdeps
                 total.remove(tid)
                 next.intersection_update(total)
-                bb.event.check_for_interrupts(self.cooker.data)
+                bb.event.check_for_interrupts()
=20
                 if time.time() > (lasttime + 30):
                     lasttime =3D time.time()
--=20
2.43.0


