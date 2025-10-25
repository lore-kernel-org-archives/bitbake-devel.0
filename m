Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAF2CCF9E0
	for <webhook@archiver.kernel.org>; Sat, 25 Oct 2025 03:26:04 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.40])
 by mx.groups.io with SMTP id smtpd.web11.814.1761362762478113873
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Oct 2025 20:26:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=WgOjT6p2;
 spf=pass (domain: axis.com, ip: 40.107.159.40, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jN/jSqsiGXcKTf6SFMd2dOftd9Kuec/i/aXvHgIDVyOSvDapqup/kuVJ51hUSmUauK4SdClNN4ExgeHVAfjG314ZoVRjJDCfU9f1FuNLkShYLgJ8ELDE/uUkH/aiYNfQ6faRVzDNN2YzaI886JMzMohJFrxY33C/p0WdoQ30FEwbZbh9GWvBwD2KPk+wGZbUmdLz3aWDuxH7ILoGJ+1ph5dc2ofBef73kwswymDUoTdIqoHUdMD9q2gwCuP95J1HG7H2xYT5qS3YLzxiCKJFfeB0JJ9OEDPsBuR+chltjMGkrDT6R18XQFGIjJzaf/80TVb9agvx27PIhJfR0S+bjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzymOA3YtMljUz7DyC7Ut0Mlo8sb6XZKzd+0WOsSx0I=;
 b=Nudyx9samCScNd9+yP1zw7P9TKVtKWdERtQubnrWvJ9TyLpwd8S3r6tGeQv/GV/Mhf8r6o3HA0asELN/nh9D3B6Ah6FvaiQZx1OC3wPSEzE3U5Cu/4bjtUvVJybE3PjEhgG7S50sW5Jo9jD6tvFt6QCehgNIuo0wVLFpNWeugU9e6JB9h4yW7ySMIxMBaKgKPhKOH2PIUzf9810yM3fht1gk5z+nYNg/a28itw3ODGWqc41roE3sZjXKvBNR1VCAIur70XhAs5hKTWUUjWqHnNheS2qlWtn+W2ngei0aPahZfzskDyv7xNbwRcgnOlJ7UbW0fZUarYi8gvCjajw1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzymOA3YtMljUz7DyC7Ut0Mlo8sb6XZKzd+0WOsSx0I=;
 b=WgOjT6p2Kjaa9RBVQkeE8+q0cCiFnkmY6J1n+Lw7C7S1ksFK2KGTaFgxrUISNx9fjWg/BrPI3Ffhyly1An2NML1jnMdyoUjIJMvUOHkTKoilv+hJHPFVsri6E3tlAqUtfL0sly9/WEUQv5N+mdk9j37Zryw92vQ2XgXGFx7PLY8=
Received: from DU6P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::23)
 by DBAPR02MB6294.eurprd02.prod.outlook.com (2603:10a6:10:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Sat, 25 Oct
 2025 03:25:57 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::8a) by DU6P191CA0019.outlook.office365.com
 (2603:10a6:10:540::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.15 via Frontend Transport; Sat,
 25 Oct 2025 03:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9253.7 via Frontend Transport; Sat, 25 Oct 2025 03:25:55 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Sat, 25 Oct
 2025 05:25:55 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Sat, 25 Oct
 2025 05:25:55 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Sat, 25 Oct 2025 05:25:55 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 307396318
	for <bitbake-devel@lists.openembedded.org>; Sat, 25 Oct 2025 05:25:55 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id E4F161200DD; Sat, 25 Oct 2025 05:25:53 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 2/2] knotty, teamcity, tinfoil: Only allow one process progress bar at once
