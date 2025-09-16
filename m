Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CFBCAC5A5
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 21:19:47 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.30])
 by mx.groups.io with SMTP id smtpd.web11.7529.1758057585467794402
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 14:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=ph7FTQiD;
 spf=pass (domain: axis.com, ip: 52.101.69.30, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IctoQaW8/jzAOrROshBv/Y386C+b6OJeesXa97j2PYogUd9lk/tmneJk5QaiXEyGVD5YXMYJ8ZRN/bhdCzNBMzwyeKWWcLEsf0QrQHSXNqakNE4MAs/weiWPz1NT4Wki+Tjbp31aIzTfarpc2JLfG3aMklj+KZo5nFP6DQvMULjCoyVXuEA5xZxJNyfkTiPFM5XX6yuTuVFyNMQRVT5c1hvKz3ptjVTfaqvuiQdcqkYxjcNECqa/TtS/NkJMQzsOMTEH5MAhJH3thwMqf1Cz8cb37rOlhgNDfkRFHxIoqFHW89vWtjQE+qBPoMSumnzJ3vlpnRAU6X+CCGs13J0JNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMCKCMlXpKpisLfyzcRYyjTLoUgGiIy++iItjM7qSiE=;
 b=slR9RmYlIwAiJumZigoT+vcstVElGerXBJniYMGS7NbnN6KynuWH0dl8trqOWEsMxXzx4El6NjMNN13+8PfTSS9e9f2/8iWxF8VQuLVbhy9AFzZcW1wI9wCNt48wM8knROzp5pO/GCZA0zRGiwmdk6KPaShDuzfdI5ihXjFqxGCdy4z8DytWGicLrH+kJBSKYeop5Vg4CTjPXbNclmecjYvZk5iYIgxe1Y9XKEuz61gXb1VyYuJOQJ/+4rJ4aLvHJ7jEZrgO6ICo5p0G0kGgKu9i8TRM26TQREuDrG38eeIy0oGyqdMFkvxTVvq9RRagukHJnMEKkoWMU0o5taa5+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMCKCMlXpKpisLfyzcRYyjTLoUgGiIy++iItjM7qSiE=;
 b=ph7FTQiDwsqz1cwWqjVpC2B3ezW1avueO6eZFdKaLE4agvdPbKf1ok1kSo2SdaCPuVLHw6g/D78ojfZlnL1OCHHEmUXqYCCHJ+y61nmZTLPbX/PxqOTk6TZk4/qxwqqdeOXDBJX9HiNFwBm6zgF8xN/9jpZAl/zUFAbQhzRJYTI=
Received: from AM4PR0302CA0035.eurprd03.prod.outlook.com (2603:10a6:205:2::48)
 by AS2PR02MB9906.eurprd02.prod.outlook.com (2603:10a6:20b:609::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 16 Sep
 2025 21:19:39 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::aa) by AM4PR0302CA0035.outlook.office365.com
 (2603:10a6:205:2::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 21:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 21:19:39 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 23:19:38 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 23:19:38 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 111FB5D0
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 23:19:38 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 75D5112024B; Tue, 16 Sep 2025 23:19:37 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 1/5] tests/parse: Use with statement to avoid ResourceWarning
Date: Tue, 16 Sep 2025 23:19:30 +0200
Message-ID: <20250916211934.253650-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|AS2PR02MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 617e63c1-ec09-43ae-d15c-08ddf566bebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7yB0+DZ3FZENwhOHU3T1vN7jjRGhd3vxdSy1qksaJzYRuHM971KiQwe7O0Ct?=
 =?us-ascii?Q?XwFijvPoajXroa1rMsdBBN0K80QqSpxaaU7XYcBRcbZ82Lnilu7UE9KBrxyT?=
 =?us-ascii?Q?eOo6rH+5GfZcfkSNGeqrRzYXg/NkJcqCfhA0NCHoSwfl6CElO46WuATLHbNh?=
 =?us-ascii?Q?AwBLPxMmp1z/PqPfdD29t6KgQMI8IyoFERHKT+O5W/GbCTFFmVjIzpYtIU9w?=
 =?us-ascii?Q?PDeX/utdLNtTOfhMkPlzYZJrMMPrkEGpNrXgI2++gO8bWXsx0deVN8Cl5ld9?=
 =?us-ascii?Q?BwKgcLkcL24gPycwYQ/kFYVbeJBrvHMPHgeP8ktzfqqCd1yzkYeOmmWKBsL5?=
 =?us-ascii?Q?o6qQHkZ0QKphInYDKm5kw9TVLjNL/+JN0RmE9jdcViKtoQEBTRpQjR9KxRc/?=
 =?us-ascii?Q?T5Qp5kcMzsn5F0/85ri/g3dYKwf705WuAPlmDTiw879KGoOqnQaQjNW/M+PJ?=
 =?us-ascii?Q?WLJvESrZejmX4y8eO5bt+jgY6QQggEd4BtOBYOucTloc+J66u7bcjpbhzePX?=
 =?us-ascii?Q?a/p/uyrZ9ykdjfcRmgMjyRjvkrHTZzEbp8dNVtjigVvM6VzZx76/lDQ9BdT9?=
 =?us-ascii?Q?kpcX+lFk0240BNgqKYaEYgoJGqo9m6x3txR3mjPfnxq6Sax5ZqizzxlgjZYm?=
 =?us-ascii?Q?kq1NSe+39IUIkHjxFul5Uks01NHs1Dw3deBaEMuT5wJsXBjahg9h7ZfSi8sT?=
 =?us-ascii?Q?qJzuCTWSgmDybHH4G796EsYKmymPiCA5SzwqahA5NiiJbzUqmBxMS/3S45zf?=
 =?us-ascii?Q?7+lgv9yyyfT9O05NJ28PocVKOD0j6GidAtEfe8wPGRGzIRcq5mvE7rpkOfms?=
 =?us-ascii?Q?g61nCwMsyw3KgmOwhijhiit/zNaJCEQdlEW3nYdKL9aTfH6+n9y8fdChYM0K?=
 =?us-ascii?Q?Slae0ymZbSVwy+8562kHnegRaT4EuWX6SuwJG8nkwnp+A4WbFxvJS1fMvU3c?=
 =?us-ascii?Q?eMNkKB+A/HoQDbOJikrT3AvqdkGKtkT4VspgyRRiMCVSYLLUAcB4IGTOvFqL?=
 =?us-ascii?Q?H1nzZd7z8r/fNSB8jb3Pqg78H+wIAyr5WuQ+KZLinpYPUy8TceCD9RtpXizT?=
 =?us-ascii?Q?fxQw67sAQEAHh0IyqAVinDmQjH4SswWeLDXd3nBD3YWJVoPeCGtbphz+zyLv?=
 =?us-ascii?Q?3QTjR1cHR96pWwEuvIlR9QQoqFQWAfAyJ74fJWgA7U+XKEnQTtNGXMZLI/7s?=
 =?us-ascii?Q?gK3Jtz6dqoovCKnM3n0tAjqVkakWqF4WwaU5Ei5ek4hE+BmfPthVKSfEBxxC?=
 =?us-ascii?Q?cTHxUGEZuzA+ss/cDWED/U0NNMAzyg+6PXVV9kVRE+26Pj7ee+XW2m8KTQLe?=
 =?us-ascii?Q?ObTkvb8/LRvGK5HDNQjpSANJZ5fXlbs754XT+YPCAtoZiMR3acVitT/vIbC5?=
 =?us-ascii?Q?uPQIwZvd9Gwa7UGlGicQ0B6PU4JqPbWgpNsRsrZ4WuEoxpFphMUJr64831dT?=
 =?us-ascii?Q?aYdT2JSJ0K1N+cTV93Lk7kFnJuDmMh9daCb7Z2L4Mt03bHxp0erbsM4L0/wL?=
 =?us-ascii?Q?tF3I1m9XzugLNbPQsWlIyaOFNkF8i9Yt48lA?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 21:19:39.1515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617e63c1-ec09-43ae-d15c-08ddf566bebb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9906
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 21:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18046

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No change.

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

