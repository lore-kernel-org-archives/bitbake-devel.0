Return-Path: <jhaller.oss@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4CC36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:27:41 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.43])
 by mx.groups.io with SMTP id smtpd.web10.48820.1743416851595199391
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Mar 2025 03:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@Philips.onmicrosoft.com header.s=selector2-Philips-onmicrosoft-com header.b=B+5MVOcP;
 spf=pass (domain: bbl.ms.philips.com, ip: 40.107.241.43, mailfrom: jhaller@bbl.ms.philips.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYCunBgD3pas86y/2YmP0Sp6ZLqUwcqftDrNYqsxhGrCuEGBGCYGL0T5GZUZSzMg0w1lyU5HfoAYg6ZDK8bKJLg9LrY62haShQi/VprRzqPDcsFHdeITCdp/R1TeiBEITAn5Bt/PJlwPu+nFHrYrkSscYs8SS3vOPknvDOluvNQv+TFugwfInjhkBCBJznRnf8+UVjql/a0p0fVymUhWvZ943u2ovGk2Nz5aZFq4NY5FplRbBY4QipQ9PdrwAtqB/42bKOxRT90E9q7H+J7JoBIPaMxblsX/N7KeNNdszmA6v6mU9shOe8Z5T4UMMUCA6LnMwGqk1Av7eENj+nLTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/M51N5ll21XrHf6JM0Vm+nlmRJ01LWbywvbHI4zeHY=;
 b=iixlkeaLP9+HeIJLxJR6NO4pdYz/rbCwEBNa/VA+9Vlr9gz77pU8XNRd4p3a0+1OG5epIJri7N+7DOdpxL/kx+tl1OBu1idlXCmLgkTnjK+AC/EV35hxtOlNsUu8fQmoQIFUqQ0HdZ/9Z62PXlcHvfxY41WWP9bsWhNlP+EN5QIZDrDaMSYG9o8P4GCdcCRmY81RKyGEd9E1W25HwB5hLatQm5ufXcA0ohm632iKZ4YwocldhPiNb0Ra2moAwlRQnflqNuyEKN6wKGlLY1aWE2JPwnvzyW62I6Q2dVjTKWXeI+gOr3bCLuNIKPV9eUTIYAnUPWRE6xYRPptg1HCSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 3.248.88.141) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/M51N5ll21XrHf6JM0Vm+nlmRJ01LWbywvbHI4zeHY=;
 b=B+5MVOcPZHd0nAbXezFQnblAoY39tCC4jJpyC5+c6FpOSRar3T3hDg1ZmBcL6H3mLF7S6Lfce1MwNVP3ZVFgXjYVFTXhVJGDQqMv7vWjq8sNjBXE7TiFNAEFaD5kOZRTfNghaxioNng+u2mD2tuOcPqO8fgql339CbSNq6H3xXw=
Received: from AM0PR02CA0025.eurprd02.prod.outlook.com (2603:10a6:208:3e::38)
 by AM8P122MB0262.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:229::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Mon, 31 Mar
 2025 10:27:27 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:208:3e:cafe::d1) by AM0PR02CA0025.outlook.office365.com
 (2603:10a6:208:3e::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Mon,
 31 Mar 2025 10:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.248.88.141)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 3.248.88.141 as permitted sender) receiver=protection.outlook.com;
 client-ip=3.248.88.141; helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (3.248.88.141) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 10:27:26 +0000
Received: from smtprelay-eur1.philips.com ([130.138.84.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTPS
	id z4Rnt58UvQb50zCMYtHXFG; Mon, 31 Mar 2025 12:27:26 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id zCMYtLk9rFWGrzCMYtUszU; Mon, 31 Mar 2025 12:27:26 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.223.70])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 3A5CE184836
	for <bitbake-devel@lists.openembedded.org>; Mon, 31 Mar 2025 12:27:26 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
	id 2DF617C01F9; Mon, 31 Mar 2025 12:27:26 +0200 (CEST)