Date: Sat, 25 Oct 2025 05:25:50 +0200
Message-ID: <20251025032550.2730352-2-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025032550.2730352-1-pkj@axis.com>
References: <20251025032550.2730352-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|DBAPR02MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a59a26f-ef72-409c-d5df-08de13763579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RacWUMqFT12CqJe3NCKdoQ5U6eDy2Kn6Nsn1H/4cjI1+n7nnTJok9jqDvxAr?=
 =?us-ascii?Q?/49xo/5rDRwRdGj10FSZIizS7EVwoP8r4kLw27DuuCI+2akDU8zeG0AZn2Z1?=
 =?us-ascii?Q?yjYfXQ8vJvlauWghO622wYCQcE3oSe9YX+R+BzYm2qufviuGbGEzTAUjfM0G?=
 =?us-ascii?Q?+1eYoYdH/eN2NWJ4C8b7lULsIXwzkMKLNnzvufJvdnO38C9uh+lvAy1y9rKC?=
 =?us-ascii?Q?0Vs5EVohe06oxR4/tOpxMyQ65s45P2adB8jpvh3SPopqG9Y3stOngxqQUqHT?=
 =?us-ascii?Q?GQlNwPsRy9nsno4Yqz/IUh5d5U26IaAPCmrzt49E3BOyCB9zsDWdXLALRENF?=
 =?us-ascii?Q?hnaKidXop6RzH9UPxat8m65Skdf6UJUVptbrXGvuxwrKCScOjZqabQkcN30W?=
 =?us-ascii?Q?pfezJvmzjWRVjQ41/NsaDiuicYEekXk34ipwZB3IYU8ZNMHPQb/p6/9IRYuF?=
 =?us-ascii?Q?y8Vswwh21FV84F2ipYPzsWBBrCUK7j9hYS8y8NsGPpS6apQlfItTgwaSPSAg?=
 =?us-ascii?Q?NcTjAWYZ8t4HVwv35uK11I/sC87ZZAcyDbREaxbDp9keswuua3q030k5Vf4i?=
 =?us-ascii?Q?MQZtR1CmmwNHJq7f2sjN/ZwF7C8JSXqNL6/XnpWb1AhdrzfBx6qEE1gqe8mj?=
 =?us-ascii?Q?QRZKkOcXaVwXfPicqeODEZpSmM0C5C9Ki/9euLBFJzQzbzJ5gagtv8VwTb/4?=
 =?us-ascii?Q?kyUEuwUh76hbrRl1Kj0/LsysRO8hP2S9p/sxi9hZ++LT9NiBeWd2yNgiKxlK?=
 =?us-ascii?Q?ErWaIwxoSz1v4UihGItsbYBIkKVL5KM8lqiKqelMTUgtb7kTa0cWsWsL2rwy?=
 =?us-ascii?Q?pRID8Pn3SOLHJcwbm95bLyjQNXmKFoQxzrODXySXBg6bc0S09r0M1KfTjWo1?=
 =?us-ascii?Q?nOJJeF6YR2li1ra9oTG3U2zFgQ8/WRrbsAKFHgpioHjsG6905gHwPJ1CaxAi?=
 =?us-ascii?Q?dq4x75K+4wBHZxAjhW/2wXnzul35p0KbVde//PBzKz7l1k9039otYPcA20PI?=
 =?us-ascii?Q?HU7Ipgg94CK6JRd0KBTQWpM9TyKL9ToOdbK7UZIaLeq/RpYOdRD3FaciUbIy?=
 =?us-ascii?Q?QOaObomIzzH2gB3vwxMXpAMTuFESa9SuPSMMZkytlNJTWVqP/lnb+4lapjrA?=
 =?us-ascii?Q?yK35Koq3JDmFqEhmmf2JwiG8YMjT+ZeK/KENQvRrQuR22NnFrzDDnj+L3wyR?=
 =?us-ascii?Q?s2NJY5G+nLGfWXn7fJSYY+zC50s0Hnb8CGKnkuQjKUVXpLhmxHcIFOGxM2Gk?=
 =?us-ascii?Q?UxNCwbKwkE9Xdu6QOFUSMs3hWzu0seDUTxcec9LjlZhc81w+DqQr7MK5QHl9?=
 =?us-ascii?Q?oFG25YAQVWiJXJcH/W63eJ62JhXGIy5YccaWJNfVt4h82T/1UQcYCGNFA2iA?=
 =?us-ascii?Q?Jzw2jD+83hfplmI1oU7zOQjHPrEpevdBFRAIav35PP4l9J7nLN+1vYJ3+ZWy?=
 =?us-ascii?Q?TY7VpaJDh1xPouDAAgxQXXV0pZix2HGBvE+rNsBfTmv5wbcT9ARAuq3J2BxQ?=
 =?us-ascii?Q?80VNfM3ls0VLLcRczE7TgneiCzo85M0CYkTu9DlKxnVwi7ZOPCtY3xs46kT/?=
 =?us-ascii?Q?zaTdl4XxDqCmR1e7+Io=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 03:25:55.6915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a59a26f-ef72-409c-d5df-08de13763579
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6294
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Oct 2025 03:26:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18214

In case a process progress bar (e.g., "Initialising tasks") is active
when a new one (e.g., "Checking sstate mirror object availability") is
started, then finish the first one before starting the second. Also
ignore ProcessProgress and ProcessFinished events that are not for the
currently active progress bar.

This also adds an id to BBProgress (initialized to the initial msg),
which is not affected by calls to setmessage().

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: Corrected a typo (parseprogress,finish -> parseprogress.finish)

 bitbake/lib/bb/tinfoil.py     | 10 +++++-----
 bitbake/lib/bb/ui/knotty.py   | 12 +++++++-----
 bitbake/lib/bb/ui/teamcity.py | 14 +++++++++++---
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index e7fbcbca0a..d9e985c612 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -91,23 +91,23 @@ def wait_for(f):
                             if isinstance(event, bb.event.ProcessStarted):
                                 if self.quiet > 1:
                                     continue
