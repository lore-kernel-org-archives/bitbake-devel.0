Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD116CAC59E
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 00:06:59 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.web11.7739.1757981218827481457
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 17:06:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=DZ9B63pK;
 spf=pass (domain: axis.com, ip: 52.101.84.69, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQSExVguUuRJJITFqljbhJ/3+b7gKPjdbxm+K1aH47gj4RbCGZPCugzVrH9/79/M6h4O5Adlv1C6w+vqaO5hM8XB4ejY1bFkpif5Mfci3fDQtlyhbMTMqYMMmF3PBb+j/l5y8CSVniIMuBblpCNV4qUbrN04syd49j3+NFNtGQ11PYNOrwrlMicNoJFl8bdBsmp/CP2Stexek56+zp9g77loCxuJtuQBv9YOhy2PhIVMXgGEtePY+mBhn40L4uJWji/IZmM4qU3ZgbVvX59Ov3SCq3DzUTdTjCSjvybj5iYOc09ujkXRBZdoATVIHBJqgHFrkUREHZ9XHQAi/kNkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZFEsP89gCqCDDCj8wahYbI+8u72HQ3LEvDlAXxXERo=;
 b=TVLwFY+J0BwBeOGf8hmqyAQpjxQ1T7EY0cBxqY1zdxhD23QqQYDUAGpvuhWs1HgnTfcUl5rBsFyUqn4t8ylBFq+JYfdu4EQXwUPIGRlvypOloeRdWOPH9ndZNbqEsEDXUo1iofK3YRhJSkiZto7OOlhScESXLYXH1HbabU4KksqOULS6BEMp9MXF8lPBWLTAIJjy6rKwRACNWd1UAMmibTt0K10nDzMa0lbk5TYQ7v3ZPTh+R3jde7vpZOvWnzRsyRe+f3V6CM6P38qRl8zlMKh8wLb0YV64dXUQLZiYb4WOTIFPfMj60ZcXTvx4ywMyWlpbXyWt1nYAZPtzNKk/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZFEsP89gCqCDDCj8wahYbI+8u72HQ3LEvDlAXxXERo=;
 b=DZ9B63pK0jADzG0TI89ec0ktgAUjMvL0ucKEVjosQAjPCtJl2PlUAVtDBbg07XQg2r2QWd1xV+/lMGlj/o4pyrsnBO787nXwvMRhXFQQj2mkyvbS2Z0ptsHNm7KBTPv5wSXua/Y8EW05G0ulrVtWlHnKtoRLJg/mSXn+lAo+Vyc=
Received: from DU7P251CA0003.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::33)
 by DB9PR02MB7305.eurprd02.prod.outlook.com (2603:10a6:10:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 00:06:53 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::e0) by DU7P251CA0003.outlook.office365.com
 (2603:10a6:10:551::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Tue,
 16 Sep 2025 00:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 00:06:53 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 02:06:52 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 02:06:52 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 02:06:52 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 17F4B26BE
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 02:06:52 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 849BC120468; Tue, 16 Sep 2025 02:06:51 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/5] tests/parse: Use with statement to avoid ResourceWarning
Date: Tue, 16 Sep 2025 02:06:44 +0200
Message-ID: <20250916000648.1182372-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|DB9PR02MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: c6582877-87c4-4cc7-a7c5-08ddf4b4f14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?v0VSr9PAw6rDv+2AHqNhpp2QGrrsjtjN9GtW3D1zgLNGpE7viiXsxoBWNbiO?=
 =?us-ascii?Q?KcJ4tM5ln923RX8xOSpTEMn+SkdZkZw5KyyoW/gke1uqKAtAMYRbEwhHH43/?=
 =?us-ascii?Q?9cHf4A8ZDBr3HHytl6gsDaCOouSkWdUWe173g2n8HzJkf9/2+AiCE75SQeoE?=
 =?us-ascii?Q?xz8DGD4d2cHRd5y9SOCKx7elcw4s8A5U+8tIoV0yOlsXArFpjWP0/0QVjvs8?=
 =?us-ascii?Q?RIMoz3gFeoo1X19U1EbbvxmdooZzd7gBAwoJB010JND5lq3gLdF5xWstMlVu?=
 =?us-ascii?Q?mp6W3+V6TljBfhZY9XvSdEBvKSG2Wk80nzEKXCGFHYUQ3KSXg9IKowVHY5XP?=
 =?us-ascii?Q?Ro0bJHX6bZlzsIqcwy0WFZl4TQy9iKJSTi4ixNwOOVcbisDFfGE7MUZ/WfIx?=
 =?us-ascii?Q?SP2Dwf3DBVOtOaO8snQx29txlkIwjdZ5zaajcEya+xb6zs/hRZgrXXFWW0+8?=
 =?us-ascii?Q?jlBaSraUgbcekwDELwzdVQEfzEvDNijC9RIs/vKiuGXhzdrMoAztw2DB1fBB?=
 =?us-ascii?Q?cocFsrTG+ZhqcvAjnXalih3Sk360jZxCbKi9VSjnnSHi6J0RZ21DZI/3XWGk?=
 =?us-ascii?Q?bisl9N/eODb3mxQ9wsp07UGAeK23k4hFRidcfvu3lK6o5qS0cNhl2gSDq0eZ?=
 =?us-ascii?Q?PKbO6MJV0iypeVNamy1NHh8bUPhrnvKd+TBHTZLiHYsKOvz0MjmMiP7Eh7wd?=
 =?us-ascii?Q?aG4x3E8x48lrxS6S4jSVfs7FIrRl+L6F4PIL+qZFf20wTRXUBtPgjsCqb8zd?=
 =?us-ascii?Q?yLasjOwgnnidYpRi/Gr1A+BYvFUCBghHYWQj8a5fK30bIl+mW1nLuMU7Im4d?=
 =?us-ascii?Q?G3OwgDTx6pzORCS/56hOC2NuvCcaA3dbMOyt9v/jZ3QCDybUuVkwJj69KlGX?=
 =?us-ascii?Q?5IeYqTjl4/ppnJzXmDaVSt9uUKkuY345GaBN/snTylkO6p3/61IVWORhszA4?=
 =?us-ascii?Q?DI+qvpq2iWyAYFpMXZayW/2vRw/65mfYXKuR4gaNdpeHG7xkw0l//rJSxRkO?=
 =?us-ascii?Q?13eWCAkj5zSNIbmQmYIOxRNFAdz4yTxAx4Gos0HPm3s9ebiirilLl8bKcAMb?=
 =?us-ascii?Q?jR8y8Yg/T3SznJ5ejLLuYfHPnINRZ7H55HO+XeHsnNCBiyIZzpFxR/NZRq+9?=
 =?us-ascii?Q?Gkaz+fcPI5tT/SD9ph5nUY9JHuVV45ZQK1L9vyt96SIx41NZms6O3UvK3zyh?=
 =?us-ascii?Q?iQdcDNjxbbAbQ9gKq46yIkPP3ybkhu4ehIPu4DXMdEx7nenVZT5ZP5ZYf0yz?=
 =?us-ascii?Q?QXxFXdMNBcKCiMg4nGe1amAdDmkshEaWqIFB835P8EsKpB4bwOVATuxqv4CQ?=
 =?us-ascii?Q?UYhCZKZA+ARlm01L5MjRzB78PNcsmYCrd6mCgVxwq+Hd52hRZTfKPOIs/VYT?=
 =?us-ascii?Q?rpoUCB59mf7waAYWjMsdD35R8SPE3CLo0SEaK/FFM1KmAOx0CqSBBSbq/z34?=
 =?us-ascii?Q?ndQTMe95UyJFa9tKWl4FHuvQjHgytM87Y+Y+I/eY3j0LaTdHbhanvJk04G3O?=
 =?us-ascii?Q?xPeVeJYaDeNwn+oMqRIfcgOBBc1R3ATASeTB?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 00:06:53.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6582877-87c4-4cc7-a7c5-08ddf4b4f14e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7305
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 00:06:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18040

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/parse.py | 95 ++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 51 deletions(-)

diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index e3cba67ad4..b272739f56 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -39,7 +39,6 @@ C =3D "3"
         os.chdir(self.origdir)
=20
     def parsehelper(self, content, suffix =3D ".bb"):
-
         f =3D tempfile.NamedTemporaryFile(suffix =3D suffix)
         f.write(bytes(content, "utf-8"))
         f.flush()
@@ -47,17 +46,17 @@ C =3D "3"
         return f
=20
     def test_parse_simple(self):
-        f =3D self.parsehelper(self.testfile)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.testfile) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         self.assertEqual(d.getVar("A"), "1")
         self.assertEqual(d.getVar("B"), "2")
         self.assertEqual(d.getVar("C"), "3")
=20
     def test_parse_incomplete_function(self):
         testfileB =3D self.testfile.replace("}", "")
-        f =3D self.parsehelper(testfileB)
-        with self.assertRaises(bb.parse.ParseError):
-            d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(testfileB) as f:
+            with self.assertRaises(bb.parse.ParseError):
+                d =3D bb.parse.handle(f.name, self.d)['']
=20
     unsettest =3D """
 A =3D "1"
@@ -69,8 +68,8 @@ unset B[flag]
 """
=20
     def test_parse_unset(self):
-        f =3D self.parsehelper(self.unsettest)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.unsettest) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         self.assertEqual(d.getVar("A"), None)
         self.assertEqual(d.getVarFlag("A","flag"), None)
         self.assertEqual(d.getVar("B"), "2")
