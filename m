Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FF7E77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 21:56:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.77])
 by mx.groups.io with SMTP id smtpd.web11.4663.1736286998993525899
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jan 2025 13:56:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=WclwP38T;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.77, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ/U84q9UQWzg4Yq8xRw7ayiRKNviC2+dBXVQ3A7qOgEtWVLu8/Z/R+YkpxkeBoNpYCg3vj7G7CI8f63M/DXjHfpduEGS2ByjBv2PP1Vu5GEjAMgRMXBz0yogTgQog3Ozpr/dd04lwl2eW350qzqSyl8n3UktrIpBxWmfmzRBN1Aozox/r5XdDeG6qOuMzaO4kY50zLjruWFLS/WGO+VHy8ELP1Z5aqSTkiJMrzbDHbAslDO/eUMFgVzzjnWH06ZfF06eWz+qYtv0YcSTAGjFoQlkuQSmXDQuX3ve/ITNikxlc1YDhf37sgnCM2Bj+TGDgmg03kfhHlzkz76dI8wbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3Fwj3o6MZyc1n1wk54/5JxYl0UtBUjEKVE2hwA6hqg=;
 b=N0Or2nDPeygW4TjGzUZAd1WWmJY15SBHoe9X9xCiOKqRzXZzSgd4KOUCmRt1W3VHQ4SWWQ53KQ/CicZ7OjLzDuGwxZqxmwgrVMbssJskyJb834Pp3Udw3EYGCSOC/u9JjmnCOUiHXYsJpJmrSS50ewQRuK6jtfDZodfWW3EDqUqbyRR/7KfdS3oHsTtA/x9j3Y1Jn+9HNMOJ4R24FaCZONh5hpFZ7Y/zrIkex8cuXAm2kQ5xFLQZXZwhxch81EOSxh3YfmaOKBsGRysox/KVgpl+v1ajzeugJFeCWJQSMz2YkxXOXHmtGchIs/lvSAMtPWaOuuWg7qQj+5NVO+RNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3Fwj3o6MZyc1n1wk54/5JxYl0UtBUjEKVE2hwA6hqg=;
 b=WclwP38TBOVk60LcDj9hK4FfToH1Vr35nxyk0/Wkt7Gu36pRnfDOAOsKHbJ2mUcBkqAzGhlKWaxa2tO0wUe3F6xLuy5JwM8GNNkuzWyl8Yan7+3KxJmZUiRJxd4pMOSNQHRmwW6MusmTLHdL6GQ4Lu6VZ90NZepfIHowtKYpkGB0CQ6ppsb7D04HbhfaxTF98nTOoXPluRXB6DCsJYBdM+p1PST4ju4PZPC44C15w5H14ZXcvBOFIOwJzXbi0OgY+3kzxGpmJR7VmsWwusUp6aKjn6l7xdJHMzoxiu9T1Umnwqw3yEvMN2kRfNiFAz4zZZlEVx4sxI9Qdsxw35+aPg==
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 21:56:29 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::2c) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 21:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 21:56:28 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 7 Jan 2025 14:56:24 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Chris Laplante <chris.laplante@agilent.com>, Richard
 Purdie <richard.purdie@linuxfoundation.org>
