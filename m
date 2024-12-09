Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A417E77180
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 10:32:31 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.108])
 by mx.groups.io with SMTP id smtpd.web11.98025.1733740340477353303
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Dec 2024 02:32:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=PA0NEwNF;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.108, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGaAth8D+l5Tu7UkdCUrDNNimAKhga/US5Ici1zjOSA3gGHHJVwIHx9b1Ou88MpBUwi39fNil2tZdmsEtYEdXliiuLybYB6BpKg1+EX54nJGktv7+dm10BzyFZlNrqTQ1aRRPcgtjCKuEGnXECp3SuyJF4yUcMpi/XydFnAer66JjK6zmffwyOfDDxrrBXEiNGkG5xrteLocDc2cRE/OaHqfIrnCqnYLwmvUDU9TopwKqYE61v7RW3RFPGKlrmclUEPNhtBlsIP1r54LfkJ8+QRx6F0qe5U8E+RhXvJ0HNINCfdrv4Ss4sWSyQWiX6GbR++bxdQs+Q4m/rvih858Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mblQIwKid27UqOCLTUN4f5pe9qZRosvcI/KOOFDQGyI=;
 b=wmGxuielDIzr8I7EvnQRM8SuYwefOwauMMNCHhg7vrkgzOCYR2j3ck/ARfPJ+xlPHSqYc0UBs5HvYZ5vP8NN3v7uQNQngulas0H9njkQPgiboEM4H2ZGcZ7TAufLnAli57GoMEHnhFOIiupktwbpYqRWVDD/fu6bUbg3nY8SohK+4//N+P1fwXVye2XyXRxSC8F9pnM2+F2SvZ13I4051SqkNEvdnBf1w+wO+i5JYObMfNS++2xXWR2q6mJOzUNdtpy0eiRkHdaqwIDu/6EuLMTX014C/36gzY68FOASjFPkNGmZEFip3vwN8DdwoRmylBjF/L+ZAdon/ycQ01eZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mblQIwKid27UqOCLTUN4f5pe9qZRosvcI/KOOFDQGyI=;
 b=PA0NEwNFTpHnYiDmpwuUQI4zT9AH1LJ3ZxIiH3+VGUB2XO32q4euqLVfZ9ludWfzseXdYOFm0Oz0jYnkvEMzShY+S2xLo4KSlRX16pwMWF6aEdzuv2e8PD8hZx2NKAv9k2Myim0Yw5PiRm+19xV5PsDgiRdxgb1eY/ChMtrEj5yszqY+iEe2JQAJSdmeGgsMaUqKJBnKo6djr9xhzx69Nn90wDUqvyxDvGVxPFmdbadO6uP5EuvRu/tb+bcM5URyBY1+uDCFZgona15DOHKh8M59pz/f02SThJRdROtx8w4vSiUhX42lQaVbb8q9tNa96BtGGT4eRkTZD3TmvxJmig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AS2PR08MB8384.eurprd08.prod.outlook.com (2603:10a6:20b:55b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 10:32:16 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:32:16 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 1/4] tests: fetch: adapt npmsw tests to fixed unpack behavior
