Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6304ECCD18E
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 03:11:51 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.51])
 by mx.groups.io with SMTP id smtpd.web11.4392.1760152303761562808
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 20:11:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=hJnw8i5X;
 spf=pass (domain: axis.com, ip: 52.101.66.51, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxnhfxmaWjDKKI4D6eWgOMcRnxqwnqbdGMDyFndPL7zxng5j8IgZY103LWAQNTZVLsOo2chN6YdaTAxWb8IsIwflNrGo4LYuCzKrUuAaYckZwlPjl3S64iWYGH3/FIt9KjqklQ3rbXek5atq4Qa2Y8dxfyobh4vtglvDJ1w0RaHOAzUZG32YcyxzB+7mlV3BNATGRhNntyGvAiBd80g88ypXRmUHsLPZn0nuopKIteNxu/dfV+3kQ8AFHNgBijHGy5wQIPRb7eaFwiA7qdZZuQ5ZUKx0YZNw/2MDTwmKYHcv83JGKmcEUHw9gbxErh/+YSxte4y9W/h5Nw7Typhzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isQajEdVQ8geNoIoO3Dw6YsoWpMDk4HWPlhKY+HLyNk=;
 b=QjE9MLAEH6JvD6CwI43Lv2BUriBD+L/pfNnVW4Dxj4yxY2nHMpaq6N17gupJ2D83OAL1Jdj8N4tVMPqgvXy9oRMTjy/zOebCvU63Er9Xk558RfgnCj+pyKXjDPaRelQ76JPVTz7Et1swTqGc8ixxLc5cutnLWFqk9y830XG9wEMffqfOTGXKa4zll846upDY/AAveg7NtmEO805f3q7JQyCmApf1lQvGH3F6J2A4a9Gffk3s4HDaVztGII+Tfl7X0HkyF7i+LVoqtUM9gRtMkYlWP9BeLlLlGVO3KEEQlN2luqxHZ47oQJ0QoaWgQbswxS6OfM4M5gqM9UfCjIeYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isQajEdVQ8geNoIoO3Dw6YsoWpMDk4HWPlhKY+HLyNk=;
 b=hJnw8i5Xy6P5SoYrSiUim5oBR7ztM+ZW7Gn0a9BCprxxLqPTKZf60Pbv37Gxib/4RAe1Fi/oL1AVUa1+nDjtUUoVOPaAAk+X/WcD8pk403KHdFqVtOZfRv3w2AgRIAoCfEtVPwJODW5Zv/McNEQmv1tZAFnv2h5phQYKo0zIP68=
Received: from DU7P189CA0005.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::8) by
 AS8PR02MB9960.eurprd02.prod.outlook.com (2603:10a6:20b:614::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 03:11:39 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::6f) by DU7P189CA0005.outlook.office365.com
 (2603:10a6:10:552::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Sat,
 11 Oct 2025 03:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9203.9 via Frontend Transport; Sat, 11 Oct 2025 03:11:39 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Sat, 11 Oct
 2025 05:11:38 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Sat, 11 Oct
 2025 05:11:38 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 11 Oct 2025 05:11:38 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 8703F1CBD
	for <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 05:11:38 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 5D0D8120690; Sat, 11 Oct 2025 05:11:37 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/3] knotty, teamcity, tinfoil: Only allow one process progress bar at once
