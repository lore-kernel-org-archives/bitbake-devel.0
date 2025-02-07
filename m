Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A42FC021A0
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.129])
 by mx.groups.io with SMTP id smtpd.web11.68552.1738932444338795086
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Feb 2025 04:47:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=mO0VAk0G;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.129, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2zygd4JUtDADUwZOQi6ojKVIPCVT1YIfUHuSi9ry79CQsO+w7PaAhbUJ5XYRLw/VlfpdbehKrX9bu4iT1T4j8A3i6SKEZ7r5jbpkQRnntbMOe6yyZrhuEcEufW6RS/Ox6tjGWd2U8f1Xs57RDXOAXUQIWMMV5uZFfA4JV3oR//iCF8qGtTVuDXjKNIjkuIDLnV1HMzUTm4mYNcGVE+NiVv1TfkdmzcZR7x5WtxiHZK93H1zNXnikqgdjs3LmD24oiqUFsmQmf73My055WX/Re5PLJVeHvniezd5dDNLLxR0GOeo+wfsTXC29b0pY8pUGQ7Bei983IGbv0lysr/B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8etdPKbcLYyoAHOtdrw23JDPxnOh5bDZZRVDpfXUYk=;
 b=EeS7fO22NUG5t3OpjfKN2Z4SixCquLtIkSBiHybBFA+ciZA0lu5LHqYXCw7ABDmj8woZKttx2nzTqImig9OcAscAWJCPN9bNKNkkgcMPdKWzAQrMksN5qlwlIdsUo3tjJ3PpZ3oNXpGiCf45IavSikm1bvaz+kK/VSX2tJ40wBxVxfKFmdsOKjIASK8sP2uL4GDAeDR4bHqVEHclV91qB914AkQwjHommZ6LZKgL41eFyBxbz5+scSoT2Z619dWu4P6YJ3gWprfpaV3uLI2TOH99UDXJPpXsIxPZ0h84DCDAaJfEyNm7SEUc9yhliNPG78C/ix9ryEzTUfAPo9lI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8etdPKbcLYyoAHOtdrw23JDPxnOh5bDZZRVDpfXUYk=;
 b=mO0VAk0GOh8Gcn8A5uEW/b/2EO80cLoz2+kc/y+rCopkK2r+Q6Jh5hz7Q0A9/JDuEXTKLTrMutujjwYz+jrhqQF20KT/jPfAG7gla3nWYnhASA7DsNJtIBR6ZPobwMN1h61bjaWs7roC8yAkxGFOIYRww9fxOnuOXnMRkHVZr5jvabkcQURqHYLNhqujHssE/6mdD5KS1inOjazcaYURgUuTR6H37DiCOTePY56RMAtxaNNTNHPvQtdNBZvpOJ/jOiLwvCTgNcbi2R0TomTOVNqKxtTBYjqTsS91RapdG3qI+nFBHzlStArLSAA4bPokzdSh51uBeGl0S4gnPeihJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by AS8PR08MB6390.eurprd08.prod.outlook.com (2603:10a6:20b:31b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 12:47:17 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 12:47:17 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 08/13] fetch2: remove unnecessary unquote
