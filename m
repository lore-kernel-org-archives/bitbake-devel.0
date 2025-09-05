Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92538CAC585
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 06:21:24 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.75])
 by mx.groups.io with SMTP id smtpd.web11.14988.1757053273963266587
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Sep 2025 23:21:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=VnublnBi;
 spf=pass (domain: weidmueller.com, ip: 40.107.159.75, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mynna1MNNoOYGZXXc9xMWODCpNc5gAPpNxG9fz/DOamTQ2c73ilnYUoE4PYVcLFyCILqRidB+NJd6Km1RfQBJDzxme+devR0fZPAkfyLF8gm80h7VoAONKdLjFKlbEFRcuWU/GqvjES2hk0mvD3qSG1Y7w0uVTKioz7+yJ8iAfOBRkSUpPBtIfqIU6uT05p5NNHj/m71rDRS9r7S85Dia+ugvAjFhFmqD8ounhHm906mxbZufzuzgI9brlF9hHBO58t1CXBmYxWbB+5p2ynG6jHgg3JtnK63RoE+ZblEgqYqFEC+jIV0Bwh/OHdwUlkyHcn4cvpEb2bNRPhALdUYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTFZjRz2Zi8ePd1sxhacyPK9eStitM9OedNmfyn1gTo=;
 b=Qbhjm+se613pwizG8vOI41kd7uA1hIU9Ap7UFAkBROHrfLMGIMquXB6PKZOggfN3956KGBS95wdKHur+kyDDRXyrx5i/Ciqo49ec5au3T+IEqabWcwXFqINp/V4ubq40p2f2ptKZV5+Ym0mH6vAg2afiW32j82wISICeDsD6bO8PVFEu0GQ05lJfsNnUlbbM0+D14/WUWEAKssQlBnF7enLXmW0NdSb1Z8Re72qrMfof8IUNNbpMENjwvoQ9G6ECN/ilSOEpJpLMy3GrmPLuNSQZfkqFMGM8KwL4RObpJkpcWsdOGV/hUEeJxC7OsJN+kV3mSvho8ebDF2xMnKojfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTFZjRz2Zi8ePd1sxhacyPK9eStitM9OedNmfyn1gTo=;
 b=VnublnBiDM3nhygYKiZYrCYGXwQprrzGDryqPx7u4JljRGgoFZp97P8JR2WPQ+pxTa54k2fJX/8JyHiVnurOjZXmoYYFhMaBZBa+5XLLlX7Q1Hb1qI1SOraFo2sj//Fstp/d1l9eUGtGoUEhvzKI27pl6IVP7gOCBcV0On+1/n0JyZf0p/6ICwjJEoKwqoTFaUtxgCxFJ+NcTkANvecV9KXBQFiSIylz/UvWX0muApC9Awdzhf/Na2Z31MN1jFRrQQjVUAu3LCf6cqo0UCuyVfsUhhRBw4rKcv/eFsVVTOiqfX44Y0o7G8eqLRQ8QRtttbEB1PWLoNUF+NyBMGYCkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6)
 by DU0PR08MB9632.eurprd08.prod.outlook.com (2603:10a6:10:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 06:21:15 +0000
Received: from DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25]) by DU0PR08MB8422.eurprd08.prod.outlook.com
 ([fe80::4ac7:a794:5e4b:fc25%4]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 06:21:15 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2 14/15] fetch2: gitsm: use TemporaryDirectory instead of mkdtemp
