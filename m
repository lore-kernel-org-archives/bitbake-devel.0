Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76FCC02197
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 07:16:05 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.128])
 by mx.groups.io with SMTP id smtpd.web10.6665.1738739756512032404
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Feb 2025 23:15:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=e7/g5GIQ;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.128, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3HEzJ6THiPCDhrswIzfQY0p8WxBYFasNWlJkBzBDp+Y5nfNhT16ix4tlGlOaFdSK6IlJ5x712zbnVWCMxVPMhIimxEmQUL1KNcWoC3kqH3GiWzS5Eav0XZfnxROWq3fOC5toq6y21qJ/5v68LpJ7wrSMgNBIAt2LssrufcGqXYD2W4T6RTw1jrTPidQJ6peAcycDBp7+rDuKC5nPPg0UdHm5jStMEZcdFqq/b+h8kSjkTgKKOFZdUW9B72AffyF0hNLGaiU/Ml+s2RdvVNraRDoOSFyBvWCnG+c6KMSlwAptB9/QSu0khHxAl0ywxl3En8BvwaAVB7En9NPizZUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI4326i8VbSUlxv1GMyM/lMXqvQQA7NdDYs8jkUc0ws=;
 b=nJOOf+nl+ms5gV4jVkhaIEVstk3DfDwsApfiU2bRLtky9/6+QFrpeG3N4I+iBOsCgugTDAk7q8KP7obtuHYjCUZZTQZRQCopgoC6hufD1w/NguyVd5cm22cLTz9TLbFYXCzrC+GeHJiobHIR/NR+5MLL/9/ETMvjt3h84P3T/otm9NSS4Jo4CJg6Km5tbXArzNh22DbcRwVsDSyTO8EbgXlf3xsqbmF07+TYLCRGWVyGIvBRTuwLnHFCa6RcixEwHo6UMGp9M9CKHPB60vLI/KUK81sRTwU53u9MQs8Efv+ZV5gDqt0V8o21bJmBla9xMJUQD9X2yOYtAZOyZrfiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI4326i8VbSUlxv1GMyM/lMXqvQQA7NdDYs8jkUc0ws=;
 b=e7/g5GIQHKvhSo34oqMWOLRrJB3c/LgoaGiDy97zEHhl7mEo9Eo+O1vlof0GiHL5JyXKt1XwrvnTMlNLV+0/LG1EyRi1rnY1KvUkGP8MNCxv2GdSAjC5/BeV8/eAhawrQPpAQHwBoT4OKkIPQ69X3IyOoQ8WjidYA8u9ScwmZ8Z0/76M0tfVZWWLpxlNdWFmtDNYA7fkt+tsD2BvOzqCl0gvmOinppwIXHvExuEtZiRECmiohIGUrwoV+w44TU6vlyxnmZzhrSnw181Hp6/xYL0PfkHgrDmob1o87Dgk88eMuxpJ+kNROdw+Weawf4S+DYvaTSfQw2v4dBT/wIrfSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAXPR08MB7320.eurprd08.prod.outlook.com (2603:10a6:102:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 07:15:50 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Wed, 5 Feb 2025
 07:15:50 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 02/15] fetch2: local: use path variable
