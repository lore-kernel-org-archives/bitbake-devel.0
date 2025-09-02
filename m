Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF70CA1012
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.127])
 by mx.groups.io with SMTP id smtpd.web10.71239.1756795548727092388
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=Aac844yf;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.127, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtBUHbajM6V60X4TTRu75kB1ACrnhdTD2JsSCtKBpXt64nVDWERj+CiiQ2DO8K9IZOCe07FSE/CqR59dAff0Bw+vvhSf2xLo+4ScgLeMLo1a3+29yWIZdMdPxMZE4wIImfcczLjkyVxHJ2hL4pgyoex7gRFQnh8406w4gTBU9fJd6FiYUQAEuxZKFKSDDG78DOD0ri596lAbH7kT8FJg2/nui5a8eyhzdfOfIxV2+WktqZo6XhV4MCRqq0vjHeTzB0pOisF4+yOUNvhLv/NP3tAL9P05DUxdi9ucOp9+DZJ6ZtBjwtObX6jikaZMJGp6LaXsQFwtLGeGbLEuKzcgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzxFC7hTjDeOMK8MkfGMYhPFDQspg3ksvCXyUazqS1s=;
 b=L13wqGT2k9e2iuw/7yQ7hBSDgbY9CmJJoJFVeiGVRVxRpry9apT9RAZS4Wcw3xtN1PV2+vzdMJxd5Tece8UkvXSjt2fNZQ2hd1qGi+vyezccOkij7OA1X3CiInClDRBYRPd36yeH0wPm8VE2wv4O1oRhji7GoAFDKulinannVgCvuexoBoGpPNsXITlknBbanAQeeBTzBARWSUfXZdtScpDi72AaUGiqMXs172PqlCWsk6UxH/yQZHQ+naUlueGQrI+hzcrp4p4Al7sTa2zC3vDW/5UhTmGPaFDpRa5znCRTEvIrEINOmnvLUlbCE29jWNkQSg/r8hd9W4Vh9LGFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzxFC7hTjDeOMK8MkfGMYhPFDQspg3ksvCXyUazqS1s=;
 b=Aac844yfn7huxHGlfi2xT1CvNPHS4geIDRGXafpPjL1RhBrkF60cBuTfW4lRVxjp61f1QvZ8PPfb194j0rGrdp8JUZSadyC6C13I3Z4rrWNVNZwZllzVNVfcunT9+8mZlGXhjQosPh4iOZNB5McG0Zr6ywIEyL+EZ85EcJXXH8wXaaV8cnTEtETrMvh+Ap27orJ7bwZ0YnH/IoFO7ti4WSW2PAHKprhmA5OTktItErPvqBMSTyk+n4Iub0cUDiXOh1ws/yjcpMPmxtghVt5RL5I+2CQ5Hsz327NTwHRGiLtpn0YY1fgpK6Jy3oAXUax+dgzUZKN+Xgd74/akgS9wsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:40 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:40 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 07/15] fetch2: gitsm: use rev URL parameter instead of SRCREV variable
