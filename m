Return-Path: <jhaller.oss@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93960C3601E
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 12:10:53 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.44])
 by mx.groups.io with SMTP id smtpd.web10.10094.1743768649405982401
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Apr 2025 05:10:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@Philips.onmicrosoft.com header.s=selector2-Philips-onmicrosoft-com header.b=Cyzd8b9L;
 spf=pass (domain: bbl.ms.philips.com, ip: 40.107.20.44, mailfrom: jhaller@bbl.ms.philips.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWL3MdCKdk1PPLJpiM+lJF7bD6MufosX7WUG3B9JlUmJEn6wpU7hnyKb8c/I+R8b1apOyGm8iNpz/EU12I77T5bFVomjRIske+IYj7IgUiMG0ykkSXw3IUtN8MIIORRAChHHEmFyDnPaTSzPJ+yD5f/oPOyirIFmI8G3tBjF6NkcbSeHIs1TQ9uQz5bAcNl2lfsYWvjTRWdWNrHg+iRUlXhrmDjE+poBSG/xrPLbfSut2JrX/rhr4ID9bcJ6v8/gTB6msRjYFZIay4UACNAp18TtIvUNfFhhs3WZXbFpwAnLwdarmY0TJ0tOBboUz+7rjR/3GmDPkY9/tFuEeBbQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA5U0lTxPv4XZo1YxjWiiq91A+7rLi5zP3SK3sqzK78=;
 b=uSeG2nelG0eaSebK4agtzA5IfVcZzzypATV+g87bGgdMFZmYhHYBFY2k2QVCl3TlROn38ETx3MtYKQiQykDUuteM46m2CuJk89zqFcUflvRwjHnTau2Fz/J4t4Vwhr5rc6CzbAOrYc2bLQu2DhoNw8Z/jt7FoIM7qjEOdk2Hpc3iUvLuUANcbJLe5h8XBZ28crbhgIjiI0ijTPtR3rnANyowU5lqH305GSkceGcNbf8QxBftL25ZQlsUDNXPGKAo+aTn5CoecomU7nlcyZvpMXAsIxqQeXK3HYOfzssRvITpxjLrc4UClsOM1SeuT7SnCVfoMBIebCMSVm+4oJI19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 3.248.88.141) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA5U0lTxPv4XZo1YxjWiiq91A+7rLi5zP3SK3sqzK78=;
 b=Cyzd8b9Lgw2z0P5E8DcrMA5O5YNdoUWBKCpBNIVI9HtnSq0xWynlvNlDHVe4LtuoeuZg4NOLmpnUZd3kyrYgVVITDFg56tvHCHlgZ1SIMkD2GOhq0slDZW4UBsMsJxn3WsPrUyq05JeldnbguANSwzC/6Vvzw6yGszk4cnFJ7X8=
Received: from DB6PR0301CA0076.eurprd03.prod.outlook.com (2603:10a6:6:30::23)
 by GV1P122MB0302.EURP122.PROD.OUTLOOK.COM (2603:10a6:150:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 12:10:46 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:6:30:cafe::8a) by DB6PR0301CA0076.outlook.office365.com
 (2603:10a6:6:30::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.26 via Frontend Transport; Fri,
 4 Apr 2025 12:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 3.248.88.141)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 3.248.88.141 as permitted sender) receiver=protection.outlook.com;
 client-ip=3.248.88.141; helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (3.248.88.141) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Fri, 4 Apr 2025 12:10:45 +0000
Received: from smtprelay-eur1.philips.com ([130.138.84.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTPS
	id 0Seeu8kyNQb500fsjuUHRI; Fri, 04 Apr 2025 14:10:45 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id 0fsjuQx3tFWGr0fsjuiJa2; Fri, 04 Apr 2025 14:10:45 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.223.70])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 7E508184869
	for <bitbake-devel@lists.openembedded.org>; Fri,  4 Apr 2025 14:10:45 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
	id 793E87C0086; Fri,  4 Apr 2025 14:10:45 +0200 (CEST)
