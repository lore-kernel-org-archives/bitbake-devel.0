Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFE2CAC59C
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 00:06:59 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.21])
 by mx.groups.io with SMTP id smtpd.web10.7557.1757981218377397356
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 17:06:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=UKdcTLcV;
 spf=pass (domain: axis.com, ip: 52.101.70.21, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0aBqh5Dz8oaByQktb1criXAQviFnDpsj4XI50MykDr9ofLcpuKqnlNKKZUpV99YexHZzFSUWvzQGGh6tcV4jo4WxlC1PJXPVngq8TfC1qtSdHndQ1VENp5MPKrq+cmaSOMfCZm+xFcpFs6ZbAqqn2z5koTTXbOSuZeM1ywoahMOIEiel92LLw2kiU9kDtwcXR/BDJLCdH94tXZfi8PRdnfZQGbqEpu3SRM+0KvioDSNGUcqE7S1zEHoQFzbYn7iESfWiSyhnwg8vQva4juxDnQvmTjYR7qgA+FGU9xVjpm3AnjJ7rmbjEl7AFYZ8kkPiMR8OEDfn4ID89WJLao3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge877RpA/8AgGRzZI5eOp1fUZE6PZzAvuVEnglCFNng=;
 b=EHWXyJjOEmvnSNHhpMVe4zTqFcovvw2gBnHCDaTZe6aBLm+cfIoDuGLYXmD48wkwjwiJSBrXNpyaCg8j/jF8gkZqSv/9G4KwecmZ186vc4ebhA98+PbFih9qphrzzw+/Cj6OxneltAnDGdSP+gQyp3D2Uj6A1ALEgWNCFVIuFb+ThASOWLqTkA5dfkJClDh6wS09yfr1Xx31VGHzXjb4TVZsR27p5gsy3KC6OTfH7+FAEhqhztf8Lehe6ixbbelt+cKd9K4ho7iWZagBeE4SJs24fVkY6dNe9pIYYfF97LdG99jveO/hjPMJsVYofUCK+9MVTc+wXiRQfcgMWVvZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge877RpA/8AgGRzZI5eOp1fUZE6PZzAvuVEnglCFNng=;
 b=UKdcTLcVENJo8LskUEr9A+3iMLNeehlpWBYYVmxBRVKzvaxukGHqzDYV9LN5IeNYoGfYNJJWypjPZNdNPAwKFmKypwvXY9dLnzX8VQEmnHxn8khVMasAd3qJzoErSWwf0O++ubjGFgwdivV6E3AkRwJucuND/EUzhzOXQI42s/k=
Received: from DU7P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::10)
 by DBAPR02MB6438.eurprd02.prod.outlook.com (2603:10a6:10:17c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 00:06:54 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::2e) by DU7P251CA0019.outlook.office365.com
 (2603:10a6:10:551::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 00:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 00:06:54 +0000
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
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 1C7D727DC
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 02:06:52 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 8BC281204B6; Tue, 16 Sep 2025 02:06:51 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/5] tests/parse: Add tests for include, require and include_all
Date: Tue, 16 Sep 2025 02:06:46 +0200
Message-ID: <20250916000648.1182372-3-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916000648.1182372-1-pkj@axis.com>
References: <20250916000648.1182372-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|DBAPR02MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: c7431120-301e-4b7f-77c9-08ddf4b4f198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?D4kJY4j1IGdxXJ7x+lL6FBG/HzCs7mLev7BCubfs/UnKfTJz2WA7KfsvVILv?=
 =?us-ascii?Q?hEtBqBIL6GgsZ1pAhE0yS2dnWn21tACbjuB8oeuHdP8CYdUEWLU0KNZR7MiO?=
 =?us-ascii?Q?Z99LnUDzFWWbKxkrb5JEJ/ce0JmwiAHENh+xBy8EmrWDrv5SbC+Pmx6kAnQw?=
 =?us-ascii?Q?Y+dowBCHc8412eanwHkHe6LUSrHVvraQc9DNfsnMyR/zQTuXIaiwoF5TBF41?=
 =?us-ascii?Q?+rq4qjppiq4Q3WZ/GgSX10XsHglsKhBwlb2aJ5iUAbDiDbrTAHxcNEMtIrTF?=
 =?us-ascii?Q?aSqJRc13ORIubN/SciAydV8HcT8yIrwZn+3FQx2O4B1MTzanexXBWtOE3Hxe?=
 =?us-ascii?Q?bn5nSz0cwSWvLtgSvMKfGtWy/gNBXNcS25+bTYWr5mRQtxcuSNHw4UVjdwon?=
 =?us-ascii?Q?91Fn86BoXyi90Y6i3mQD6lRoggXUhEAnHBaL6xiMa9mqhAn7c7cz1FamaT1c?=
 =?us-ascii?Q?1C4mOgWXbBWE4pAgUdskBoTfPkXIo6DuoZ5i45zyyjHU5nbe96WV3rXxMEeJ?=
 =?us-ascii?Q?55826Fw3UAaBRjEnC0tNEbjpK10KC8oFad3s4x4hpulNNfPDLoRNQeTFBOJv?=
 =?us-ascii?Q?gMF3cUqch92aF1prmSLpvYwF4ZrGV8WgTVqAFT1NNclPqMW1r8zraOLmSx+l?=
 =?us-ascii?Q?71bZ4VBBDDImTULhdQY/1kq2I/3Jz11mkk9r1Ix/77ucxFhimXfooJmkKaRL?=
 =?us-ascii?Q?wF5FiukoYgq8tFidwYZIK5V1lsLh1bYppq6y6iJJfUgph4Ku0LrCOFZSBbqN?=
 =?us-ascii?Q?QRl7xqCrpNm25GqHxvh5O1GGzsaVAFEuGjszUP121rcPZjCBLNkHmw9miTIf?=
 =?us-ascii?Q?mlN27+QVoxvKcLxa5rYle92m61L+MATDriNMCKNXA0Fcr1c3iojpNtZjLtnx?=
 =?us-ascii?Q?CNw/5xh5U/OJ5u5WGwiq6Ab5CT6CK8f3r5k3EgQsQ8t3myZx8ajO1ZycaBkD?=
 =?us-ascii?Q?OaI9ezKb2vmN5lYGs7N7zjV4Hr/sQsnPmkcDnz8TjGpak0afGc5xnTpR/xnS?=
 =?us-ascii?Q?1wtr5+JPruTA2aO/IbUInLXbQTJq7J0hxTuztEeUkBahk17Sbv4RdinZ2WfA?=
 =?us-ascii?Q?AAbfHD5S40bSr1tFBHrNp0P/rj+JMP7DPYFmD/hHWHxqHi6B51lduOPWWy9H?=
 =?us-ascii?Q?eCkozag6hqjM5HUdot6wg/DFCjVjbgfmxeSaS8AMsyYv83VWw5271gtj5zNg?=
 =?us-ascii?Q?H/GVN0YX2U+f6DiS4aBb3JQFKgy4px/wgc7cBJ0ikLb+B7xDuU4oYNrnogRI?=
 =?us-ascii?Q?imuKIvX/CLawsapCqtlT29WKCzYTF3dZ16GR5MOM6dFp7Ooq0NDnMESeBn75?=
 =?us-ascii?Q?wo4VTIMDNoA1b8j2ViW0MFXYOiD5EFcBTI0sNIwVCcyiIXVTx5rcWVxjVqr1?=
 =?us-ascii?Q?2Rja7F0PamNJmgmTpyOFGe78cxbNZPGEZb2qphP7vXkLJ38WAieXepndDDZK?=
 =?us-ascii?Q?rwGgeA1eTwD57qNN8s7oCEELZsCDotJ5TKLE3z5Ay2+fxoOkfF2KrCX31Erp?=
 =?us-ascii?Q?kP603MoSoBmLjKTmDrL8vOOWwQ8kpSHDrftJ?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 00:06:54.0558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7431120-301e-4b7f-77c9-08ddf4b4f198
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6438
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 00:06:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18039