@@ -113,8 +112,8 @@ A[flag_default_twice] ??=3D "default flag first"
 A[flag_default_twice] ??=3D "default flag second"
 """
     def test_parse_defaulttest(self):
-        f =3D self.parsehelper(self.defaulttest)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.defaulttest) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         self.assertEqual(d.getVar("A"), "set value")
         self.assertEqual(d.getVarFlag("A","flag_set_vs_question"), "set fl=
ag")
         self.assertEqual(d.getVarFlag("A","flag_set_vs_default"), "set fla=
g")
@@ -136,8 +135,8 @@ exportD =3D "d"
 """
=20
     def test_parse_exports(self):
-        f =3D self.parsehelper(self.exporttest)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.exporttest) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         self.assertEqual(d.getVar("A"), "a")
         self.assertIsNone(d.getVarFlag("A", "export"))
         self.assertEqual(d.getVar("B"), "b")
@@ -149,7 +148,6 @@ exportD =3D "d"
         self.assertEqual(d.getVar("exportD"), "d")
         self.assertIsNone(d.getVarFlag("exportD", "export"))
=20
-
     overridetest =3D """
 RRECOMMENDS:${PN} =3D "a"
 RRECOMMENDS:${PN}:libc =3D "b"
@@ -158,8 +156,8 @@ PN =3D "gtk+"
 """
=20
     def test_parse_overrides(self):
-        f =3D self.parsehelper(self.overridetest)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.overridetest) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         self.assertEqual(d.getVar("RRECOMMENDS"), "b")
         bb.data.expandKeys(d)
         self.assertEqual(d.getVar("RRECOMMENDS"), "b")
@@ -173,8 +171,8 @@ EXTRA_OECONF:append =3D " c"
 """
=20
     def test_parse_overrides2(self):
-        f =3D self.parsehelper(self.overridetest2)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.overridetest2) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         d.appendVar("EXTRA_OECONF", " d")
         d.setVar("OVERRIDES", "class-target")
         self.assertEqual(d.getVar("EXTRA_OECONF"), "b c d")
@@ -186,8 +184,8 @@ PN =3D "bc"
 """
=20
     def test_parse_combinations(self):
-        f =3D self.parsehelper(self.overridetest3)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.overridetest3) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         bb.data.expandKeys(d)
         self.assertEqual(d.getVar("DESCRIPTION:bc-dev"), "A B")
         d.setVar("DESCRIPTION", "E")
@@ -195,7 +193,6 @@ PN =3D "bc"
         d.setVar("OVERRIDES", "bc-dev")
         self.assertEqual(d.getVar("DESCRIPTION"), "C D")
=20
-
     classextend =3D """
 VAR_var:override1 =3D "B"
 EXTRA =3D ":override1"
@@ -218,15 +215,15 @@ python () {
     #
     def test_parse_classextend_contamination(self):
         self.d.setVar("__bbclasstype", "recipe")
-        cls =3D self.parsehelper(self.classextend_bbclass, suffix=3D".bbcl=
ass")
-        #clsname =3D os.path.basename(cls.name).replace(".bbclass", "")
-        self.classextend =3D self.classextend.replace("###CLASS###", cls.n=
ame)
-        f =3D self.parsehelper(self.classextend)
-        alldata =3D bb.parse.handle(f.name, self.d)
-        d1 =3D alldata['']
-        d2 =3D alldata[cls.name]
-        self.assertEqual(d1.getVar("VAR_var"), "B")
-        self.assertEqual(d2.getVar("VAR_var"), None)
+        with self.parsehelper(self.classextend_bbclass, suffix=3D".bbclass=
") as cls:
+            #clsname =3D os.path.basename(cls.name).replace(".bbclass", ""=
)
+            self.classextend =3D self.classextend.replace("###CLASS###", c=
ls.name)
+            with self.parsehelper(self.classextend) as f:
+                alldata =3D bb.parse.handle(f.name, self.d)
+            d1 =3D alldata['']
+            d2 =3D alldata[cls.name]
+            self.assertEqual(d1.getVar("VAR_var"), "B")
+            self.assertEqual(d2.getVar("VAR_var"), None)
=20
     addtask_deltask =3D """
 addtask do_patch after do_foo after do_unpack before do_configure before d=