Date: Wed,  5 Feb 2025 08:15:25 +0100
Message-ID: <20250205071538.2681-3-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250205071538.2681-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAXPR08MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 56bd9bd6-c0e0-4c14-5f50-08dd45b4eb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?D9xrQHHmnMPREgJpeqzH+nc9+2Peqgd+y1PVvki3uamEth9jy1yWfLCXeAWF?=
 =?us-ascii?Q?y6Cc3wBrzcTsUKVGWzZ6xomYYHOW7kJD8wa3as2Hcvmwir6bcqVQ6xNLnDVn?=
 =?us-ascii?Q?I9FjvD8K8EtdvmZ1Xbns2vd5IO1UCXbm2wLufETUn42LkIxWxiefApg243IP?=
 =?us-ascii?Q?0BigewNwFep8syuE0Je1wWeZXxL3MgcCp1COIIKdBFfrpA0oLcTh+Ne7thc+?=
 =?us-ascii?Q?uqhwsNmVRQAm9xUkam/l1wgq4K3jZPJHwrfa0YM+NXbXR3hHXpCmHM297kr0?=
 =?us-ascii?Q?QpZRcFkqcW8dVUkGsJqwKPQqZeIxAQ81fTOnUtNQ70KwK6SqpWqTq4Fb3y+H?=
 =?us-ascii?Q?POKjNpyxojeJVrsqQexzDqNcuvVBFcc59sn/0f5VEHQSD1bRKRidtnUePXQR?=
 =?us-ascii?Q?0t5lIrrlSg5mYoPD0RimJzfMmL3HrHW5dpRybU6UGSqM0NMWYDI4ObHpXKDX?=
 =?us-ascii?Q?I9A3Ky6xXqjaGezEOSJ9bG1NEULmmu+0LtK9AZl0f2EFfhsOtIkxDxP9KSFR?=
 =?us-ascii?Q?Pk2rRA+s7tYU/DIBIu4Ao2/c2Zan3RnJIW6r0UmbomFFlaAMkY0p1K8XZmU9?=
 =?us-ascii?Q?TYUo5e6rCB+hRRVK81hY7rTE83DLpiFVbIYhxtJD/by61vO6qS/luSHfYYpd?=
 =?us-ascii?Q?tzFJS9OVZk6QUxUkTOLouIlR1niBbUZ+ZcIwp51d5s/RnE0N/7TR4tg9bew1?=
 =?us-ascii?Q?el8xFhYqbVxNnq8PvyPa3VswAfn+iYrYbv5kYBCF1gyh3mSM42G1+DG8GfGU?=
 =?us-ascii?Q?Qkdkfn//rDlUbNjr4KxAbml+BsI2F9A2yJCXc0SB5/3ifJqvCRYI05qsZdMm?=
 =?us-ascii?Q?1Qbi/3bx1AcoWXROODlwDIHuA/b9SUgP08TCRqJwwDG9quF72K5F2wQMpXkF?=
 =?us-ascii?Q?ySr08qM8uGjIyFaFf7frfVbSWAADFC1XeRl59oZmMj0z/ejwUFB2Fc3EexJx?=
 =?us-ascii?Q?lANVJYhQee79/1DlDIRR1K7RKaWdsZukhdpKhGFcedH0JMQGO6l+emrQoRxj?=
 =?us-ascii?Q?TxphWEmFtnUN8onyTMZF2h61L5ISqsODvGtOkDp4pNy5HpyG9FU7gqt7PJIJ?=
 =?us-ascii?Q?+xiq7pgRY2k8tZB0/zFwokxDAS1JzkBtUT9rZlLgizjQg4FNKcp+PXI5KJz8?=
 =?us-ascii?Q?sChAAceTBVjckTyRRUNpvhtlTUFherMYjLT/I+VEbnMeKFURRbvSebgAqm5l?=
 =?us-ascii?Q?/+bggyx3tdFP63oQ7Th6TC3guMiyDMUnn0uZy2HG93HhFMSzPxW4fVMP1C9V?=
 =?us-ascii?Q?xx0Fa3G8eSmSuPapULbktOtcL+fyAG/lk8vuphG3NDrXkU0GAhZOZZAEkoor?=
 =?us-ascii?Q?8C6nEElZrinNEMwf+nJnDujY4WwVnP0mYfW4ElU1Kb12VheMbEJYE57AGcfP?=
 =?us-ascii?Q?scrz9+BrvdiSsIK4dOfRCTmhInpnnOuM/5/+zZHBPFmhYpKqlEXlNAYx5o7+?=
 =?us-ascii?Q?P9YdHW76RP5/X8X+aUigaN79BQa1+bUh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SfH4DxO2bawiarRTOkyXAhmGBqw9gGT2ULHWbZB6pZEbpgQuXqqHmmgJtZCV?=
 =?us-ascii?Q?m3Q4vT8WZL2iTmEyuvhOxdoL19UvHhdv+GdFs/17AMksMgInCgufLsGJPF2l?=
 =?us-ascii?Q?CiZeFwhNiBbe39cAKGuEfsAXSzLyCyddDPkDDCJs0SQmjvGBN0LOrAzxiEjv?=
 =?us-ascii?Q?myVkVmgLRKRgDlGnzOKajW3RWFCxl18InqpvZOSmcl+zxlkpKHIpQX0ECkJM?=
 =?us-ascii?Q?Nd5x4rZjpF4G+X+twO8r9f1j1WwmbocEZF0bhmYYjiyIwhnKaFJ3gvFYqgFU?=
 =?us-ascii?Q?+unjwPHpBKpg/TgtWzrM1jVg761ltZSHDCU8E/T07dWa1TJJX9uSHgLM0fuW?=
 =?us-ascii?Q?Cxoyv4eBsHc9o7+yDxec+XxcjVV4vnaHKwg305nxLOavnzbk9wms43O96O56?=
 =?us-ascii?Q?vYDsOdzLeH9icVi36eF0UkSm8uoJzcXysvVryHHoApNc2ELBUrmQUUeoO6W+?=
 =?us-ascii?Q?ZQ4si9etgG0ExeDRrU5ARPUcSioMaF1yr2K/jyE0mQpLcCEPP7mpl9JwJrxQ?=
 =?us-ascii?Q?+jr3/g9Lpe/hEcBftrVTgIY0bzCD56s2yNK0gXtlxLyeH3fb2/gOgPltWoMO?=
 =?us-ascii?Q?B78DjsiZqtLOOH1xLk2cEcxsTTn+1DtMfqW5pmumMHzAOQ/q1ipg2Mc+jFua?=
 =?us-ascii?Q?57vfF6bV7Qx2qi43blFYPFSx2xP60golrXa1o2Aextqa47kglDRfUcAzj07C?=
 =?us-ascii?Q?wNMqV4oc3KjWaYiHJlBH//qRjnoG1WblpEa0ftXAPT1JntGn1RnGon8ZJFuR?=
 =?us-ascii?Q?/czvjaW/w4kXeFvT41zK456hjqrAoRr17bAGaR6yTioNvQwC9oP+yr1SddBV?=
 =?us-ascii?Q?a6XZKFQuI8FoJcyKEBfUPyo6aHbFb2B3SbJx3i4Nb4a1bWOMHfWfs1WXhbzv?=
 =?us-ascii?Q?nHrMGNyWNz4WS7nj0eM6NYyZV0t35Pq4IMSeMTF7z3EI1RQKocy7EqDwXK33?=
 =?us-ascii?Q?MUQODoT2FrDslTPLrhhoc3aHZdeSZfUf7yYrx7q30X4eK3hEIJDKpjYYNd6q?=
 =?us-ascii?Q?vukVbW5b2vxfELbg9W3UG+z9k1FQeSw418D232ESrLPadIQEVOF5H7qt6Cl2?=
 =?us-ascii?Q?UOv2/AfT3VphQMJe34HXSedUoifFfbZZl7zxrlCW5bBcpVrWWmbdTplJeaBi?=
 =?us-ascii?Q?aM1QvB77ZtGfw/GrHjHahWJvHVP/CHvuU/CM9JMZSW9k9geQb1zW350MV+Vn?=
 =?us-ascii?Q?H3450MUtAqoejqdzds7PLknYuTEU/0FpWyKyObLVvnRZ7UT1rMWwg56lsU++?=
 =?us-ascii?Q?Fmjn5l5sSmSuwjjQRUFMFOAW/HAQWpQEbjAP2pXV+sBjwEtBIxU9YFgHQ/AP?=
 =?us-ascii?Q?DQSZ1RamKsSTRe/UIz6b9yjQ6BRnIEwXu0J8dyLyMjhqzR4fUS5rP5Yyv8dP?=
 =?us-ascii?Q?ll29WatFR22GE6i9J0VAMB1mtC0fhjd+0ILagAFxcYH6hCCwOIY8KJsKqOBi?=
 =?us-ascii?Q?OIIDPYmF/q0MD8eMtXsaK8PTy9KFKBG8a1q3hXsmf7P29CgjOnUzxTDGK0/e?=
 =?us-ascii?Q?h+zB+cbxnj9MgWuo3Sm2MebFDuAufv840jQsaKTE59RszS2QjKCJfymlkCTE?=
 =?us-ascii?Q?uZWViX8QNGNaCqCQqrp2KIEPdGgEB28g6I0Y07R+PSpknPF5jom0D0iHPnam?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bd9bd6-c0e0-4c14-5f50-08dd45b4eb89
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 07:15:50.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2To7iEhf/nY0GFbzE5m09Kf2T3S7iAVegkN12oVuAUjZQ4I2rgNoEi/LudgrEfIokbYcWsp31jrbnMTesx3cvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7320
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Feb 2025 07:16:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17134

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Use the path variable from the fetch data instead of decoding the path
manually from the plain unexpanded url.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/fetch2/local.py    | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index c77155a1e..f282ecf17 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1271,7 +1271,7 @@ def get_checksum_file_list(d):
             found =3D False
             paths =3D ud.method.localfile_searchpaths(ud, d)
             for f in paths:
