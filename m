Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B91C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:35 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3439.1787861245425650943
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=xiKfdGPE;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.196.16, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOpvuMEcOcevPPFgQWWJIaxy6ZbFcHxIXIr580sKct38xOgo6BLi7Wg7My2ERQNKxk/Jxhf71P8N0YjX1ASA/W0TZeWNE1roWlBC5eLqAm8E7LeZZyp4DuMs1E+s0MJgEyOR0bvEFOZlit0ReWiZ4yNG4k3KvSBwvniSe5abCNDcjRsSBvgMHk2sSHMAvST3WVFBsE86nkiRFCyx/nIGJkuWMRbJ5j1hJp2vBeonCxcKSFIorAQtYMa3nYnGVH51xrUqkNBXDjL4OV5ESU15pWpV7Q/7GxKyHh/SuwYgYRSJwV7MUtTRnPaR3hfIsUmypXk6WevU1WJIaNKFocIxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNdi0p5XXq+tXPGu6E6Bb7q4VfQSppnYsDGFMzRBVmo=;
 b=SeUpXKuU2z3WHfOmviuswYjQzWEUQ+fb8ECEqmUyda48OMetrErkaoJy9FKkWjd1NAa8cpr435s0mYm/Y8ogo7rH7G/idnvOztalQgxYkWPvFlGLOcFUWo5OBAm2tJzCU3aGRzcdSLRQXrICPjKyf7MgPt7NImUt+MG8SIk8uHHeZlDdpaMC6+N3Dcj31TvYiN059E9bSKlNtBap8tFEEezU113mk0FXjjks8KBGOJRq943qNmk6dNTx+5loGVLbL8yNwWb+K/ZCSFaH9Yza/k5PiPmY9tu+z9Lgl4nkcYQuOWcj5NLv2w2F5cnaQgbVON3xVe5fD+YYyFbs9MjOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNdi0p5XXq+tXPGu6E6Bb7q4VfQSppnYsDGFMzRBVmo=;
 b=xiKfdGPEFNpVIYKITG10BnGtyfjN/OjWLicwDi9fIEGCp2ChpgbO0tHUipyhj4/uRXs9jejk+kSZl7PAKV60w33Oa1uWxXH+L1yJ38PDzt0n+mwOHQ6t5+uwOSmYD8kYJrvWSlOyKqNw6mgMS3j2+iILM7JxV95xeIPDI0IV+Zv00hl95t7Vs4SlhBbDFJucEQX22EVN+qTiCuoq5JAyprZ2n64xdNayVWiMJbg6wmI2QHy9HYG8NHonatIwYit2SKIjrgpN9BjWxbDFJfhaG7j33ONjgmI6Kl4qMdZMe5GczoQgpbEKJWorsC0J8E/evzhnI7wZhGV/2gJztbl6Bg==
Received: from CH5PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:1ed::18)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Thu, 27 Aug
 2026 20:07:13 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7a) by CH5PR02CA0014.outlook.office365.com
 (2603:10b6:610:1ed::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:12 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:00 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 01/11] runqueue: remove unused attributes/variables
