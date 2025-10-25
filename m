Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B643CCD1BF
	for <webhook@archiver.kernel.org>; Sat, 25 Oct 2025 03:26:04 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.32])
 by mx.groups.io with SMTP id smtpd.web10.800.1761362763202441577
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Oct 2025 20:26:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=itFSVXlf;
 spf=pass (domain: axis.com, ip: 52.101.84.32, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZXvIFb1VeXldChEuSTkvAuiGYu9qfLrIM9cZhX2eFFm59ornCM7FClnacQflh90hSoXRHgOaEerybVPg7wkFjpOcVIhMD6QTtCf0gLEuJPXRJ0ssPITWGxbl/lbL6k++r1FH25ds+VeYexK0wMPXNBM73BT0blUvml/gUyGKXStd02Kab0HrKh+r1UJI+9wb1XfQq6FEurHnwuQ7uBky6y7bKrw0hxBGlg/2v4LtiuhCwH5/fEgwgLQqP4gcIfwk4+MFdwMcZ4DZ862CDl8VB/d2PWGMvxfmHW1q5DGLeRDe8StWc1W+UiavHW/pOfK+IwaWYpUHLZoFLSKLOwWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9vyxYvlIa16Ma4vjpGmiMXrS5fOJCJHPY+ytvR9Ta0=;
 b=BkX1ENnwfFCDhIEJUiZ5/Qf5x2TkNbEHHUmX2z7dST0rerO31N2TD+eyQhPX3UpdFRbQvN2y2NnrEhX6VQfcMA9Lrs/Sj0aBc3OHyYjfv5W1rSSgwAOM79pTC1XVkABPp5/BkdN5tQmr+R/KljXKHDvoX5l76bysC3APZzMnzaySAaA9cXiwpjFc5O9WFrVWs6OHrFwT8P385QUlsELZBxfSEYsZCu3rPu/XMxTz/9jegva3v3EttBLELIeiHm8+Jjbns13CYJzerpLzj76XzcCHN3rfMeFLqGT98f4ZULhpoo4e4KxspC1YafTHhZtNkSKtSErn/qH/n/CexrzNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9vyxYvlIa16Ma4vjpGmiMXrS5fOJCJHPY+ytvR9Ta0=;
 b=itFSVXlfT8Nd9OIVg3UXHxhEYD4a1a+xicMNB3XqJuvUy2m3JAdz1QZrSYUSIUfTczuRbXxT07oYO0cG87KlqNI7MMgxfuQ92EtjA5booJF6iN6zMYZUoc1VB18maGKVT60nTws/K37TvuS5xbZvn1yhBm7k8UxdUr0g9dOXf0w=
Received: from DU6P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::9) by
 DBBPR02MB10556.eurprd02.prod.outlook.com (2603:10a6:10:53c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Sat, 25 Oct
 2025 03:25:58 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::71) by DU6P191CA0009.outlook.office365.com
 (2603:10a6:10:540::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.15 via Frontend Transport; Sat,
 25 Oct 2025 03:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9253.7 via Frontend Transport; Sat, 25 Oct 2025 03:25:57 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Sat, 25 Oct
 2025 05:25:55 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Sat, 25 Oct
 2025 05:25:55 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Sat, 25 Oct 2025 05:25:55 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2E84E62D6
	for <bitbake-devel@lists.openembedded.org>; Sat, 25 Oct 2025 05:25:55 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id E260B1207A3; Sat, 25 Oct 2025 05:25:53 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 1/2] knotty: Some improvements to TerminalFilter.updateFooter()
