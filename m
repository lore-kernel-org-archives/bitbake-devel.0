Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1660BC87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 14:53:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.74])
 by mx.groups.io with SMTP id smtpd.web11.27436.1754492016483151109
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Aug 2025 07:53:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=ysfn7bfV;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.101.74, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oe8kfioGZJfoaqw4geK1cXApprHLU8LMneuLeIVXA6yuiqbCzCEiaG8MPfhxBVYJ3Ekg4/zp/ArcXVIlfcUaNOr7OTdLUcBySccAAQEbdY9JeehTPCbOtY6vVoUkVYKkDyHxpZCtD/4ULv4sr74RBTDDH2wcdAxrfHlatMIsJte3QByLeOyb8UZkZFknrKC9UnxzKfVGQShZi4h2sNOLz3jBrNFsR0gP9pym64SN8qWXlfZUMLNacIczG/zdoqPg8yqNiFOXxO75K1G3CYNA4GiXCOGxt9HtHNh2zQ4Q/7S0ltJVQA/3rmakygujSujamw+ZrQDncICuF05OW4beBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gevecUNzUCCI7z9w6lo4Nb1kxmhnc8fAfQRm66MGkZE=;
 b=H9083Q08oWS0q8zRHvs852pjfyfB6+2UTt4ZWx3AmaKzUNn0+YCC76TZB5rQ8RNWIz8hQLs0T20BPlF/iXIL7APJX+Tu24xJMi+ZwjORVyUQsBpVScnuoIJF9cBeuq86hztV3A62P6a7SLJnEafI+eyoCLPvTCGqLsfIt9Q3OFYKp/iYp9abFVQRfUHe275Rnvd+CE1Tqj2PHtGDdPBcdo2zCvH80q1cT6QS1UTyAarft5c0Et3pFUKI7T+Y/G+nrB8aBZ4cXMjxyKwXi6ZMtUZ/6SP5GI5gyzFDJ+PReUOwIhtluhxBHDEIp8GpJkPrMNUsnwZQ1P+5lIDMqPOSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gevecUNzUCCI7z9w6lo4Nb1kxmhnc8fAfQRm66MGkZE=;
 b=ysfn7bfVl0sVZzp1lNFK5zZ9+YDGa20RE7JRBQQQFzNXhbKckbGAv7qfjtggCdiZvIA2haOn5xIwzS5baAoDGxQLpldCCKHC4m2tSjcloRIZkU4BKodXQAGe/CypFHgGxqvNeS8V2NTym6bgZlCMFbVfUO15omQvB9oEnxOAFlO/ZwcuIUjmxfF0aCJcdPLS7LQfEI1kAkGEpEb3GsP0ZpclNlebeMZzkxjLz/4BN6Wjno9MHMK3H1yLaWte8uVbZrEu9RVLBMlHLqfrnJ1toev1EF4LDIz3MHjHTgrbsUl8AQTw08yxWEbKGxs6D0hvN5O/bS57LTf+wgeaZP+GyA==
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 14:53:30 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::e) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 14:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 14:53:29 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Wed, 6 Aug 2025 08:53:19 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 3/3] runqueue: use enum to represent runQueue state to improve readability
Date: Wed, 6 Aug 2025 10:53:08 -0400
Message-ID: <20250806145308.2052128-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145308.2052128-1-chris.laplante@agilent.com>
References: <20250806145308.2052128-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e29c46b-8cdc-4b41-02a6-08ddd4f901e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YIP8MhkatG5Gy9WTBp2d9hkWi1peasVEQuV1qTm0dTnsUX3zIMQOiJ/BiTtt?=
 =?us-ascii?Q?pZ6E32lUqyB/bdo+XVP0olM2TbMF2A/adURAuXZzkpGO/ySBukfB0M26jOiW?=
 =?us-ascii?Q?oAeq3rZu4kLCWnADoPkYAZqQBpFdklDVxRMAdBN9LDODgP6oAG7Mfhdn9iYM?=
 =?us-ascii?Q?CSL+AKraqtbMx7UVsRB/LLrWbGTySAM4/Bzf7f07eSqmz/yPm0sk8VccRoj2?=
 =?us-ascii?Q?q0c3SxE9jKwJvrD4pcgHe2tMgSKaCxoLI0CjLpmR1p02tGGbWa5yMr1ieA97?=
 =?us-ascii?Q?UXmG/jkZP+gjP9tmZJnYVlmt044nXzTV7VXhazqahPAJVyBxAghF5XaX+m0M?=
 =?us-ascii?Q?alTSer+nLlC8VyvKK0Gu/yCNOHwPU8RiP2FJEWZ5PBpQ5EVoYRAuMf2IxAyw?=
 =?us-ascii?Q?RJq/d+7DvPzzRUhl/Vfs91zP6lebcQY26Mws3YNfLplsOe9lJZJyhqlJgOBu?=
 =?us-ascii?Q?bFp3BATdcTVJMA+TpkbxTwvQQg0OQg9DDFLanwVLtLFBbE5ivu21YFjP0We/?=
 =?us-ascii?Q?0rK1i74SQls1Gwe4lAHq6iJTnqFOlKmh/HtmDispq7x4jnEO8br5hbVzWApA?=
 =?us-ascii?Q?Z3iwHwazbusn+eRG78qAShA0i076SwNhESnRgL/EyirxgCbPpa2jEOrG5mWF?=
 =?us-ascii?Q?n6464kd5HMSfUTVuZvXRhqVpC0xQ4vrDIJQdW/PcJ4N4MbgaeJmiMMgAVZWN?=
 =?us-ascii?Q?KoFQuLQiYVBZZaQ18lDzBYl7sk93wSkbi/xdVo+hF7zH8gfxJpgbyw7l/xiX?=
 =?us-ascii?Q?2/ACOWt4IIRQ8joy5mXyIkYK88+TIntepuNxdQ+Jv3mlg5iT5LPRDvk8CbsQ?=
 =?us-ascii?Q?sZ/J1uOSNI6s/YCiUi8SBACBZ5k6QyfFb8jIE0/7mK2YEj8O/3LIbDoCcR1a?=
 =?us-ascii?Q?OH0g2mZ1AqhjX9ytebXgB2W6Ehx7j9tIzWe5KBFjWDBYo6AUCHjRVmijmmDK?=
 =?us-ascii?Q?SQ0v8fOsPG7JyESEiECLAvlXrSFhbYX34BPcdSAZmxJYHCgdnG6bRy9uvEEY?=
 =?us-ascii?Q?Gwx29NARGxz1RUEmZQvpiuCtBt5GdNosoAB7Hq6u8qXG9ifHI27R/rgKX0sG?=
 =?us-ascii?Q?+URWPFYv1HFRTBeH7DbG5x0WW9a/79n4clg5kiHZ0JBq9qTaGvVx3bM4nsmw?=
 =?us-ascii?Q?tIyHEBQkFuxn+yOmt+nDPfcxaiAe2LKh2PCItfJK+1UmJWM/UgndTM/U7CrC?=
 =?us-ascii?Q?BHoWPplwquPEu2FtPGLKP0Zyt4EMoueKjd9UHLE7w8M2OfdXK77wrZll3be4?=
 =?us-ascii?Q?gEbxFfSNU4ObhgosSlBCxv8BbRA52YC/ZsbBMVUsg7TrWUYlefNStgp4+L9e?=
 =?us-ascii?Q?W11eULgUlxE9w8nPsD/ye8O8XrPezb7ZdP7CWA1UZ7ugNm5Fqk9Zev2apeBL?=
 =?us-ascii?Q?7XY9Jw+DexUwdECe4L6a/o5uZxFB1tbu0BDv/xjpS48BkKyZ0YKZ41umNT6f?=
 =?us-ascii?Q?iA4FwetUUCCsxwlc9Jsz2QkxVHAMEVJBtHDjmbRRV27GBxIMYwdKYNGdtEAs?=
 =?us-ascii?Q?JUyd1ur+/aiwRgbSL3VARBcLvii8mIHDFkWO?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 14:53:29.8971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e29c46b-8cdc-4b41-02a6-08ddd4f901e3
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Aug 2025 14:53:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17842

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 90 +++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 44 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f37a0a706..63d4edd89 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -10,6 +10,7 @@ Handles preparation and execution of a queue of tasks
 #