Date: Tue,  2 Sep 2025 08:45:06 +0200
Message-ID: <20250902064515.30879-8-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: badd5add-2334-4ba0-1ba8-08dde9ec53e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ze2hR0I+3S1HLqMrV1U3kZtaVX9J1EGmjMoAz/cHsuZTvtXR7pm8Q12W1CbQ?=
 =?us-ascii?Q?QPTImkzVE5VR/2aSfYYzR/9gORdLKVNsFZyLbBFty32zc2p7N1M496v2LZM0?=
 =?us-ascii?Q?8PG7g6zcQHkdFGzOXSmLDq8e6mS/6daJvlP28b8Q5/DKyvbtZRD8QeOrUffw?=
 =?us-ascii?Q?B79heoVb5W/ws9wKv8y/z8iV/Ew1JUAbPfKeaCmgaLBYVg1pEw1mlOCLnvVZ?=
 =?us-ascii?Q?eCnGpV1i+UGUu5Puv1ic3ovnFra7VGUTGpd953zX3DjSD04UV/3yhEQjrhCR?=
 =?us-ascii?Q?6vXejNT8vRYgtJUmx5pVtL/zVIa2Zm9EPDJXwc9dnhyTkciqTFR7m9DZDG/Q?=
 =?us-ascii?Q?aesd040oGdvxi8V9rDm+0UVIdM907P4NvnL2HxtZVsyS7x81TZGww1fPiuUA?=
 =?us-ascii?Q?/OIOJHV9crYoqX8zO1cQcUDQDQ/06a4IdjJdoaNg9vsvO157lhc69PcroCkq?=
 =?us-ascii?Q?WQAF5VbW+x+X0GMPGb5qwBgeHu6iIbg2+Jq2X1WDvCPaMCWw6R9XYIKqRNBG?=
 =?us-ascii?Q?a4zBg2Ul8K6hW1slwe53XolDYGVT412EP0TqFxSsDen5U+iI9swKQtiviyGE?=
 =?us-ascii?Q?yms26uCgD7zj2sFQZrcnst3Q+Y0KG8t5ax/JO1p1/plG2vwWSq64WU4P3Uj1?=
 =?us-ascii?Q?DGZxIZUPgYjT3vCRY1XnKAAqv6lGJ38RET9/StypL9EAhzehI3PYhIOM2nuP?=
 =?us-ascii?Q?cc7tDUfbqsHau5zMWmy14awSL1wj659lF7raKh0sSMZOVP7N76Oi+4RLucY6?=
 =?us-ascii?Q?LHBSHFQOLWaHrWWJtfAeup0p5y6H449f1OqCgPfwvpdsN8+Dw7YbOcK/D13O?=
 =?us-ascii?Q?R4TOW6eR0FLBG85mdYP/KlCU10t4H97b1sRBJEELhgAMzKULQFUAACGzeLwk?=
 =?us-ascii?Q?TpsDGP0fR8ls0meArY+PTEKpUrEBEa970zNp9/tApeed7YPKyJWxm2gOks2k?=
 =?us-ascii?Q?w6qMVrtwt0CNY83sAynUMM9rnUiqkpl2kTTR1MhU2cBAv8q1cHmlQs488/jz?=
 =?us-ascii?Q?PgZWcZE6JozlhenZOq52MfT4g0r8HWutY53LsMhL9MLyK3O0LwG04Nw2afW/?=
 =?us-ascii?Q?v7vzndPLn2n7uTw0gl7lD7dT0cLtnw1Bragec4+2CJdwIAsZOj8nBoAimQq3?=
 =?us-ascii?Q?N+c3sYK062cFrKqKBU4TB0LbZEZ22zE8r1zK21XxC0WcYuKMsxeaVCJ9eJm5?=
 =?us-ascii?Q?Yp1nngRfnzwWUFRzhwu4x0/QaW1bElzjiicHMcjFMzETFvUpZtfSZgmhqzOG?=
 =?us-ascii?Q?rhp2H5bYUFBQyTFKafS5QRNWrfmRrn5b7GoYF6yG6Y4F44OwtDiRUI1ecPX6?=
 =?us-ascii?Q?WAbwa06nBgkK2mkYI0N/88zyURimTzqiDvWIPjvHKUk8AyMmuMClVj6fBuC0?=
 =?us-ascii?Q?ImxMvqTASacqW/IkDvWgryg9mXLUMbHx8ZQD8f0MjTAOVoEbpTVuLfeUyHOi?=
 =?us-ascii?Q?qf6zl8BfFxkZLsHrzcuAvr3CXcWv5i93fNdPnYr1wdEl+t4IySFa9A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dwfUpGZ5gegN6bGdcybjrB1pC2GQWAKrk98rFOPaP6uKbU8KlaYdfUV2KOos?=
 =?us-ascii?Q?uDE4LZeZirRGJkPUrmq4pnfVwlfaDpsPQLOa3bSWgRdVW8TvOKw8LpyhiKIq?=
 =?us-ascii?Q?Y0WMGM0XRZR5ByH9xJsX1yNkeNEX34+bZKKixZnDWmvLkRe4LsHK3M6kKWKv?=
 =?us-ascii?Q?oZjJpuDQyXx644VnW0IuBsCaYG1Rec/98wEo1vSVzlgJ/yQKnB9kIPW1pizj?=
 =?us-ascii?Q?2JbtBDYqffxTenLZnfOXpHo3JI3CZq0ZnefAea/tGyTmkwfi7fQ+7aFnlgoZ?=
 =?us-ascii?Q?C9pxPz8lZ8hYBC/zIgIZ0uY+iF1FMH+91mLFi8Pgp4ukCbkfu7qcmIKFlKa5?=
 =?us-ascii?Q?QlSkuf/tvBGdy7mvPPSOmbau4n1v5Kyk0PKcZvbALYdxCle2RsxvmYm3wFPJ?=
 =?us-ascii?Q?eDSqNlU2u+sFhNWmAYDsIbI6iIW05g1Kxn3kFFU6Q94PPVPKDlHe9Cp8VB3N?=
 =?us-ascii?Q?MF7afrGjjthSksK0BEEJN8fstp2KoAhuZ7a15X65UyWTwlHXm9DQ0Y7Z2qD0?=
 =?us-ascii?Q?d1NOVyDg/PooxoH4mMWtqJRa2F0MR6w0yIk8fYiAppm3j8XYcBb052q83zeI?=
 =?us-ascii?Q?LvwO73bJz6O/6HLq/9Ak+ws3ysDeJM3cBP8331GhMUlIDbfVL5SofpoNFMHS?=
 =?us-ascii?Q?SOI2dTlSjYyKbx06xBcW/N5ZIvZPBjb79WAckMIWhIzfktTFdDNvzwyB+0h+?=
 =?us-ascii?Q?wzyfG0Hm3Hl6U127xxx1MNgT0n/rlakezRVBaj6qteRRu6Hrv7UC9Cyfasw1?=
 =?us-ascii?Q?lH1YWjtK30BNw5sZlpkFLReA2keUiiPTfhjzkaDI9UxfWUKInOiu+DtjXFQC?=
 =?us-ascii?Q?+85IOnVdGJo0M1wJobWpcCNYv47bgf8RuOlTt56rnQzHQ9iNsUX6CImL7KUE?=
 =?us-ascii?Q?QdtY03jb0uBlsMNj/14FPCLemrZi5g5R5N0hurcj+USQoR8qxAFrbeUcpzns?=
 =?us-ascii?Q?zqbT017IfbXAahoQKOzcu/gxXo3jGUQiBAffuvnAZGN9xTCE/Oyht7eqn0h/?=
 =?us-ascii?Q?X6pQFx7t8bnq5DjbuIaPBSL/kKK0n9Vv4irpmgeF4SVKsQC4FWvJBVnBxiVD?=
 =?us-ascii?Q?0q5Mw5ZQ59EdQa0xo9kfjyhTYdrR6LRLF4plPZnFz601sPCtVkaZdN3nBpoe?=
 =?us-ascii?Q?EETal1b4TZQjtxu60gws1ByjqtkxLyyKDWCNuxpLXn7kJ9G6ND6hS9QHaJzx?=
 =?us-ascii?Q?Zr6Tv8iF0utdDrUWWEshlArT3MxbTX999xO9IdvI9jzGiG75Kb7VpYzJEFXS?=
 =?us-ascii?Q?J21dZaPh58R46vGd1I5SAX5/zYX/YdFCRfqNGAF5hZWv6yG0ViVCACpwcBkt?=
 =?us-ascii?Q?zPO03hpPMzVt5VzrBCTunl6wcqU7yrDAq/aFcSTbHIBhojgA07KFQxArWGdl?=
 =?us-ascii?Q?O1Bg4PPjhiXycSdvQv9plDSrH11sZbG1IMprdmkZlFcJ0EwDepEJ59Mio+14?=
 =?us-ascii?Q?brXro6QaiPhuRQlybUTHn7sIliMkzu0a2jsvFhkerlh/0m2oWt4rsf81Acc8?=
 =?us-ascii?Q?+k5abYgBxf14pgKMq2fYcNPcydMVdtZpvW2Kdb8NboqdtdF8KvuJmrDxt0di?=
 =?us-ascii?Q?6SDw9wQsEUUUYo+0cgsEUi4FJkGUEyr+t6PfGnDv0cg3H05bqiP8VK3Qj+US?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: badd5add-2334-4ba0-1ba8-08dde9ec53e5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:38.7021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiZn2ZoQmSTIwZi21peF3ulj0JEb9whGuWuKSsq54jhkdG1+wxqAqS4+9BnTtU+HxnrIEbSIYKm5ozuxybaO2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17929

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index bda9864ee..497661bd6 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -123,6 +123,7 @@ class GitSM(Git):
             url +=3D ";subpath=3D%s" % module
             url +=3D ";nobranch=3D1"
             url +=3D ";lfs=3D%s" % ("1" if self._need_lfs(ud) else "0")
+            url +=3D ";rev=3D%s" % subrevision[module]
             # Note that adding "user=3D" here to give credentials to the
             # submodule is not supported. Since using SRC_URI to give git:=
//
             # URL a password is not supported, one have to use one of the
@@ -130,13 +131,7 @@ class GitSM(Git):
             # the user (See comment in git.py).
             # So, we will not take patches adding "user=3D" support here.
=20
-            ld =3D d.createCopy()
-            # Not necessary to set SRC_URI, since we're passing the URI to
-            # Fetch.
-            #ld.setVar('SRC_URI', url)
-            ld.setVar('SRCREV_%s' % module, subrevision[module])
-
-            function(ud, url, module, paths[module], workdir, ld)
+            function(ud, url, module, paths[module], workdir, d)
=20
         return submodules !=3D []
=20
--=20
2.39.5


