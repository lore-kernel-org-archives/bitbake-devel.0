Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C6CCCD185
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 03:11:51 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.65])
 by mx.groups.io with SMTP id smtpd.web10.4405.1760152303808700471
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 20:11:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=NMro9FUI;
 spf=pass (domain: axis.com, ip: 52.101.70.65, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4Ix78puXmrhilKQKIBU8YO62V6pnJwLtlNc8OgUGDGAVNCZV0KHzwi4h0t4Ch/7Hlr9VstP4S6akv8TIZ5N95xHSJxJlY+0EiuV1xBtKgOK3uA6IiHS06az6/rul+0AKJjACKvXShgOUZB44FrocOQeVm17j1w0QI0pHJJ7nLzsFoCvzn+foTMNhYrSA+TPba1sY7VCjdnl39OJ2SILKa1j4JjljRIVIv/Dhwx8/Vn92+09gGTrO6tCb2XCgGmNP7RNyoKNKOTmnhfegvmMLXCLClYG7usgUr7tbwiwZikNYTD6J4l4fUHPgD3CU+LsnXSbXq/FqOWTAg7DxDoFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0T+OVwCbEul1d+HD63N0XBC50UfWiHaAc33t0Jea+0=;
 b=dlU8CrJCaGq+3dnj/up4bcdFVlGWUmpiUDvkoRldDBpPC9NoULOK2ydm5Ek5Q55ez50g8F+/KGyPUVxJW3uOCffx3gwI7TPC5GO46vfhG9ZgTR9ThzfEQjuTj/s1ChmIuI4qHmI09UcbYeDzKTc24kIAgE20cPuuVbyb2eK+qf6PIMW+4eCvwtzfHq1btMD/u9lC8Z5iwjtOcVNNrH2N673hN/35JG9S37Ml6DKkInLb7sOdE10QEef/7OaL+JP6f8scFYf/w2rRgVrMo6Zp9sWjULKK2xyim+ZL9zI8Up3d4WethWzVvgkcAS67se6Fr6+qwVL4Bc51QnmSh+uLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0T+OVwCbEul1d+HD63N0XBC50UfWiHaAc33t0Jea+0=;
 b=NMro9FUIKB9xSstYEqFLm49atKHqm4bheekqk0s4uve6Qht5Qfgi/Je4Y+h2mCDR0HfMp3sOUHwMSqlzfTIJUi8g23F+SUUdRacu6K3ulVMGpJOuoaopRc7h7sz+OTuzpvgXaMVf5SAL/ksOBeGLZAmJlEc3xJi6l6ff15+u4B0=
Received: from AM4PR0302CA0007.eurprd03.prod.outlook.com (2603:10a6:205:2::20)
 by DU5PR02MB10550.eurprd02.prod.outlook.com (2603:10a6:10:51a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 03:11:39 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::5d) by AM4PR0302CA0007.outlook.office365.com
 (2603:10a6:205:2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Sat,
 11 Oct 2025 03:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9228.7 via Frontend Transport; Sat, 11 Oct 2025 03:11:39 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Sat, 11 Oct
 2025 05:11:38 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 11 Oct 2025 05:11:38 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 857D11CA0
	for <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 05:11:38 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 5BDB81209E9; Sat, 11 Oct 2025 05:11:37 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/3] knotty: Some improvements to TerminalFilter.updateFooter()
Date: Sat, 11 Oct 2025 05:11:34 +0200
Message-ID: <20251011031135.2243358-2-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251011031135.2243358-1-pkj@axis.com>
References: <20251011031135.2243358-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DU5PR02MB10550:EE_
X-MS-Office365-Filtering-Correlation-Id: d4acfcf2-0cd5-4baa-afdc-08de0873e55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2HpZpDLt60kmRje6/sgYdDvZ2LEmKlCkIUfBRfBllKZdKghdb3PqyYTc5fg1?=
 =?us-ascii?Q?RVv5oFdwHtEv4Siyb0Wtuxm9FQtE9w3yaFjOoQwqLFiNzJBBKmRap9CdfK6M?=
 =?us-ascii?Q?2mEu16yN8V4HJU1iPKT9yIyPnkQMWCFRASrkVvgzRxN4XKJSRjDMMtk1m0Ev?=
 =?us-ascii?Q?cUrG+Efuk0kDpioCukhJVic7Zxf6z7u2wQP+HoDFx6X5/Ihr6fFdRVRcAM5I?=
 =?us-ascii?Q?f43+pWML9BwVsmM4ldD1FPWGY6lxuoBTvcTaAuBA6DyjSb2khzbJjvdePOit?=
 =?us-ascii?Q?MYy+F3WKH/JBArA9LHooKTxTD8WHNNKBd26VbhOedKR0uA2EAZI4UYpm6Em8?=
 =?us-ascii?Q?6RElavDEroRsfGzmKsf1ROPqt/g+LgfWrW4F5L15CWKp9bASz3O/1/aCuvR0?=
 =?us-ascii?Q?+pDtsa8NXBIP0YlD7oasGrCnFTpki+DlGMu0sic4xwDO16xb7qMv09UC2JhV?=
 =?us-ascii?Q?Xvx9ZJ/iLvVKBOkB6PQfoHMXxK9YkItNACGgPpXCqD14jeW5cTK/Eg6wFYek?=
 =?us-ascii?Q?KJ8xrSgAANx1MijLtuHQ3ZwsV32TPEZC8RdWrk3TCUue0yI/KAg78g0jd2gP?=
 =?us-ascii?Q?Z3UoCFkDULfu2/aPLhtGfezDE2EyWaYwJ3D20JiT2uduxjoSPVTzJgFs3ShE?=
 =?us-ascii?Q?4pHaR/ibbllRCmuxZCB3uUojxackr4T/ccXptikJpEW67w+w+vQpLbodq+0L?=
 =?us-ascii?Q?CzNbC9xddR/pMWDhPlvqzGMdWWyibTduU1fTzQCEPre5xL/+AvbPhrWZzQc4?=
 =?us-ascii?Q?Jm8UiFDKLMRMrIvgyn8MLAZAL7R/JjCA/sbddz0+eSGb5/sN0/ye4N9nkw4A?=
 =?us-ascii?Q?Lxak5xS8rPeLokbSW+U3dpvgMEFp/5a7FuOHN36QDPIVmC/Xnedqel9Cihsp?=
 =?us-ascii?Q?m/LEwM5mFiojwS8IHQT8OyG4hVuG0p9XwntWhsAheJCQf/N/BJipPDUbjy9B?=
 =?us-ascii?Q?PB+1LOv9lXRT4rKSz1hFERJoD6Gn19ZLn12PQ1BuCjvCcxMqJRKm+vNc4NCY?=
 =?us-ascii?Q?xz+PMUnrkXxaREE3XC6WQlU5Qy2qnBLSYkXF5Mxf8k3e7Hc0XVoMEaLBLb9p?=
 =?us-ascii?Q?1i2RzxclGKCs/VxKfujZn8suTbICxidfGef9TKOz+HreuBCZTRFrbJtkC2vV?=
 =?us-ascii?Q?ZXd85ASBG0KHrcmx0xsTU2N2VFo3VR05zcM1Ee9We71K1hYXm779mdjxIbVP?=
 =?us-ascii?Q?X2lqF8WbUGVrYSANO8AhyFF1iQHcgV0WEtkVQuB5iXyHQm11+3a5vZPL8OD6?=
 =?us-ascii?Q?kSa5dDSs7SncUx8cwi+C0NOIkwbzgRGx2SZ5DJUeY9wiC5pFZG4n2Udlaha2?=
 =?us-ascii?Q?xYUD3bLGBmdw+CgMDABiygbgnTL8OtXnAV+uommKV/FrThAk9LLijqo4oVU/?=
 =?us-ascii?Q?hkqWuPggjUMp9QqYnU4yxN930Rxj6sill6KZEMECaZCXyzP0gfhO8WCu3JJa?=
 =?us-ascii?Q?1oNm+7kMW5ysf6i2nBYXImfeHLgMMu2h++ZhwSlGNwAxSBjILcF5R+1qunLL?=
 =?us-ascii?Q?2zJjLTF6vho60YxjRbCjTEzmlkwzmXxgT9d+z/fIWoB5xvRTISypXsDkyy6q?=
 =?us-ascii?Q?sAz2H+ljAJuKxeBOD3I=3D?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 03:11:39.5300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4acfcf2-0cd5-4baa-afdc-08de0873e55f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10550
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Oct 2025 03:11:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18170

* Correct/improve a couple of comments.
* Iterate over the values (tasks) of activetasks rather than the keys
  (TIDs) as the TIDs were only used to lookup the tasks.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
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

