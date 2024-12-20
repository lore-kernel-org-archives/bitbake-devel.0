Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCC2C3DA4A
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.114])
 by mx.groups.io with SMTP id smtpd.web11.149745.1734693993938884026
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=NTrdkvnI;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.114, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXlUIjGP2ZyO+zSLq0on+K2zqRZL96k2VR+OR+oFNXn7K4iAPnBUAV8+UR4gv9X05oXCn29c94Ma9YQCPKDG7nnwZ83M4J7CV0sGQQNMnJz5COU/eS/QBZCFXkiuMP9iCFizVJA1D3cLi18cvr1xuyYJoYlBO5vT17dD+5pKdHn95bUpwIigevpj0liCJWeQvt783ZaxB2a8BxgxBCzRc7g7FuKEI1hBMKKJCNsDEhqQn4A77wGUIHn76mIOGNv9Jn0pI63fpmkYkdLZLfAZzMzBlB7USoVFEcR48yCQweD/VymA8UUudSon0VAQ1epyekAYz8KNmYMhg5mSOZwiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLENERgwmHO7EYBIoxAN9UBOjHA8RShHsMMjX0MMi1A=;
 b=o7LZc3E4EXKREJ+C4fVe2bNNwWWAiDt6cgQm/3Tr4ZKIBiJnsZxXOi6VJQzW/qOj/YeHBmBl8uhxhGeQeKUYs7GStxSes5RmgdtlGJBAYXOjJ8J39eR2qgAEkZMX5GXKoLCZe5oxQ9QtVsMxp9b6vFYoLdGf45ED5Lrzd+5R3P8Bpop3j/GC6qN0WG10FZwEsDMhMoFJFTxNG9h/XwtjKTM5a9KT0RYwQtz5PGYZ7oEV0gtNI4xGy8QktGR9eJCysytsPXZciPVw2rXmZVC1SA6sQdObL3/i6JtlZ7lkcEBpwgWyXE6pESFSu8NlI9HmJ/cmApmszpZWkMJQq5Bqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLENERgwmHO7EYBIoxAN9UBOjHA8RShHsMMjX0MMi1A=;
 b=NTrdkvnIyysR4PEliaM06auU36+y2BvftokwUJq2s4gIGwBnLzHCA0xbzIj/AecV/45Of6B5xVhgJ82gqhs4k/4kpMdVL7tpo+oP8CMmKgQTsmQSMf/GfDYZAEXrnz7PkwXvTpRlsjSRuVVn+kwg3IuUsa5auHty9zZ0Q7QJ3ZUNbYQmEW9/02lEwZ9PeArBGb92YV64a9YXZ8dGRI8GWdRKBoN874MfPzPFVDFLLskHVn6JrgXDlPnlcgnp0lV36wBhI7/cq96/TajnXJhnc3kL1JwoXtPy5+VH3T5Nmq+mni8hA66/6L1zowJX4SnD4vtHi608FcSU4LdKteBzjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by AM8PR08MB5684.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 11:26:31 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:31 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 19/21] tests: fetch: add test cases for gosum