Subject: [scarthgap][2.8][PATCH 2/3] ui/knotty: respect NO_COLOR & check for tty; rename print_hyperlink => format_hyperlink
Date: Tue, 7 Jan 2025 16:54:02 -0500
Message-ID: <20250107215403.251838-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107215403.251838-1-chris.laplante@agilent.com>
References: <20250107215403.251838-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 153e05fb-ae86-4846-76f3-08dd2f6623c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vinhCLVhhxaHgkUeYEwkOG8SN11I1dfSecjXwAZzkDtHGbWLaOTgbKtkMuJ7?=
 =?us-ascii?Q?5zDuRDSTszH+6BbRyaA9AajsJGnzzQhWvQv1VjTdpGtVrOCFdilVojgHUNHq?=
 =?us-ascii?Q?/SyTGjKNWbInpOeWmxqdNmsuDQ9VqhJEbyH/tgW7crCzqOxxqLaRb7yHhb3S?=
 =?us-ascii?Q?AASWVASQiFkS7OzdtwCP/MddV23iQT+Yud6soauxt0XnW5E6bF371kWx3K2I?=
 =?us-ascii?Q?K1t5kX/1cqBVS9fmCuuF20/k2mK5lo5EAQSnxP6B4CU/J/RzENxOOwLa8Eic?=
 =?us-ascii?Q?RWWlXXv0mTC9Oc3ese93xJbjGYCE7SliGymxHZsSE7+7fAYG38/mPTOORZQE?=
 =?us-ascii?Q?eSXuYlmk2oJBYA5mecHK7Sks7njXkOCKnlVU3vB8W9Ad7NSOQsyO2mHK2tAv?=
 =?us-ascii?Q?hSHaoGgYJnDBj2W7bBVqsidP4EjBWzbT6PqNwR7PIFLmtFJc7k70srtxxcmI?=
 =?us-ascii?Q?171HOlGErhJ61/ngEOOq9TJns7g/jZtrnAjwdIs3JleMBZm8yhz5v21w0B3v?=
 =?us-ascii?Q?0oX7RDXfWtgn4d1Hap0trj8CAFdlgfMU2QBIP2wAzVQiZK0AoXbfRknyieds?=
 =?us-ascii?Q?goj+ben6WOEmOAzco2zX73VY/vqpNS7wuTvxJFHjIEt+CDPV0abwKapBApkG?=
 =?us-ascii?Q?6ZbL2N28VqrLzgiPMOUz/tb7P7Oa5VxlI3yD1eSy+0E/U9tGNWUezDJRWs/Q?=
 =?us-ascii?Q?LMx8XK9PqbxBeSuf0VTq+gO4+O0pJalubzMBT/MbFV+AlJQ9kmVyXh+yr1Pf?=
 =?us-ascii?Q?0ofLcJfOXq4v2p2eq2JHu5T4V4heisNe1WgNSLdCVAuuz7asb/JQHD8Twi1c?=
 =?us-ascii?Q?CLE0it9ZQeZKxbxHC1hRV7Ympa1kdk6VZnSmwopW4TwCg8dxgOYzoCU6SItk?=
 =?us-ascii?Q?notHbeslTTx+GmrsGPqtMxwom5Fgm0EQJSnaqgW2exu02R5nFd9vATbspNd2?=
 =?us-ascii?Q?ylqkesvUAObMk4aJysSn9DwBrHDqhqO+Ohd+h2x1LadrgkbFfAUzBu69dDhI?=
 =?us-ascii?Q?mnBnmS5qAN4Xz0sMO6fYHPs1aqTrDKFkH8w573iQt/AmPRthm/8U5WIVU6gR?=
 =?us-ascii?Q?6v3ifygwOCOLbeJiYLM26ykmUqY8qkrhuqGeM8UoHw+pwPmKlgCTEdR1rb1m?=
 =?us-ascii?Q?kVSgn3+zlWmK+Rfevwyf2fQiTuk0W1lKNEmj2tZgvc2zkREsOPsGKSYrTMCe?=
 =?us-ascii?Q?akAmEuWFLbOjA5lNsYQbQto0b7RU14Zh7VuFT5VKmgg2tDL2G84hmm7vuzpV?=
 =?us-ascii?Q?j+lpmOpFOrJqIE3AjbJhReWfBcplQjpmALMzLlbU2sLHLX0lNxcsHv9Jey3u?=
 =?us-ascii?Q?7DuSGhWgAlRNZkcDi1RoleaZf3R1z7ux7d1PkzCv98vLgzscmm7qEZySkezP?=
 =?us-ascii?Q?E7r2TqMOFYTFQg9BKGrwaNjHFkp7M8KfvhGMQtcone62+2oNXueEv628Ystd?=
 =?us-ascii?Q?pQteSdg1NLyMphMSUnAh3RY1mCRbTdzV/mFyUVY56yKDJqMKfB7Zb9YsVNor?=
 =?us-ascii?Q?fs1XC6NmEeLtRSE=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 21:56:28.8829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153e05fb-ae86-4846-76f3-08dd2f6623c7
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jan 2025 21:56:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16985

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 5956ab177..3784c93ad 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -577,6 +577,8 @@ def main(server, eventHandler, params, tf =3D TerminalF=
ilter):
     else:
         log_exec_tty =3D False
=20
+    should_print_hyperlinks =3D sys.stdout.isatty() and os.environ.get('NO=
_COLOR', '') =3D=3D ''
+
     helper =3D uihelper.BBUIHelper()
=20
     # Look for the specially designated handlers which need to be passed t=
o the
@@ -944,10 +946,12 @@ def main(server, eventHandler, params, tf =3D Termina=
lFilter):
     try:
         termfilter.clearFooter()
         summary =3D ""
-        def print_hyperlink(url, link_text):
-            start =3D f'\033]8;;{url}\033\\'
-            end =3D '\033]8;;\033\\'
-            return f'{start}{link_text}{end}'
+        def format_hyperlink(url, link_text):
+            if should_print_hyperlinks:
+                start =3D f'\033]8;;{url}\033\\'
+                end =3D '\033]8;;\033\\'
+                return f'{start}{link_text}{end}'
+            return link_text
=20
         if taskfailures:
             summary +=3D pluralise("\nSummary: %s task failed:",
@@ -955,7 +959,7 @@ def main(server, eventHandler, params, tf =3D TerminalF=
ilter):
             for (failure, log_file) in taskfailures.items():
                 summary +=3D "\n  %s" % failure
                 if log_file:
-                    hyperlink =3D print_hyperlink(f"file://{log_file}", lo=
g_file)
+                    hyperlink =3D format_hyperlink(f"file://{log_file}", l=
og_file)
                     summary +=3D "\n    log: {}".format(hyperlink)
         if warnings:
             summary +=3D pluralise("\nSummary: There was %s WARNING messag=
e.",
--=20
2.43.0