From: jhaller.oss@gmail.com
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake: tests/fetch: Fix git PREMIRRORONLY test
Date: Mon, 31 Mar 2025 12:27:26 +0200
Message-ID: <20250331102726.1965866-2-jhaller.oss@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331102726.1965866-1-jhaller.oss@gmail.com>
References: <20250331102726.1965866-1-jhaller.oss@gmail.com>
Reply-To: Julian Haller <julian.haller@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|AM8P122MB0262:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f256368b-4e54-44c2-1bd6-08dd703ea220
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|48200799018|61400799027|7093399015|35450700002;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oNt7DN5CX6aV/mB3ScjFak0Y5d0mRyv5AGWNyhEE4cyPXclAYuzf4Vfwss7e?=
 =?us-ascii?Q?fFyEroOWmKTKCaKaL/qcGQb8oK+e+w7FzkvEXvGURf/DsWRKm3toFMz3I2sV?=
 =?us-ascii?Q?GaTb7fKpLPhge7NewUulAxE60zW6tSn5y014FjTeP5+W17+URExVBgX60BlM?=
 =?us-ascii?Q?wp12BPfS6sHGxAjHIe3sGwTzaCgwYvnbOKysKaNkisRsKGchjUhypByBI0oK?=
 =?us-ascii?Q?RPOT6QkYN86k3weELU1Kf2+fO+e/NRIsXCDPGSwjZU1ipZriXa8DtjoTxZWv?=
 =?us-ascii?Q?ay9tT7iNQ4QiKcghVyJit4OB81Kz/v+v8+mg9TFAquaMw2gcSYJyG+lpzbUY?=
 =?us-ascii?Q?gQIUpiutiGgcJ4bPQGNT3PWvVjnFvTT7w/W+wo5l6D4nwA/WlP1haKyJsn4R?=
 =?us-ascii?Q?oWWaPsex62zqW9YItaSPMtHyRn+M1UQ08C81Ai7H4JFGq/G13lBB+cTiACu0?=
 =?us-ascii?Q?WJMDHKHy5XivsXl9+mZ7Gev13FbxQEm/04mWwM2uWiV6IMCnNY5mP386d9XU?=
 =?us-ascii?Q?d4gVUUiAmnvfLeUIyK7q76N/cnVfYwld59L7X/AYLB20Urtc7uFa4sE30f5G?=
 =?us-ascii?Q?YzW4tG32z5DZE/NZhxqeG1fRZzEkLATe6w2kHl9hc14TeXRatlXFNGec+Tev?=
 =?us-ascii?Q?fFtHuuOZYmnjERuQQGI2cOzu/HhE9XuwpXcXjRsQ31tS4yLDDWKqRg3O431R?=
 =?us-ascii?Q?MokBZO+mFGlesqAMoF1Ybv4Y77p2M5MI1iJFSUhbYMYzMM2AnNplr/NmE2tE?=
 =?us-ascii?Q?5qgxw13Cdw8EqxZkeB/2KlANfdz3BbBxF19apU+bi246VAbBOOZ70Wo7uAj5?=
 =?us-ascii?Q?BUJUyBeBM4qmfGbou44WvyiyaFygGItBD9sHreQUMNzFwDWjS227n1XZ15E/?=
 =?us-ascii?Q?MRESkVjnk8iXlo5/0BKgVnyGOpV83ySpGJcJy/B6LQGE6mjZ7Fw7Tc95kGxQ?=
 =?us-ascii?Q?Q08JoS+wyXIxDQ/GMOaMqvyB8VpCLM1argBQbW8j4dKVaiDkirSYy1MajLDw?=
 =?us-ascii?Q?8sPcoQ6E/3QwBJ64kkU39BLDwrBPhgRJRP5A+bPli7lpvp9y6VqcYt0rc/a9?=
 =?us-ascii?Q?5p/Fi5CaNjq5ZZGNbn79wjDbhEB/0UxzW5SkrWYcw1o5Wb99p6EGjXf1XbdG?=
 =?us-ascii?Q?8RsPmm+x70zaa6QWJ1cLB9Sahhvk1DNd3Y8arNIVEuOUSJULLEz1/MfSpjCP?=
 =?us-ascii?Q?Wk0oK5otZn1WdGzjGB5FkFv1ZwAACYJblJ3kuiAyEDWNCmYRzWGxiMC9oHyM?=
 =?us-ascii?Q?aP569VpZxAi8X5XTs2AhYkFcRjRxNGCDaX74sNnQy1IYbYwS6T2bfzmNdWYu?=
 =?us-ascii?Q?Y9w/j3i0FMd7eBuuXb7tzkQ3Y6/v7wWZfZcaswAcI+Cidq7cDwEmCVklyOnK?=
 =?us-ascii?Q?zHZr134efIyPfNNusHK0T5EaH3dHOmtvNfDADggbgAWsqVcHH9gRWA+u7Zkw?=
 =?us-ascii?Q?rEXhcxU59TTuXJ82yWfErBPXWNoU/8AqmA831QOTRXUsRTrPi7QWkX9WyvFq?=
 =?us-ascii?Q?QLNOB6cEuROR5L4bsR+xqRHle00navDhowOD?=
X-Forefront-Antispam-Report: 
	CIP:3.248.88.141;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(48200799018)(61400799027)(7093399015)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:27:26.6306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f256368b-4e54-44c2-1bd6-08dd703ea220
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[3.248.88.141];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P122MB0262
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Mar 2025 10:27:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17505

From: Julian Haller <julian.haller@philips.com>

Using a shallow clone to simluate an outdated git mirror tarball does
not work in the intended way. A shallow clone already contains the
latest commit which can hide certain fetcher behavior. Simulate an
outdated mirror tarball, as the test titles indicate, by removing the
newer commits from the mirror.
---
 bitbake/lib/bb/tests/fetch.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 65339d1bb1..8de6862482 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -3290,7 +3290,8 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         import shutil
         self.mirrorname =3D "git2_git.yoctoproject.org.fstests.tar.gz"
         os.makedirs(self.clonedir)
-        self.git("clone --bare --shallow-since=3D\"01.01.2013\" {}".format=
(self.recipe_url), self.clonedir)
+        self.git("clone --bare {}".format(self.recipe_url), self.clonedir)
+        self.git("update-ref HEAD 15413486df1f5a5b5af699b6f3ba5f0984e52a9f=
", self.gitdir)
         bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir=
, self.mirrorname)), cwd =3D  self.gitdir)
         shutil.rmtree(self.clonedir)
=20
@@ -3298,7 +3299,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
     def test_mirror_tarball_updated(self):
         self.make_git_repo()
         ## Upstream commit is in the mirror
-        self.d.setVar("SRCREV", "49d65d53c2bf558ae6e9185af0f3af7b79d255ec"=
)
+        self.d.setVar("SRCREV", "15413486df1f5a5b5af699b6f3ba5f0984e52a9f"=
)
         fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
         fetcher.download()
=20
@@ -3306,7 +3307,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
     def test_mirror_tarball_outdated(self):
         self.make_git_repo()
         ## Upstream commit not in the mirror
-        self.d.setVar("SRCREV", "15413486df1f5a5b5af699b6f3ba5f0984e52a9f"=
)
+        self.d.setVar("SRCREV", "49d65d53c2bf558ae6e9185af0f3af7b79d255ec"=
)
         fetcher =3D bb.fetch.Fetch([self.recipe_url], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
--=20
2.43.0


