Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69699CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 07:23:26 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.110])
 by mx.groups.io with SMTP id smtpd.web10.71614.1756797794202570130
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 00:23:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=kBQbD21e;
 spf=pass (domain: weidmueller.com, ip: 52.101.65.110, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAbqnBplvDCd83c0BPe9NuOSaZqyMT0SR7D0nyhb86R8mcIAYf7Z0ACJgmKasCVHbSp8+p410vOkIRZbbao7umT7pFBg3rcaqPU1+mmFKjQE9jjIwBbB3O4vA+8mdZ8bRANRDhrGVYH1iBLq+s7g8Q2oj7I2X+qbj4TLKjY8ep1uGPZRrJeipYT++eF8iFzJ6d/2M6RILxXDW/QVj4w+uq0gvMvBcnQFHhhgFK9bI17Jdf8Um3JqzNpkJGm6jI9oCVfsivkM9ILr6flns0hlrt0qsyAW61nxaAU1qb+2gUKEbaFlKpKHfz0TFbmFcenk83/ilx8pgHk+n4RghZc8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE/v3B0O/XkA4CJmoBvWFdObGQ+zP/Y5F5dbcQWlvgA=;
 b=Xqq6akZCkhTTGHnL9Lz31ArlWPuCreVIAVLSejub+Af/YpCY+D/ocjYtD2970IkwiA6LuoxD7A75uiYJqpXsqIVKMuyOurGtyTBoz4H3tFULFyHy+Hs/+USVflPRQSSdAZddLtBx2p+BfpAUVx9/VKdQL8b2RuvPX5k8jBVBBNXhEdyyDtzqpzRWAfNctB8DLIgJ5t+B6wAitWHmMxB8Yp8dGUjT5458N5McQhgbjn8TaPd028CRo7Fg5+Td982GPe2zKW04ynTvuGao/WTcBTUJ8zDWAEX+4iKpCiUK33YFsDGm1ZXnefoM7Z3+hHmLv+kmPv4aVvaQ3euSjnbNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE/v3B0O/XkA4CJmoBvWFdObGQ+zP/Y5F5dbcQWlvgA=;
 b=kBQbD21eiLl3loROzvdkIbTvAalbcdDU2uninmujYg4G3O5ZVh8zw0j2a6UQ3NbaBT6ZoF36HGvlekIWMKqJOgVOrCIBdwQz2eTDA/9cGTKhkaivp91/E9EAT09raDX9n+0awzzowItUVu3VX9KJxeqeHNLycOFdf4HTQlJLhS2WF5/AZksboUzYqiloEPM7NDrlto5hRi6fC6UyrXqfdaPaEazI0gbdJCwDIQ6zqFEpxD+YjAC41WbWK6VtlxUjOFYWOM7tYzwjYikQ2HnkCgTDhWZcJWNG79NRtRW56HrRNcmgZn/NXaZxWtRX8cay6+vvew3BL9iBwwe/7tQKUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by GVXPR08MB7678.eurprd08.prod.outlook.com (2603:10a6:150:3e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 07:23:10 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 07:23:10 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 6/6] tests: fetch: add test case for gitsm implicit local paths
Date: Tue,  2 Sep 2025 08:55:07 +0200
Message-ID: <20250902065507.35737-7-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::9) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|GVXPR08MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: e4330e9d-5449-4060-f989-08dde9f19205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?amCbgqsZnwocE08mOzTJ0iheOHKv4PgUkhIdUglFJ60IQI/UmKLk9IMAw+tP?=
 =?us-ascii?Q?3BgmcFQGu13nWJyHU2ZiqSjivG5x6FDg60mlzQ4CBaa5c3RpMSH4ZJzJ48+n?=
 =?us-ascii?Q?OH8w0UNUDP3tQ7Jaw83ZU/SYaZfWoM9icR9F7AWHGIA9bXVwMpdbgM8V0LCI?=
 =?us-ascii?Q?E29zUvgbbgh4f/ubs2sX2WsQfJbKg0joM0zMD8gaAZD8faMCU1JSC5TdIPaE?=
 =?us-ascii?Q?YTUvZmQqq6yaFRLKJlhGAB1I7fPMCJpGlseCkPZ89WwBX76Nh2FomCr3OQAK?=
 =?us-ascii?Q?3+vmyUuLXnov8BUn9ew/6GK1qyL7AaEnu/cf9WDPQcU1s8WessGegvhZkzp0?=
 =?us-ascii?Q?fhLwKxnCEDIvKW94dv4hQTaJ0Xx13JN4G20HTIveTi2XVGB4hF+6m3dEhRsT?=
 =?us-ascii?Q?VjoX25j8EeHfHVBtJzujGInO8Vadu0I/jGGqsn07fYRjazQvUH1vvyHh+BTL?=
 =?us-ascii?Q?7uIGH6JaU8isWfXAkvezv00sxNVWTAAug5rhMknXtVnxBo6M6ZiZEH02gMEG?=
 =?us-ascii?Q?RZRTmtuSXtcTXVJfHxLbUWQxdzIPF/hjiPsMksQ9MdP33hOch73r5XLBWbj2?=
 =?us-ascii?Q?vHZJRkWeCIN9/asdurpAn2rviR5sm0bhxXvpa3FC67hKlewunMxR2vJaz6DZ?=
 =?us-ascii?Q?gW9XKGzDRz4vfIU0/X8dTBuUXpgAgZCxZ+gDwqLBtOhL0xgm4KueYNMqbRHj?=
 =?us-ascii?Q?zm8o+TpXqb9iSICGO2ZjoCyIG/80vG6YmhnpHsisjhCnz4KVxsfBxdgk6b3N?=
 =?us-ascii?Q?vAtwTOJ3BwwItQ+X4QXvg1a3uykZN2RnadydkaNSKLt7KZBRYK3NE4uAaqr3?=
 =?us-ascii?Q?ClZW/vQA2Euw8Ng5gMUD0ix7/O5f/FJvovRY6NiGJHdWzjiuaDH/wYV2rpdw?=
 =?us-ascii?Q?hYA5OI+utPYxzhcwW60GKwev/IlCLwIlPJmAO8Uv2WHtlrBrMa8zJy7OQNXK?=
 =?us-ascii?Q?oZdaEpX6Yl0mODi50pWJj7K6R9FFaRmTL/AeTLt+QdaZDGeEt3lv7KAN2HOH?=
 =?us-ascii?Q?HHrOsqxn7NjddZTtm/X7MgOMDu1/PU/tDeIRJJUn4qw8litp6ApSkpuQIFWP?=
 =?us-ascii?Q?Sk4LjxcHFlsHt3a3z7augG3S063bEkG8l6QOVHLLDV2vLHN08DqU6tg5/5qE?=
 =?us-ascii?Q?pM6PSPwCz/olf4av6UPcYl2X5g1Fjd4mzQnhlKUojGbslB8AqSjg57BsStUs?=
 =?us-ascii?Q?cO9AVJUj0iru0evSYEEDWrFc6HNnsuaDEAni0J0g/BEYUU0COkW0Nt16D6/N?=
 =?us-ascii?Q?diqkV5DKocAn5gDd2YUunRz/c6etMk3FY0FqzSo4Tdj8O4gVLAoH3zDTuJnH?=
 =?us-ascii?Q?yOLbi1Gg0xAzYhCrdk+/2HVPbG+oHjjlATTWIYkXyLJ4r/vQrOWGCSsLHuar?=
 =?us-ascii?Q?txWDas41a4Ai9GXsrnE8QAHcu0OcDCU/TKxRrs74YHH8dmMYOK3Fdy1Mv0y6?=
 =?us-ascii?Q?J7xONFmZrM8UiHaQGPIkb1cI3f/g/pH1aqmqA1P3m74ErTn5loAKZw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hjoK2zfnalKGsndFsJrGdf2nfeh8ysDJcerrdWQPqk9glkrVdS9CHcSKwXq8?=
 =?us-ascii?Q?U3R2awU4foroGy+duXjOSG7+eqSwMduqwaFC8lkqBV2yXLyuAAQssmIramg3?=
 =?us-ascii?Q?sPh5+emKLgLqOA446RS5yb67uMTUr1PLF/vjabU56hEoVSOUjjCq5Mh+rpAD?=
 =?us-ascii?Q?CWUY9Q7X1G1VswzMXuzmNEnKJy3xnqjV0Kaphn9wnpbT3TZkkFDw6P6JhmMt?=
 =?us-ascii?Q?cda7/FJFPnOXgjogodDVzCTLBcwBXeooWVozctK67Tn/ZQbUgfTvuz8OrNiP?=
 =?us-ascii?Q?xqGR0CodwY6sb8g5RXaDz6nszFcq2fNb2It1q0EXg/XbiZWNroHGdlJ5oa/H?=
 =?us-ascii?Q?UVfP4oYUZSu5nW/OEfzFz0DVbCUT9LsmN8r+kdmpBF6Bs1rgywAMiwTk9EvT?=
 =?us-ascii?Q?AtsYCeJhioBlf8m9MRrky77tl44t1DnjPMS7gCmenyPUqu7i6kCP91kAVN10?=
 =?us-ascii?Q?T/mTMsgLtbxGwTWUpxhusdfWNX4kdsHvXMwUReVSlU0ZR8rD6r/XEtiA+wQB?=
 =?us-ascii?Q?AKey4AyeAY/tKoZIbMesr0uEfkD2aED3qwiURO2vd9IP+OtVyZcNbduN4Rgl?=
 =?us-ascii?Q?1xEWAXvfjywIdSKlcHxMOKnZHeyl2nyo6L+zdk0t8ufsHJWqiMUd4r8/MHoe?=
 =?us-ascii?Q?unajjC19wac75/Zt9j4Yn82qQ0Xc0KJd7cfGg4U5bnY0cSkeTa+xUU1Ij44c?=
 =?us-ascii?Q?SW1K4gcWqilLYJr1RzpOlcMyrbC81Jk+NUESQi8kDkpBYWLko6XFf8qEdflv?=
 =?us-ascii?Q?BVJz7E7eUH64ws3ug7SWOQ/67DebnfhhDkAxR6hNQKYb6DfgZe7FkpvA39nM?=
 =?us-ascii?Q?vWRRIDU3i9QuMM1jpZqaRfLVzH1krPTBUqdsnAfP7R+dAbrcPMwmSKjblWaR?=
 =?us-ascii?Q?CUEskTT2RZNLSeRnscYa4V4xXn1BADmwX8wtMXirRzKCx5PmMZG+B2Iol6hk?=
 =?us-ascii?Q?+n24j8ff60A5ZpCICM5fH2CFaxKytZ0d9cABr2i0+98F0sA0FntLf/JZD4D/?=
 =?us-ascii?Q?bSBn5MXnht1zm0qe64m6u+o/aj9GMZyfsq95ycrjtzLoTVYQ4YcP1IFhUhlN?=
 =?us-ascii?Q?HhAzwJb3Ouzbr0tp2WcYno9UMeTsnJJF2uc6XQVhKb3vqBosDL9HHiXaHX4j?=
 =?us-ascii?Q?Swrf2egvCIMgnfborVPfb8W1mVOioN4tGAvNtOo3EDqrhGD1pInna2vSSUgN?=
 =?us-ascii?Q?wxzSszHt+K0j51f0/78GwNTiKCF9M6+dHwe9bPNaqFTGICKBHfoyyX2CZF+x?=
 =?us-ascii?Q?7f7O2F0bJd6GO8fKlq8re9LC3Jrpr5XY78jluzvKD5CxYS1OXtrOR797ZduX?=
 =?us-ascii?Q?mUj9tjKooDk3+D96Te41pwtAEL7x0Klaf+SlJelYPuZ7ZBP5y8uOjOX1Vjvi?=
 =?us-ascii?Q?55b6vt6gocb9kaX8P4nxQoB55aRGXUacN+/VV/4JWdoqijNRlNwe+Xtof0oc?=
 =?us-ascii?Q?mkVDH7svOLtkYxJ3mpjaqEH23J1CcsH+cuw8hyVs+c/5j8Xxi5joNCVvj5C1?=
 =?us-ascii?Q?tYBAYY73KiK/yKkqJTjSuQeaU4NmXnpE1L0jqXgB54/sHR8kH9sJz7i66pJZ?=
 =?us-ascii?Q?o8hKQaKag8mStaAs2TWivmBEk5ec4NufMRiTvHBcHFaVkpdV8dISgVqpo+bS?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4330e9d-5449-4060-f989-08dde9f19205
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 07:23:10.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Kg7o6lAqzd0OfEEPAUeSvnCqJDwtgUmF3vJRNxqNL/2wz1B34JoNVZiyvePE6fdlNiG4B888SDKpHXSNfcW5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7678
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 07:23:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17941

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6067b02d2..e181a9a2a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3818,3 +3818,15 @@ class LocalPathsTest(FetcherTest):
         }
         fetcher =3D bb.fetch2.Fetch(localpaths.keys(), self.d)
         self.assertEqual(fetcher.localpaths(), list(localpaths.values()))
+
+    def test_git_submodule_CLI11(self):
+        url =3D "gitsm://github.com/CLIUtils/CLI11;protocol=3Dhttps;rev=3D=
bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=3Dmain"
+        localpaths =3D [
+            f"{self.dldir}/git2/github.com.CLIUtils.CLI11",
+            f"{self.dldir}/git2/github.com.google.googletest.git",
+            f"{self.dldir}/git2/github.com.arsenm.sanitizers-cmake",
+            f"{self.dldir}/git2/github.com.nlohmann.json.git"
+        ]
+        fetcher =3D bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        self.assertEqual(fetcher.localpaths(), localpaths)
--=20
2.39.5


