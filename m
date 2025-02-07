Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D27C0219D
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.73])
 by mx.groups.io with SMTP id smtpd.web10.68437.1738932437003972275
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=Mdw/H+1y;
 spf=pass (domain: weidmueller.com, ip: 52.101.70.73, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWYc0vPZlTk7c4tnFh3LR2ZpafrmoPYcVnMqn3xdPTFKUQbBR9MVIbAuCyAXyowkZtnD6+hrR9jILYFqjPee9yO612MA93g4SGhxHiR+0ZsNdH4yfmvRMNC+Xx4hLbl5MbhKmC+lSoPzKJzH2BP4hHftgAnzoexelB7w41hz9oOdqP9bL3stai51v9+rCF1kF8IDyZ6T3RzYLeEQfvcmSxkshM8pR5aPKziHCgd38Mz1JLQdR37fhm15F/n3kvZx+d/AqTCe9LvKxQFzgrVbsAn+iqBj+27kpoEWYU191mHkABszr5HN0VAEHGPJqGqQXo9lp3jlNky8+9SLVIvY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsT8uEQNnUeL3HsqM0qxMnYRib1WfzuXSCvQq4JhvEc=;
 b=DzIOJkF8F5QioejDJAv8PXfEN5D9HjRj9XdD/b5p7TTN6/1Ej15MVZ9KLOanhe3ZMmgAr4JZcIHjLwpNQ7kaEM/Gjcm9vm5xH9ZUikhXanWGMd65czqWKjqTuEkKeM01ux+r6gehBjnZZlAwZ8Msn6d4Jhl2nPXCEMGvgGGt2Jqv6ZQ7LHrHkm6xPe3zjgaTJEJAhFbrsuPgFrk/0IbqirP8u1fB2nd7CcjlghUy0lt7m8FOETMdzPBhhFYA2UVRnT54EyQo43thv7nY+TUaWJfRDcckdIbjJdWAk0ynyMTiTVJSdfT9YFRTbNz42/V1qGyR9CAU/R56qgO/Nx3Fnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsT8uEQNnUeL3HsqM0qxMnYRib1WfzuXSCvQq4JhvEc=;
 b=Mdw/H+1yUsJb4epdRvq/cRunJCigfr13ZG8ID+ZbqTFbX34UGg83+31E73E9c0qJpFZxjlFE+FdkSbAnoLHHv1Mk/OtV5ayZsJwwsABiZYaFrN+Hk+JVtmQPPNSt/Q19s0mRCHYRstiCPtGwZj/gxhxU8hPZmmkY9gFSzaCLRqQQR/Hfxss3XZtI46Aoj1q8QzDq2Vh22OzaIB/p36iw6d55mPFrHpom6S6atRUudMM7Sao+QJb+Le6zrYwNwNWY0fM9mR/ICIYne3Xz/6OEfGT8CxYsSr6p53adDwVTwjiZPA5imomHGpjhk685P7t5hTz1imdZXxdM8Y5/tglQIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:13 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:12 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 01/13] fetch2: do not decode user from file URI