Date: Sat, 25 Oct 2025 05:25:49 +0200
Message-ID: <20251025032550.2730352-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|DBBPR02MB10556:EE_
X-MS-Office365-Filtering-Correlation-Id: f69341f2-361d-4358-e85f-08de13763661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DTD+zjEzkCek/2fCbTTY520CQHEyWmClzwbo5QetECl2dorr+Vyd8ID+Av+y?=
 =?us-ascii?Q?9dKTH2fSvSBgb/8cGe8NjUvICP1Rmsil/NSC1omsMpo4yB4IeTqf3ayJa1cx?=
 =?us-ascii?Q?Sy5L4/7ZB54vA/eGGy1PTdDXpdWYBaSF6igW0hPtbZqY/6X4rf9vm016rt38?=
 =?us-ascii?Q?HjujXg5pdDxHC3O0gPm6CSBTZsvTBYkFCcboBaWO7Kz+YKpq/vLBvhDGuxvU?=
 =?us-ascii?Q?QYQbclGdAfTKcQj1IzWyDNYxK/qTApk5YEBc0qVkC/pIWF9oEQIBXUlQQMgs?=
 =?us-ascii?Q?u97qXM02X6UrnF51FdsN4lshUyGuOkIx5JZR7YrrPMqyMYDsc/bzqMMTB+0O?=
 =?us-ascii?Q?+atJPJ7S+7wtImAYtVYdzedVvuE9H/AgtUHeVZlBM76zcJt6aQV2Fz5MUhUu?=
 =?us-ascii?Q?myMX6yVc4T2xy0F1D71SRbTBpzRpzQthYFSNBabvi9fBj3Yv0YXttp6qJXwD?=
 =?us-ascii?Q?8I9n1DL2SEEkXKT+Ss4LBhf3yyzwrlhxHGjYCijezZXirHbx11vq5wEcKOgP?=
 =?us-ascii?Q?RCg215XvXO74LlsjUATQcOV89F3KQ+TS3GH4HGTgM7oTCOPIirp8UTcdhjAf?=
 =?us-ascii?Q?PMEYihVHAuQHDNGkE2P0agunn4US1OVo2sb7vdTWP6ya6NqGCuszWJLIlUrC?=
 =?us-ascii?Q?2HcsoKyXB4IPN316JcyzR5nuWjBZqE/QDdssJid1AOPDiIILC9H5Y10R84ag?=
 =?us-ascii?Q?T9JLeFKP8Ny2Nmr7q/nNNgv1jZJITfW9OiSErs2a+Z3OZzyNRxjnK+lBHCq3?=
 =?us-ascii?Q?0ary2I6QYLpS9GN+kb5/i5ecAxi/K2qnNOml9eHs8KDxfriDmgzLtcvDNnZZ?=
 =?us-ascii?Q?TvSK0AnIJhSdk42R74JOMwIRV38nYF7FGmUdxMoorDfJ/2dWG6IQ2wiXk4yo?=
 =?us-ascii?Q?u6TX54XjYoybJgTiFfjc3wKGPudiMvjU2ZHiS4gV82J2iiKUO5DKIqZB6ytY?=
 =?us-ascii?Q?96/nuGOI6QUPbYr1kIkDsver6U5hvPXUhAQJZskxaorGoiMLc/cC99oOCan9?=
 =?us-ascii?Q?RZlb0TCuEyinUn5NMXk7WFmMWNj3lyCvDkfeuUvjYCAE8ensu+FIx4tfCClw?=
 =?us-ascii?Q?tsl1dH3RqY7PItEKlOi+k1ItmXKiUbIfg3CXKJu0dUdNNLQA7SAc3jp0k4dg?=
 =?us-ascii?Q?Ait7k/uWVFozv/Fdl1lvmdn0ssbeAwO/qkbApW9U2kFRVyTRPpj9Fu2SMOj4?=
 =?us-ascii?Q?jdfm+qwTuVPkLzQgYZVSQLWPdNreWgj23lvxVSK1B6qae4FS+N8c/Z3g4SU9?=
 =?us-ascii?Q?1e6u2u+ZTq+pGFZxR1KISl9IKthNNKZGHoiyV1ohFk9nVw3X53Hkl3Uov8Fu?=
 =?us-ascii?Q?b9m0XtRQZKYwbRn9pV7gLYBGmOlDu/83egs22nBFkQIYHKK29F77Fh9LeGAa?=
 =?us-ascii?Q?Jxkxj0vuIiKP63irRECvqL5WN0L/5n/3swRFA0kwAXnquIw1BygteGrriVyF?=
 =?us-ascii?Q?cbs8/qUs/vp6dOt+ljGAXS5o2UxJMt1XZQr07nwB6TC3hvX8VIoBkaxbnrA6?=
 =?us-ascii?Q?ZPtbVgEQiDQ3NiJN1fBTPdcvFFSV9vvr2NoSfdqQfwx6U43QiXBchRR1yOUV?=
 =?us-ascii?Q?ihJ7YL/WpdeWnGzCrkU=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 03:25:57.2132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f69341f2-361d-4358-e85f-08de13763661
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10556
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Oct 2025 03:26:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18215

