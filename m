Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7916CAC59F
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 21:19:47 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.14])
 by mx.groups.io with SMTP id smtpd.web10.7466.1758057586109689718
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 14:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=aYLHkU3h;
 spf=pass (domain: axis.com, ip: 52.101.84.14, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aV9Vmeag2v7MSOwV6/K3Nx272mR7ZclQxzsndNI9mvzQrnoQ/GpHNFGZJlM7L///vBibNjOkWTwFnLQPcD7IvfOfyaR+8he46yx0Mhhfd8HDFxYplQY1V31/AVxYXl5NX2TtSwUxqqJJ/x1ocXF2ZaPmOWPlFrDBmaJaIVFLjPgaxNnLHi2/dpffbPF9bmG7AaMPoKRxcOyETgXa/dsv63zB0p7IH3kqCEkFPW4/nOciasObR78IWihRaca9xPDCE9GmeBpfYA02IFj4K99QM8HaWGmP0DFDdsViKj8VbCPYnhBwk2DogM4qtnd7mDNXj99/W8w3GnuCz/SXYTnzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D49e6E97PV6beEewIFAw/obW8kQPwGPIPZ/r9vUklzA=;
 b=oDIoYzTvL2vGYoIM5vMilu/7PiWOVZsntkjsPlLc6xa2WyHN9EeiD61ylL+2k3cQWYCTuRF2NFp4XcPn57IgWkhlDcNvW6se5XTwjpQR3yWU6PIoRZXSczsw/m73ZXCoHhFgf8uM3dnmw0ZHApMAAM8uQuwq7gcc+h7LEBVq7HBQNJy4DbKGkuoZIEzWoPGkDkUfQ7URI5w6TOaF3kjFvuGG1HC+j5QlBlZvzTXYXC0rWD7SAIKgrQLRBzJWtTr8E906EKYXfrc/8kF2X49XI7ZW1k97QQW9FAThyW2QAV+KcFGDR9m1xj2bORe+AzyUP7kvZQIMMTx68pm598j5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D49e6E97PV6beEewIFAw/obW8kQPwGPIPZ/r9vUklzA=;
 b=aYLHkU3hMD5R8n0D0UzsrW80w3LQe4R1GnQMuwchdrHV/txVXnsIv9Q5pkt1AaJZBfgb8cuQmuLPwjW2y/SjtEJiHQSyrJrgIOzqns9nekVhhTqUULcAyIrqV5zhd/y+3jxtWpiozKAUcYsh9Do7w4THt0wjoR1x+cz9bxdC6r4=
Received: from DB8PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:10:be::31)
 by GVXPR02MB10835.eurprd02.prod.outlook.com (2603:10a6:150:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 21:19:40 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::aa) by DB8PR03CA0018.outlook.office365.com
 (2603:10a6:10:be::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 21:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 21:19:38 +0000
Received: from se-mail02w.axis.com (10.20.40.8) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 23:19:38 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 23:19:38 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 16D61292D
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 23:19:38 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 7E1BF12026C; Tue, 16 Sep 2025 23:19:37 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 4/5] parse: Make include_all support empty variable expansions
Date: Tue, 16 Sep 2025 23:19:33 +0200
Message-ID: <20250916211934.253650-4-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916211934.253650-1-pkj@axis.com>
References: <20250916211934.253650-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|GVXPR02MB10835:EE_
X-MS-Office365-Filtering-Correlation-Id: c584a353-9e4f-46f1-d56e-08ddf566be65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aBwbMjguWCmiXT2lBshV9tJD3Hs5PRVvHUMM76eYHBXQWKCt7hfTZlSIssvf?=
 =?us-ascii?Q?b9VPpUB9R7fxKpdM4i6fX+P8L13Ug+FURq0YQUflyevSmyrT+ivFln2MImi6?=
 =?us-ascii?Q?DCCanP3nbqYXPTZmIqaknn4gZwsE+PyTPZX6XV6Q2eIdeEYhqUt7c1M+FL+y?=
 =?us-ascii?Q?bcBULrEwjadQBcgyCqXpMFV9EZvcWz8neqJAVRe/QnfewqWi9+OczUSdhRkM?=
 =?us-ascii?Q?H07UrvXj6kZHNnCXt4pKo+yjp4mQl942k6p1xRXBpALtpUSNxYy/cKHY+/Tp?=
 =?us-ascii?Q?gxE2bydqNrzXGPElCfiYV98GJJTX6SZBBPWUgon5xXIvf5JM17pfdrAc0uH7?=
 =?us-ascii?Q?Y4TwKwwyKQSBQ2U6tzQuEtINgwlBWxmKRQW4V/7Fpz7f4NAMHhnKoOLZePKs?=
 =?us-ascii?Q?flSqKxKwnbJvUBKE7tkQp31O0E+QMz/Za/XibZxzj71vAVDEQm9ZgtG8RM5L?=
 =?us-ascii?Q?OMAGaWBoE0Yl6H7Gs4NcWxyamMnmZD8OoAJyrI9HvHlN3+6fbvbBmOFfW33l?=
 =?us-ascii?Q?eMYHnqG+wOCXwh+9YATPZ8qKByD6hsXiWMo9g1ZW3Hj8J5EmTXRYbCAF9v66?=
 =?us-ascii?Q?5EbyMJBelYzY8xg2Jn1ih5A/NUEc4BKZGALXztJmHnAQYYWxzPegasu8dm05?=
 =?us-ascii?Q?Fx5xvJsmiuDhwP2Zdya48zWRbwuX6qJBJ8XHJ6Fna5dx0rcdFE/EvurzLqjI?=
 =?us-ascii?Q?s8XGG/uGsbHAW6hftC3zGr0lZ6Krw/rKacql59GnT/loij0l5f+pFQM5G2XC?=
 =?us-ascii?Q?GV5a5nflPKm2rLND+Xmg3jz8I2hHg/HNDcJcnyuKzEyv5DTllpB//T+hZlI1?=
 =?us-ascii?Q?4ITkgxiKE94hkDi1LaHkai+lpU6W0w8bNGA+d3wWqtUla6C8m+iuaV9Ejvqq?=
 =?us-ascii?Q?bPLN234V2kGp6KJTm7SwBtcI20n+GTb1hsvTsmwFFhx/IxbJPd2FRRuzvmIK?=
 =?us-ascii?Q?N2GPZJpR5l5kvyJSi3I4axzWiw1m4dt/ftbbaeUpbJLqhfvPHj9wec3IW6UL?=
 =?us-ascii?Q?oHcqjZFlxYJgGeW65ITpfaVl7OKDXkygxhmVZrdM69nSy1dhfuw+TRLoIP87?=
 =?us-ascii?Q?c5m5QqLZr9kAOXyFaZLwXr7eXwusms8Td9rwosU20d7hS46xf0WzTlvQ3zSr?=
 =?us-ascii?Q?FUEaCfIVM3vsGFlP7/h2cbynXAVIPHGUsGUIB9RMm0aPqnyXbiE6A1SfqntM?=
 =?us-ascii?Q?v+PXokPg3V04wcDbD6BJoiWUzxYKxbMH2dEmQnd5VZwGrVkSfHglUNrP+xcs?=
 =?us-ascii?Q?EaV3TnQlcRu1/J4oJOE5OSwI8Wa+bkqfBxes/y6JVn4w2LNcxtC5xC4uEjLN?=
 =?us-ascii?Q?3Tht09TRqfkS8FXcQEhN8aExiTmv4i/kU/5H+EnJv/nBpDut5BWuvF729GjL?=
 =?us-ascii?Q?H4AQostSltzbrwr8uym36ZYZlvUiKF4rGaC33I2SO8H7BNOsC/Uznqj/ayJx?=
 =?us-ascii?Q?LhU4F3GdmcIGlPhRKeTOwhhp5Gerz8hv2FKrQH34qWKjeAEwmihtOXGHrybL?=
 =?us-ascii?Q?bkIbXJntTJg2ZR4ymDbo+Q4Eh1my4f+uEfbb?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 21:19:38.5755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c584a353-9e4f-46f1-d56e-08ddf566be65
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10835
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 21:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18047

