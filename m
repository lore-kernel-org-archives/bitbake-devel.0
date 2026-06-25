Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859B6CDE008
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:15 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5833.1782371286374348394
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=CaRGU9F+;
 spf=pass (domain: est.tech, ip: 52.101.69.24, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr4tWzKP+zrK1MlVSvZ7qAZSZfcBXUnqz1tUwDf2CYX1XpnBTDg1579iqBoxwmZffE8+G+D4evsiXff/GBV6JVlGVe7YX5Ohc0ocnnHBZrVpFXZl2uuMDA9esH78O4S/Mx1u7Zw+8WE7fZP8xbNxQsTWBvm5ce4Vf2LtdyZnO1mfyIhD/7uRUKUSCjhC6fXpiTxmTH/GTSIgLvPRQ/n7TszQE9YVUWdnS4dGoFTmxnr18DgsddSZNaw2OUdHwBTL6uLOS3cR5/mWVM9rfJY+OjaGscCpsVuqd/8nEjUd3U7XtT0xOK6pbpHTpHMVF0kKJGN0NArSJUlmhfjtJaPrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quIJgGNsZLNgwxMxwXWMGW66lyhugw25rFnOYY26SkQ=;
 b=qq7jlOpRUcKiYk8WUp8nGz21hX38t7xPb+h+AChnRBSPUgOIoZTCFq9ML/2ZxQz9xdfFay7tfuW7LfY4IGS4bKXpref4khG3dmAfQynEAaMjChq3aOpRmAZe3a2Psz9IyH/N2JXXZlPlBseI/iGU7gcVkehLjNbD3ss+8oMcgFca091qVjWSpAnrFx+mFih1grONndzvD799pCEtAkvHfX7Ne+pJ+NtOauEwh45J4fSgC+LqzUv86U4zNNA82eZ/IRDGDCZnOatMpEYAaADjK2pXPtaF5X0dZdlQZOsHW38uv0oE9CoEvTQ6mdC5cCNkkh6DAR5O8qzVnUo3y21SGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quIJgGNsZLNgwxMxwXWMGW66lyhugw25rFnOYY26SkQ=;
 b=CaRGU9F+Mpd87EhT3b0xsSCm7Jp4L2p9yVjLlPd9nv3JNgOvcYAmO7G4loHi7/PihxgqQb4nlSa7dKEw6rgEBVCrih/txMKwgGNEEQtLMPaW759a3n2VPxPfp2a8VLhqgVZV6phMxB9ioC1hMmVNUfgMnjvxG/4Lk0sAnSqVPclRiQChIdsIlwsqLZWan3ONrDtIfb+0jV+Fhx0MJNUe+OWzDZMGZEf8RTOt49PLsJr1+qXQ0/6U9onN5WEiYL1dYKB+SlsS4u/ttA1unxjyzhVuuaiWIBL+yz5EU8W6MlUxuq5ukqp+wP8IU2Lg0KoWsostrNjlDUS3tezmlg2TNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 BESP189MB3178.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Thu, 25 Jun 2026 07:08:05 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:08:05 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 6/9] fetch2/repo: fix mirror tar command arguments