-                pth =3D ud.decodedurl
+                pth =3D ud.path
                 if os.path.exists(f):
                     found =3D True
                 filelist.append(f + ":" + str(os.path.exists(f)))
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 7d7668110..fda56a564 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -29,11 +29,10 @@ class Local(FetchMethod):
=20
     def urldata_init(self, ud, d):
         # We don't set localfile as for this fetcher the file is already l=
ocal!
-        ud.decodedurl =3D urllib.parse.unquote(ud.url.split("://")[1].spli=
t(";")[0])
-        ud.basename =3D os.path.basename(ud.decodedurl)
-        ud.basepath =3D ud.decodedurl
+        ud.basename =3D os.path.basename(ud.path)
+        ud.basepath =3D ud.path
         ud.needdonestamp =3D False
-        if "*" in ud.decodedurl:
+        if "*" in ud.path:
             raise bb.fetch2.ParameterError("file:// urls using globbing ar=
e no longer supported. Please place the files in a directory and reference =
that instead.", ud.url)
         return
=20
@@ -48,7 +47,7 @@ class Local(FetchMethod):
         Return the local filename of a given url assuming a successful fet=
ch.
         """
         searched =3D []
-        path =3D urldata.decodedurl
+        path =3D urldata.path
         newpath =3D path
         if path[0] =3D=3D "/":
             logger.debug2("Using absolute %s" % (path))
--=20
2.39.5