* Correct/improve a couple of comments.
* Iterate over the values (tasks) of activetasks rather than the keys
  (TIDs) as the TIDs were only used to lookup the tasks.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No changes.

 bitbake/lib/bb/ui/knotty.py | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 00258c80ff..6f03bf2faa 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -260,16 +260,16 @@ class TerminalFilter(object):
             self.helper.needUpdate =3D True
             need_update =3D self.helper.needUpdate
         else:
-            # Do not let to update faster then _DEFAULT_PRINT_INTERVAL
+            # Do not update faster than _DEFAULT_PRINT_INTERVAL
             # to avoid heavy print() flooding.
             need_update =3D self.helper.needUpdate and (deltatime > self._=
DEFAULT_PRINT_INTERVAL)
=20
-        if self.footer_present and (not need_update):
-            # Footer update is not need.
+        if self.footer_present and not need_update:
+            # Footer update is not needed.
             return
-        else:
-            # Footer update is need and store its "lasttime" value.
-            self.lasttime =3D currenttime
+=20
+        # Remember the time when the footer was last updated.
+        self.lasttime =3D currenttime
=20
         self.helper.needUpdate =3D False
         if (not self.helper.tasknumber_total or self.helper.tasknumber_cur=
rent =3D=3D self.helper.tasknumber_total) and not len(activetasks):
@@ -281,16 +281,16 @@ class TerminalFilter(object):
         self._footer_buf.seek(0)
=20
         tasks =3D []
-        for t in activetasks.keys():
-            start_time =3D activetasks[t].get("starttime", None)
+        for task in activetasks.values():
+            start_time =3D task.get("starttime", None)
             if start_time:
-                msg =3D "%s - %s (pid %s)" % (activetasks[t]["title"], sel=
f.elapsed(currenttime - start_time), activetasks[t]["pid"])
+                msg =3D "%s - %s (pid %s)" % (task["title"], self.elapsed(=
currenttime - start_time), task["pid"])
             else:
-                msg =3D "%s (pid %s)" % (activetasks[t]["title"], activeta=
sks[t]["pid"])
-            progress =3D activetasks[t].get("progress", None)
+                msg =3D "%s (pid %s)" % (task["title"], task["pid"])
+            progress =3D task.get("progress", None)
             if progress is not None:
-                pbar =3D activetasks[t].get("progressbar", None)
-                rate =3D activetasks[t].get("rate", None)
+                pbar =3D task.get("progressbar", None)
+                rate =3D task.get("rate", None)
                 if not pbar or pbar.bouncing !=3D (progress < 0):
                     if progress < 0:
                         pbar =3D BBProgress("0: %s" % msg, 100, widgets=3D=
[' ', progressbar.BouncingSlider(), ''], extrapos=3D3, resize_handler=3Dsel=
f.sigwinch_handle)
@@ -299,7 +299,7 @@ class TerminalFilter(object):
                         pbar =3D BBProgress("0: %s" % msg, 100, widgets=3D=
[' ', progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=3D5, =
resize_handler=3Dself.sigwinch_handle)
                         pbar.bouncing =3D False
                     pbar.fd =3D self._footer_buf
-                    activetasks[t]["progressbar"] =3D pbar
+                    task["progressbar"] =3D pbar
                 tasks.append((pbar, msg, progress, rate, start_time))
             else:
                 tasks.append(msg)

