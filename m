Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F22C61DC4
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:18:02 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1.1787861874309629854
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:17:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=ZIRroLfE;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.93.196.32, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aR9TrGGqg/EHGWPU0EYwB9AuaAbe0qDkKLF6QBiAWhFeyfoEma+gpjAA8UF6LNbZOURulmjwX8yW1ho99HrHlJ5RA8MSOA4Ltc8yF86ZPjCieaAqqyeC2wA1IZqwPizsfTEr/lVg+MvNrWJ5d+b3tgai1JgwCKjMS+KJwIbGbDT/dIsfMFkfOxgQQ6GkEpQjhIqkW7891pDaF9od7lBse9BvvIyoTSpBV7Ek1Ttdxjgv+tAbz3uhJ05oed3GWYTvy+idhWPyA9Jm9P5ajTcH5x3VlHYal/MCu4A92zzPna85icEtR117Nnw6h1NKCc/NGhuyIBYla12RBLIIsBiq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uxSclEzWRj63LVbiAKe0kg5UFWa/yDLnAs4gMnXqdA=;
 b=vC1p/p1xorduiiMsqyPkHVxIJ7Ve6XWDWJ8RsX0Fy28uE545F9afVpel6xgwr4UBs93aD2m+ue2Q00+I7Ezguh2a6R0Xj0GX55ySjlbCJvycm90KnJVquJbGOMYy8svuz8hK2LLE5uz33H4OdLk1U4EqYAYJ+jLZh/8jiGuO+DW5VaoGrffvc2rxlg6uZYyDBjbumIP8wwPWgk+DEobnrCDWlW+sUfDNuG5DYgoLMjmkapezK/7xm1pFYOCGB3nKk+BVHaqvhYcIavaShdwy6A6jw2CKy6ZyzN93V0HufVQVeVYi2GPT2/mT+LRgKiJVRBo8WJjOz0ZUVxDebA8F9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uxSclEzWRj63LVbiAKe0kg5UFWa/yDLnAs4gMnXqdA=;
 b=ZIRroLfEsx1zRMutbGAKilSJEayGD3udnBxQ8zu5aS1R9l0qJMK44vMFgqmCVvdiy/4PdDRFq7TZ8yq4w+ld8v4X6awn4ACjr0yPHVjvz1r59/VMrYR3Bx2q4RxpchzoVu5OXKhwh2MROxd7zmjFGXCbNrJGr0JueRflYumFA+AzkkkPvrqPbNP924AdC81khpbeB31AfkSfXiw3h0YiH5MQ/T7d6dew49C7rjTqqwqCStKW2454mR595FekoQhBF5CGw1dpPZ6qQtEZye5uBnn7v9dq878HPyhb7eP2rbNxzf7uhu3ZoSPC7XaK2ZnRhfFE+CFSMz4GOqoR8Y25gA==
