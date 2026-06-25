Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76285CDE006
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:15 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5833.1782371286374348394
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=d6TO5TCW;
 spf=pass (domain: est.tech, ip: 52.101.69.24, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u35Lvha+mRCppEm7Y8P3XLmRI8xAvxc1Zva3TlAvOpzJbcmZD/VRav3KcCkrYpeg9n5PaclMF8KkVlMuqPSOuwOqC+wd2PJPLF0yIy3p1s7dUx7K2PQ5j6kP88kLnE2RZyay1SYOejYPwQKPCWB0tXNvonrDOsfgaJldeZ2bUq+nhDGAT4JsVqn21ZnyoFmgQ04PMQUND4vGodOz+u5NfjCYAL9mKErKa37pt0L7W6C4hTE7UQiKcZ8tKXpJL+W2LjmfpEQ3rDDfvB1DpLF47/BeH1M/e31JaUnZ29lCbUtm3VghShQDtrLP8M1J4mS7sjvz032UaCqPHs7s00uxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG5swdPs1GAIEDu4Z7D3RgE1PJe+PdjLx70Z/5XfRRY=;
 b=K+GmKYcNBwpHMCkJfEm61a+OUVeSsGJND8OOExCFafXunydcgPJLwUuCiOMwoCnPYsMW0UdjztgHk/CFoonhBP80tSOQ0ajDC7w/mF3SOOp9V5ccyMms9wZaoMwBYlHHZtm/JfDCSKOYPXx9CHQ0rkHcT1z/P9Ei5ru2NlcPrXjtvSdb67CtLOQYtretHqF6m4703QSRhQKtiftb2iPEiy1BqmDRaO3w5Ml3seT2IeZaFAndeTTuxjDmRct71q5OV22+aWCe1PnwWZ1tjuO2K4WmqoNbjaUr4VOZQXEk6+SNWOLsABae9sPeZAIfXqQWKrVVDaOow1s2dOG7PpvuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG5swdPs1GAIEDu4Z7D3RgE1PJe+PdjLx70Z/5XfRRY=;
 b=d6TO5TCWLtjZkR2DOmcnz7Ze8gWF30gPGc7oI1ColEcjbytQG0eVHiV1D+t5LRM+QZGJMwaRIhfspaQWaEBCZRnvq1v+P1r+UdefIhdZrKuIwusC3XVY5lfHOstcYiS1TJnAqfVjJOlgUH0hX+c7GxS8Omckt87kW4XkDWuzJHnyLLHsBhFoQlfITmlGU3cbRkdIEgpvUVq52dZW+kSgZZgq1er5ULi+NlfSngxLftab+3YToaRFHu4Jrn+khEa+QPELxuN0r4p/zelI0h5qfW1hKP+yo9qRXxyVQO5C9U7CHpol3qjJrbhD7zgezGzWqnJJDYQ3pSlxLTeTUtiJ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 BESP189MB3178.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Thu, 25 Jun 2026 07:08:04 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:08:04 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 5/9] fetch2/gitannex: split the annex get arguments
