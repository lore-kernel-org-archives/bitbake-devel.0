Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13746CF9C6E
	for <webhook@archiver.kernel.org>; Sat, 21 Sep 2024 12:09:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.55])
 by mx.groups.io with SMTP id smtpd.web11.8496.1726920588726382491
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Sep 2024 05:09:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=Exll/P0Q;
 spf=pass (domain: outlook.com, ip: 40.92.90.55, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOIJs2uWFg1tc8jzLCiI2k2rpcvMDSfUDJ4UfiUH4IvzowU8GEBEdVWnRTCNC2Y0ScKAyqXI3/D3mHzle0Ht+4W6zzlDntQfs3fdq1L1axzIb0Wc6mas8BQ8zYzzmQyn6sPWgR2EVt+WACQXKlR1YW1ZTYUuG60QtyAJdF6DJxN01on1YnqvM473EEyCH2uedsJ/2sNIsKWsg9Byy+EEKFMs7P9nRnUbuNCcY13bMKK8f1rEQ++tMPDHkePbl7jPtQdlcMdzsh8m2OrMC89GDDUkYfWWNnGaxAgQWET2gbPJqCTaekj+CiAiOQ0VEexFd2h9Zs9sjMw8NeZX/GLNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emNytj/93dcyFXYKBzRxfKvnYLGYIv1ZOkilJak4h4s=;
 b=SnFqSgeBttGhHmJk/NdXImD9mQWHvK28BgQ2vzjcqVX6TQMAKPG2/VhbWpZtkUZqZ3pCJsumHlTaHzm+b3WDBW5zPiN4nM1ZS7/iRNhaxO5v14lEZZFEqyhddMaq1uNQNSSRyf9mbNsOLRqOhcR90qaKHVMEF2P3dIpwti0687FBOmq2dk2nARJw1FOrYGUU6OoqOSYehedbVOJoMY1NGmTQnIu8/wNXk+04MP1OOxxmhfojvHtcGF33Q/3bI9WV5UvPr/09nV3aFbfevMPuzr7tnlbLw90+xycQ+hyc2zsbNz5BegTtEVv2tAzkJUTgdRfOR53f1neYObZ+802mEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emNytj/93dcyFXYKBzRxfKvnYLGYIv1ZOkilJak4h4s=;
 b=Exll/P0Q9LFGJgYgCJkBsHZGOE4N3KwNGbzmCffOKIiYejWjursx+yWPgt7iuZWkMybStJzvqKPamRkX89ylRaMEPz5GmUHj8pvKzvNm8c7EavdWIlrKFvpTEDE91ahd9hnw2lpUaRDCnMTy2LL69J7yRiqIXAt/LBdx3uEqJT1dFkhuZqpBmIwy74/eZiLXWNG00qoeVsVy/lpLnKcWKKAIqd0aRwOw6EHrvgsVyjIadmwxYbRgY40ceql7y1/Rdg2V+QtRp5XCgu9oX+u9ImlV8ifMv0Hl5PqhEOOKXNXPOya+zY83QUNBSL4u1YuC0+SfJCZAq5pK91jgGanKjQ==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AS8PR07MB8992.eurprd07.prod.outlook.com (2603:10a6:20b:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Sat, 21 Sep
 2024 12:09:47 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 12:09:47 +0000
From: Konrad Weihmann <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH 3/3] tests/parse: add coverage for old override syntax
Date: Sat, 21 Sep 2024 12:09:20 +0000
Message-ID: <GV1PR07MB91206D0607025857909F16ECA86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240921120920.240557-1-kweihmann@outlook.com>
References: <20240921120920.240557-1-kweihmann@outlook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::19) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <20240921120920.240557-3-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AS8PR07MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 707654da-64c0-4e1c-cbf3-08dcda364927
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|7092599003|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: 
	tLGbPblzyHKQ11/tssUsPuMYBHKQxT3PBWpRyKAzqb0vNMlZ+V9TKFnvqPsZX/EFr9KiX1syS8Teb2Q4ifSIH5uf9sn+c4g6QaOtZeUJk5Ezwptd3wEAQzg3eBKNERKWivR8mWRX3r48UYqFt6zPef0v6XFE+9Z3D+yyQwlnpc29WAwBoPvJC7mkFJDGNho2oh9y8/mU7BRjJqy2qyaCIGQ+AkMXy898qrTiv+GWbshoZJ88xIbikSSz2IqQIU80EVQEVgTZTUhIUHo/F8c1XBGjF0ZhH33X5zXmu9LUfGYQOUzq469oWrYFl2+2rEx8Gti2JXD5Q+Jgf5bvZZ+ErrB+ovUo4cmw+CMV56N/pOD5TQvEbLgndjRT4IIS3O3KsZQDnucMV6mFVFwEEMnymOXVeEtCrzA+qhXgcG52aULpWhzhcAM1aWRBlvXTUFeqMKt3olwSkSoOj6yHhF+r4pUJtfseONK8wRWIVvTZeafxcqt23clH87dvrJsmvdsJIP/RxNwNrgh4u8BM7JPoBms1ZsV4lRVykDRql4KEtNi7fbT8YWPuLpnC/j2e3RAhzxc0fLb8K/23dUneOFbQBpiSS3pHGq0/unKapxt2UEk7Db+b2Z64Oo+WVHhRajEuFplJ1zclae/NBEBIDob6vRruvYmMuTdEBwkZTCkAurqHGfzZkqYgR2qjnNeb0uBvN0+CcF8vd66K09RULt7EzQYOTWUpQ0T6LbvXzRwX5Hws0A4OWKMyVMFR3NlXpDLKM79HC9YBqJejo2vJr3+ECQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vt1NROQwn4Qe89CMrnweOhgT6ZQW3wVgC+zrd/KlbgSGylbp7IdHpGh/J7uN?=
 =?us-ascii?Q?vnkWNb3C/XqIBG6MpuQlL3hSY7WkofBil4lybutlt0P9UdrLGvFekEFwILSq?=
 =?us-ascii?Q?TN2+xWUY1it2gT3mbXyJYF2vQNEOhdnW6D3U6AcxMZC3sEra3Ez8whCb7qUM?=
 =?us-ascii?Q?cfgu1vp19PWx9F9Xe31QhAfYz9BbYg4yuvCqModAbBPhwmJ5JQ0pQwDpuyIT?=
 =?us-ascii?Q?JG9e7fO39O1SFR0cM4zmufN2ZFmDB6Cx1Is4aBN4b2S8q6apia9HXsu5jdL4?=
 =?us-ascii?Q?0Wpm4sEhUO5EGefXyKxjEaQfRvYJ8CnN8FQ2b3OIHqxJBew1JnouSIJXvfz/?=
 =?us-ascii?Q?S28G43ROFbMwPcXQSQ8pMOSQTrCljix2eSdplJIyjYnoVrAbevde72u1EkCP?=
 =?us-ascii?Q?jGPi6omBtOLS8jnN84B4xsHdr/QYxWXnnmcVc8J7Tew2MWQrTMWtBJh4mCKS?=
 =?us-ascii?Q?IZukF+tdISfwYZaQLImw046nxCE7PHaQQQNB+paTIov6eWlHLIScDwRPVmnI?=
 =?us-ascii?Q?91Xh6JV7cmzH/wOfNLeUchJUV0gHr5q5UoHo4ZvKSw+t32gkuSpuLAWWrelq?=
 =?us-ascii?Q?p1EwENHwzyrHH23uPxw3u0GKB9gAvfMhFzBb6nQzTc8GEHQNGkY8DgULZNOv?=
 =?us-ascii?Q?5hn9Ufp7J8AY1waX+8zxdsQrwTiCYDa+gFxv3RS6Xn9dgUSAYpROXYi+0Ys4?=
 =?us-ascii?Q?MOt4b4VuNnVaA42PQmXfsjWgOnxraCej6VkTjvwUTlFCThbA7e8D1menXnv+?=
 =?us-ascii?Q?t5+miE6UXvS1HaUCIw2DbzKGtff3YmfLnicLic4Zd2fHQkHO8/OTAYrBykOj?=
 =?us-ascii?Q?cEilzHek2Jm2sIlnjby5lr/k5ts+zm17xujRCHO/iNUcsZh3joTHkW2qCMA+?=
 =?us-ascii?Q?Vrj/8nWmcgZj1YPpLdKJfgFsMJyFycqq65u7T6n8/cwtjs5XMz6MAykbJuN/?=
 =?us-ascii?Q?QNX4yBFJhpgnT8nBDjwWciq7TZm4DU76pc+b98XNMr4ycslU08fjHqOTZZ0r?=
 =?us-ascii?Q?hSekkOm7nO++N9YFWUFRT99S6jHiDvPcAXi4+v6Hw1GYU0wyVnEZ4Y9rq3Qy?=
 =?us-ascii?Q?C79ryN42Cq43KWiemzH0P7SvwnsDloknobfNMX8rxS+gYf0r6hSRS2m1Pard?=
 =?us-ascii?Q?mSJG2d0j/SBNSta/hitdLWC7ffl9OcWMEUHvAGfX36Wu9TVharPiZqyXOCPp?=
 =?us-ascii?Q?3R4Z1sRNGzS7szQdkIaIH9SRN16YqFMdl0y7F+os9NF88NKDguzb4fLPLAEt?=
 =?us-ascii?Q?hFEBHHtWO0WaOfjQLz2gSYANdSx2FHep3GzvPXFcYr9NnveWDrcmiElXOXHo?=
 =?us-ascii?Q?kU0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707654da-64c0-4e1c-cbf3-08dcda364927
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 12:09:47.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8992
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Sep 2024 12:09:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16579