Date: Fri,  7 Feb 2025 13:46:56 +0100
Message-ID: <20250207124701.14787-8-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|AS8PR08MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: edb99380-b64a-4a47-a72e-08dd47758d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6E3auwunbvY/DotoCz0M27QGaNd3qp642spHzGL5tvCl6Rq6cBr1NVsNlRMl?=
 =?us-ascii?Q?GWOl5MQrOEw8d351y5ZtWyHfifqqMdFYCR7S/l2XVQNKprRl1kIyG7ZGe7Zi?=
 =?us-ascii?Q?GSqSr0R7DRNxzEUBBWaYH4HHQhWN/FCyUU4781P9wH+gbUEqra636vnXz2NN?=
 =?us-ascii?Q?O0uqEHpoKRv4NzsFndvcZh8Buq+RGhr8Suqgh+1yecFlcQeRx3UjkOqMJUWa?=
 =?us-ascii?Q?xF8+NCQzI/Y2GqI5aTkNRJNZxURKW9GhH8Oz3p5bj5mYjRp2uiolQWSw+MDK?=
 =?us-ascii?Q?VeqIh5jXDkxxcuO55gPrlnnrN6DojcuQhjiW1+HcbU4gL+TzqfrdXvS32nlt?=
 =?us-ascii?Q?loIcUwrfbkTeH1WRoobJv+Tuwk3WOWlkGQovuPlqctT+urTL2RDWseYH0+7E?=
 =?us-ascii?Q?b/QAG3BIrIVeQxz0OSLyD/DzlVVCh+DvVr8iTN9lg8yED03Jd/1iPf8nGgFB?=
 =?us-ascii?Q?iqozPoYWFTWDL236CRmPVuKGDEVEk0zEXHW6zKrqSsD9VTuwyQrCXwkaanSa?=
 =?us-ascii?Q?B6FiTXCSbUy9yldZ5fGaHj4B5TGPhT988G0BuSpJ9FcMNbir4ccnzcQynOzu?=
 =?us-ascii?Q?jtBWue9zjwot0N4c/irbCjrBVuYxDVp5j8Nhcn054dAjqny7NczrWO2kg9Q2?=
 =?us-ascii?Q?54tWB2d7PNZHTx2O+vSgmDr7Ozz31DndNwQl6mld0//NWduwEjfoSCl0fxiz?=
 =?us-ascii?Q?3N0HUAPoho6tlm+EkAlFLaOF7D2nXHdzzUpSdWu1pt0RB3Y57UMli1QYKhEB?=
 =?us-ascii?Q?F34YfGSggf/w7TGCtCpA/d2Wvc++hENuxtEMsEzYxV6iUiOSQsDtRFHNiNFR?=
 =?us-ascii?Q?Y+wsuQQfDtEjb5UvN9PVJ+hoYfxEzS6uQ66sU9vTU60ZrL+ASgR1sK3hXDT1?=
 =?us-ascii?Q?zh3AAwY+Gd/OnkdleFPhUDx/Dgyo9yLofz3Mh2+Uav7tMvMuBIg3OTd6hSiV?=
 =?us-ascii?Q?3Ziz3zmGQ/qszgvRs82XX3E7xM8NwxBhxs3q6tE8rkfvCE3lZad4sdLGcuzf?=
 =?us-ascii?Q?BvJXA30ywq9DPLQhAU4ZPY1X1N65JSLAF4cN7JnrP/ufoobCh5pkUi27AXpD?=
 =?us-ascii?Q?huVF4AwOZQkUloF2iB8pXar674jFDRr+aJ6oMZ8k2DdGbtEtHbWZF7+NIuhC?=
 =?us-ascii?Q?st612HVeR52/46EuonfG8Yoa5H6XEM4noToHd45zmzU3dgQyvxYOULdWB/vf?=
 =?us-ascii?Q?5hNITLcV6wjMx6HyoOZaaY2iSCsD/BOA0d1DthqZknd04IynioUsg3xUqvb0?=
 =?us-ascii?Q?IRzpP5Gotsh3zULHRd6rnkVax3wgJBBuLA60SeVgo1jge/sbycd6vXmPZ0EA?=
 =?us-ascii?Q?N4BUl+4/EbNeyWPmv80vOSlD8gYbjxfX5Ez9g4a+sUaqxIR9A86sTcBnlurO?=
 =?us-ascii?Q?wYSWr/TZ4/54eWNT4btrha+3uQ9IsO2RLhidR9EXVQlMx7A8CHwxr2Lqxqe3?=
 =?us-ascii?Q?XyZyQbptnOcYcqqk57Z3eX1O4nQh71Km?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:da;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LJlhS9mT2GhAx/s0LzQlu2EWgsYCZHUJUkrpPufGZEWxf0VY3m+CPpoJopLc?=
 =?us-ascii?Q?pMniYbvVO0M3Rz1wC82IXS76JIaoeipzeTNV9ekQaZR8AQ4JKZ/LQKghGgmL?=
 =?us-ascii?Q?5v+l2Em7RsjlqIJ41M1C9ZFMVQnwk/Sgicktw9iutZK38DoDDTCcX0BbVhjT?=
 =?us-ascii?Q?wpAlg2RcslmcjeLrbrb6uBxBKzEt9Uryj9GY3a8BDf3Kf066EgzzUR8X3Qko?=
 =?us-ascii?Q?pFkqNG8jib7sQyMWdphMnfIyTxRDoPzc1OIIA6AmDfsgGE6+MbXGgLgLHf6E?=
 =?us-ascii?Q?mqI3Q04994nwDBb1DDAZYq1ICTEhkGV+/veq8W4z5wdl5ydlLyULFJqiQ9mV?=
 =?us-ascii?Q?nh4ezEXwqPZEUQAHBb0/ZSdZr5mmfn8BmYCHLF3KHJ/bEyivPRqAoyqCBIsi?=
 =?us-ascii?Q?1QuXstD0vHEAzIGzAHcAOmUaELu3PFzN9n6zj2sl6xrYp8zcy+rm6HGw7ART?=
 =?us-ascii?Q?qxu7d/t2GfQFTsryPrVUV8HkJ/rrRTf0D77OiewW69QxxGbmzPMWeRdKcvJW?=
 =?us-ascii?Q?CZxryFN+ZVZzmOtBkc7WEs/MkOwJ5nUF4kOgVQClTKd1Oaujx25+8EhP61Ks?=
 =?us-ascii?Q?+Hl0UJGHyv8jdH1RQV7CSdZmH/af5K8TocoVFLMRvEL850a9kmWdVCyXb+XO?=
 =?us-ascii?Q?OODPmpaIMdASQL8QXLn8U+9pe3nHbYxgVdZxEoERR2fctaKhJ8rVyONwHJdb?=
 =?us-ascii?Q?8SaBzfYffShUzpPFEgVfleQ1jgk+6Y/IdVjqSw1sfOqxu/K31ZBbcYtLqCko?=
 =?us-ascii?Q?ccosMba+Ec3Sn2au7KoN7yq04MU7BZyKEbdC90VNRFoVRcFp8Apa7KZCQK0x?=
 =?us-ascii?Q?xaCngAeF6MCoznE1qLUvLe5cXKzZIbjlk/l0cmwqbFF7SzuWNzSpf5hVrS0Z?=
 =?us-ascii?Q?eoq4190XEdSjEmZarPEN/2I2yjzkV6K6OgA0KKC6rawQ1H5PipHQA5BP4R27?=
 =?us-ascii?Q?ueuJCTgWG2BNWMEkuUFTAYN3FLC6Ji6uFCKYA1Qr/aLua7D8/eaRjnJeYGZu?=
 =?us-ascii?Q?K8rYYP5t+6OD6H4u4ik+YK5XddOrLnmP8eNaTSCqicB3LlCWhjGk8DYAO4wG?=
 =?us-ascii?Q?yZyFrCfoPWTop7ukCiZicIenKbfRB69UO/eNIkf9fqT3Ima94/R+Oq396pz6?=
 =?us-ascii?Q?fKQml17z4148Xd+9/5OxJ8HDZ131HIfzcs1dqebvQYfmqkgS4sN1UY9f/btc?=
 =?us-ascii?Q?bZFte4X5lbKPwD1wwiic+G6HqFBkaU1kNrB7WXQOO/M/9/ounKHNJpP8L1MD?=
 =?us-ascii?Q?FhMsUhtobrZHiFP4G9Y0NfWxvGS9FQCT7if0aC1kqhp9ZPqSNGeQuvam/faq?=
 =?us-ascii?Q?bHBF8UAek2wGrk3Mn5WmFKnr5SkuXy7bKNefr6pL1GybXVTAF5DT9cHTsGEa?=
 =?us-ascii?Q?igVv13X3cIJVBi81ld1+Ea/Lesnsp6Smu3OBdETxShZPqYxsjV80TXw53IGc?=
 =?us-ascii?Q?TaOZZbTrPfG7NuHh4ClZhSMIQG/7uL7qhBbxLbwNn/84beFUOn2R0yz7OQIB?=
 =?us-ascii?Q?HmS8Zx0HiTqjXlhY64u1QfbMuKFZL59oaOQtpblxM5M3fZMA6K+OmodDoVpW?=
 =?us-ascii?Q?Z+RDf+6TAOm/D7bjn+Q8E4ieLIs82mR7CBDnp86X0PNJKvPK4bJKSW03DOYh?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb99380-b64a-4a47-a72e-08dd47758d2e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 12:47:16.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyhqtJWVJxZhNK/YGAiSAA2Hy5xYGDvR+FzaulLdNA/SnCrCBSEpH576kyFVcaImeTuO5NcYoWMx/g4uLxDoKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6390
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Feb 2025 12:47:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17175

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The URI path is already unquoted. Remove the unnecessary unquote
function calls for URI path values.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gcp.py  | 2 +-
 lib/bb/fetch2/s3.py   | 2 +-
 lib/bb/fetch2/sftp.py | 2 +-
 lib/bb/fetch2/wget.py | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index 268267b7a..86546d40b 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -46,7 +46,7 @@ class GCP(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D urllib.parse.unquote(ud.basename)
+        ud.localfile =3D ud.basename
=20
     def get_gcp_client(self):
         from google.cloud import storage
diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
index fa5292dfd..22c053813 100644
--- a/lib/bb/fetch2/s3.py
+++ b/lib/bb/fetch2/s3.py
@@ -77,7 +77,7 @@ class S3(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D urllib.parse.unquote(ud.basename)
+        ud.localfile =3D ud.basename
=20
         ud.basecmd =3D d.getVar("FETCHCMD_s3") or "/usr/bin/env aws s3"
=20
diff --git a/lib/bb/fetch2/sftp.py b/lib/bb/fetch2/sftp.py
index 45b6afb4a..bee71a0d0 100644
--- a/lib/bb/fetch2/sftp.py
+++ b/lib/bb/fetch2/sftp.py
@@ -77,7 +77,7 @@ class SFTP(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D urllib.parse.unquote(ud.basename)
+        ud.localfile =3D ud.basename
=20
     def download(self, ud, d):
         """Fetch urls"""
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 7066d5e2c..6cb728ab4 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -78,9 +78,9 @@ class Wget(FetchMethod):
         else:
             ud.basename =3D os.path.basename(ud.path)
=20
-        ud.localfile =3D urllib.parse.unquote(ud.basename)
+        ud.localfile =3D ud.basename
         if not ud.localfile:
-            ud.localfile =3D urllib.parse.unquote(ud.host + ud.path).repla=
ce("/", ".")
+            ud.localfile =3D ud.host + ud.path.replace("/", ".")
=20
         self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wget -=
t 2 -T 100"
=20
--=20
2.39.5