Simple tests for various ways to include and require configuration
files.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/parse.py | 60 +++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index 431b0c7d3e..d3867ece98 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -448,3 +448,63 @@ A+ =3D "b"
             with self.assertRaises(bb.parse.ParseError) as error:
                 bb.parse.handle(f.name, self.d)
         self.assertIn("Empty variable name in assignment", str(error.excep=
tion))
+
+    someconf1 =3D """
+EXTRA_OECONF:append =3D " foo"
+"""
+
+    someconf2 =3D """
+EXTRA_OECONF:append =3D " bar"
+"""
+
+    someconf3 =3D """
+EXTRA_OECONF:append =3D " foobar"
+"""
+
+    def test_include_and_require(self):
+        def test_helper(content, result):
+            with self.parsehelper(content) as f:
+                if isinstance(result, type) and issubclass(result, Excepti=
on):
+                    with self.assertRaises(result):
+                        d =3D bb.parse.handle(f.name, bb.data.createCopy(s=
elf.d))['']
+                else:
+                    d =3D bb.parse.handle(f.name, bb.data.createCopy(self.=
d))['']
+                    self.assertEqual(d.getVar("EXTRA_OECONF"), result)
+
+        with tempfile.TemporaryDirectory() as tempdir:
+            os.makedirs(tempdir + "/conf1")
+            os.makedirs(tempdir + "/conf2")
+
+            with open(tempdir + "/conf1/some.conf", "w") as f:
+                f.write(self.someconf1)
+            with open(tempdir + "/conf2/some.conf", "w") as f:
+                f.write(self.someconf2)
+            with open(tempdir + "/conf2/some3.conf", "w") as f:
+                f.write(self.someconf3)
+
+            self.d.setVar("BBPATH", tempdir + "/conf1" + ":" + tempdir + "=
/conf2")
+
+            test_helper("include some.conf", " foo")
+            test_helper("include someother.conf", None)
+            test_helper("include some3.conf", " foobar")
+            test_helper("include ${@''}", None)
+            test_helper("include " + tempdir + "/conf2/some.conf", " bar")
+
+            test_helper("require some.conf", " foo")
+            test_helper("require someother.conf", bb.parse.ParseError)
+            test_helper("require some3.conf", " foobar")
+            test_helper("require ${@''}", None)
+            test_helper("require " + tempdir + "/conf2/some.conf", " bar")
+
+            test_helper("include_all some.conf", " foo bar")
+            test_helper("include_all someother.conf", None)
+            test_helper("include_all some3.conf", " foobar")
+
+            self.d.setVar("BBPATH", tempdir + "/conf2" + ":" + tempdir + "=
/conf1")
+
+            test_helper("include some.conf", " bar")
+            test_helper("include some3.conf", " foobar")
+            test_helper("require some.conf", " bar")
+            test_helper("require some3.conf", " foobar")
+            test_helper("include_all some.conf", " bar foo")
+            test_helper("include_all some3.conf", " foobar")