Date: Thu, 25 Jun 2026 09:07:46 +0200
Message-ID: <20260625070750.2757558-6-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|BESP189MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 986d09b4-c9db-4b3c-1cd9-08ded288800c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	iw4DfZ5hENwx3FOqD0xtjl2HXqlYkxoV7zMaZFKjoLHS8VQOWK3CS2GSnn8KB4qtpRg48Ue5QeWjorkJaR1dY8ijUEfG3W98NI/qiWszmVxvGX7ZJ7Ng/EYKV4yuEHx286s0gXt0uTeK+xoA1SKKH87UvE0yEOcblXp/i4GsZ2LETRkObB2YjyCvVyyQC3WmunH6QbHbQb89wyVGmiKSdV8/3xOOmoEhtzaQNPOwTrFZc+BynFuhVx88SYd14SwT7nBaU2/cc9cbszpmt1WSqRtrVgAr2FcGXPjGJLTKbCecYwS7wsQcbX9KmWDp0z2SDGXmU5vRmDzrMqdP2VE7dm2I341ab/NmxYamP4gr2FvyzGobjSKU3VGjCnlkg6Kb0up4Mh9ZVgmlQjWxd82cCRKDIiPVIyU85VE5G1iuszaVnRDpDT4oD8zWkFzMjbbv8rJH9QgMhgjsUYL8vasr6koKxtANjGbFI2yCS8A1NFFn/g6ulO0WnA6Jzv1UcPel5YZj+SMCRlTfbKFF4g4DV+kU22CjaN52tq9HOyXpCl/xWsITm40UQhn1l3kbQdiPtc/Ctmu60ZlTl0veU58BY3mZ6EMDBYXUVSz/OtpotxPFILplbAAFXHXn5GzlR4HnDIluOuHQ4bXzeVX0vTEpvaugawz5PHY0374xOHsN/10=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tPjPZN0uXiOHqon2OHgT9oYz5cGe9sloeb3lCGeoq/5ligANJP40uqn/ONLD?=
 =?us-ascii?Q?ZkvqISm7gzYoznJ6zpN3s9Lqksaa2nYa2nh+7XgcIhvXPPaB9CiRFdlvBYUY?=
 =?us-ascii?Q?kou6I/uXjUoRZA/w02W/+3aPd9d5F2iK2lqL6hHkE1lOJ/Tm/3InaP/jA3Do?=
 =?us-ascii?Q?lhsmXWwdxn1YI2/72jzVnZs34k112dDVezCccJxiTOe/Brps1tCwRwWy0kIo?=
 =?us-ascii?Q?K64nzHI6rZiUTAop8KGZq6n/9eD1KI3f4ySIkJyKu0VkvGSYjDwkMN0cXPlZ?=
 =?us-ascii?Q?VYCDDu1j6a4eh3/AqQzqDExtZ7sjNla7RcbgJdr994kV8CJW2VMx8ajbpA0/?=
 =?us-ascii?Q?p6SJti6ue6/Q09gw67nmwwcxheDfcz9nErQ1AAZDitTpgU4eyrvS5netO2ob?=
 =?us-ascii?Q?9ZDpV69QenDQ/28Tf39rWyFXC+pNoH51ls8tF7eeC7VgpgdLd62AOVSgX8CW?=
 =?us-ascii?Q?jfUX27YcsZEztp84iZu0kKAcGmUuh7BLvumYSp5t/ydRJEVifTbqgTPuLX70?=
 =?us-ascii?Q?ZMaIFlCy7TbOFMBNIGiwXlUAHcJ2b4lvExfKEByNedufXR3afy7kfvQAhsWf?=
 =?us-ascii?Q?8L09wcjLMARg3a/9iAwoOaN2wLz129eQjNFQ7RZf/N7hIRKuHTKv4atZH3fX?=
 =?us-ascii?Q?C1YyfVJMb1dt4zPvGRBd8MOZUTT2vfhUmq18pDeoU9QK5v8g263BXNSvHJMw?=
 =?us-ascii?Q?uL++04xJLJ3tFOlrv1rY7lZNPqp8TaQ2nYQXewW238Su7UutrGPP+uGiZx2F?=
 =?us-ascii?Q?404UacCxHM8lE2DVsCbd7XBjeu+RRwvc7yiSyBWJiDPHPO79ZEykJ97y2J4b?=
 =?us-ascii?Q?cyls2ZtYJ9/3ZRMRG/3uP6czAYNygQJdWRbQGQGcCnHOgSMUr8lDT4JBMifs?=
 =?us-ascii?Q?Z/veEHdEpOXJSBmTte4n3jgN9y60lOtL7mAYhoxZtrULXSGqmswPDbcFq85E?=
 =?us-ascii?Q?Vgyyf5cZ0nFX+aeJHFdIkC8FKWRI2Qu7oGpf2WP3NpCx0Cu2+lLtlREknSTp?=
 =?us-ascii?Q?R/t1eeItaXqt2aZ2kKaFgeHS60nm9SiUPB2ClBgAe3aGJBLWlF4Ap7Mwf/LG?=
 =?us-ascii?Q?INQJ1DpsgiuYOKK97dnEDtk4Z2J+BM6+xT6LkO+qVd6lduxt97eIjmeYenUX?=
 =?us-ascii?Q?2BeaxQGPZhyGBNto2cBh59l9W+yV3IpjBqRzvunj4aHAmPPXw/mJh7J5ysjs?=
 =?us-ascii?Q?QTNlmdbeLh9PFMbLIi+CfTbrPhMKLnE02w7B2MIYIHyo5MJXGRnAniwgSSY5?=
 =?us-ascii?Q?KQDMsDypTgOVVq87uL+piqCyGbqxP1NV9AK0Y7CpIRf03A8rVBLpBWTf5LNi?=
 =?us-ascii?Q?GRS5/Gg+yvuqjprumXXoAiMHL7ikqsGQTiIR/A0gpiONSz9I3HIpHWpQ4Z2F?=
 =?us-ascii?Q?SXM+rsYRezQVfWO5etaZKGTHJ9/lQRNbWdX3Bg4J+PZ0ooreEPw58UrNDvTP?=
 =?us-ascii?Q?qIHV15yySqxmawXjx+5xgXfR9iVvP0uSUHutXdhhhfLcy66V1yFIdvB4WtjH?=
 =?us-ascii?Q?5VPzyVcCjf2dFYuOOfAhMMXXpPg9yFOZBIO+EsRJukufJdIHnMePOZfC+EPx?=
 =?us-ascii?Q?1AlpnHFtQ30ZZoWeAIt5xOhY6GhNjnLggFWl/lck9hIb/QSgKfLehBxMInIB?=
 =?us-ascii?Q?PnhFkEe/ajv3Pp9u0RSV8+EFzaH1j2ooZnHbLiuZK3TSEJA+J5TTGb6gFyFW?=
 =?us-ascii?Q?7D5Y5oUm7AKT9DAoSvsJpz2/cehj0Kk0PCzi99VfcsR2e0oKoYDYjcshVpOb?=
 =?us-ascii?Q?IvbgxhDuRg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 986d09b4-c9db-4b3c-1cd9-08ded288800c
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:08:03.9896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtSt3x9VNLm8AbD+0tRF0VOv+fOce3zzCERW2TbVCxPy3qXs9bHf5XiVXqmpGDqkRohGuY9J+Qx3/ZvPoK240g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19784

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/gitannex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitannex.py b/lib/bb/fetch2/gitannex.py
index b0b2c229e..c378cc36d 100644
--- a/lib/bb/fetch2/gitannex.py
+++ b/lib/bb/fetch2/gitannex.py
@@ -36,7 +36,7 @@ class GitANNEX(Git):
=20
     def update_annex(self, ud, d, wd):
         try:
-            runfetchcmd(ud.basecmd + ['annex get', '--all'], d, quiet=3DTr=
ue, workdir=3Dwd)
+            runfetchcmd(ud.basecmd + ['annex', 'get', '--all'], d, quiet=
=3DTrue, workdir=3Dwd)
         except bb.fetch.FetchError:
             return False
         runfetchcmd(['chmod', 'u+w', '-R', '%s/annex' % ud.clonedir], d, q=
uiet=3DTrue, workdir=3Dwd)