include and require support empty variable expansions, typically used
with conditional expansions. However, include_all does not, and instead
reports an error for the first path in BBPATH.

Rewrite include_all so that its behavior matches include and require.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: No change.

 bitbake/lib/bb/parse/ast.py                  | 5 ++---
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 8 ++++++--
 bitbake/lib/bb/tests/parse.py                | 1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 49a0788038..3250211e60 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -53,10 +53,9 @@ class IncludeAllNode(AstNode):
         Include the file and evaluate the statements
         """
         s =3D data.expand(self.what_file)
-        logger.debug2("CONF %s:%s: including %s", self.filename, self.line=
no, s)
+        logger.debug2("CONF %s:%s: including all %s", self.filename, self.=
lineno, s)
=20
-        for path in data.getVar("BBPATH").split(":"):
-            bb.parse.ConfHandler.include(self.filename, os.path.join(path,=
 s), self.lineno, data, False)
+        bb.parse.ConfHandler.include(self.filename, s, self.lineno, data, =
False, all=3DTrue)
=20
 class ExportNode(AstNode):
     def __init__(self, filename, lineno, var):
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/=
parse/parse_py/ConfHandler.py
index 9ddbae123d..af3af2ccee 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -56,7 +56,7 @@ def init(data):
 def supports(fn, d):
     return fn[-5:] =3D=3D ".conf"
=20
-def include(parentfn, fns, lineno, data, error_out):
+def include(parentfn, fns, lineno, data, error_out, all=3DFalse):
     """
     error_out: A string indicating the verb (e.g. "include", "inherit") to=
 be
     used in a ParseError that will be raised if the file to be included co=
uld
@@ -67,7 +67,11 @@ def include(parentfn, fns, lineno, data, error_out):
=20
     # "include" or "require" accept zero to n space-separated file names t=
o include.
     for fn in fns.split():
-        include_single_file(parentfn, fn, lineno, data, error_out)
+        if all:
+            for path in data.getVar("BBPATH").split(":"):
+                include_single_file(parentfn, os.path.join(path, fn), line=
no, data, error_out)
+        else:
+            include_single_file(parentfn, fn, lineno, data, error_out)
=20
 def include_single_file(parentfn, fn, lineno, data, error_out):
     """
diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index d3867ece98..2f77c90f60 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -499,6 +499,7 @@ EXTRA_OECONF:append =3D " foobar"
             test_helper("include_all some.conf", " foo bar")
             test_helper("include_all someother.conf", None)
             test_helper("include_all some3.conf", " foobar")
+            test_helper("include_all ${@''}", None)
=20
             self.d.setVar("BBPATH", tempdir + "/conf2" + ":" + tempdir + "=
/conf1")
=20