Date: Fri,  5 Sep 2025 08:20:57 +0200
Message-ID: <20250905062058.2563806-15-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250905062058.2563806-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DU0PR08MB8422.eurprd08.prod.outlook.com
 (2603:10a6:10:406::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB8422:EE_|DU0PR08MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: 431b8f6e-4812-4da3-688f-08ddec446b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VpIBP3OD5YjBpDIQ9lS8x1xWL06MjALRw87YCk+6vf0krrImw5jOHmmD750z?=
 =?us-ascii?Q?sN+F3I4ALcFha6SvoLDsrPuG+7cXK4J5J6uEhDXva2a6u7Tk8rStVijgk5ZT?=
 =?us-ascii?Q?xjn/H+YKkx1thBZm8CA+fNiCdOc0jHeWW6OCU+obzHQJzwNasIyp0v7WHz3w?=
 =?us-ascii?Q?v39psIE82ZqFTW9xZ39NQspByzpVc/tmNTZQvACj2rJWyKn8BqHmLrkPQ7je?=
 =?us-ascii?Q?DPYr8RtTGsy5fX4ymT5BiivRYEZ5mKvYn2oJL98UnXZ7GLthq2LbYV/Sxt7K?=
 =?us-ascii?Q?nFmBC2IScxdOlRDCe9kPFqxSolFtFQiCn64JRhSBlwTAyZvS1am4CvRJd6Pc?=
 =?us-ascii?Q?EAb9I+8fVLlcCApqKZJ82AZlKcoAuKPV6VrfN1QD8aSToT+q93u3HyjwQZye?=
 =?us-ascii?Q?fwUSG0/FSpiHTJ6nPAKZrqV8G2AZUUeKf2OPahsXSL1rZI2oImovZ8JTb/Uy?=
 =?us-ascii?Q?n0P8PvSrrQqEhT8gRLaJYbiTiL8VMU7svmdLjoYb6qEnkZ0esnHM0VoLv7F8?=
 =?us-ascii?Q?ftg8F18OV27iT7O7i2fYDLp+hDphgT3PPclG9ws5XCk2gCCj1Eva6CN+VnWY?=
 =?us-ascii?Q?BBQpykJxJL5Pi4hAGJx23JmCtdm1x123O+mM3UvNLuyI4hp4zhvduexdlm9A?=
 =?us-ascii?Q?uDdDFeZgk4yTmLnqOeX2dFBzWN2FYa1XBC6CD6Y0jD/xmNFhs9MUcDKpap/b?=
 =?us-ascii?Q?M3237lVG7GKNhzDM4SUpJgdPCOmsdq76iPymSgmpHugxQ7cELbqXGQvHnoop?=
 =?us-ascii?Q?gCJDaLbH6NhGLNb66XEABHEj0erqb8baFpPFoU9yMZErLDRpsoAI9PUMgkuW?=
 =?us-ascii?Q?8of6dKPNDtQR7BkuTniCenfPXaHpF568j9FzLKbMqDrnWhwD7hvwO1853j9e?=
 =?us-ascii?Q?+0zd0H0USE28HfTUqERi6tOQPFOw1mw8XOQdiJoEc4NMW+xt8gwQy7jidwWP?=
 =?us-ascii?Q?7u3jFqtLneR7JOb3/uWtMkt4+lSh48DBLeVR3oQKSTZqVtHgmC15O0PVWTiC?=
 =?us-ascii?Q?QqFSkQ1wqY+kmwuMf1JKqTKCTwZ0OMVFB8N06fxRYoBX+R3rrEHv8E7+JSEh?=
 =?us-ascii?Q?ac3tM6u+8MWL2t6HcrPp66vNWnxR+x43DNxr7/0kVsYk3cc/bBLfA0l6em2r?=
 =?us-ascii?Q?RorHZ/iW/eHAjGp/YODTOwequOY1Co02Pgu3/TjRGk6HnPsG/y8UwCPAwjJt?=
 =?us-ascii?Q?tB8D/IidLXOtWIz14ay9Ks6Vi6SKguu+25dOyhMUxwAm12eoOcud1VC4kPBV?=
 =?us-ascii?Q?p5Q/mbMcMW9/QIUFmx00/xpm+y8remn05Eq36mD6EXfAX5783EIbP7uOt4B2?=
 =?us-ascii?Q?zylU3LSklHVYuSs6FVp+/f5fCWsrRto/9RT8uQdTfNzKPrjkP2biJIiwibKs?=
 =?us-ascii?Q?hztc56bGQdMaFEPhsb4ovKwpQWpAFVPZIXTBUcaN8a8Bk+OX+oZFj9alnyyj?=
 =?us-ascii?Q?XlIfrZ/7nyWOPnvgm6fLAJ01AOmTEKIspLsSiK9I5pi7EV+kO7Qikg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB8422.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KrS9lYm9tkkaRkMwiSfc22msLVnpSuCabP17WoC4kKwnyOBnRSK8KpJQVPsv?=
 =?us-ascii?Q?Q8bVTdRoJ0sc6/l782Zmprk6b63JOBAkvBC/IDuG/lmbh+/rmG0aT2Btcddz?=
 =?us-ascii?Q?Msnt4WtjVltLr22vUfK62ufu07Au7TQIgtUCwU+pZJ8UrYRxr/xWBIFHhkIR?=
 =?us-ascii?Q?/FCeTBN+dsJss1rE41JsaAUvWCWdS5l0pvd4+0DpwHrHaxmkX7FjUyufPsim?=
 =?us-ascii?Q?ZwBVfEhDvlL4ExEevIJAeGzUilvasiNUBPjezvoKKr/aadZ3UPUnWAATbwdW?=
 =?us-ascii?Q?5KQVfdTgdTwA5FwgZotUuaQvHaiWEz7ukX+qLakTw3ELrPOK7y7uV3mDK5Bl?=
 =?us-ascii?Q?MGntCIYF/gNAJDKXkSmHDAU25bxlVxVLq0/ylWegwe5+LPEDJnWuHWcnsti9?=
 =?us-ascii?Q?zwYNjMSxwhfT89XgBHnKj5sthJTOSLaXLom1IPmH7hrhgUu0940KeUW04kiH?=
 =?us-ascii?Q?Mw1222T8b5V3Ildg4wCGUePwqECtQRn7ZXgUXd33DNs8twDRw9cLyit1MWdj?=
 =?us-ascii?Q?FVrIztNxAkzcaYaz38VNKqsLDvujbztK14GtzU4lkmL6/H6V2U51nR8EeR2N?=
 =?us-ascii?Q?twT1KJXoZJeCassau8Rn0kjpIcp3Ya4edbnDb38FFfs6IkvvuAyFsPsN8bYh?=
 =?us-ascii?Q?Iju5Jz65yfuBPtAQr2CxTSSIeIw/EHnSU9jYkITiZBpuRQCEMYN/HdqMK2pU?=
 =?us-ascii?Q?W0iZRF1EJWP6YK6Q0FXbUIpXYyTXVtfGNyeYmxD6j55AIib/JBJxMAUxl0h5?=
 =?us-ascii?Q?TKKEtQaxkj76/y+OmtDe1KZ3XfJWmJDjNRDqS9zA0C3p7elckYALATLWoTlk?=
 =?us-ascii?Q?ZcjlJboBk4+Jjoxh5B7oiDJPLpyTRwWtV9iouUe2ug2HPQUr0DAKiiGAIr/Y?=
 =?us-ascii?Q?2F6XziI2iCBJUkfCRaHw34vU55BokH0djY8V4Er6+/xu6iXHiYxp3CnkSVdy?=
 =?us-ascii?Q?2FcoiyWzc5iIUUZN2loLM0RoZRRoW6igoOeWmR5mzbzz6AEgCTcV/K6b9Xn6?=
 =?us-ascii?Q?vFxQsTw52CA3h1KUimchG7yNkUwMrG6XFPAXUCxLLtZHZ+4U3ZxBOFJrxOaM?=
 =?us-ascii?Q?bNtKi/TB/tPu2wLhJZp9mWrJ3plPG38kzF6FJ5qOQr1EVCzX0vUsNr7FF0lF?=
 =?us-ascii?Q?G7XgNZb7bSGrzXH7zFUEdIFWUurMV1Z/YahoF54VEZjEH4Oq/ULz/5yXRvIy?=
 =?us-ascii?Q?/QL+xQMiOjopMYr5m6FDIhx4CjKY0MJwzYn3DW3qSVo6B7a58KZCzhBalrxV?=
 =?us-ascii?Q?fmFRjmYahIsiJZTvuuERF1HWqUZNkjjLshblZrBkmuRiivLfVqSvCfyPWaVM?=
 =?us-ascii?Q?GqLjArGJxZEau3UAybS1SXK98SI1633I7b+cYg9TMjFZcJCLcFPmqR/qbGbp?=
 =?us-ascii?Q?hiopPP6v1QgWMUtHzyrHnKHQayHGx9jFhOBfp8n4WzuiWeBmDlLVi3eXl0uA?=
 =?us-ascii?Q?Gn3zIXOZibiXW0jkto9UXf2LToAA6LH0q8CbtcPkj2flcoz7EkG3+PR0Lwp9?=
 =?us-ascii?Q?8i9mLkpqqdtmUaZlmmmi2h9qbWH7RenXYndwBRaghLi++mAYClrkciRdzi24?=
 =?us-ascii?Q?3VKCYJrJt0KU0Ie7M/3o25Hf8bgGFDESygbvIfIyO+W8Ak9GGoDObaUqHneJ?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431b8f6e-4812-4da3-688f-08ddec446b07
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB8422.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 06:21:15.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yodhoF/u2qWqPOOWzckJBMeN02pUjcwzyK6F3G9wvPYlPZAXnCi+9uTvSJmmlxln4Sz9Tj4goGo1gHHavxIkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9632
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 06:21:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17971

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

(no changes since v1)

 lib/bb/fetch2/gitsm.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 31460b19e..4b6c88baa 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -20,7 +20,6 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" req=
uires a clean of your r
 import os
 import bb
 import copy
-import shutil
 import tempfile
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
@@ -151,12 +150,9 @@ class GitSM(Git):
         if os.path.exists(ud.clonedir):
             self.process_submodules(ud, ud.clonedir, subfunc, d)
         elif ud.shallow and os.path.exists(ud.fullshallow):
-            tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar("DL_DIR"))
-            try:
+            with tempfile.TemporaryDirectory(dir=3Dd.getVar("DL_DIR")) as =
tmpdir:
                 runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=3Dt=
mpdir)
                 self.process_submodules(ud, tmpdir, subfunc, d)
-            finally:
-                shutil.rmtree(tmpdir)
         else:
             raise bb.fetch2.FetchError("Submodule source not available.")
=20
--=20
2.39.5