Date: Thu, 25 Jun 2026 09:07:47 +0200
Message-ID: <20260625070750.2757558-7-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::17) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|BESP189MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: f13d33db-e047-4336-a166-08ded28880e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	XsRaOaSOetDc6oWr6ntiDhE2nqZBDIvOIFX31HxtUFiZDyMgA9Ntkp/A1lPOEWyglCaOhP0HXNSUt3UJub8gxMHypV1rvJPe3+zG3TH6lxuadpTKZr7gEhCGh+UHq4ptffOhOGaWPHiVu904jUZgdLWq0oFn8TV1vTT/Tzmjoh1Fimic0c5mUmTGzX+JmALtzJFWKSJxX8Iy+hqtd6qYHzpLJnw/CTAJU7vLsz1JqzEjGjGOP0WFJ3na4ky5/aJFIrmnq1UOxB8tl1p1UPOZZOooKtEY0QXXcvQ30vPuQKDGMGu4dK1leBv6+MmecZsb3FvRE9KV7CrowBS4/PBERDzTWc6FjThCIJoeCTD3yU1M9RFkQZCrJDUCQOrNJ1gX5BqFdDnpA39F5FSkRw1qNzioTifuvZnkyQsAMBQlYc4rAaQGLtXPJm4g41zksu35cuSTDvaEVvn7120ELDN9wdAoFW8PONuiT+In1li3eiAx5iZBWQyemNV3nJCG5Ek+NJEbVqjIaK2mfznXsiQuLHChl420fAgcMhNj5ybmUa35o+Nw3bUCzoOmnakWCLqYuxYwP4I1uVa2+ypCphMcR7tC8jhLL/Qji82brl2/RDADeknkloB5c/yUNRZckqSOC7/aOVL819NxcciM/l2YTnMXgttpxeXXiWwXgoWtABE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qCFbnoRS4oEkaRtqLuwlGIGTFP0DGe1LuFrWoAL0lPDY6vF0tjD0dGzIgyGv?=
 =?us-ascii?Q?7GqkBAGHDMjSXI+gvm1MrAeDJ9s4+ska9nDc3SbO2qO4czEWnFbvQtQYUBlK?=
 =?us-ascii?Q?bAaW4n6PkbWbTuaHPBeRzCVTF35rnGq+qPPJCjCRZie8cAFNIEE3FCr4OfvC?=
 =?us-ascii?Q?joJKXz9uaDzG9qg6LcqiOdx1t6p++edyKNdAxPjHUcBVV+pozM9h6qj4bXtR?=
 =?us-ascii?Q?w0xA63iRlyDqfSfB0NTVG4ufHoFc4jssLSC3Q5EyeCan//THifDERQaFNe1f?=
 =?us-ascii?Q?Hwt67hxTHub3FY3ME6PeHHodPOEvE1Leu9gz44L4xlgheXs8m0exPENS0Fb3?=
 =?us-ascii?Q?SgeKl6GTCZ4Ltjif+wdCRFf+Aqx/x2DoxtMlPXBbNEwKPWHeVQP6Tzm9WnVM?=
 =?us-ascii?Q?Pqh/aEWPVsHJGTqOllGEJU1GEV4Ic1HTpr0epBwKPrQhngJluecsj+vuISCT?=
 =?us-ascii?Q?H0mrsitMHrSDennF9uCunPrwjrFA7cqq3+VeieeB9n2bZrs/xLyjCzVczfo4?=
 =?us-ascii?Q?kjIgfW1jA9cejfucLBUceYJq9AqZMa7hzWPxTN8Ye4rie2o7CX71fL+E0oeV?=
 =?us-ascii?Q?3ttUYDFbSR1yyhnSzD9GIEASwnrLoMADQGCktLTxSdBj+IE6OGBsBnWnZ2aa?=
 =?us-ascii?Q?hPmwZY1ouZVvdjem7+fvOZViuTjE1VdU7oxfax8/uW4IOoKuI0TLNtc+5pyX?=
 =?us-ascii?Q?b11Q+mz0J2t7SY2eqULhxOrX8s43b7UlxqAItN56MFIG2wJHouRRupE5P6Qc?=
 =?us-ascii?Q?Te00/1nSgfhi81hteB01pqPlQqofqWb7uTCbB3vxGRjDPUiOadg/4Z1fM7xW?=
 =?us-ascii?Q?sQ4Akx14OHTKDRkWQ6+0xkShGkYAZtmoYYxAK2lQ0nM4YPFijx3XoWbdqgNk?=
 =?us-ascii?Q?Id4jo50Hc96bj4TDeDl8pf1MGLTXCyUmkF39iK0HjcHntYumAERuptKiR0Zb?=
 =?us-ascii?Q?f9bWZ4YdX60NDVUEryjHpDIo0EvRwltwe5hnXZqQqsa0kcaEej4aJ/jIB8EX?=
 =?us-ascii?Q?/yWFGBcue4buNFDs8q/BqrFUmz59jM8oPy/Ujy1RktOcUNwIoD4+wvoEHZRk?=
 =?us-ascii?Q?TrbrhCa+4HKvKnwQ5JkqLKQLHkhurU3LD7DG/RbBVNY8DtwpAuWs9sji28YM?=
 =?us-ascii?Q?BA2JogFPYeahgPPJ1ojRl4IrDZL2cVDMW4kSKdnuix594e9aVRlQttO48F1N?=
 =?us-ascii?Q?28gYeebxY/BtSNJUbZS4kYNTaM7I00x2J5jJxiTjyhlaW13jT4LD+r0PjavN?=
 =?us-ascii?Q?RXlM0J/oYsbnWrhJuP7rUCNwv2y8IbOzR4yNEJG+V4Tjh5W5lPbGae6ckE7A?=
 =?us-ascii?Q?pIlufRHDjIee4xhcoagojOsJCYZMBu4T4h1dCtDqE6F0XQfTmtOZQXq2S6oK?=
 =?us-ascii?Q?FG0kK6gNhLmxOW9ghvz0Fx6LiF6yggC+4Qvbft7jTjrb/5J3Ubkg4blHnfar?=
 =?us-ascii?Q?9/7W4iY18qEKfAX4lvgPQGWULauwCeUTLyciXaKEB7lJyvqfn5UCple0QSFM?=
 =?us-ascii?Q?X89LJk19Zbbp5X6JKEHisG2/xkPpkqUPOOd8GhGHxIpT3oz7fMEQO9cDMpu2?=
 =?us-ascii?Q?INnYcvim+UAsNJ4jIjBF5o5fSzACDGAvpylZHcXScBGEstyKvDOUBcgLY4aO?=
 =?us-ascii?Q?2CH+/45jnclwd/8LeUK+W/T1fBy96qhu53CMfl9ZmE3XaePhXSzsCBclwADS?=
 =?us-ascii?Q?QgsbkxHfLdO2er7yBwmibnbCWK7AjbXTJ0+/Oek1jKU+KzfkL7MQPMzFD9ms?=
 =?us-ascii?Q?aD0UH2fJoQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: f13d33db-e047-4336-a166-08ded28880e6
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:08:05.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CZRiEMkup2HZbz+3F9sP9FYBqyUSYiiHlNu0QmWAHYuJLsPH04H+vTDwJUTABMRtr2svQ/7FPI8revtMw6CJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19785

The direct tar invocation no longer has a shell to expand ./* or
strip quotes from exclude patterns. Build the path list explicitly and
pass tar exclude patterns without shell quote characters.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/repo.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 8543e3d59..9b96cd824 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -73,10 +73,13 @@ class Repo(FetchMethod):
         if scmdata =3D=3D "keep":
             tar_flags =3D []
         else:
-            tar_flags =3D ["--exclude=3D'.repo'", "--exclude=3D'.git'"]
+            tar_flags =3D ["--exclude=3D.repo", "--exclude=3D.git"]
=20
         # Create a cache
-        runfetchcmd(['tar'] + tar_flags + ['-czf', ud.localpath, os.path.j=
oin(".", "*")], d, workdir=3Dcodir)
+        tar_paths =3D [os.path.join(".", name)
+                     for name in sorted(os.listdir(codir))
+                     if not name.startswith(".")]
+        runfetchcmd(['tar'] + tar_flags + ['-czf', ud.localpath] + tar_pat=
hs, d, workdir=3Dcodir)
=20
     def supports_srcrev(self):
         return False

