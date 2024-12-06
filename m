Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE5CE77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 16:25:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.81])
 by mx.groups.io with SMTP id smtpd.web10.41421.1733502332037637173
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Dec 2024 08:25:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=s3wI12cy;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.81, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNVEQyXl1GGa1vQKI5XRYHXEbjol43gPgj6yAZY6N5usrXEU4ys6PJbdk2pB9ao5NzbjHUPSyuuegh30+Qq4iIE+73OSkhTNX1NgoX+qvntKVrtaz+PW8DecY1q6xwCVV4ZlpHp+vhtDGUcaSgAahN4cSUd/Q29gj9mev1HZfGWq7olIdZd/HxnV3PECB8s2iSh0fPKLp/AiBLCDMKrq+xZ4XM6NKOxNHUrw1X5I+rpDq7IX2twhVw8Y3NNm1MdZqWhrQWFVXODSo5LurXPcupcD/HqU7eKvE50lyMT2pk04mjIB/HYTkqkkcTM4DaqRu/G7OJIRi054f0x+FAU1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZYtVE0Fs91npLpC01RYFlVTYmZxTcajUc0XC0Z+mDw=;
 b=ZVRDubqaS5QmmEYw/FsQ59tIBVKYhhD4yXWnrC0Phmq0JCwBRkiE1IlBB/IsosUcqBnvovmpPgfxcy05i9Xdrh895NHn4RuiZnaO0r3UJ0PMJPBP1Ft3AsFwikPvLY3W2RvD6KaObEQZysU7xeGHF/TIqNLSgZHwRo9w/C1YszHE5+6rCd1PduELnDeNdQ7hocV8v11b423TWtgDT4Ri8wvqiBTrNcq43K2ffsIIPimrbxoHZXvE4GDhhIm6ppNvUI89TPxE2IzOSekRLLLsg3uySbXSuaBT3StAtdIVB1vbWlBaY7rCx6AHbKF8u8zUMsmmzPLyKcxUx+7UMLPWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZYtVE0Fs91npLpC01RYFlVTYmZxTcajUc0XC0Z+mDw=;
 b=s3wI12cyNkQaTbEzae0Z1ZFNpEwYG6oAezYxT2QuWEZiMTJLcldWV5Yv3AefQvfugQo8U+ksOCw7Q2WGF6PiYFhrYfIQ/lmYfNN3w68rlu+9Q+w0+VkhDlqsIXcy7qRmMfvdVq0XtvL+pFQEt114rgPuG9bkcEXtCFmfLYDvwEQVQyl/Jpe/TmQV9WDjAhFrKGuAgU9MNwxlB4OUouioUPQxze9jQI7U52WU/EXdD1+MpLC5Y46357jA+Hjopi/1XRdcqr7DEEskdxmu8KeNjo+BrcTS7h/Y/i117vKP3B0XJQPhtR/PGO5kUbRHvQrjgoblb+bb0jaN1ojBLuSd0Q==
Received: from DS7P220CA0050.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::20) by
 DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.20; Fri, 6 Dec 2024 16:25:17 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::ad) by DS7P220CA0050.outlook.office365.com
 (2603:10b6:8:224::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Fri,
 6 Dec 2024 16:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:25:17 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 09:24:40 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/2] knotty: some small cleanups while I'm in here