Received: from BN9PR03CA0292.namprd03.prod.outlook.com (2603:10b6:408:f5::27)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 20:17:45 +0000
Received: from BN3PEPF00022BD0.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::90) by BN9PR03CA0292.outlook.office365.com
 (2603:10b6:408:f5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BN3PEPF00022BD0.mail.protection.outlook.com (10.167.248.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 20:17:45 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:17:32 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 04/11] runqueue: cleanup imports
Date: Thu, 27 Aug 2026 16:17:14 -0400
Message-ID: <20260827201720.698482-6-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827201720.698482-2-chris.laplante@agilent.com>
References: <20260827201720.698482-2-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD0:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc6d748-cbc1-4c85-316a-08df047841cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	FvjbiRvG9Tk3usGv9iyS/IN8w07bJUr6oytPkRGpNdJc+pwCenB5w6Ev1tMbCATZ3f5Mi/MEpSDv6HjJ+EXEGCAu0d5rhYFr66/T/t3398SghPsEQfXAmVMICynTtxNQ0Aw/gZ7h/FRuQrKpC0DZ0jVbimgOI8fecHFHk6IqzU4gBj37EUTRRVP1lFWAIF7kOkfpWqCxjmykl10C6c6rWsk6mZ7eXpVjwZOONPXvjFx1j49eAkKEnzi0F/P7OPvWfyKE1UDL68Bj4tXznMjt8O0bDlqADi/GBXNclD1HA8JrEnYWx/aaXFPInuRMw9Tekedymfhvw5zEBrEdZ1hIqUJdlNw5qMPUsyCdhTyGu9KQJfOJMYTemOYwGC0zKD2e+o7EpSMY4OvOAn7oNUnwKNd5fBykie6yLAEkK5NzxoR2SWOc9D5Hgvl346NljDgakpITDRw0KBb0rhC4zDftKFx+7jMs5IiaWeHZGjUDxXi44RX0zAFsiUKpJZuhFnca3OginVFiBs6HhxUzJbFLDPb3Lq7CpMVHtNi9GTbLFZgvmkXIWGbO1+cDPkA5ACt2GAHK+Uy8eYE7GpltJZADoEl7CJBNPCymRav8jebil+xXBD+r8FE6Ho7UOShEqbwv1c+hVHbz8YxokVgzcu6UOGM0a9Tf6oebejYm10NbNU/rvXX0d2o8OCQPFWzeYaTk4NlRMs6q4nCpBTjwd44jFQ==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	J9FU2Ajft23f0j1hov2IxTvhBjLiGPNqmq+BOkadnFmg1OTuZoB+2s2TnloByxSGtu+/Qm+PoVplEpCavmYoZ7wW6Ru0a0aaEgsjsF+rWQz9dxEueeoN07jmAPQnQ2+fedLvzc3KCOoclr+mZC8vyUvk24obX8MrNYwsNCIaDoOT+O3GE6R3PpljLgj5Gg0c6IgMGqo5sUl6iUpmhcMaI6gm8EIAA0hMgs+BgUtHzcqmrZ/7WCnRBcXeCMGXfDcGCkfUeinPxRGJIq6gRD4mYPujolQkwRGXCfrW9xcdvLdexP0LqEZ3hoUAAV1QX3sU1SBeGva1tXhBe3zvM4BXfdGcQenCJuQJ6hZDUx3Oz6IX4cWDacfY01UhRzleiRmJWroVfkHQNpEAS/0rYHchC2fekkGgjEdsxcEE2yvNc3Rg2HRuRHlfqhrC4O/VfSrS
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:17:45.5217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc6d748-cbc1-4c85-316a-08df047841cf
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:18:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20091

From: Chris Laplante <chris.laplante@agilent.com>

Import BitBake submodules explicitly. Import multiprocessing from bb
because it is a proxy object rather than an importable submodule.

AI-Generated: GPT-5.6 Sol

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 4211c83ad..07f5d9fb1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -18,16 +18,23 @@ import errno
 import itertools
 import logging
 import re
-import bb
-from bb import msg, event
-from bb import monitordisk
 import subprocess
 import pickle
 import shlex
 import pprint
 import time
=20
-Process =3D bb.multiprocessing.Process
+import bb.build
+import bb.cache
+import bb.cooker
+import bb.event
+import bb.monitordisk
+import bb.parse
+import bb.progress
+import bb.utils
+from bb import multiprocessing
+
+Process =3D multiprocessing.Process
=20
 bblogger =3D logging.getLogger("BitBake")
 logger =3D logging.getLogger("BitBake.RunQueue")
@@ -498,8 +505,6 @@ class RunQueueData:
         Some tasks aren't buildable, likely due to circular dependency iss=
ues.
         Identify the circular dependencies and print them in a user readab=
le format.
         """
-        from copy import deepcopy
-
         valid_chains =3D []
         explored_deps =3D {}
         msgs =3D []
@@ -1335,7 +1340,7 @@ class RunQueue:
         # here, just in case that there ever is more than one RunQueue ins=
tance,
         # start the handler when reaching RunQueueState.SCENE_INIT, and st=
op it when
         # done with the build.
-        self.dm =3D monitordisk.diskMonitor(cfgData)
+        self.dm =3D bb.monitordisk.diskMonitor(cfgData)
         self.dm_event_handler_name =3D '_bb_diskmonitor_' + str(id(self))
         self.dm_event_handler_registered =3D False
         self.rqexe =3D None
@@ -1634,7 +1639,7 @@ class RunQueue:
                     logger.info("Tasks Summary: Attempted %d tasks of whic=
h %d didn't need to be rerun and all succeeded.", self.rqexe.stats.complete=
d, self.rqexe.stats.skipped)
=20
         if self.state =3D=3D RunQueueState.FAILED:
-            raise bb.runqueue.TaskFailure(self.rqexe.failed_tids)
+            raise TaskFailure(self.rqexe.failed_tids)
=20
         if self.state =3D=3D RunQueueState.COMPLETE:
             # All done
@@ -1647,7 +1652,7 @@ class RunQueue:
         # Catch unexpected exceptions and ensure we exit when an error occ=
urs, not loop.
         try:
             return self._execute_runqueue()
-        except bb.runqueue.TaskFailure:
+        except TaskFailure:
             raise
         except SystemExit:
             raise
@@ -1912,7 +1917,7 @@ class RunQueueExecute:
             self.max_loadfactor =3D float(self.max_loadfactor)
             if self.max_loadfactor <=3D 0:
                 bb.fatal("Invalid BB_LOADFACTOR_MAX %s, needs to be greate=
r than zero." % (self.max_loadfactor))
-           =20
+
         # List of setscene tasks which we've covered
         self.scenequeue_covered =3D set()
         # List of tasks which are covered (including setscene ones)
--=20
2.43.0