=20
 import copy
+import enum
 import os
 import sys
 import stat
@@ -125,15 +126,16 @@ class RunQueueStats:
     def updateActiveSetscene(self, active):
         self.setscene_active =3D active
=20
-# These values indicate the next step due to be run in the
-# runQueue state machine
-runQueuePrepare =3D 2
-runQueueSceneInit =3D 3
-runQueueDumpSigs =3D 4
-runQueueRunning =3D 6
-runQueueFailed =3D 7
-runQueueCleanUp =3D 8
-runQueueComplete =3D 9
+
+# Indicates the next step due to run in the runQueue state machine
+class RunQueueState(enum.Enum):
+    PREPARE =3D 0
+    SCENE_INIT =3D 1
+    DUMP_SIGS =3D 2
+    RUNNING =3D 3
+    FAILED =3D 4
+    CLEAN_UP =3D 5
+    COMPLETE =3D 6
=20
 class RunQueueScheduler(object):
     """
@@ -1337,13 +1339,13 @@ class RunQueue:
         self.hashvalidate =3D cfgData.getVar("BB_HASHCHECK_FUNCTION") or N=
one
         self.depvalidate =3D cfgData.getVar("BB_SETSCENE_DEPVALID") or Non=
e
=20
-        self.state =3D runQueuePrepare
+        self.state =3D RunQueueState.PREPARE
=20
         # For disk space monitor
         # Invoked at regular time intervals via the bitbake heartbeat even=
t
         # while the build is running. We generate a unique name for the ha=
ndler
         # here, just in case that there ever is more than one RunQueue ins=
tance,
-        # start the handler when reaching runQueueSceneInit, and stop it w=
hen
+        # start the handler when reaching RunQueueState.SCENE_INIT, and st=
op it when
         # done with the build.
         self.dm =3D monitordisk.diskMonitor(cfgData)
         self.dm_event_handler_name =3D '_bb_diskmonitor_' + str(id(self))
@@ -1557,7 +1559,7 @@ class RunQueue:
         retval =3D True
         bb.event.check_for_interrupts()
=20
-        if self.state is runQueuePrepare:
+        if self.state =3D=3D RunQueueState.PREPARE:
             # NOTE: if you add, remove or significantly refactor the stage=
s of this
             # process then you should recalculate the weightings here. Thi=
s is quite
             # easy to do - just change the next line temporarily to pass d=
ebug=3DTrue as
@@ -1568,12 +1570,12 @@ class RunQueue:
                                                             "Initialising =
tasks",
                                                             [43, 967, 4, 3=
, 1, 5, 3, 7, 13, 1, 2, 1, 1, 246, 35, 1, 38, 1, 35, 2, 338, 204, 142, 3, 3=
, 37, 244])
             if self.rqdata.prepare() =3D=3D 0:
-                self.state =3D runQueueComplete
+                self.state =3D RunQueueState.COMPLETE
             else:
-                self.state =3D runQueueSceneInit
+                self.state =3D RunQueueState.SCENE_INIT
                 bb.parse.siggen.save_unitaskhashes()
=20
-        if self.state is runQueueSceneInit:
+        if self.state =3D=3D RunQueueState.SCENE_INIT:
             self.rqdata.init_progress_reporter.next_stage()
=20
             # we are ready to run,  emit dependency info to any UI or clas=
s which
@@ -1584,7 +1586,7 @@ class RunQueue:
=20
             if not self.dm_event_handler_registered:
                  res =3D bb.event.register(self.dm_event_handler_name,
-                                         lambda x, y: self.dm.check(self) =
if self.state in [runQueueRunning, runQueueCleanUp] else False,
+                                         lambda x, y: self.dm.check(self) =
if self.state in [RunQueueState.RUNNING, RunQueueState.CLEAN_UP] else False=
,
                                          ('bb.event.HeartbeatEvent',), dat=
a=3Dself.cfgData)
                  self.dm_event_handler_registered =3D True
=20
@@ -1596,17 +1598,17 @@ class RunQueue:
                 self.rqdata.init_progress_reporter.finish()
                 if 'printdiff' in dumpsigs:
                     self.invalidtasks_dump =3D self.print_diffscenetasks()
-                self.state =3D runQueueDumpSigs
+                self.state =3D RunQueueState.DUMP_SIGS
=20
-        if self.state is runQueueDumpSigs:
+        if self.state =3D=3D RunQueueState.DUMP_SIGS:
             dumpsigs =3D self.cooker.configuration.dump_signatures
             retval =3D self.dump_signatures(dumpsigs)
             if retval is False:
                 if 'printdiff' in dumpsigs:
                     self.write_diffscenetasks(self.invalidtasks_dump)
-                self.state =3D runQueueComplete
+                self.state =3D RunQueueState.COMPLETE
=20
-        if self.state is runQueueSceneInit:
+        if self.state =3D=3D RunQueueState.SCENE_INIT:
             self.start_worker(self.rqexe)
             self.rqdata.init_progress_reporter.finish()
=20
@@ -1619,15 +1621,15 @@ class RunQueue:
                     self.rqexe.tasks_notcovered.add(tid)
                 self.rqexe.sqdone =3D True
             logger.info('Executing Tasks')
-            self.state =3D runQueueRunning
+            self.state =3D RunQueueState.RUNNING
=20
-        if self.state is runQueueRunning:
+        if self.state =3D=3D RunQueueState.RUNNING:
             retval =3D self.rqexe.execute()
=20
-        if self.state is runQueueCleanUp:
+        if self.state =3D=3D RunQueueState.CLEAN_UP:
             retval =3D self.rqexe.finish()
=20
-        build_done =3D self.state is runQueueComplete or self.state is run=
QueueFailed
+        build_done =3D self.state in [RunQueueState.COMPLETE, RunQueueStat=
e.FAILED]
=20
         if build_done and self.dm_event_handler_registered:
             bb.event.remove(self.dm_event_handler_name, None, data=3Dself.=
cfgData)
@@ -1643,10 +1645,10 @@ class RunQueue:
                     # Let's avoid the word "failed" if nothing actually di=
d
                     logger.info("Tasks Summary: Attempted %d tasks of whic=
h %d didn't need to be rerun and all succeeded.", self.rqexe.stats.complete=
d, self.rqexe.stats.skipped)
=20
-        if self.state is runQueueFailed:
+        if self.state =3D=3D RunQueueState.FAILED:
             raise bb.runqueue.TaskFailure(self.rqexe.failed_tids)
=20
-        if self.state is runQueueComplete:
+        if self.state =3D=3D RunQueueState.COMPLETE:
             # All done
             return False
=20
@@ -1666,7 +1668,7 @@ class RunQueue:
                 self.teardown_workers()
             except:
                 pass
-            self.state =3D runQueueComplete
+            self.state =3D RunQueueState.COMPLETE
             raise
         except Exception as err:
             logger.exception("An uncaught exception occurred in runqueue")
@@ -1674,12 +1676,12 @@ class RunQueue:
                 self.teardown_workers()
             except:
                 pass
-            self.state =3D runQueueComplete
+            self.state =3D RunQueueState.COMPLETE
             raise
=20
     def finish_runqueue(self, now =3D False):
         if not self.rqexe:
-            self.state =3D runQueueComplete
+            self.state =3D RunQueueState.COMPLETE
             return
=20
         if now:
@@ -2002,14 +2004,14 @@ class RunQueueExecute:
                 pass
=20
         if self.failed_tids:
-            self.rq.state =3D runQueueFailed
+            self.rq.state =3D RunQueueState.FAILED
             return
=20
-        self.rq.state =3D runQueueComplete
+        self.rq.state =3D RunQueueState.COMPLETE
         return
=20
     def finish(self):
-        self.rq.state =3D runQueueCleanUp
+        self.rq.state =3D RunQueueState.CLEAN_UP
=20
         active =3D self.stats.active + len(self.sq_live)
         if active > 0:
@@ -2018,10 +2020,10 @@ class RunQueueExecute:
             return self.rq.active_fds()
=20
         if self.failed_tids:
-            self.rq.state =3D runQueueFailed
+            self.rq.state =3D RunQueueState.FAILED
             return True
=20
-        self.rq.state =3D runQueueComplete
+        self.rq.state =3D RunQueueState.COMPLETE
         return True
=20
     # Used by setscene only
@@ -2140,7 +2142,7 @@ class RunQueueExecute:
         bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.=
rq, fakeroot_log=3D("".join(fakeroot_log) or None)), self.cfgData)
=20
         if self.rqdata.taskData[''].halt:
-            self.rq.state =3D runQueueCleanUp
+            self.rq.state =3D RunQueueState.CLEAN_UP
=20
     def task_skip(self, task, reason):
         self.runq_running.add(task)
@@ -2334,17 +2336,17 @@ class RunQueueExecute:
=20
             err =3D self.summarise_scenequeue_errors()
             if err:
-                self.rq.state =3D runQueueFailed
+                self.rq.state =3D RunQueueState.FAILED
                 return True
=20
             if self.cooker.configuration.setsceneonly:
-                self.rq.state =3D runQueueComplete
+                self.rq.state =3D RunQueueState.COMPLETE
                 return True
             self.sqdone =3D True
=20
             if self.stats.total =3D=3D 0:
                 # nothing to do
-                self.rq.state =3D runQueueComplete
+                self.rq.state =3D RunQueueState.COMPLETE
                 return True
=20
         if self.cooker.configuration.setsceneonly:
@@ -2411,7 +2413,7 @@ class RunQueueExecute:
                         self.rq.start_fakeworker(self, mc)
                     except OSError as exc:
                         logger.critical("Failed to spawn fakeroot worker t=
o run %s: %s" % (task, str(exc)))
-                        self.rq.state =3D runQueueFailed
+                        self.rq.state =3D RunQueueState.FAILED
                         self.stats.taskFailed()
                         return True
                 RunQueue.send_pickled_data(self.rq.fakeworker[mc].process,=
 runtask, "runtask")
@@ -2439,7 +2441,7 @@ class RunQueueExecute:
             return True
=20
         if self.failed_tids:
-            self.rq.state =3D runQueueFailed
+            self.rq.state =3D RunQueueState.FAILED
             return True
=20
         # Sanity Checks
@@ -2456,9 +2458,9 @@ class RunQueueExecute:
                 err =3D True
=20
         if err:
-            self.rq.state =3D runQueueFailed
+            self.rq.state =3D RunQueueState.FAILED
         else:
-            self.rq.state =3D runQueueComplete
+            self.rq.state =3D RunQueueState.COMPLETE
=20
         return True
=20
@@ -2688,7 +2690,7 @@ class RunQueueExecute:
                 if dep in self.runq_complete and dep not in self.runq_task=
srun:
                     bb.error("Task %s marked as completed but now needing =
to rerun? Halting build." % dep)
                     self.failed_tids.append(tid)
-                    self.rq.state =3D runQueueCleanUp
+                    self.rq.state =3D RunQueueState.CLEAN_UP
                     return
=20
                 if dep not in self.runq_complete:
@@ -2823,7 +2825,7 @@ class RunQueueExecute:
             pn =3D self.rqdata.dataCaches[mc].pkg_fn[taskfn]
             if not check_setscene_enforce_ignore_tasks(pn, taskname, self.=
rqdata.setscene_ignore_tasks):
                 logger.error('Task %s.%s failed' % (pn, taskname + "_setsc=
ene"))
-                self.rq.state =3D runQueueCleanUp
+                self.rq.state =3D RunQueueState.CLEAN_UP
=20
     def sq_task_complete(self, task):
         bb.event.fire(sceneQueueTaskCompleted(task, self.stats, self.rq), =
self.cfgData)
--=20
2.43.0


