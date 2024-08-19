Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1414C52D6F
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 14:37:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.88])
 by mx.groups.io with SMTP id smtpd.web11.212126.1724078269597277338
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Aug 2024 07:37:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=uhl03bxJ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.88, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJ+dLcvMVcS+L23P+wiw3z7Vh/UhmU/gpfMHGVPwV/kqpY+PyT0UDjYDb1jWbDf7xeWmuCAf2kTxWGlSTgTJdA+xJL3k7UtfXjY0bg73QsTGDomlSKDdrHrT1jPCLagoChVi+odpqjVuTiiSDFvsEIS/F/BIDrHJNGpdMtWP8mPHhNW99AcI/CbwEZesdSa8Eo5GZ4axFTrB43zXH4QIxHInaFx3/IMLRgITE5NtqizANe0SeOa5Pg9AER/O5dmIsBJo1WXs+zVsGZblFpQ7bn6HsAwQrkeavoqGQB+pgxrq5kprKuhGxtCneYA7ccvOZC5kaLFVgQgsNGoiMLGJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l2j4tzKjzaaR3LrDdtl0y02IGHW+J496Yq/K8qYSko=;
 b=kttawZxH8BzNev348Tla1X4bUdLM1miTzcJNMXAJYl9lG9L4WRc0T4LjHO/EKF6NrTD2UwCGsdRQJ9n4815qZTlMMO+AE9dPpdl16G0F0QhsU1guUFHRaXp30C8B6yDshNCEKY2jK5isqHVx6HRK/s7m3KCHKDXGOaPcuhqddkfq38DEVsoZKt3PyxdrFZ/4ZIrL9vbkJrDjbyPHERzZAWVcVNnANERLrTtODFIuc3mbqx5fb2Ilq1GYsNRdF0EIIJyEssinvh8+osZYzLv78AsfmqWTiy7ozOMnXhKu4dkdE7JOCOz8/pwMWNJsG3Eqorv41NekjqTu/FF+gYgZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l2j4tzKjzaaR3LrDdtl0y02IGHW+J496Yq/K8qYSko=;
 b=uhl03bxJSTb/ha1swsbmug+daV0O29HSB0JECITeccQfUhMajdwnlWCOT99Hh/38K38Y/3eHFzDPEh+WNOlefjp6D68wU9wzO6vN3Enh12lS3/TIRKrt/WYvE96uWR7VMnIGssI4c2eRghfV+m1sW8EX4SL2Pfi4rVMqnTr2DLWcfeQ76cf1kerSC6Bk1MMBt5Yu7IYo6VLkGDTPO7iXVQFFNiWPX5zRNluxxqTv/l6aOI1vgk5KMM2pdavqSLOhKC3dVVKoLib/sk5hxcnGGMFchPOav7REeoHFs7Uyt+cPypESE98Pc9yaenZAYgAhunLM9fTXS9GL3oIdA5UGwg==
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:37:42 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::4d) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 14:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 14:37:42 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 08:37:35 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 2/2] ui/knotty: respect NO_COLOR & check for tty; rename print_hyperlink => format_hyperlink
Date: Mon, 19 Aug 2024 10:36:13 -0400
Message-ID: <20240819143613.1380185-3-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819143613.1380185-1-chris.laplante@agilent.com>
References: <20240819143613.1380185-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b4cef9-ea14-4d2d-07c2-08dcc05c7b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UtTTY0UmoI2HJkb8ex0YDM4N+m7J3eaXihk4pNIWe3Ifbc66+PSHRDv2AEU3?=
 =?us-ascii?Q?Jk5bK/M/+llqM01fJEZUkEhyNjQ9SERazbyve8cbpDYcWhy8AXUoz16WLnVY?=
 =?us-ascii?Q?iCWgb2JjRJcEL5KQKsuGLgJcK7evx7EDfCwg+HvXUbfKF9nM8XIKmfSC5xa4?=
 =?us-ascii?Q?XaL06jUEIQPl6CFYTsiotkyH0czYEEMf7PWljkE4c9r5hF45T5blI7F7TsAD?=
 =?us-ascii?Q?rav4ev6Ep9VZCe1YeWcAPWEvUveBh/QomEa26rQ2i8JYyQAM4x7UyTWhYZHV?=
 =?us-ascii?Q?qO9HwGiygDTpelJqEfGsSJn3esf7M1g77UMwtsefti7qwjR7ZzBkDE4E49SL?=
 =?us-ascii?Q?aNbBW0NrLuM0OkS9JI0JFUnpvxd4OcbTIaAOnRvvtbUp0xyOXRCkrlVoO0br?=
 =?us-ascii?Q?6Tq4Dvr93lFxZ5uYNQTRP87a/s18MZKLKcJk8Wa/I+zKjFi2YKl2tUQ3+fzZ?=
 =?us-ascii?Q?UvwZ0BNRhdkNFh5HK1bA/mXooFytbvIaadlUIQ75lC60aq96ziLLPae6yai1?=
 =?us-ascii?Q?Dl5NqvNTyyvPS7h6n4W6szZf1wxaBSKjT15KWUAS532o1n51SN69K7wfTZOK?=
 =?us-ascii?Q?PIaq2WELI+Etg38Bv0pQltMcVOHKaxkxmj0Hl/WtoZTRhTXq5CrhmMtlWwuM?=
 =?us-ascii?Q?0opQsQXMwAM1knX5YisXaXd04FGKPL4NV8zUGrrgp+W4QXWEs/SsJYpigqdv?=
 =?us-ascii?Q?3qaTMQdN16B7Aq2/LaltI+fbAftOVzdOah654oAwRRI9D2AdPMWICZygq9yI?=
 =?us-ascii?Q?etHpsIT7YPESxmblcqZ6e2YSiQseQ0V8h9j6W98/ZB5LxGoPs9NmDDx+3DWW?=
 =?us-ascii?Q?E0IBNk+XdwYWu3XtHRqfBzX7gab+iIKQHuGXieTFJflxiv7lVAFEFGdIzjoW?=
 =?us-ascii?Q?6sLfca+5UpyQFztm0YSi10WggpGzumrh3bYLbO2qHHG4xdnmK+n2aey6fUo/?=
 =?us-ascii?Q?iND4XQ/UQ0PHfSV9Fraf8vsCfbUXfkq0Lb2jXFZUvpHtByxOKrQ9GQ8154n0?=
 =?us-ascii?Q?Y1WATAxr9H5eEx+v/rG0+M72KN3TLr8JZ6U/joq1o5ovRT/LqZGmKA8PwZdG?=
 =?us-ascii?Q?i7CIEQo4dWLnl+AQpO6wknOKnjGoQfDNPmOmPKEGCOKN76lRam1lzeb1p39j?=
 =?us-ascii?Q?Y991tcqy5cyRXPxqwJZLajxnmxSevU8S2VVi8INET1/IXbLIzP64KJL7Mqe/?=
 =?us-ascii?Q?8lC4xmNKQguxRMiMI1fx6Xk/U+7oQ5VUxeDoS8klY8PpFhQaQiPfle31gwtZ?=
 =?us-ascii?Q?47LEaDpxk7TwXZQPYaxYa5YyK9Arj8KFG1UccugRL+DjiXcoRy6NG80MFQxo?=
 =?us-ascii?Q?XwrRCZAMyz7VT5RJJerAQ+d1v4pEUrntELH2+4gpDGsRhkZ8GazBn8J+BlK6?=
 =?us-ascii?Q?L1JZ+HTayIKIiIhiwkCPkXZyBbZKk04i5M3i7tida4w74rO3g5L2japBv8Ik?=
 =?us-ascii?Q?jwzVjX/5+CI0TDLvnVGj0JItn4lKCBU8?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:37:42.0544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b4cef9-ea14-4d2d-07c2-08dcc05c7b8f
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Aug 2024 14:37:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16498

From: Chris Laplante <chris.laplante@agilent.com>

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
2.34.1


