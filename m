Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C05DC61DC7
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:17:52 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com (BYAPR05CU005.outbound.protection.outlook.com [52.101.85.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3645.1787861867555201412
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=iQrvr+Pg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.85.56, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on1PmEDLD6v97FGxjRP0gRNAvUNCuMXL7YRjhXsP53raUFImHIdgtHNkiDM5JUcHkoBqEkw2391J5njHZfCIcK8HJlTmEzECypBDvtWc1QLwEadUAhvEJDvJLElmSK9Hz/TWnUYsgP7aw1IW4uSv2LkC/K3m08zwEs8MlWCxUPuESVN9c5aB82p/W6BZ7t4zNdH6lqwWJASjArxKDUQ3b7Jv0d5DXjPkgQVsehuD+0Nwn3FS1Huon26WTb+BGFDV7duK92qF6nJC32xKt6AlqYF4Dui/O1erAz7V6qcYblpDEQUWtkwK/R9ctcz+M0su14OTEW0rkMJFsRed/HXVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNdi0p5XXq+tXPGu6E6Bb7q4VfQSppnYsDGFMzRBVmo=;
 b=a0SAnNuD9ue5ZfzXJA4NpM5itxE5+jwedWFwQ6M41dLQ1WDALrqHFARJecEaGzNgThsOZG0wGk8ug1ZwI56rGMkCSPDaNWW4yxsfB//LONkbfuM9nz28FXmDomYPHO0EJi57vOPvSSgDgF2gLT4qrnBxYcaDvOlvluVMK7ZmQxRjCrdRgY3VaOV3jBSoJ8ahSOjd9Jc0Q9d0H0Agfp6HZ4vHPRADe8mtYtL/XCpJ71QeHOzX+M3msyLO2YbUb2vcS3Bn2VobpsBnnwdOTt3WkNKsTr0WNUqQN7p9A2RhbBomasRiTq71gDUNTIJiBWoN5FSayEyAQYCuZz1E9cbGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNdi0p5XXq+tXPGu6E6Bb7q4VfQSppnYsDGFMzRBVmo=;
 b=iQrvr+PgABOLldg15L169UyiIBWqFzV+im4dSXlBcCx2gwTFbxJtJVh1uKna4njwPW77geaKR2G4f8Zl/r07PKaJyLQSTiW592L2tr6w8bN8NkEtbFAosL9dcT2q8X3kSJt6ZzSp7HpDLOpzfBI5Nky6E6u1xsa1kcy59tYjwXHE7HcC67CSlpGysL1DHJ54a7bHbS4Hl1j5qfmd0qlVHNa2P5h6lZQ2Qbwu8Ceq9Bwi2yVGnPeK02R405mse3WDEv9Bwx1koeBdvnoZ83C1Axpr80DHlX5AdxmHBVjxCkJN9b1dNYCUUpM+0eKlbeWas9/fHmz7qauEaMKii99hcA==
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 27 Aug
 2026 20:17:40 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::46) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:40 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:31 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 01/11] runqueue: remove unused attributes/variables
Date: Thu, 27 Aug 2026 16:17:11 -0400
Message-ID: <20260827201720.698482-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: de2b69c1-7117-4fab-3d53-08df04783ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|6133799003|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ngcroubfEMkfUPZ8nTJtjSXAkSMVhWtC0fJsRBAwQui/NQospWGLdPuVifYxhzOmKnjC6zYIebVpg1WaQZV5kwWsOpvBTR3QyNi7anLub7DFnj7xc8O8XG/RjzGzrxqDYeXsQdEqtqGHe29eflKGQ8ECw3b/FVtn5VwcnUef1SHszz0lWwVjY64wjkblfXBQipO4xT1LAq27p+A+nt0fjzEHBAGPXaJVFCyfS402RjQyGjk+5TkBnsmza0L2gAGL6zEU2dYufi4rgBqKHHxs0NrI0NG282z9UCyCwHhtGOuEVAnalMB4p9EMBgmxbXYWCQ6x9Ahf6iDhXCZv8WV+DEmEs3OlfZfsNSwxG6ICViYhOKpjURshrLM41E2tT6riHOBUyD11zEegLPBTpmgd2bcyHJPQV+3w9ZypZj1V3dQfEBJALLb45xQbjZS5lyhZehesK5UPVkfg7opWbm2Q/KGaDkY2JyPM65loiSAYWUTSYut1vfeTt6+o2DiBOvylfXEGAdjZmvZreN3nirjUNj+zsIXRWoOigxHvpf2UbJHFnJ0VX9D/tHCMQ83rXzusl4/tq77YlVu0zdI0K9OZbkjS5Hz+LenKEHLQ+DUryNaeVcbRZQig93WlzvAZoQjJks8GYnwtD+3rVaLUBlsd0WxyokiHX0Ezcblzoj23SHELh+UokQBRSk68zH3KrhQVPyhl4zb/DtmNQnWdpWFGqA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	alvjufsJYAti4BM94fqqaefhGoGRWUg2jWCf7tWvBUhT65NcfWiGV35BZ02CCpzh3OYBbPdrxPXppICVIUb8A4RxBVfQj/YswFIAo4FOFbC3UYALtFEOBHUwqqmKE/5jjGG1eO4A8aenhMo+zBIx43w9cTG6CKDoUVDxJpw+/YtUhm14x+1oEbcM9cLwmwd07OL3KZk2X65IdrBY12eyp9ks8O0Yo1CwmqVeFieVwNPc7uY2HYFFtuBqCKSMFpaVKw8bIbIlS8hM/RjKnqyqlXPeoFO+MFe6zN3x0g/He+knOqynRkdmhK08lmvQ8LkEgVYDQt3POlmmrHL1JtNS9gdzlplsDN2KKuQLCELTAreQzGv41uyqe0Ba7szxYiSwlaFk6yAAtEaxRMSVfOVNdqimE6tLRPvSsUkNKavvWaWsKcfJLLRe9LNjT8N/3Dem
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:40.5442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de2b69c1-7117-4fab-3d53-08df04783ed9
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:17:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20089

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