Date: Sat, 11 Oct 2025 05:11:35 +0200
Message-ID: <20251011031135.2243358-3-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251011031135.2243358-1-pkj@axis.com>
References: <20251011031135.2243358-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|AS8PR02MB9960:EE_
X-MS-Office365-Filtering-Correlation-Id: afd0d963-1a7f-467f-581d-08de0873e511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5WP1PP+NDZsolHjF89DUJtu4Fpyfhk9MCVMmOB4ZHMscE847wg1OqF/9lYIo?=
 =?us-ascii?Q?eIH7ZOCzDLWSNHNO/YMBDNPBSJyLTLC4NnXEt3bp0P9lbgbcmvziumzme231?=
 =?us-ascii?Q?Iu8Yj2+O8KgrNWniKD2n0cBt4HJ78t5OTaQYhweIC0Z8ytW7XE/AXXqvpbRq?=
 =?us-ascii?Q?C/ArjPucC+QHP3UNV/5LucYhGx9AWyOIzb/6PmmhbvYuveTOzta/U0OLe8ny?=
 =?us-ascii?Q?5MZjEdJOgmTRYQOTy98qkqXhW6Nuu03WupCdSY1Pz2LTQITvC4zfRvlTMg4G?=
 =?us-ascii?Q?AxuOGXbtDR+bipmaiFLNqKupOXKuoNxgQNUq9Da7t6/jcSP7c7tfkvMNTP3H?=
 =?us-ascii?Q?mLKuPg8p4AuASEYl7N7XerKsd2UP2D9+aYneZ1h8pCgWVVVJJS/hbz3iFr72?=
 =?us-ascii?Q?tHb2T0Pf5HLvYNBcJStbAsEk7yVzuBgeCuTR/uy/n7CPhRKXVZc0lj3XFIgG?=
 =?us-ascii?Q?OWV6D14v86p4wmUIHJb9uKGA+Bj10kucs/tHd38ZgGnvFwT1f4GIUHv37rYe?=
 =?us-ascii?Q?KPTf1jP3Qc36I4/6B9xzPIUhbjfRozPixRKNDgwEJwdOr4DIgtb1H3pPtbzN?=
 =?us-ascii?Q?6pc7NHGK5pp3GC9tYFn16KGrAv5l1wJgjESEgZ1MTKgqhKpmRRtEjnrGzSg/?=
 =?us-ascii?Q?zboBXFmLQeWcenZnJSXcg/SMyQcVer41PDi4daRgoQ5Ov+gclS1RQucIoTE7?=
 =?us-ascii?Q?e3aaU/STKJQBbm9od0OIOcD0SeRaNURSrP4rGx5Jh0ZBMQ9ERSdTjy8U7vkY?=
 =?us-ascii?Q?ldLvTMPu7RrWgRa/5hr12Y/vod8aHWPsjbYf6ylPb+DTdfbgHkz9Yw/yeWEi?=
 =?us-ascii?Q?1mHqZY8UoJ/dpf1xXIrajQ6tuwwlAwNXaARJCrCc4wA0rNVCQrerDRLCK/4U?=
 =?us-ascii?Q?mIRvgmJHHNUm1hgXmJHjidhyUP9YsKCqvOC+1N4ts9cq6dEXJPgN6kjZjUhf?=
 =?us-ascii?Q?69ABjeF96fPk8KZKKH9wwaLxIk7pKChNWS5O8JdNFurfvPQj2tNS0Ppx+Hdi?=
 =?us-ascii?Q?Yu1zOiT0zHFJOlO5QP0QbNV+g776WUb8j/mRhA07nsqsEcjYqTgEqGKRHA2w?=
 =?us-ascii?Q?QMTXN2BQAzwScKglEJoRfA759yB6Hdk6PAVFbIgDA5mbuh66QG+OAw9s0z0u?=
 =?us-ascii?Q?tD2JnVI+McUtVobC86Qc0G9u/0cUC0yI90KbGYWUKQSk4hdD3aybB/KspXXf?=
 =?us-ascii?Q?Y/nW8o79EBuojSk9FuRel4nLhOSZtPHeXrx8NJxv82jKC00YUgaFWICpSLCW?=
 =?us-ascii?Q?H4UOOYSqrBfEUD/zPZR3u8v1fgKZhu3n2ek0+9cucSysWEQRoyVg+VIfo0Am?=
 =?us-ascii?Q?FUr6CLonfnxSn8L8m4lLTmi/UFDb6NKY9fYyS9ln4LD7fFwYYO7ReNckAjwp?=
 =?us-ascii?Q?JciBUeL+C02nFT9CUErTBBoZjm0i2A79GSJYX+eE1CEXNUOEbv3W+2CYqg3+?=
 =?us-ascii?Q?Wx8rCHpk8lV+7sAK3ugPDpoIV9IurwPxGyXHCsh3XYSdYJt3h6xNYHtwBiAj?=
 =?us-ascii?Q?ygu73nLtkvcEHEzUrQOYVUr9ps6UeBb919O8lcncWb//U2YgH9FgBOTni0MH?=
 =?us-ascii?Q?FoWdmEpuyOUwue/3Cak=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 03:11:39.0059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd0d963-1a7f-467f-581d-08de0873e511
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9960
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 03:11:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18171

In case a process progress bar (e.g., "Initialising tasks") is active
when a new one (e.g., "Checking sstate mirror object availability") is
started, then finish the first one before starting the second. Also
ignore ProcessProgress and ProcessFinished events that are not for the
currently active progress bar.

This also adds an id to BBProgress (initialized to the initial msg),
which is not affected by calls to setmessage().

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tinfoil.py     | 10 +++++-----
 bitbake/lib/bb/ui/knotty.py   | 12 +++++++-----
 bitbake/lib/bb/ui/teamcity.py | 14 +++++++++++---
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index e7fbcbca0a..0a8950e730 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -91,23 +91,23 @@ def wait_for(f):
                             if isinstance(event, bb.event.ProcessStarted):
                                 if self.quiet > 1:
                                     continue
+                                if parseprogress:
+                                    parseprogress,finish()
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