From: jhaller.oss@gmail.com
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 2/2] bitbake: tests/fetch: Fix git PREMIRRORONLY test
Date: Fri,  4 Apr 2025 14:10:45 +0200
Message-ID: <20250404121045.1133722-2-jhaller.oss@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404121045.1133722-1-jhaller.oss@gmail.com>
References: <20250404121045.1133722-1-jhaller.oss@gmail.com>
Reply-To: Julian Haller <julian.haller@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039231:EE_|GV1P122MB0302:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c3f60357-5f7b-4955-b085-08dd7371babc
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|48200799018|7093399015|376014|61400799027|35450700002;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rT2Sl3/mALNphw2wTsuimrXwqojn1NWPP6liVfnqKGOtG/HvjN2/UDOMgbPx?=
 =?us-ascii?Q?Xrl41MoLe+zndu7imjaqhNMkkrl+XwRCraaV+d8QKBBPc4uH4/Q3071gu7Hb?=
 =?us-ascii?Q?0TRfddKovM2PBDhA6EC62oCWLK7NuMvrlr9aLX55rrmfHga1C7oP+UsPTP+u?=
 =?us-ascii?Q?7L7SkcLdnUjjpMUhyBn2nSyEWdBJW8RzvT5VuGW5LZ3qcKSVSAdKcnNEaE8y?=
 =?us-ascii?Q?3GcKgwawWnQ5Y83Nx/+RiZeRP5yqXasRMYPiVVbU5UUomDGz29mullwC1IKY?=
 =?us-ascii?Q?djwiOBSUrjTfb/bTQflKAgfGnf+ew2UiuDpEaMp1RK9vSgcjz4ujf8gjxfdy?=
 =?us-ascii?Q?pD4zX3QuUNaALEA2eTEzGH4N3JS4P/2kl9O6mjB/YZSM3XkltQ1R0vHjd8Hh?=
 =?us-ascii?Q?x1IYIucIh9H+hFyoHon7VEI8vOfQuIeJiyRUHnGpgvMMW7GALKuRhA2TWLdd?=
 =?us-ascii?Q?BI2E/VTcBfj+jRdvAwxc2SfVdDg4teK2QD62mR/Nebed4RppOkMFQUOq6dIu?=
 =?us-ascii?Q?sVOOZPuCFAAL3RZWiq1mb2cMYG6zmZxL4HK8ymbEELIGAZH87h8FRiQBN5na?=
 =?us-ascii?Q?mwnfOCibRZ4zpmpdsyiqhEIkGq8kVw+XCUf13JJze9JLWyD/CTHuxEe/45f3?=
 =?us-ascii?Q?7Aesp9GSU66WNbCWpYdaGTBw3Cn9dnnGGLqpJBIqvudk3FwSUgiQrfWFrpGU?=
 =?us-ascii?Q?l9VElQQLyajds1EW3bZL2LHb2kXPjDHASLG9QC+FMmeLiOrngevvbRMr/gAm?=
 =?us-ascii?Q?rYOugoSR8ytCGBqT+lQRqU88NB3Dj9rsrPHbYimZ2VpfZhpZ8eYayEeVZsGK?=
 =?us-ascii?Q?FJLbTZW9KrzZTHXo6Ci6fN5FHcLKw+iksCDdLupq93Ro58/3wdVtVDiSa2m2?=
 =?us-ascii?Q?N7AMEDPqT9n0HpLTUxhakjXdEQxKVfS2OCxXD4yYj6RFlpm6dpXcBRAhMRLt?=
 =?us-ascii?Q?Vg8Y13nxdCJ93lsM/Ogo2Dd3Ayf6xCs5ZqJdY2hT0+h+HQ+SnP51rBu2TaYu?=
 =?us-ascii?Q?S724ubBNYsgvvvByvoKMA/da3ny5pwQxDxQTZp2O/aDwiRzG9YKiIhwzOlG1?=
 =?us-ascii?Q?SoCL4PO25Gf3gF1auEusHr7QWzp8FfzYrFvp4+fqMQo/xmo8gvnBdvZOs6yv?=
 =?us-ascii?Q?sstdNxfqwXjOqJpq9GtZg0KJ5pvWYiMVdnL0i9eltu0kzGv3dhKtoKn63WBf?=
 =?us-ascii?Q?cCEde+jXq6L5vKf9WQHKwLcqKBJ2+5gS0Juo6fOY9Ps+PbJTkhINcRHQPKDl?=
 =?us-ascii?Q?1jbuJqrumoUgp46NrKJmbxaQ4DZiewEgq0mC89B4mQGjG4DbiwwWYWrILkJ7?=
 =?us-ascii?Q?mrTs2j798I68BBGhrIqWq5j3T5nSm0Dxf0SoTLFGZYoZJJVnzG2hXqpDQpXZ?=
 =?us-ascii?Q?gMgUWP4IN8oTyeUxeZWilppgzEGn8dTG4BuzzhGVnMAJUEsIEHXEeEbavTm1?=
 =?us-ascii?Q?8Gn2HAlOfN9V4XPfdGAx8/eKlinfnBS+6XKdUuZ4iahQ1qavYieJ5Qn+y01C?=
 =?us-ascii?Q?6559TnIChWspKC0KcwCRQc55v7ZYZf7Bpqwu?=
X-Forefront-Antispam-Report: 
	CIP:3.248.88.141;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(48200799018)(7093399015)(376014)(61400799027)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 12:10:45.7905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f60357-5f7b-4955-b085-08dd7371babc
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[3.248.88.141];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P122MB0302
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Apr 2025 12:10:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17515

From: Julian Haller <julian.haller@philips.com>

Using a shallow clone to simulate an outdated git mirror tarball does
not work in the intended way. A shallow clone already contains the
latest commit which can hide certain fetcher behavior. Simulate an
outdated mirror tarball, as the test titles indicate, by removing the
newer commits from the mirror.
---
 bitbake/lib/bb/tests/fetch.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index afabaeba18..d682b7fbe5 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -3276,7 +3276,8 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
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
@@ -3284,7 +3285,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
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
@@ -3292,7 +3293,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
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