Date: Fri, 6 Dec 2024 11:24:41 -0500
Message-ID: <20241206162441.894274-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206162441.894274-1-chris.laplante@agilent.com>
References: <20241206162441.894274-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 15162ea2-680e-44ee-69e2-08dd16129221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xh5UAZfCQfdfBafPYI22qGouW1VfcGWX07jgl1JUJF0rTQoGg5tU55LFnK7i?=
 =?us-ascii?Q?B/QY2DD8nuytouEyPEvwWJlbzCLiaPhPupnnwFkJfXOOq+AXR1+6h8MG4K3O?=
 =?us-ascii?Q?uDjoriFnMcskeYmx0TkRmy43VQqoZxR4AO9WxoEHDiRtL3ysSku2WtRvpr8X?=
 =?us-ascii?Q?E1MxB06LlEv+qkpFVY9Pgwzkzh8Nfxc8HI3KwAjxQ+IDDE86urmJ+88raCkZ?=
 =?us-ascii?Q?QaqVcOCZSnk81Jp2CmEnlvcrWTETmECXouBCS+t10+XeEXtid+XqM+80U0VK?=
 =?us-ascii?Q?yZ+LSMEUfuTiB1XwQSZcHMoEigLwRhRYv6DtBtKAg8dpxId8RmaK7eAQNDvJ?=
 =?us-ascii?Q?Un5Lz+cNJgRRm2fjvK4wDhju1KxMquuORSPH9sJNVLXwM2ZzIpIzjtUu3kDU?=
 =?us-ascii?Q?M7dW20n52fuKLVLCLdvzxm/vgBxu7HtwBJre1XJJq2NVy18xbrS3XfAu9IXl?=
 =?us-ascii?Q?2oy1jabJFVKmyXtXFQ8M2wq2evsfeSk8+pNKzqQW45sHK6HMFF/WCDOBfDMG?=
 =?us-ascii?Q?EW3s44/C4yoX7hi4Hti6ztHNlHqGNsomMBMQqtI6FsBr1PQGBJQkGw1rNg1U?=
 =?us-ascii?Q?vpLoJP3JIEHY0XRktrs83lSYgxviatK4YY223ovVSs4KVYtWe0mbeRHE78z4?=
 =?us-ascii?Q?/m4ln/7z3rh9MQvyOD+O5BQD6qWjCaEOlXv4189CX82yd+SvPojiDDNzD7fn?=
 =?us-ascii?Q?052heXh0vJDXJR30OApXvJA9VRiZ6miyhvxTkP0jQVUmUgnKj2iCWpAtEbiB?=
 =?us-ascii?Q?qethRZsd99RNAwwVRHN9wqztLHOdZsLu6309+2DQhX+rPWATI0b6GfJQlxUL?=
 =?us-ascii?Q?NBoS30ihhC+wM6yu8Z24Ff2Mmqua5BiuHq7jR0xkYzHQhHWHJI+mwJEOLG6o?=
 =?us-ascii?Q?3Z6xwGONfaZ6BYUIoEn417ne1d38HbhYRkxEAWZNUQwCq7RnV2stjVIOrIgw?=
 =?us-ascii?Q?cbYaP3sjAihPjjIu4gSGaCFI8w83hap2P09bAkO/dKysbL4u5TmlZDLN8Nt2?=
 =?us-ascii?Q?0wVben3K/ox5y5s9RgeOUae8KXHdXKPi/4XMDRvYTdEuj1UYMU1UDNCbHJJx?=
 =?us-ascii?Q?/0T6SB2DvSAp/QwKWWOeQBw1D6YQWx37VauehjiGJ75X96Y+vR5o5RftZqv8?=
 =?us-ascii?Q?VGyXMv7Up4OdGFsL/PI0mC6RRJ/zqvxlyiSwT1oDEBq+AR3M6NChVoZpsOVJ?=
 =?us-ascii?Q?clWWBpe92FL9wHjzBxhYBUsd44E7kndlyXMnM4XiY4W+VHeZCWmIkOwBkslX?=
 =?us-ascii?Q?NM0qFYNmKYFrZbjg1sftAFOJl4vg+cQpPPa4m3zLim4GgyMUXBXXCy2QGh5N?=
 =?us-ascii?Q?qaA2ZFlQXUMjbPuWLA5uvc4lnxoEahxP8g3+2jau6Br2rtmgdktYQGCPAkRM?=
 =?us-ascii?Q?KCtOzu+HvChbgbACwqNfaHvYi6yQ/++OpEERtrmG+DkgewEZS/kigikaNAzR?=
 =?us-ascii?Q?eTSHEbUoHgws6e7HfLrGL/VEETjOeBuf?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:25:17.2270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15162ea2-680e-44ee-69e2-08dd16129221
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Dec 2024 16:25:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16892

From: Chris Laplante <chris.laplante@agilent.com>

+ missing imports
+ indentation fix
+ missing call to super __init__
+ redundant parenthesis

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/ui/knotty.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 881df9e5fb..2fff1b3669 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -24,6 +24,12 @@ import atexit
 from itertools import groupby

 from bb.ui import uihelper
+import bb.build
+import bb.command
+import bb.cooker
+import bb.event
+import bb.runqueue
+import bb.utils

 featureSet =3D [bb.cooker.CookerFeatures.SEND_SANITYEVENTS, bb.cooker.Cook=
erFeatures.BASEDATASTORE_TRACKING]

@@ -103,7 +109,7 @@ def new_progress(msg, maxval):
         return NonInteractiveProgress(msg, maxval)

 def pluralise(singular, plural, qty):
-    if(qty =3D=3D 1):
+    if qty =3D=3D 1:
         return singular % qty
     else:
         return plural % qty
@@ -112,6 +118,7 @@ def pluralise(singular, plural, qty):
 class InteractConsoleLogFilter(logging.Filter):
     def __init__(self, tf):
         self.tf =3D tf
+        super().__init__()

     def filter(self, record):
         if record.levelno =3D=3D bb.msg.BBLogFormatter.NOTE and (record.ms=
g.startswith("Running") or record.msg.startswith("recipe ")):
@@ -569,9 +576,9 @@ def main(server, eventHandler, params, tf =3D TerminalF=
ilter):
         loglink =3D os.path.join(consolelogdirname, 'console-latest.log')
         bb.utils.remove(loglink)
         try:
-           os.symlink(os.path.basename(consolelogfile), loglink)
+            os.symlink(os.path.basename(consolelogfile), loglink)
         except OSError:
-           pass
+            pass

     # Add the logging domains specified by the user on the command line
     for (domainarg, iterator) in groupby(params.debug_domains):
--
2.43.0


