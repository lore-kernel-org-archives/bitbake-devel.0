Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C20BC88E6F
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 19:29:53 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4559.1789410132407216228
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2026 11:22:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=T+pgujDl;
 spf=pass (domain: est.tech, ip: 52.101.65.13, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gujQ//8vH83hAX++CJceMhTDB5ZtuGDA7RvWYrPyQtHSEeFeZrag/3E20tBfX8obhbYwZ7zMlG7jWSfsTDJdACmkdE4n1+12iZWccXNvQuA2scRZoWTKWYjMrQI+VcYE/qhsCdOy3svCgPUu8JxlWj8GN849PXvyzqsQX5MRarUSwq5BeYVJxNrKDTbbX8ACduWR7LmApd7PBWo9lYVcxmDaq+ujLxt27g4Gqe2NID57Qf2CgpPp1qooX5GFmdaC+Cevp/5pJlIPlN7tNAdKfelqw3QXMVmQCpYs9HorKIgtwcSUJgDW74J3tXeYOHkEt+CoImFBN61YVA/MijbOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUTKWTQrKqJudG9FPrNtsFVCCyReg8PWcTFlm2az8Dg=;
 b=NFCb3IpoD1iVn+qkE89NAWL2cvPBft1NUrv/qHM7vI0J79ZXDUcG7DEPu2dZM6gAgjcOvy/ZuNDEuqUJqR2MxodDh7xOTdNDDKITFvDpOlFtvojqqVqeUTcDJq/Oj/yYMknzCeMvEAIybymcRUAQCYZzAtGfa1yVqfc08TPqQBKJo0m9PEByejrSajQF3WaS9eaXrNj/80PZ7yLrnR0EIy6XELmvrrmBdQlYNq6IP9LTWJgeykRGrlUHIm+mIWDmYU7vgmOQH0qpKZ7qN0yEUzjPAAYmwkSVFJ7a+EWY9JOfz6jzOxtmE4zvUstb8CrxT1PUTWWTTdrtFkX9g5gU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUTKWTQrKqJudG9FPrNtsFVCCyReg8PWcTFlm2az8Dg=;
 b=T+pgujDlRVY3V6iSk75tb2k/XYd5qgDwD4QnrBt6KWSVAThfq6+asGOQX5Y1GUaBvMRuGVUktkLtPb5oB+d9P9WCMx29+lGJDJAZBXSiHblqsWk12YPUZyC+U7RTTE6OzhJd95bHKzyQLstlswHHG5VJaMlpdyITuWSsTlncpT47xcThylNgPn51qEoyrZl43QNHao9vbXS8NKwe2dnmc14lVod0GzD29/HC7+mikEU5+vwWUvVf6OyGifEs9g9Gv4g7mK/dAjfak7RUFfbJheSDYzSAOSLAGazr81gl8V2nXbKJJb8Z9jBVkyWWtl7PKQCQkxxVfKbiHE6xv8DO2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by AS8P189MB1302.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:2aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:22:10 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 18:22:10 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Mon, 14 Sep 2026 20:21:42 +0200
Subject: [PATCH v2 3/5] doc: bitbake-user-manual-metadata: Doc change in default behaviour
Message-ID: <20260914-landlock_try2-v2-3-0a1bad3579ec@est.tech>
References: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
In-Reply-To: <20260914-landlock_try2-v2-0-0a1bad3579ec@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
 mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789410117; l=1138;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=ecGizml/kW69/bAUhokv+n8CRnnEWaRnvb5Yn/RCpnU=;
 b=sG3U/3Tj7B2di7CaSjR027yy5Ai1jwFxIOzZXB6T3DV59cbTVFNTJuRbFEQqnhp8zfOVQOVIj
 U3SBVBpekwGAG32Yqv3n5oxy7bzFen7IfHT/zyFw8WwV4Qzu0P2NxY3
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV3PEPF0001DDA2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6c9) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|AS8P189MB1302:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cf9b06-a96e-4c5f-e536-08df128d1757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|6133799003|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	Y5bLOeFhhQVmsayNrAiTCnf6RnExJ3sapHQ001pumT0ra3pnthzJWAo8VWiDz2K4GoEbo0YUecfGVt0RGu/Xmg6cRKPomy6f5LfJFjeXBFPOfpi82snKrLMBVeQfq533LUS6FkCaLP+PGOjR3TZ/vLAYSZKKqmgluMP3TDiQRFUYCxfNxRiJMFoMr9GmqulIYrSvdM9neflv9oTLF7X5ayeZVyseJChmSQk86uUIfkGxigxeg7qmAwPr7qeBsO9kAYR3ASPQD4wmEYZ0w1B32KTVxG8niKIUANZQNq1OgNHxVAzAi9PH/qd+1ED9HYZDP9vXC/TBM0zXS6gq3vQ9L/uwbRy/vvGZ24UJT2cDwTfW1RIt5YI8yLCG1p9nkh3QEWFxDmQ7ZRz3Hmx4ZSUPXm2rq43oDxJXzLv9tWuOg20FRjxTyQ3F1z1Wo86uloEzR/4Qw270BEiToTM9GerkePwoVI4yzOzVTluQCQZCbO9VqCK+k8TwzVSujHdDvWIGn3bDNuTOanHTvAXTG3YgtDsr6qgYrJAyp5vTF78xL99vb9alDaPakAcakaMbXiO5oj81SEhL9QQBbaMD1BEin/S85V6do073zkS9JgvXpW8tkIVuAYGlKrTUO04HOIZ81QHjtwaTzneIALWm7qDGuMiW018ials1m0eJntZ+O5s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?beWww0a/LBhXPvJaqtJy0iMIO8/yXxAquSEqFMDs2lVwJRy+kXXhqtUtQ8Gr?=
 =?us-ascii?Q?eyievHggmZsO+AhopPadjqnG5nVUmtvTBRmMJWTwm9EiDPXoYrw99Q1La1Gb?=
 =?us-ascii?Q?P7SaoQtZTL8u895x39tlm1J+asJcFFvEw5AhHkHJWcPNl/ZeOiwDr3jhnJV6?=
 =?us-ascii?Q?V+9Rcpuv5cspXaBMH+FFpjIVq33E+XdStFRuYybk1Z3CoYXHg2wcM+Y+7ard?=
 =?us-ascii?Q?+hC6TuvKq5xT4tDRmj3wQa6+c8D6HlUfnetcUFMeHVWKaym/lL/bTEIPiqlZ?=
 =?us-ascii?Q?pLf1npuVh/SWMofkzoOQzCp5PGpPvZR5eX4+wDpNIJeABeAAfr+vDMCrcbay?=
 =?us-ascii?Q?8SdLm7JQH4kovYptaY0caeLwefLvVg6xNfbRZkE8NiabPlcVRBBBQ5qP5Qlk?=
 =?us-ascii?Q?hTYOWtL0RK2HlBtJePMhVutlysL48t1FHbMcw4O0kC6/lyUpTcBILWhZE6zX?=
 =?us-ascii?Q?gOLSNYF/gsJgpEZYGKOj73h4Toc1+7VCKAbgNNOmtosjjIfXnjVF09BNtvWH?=
 =?us-ascii?Q?y+IMAfvwnDXiKL3PnEIdzIBtJs1/CyyMfDn2Qa4A4HP1xmvgV0X0YQGXWXbJ?=
 =?us-ascii?Q?7LZpyo0QVmo1/YcXe2KBXKXLND7wOZWCfI9xAdMHNMOUhCu3jCl4I+8QOkWT?=
 =?us-ascii?Q?+ZkBq7u0Icq5psq4ZY/sWazCDlhp4t0XWGC03B1UjzmuZP8pJGd55/WqNvX4?=
 =?us-ascii?Q?3cxSf+x1D76fOEjcZtx60a9C7xDpCchZmS5PdoZuEIoUUoeYceVr/OZ7Z+JM?=
 =?us-ascii?Q?bl6mhPPirVXi6XJ2dTsk0BXqojfR0xid2AXlL3RgO19c+N4n1G1wLRBhR3gK?=
 =?us-ascii?Q?b/O//wRz8Zxye7+4hGx+abTCP4hNW8u7/4QYHcn1x/GtEWKpd+kRFPoy7Vb4?=
 =?us-ascii?Q?lMFnFYZohipPPgkcWpSq8T/cUplY+zzoNBaSNBbQdBIN1zGOLypgnx0kJofS?=
 =?us-ascii?Q?LLPhvDNb8Y1ryzfmz9i6slav3exCqUb9fe2xeVrwbyf5bnzsQ2eKa38OtdmN?=
 =?us-ascii?Q?cqDmhplT41AmXu+Ej7M/f7UKfLz6VpeBRB9PmDkLn6sRIrDwCGIYTxYvUDhj?=
 =?us-ascii?Q?+vIkZrvBdVkd2ooz/WfdxHqdp5ogbZEk+66xlX4TmMoZtvEylKE4TjbPOBAF?=
 =?us-ascii?Q?jD7v7Py/h2Q3m41Snr8HJCAmcDJLtv1HRC9qCJng8kr1ou7uGCgWWuRGDFbt?=
 =?us-ascii?Q?vW3MBexi7NeoiWa+URhfTgMB7U6rtFTn/qQOmXWJdcLlWKkyu1ghCLs+aAUJ?=
 =?us-ascii?Q?9fWn5/0/HMgN73C/HUaqqOiec9hQx26Tx9tvI+1k3wYfE5HGfktUm9Nj2YRZ?=
 =?us-ascii?Q?ZtFiAHlGB3U9LhYq6+hfZi3WV7ShQUZ508zp3i+DGhZ7t/MJ9LpmdkNBrsmm?=
 =?us-ascii?Q?bewzKaVSkJ3IsCrsTyxH9XjTX7FjKlIfpIMFKgyrBooqa2flQ12Sro6GZPtL?=
 =?us-ascii?Q?KgCvFkAldu13z4R4bUVVQY9CcZMJ4MUn4AecLNYlObZAp8ZUh1YvXkW/3nPH?=
 =?us-ascii?Q?jUFvyjL7Nhnqlq6lI0z5txJtfiOqEp99K/PTiebvy7LoBkrLh2mNUaRQSiVI?=
 =?us-ascii?Q?90GnfVjLKUUaar8Phz+6WYXUSdVOeSIgwvHsCE6BqxklYzLwQ0J2Uc3TJP+A?=
 =?us-ascii?Q?a2TFqLhUukn/OgS9vhkh1/MlzcJCkZ0bHZi/ipg4/GhPIrI9e+YuteakJfEL?=
 =?us-ascii?Q?Jc1ZKKgsLjd0yk97NCisNEj5m3cVSSTWHhpx9ZBIhSdA6Ay0OjqDvWTuQ+VV?=
 =?us-ascii?Q?BJFqCfh4thO3fX3KWPaJKCLTE52V6TDf/prCoEXyVH02jfeb2bZMCcNz4L+r?=
X-MS-Exchange-AntiSpam-MessageData-1: m51Uj2634FKLZNq5qU7bUmKBxiJx3j+kYCY=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cf9b06-a96e-4c5f-e536-08df128d1757
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:22:10.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcjzI/aq4t9siwqvjVNfxCQ4idGNBGMPliPiDBgupXdgheZGTLJAsT4wmeRqhbu30T7d1TNG1RbwpAh7DqCJ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1302
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2026 19:29:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20203

Document the change in default tasks behaviour. The "network"
tag is now needed for usage of setcap:ed binaries.

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc=
/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 9cac793d3..621aab253 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1791,6 +1791,9 @@ functionality of the task:
    shouldn't access the network outside of ``do_fetch`` as it usually
    undermines fetcher source mirroring, image and licence manifests, softw=
are
    auditing and supply chain security.
+   Tasks without the network flag will run with PR_SET_NO_NEW_PRIVS,
+   which prevents executables from gaining privileges through
+   file capabilities.
=20
 -  ``[noexec]``: When set to "1", marks the task as being empty, with
    no execution required. You can use the ``[noexec]`` flag to set up

--=20
2.53.0