Date: Fri, 20 Dec 2024 12:26:10 +0100
Message-ID: <20241220112613.22647-20-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|AM8PR08MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 238f62ed-c9e3-4a4c-964e-08dd20e92683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2alrcqpwAHmOyeKcHUxyRwBl372NEK0TeC5RTzBPz0/+wWtb0vOSVdN6zeqV?=
 =?us-ascii?Q?DvcN/VsvrFiRdB7crvqsmjVtZ/kK5O2WA+J64jO3NoDoOwIecP6AtFqgxOaK?=
 =?us-ascii?Q?It2zgfSvuffi6dc59cOgS3IimVk0LarQPKDH7Se5dAH3ULeauVaQh/c/orti?=
 =?us-ascii?Q?CM9SYc6gvO1Tf4rLFZrpqrMComN+MJ+2hmDu1n2z8MrAS8MVjzKEQ3OaVHUL?=
 =?us-ascii?Q?3oTh2RFtB5gdDCCa2LUwN03FG3h7J1xUsAH6i6ZVlKJO4Xk5cyNkRWQXXR+b?=
 =?us-ascii?Q?8kziSyoE2QR2IjHWi8zua/4t/07S4io6W0dXc+otcc1YztUhP42y70jpTqcn?=
 =?us-ascii?Q?4/A/h4e/DoX7p75tUtLglaBlWPDBmmjBJw2ytbm32nKXlpnu5+4S410YpfD9?=
 =?us-ascii?Q?AtEhPF+qeWTee1jolDDjT8UG5ZNeHkN2jsW3QA1JsoeEekG/tgUH62f7x4mT?=
 =?us-ascii?Q?1iicAcTOw5TjfJSiA54bC8bzLJ30lzA2DrDOlDCuD+bUHr1pq1w1sELxlHkl?=
 =?us-ascii?Q?FRSiw0pwJkFmdtGsRCoVpSE6O+SxvdUyqUc4fHega9KcmpUPjX2/8EcG5B+V?=
 =?us-ascii?Q?dF0yr2q9MmxtAI5qIn33uSYAlZqlaDpV7vWJfnlkbS/3PcFCu+SN3J0/LHQI?=
 =?us-ascii?Q?hJgQQxCDoMAnLJf0T5MC1P387MSey+FNv6X8pEhkRFId72VPFNxu/MicLl6V?=
 =?us-ascii?Q?Q23AO6FddmSNS99ncy/654gsTE72c/eIkBcny754/Czcxj3xgWzi5eP6XbC1?=
 =?us-ascii?Q?1yvI03ELm3ZJa49NMGRjRhe+sXq1IckqmFS4p6Dna2u678uloWLttUpUqUfW?=
 =?us-ascii?Q?xxjNFurcU9gMnO7fQX4cxyA9cDwnYo7jJqk+Bq/GTi/6Jl3cyeVCRET+W1r5?=
 =?us-ascii?Q?vG6W6/0lwxk103vOSgAB2KfA6JJjSolj+rpGOWxaDDW7zhlmnRdE99F7XkE4?=
 =?us-ascii?Q?QrjFb/tVeiqJsgxN/tzUKBd40T4Zv9j5rCfDzcWzcH/9nZMcPnaNNfVgUkH0?=
 =?us-ascii?Q?DLEbkoVNi0efw1mbiBQcwdiGg8tD0wwDmSLfgOyYa43NJH/xGvWndmyceR3k?=
 =?us-ascii?Q?zHDaTGJmVIFERvC8SrBNxVvW/6hj+EZm3Zd4FZhVtrVTeJ4KUkhMt/EJjoR6?=
 =?us-ascii?Q?qq1e4GqkpHAvA7pMgnahTgN61jzxqLgN+eg8W7v9zoMWyGGds3+pU1c/Rrkt?=
 =?us-ascii?Q?MUzACVuiw8O7HURQA0rPMPgIRYEvGS79+IZ0sI2zPpjvgVGlcUoHScH4JM4X?=
 =?us-ascii?Q?BBNQhqQsTV48qz4ZbZQcurHEdTk6otywTGwwTXpzJP5trcVhwYNsQqO9uiSC?=
 =?us-ascii?Q?dtiuRZDKvC45MpQ3pJKan3y+Nlid8vhgdKOKXRTf/beBKOmntL4BMG9V4H89?=
 =?us-ascii?Q?yNXUK+yFGYGSPA+t1ogDGTcS6AsD8hdz5dPh268Xqdulc2nbAg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fWgw/y5eV4jeiR6Bnmev0xaM8U6/dV8IJfL8Dfbd21t1eptKONK1qdXO6m+s?=
 =?us-ascii?Q?HWunxwmlWVj2aWUrMcsuF6jFr9fNVKnup/vYF7NRRll3z46GXk0uc4A6zuFG?=
 =?us-ascii?Q?oGzldYneCFEAEGTqUbdL7n+dvD1ZEt2hbLoe23qUBofnmBv/VxjJ8kOT0Ye1?=
 =?us-ascii?Q?+n5mQ3TJM9NGySMYGTNlXAWdFMZ/GNDbeIzCPncBEe3fbSOv5Dteh6Yz2HrN?=
 =?us-ascii?Q?8JVcP7dalCzrzydFmZKRgDlaY2e0uMrbfW3DgAEDUFh+MMBI+9+BBPpQIU9y?=
 =?us-ascii?Q?Th4uO1by7CP/G+rE4gNYnsF0DqwBMX3acOmfle16a7aHyoSQyqsCgC1XGQSi?=
 =?us-ascii?Q?2D6fK5TdEX2ydSEIsP1tjzad7ggJO8ZkqvCpqnhK8bUAYk1OEvGMVZzEax00?=
 =?us-ascii?Q?qe5zkkjBGG2j8llSiT2azffv0ZKbMK7ySXlumR8l9Q+PKFpOEabHyQTyLtzq?=
 =?us-ascii?Q?q+0JiCUVRJVTsZazSQ2x8x2sD/0eZ5+p4sUmL6hceZyv3J3B2XQbgaxyvtTK?=
 =?us-ascii?Q?X9CGSLsRBHhacFrfaHmVy2bEF7DGdQ7XOfJga0iidpDbqUNWsN4ptb5Nz5XC?=
 =?us-ascii?Q?wPNJaA9YWfTAdyRcYL+ZqJOyOwlx2rSMmSCf2lciUvS3TXQ8e5OeuvrV2aod?=
 =?us-ascii?Q?dCKg6icq4HVjnIpSjTSFQZzm+XVfWIUVU5xMROr5olqcWIlTSBBATJRhvGVo?=
 =?us-ascii?Q?rTFi3Hoi045Voi9Q1yQEE+pUWbNNpVWgc0I2LJLtWM+XEYF/JRTBLoCRPP9C?=
 =?us-ascii?Q?8p6Bh8X18UVPFDYKv8bkaQ45NkNPvZ5Ump8qtloom1zOKGNti89Cf/kvacNJ?=
 =?us-ascii?Q?MYrL8J75reKed6NEJwlQtLLIO9dKrETCe/UGWEnt3mJaDvf2Q3OFMAZoe6H0?=
 =?us-ascii?Q?h+zNANoUazJjd6iHS6O+/ScxfOKlrlZq31DCzwqLL6yEfRHBTeWhxIvIfYw1?=
 =?us-ascii?Q?Owz2u26xaZ3VrzDdEY4y8+o82u9owKQIdsmIHfj2zh9JNsZpmeeYzsTuYUIm?=
 =?us-ascii?Q?gQl/q7/ka7Dg0M2eYTbWDYybMfdxOAxmaPGtbeQjDtnmF5MC3oShT7XkV59r?=
 =?us-ascii?Q?DFjQXW02IzD1F4lC76ywqiI/STXxhZPWMNR3Ry98QRv7lBlQHsJvEf2XvyV+?=
 =?us-ascii?Q?JaOT7KLdFot/OF2Yuc1Uz97IYj5M3XX4gPYfgBOsDG2gcDapSojdyQ9h3zUG?=
 =?us-ascii?Q?Wb8Cfqph3TTsd1tIUgi1oaHYZn3XKp8SXPGrpmIiUh9aszZL2rR4kjUAbWEW?=
 =?us-ascii?Q?2ltftxqYq22gcIE4ajdxyBunWuBdN0Y5Dybwc4swEqWxxJKeh5Vi+u5Yd4V6?=
 =?us-ascii?Q?n1V2g0iSjllHpfLm6tQP80jQ/S0LCT5JUjD2f1yaInkkvfq38h2f2vt2fEY/?=
 =?us-ascii?Q?bJqjc8MtWVMG9UqI17Rd3A7YXbcTeM5jkWkOKZ6HnCzkaHmsZFRauaxjBYs2?=
 =?us-ascii?Q?WElkRDj4eWhiVaxyII4J/7cg4ee8jbZqPr7A6G7ne5CW+neQrOiUKe7YEhQS?=
 =?us-ascii?Q?G0qMGiNdOXI39nIo7yr83D84XoFACLBNGWfaueo1NKURgwNmHMRA3vHgZFVD?=
 =?us-ascii?Q?HWIFdUCUmZJol+sDD23W1XyMavoydtYSUdvsvK3f2K0yj3V6sgtfhsqY1JSi?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238f62ed-c9e3-4a4c-964e-08dd20e92683
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:30.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krhEqhsGFuOs0+3lJWYyXwodt/ohXCBxO2iOpQGkXALV9iRV1XROCq2M8Zjel3YO+AYBFzL2FHx/nN+XUj1CTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5684
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16939

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/tests/fetch.py | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 437571f1c..30c821a67 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3439,3 +3439,59 @@ class DependencyTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "dummy=
/dummy.txt")))
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "dummy=
/bitbake-1.0")))
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "dummy=
/git")))
+
+class GoSumTest(FetcherTest):
+    def setUp(self):
+        super().setUp()
+        self.localsrcdir =3D os.path.join(self.tempdir, 'localsrc')
+        os.makedirs(self.localsrcdir)
+        self.d.setVar("FILESPATH", self.localsrcdir)
+
+    def create_go_sum_file(self, data):
+        filename =3D "go.sum"
+        with open(os.path.join(self.localsrcdir, filename), 'w') as f:
+            for module_path, version, hash in data:
+                f.write(f"{module_path} {version} {hash}\n")
+        return filename
+
+    @skipIfNoNetwork()
+    def test_gosum(self):
+        filename =3D self.create_go_sum_file([
+            (
+                "github.com/Azure/azure-sdk-for-go/sdk/storage/azblob",
+                "v1.0.0",
+                "h1:u/LLAOFgsMv7HmNL4Qufg58y+qElGOt5qv0z1mURkRY=3D"
+            ), (
+                "gopkg.in/ini.v1",
+                "v1.67.0/go.mod",
+                "h1:pNLf8WUiyNEtQjuu5G5vTm06TEv9tsIgeAvK8hOrP4k=3D"
+            )
+        ])
+        fetcher =3D bb.fetch.Fetch(["gosum://" + filename], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "github.co=
m/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "github.co=
m/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/v1.0.0.zip.done")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "gopkg.in/=
ini.v1/@v/v1.67.0.mod")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "gopkg.in/=
ini.v1/@v/v1.67.0.mod.done")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "go.su=
m")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "pkg/m=
od/cache/download/github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/=
v1.0.0.zip")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "pkg/m=
od/cache/download/github.com/!azure/azure-sdk-for-go/sdk/storage/azblob/@v/=
v1.0.0.mod")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "pkg/m=
od/cache/download/gopkg.in/ini.v1/@v/v1.67.0.mod")))
+
+    @skipIfNoNetwork()
+    def test_gosum_git(self):
+        urls =3D [
+            "gosum+git://github.com/Azure/azure-sdk-for-go.git;protocol=3D=
https;"
+            "nobranch=3D1;subpath=3Dsdk/storage/azblob;"
+            "rev=3Dec928e0ed34db682b3f783d3739d1c538142e0c3"
+        ]
+        fetcher =3D bb.fetch.Fetch(urls, self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "git2/gith=
ub.com.Azure.azure-sdk-for-go.git")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "golang.or=
g/x/net/@v/v0.0.0-20220425223048-2871e0cb64e4.zip")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "golang.or=
g/x/net/@v/v0.0.0-20220425223048-2871e0cb64e4.zip.done")))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "azblo=
b/go.sum")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "azblo=
b/pkg/mod/cache/download/golang.org/x/net/@v/v0.0.0-20220425223048-2871e0cb=
64e4.zip")))
+        self.assertTrue(os.path.exists(os.path.join(self.unpackdir, "azblo=
b/pkg/mod/cache/download/golang.org/x/net/@v/v0.0.0-20220425223048-2871e0cb=
64e4.mod")))
--=20
2.39.5