Date: Fri,  7 Feb 2025 13:46:49 +0100
Message-ID: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 267afe25-799b-4835-ed6f-08dd47758af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ve3RItg2y9FuCMod3YChRQ2MVaCWVQBg3f10Ynp/cJh4Q/CZGCpGV5v4y667?=
 =?us-ascii?Q?1LBIi/mVs1cfHLvNWrrq8eCoLTuTEmixduTVSsoLekswj5u63nrtRxIqZDGK?=
 =?us-ascii?Q?SnUkcAMPMWTgOQsJJc76bQ2w/7sT86oXxjiobqDbwYyGS4oaGfI5nmBnQXJW?=
 =?us-ascii?Q?mbsuKj8++DUbia/Ifrz7s2vsaRVZ6QHEjWBnQc7yklDAOxGJTdXbtWTlUBew?=
 =?us-ascii?Q?ektGrsjEe7Js6LyUcUHYWrjXDrlR4sTGwffzH2Fj7C5HzJhihOrB5X5fmARu?=
 =?us-ascii?Q?8Ct1lkAcBlMVae6cFIWoB8FMhGlSO4pX52N2C1Tdcb1DHNqzoQ4TZqFrbA1e?=
 =?us-ascii?Q?OAvh8WGF0Rx8Vu4U55TQIjOCd8mcr+f2tENCxLFlapprCa+2q8JUNwGbJ9kA?=
 =?us-ascii?Q?YQ2EZGkUsaOW+xB++xKPoJIi7gtFMDd4uffj3iY81aDQYTFjMgdpegexG+I0?=
 =?us-ascii?Q?o2/UfxotSmRvVkjyHoW4OI7TtrS6YAETW31EH87wCJ2ijVSYIjPmZcF4rAxy?=
 =?us-ascii?Q?sH746smPFxnQz1gXJxqq3qjUDR8hHH9LkUIFcg7Sg9k7Ff2O12FvZd6ADFLl?=
 =?us-ascii?Q?w1dIPa/+iEPa6Ez9E4SEluGsGX0/iWlHL3PE1aY+Gf6hK9av4Nb5e2fjjoHv?=
 =?us-ascii?Q?ypvR+//Od5ijMyMZ38UNyK6ObaW7Kyfe1SN3g9EF18MGhoNZWPb7cHlTpTHg?=
 =?us-ascii?Q?VZ0wp5SyN2HylA4LiakA/QSqrVMnD6M92OrD05DQoqmkAqTAOxjGchrImhNG?=
 =?us-ascii?Q?7LwpQbALganjYnXEe9vjgZ4zr3I4gw7HDpHB79WW5Ke8v9TH93p143Jb5lkU?=
 =?us-ascii?Q?FqBDQ4ejQqntX0BwzYHyybJsyRY356bk09ASH0c8jp1mc4d/HpI+ojdfmonI?=
 =?us-ascii?Q?Kk1yDlWfdch3x4Or+tDUVROLAuvxYTA/JD/kydiTRjsnOhDYw5OrJIWKB6l0?=
 =?us-ascii?Q?bC/1xuBeeHGSUkr+Mj/PsdNOk8+UXS/6Rjk1V3pYaQL/hn+yZ/sfKKY/Y/Wt?=
 =?us-ascii?Q?6LomSUpw5Ks2CSJGlq7oBlrsJdzDYRBCz/+1q/syx2BUTCeVEygsBKb4wzTU?=
 =?us-ascii?Q?vIJwUVgns+zRu737VfwdX2L2SAPln+anSRQ1SlBtllmlmTDWOQbRd3dTrU1A?=
 =?us-ascii?Q?mbOOOaDqB5M4PJd9zMYYoRqewRn1DTfjJB6bg4ZxCzxHFnIRWOTrw0hrQ9tT?=
 =?us-ascii?Q?JcSXnCgoYlHQgo/EzCgo4h2LKKN+awzWUuJqQ+csnWveS0zpMG2M3nMoY05q?=
 =?us-ascii?Q?wLg38NQvOcWlEiQ/esGMlESlL9q2jeWtgkpxXyhQg/0wKGZ/RGStcrzUub1f?=
 =?us-ascii?Q?TC0taXNCRZzqqtP2sqeb0bj4umEtTqJ9hUvpzzwHjdJmxgsVFIaLSZ0CUI6D?=
 =?us-ascii?Q?H47s/AG5Z/DzLXXGSC30I/r42xhU4MAHnkTgUNigSh2eutTh0Z73TraiMIa1?=
 =?us-ascii?Q?Jza5LFGq/ARkxqvoPzwr8+h9yVVJDony?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4lRCfhU1xwPMl5xwjcsAVz3sKMEPIYmJa6M1d5sQImUMPLInepBp3azVr9O5?=
 =?us-ascii?Q?6sGBHae0GgONrHmdKdxtOvwedLGRmZUAmpR/nN/tswI/grGmkgdYRAqQ8wxE?=
 =?us-ascii?Q?zmaLFLLLbkmPZKJyjbG2lpWj8y8sq8CMIDNwMmoYWYb2pJgYqjqqZm1LYbCZ?=
 =?us-ascii?Q?1nLcdstGvNoa1Ir9Ah4LSe9D5lmxFtAzaEwAd2SviP/+qAv4HP5r3QAGCJQE?=
 =?us-ascii?Q?rdErgNq8acMWh+2yYOaBmNPP6szPMxGxyuJn7z7hKsDBbh+Vzq1YyjQ6nU8l?=
 =?us-ascii?Q?2D8GclQyrKd1jbDMSRP83k0J7dSTf6IQIVvrOtLvFJ4Vnat05I4ZNZyhA8Ww?=
 =?us-ascii?Q?dZCtE4mOZJZ1l2gYdTtIDpe9tmEV9Q6G2keGfVmxIVN5KrvaMkNMnIyICCnH?=
 =?us-ascii?Q?vL/JT0GVTFzMnCuvioHUj/Xto87YU6yFPbIapQsX83qSCBf64iG1TTe1tE0g?=
 =?us-ascii?Q?5VipvXqjbUyieQ82RUBgFouqu1GsvNRd3itIvazwHmczd1k/xD5E13b9WiT1?=
 =?us-ascii?Q?m5XkSo7Cry/gIwsO09ddJilMogGjGmuDRwCuRiyAirForn3RJmPFHkYS9wT4?=
 =?us-ascii?Q?yqlWnBMpnB8zzhfvPHfczLFeUq63ll++ZpjljQPeSXfPE7DVn9xudmeQJYsJ?=
 =?us-ascii?Q?HYIK0ukNXsFmWZ2DtgUFBrgAsiyBL8wcNPirCyaRfe08yWHjvf1pGFtIaEr7?=
 =?us-ascii?Q?mao+JlZGgQsYOtttfr1OOTCwxL7BPmn93FcLAcC+c45/jdn/h85WIJ4gwVRx?=
 =?us-ascii?Q?gsEPMsDvYuqGOMJxNV1CCoLEzSXt0pDBShCFmOzFLrYz3Ku7SyCWVwHai5Ym?=
 =?us-ascii?Q?ZTGlmoBy+hQnDrWyCKoqxZsz034rGzSL0J4NEHVe1tSNLHtfejSXKyQxtmae?=
 =?us-ascii?Q?Rl3V2DNPMr+SgCPIcuIAiOuzKv3HmhFO7FMKzC7LodED/PvTKcanqejUndIq?=
 =?us-ascii?Q?JZ9UrClA1gl1QwYIq8txCjYMmG7sbEWSiaDWP4HTzZ+MvAC70fhyzDlTI08b?=
 =?us-ascii?Q?eitJDLAKJXkDZk8ZTm/FcEXJKquz+zW3UfIBXe+3e0qrByyQet+KJex8uFK1?=
 =?us-ascii?Q?MpFjBZFt6HPnZ554NuzbSq0BBdqUfn83taRXX+F41gvSS6VxyOxjdZL2wSUk?=
 =?us-ascii?Q?ONeVjUGX1ceTz6B50DusCfq60W2dJsV1rBB68DRrvSLd6HOzcvLkoGMUbUrl?=
 =?us-ascii?Q?DMZHFsnHGej/vaMYbGLvsOxwMLF1cdLi7/xEw7ORJZme4yPv88JI9RnGxW7u?=
 =?us-ascii?Q?mdVIBAzwbucMY8CsCr+95pfpcb2WvT0qsQOEnE0eCyy0bTyL665tpMR2v+EO?=
 =?us-ascii?Q?WnI4DtgOO4lWuFKcclrf6JIgQ8D77rbTLBnT78DlsOgD2VL4FoFL2YUyFHOZ?=
 =?us-ascii?Q?Dxz8F3DaWm12GvZRoyf1wAwAqc29ojxkVwksPdzIAHCV6yxGqMMVlDa5lRhm?=
 =?us-ascii?Q?h+70/HrnaBttmdNPBvFxCB9sOFPJB3c+c07gfOxZv7+g7YzIqaO7+Q2rCBxT?=
 =?us-ascii?Q?njIcdHUbcgCUZBsx/LoAIcNls0hCFRmy2K7YTsSAUEXEM/Cs3AVdJ8lihU8z?=
 =?us-ascii?Q?FtVnVg3WRJneJTF3RfsDmUftgx1qX/ph5IM+Azav2H7IDLcouuczwn7luf6U?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267afe25-799b-4835-ed6f-08dd47758af9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:12.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzwbHgp4o6kq/T1PqW3Wb+cbxHgFPHX1rWR5Rv28JxoSk93RFzVu1Q2XnbNCiiS01oRpwUdcKJyYeWbAynBVBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17170

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

A file URI can't contain a user. Do not treat the @ as reserved
character for a file URI.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index de36f06bf..ab992b7ea 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -371,6 +371,9 @@ def decodeurl(url):
     elif type.lower() =3D=3D 'file':
         host =3D ""
         path =3D location
+        if user:
+            path =3D user + '@' + path
+            user =3D ""
     else:
         host =3D location
         path =3D "/"
--=20
2.39.5