+                                if parseprogress:
+                                    parseprogress.finish()
                                 parseprogress =3D bb.ui.knotty.new_progres=
s(event.processname, event.total)
                                 parseprogress.start(False)
                                 continue
                             if isinstance(event, bb.event.ProcessProgress)=
:
                                 if self.quiet > 1:
                                     continue
-                                if parseprogress:
+                                if parseprogress and parseprogress.id =3D=
=3D event.processname:
                                     parseprogress.update(event.progress)
-                                else:
-                                    bb.warn("Got ProcessProgress event for=
 something that never started?")
                                 continue
                             if isinstance(event, bb.event.ProcessFinished)=
:
                                 if self.quiet > 1:
                                     continue
-                                if parseprogress:
+                                if parseprogress and parseprogress.id =3D=
=3D event.processname:
                                     parseprogress.finish()
-                                parseprogress =3D None
+                                    parseprogress =3D None
                                 continue
                             if isinstance(event, bb.command.CommandComplet=
ed):
                                 result =3D True
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 6f03bf2faa..4bcf6bd12f 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -39,6 +39,7 @@ interactive =3D sys.stdout.isatty()
=20
 class BBProgress(progressbar.ProgressBar):
     def __init__(self, msg, maxval, widgets=3DNone, extrapos=3D-1, resize_=
handler=3DNone):
+        self.id =3D msg
         self.msg =3D msg
         self.extrapos =3D extrapos
         if not widgets:
@@ -84,6 +85,7 @@ class NonInteractiveProgress(object):
     fobj =3D sys.stdout
=20
     def __init__(self, msg, maxval):
+        self.id =3D msg
         self.msg =3D msg
         self.maxval =3D maxval
         self.finished =3D False
@@ -886,23 +888,23 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
                 if params.options.quiet > 1:
                     continue
                 termfilter.clearFooter()
+                if parseprogress:
+                    parseprogress.finish()
                 parseprogress =3D new_progress(event.processname, event.to=
tal)
                 parseprogress.start(False)
                 continue
             if isinstance(event, bb.event.ProcessProgress):
                 if params.options.quiet > 1:
                     continue
-                if parseprogress:
+                if parseprogress and parseprogress.id =3D=3D event.process=
name:
                     parseprogress.update(event.progress)
-                else:
-                    bb.warn("Got ProcessProgress event for someting that n=
ever started?")
                 continue
             if isinstance(event, bb.event.ProcessFinished):
                 if params.options.quiet > 1:
                     continue
-                if parseprogress:
+                if parseprogress and parseprogress.id =3D=3D event.process=
name:
                     parseprogress.finish()
-                parseprogress =3D None
+                    parseprogress =3D None
                 continue
=20
             # ignore
diff --git a/bitbake/lib/bb/ui/teamcity.py b/bitbake/lib/bb/ui/teamcity.py
index 7eeaab8d63..3177f4aaf4 100644
--- a/bitbake/lib/bb/ui/teamcity.py
+++ b/bitbake/lib/bb/ui/teamcity.py
@@ -200,6 +200,7 @@ def main(server, eventHandler, params):
         logger.error("XMLRPC Fault getting commandline: {0}".format(x))
         return 1
=20
+    active_process =3D None
     active_process_total =3D None
     is_tasks_running =3D False
=20
@@ -300,16 +301,23 @@ def main(server, eventHandler, params):
=20
             if isinstance(event, bb.event.ProcessStarted):
                 if event.processname in ["Initialising tasks", "Checking s=
state mirror object availability"]:
+                    if active_process:
+                        ui.progress(active_process, 100)
+                        ui.block_end()
+                    active_process =3D event.processname
                     active_process_total =3D event.total
                     ui.block_start(event.processname)
             if isinstance(event, bb.event.ProcessFinished):
                 if event.processname in ["Initialising tasks", "Checking s=
state mirror object availability"]:
-                    ui.progress(event.processname, 100)
-                    ui.block_end()
+                    if active_process and active_process =3D=3D event.proc=
essname:
+                        ui.progress(event.processname, 100)
+                        ui.block_end()
+                        active_process =3D None
             if isinstance(event, bb.event.ProcessProgress):
                 if event.processname in ["Initialising tasks",
                                          "Checking sstate mirror object av=
ailability"] and active_process_total !=3D 0:
-                    ui.progress(event.processname, event.progress * 100 / =
active_process_total)
+                    if active_process and active_process =3D=3D event.proc=
essname:
+                        ui.progress(event.processname, event.progress * 10=
0 / active_process_total)
             if isinstance(event, bb.event.CacheLoadStarted):
                 ui.block_start("Loading cache")
             if isinstance(event, bb.event.CacheLoadProgress):

