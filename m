Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4FDCAC598
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 21:19:47 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.18])
 by mx.groups.io with SMTP id smtpd.web11.7530.1758057586507908028
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Sep 2025 14:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=U/96pXa9;
 spf=pass (domain: axis.com, ip: 52.101.83.18, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiFdW8Uaeb/bb+yUIJY/CkjUUVwGoie3Jn5fnhRVjGK24d5zjvzbA8RvdKaFvdPxbPu46/tpqGUqH8Di1EbGMcu+WRTps8W/VP9SlF3cSydjV9Ktx9X2WoY58wbr5Ruo2cdtMcQjgS8pv7PI5B0JHNA6CIer91Aj4OGZ5/1CjLmn6dqxwuWrY6pg3XsiXfprgF0+7ig0yczBM1FPXED0p7/MHGXFccsVskppPg/IciSmDpyI5h8ChCH0ee8tJ1as0BeI0lL8oRtJprMTK6MCbGri5iMZesa/ABsTNykSQnBDgTc2bk+nlBuxTKdqqaAR1GCZ89+bE/v1bCvd3qX4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpAHA75Bw55NJb/quO4TcU+FN5WhlToqpC1o41DsilA=;
 b=jk7k1f0P+tHcC16doZhe4GjQBIIeZTe0aybg3l1vLzOEwYa5Rt9vgFUriEvDQvDra9EskXXz9/9WyfRLtGzT5b5DYxOzbh6S2Pkda0gcJWdVIAQTpqSWTnelonr+ZGR8Ik0lU1sO9DckcGjp/24S62UwngM/vkIA0q6XB8sPMyTl5CVdbgsz8RuHPTwSXuFK1s1q6GCUOgK5cgvGHllethuB2zBQ7Uf8IPwqvo3KMj5oxyLfbmw0pabdLQtTwGlZ71IOakl6D2gsI3a2yHHXSxLvO5A2qOrU40/CmmvxcpQCJsV5l9PqNU1gDHRmgGxhwsHiGoz2WU5ep858gWsobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpAHA75Bw55NJb/quO4TcU+FN5WhlToqpC1o41DsilA=;
 b=U/96pXa9x4qNMcqLIyH/WEdp3QyK4V3MA07MQTmsZcihJJiBANLQfk2A23FMdmfG3pxXkTWYARtLZLfCM1LJPqP9VPpv5SWeGdcY7yBXWvgRHOnu+iucMeVUdFC4ULDkV7vC/YxfIUIpP40snwhiNRSTsmXmGwW2zXW6X51eKeU=
Received: from DB8PR03CA0026.eurprd03.prod.outlook.com (2603:10a6:10:be::39)
 by PAWPR02MB9927.eurprd02.prod.outlook.com (2603:10a6:102:2e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 21:19:41 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::b7) by DB8PR03CA0026.outlook.office365.com
 (2603:10a6:10:be::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 21:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 21:19:40 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 23:19:38 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 23:19:38 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 1CAFD293C
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 23:19:38 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 83DEF12024B; Tue, 16 Sep 2025 23:19:37 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 5/5] parse: Make include_all raise a parse error for absolute paths
Date: Tue, 16 Sep 2025 23:19:34 +0200
Message-ID: <20250916211934.253650-5-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916211934.253650-1-pkj@axis.com>
References: <20250916211934.253650-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|PAWPR02MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: a485c611-e697-470a-c51c-08ddf566bfa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/gWGDSYzwp49GPnyk0wicUXtXKv60u4WaSEcefAIzVbDWlwTpnckwsO9Bl0W?=
 =?us-ascii?Q?kN6wA0AjxelO3yRNRX2CfSC3k4xoLJy6859kT7m+FrLcUatAulNq01/6jBPs?=
 =?us-ascii?Q?2fgHsbu05uDQuG1WJuYb5SJsS5QPVhpLNgS2WJNa8oMDfiZPE8TTG3LTMrxy?=
 =?us-ascii?Q?/ukXPDLDlXxn5+w7rGSfJP2jGCWAbv04r96TT+4UgBcfbeYIRV3DXIz+5iaH?=
 =?us-ascii?Q?VJk24Otmm8BuqN6arStg60vsOd/xW4hL8sUhBij+62aC/3W33/TvN94Vxt+5?=
 =?us-ascii?Q?jhCcKary+uStPCcJcVRx1WTfw1nEBwoHRafn0bVMEQJUddWLeteADkhpz3ho?=
 =?us-ascii?Q?1bVuukNSsV4ruwHmLBLdXYcyHbWbE0+OfeSRnyehGsUZKLU0OZB8v+qsGvIP?=
 =?us-ascii?Q?VBb6V+9Bl9iZrFvU2DIkb6OQnSelrTeOEFMcWEktCPtCEs+W9uI7wBg+Ikr/?=
 =?us-ascii?Q?j8hkFRh8mYVPJ6Aa9lMhupXPQbduiHGUWJmN4g1Y94WCFT271oQh0Zwy90pI?=
 =?us-ascii?Q?Gs3RZuJ+fexUKdlQ9CVnz6b132jW6petYZ1cIO7Es5dGXYTdErHvFeAHG3zL?=
 =?us-ascii?Q?UI59hwxRSKm0vIGDjLLL8VjZi8caEJEw7R47AxWj9+tNlCbspDSjQDlApEbH?=
 =?us-ascii?Q?HGC7waw8IUAKaCC0n7qZSYEYfkazAKij8jAB6SyaQQPCnEv+wYkxFxMit8zf?=
 =?us-ascii?Q?r1JNxRKAF1Mv+tgMTvhffuU52t9Cr/K4tq8XYyG7UjcA94w9x+5VixTqqP7p?=
 =?us-ascii?Q?GhQoX+govmwALLx4i9SFRPYiSi9tYun8wBRCyABWpgah+R4hd76ssFpZa66m?=
 =?us-ascii?Q?xzPrhIHq1SiCfWcvnZA8E4cUqm3Ldp1D9Ll3K6IhmyULptJMHexe2IfUosX5?=
 =?us-ascii?Q?WRfEqJAImivn/8IP63jnh2riqJam6eyRv3dxUQZMspbF5Kf8nH8l0lu0E2/X?=
 =?us-ascii?Q?KTRs+ZSVflJAQGfXVEXXnj+oE3pMvHv0q0UHkNDEDNqZsjjmd0IyQjd/tjP1?=
 =?us-ascii?Q?zswJ8hIWY/7FbVbpgFRO9pYovkL1LknggqbsdJEXqSvkVeJMWHB6Fede5usp?=
 =?us-ascii?Q?JUEsp6ME7QV0lu+Gmm0GDofBaQX5huU1UCK3NejCxL5gvKFcuAxJVTpOngZq?=
 =?us-ascii?Q?N1vcFW53w7eWitBtCJWc4Ki0D0/Q73G8KkMc31ie4caNHfSxN7QXTuOxTc2v?=
 =?us-ascii?Q?M4ttullULcV1bvjktFg2jkSak8Pa55EqOS1TIlAbL8IGhgGV6mrCZvjpbybP?=
 =?us-ascii?Q?+Y5MisYd0zGXuMVrfpN4ifP86Bty7Td9HjogsYAvUgONXup6r2LUTI2cMWpR?=
 =?us-ascii?Q?EXx9g7zi7UntIT9Q5vmR5eLKhKjeMTask7U9ouI/rZtX86M6Gs7diRwuBOdU?=
 =?us-ascii?Q?jJaCATKt+nKHrfe62RhTANR37foUT+6T4mXdzoiOgXB9CUPWoXJ5vdEgAET8?=
 =?us-ascii?Q?C3MNmePAjM+y8FqHV/MTgaO6jPNNA49Dn9LoCcf18OqffIR29h9Sp3aZedD4?=
 =?us-ascii?Q?eGJiGBBlBc03i5mMmsJHLo/cU1AWfKwWRZSt?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 21:19:40.6459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a485c611-e697-470a-c51c-08ddf566bfa1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9927
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 21:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18048

It makes no sense to use an absolute path with include_all.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: Raise an error instead if an absolute path is used with
         include_all.

 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 3 +++
 bitbake/lib/bb/tests/parse.py                | 1 +
 2 files changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/=
parse/parse_py/ConfHandler.py
index af3af2ccee..d876f6c1ff 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -68,6 +68,9 @@ def include(parentfn, fns, lineno, data, error_out, all=
=3DFalse):
     # "include" or "require" accept zero to n space-separated file names t=
o include.
     for fn in fns.split():
         if all:
+            if os.path.isabs(fn):
+                raise ParseError("Incorrect use of include_all with an abs=
olute path %s" % fn, parentfn, lineno)
+
             for path in data.getVar("BBPATH").split(":"):
                 include_single_file(parentfn, os.path.join(path, fn), line=
no, data, error_out)
         else:
diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index 2f77c90f60..d6bc5a38bf 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -500,6 +500,7 @@ EXTRA_OECONF:append =3D " foobar"
             test_helper("include_all someother.conf", None)
             test_helper("include_all some3.conf", " foobar")
             test_helper("include_all ${@''}", None)
+            test_helper("include_all " + tempdir + "/conf2/some.conf", bb.=
parse.ParseError)
=20
             self.d.setVar("BBPATH", tempdir + "/conf2" + ":" + tempdir + "=
/conf1")
=20

