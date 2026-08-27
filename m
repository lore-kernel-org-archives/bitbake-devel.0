Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D76C61DCD
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 20:07:36 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3286.1787861243996363827
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 13:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=UtCJj92K;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.201.29, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6Jj+HzZdnDat892C0nxv72Zx17teKFu+ohIFd+YRGzc2etbnngV7sjv7z/nfndTDPcccLAG4onUZIY5f1r1bJYMHQlDN9ULgQSK4MGXfsCJMy36131ZQ+N4jNRX2vT1BdLMiNt9R80XlUEx27Be2ZmRpiWFGWHpuUFgLdir1PCTZ0q1EiiaLVi6x01HOO19zUAtCrqXiY1UDEYHbbiC4aUZnZ6euBd1z5TyL6fnR1DkPuhQZeQ/CpQHShaXn5Q2YVr/R5DHxQXQRKUFCITKqN7ro2jjTbXQ2qfQVzKSk7/Bcudm8YUbtphmebjiAgFk6O9pH8SwxSagt+quXaOAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oLToVcnRl3iHMVKj5TeHwbmrEK3IxjOUdBes4bqMvU=;
 b=Ww7FHj86rdQUcz2b4hUjP9ybdw2lcUFxnMfNNNbt7w4g0KpocV0KNhQyUt5xCuB4w7AZd7VWfJF8o+PQNf6MXG6Mc5HQEoGUAQlgbXQFDbJ5SU6wccOJbuLSj4El9R8Mk70bwqlC+OerNLD4DSkyT2DGc5WAkMj4i1bfX+tUuOwtlFc7szzi+Bhip+c5XmoHinAnWmj+pCqXNObRrF4g5A7DIkxFx9uSFDaxQPl1pZ8Jglczej5cnY5Ht8SQaWzalDD7Mj+rCKheo1eWoytAZRr8/+BqpJj3awB2IRCyVqQKom9AHwf7KC5sTaPOtI8FvkQpOLLLNc+wMLvSxfmj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.39) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oLToVcnRl3iHMVKj5TeHwbmrEK3IxjOUdBes4bqMvU=;
 b=UtCJj92KuPWlKux6rmM4ptUlMD6owDDqheYCI/WvZWRCtXAVibC+rXf2NNFGnQw5m4vrzx5JGByGe9GvDVg8k7Di78L9VHcchDlNZoSfw/l2a0UO2+K/8KFrDLEEDfOb9AoqJsscUjZdcvuUAUomVEs+wg+oy8DPP8t59Nvb9dMWNLv3JrEuLIOlerxfMvRUOmsBDxbULkXKzsiXf2eNmp46wcJAu+8HU1WB1XjsUKKn1eJFLzt7vtAQ3vTZwp5cEgD78bhRJ0dizNXnQv/17Kr2bk5Uq9o4z7FrrOE69C71lhMHt63W/Iz8M/y9L4F3kzYkLaH/V/586BjJbmnmjA==
Received: from CH5PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:1ed::26)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Thu, 27 Aug
 2026 20:07:19 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::33) by CH5PR02CA0021.outlook.office365.com
 (2603:10b6:610:1ed::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 20:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.39)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.39; helo=wpcosapexchedg6.windmz.agilent.com; pr=C
Received: from wpcosapexchedg6.windmz.agilent.com (192.25.218.39) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 27 Aug 2026 20:07:19 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 27 Aug 2026 14:07:01 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 04/11] runqueue: cleanup imports
Date: Thu, 27 Aug 2026 16:05:56 -0400
Message-ID: <20260827200603.688796-5-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827200603.688796-1-chris.laplante@agilent.com>
References: <20260827200603.688796-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1177d4-a6e8-4e81-a706-08df0476cc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	lJAGrq8pYs5n2ia8hzdMSd5CEXnt3VfNsEG1QqxvebO5f72ujzcUm6aKlpAieIc00YB8MImDO+IRkRrsA4IiLOZNgJSIbppE+hbyvhHQUy+dkoBJ1w0DVilF2ZOiSUgY7DPeja+doGSTzgqqG0xd7XQs5CuZdy/LR2ylzUqYYCYM4hmEGL5MY87Aop2qgfA3pzBTFM2uwtckG8KmsRkeyEgHFLmXB9rnqneQ4NPUuKVnNlfxIoSbyGwTM9lLnSYxUQyes7JapPz1PR8XYNVE7r8zCmniIaUShkNL36Krv8bNI2X2nqPEYtyNyph/EBhod2PEt8i2RC7NLfS9H3GzFYEEJ9HVfhCyBiTY61VPSOFEad7pOBnGpGM2B8w5O3bh+DayPiM0nmcAcyjZ1IARHnTOlkCCIPUuReix8CkRQI6ip10lJ/nIE2AtNvrkmm1hl9f4i+rg7Jy5+zjh3pE1ehgY+pxYeEQM3jJJS9egQ4aVFVkt21JOw7+u1jvOGhQLj2PiXv6/7ejQLcmmEpzk/Vet6mIVzIGoA8FgLvUq4ce6PxJCiO+ajhn2zIh7iRvPyLSfUP8nQhfPHbOkeHYYww6WFQU/8+XI4sWUZZm802qY3KXvoBof1YFNoaZ0BLWzOiCBe08Zmn0ESwrP1UMs0QP48d75S3YlJQu9Unbrs6eEpHjTxQBtAvQD0LTLZg7Grt2lBEPqCK2Ogy+N/IobJA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.39;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg6.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	LDGaN9RAsVv8eyUIzxLWHf8sbWlGXkAWXRJz6CTdapiLlyJzS0TFc8qKKyogh8NdPKle9ip/R7Wuo5szWkJzEVEMLxVNwiJxnJ+mbPgzpKDGrtulzF3x7unyQc9MoQfPjo+nYDo6QgTU1kJJwKqY0nrxpd7vFaa3xRAZNOhMzvxNVoyIqY13BLVpngYcfarjFpMdQ+1qSAhkv5d2nJcf8yoO4i6zUysZsJtuAK2COfUxtADwSloP2vHAuFSWN0z203f+K9Hg8eF7EqMzvjFEOkd4df5VvlGzJnqKbbdBFaTem4tyfis9IYxixu1weO6H/v7eZiOGcrv2vLpXwe4TrZegCRFVZVW91pBwxvXZW3q+O9WNSBrt5eBfLIhdF3Ud8kue06Hil5cVUiQmnGEb1pdM0kdHEG17efuDnTKaMqehPQhz7a+adIZ9gGgIvjgi
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:07:19.2521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1177d4-a6e8-4e81-a706-08df0476cc86
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.39];Helo=[wpcosapexchedg6.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 20:07:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20078

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/runqueue.py | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 4211c83ad..c7b6a9d25 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -18,15 +18,22 @@ import errno
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
+import bb.build
+import bb.cache
+import bb.cooker
+import bb.event
+import bb.monitordisk
+import bb.multiprocessing
+import bb.parse
+import bb.progress
+import bb.utils
+
 Process =3D bb.multiprocessing.Process
=20
 bblogger =3D logging.getLogger("BitBake")
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
--=20
2.43.0


