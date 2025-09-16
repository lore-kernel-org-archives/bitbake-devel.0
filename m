Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEDFCAC597
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 00:06:59 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.70])
 by mx.groups.io with SMTP id smtpd.web11.7736.1757981217527662218
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 17:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=ghfiA00y;
 spf=pass (domain: axis.com, ip: 52.101.69.70, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpEqegsYgGZSunmMULW0+ZOfIUF+eSHpvo3TaUMC9MxCh7eoFoGfsHPaV68bj8s30dfmGD5t+FFqt4bv8TqX5a79LdCBR5lfMttnuFan9d0kXj6H3ZMTk13oLiuERT3xuEgoEqXTimnEj7qj2xDb8axVUt7smxO7U0EUKLoK12T+TosTZZcWE+YAlX0QcRVgeXQBgDtQLPbi2FjJoPhMLvjzSOCenxWfwKnRExnLHWw0vOlOTO5V/ai8+C+ljiQRjOTOGyruvNnCa7M/sfE//knBKFB/AYbwBME+OJbFOfJ0fVqJ7QASApI2+8xvcPoMTr891Jyw8OodeavTJcBrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyNeHBs81Q5In6+KmLgH208gtRfsPhT5V3NcBIsAdjc=;
 b=NHYldPDSliIlnLxg/RhBwzdtixRBqleFtiuBySOkWPmqk9UKYL1B93cxuoH/bLucWCqPwKOAHTBiv3DIvE6CijvHS53M4rWvQ6kiU1kHwFqog8Tiau2AvpbO+sbIW7nskZrSfeDjxiHmDoeFIP4VPBgSekVq7Ge0ZfgSmJ9n9IukJcgKSfAMvNeBDnJCsSWbVE0bZBAyurTWtBqgsb4Q/M8A1QGu4rSrhmFyXj3oHinSDk5YzOzXAEiwTwWiHvgaZ0XqseEKMeJfiAuVOSYwXrl+mm7YrHbZJAY5Dsxomto39kAjYooDudfyP3GTXgqkOZXU1kNGHSE9rUPN3M4FHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyNeHBs81Q5In6+KmLgH208gtRfsPhT5V3NcBIsAdjc=;
 b=ghfiA00yUvdfhRTKPg47pnVs95jwnzUdhyGfER9K3uhv3CiSG5/7JcbiwfjgBpBg39rMltDByZcKWHbzb39E3gkg8/VRA0slbw7fBwVsLZDLDoG2KF1spxdepQ9lSYxLYDXQHrpt0AolwNn51LvwL2knQ940UUzFxRcGCWLCp+c=
Received: from DU7P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::10)
 by DB5PR02MB10216.eurprd02.prod.outlook.com (2603:10a6:10:4a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 00:06:53 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::50) by DU7P251CA0019.outlook.office365.com
 (2603:10a6:10:551::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
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
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 00:06:52 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 02:06:52 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 02:06:52 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 02:06:52 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 205E627EF
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 02:06:52 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 8F5C9120468; Tue, 16 Sep 2025 02:06:51 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 4/5] parse: Make include_all support empty variable expansions
Date: Tue, 16 Sep 2025 02:06:47 +0200
Message-ID: <20250916000648.1182372-4-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916000648.1182372-1-pkj@axis.com>
References: <20250916000648.1182372-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|DB5PR02MB10216:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5b6bff-31c3-4b5d-1b51-08ddf4b4f0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KW1hhSMeSvPYOb1gUPp5rmcHLIQQOEiB+1ZLdekWg5N7XfN9E0D24XAMRBe+?=
 =?us-ascii?Q?mxpVWX7O9Q2oj4Zm2+MBfct6dWSP7bMIi9CGH1ROO+7rDehyMHAdgbqdSMgT?=
 =?us-ascii?Q?F/Ocx6qmKPgjOHoW6MrxYL4IXrrkrquhB8VOJC4XZyHPxFG/R8CnL5MTzKDp?=
 =?us-ascii?Q?VrrTwGh5hgk9qg66ujcC19QgheCMTqLcYGlSEuv32CeI/3huewmkvbaHvaQt?=
 =?us-ascii?Q?3XXfOMntDHNoNVCsdULFJmCGtqUYe+P6DnKvAp6IYERbDGQOs+JBVNlLLlQt?=
 =?us-ascii?Q?n6Z66kzDzdqWTTeyMPViZ/YZ0XwuHGcCSlJfcag7j60OovIa0gamaGjX28tZ?=
 =?us-ascii?Q?KdcWnIJOPoneMleEVLPQoSoWbpTFjadJwSRPDRCFWrxiFJt6ntNITQ2mh3xX?=
 =?us-ascii?Q?vQyG5lzpSMM9H798AOjVE7reU6PM7JNNoR3asXiRkXXcRl4CxT7bRyeZmRuQ?=
 =?us-ascii?Q?PPcRLv+/N+T7JuJToFAcu+GlDUlkc5vi+99kUhjWL+W1DhVlcZQ4KajJ+Sgf?=
 =?us-ascii?Q?O0RGGgAF8vKRYRXP813UVYqdDD3ZK2sHp2LkvPooo+kmnFWhjYxs6G6j1uVt?=
 =?us-ascii?Q?Zcw/Jqz/o8GIjGOaGCvb5qX4YCxPRnQlROqb2nF4nKRGqcj4ps5A7NGlCyu5?=
 =?us-ascii?Q?oW1a7LFpuO77WmOKO8SravDdLUrhJAgr3819qfLPmkD5io5oYJsN6tAYFKbv?=
 =?us-ascii?Q?UNobmfFiG99TEuqwOK+aT5W+90rauRDjj7ZKGH1Mwymq5S50u4WdMStYV1sk?=
 =?us-ascii?Q?GPS06tRMVSZ0RW4o8ojPdvzK8WtPcimz7jNuavlfi4qeLtJlJCYKrEI4rl04?=
 =?us-ascii?Q?szgkDUDs1+KA1mf+TE222uKmdkSJBiPwV8eZL5caMZhINknhmYasnjZyWlmr?=
 =?us-ascii?Q?BkFvJvFeHyIZFfhwefTa0uzL7wjTI8FZj7qVN1QYZBt7wXEbPzDHeV8TsYG2?=
 =?us-ascii?Q?9+Cfp5eLmMrcAx4pC3sXAv18TaRUKDneL/IRkZP62uctV5Jsfto/qya1deWu?=
 =?us-ascii?Q?FiQAzEFn/WnodpRF80c3EoGqea6iiGZs8quYwrhiI5hFGtOZCbjriFt16KKU?=
 =?us-ascii?Q?TkSUZnq3ucmpKhX3zBNMSJIrsKTvTo2+BWWr6aBHx/8bLltS1l+AdxnPPhn7?=
 =?us-ascii?Q?TdOIlOgE+EKaIXJPoiqzpStVnE3ARffcC6pemIm6mYM20ie8URiavzArQPU2?=
 =?us-ascii?Q?1PnRxXSjLN/k5SSMi+i+/5vS9NyYEhRZ9lBWWo3k8vV0U5FRwJyCEsS/jpuK?=
 =?us-ascii?Q?bDVYLGFA5U2UrAvbWBz7JRtpu912gbbKyDDY8k1jCLtljTHEbkhkyfBvkTCE?=
 =?us-ascii?Q?vA+BR8timex31YvsygBSFZhEIUIjoGN0ulnngsL1yese4sYGJl5gWUa0d4Z/?=
 =?us-ascii?Q?6qZMzasYzITW6+zNWpogDZNIlfHgRDoE6gD3tTk8aCk5BxJIf7ZfjzUuF8T9?=
 =?us-ascii?Q?TJby3GkaNX7kpRowsyGdyuyFkSQJ62MaJOIe3k0BVgWZJKSsK9Iwx8DEB2nJ?=
 =?us-ascii?Q?RsW4EJ1VQ5zhsIA8l+0GS1MXYAKZdgb0d1dx?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 00:06:52.6252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5b6bff-31c3-4b5d-1b51-08ddf4b4f0be
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10216
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 00:06:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18037

include and require support empty variable expansions, typically used
with conditional expansions. However, include_all does not, and instead
reports an error for the first path in BBPATH.

Rewrite include_all so that its behavior matches include and require.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
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

