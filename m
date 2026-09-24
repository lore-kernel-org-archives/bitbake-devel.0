Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D89DC98311
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 09:45:38 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4046.1790243131409226472
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Sep 2026 02:45:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=HohQJWP+;
 spf=pass (domain: axis.com, ip: 52.101.69.70, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtUmJs2av2U9R8yOfKqeSQs7AEvHHTG7xlGEne/CUTCaO2mBQsBV8ywMXrloihwYuBggMMMm5iuz+PxYdCMp299O7OSV6U0enGluicESN23mHe/KSxt5ajA7fXsnildtHUn9Nb1jxZT2bRLOLapRBHDgh+rc/Nx1kI2aftWQspQjAPfUSQQgCEd/35JC3hT8C8V8Ghl3mQI+5NvG8e/sETERQTK0fcI8hMvugopOEeCslpVo2GxltiKIb4e7vEdtYshF//MiUm+fcz5BkitWNpziyCsG+bNPHysmJHQOLS02iFUp7OxHm6MqCJg12xkffSiYo8VoSt70Cvl1jhsfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdUxzKuiXrOY65G6LAaCW+Ufy5p0aWho99A9514AZGU=;
 b=R9xc0nkEUDNmIkd57+cmbkDM5ZiJsrP/Ep6f79Xh27y6B8lz6mQ3331A3kEF+zmvsbQz+HTIlWC4FRRvWR/wsV7yg286kWUMRfyQvQeoKGXLGYQirMzoXKhpHFJKGfUVwkFwpBOIz7O5WMp8oMwpKI+UF0msk94c010b5t0O7FbrbvkcoXqicsU/3rmUF20qrUMz0SuB77YyGbcceezQiw5ff6euSmxtGF7fZXhro3MFXLtCSXpbtoe3Nx6MvMteerEvdhSP1HnhTQqecxWzHtTkqScucqwQ5EbTInn9uTIseQFSMoaAVEYIhsle2ZT35A4dCvpqgMk00QCKAoNR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdUxzKuiXrOY65G6LAaCW+Ufy5p0aWho99A9514AZGU=;
 b=HohQJWP+t6npCnr1cDJ8oy+iUSgZgTMT00su1tXjMfCcX33GAGXBMgK3jdWZewlq5DfPmWP+CmPGz06qHN7yOBiGrtY3em/J393tE1AaGhuP7PBSJiHoftTb4T1MPH2ilD/J/joUG+PJ8wYaSW5rcUc0r+0Y1rvXWxiIMhRjmuo=
Received: from PA7P264CA0418.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::7)
 by PA4PR02MB6511.eurprd02.prod.outlook.com (2603:10a6:102:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Thu, 24 Sep
 2026 09:45:22 +0000
Received: from MI3PEPF00008556.eurprd05.prod.outlook.com
 (2603:10a6:102:39b:cafe::5d) by PA7P264CA0418.outlook.office365.com
 (2603:10a6:102:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.17 via Frontend Transport; Thu,
 24 Sep 2026 09:45:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF00008556.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 09:45:21 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 24 Sep
 2026 11:45:17 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 24 Sep
 2026 11:45:16 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 24 Sep 2026 11:45:16 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id E8F052B60
	for <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 11:45:16 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 6F667129F81; Thu, 24 Sep 2026 11:45:30 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [2.18][wrynose][PATCH] ast: Make PyLibNode support submodules in BBIMPORTS
Date: Thu, 24 Sep 2026 11:45:24 +0200
Message-ID: <20260924094524.1249426-1-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008556:EE_|PA4PR02MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: d45c9c87-b2bd-4591-9078-08df1a208d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	RZJLcA/R9tmWD49jhLqD9J7DoHVbSkDMg4tFnKR53Y8UJmCQrKwojjHQsQROcf5oAmyaI7fmvgFFB2+AokyYwtw1mauVpspSaZ/qNmqmwtm+fCzGcYv248K++Xyu7vvhiFYp3jFdW+iiej8P0oA8v4nyUmmx1VtM4NwS+cGxdMQerdGKYdZdzE+H3NBlAH/2+DJc3aJkIqbioLbsB/gvtNFDh05im9KdEX70uxnjLk7ZfeVXOQaq2UT6vVa3RlD6Uj2Gs/WnfVLXFsy+H0jkygXmUObcwATnvjHa1+Y03AJXcFnvl0Y5r6Xk7XZ7bl09Ni4Z7PUeU+gSDuqESAPcW2wGpSM1JAaXp1IgnTRiiDN7RwCR9ck/ApvlXgROK3UtYK4BdHz6kDlskplZK9xXUf3n5BNtn530uCwfVaj0+owRqpAYx8MTIyWkXvye2YZ7YTaJOtegM6GetGVzgBfQ1iv1boHFmZBcvELIfm2pT8E68XAUfWUjfRlnGdxOMi/jerI2HlL8xFEnTNyuZbT5UeL3ElQ2xjB97XiiR04DR5wtedB9bcj/uG0yWkAD7Qp8DUD5u3DVLMKV/Qsg4UteyT0a0KRhggm/8WPB6EsZhaY0WWqbZl/ZeL/0XB95HQlycUQcd0yi0udBVWo9xkkqzrDvqjVF2eABVkO13N3NeSq6EnHAq1CJ0ysqOtV729vl5qATvv3BBxFb7cCesn8kAg==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	XfJy+IPo1azuu7t/24oKJO1FshEwOkvYewWu9A7bCGe27OqAWgqh+whp2KDvpo5LhApFJcx0sOx7ooimzV69v9aga+MxUFZCdvo0iMu2WMXhOWCBmcrM9323/2qspbZE1f1ut35hnGfuPbFjTrrQZ6UQl1k58dY1X8YiHO2SXVold0/5GychLY3KqJAdcskDCybFnFqcIwNZC6+7Dr1sbUY8bC05IQj6Cto6C0AFH3SE3pvZFmeMhozDLPM7O7JI5Yj3zB47ijvR6aGVVGynOILSUNV2O7+KFBKZjtmmoRyXmJvtCljThxBn3LZkhqo2jKmBSV3qe5ieD/CJyEHsbFdwq1noQKGqEvLlXVZ/eicWs+EswU16TxFCBPqbs8fX6mLVccyDJyPfyG2cKHTuEGtD7kpFwxFicASEE/0qaVU1G4hHe5LZP5nKdiiQhQ1d
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:45:21.7035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45c9c87-b2bd-4591-9078-08df1a208d0e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6511
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Sep 2026 09:45:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20250

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

For a given `addpylib <path> <namespace>`, the existing code would
import all modules specified in `BBIMPORTS` with the assumption that
there are no submodules. This adds support for specifying submodules as
well. E.g., `BBIMPORTS =3D "foo.bar"` will now make `<namespace>.foo.bar`
available.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 lib/bb/parse/ast.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index e23ef6db3..a9cfe75c3 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -310,8 +310,9 @@ class PyLibNode(AstNode):
             bb.utils._context[self.namespace] =3D __import__(self.namespac=
e)
             toimport =3D getattr(bb.utils._context[self.namespace], "BBIMP=
ORTS", [])
             for i in toimport:
-                bb.utils._context[self.namespace] =3D __import__(self.name=
space + "." + i)
-                mod =3D getattr(bb.utils._context[self.namespace], i)
+                mod =3D bb.utils._context[self.namespace] =3D __import__(s=
elf.namespace + "." + i)
+                for submod in i.split("."):
+                    mod =3D getattr(mod, submod)
                 fn =3D getattr(mod, "__file__")
                 funcs =3D {}
                 for f in dir(mod):