including previously unconvered tests for true failure cases of
_prepend/_append/_remove.
In addition add tests for not valid cases

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/tests/parse.py | 69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 410679d5a..2da3a2a22 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -132,6 +132,75 @@ DESCRIPTION:${PN}-dev =3D "${DESCRIPTION} B"
 PN =3D "bc"
 """
=20
+    override_old_append =3D """
+EXTRA_OECONF_append =3D " c"
+"""
+
+    def test_parse_old_override_syntax_append(self):
+        f =3D self.parsehelper(self.override_old_append)
+        try:
+            bb.parse.handle(f.name, self.d)['']
+            self.fail('Pattern should have raised bb.BBHandledException')
+        except bb.BBHandledException:
+            pass
+
+    override_old_prepend =3D """
+EXTRA_OECONF_prepend =3D " c"
+"""
+
+    def test_parse_old_override_syntax_prepend(self):
+        f =3D self.parsehelper(self.override_old_prepend)
+        try:
+            bb.parse.handle(f.name, self.d)['']
+            self.fail('Pattern should have raised bb.BBHandledException')
+        except bb.BBHandledException:
+            pass
+
+    override_old_remove =3D """
+EXTRA_OECONF_remove =3D " c"
+"""
+
+    def test_parse_old_override_syntax_remove(self):
+        f =3D self.parsehelper(self.override_old_remove)
+        try:
+            bb.parse.handle(f.name, self.d)['']
+            self.fail('Pattern should have raised bb.BBHandledException')
+        except bb.BBHandledException:
+            pass
+
+    override_old_valid_append =3D """
+do_appendsomething () {
+   :
+}
+addtask do_appendsomething
+"""
+
+    def test_parse_old_override_syntax_no_warning_append(self):
+        f =3D self.parsehelper(self.override_old_valid_append)
+        bb.parse.handle(f.name, self.d)['']
+
+    override_old_valid_prepend =3D """
+do_prependsomething () {
+   :
+}
+addtask do_prependsomething
+"""
+
+    def test_parse_old_override_syntax_no_warning_prepend(self):
+        f =3D self.parsehelper(self.override_old_valid_prepend)
+        bb.parse.handle(f.name, self.d)['']
+
+    override_old_valid_remove =3D """
+do_removesomething () {
+   :
+}
+addtask do_removesomething
+"""
+
+    def test_parse_old_override_syntax_no_warning_remove(self):
+        f =3D self.parsehelper(self.override_old_valid_remove)
+        bb.parse.handle(f.name, self.d)['']
+
     def test_parse_combinations(self):
         f =3D self.parsehelper(self.overridetest3)
         d =3D bb.parse.handle(f.name, self.d)['']
--=20
2.34.1