o_compile
@@ -250,10 +247,8 @@ deltask do_fetch ${MYVAR} ${EMPTYVAR}
 deltask ${EMPTYVAR}
 """
     def test_parse_addtask_deltask(self):
-
-        f =3D self.parsehelper(self.addtask_deltask)
-        d =3D bb.parse.handle(f.name, self.d)['']
-
+        with self.parsehelper(self.addtask_deltask) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         self.assertSequenceEqual(['do_fetch2', 'do_patch2', 'do_myplaintas=
k', 'do_mytask', 'do_mytask2', 'do_mytask5'], bb.build.listtasks(d))
         self.assertEqual(['do_mytask'], d.getVarFlag("do_mytask5", "deps")=
)
=20
@@ -263,10 +258,9 @@ deltask ${EMPTYVAR}
=20
 """
     def test_parse_broken_multiline_comment(self):
-        f =3D self.parsehelper(self.broken_multiline_comment)
-        with self.assertRaises(bb.BBHandledException):
-            d =3D bb.parse.handle(f.name, self.d)['']
-
+        with self.parsehelper(self.broken_multiline_comment) as f:
+            with self.assertRaises(bb.BBHandledException):
+                d =3D bb.parse.handle(f.name, self.d)['']
=20
     comment_in_var =3D """
 VAR =3D " \\
@@ -276,10 +270,9 @@ VAR =3D " \\
 "
 """
     def test_parse_comment_in_var(self):
-        f =3D self.parsehelper(self.comment_in_var)
-        with self.assertRaises(bb.BBHandledException):
-            d =3D bb.parse.handle(f.name, self.d)['']
-
+        with self.parsehelper(self.comment_in_var) as f:
+            with self.assertRaises(bb.BBHandledException):
+                d =3D bb.parse.handle(f.name, self.d)['']
=20
     at_sign_in_var_flag =3D """
 A[flag@.service] =3D "nonet"
@@ -289,8 +282,8 @@ C[f] =3D "flag"
 unset A[flag@.service]
 """
     def test_parse_at_sign_in_var_flag(self):
-        f =3D self.parsehelper(self.at_sign_in_var_flag)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.at_sign_in_var_flag) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         self.assertEqual(d.getVar("A"), None)
         self.assertEqual(d.getVar("B"), None)
         self.assertEqual(d.getVarFlag("A","flag@.service"), None)
@@ -299,9 +292,9 @@ unset A[flag@.service]
=20
     def test_parse_invalid_at_sign_in_var_flag(self):
         invalid_at_sign =3D self.at_sign_in_var_flag.replace("B[f", "B[@f"=
)
-        f =3D self.parsehelper(invalid_at_sign)
-        with self.assertRaises(bb.parse.ParseError):
-            d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(invalid_at_sign) as f:
+            with self.assertRaises(bb.parse.ParseError):
+                d =3D bb.parse.handle(f.name, self.d)['']
=20
     export_function_recipe =3D """
 inherit someclass
@@ -453,13 +446,13 @@ A+ =3D "b"
 +=3D "d"
 """
     def test_parse_special_character_assignment(self):
-        f =3D self.parsehelper(self.special_character_assignment)
-        d =3D bb.parse.handle(f.name, self.d)['']
+        with self.parsehelper(self.special_character_assignment) as f:
+            d =3D bb.parse.handle(f.name, self.d)['']
         self.assertEqual(d.getVar("A"), " a")
         self.assertEqual(d.getVar("A+"), "b")
         self.assertEqual(d.getVar("+"), "c")
=20
-        f =3D self.parsehelper(self.ambigous_assignment)
-        with self.assertRaises(bb.parse.ParseError) as error:
-            bb.parse.handle(f.name, self.d)
+        with self.parsehelper(self.ambigous_assignment) as f:
+            with self.assertRaises(bb.parse.ParseError) as error:
+                bb.parse.handle(f.name, self.d)
         self.assertIn("Empty variable name in assignment", str(error.excep=
tion))