Date: Thu, 27 Aug 2026 16:05:53 -0400
Message-ID: <20260827200603.688796-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ae3d3e-bb09-48c2-d58b-08df0476c8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	WUW3LNiQdp3yU2ngoJAdi1h4HCVGTI4tb0kv/4IW8zWcHhhT2s4RiC4nykz/kRUsyPsxUIXpRHyqh6BZJ03aKOqbLBsDOWGHLgdM210uI5LtkssJbr1cRxV+Red743J3XURyQJAKWrDljxGwoQFsw4ExYU0vEQS6Sr8QoLrdAV3pKVWlYzbqMOQIWbQA0EaLsL/XZyCkC2A/z5i/uDnxhGquRuQx5EnD5xR/uBP321y7AhAhrpeeA/v9fVDnyusJ6QtIzEB6ylZ7UsKXu6biVehnoauJ3IyGpOAH5ULbDrj9LQKoZTyf8oRiltEKLZIaBPoJ7hUKx9zDRVkTJoPneSGnpqvnDZbEck0q81g2mvHlnPShEQMnS/IQuFxTvawWQm02naZKefFMq1SdzRKJk0DNBx0z6huGUMR0ve3YI37EHU6nDfcf5L5bufkteJwc2x4ti8XN1795ymUpXc+eY0JMNP2MgmvV7GOWRtafj3/5lSqrWdtL+EXCdirq2PPdfWcAkXMQma8YqFUJ2+s+1ZZ+dOptBKWPh+Ku92cW2lXJo5Sg7GwIy1M3NevJ4NSehx5jYBOobkGYWNGiDIA11WG9Xr/KJalQ+JGh6vPgY++pLT24XLVpWS0tLh+by5cPCIEHnPfgjIsya2jjNzEXfA1EQueNmlcauvYqDo80rPU4NFf/XznetRvT158JDNE4Tb5hx22DLi90mVf0lXr68A==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	exGWhBeGM48M4djt5WL/oRdCVaFEiPO7PACZIhIc8HFb+9NfeeU/cXAeE1U19s+n76UfOgo+gHdbG4aptkqBeAHVjUIW+sAzN+2/xw6405HqI047Aab+CnqCPHUA9EX1fCW1poBx1AiJSpS70V2D1ZhH6Qw3VkeY//WgX9kMlBW+SoEN2Ru+3tfpo5e2kVm6BN1VVoh0xIiVF76XLX11e89fk58GuImqjzHAbudsL5wMoU7OU6oa9MTz5PdOB9IAdX3S1aE5s89SobxwGSwE4ksdJ6loGg5OOFIqHgqneQCn2JJuXqSaLn6VDXpviQimtc2o4QLte56YZHGnlGAmBM+et5QvCgyolDNwS2G7ow8+ANACLNDPB9RtCDbAkk61fk/fzvOav9o5etbMsHPQwWboFKpR0eMFGgBKIWaLE1mrjfpYzXENIU+qK1iOaNXO
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:12.8199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ae3d3e-bb09-48c2-d58b-08df0476c8af
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20076

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 245492de7..183475016 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -455,7 +455,6 @@ class RunTaskEntry(object):
         self.revdeps =3D set()
         self.hash =3D None
         self.unihash =3D None
-        self.task =3D None
         self.weight =3D 1
=20
 class RunQueueData:
@@ -472,7 +471,6 @@ class RunQueueData:
=20
         self.multi_provider_allowed =3D (cfgData.getVar("BB_MULTI_PROVIDER=
_ALLOWED") or "").split()
         self.setscene_ignore_tasks =3D get_setscene_enforce_ignore_tasks(c=
fgData, targets)
-        self.setscene_ignore_tasks_checked =3D False
         self.setscene_enforce =3D (cfgData.getVar('BB_SETSCENE_ENFORCE') =
=3D=3D "1")
         self.init_progress_reporter =3D bb.progress.DummyMultiStageProcess=
ProgressReporter()
=20
@@ -606,7 +604,6 @@ class RunQueueData:
         possible to execute due to circular dependencies.
         """
=20
-        numTasks =3D len(self.runtaskentries)
         weight =3D {}
         deps_left =3D {}
         task_done =3D {}
@@ -655,8 +652,6 @@ class RunQueueData:
                 message =3D message + msg
             bb.msg.fatal("RunQueue", message)
=20
-        return weight
-
     def prepare(self):
         """
         Turn a set of taskData into a RunQueue and compute data needed
@@ -1129,7 +1124,7 @@ class RunQueueData:
=20
         # Calculate task weights
         # Check of higher length circular dependencies
-        self.runq_weight =3D self.calculate_task_weights(endpoints)
+        self.calculate_task_weights(endpoints)
=20
         self.init_progress_reporter.next_stage()
         bb.event.check_for_interrupts()
@@ -1587,10 +1582,10 @@ class RunQueue:
             bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker=
.data)
=20
             if not self.dm_event_handler_registered:
-                 res =3D bb.event.register(self.dm_event_handler_name,
-                                         lambda x, y: self.dm.check(self) =
if self.state in [RunQueueState.RUNNING, RunQueueState.CLEAN_UP] else False=
,
-                                         ('bb.event.HeartbeatEvent',), dat=
a=3Dself.cfgData)
-                 self.dm_event_handler_registered =3D True
+                bb.event.register(self.dm_event_handler_name,
+                                  lambda x, y: self.dm.check(self) if self=
.state in [RunQueueState.RUNNING, RunQueueState.CLEAN_UP] else False,
+                                  ('bb.event.HeartbeatEvent',), data=3Dsel=
f.cfgData)
+                self.dm_event_handler_registered =3D True
=20
             self.rqdata.init_progress_reporter.next_stage()
             self.rqexe =3D RunQueueExecute(self)
--=20
2.43.0