Date: Mon,  9 Dec 2024 11:31:55 +0100
Message-ID: <20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AS2PR08MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f2ca44-7a5a-414f-2f36-08dd183cc09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KgR8Y6gawTgtUTs3CFWrsUCDIacszjBmO4KJ+2+YbVTj9plsdTZI28JIDxaV?=
 =?us-ascii?Q?LE/PKcAOSYexQda5excQjtaE6hKmzjvYMWJkFkUTsoRwND1g8C17eIB+sxb2?=
 =?us-ascii?Q?tiffQb/s9uVlMCaNEjNXVmlcE4GGx0cMIMiMK0/9yB0mzk1DwBVbPhI3G+qw?=
 =?us-ascii?Q?hzvuTQc1y5xVxy4NVHd9abcj/Fx7JONpPe5ezL15ukyju3av94PY37qnBEQT?=
 =?us-ascii?Q?DD3wP1yKtQlGjnUZcU2ZOlGDLIlYxzDqoIrv0CviIr8djy6NLHom5VqJEbVT?=
 =?us-ascii?Q?ErnBo4clbaTjVtWJrdSoRnqd6rXRvS2xEvVILjW82MRpI+04tUlKOMzFKnM3?=
 =?us-ascii?Q?t98Oomu6YU8DKT4UZHsxOa++J/rwThYp0jGwwxYh0w1FV/q9is61UMm9haPa?=
 =?us-ascii?Q?u+uoCev6sYJcvn5War0NcZdTS9ziC/HnL7gtRVNIprk9CLv4qo1EY1ChwSkQ?=
 =?us-ascii?Q?5bhwIe1eL6KJT+hDBkmoTleW06gWX7SlRjEJl4KbnhO7bOrNHXGnKmzKvVUW?=
 =?us-ascii?Q?kZbzn0jt1QZGJBOizUk3IEb/U+kxz5UaLLn2+DjN1j3uVtHbuM26mzUn341d?=
 =?us-ascii?Q?N5T1De+BIR6bPPK+LjlXsy1ovSTk2d7OOcTE8QQLWkLNneNKOhunLZp+8xYU?=
 =?us-ascii?Q?udNGMpPmWS9vwcEL7qZxUCpDtwMFbSwFdwwTK/Hv0w3nhrh8UemJ5Qpgr4BD?=
 =?us-ascii?Q?gIpXWQVfvWBPzHfB5xg3zopX9ObE4C3s8LBhYA/CPFOX7TXSFgwQZnbhJpKk?=
 =?us-ascii?Q?gW29tOHyzUlqj9ePEOaO4+LBC4an3dkoOupNme/W4tFqY0R8GFewS1Wnj6wJ?=
 =?us-ascii?Q?ZejOUa283Gbcz4dxivBL5yadHKGUZrTjKxrHJkn7hOeYzQzD9tWXcsE2Su7U?=
 =?us-ascii?Q?b4s+G+b3iOjuvGTA6F+2R0asEBAVViX2HNkuRdqPUEDNNkP3SQN2s7wftIAF?=
 =?us-ascii?Q?G6qcZfY9p2FglGK3KFPuNAGXLKp30++0Jmb8XBDkEU14eks+8N3Xnw3dFw8Y?=
 =?us-ascii?Q?wKxceUWEzH0V7DajJXyt/LuVSbKLRGQ1xESmMlHeMZky4Tx2jDPDt3JZ4NYe?=
 =?us-ascii?Q?+EgmEZCLCCOgc1eaopo2KTbcE07ZRZCjWWnfv9+p83Be7O+HPDdatvNbR++W?=
 =?us-ascii?Q?JJk6NNLgk9hllDx6IxviK41o8ZGqBVKKTib+lNsf3OJK+AAuwJueCGjCT2fu?=
 =?us-ascii?Q?cDIaJLvZENuNZBNOAgaY7v5dVf9aPQ5Fcs5pccr6HnaRohqKGlX2TvmJOZSc?=
 =?us-ascii?Q?6MMgeL2B/l8MdJMrgrTL1yXW6eW0EwICeM9jIBV1/EdQtVMQMLhDRYcqG2C4?=
 =?us-ascii?Q?rZJcu0xBcae0VijXX9AGdBESVE1YGKWF7n9iVG70/OWELrpNiBKx7PjmrC1r?=
 =?us-ascii?Q?sFtapGYCXbh/7E73svesDYqlOpBJvAgVblVqmKEQK1ZAyuCVNA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8VmYfPXnsPHt16l47guIevNhmfuu7qu0PfnaBsQZM1UckK1mCjKDckn1uXhs?=
 =?us-ascii?Q?q/riBPJtBoy2IF4IVI+Gj81bKDndRdkNtGCOCp6o30iQ0duKYiUlhNc2/XXL?=
 =?us-ascii?Q?nyCuSV/MLz4LWYtaXkhXqhSFWOFe1Hl9mfhEdj5R36PIxAAmdK8oMBcbjj/T?=
 =?us-ascii?Q?TqFW9VbTjKIuPw7nTiiGhopJEJ6OvL27Q4I1hcCxSrF2nY0g2opGFMyZU9U5?=
 =?us-ascii?Q?rxdVWMqhg+wnwBXZfz9Js1+WiZaqvPCR4MJAWGcEzQFIe1SxKck2NFw1HrDB?=
 =?us-ascii?Q?oTHv/Zjs7qsFrpI0SOfs4NUu/Q9lI4/WML3oYrO3Py/8BWBUUhmHMw4mlPhn?=
 =?us-ascii?Q?VNKxwyqImZAeIit2mEp2D+yvfa5Vf7uJBydTHNTRPMd7jMIXY/pez+eTVySc?=
 =?us-ascii?Q?wAVTBMr7iNteTrgITHw+M7ZFgF0N05zPeCsWOlWS9JzCVksB4tQl1Mlqc1Gq?=
 =?us-ascii?Q?yz/zurqadTJSWpbgeqGm9tbwsLx9sKTehOy9hBEzp2MMnZUlkUZ7Tz3yc+NE?=
 =?us-ascii?Q?/uK112kDy0EqEy+M9dpjngG4hGWRXBPjk+0yxUT0VaiHOFJ7fg2bLzdMRmIM?=
 =?us-ascii?Q?wL+1C5y2XK5vcoKWMnDH0IOmjDG8J110V6nIx6DRyeozwjxxFfdMxeMUEBHT?=
 =?us-ascii?Q?0RwxMSrmBxhlK9cgy4V941MmTw50yddHrLQPWQ+VHUH4qIfcKTwUU8ounhix?=
 =?us-ascii?Q?H4352YcNiX6g1ocmYv4pXFp834xKlAqWITEqHlWc7w2DqFavDiHxDL6iP8O4?=
 =?us-ascii?Q?YkQTMqnGYcKq188LjY4PcARbUCLfEXm+ld4L4FncqnZImsDZ1xlFyh5ecemV?=
 =?us-ascii?Q?Hn0J95vrhFwJGCrXpFtZmCsXF5EMzeK7NVVsR+rQwC/25KPHiBLdJTc6kik/?=
 =?us-ascii?Q?I4G29CVaaPrz31+zCBGQzLj27WxhCxuoBR/Z5ujXg5t69qifi6NgVYlQueRe?=
 =?us-ascii?Q?M9wH4KziOvpHnARyjVutLXqsQ0kJpD0umUc3CPz4ws308Cud/UF8jFa2b/He?=
 =?us-ascii?Q?FCB7fcjfDWR0QvOWpXqpv0+XfIGk8pTw9g4wvYZuJBhVdWeqmfHRgjqaNfHn?=
 =?us-ascii?Q?grqOOyI09Fe2wVOq3AN/uu+sta13cuTMSdBp6SDil8xW//ROlM7hDKTZgFyJ?=
 =?us-ascii?Q?Tvu0Ktp6AQu4S4eF6HOkO4DUWK7pqTOO62xnk0TRSs99zTD33opPGtjRsFSZ?=
 =?us-ascii?Q?agQYsTXi3wGS0tl9ZV3JshYDqddm0aVfQlTHxWswjoUyrPtmGPD+VKoywTo5?=
 =?us-ascii?Q?+xjiM+W4JMZ6moUfFR9Bxjl4tcYlqA2CERYsfKJPTsQJ+R6iqvFLHXZJkS50?=
 =?us-ascii?Q?RQQ0Md5YjpnV2/KX6a1T/MtKLy0GdFkWA7J4QSbm4e5GJre1l8DhwPpPY3He?=
 =?us-ascii?Q?Nb0tmMAD7EPLMyszmU57Y6C2wIrkmwyt1XzBz2ARqRSfOZ32cfmd4JJA/I4+?=
 =?us-ascii?Q?1eR3YHtwuM1vXzuAYh+wZc0qNFs+gtMDbxSuxnAXg0XdBoxBScCwYKgaku3E?=
 =?us-ascii?Q?904h+AN9xlhFDbw9/7ImlX5Y8H4iLvN1dYpXNQ921U1uU4v3saHFxNkQyC7Q?=
 =?us-ascii?Q?6CTUzSUYF7jnGYTTZIkxcxSQgMHwhCRttvFr1iXr9fepzxXagi2zUftaW8jb?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f2ca44-7a5a-414f-2f36-08dd183cc09c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:32:16.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grjoCQZX9dOv4Qy8c5gBEiEoW+I98WIAE9/xqy5d5XgMwC28l2iy5CRYQ+zXCeG9YlX+fifTUzMFV+bewRVILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8384
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Dec 2024 10:32:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16893

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Adapt the npmsw tests to commit 84f102954e10 ("fetch/npmsw: The fetcher
shouldn't have any knowledge of S").

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 363f3a218..01ca80724 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2838,9 +2838,6 @@ class NPMTest(FetcherTest):
         bb.utils.mkdirhier(datadir)
         with open(swfile, 'w') as f:
             json.dump(data, f)
-        # Also configure the S directory
-        self.sdir =3D os.path.join(self.unpackdir, 'S')
-        self.d.setVar('S', self.sdir)
         return swfile
=20
     @skipIfNoNpm()
@@ -2873,10 +2870,10 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'c=
ontent-type-1.0.4.tgz')))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'g=
ithub.com.jshttp.cookie.git')))
         fetcher.unpack(self.unpackdir)
-        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'npm-shrink=
wrap.json')))
-        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_modul=
es', 'array-flatten', 'package.json')))
-        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_modul=
es', 'array-flatten', 'node_modules', 'content-type', 'package.json')))
-        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_modul=
es', 'array-flatten', 'node_modules', 'content-type', 'node_modules', 'cook=
ie', 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm-s=
hrinkwrap.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'node_modules', 'content-type', 'package.json'))=
)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'node_modules', 'content-type', 'node_modules', =
'cookie', 'package.json')))
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
@@ -2999,7 +2996,7 @@ class NPMTest(FetcherTest):
         fetcher =3D bb.fetch.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-        self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_modul=
es', 'array-flatten', 'package.json')))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_=
modules', 'array-flatten', 'package.json')))
=20
     @skipIfNoNpm()
     @skipIfNoNetwork()
--=20
2.39.5


