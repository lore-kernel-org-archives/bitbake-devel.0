Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A48CAC592
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 00:06:59 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.16])
 by mx.groups.io with SMTP id smtpd.web10.7555.1757981217307339939
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 17:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=TkdhW6Ky;
 spf=pass (domain: axis.com, ip: 52.101.72.16, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0AcGpGXLuQYtTOi/faI1vHZ30GZspF0m39PTvMJqsspoBi6YADDrb5EK0zHP4MCouwh3o32txZzGWH+2zSKXv9EYT4AdbdBKlqLglXTh6PBUNLY2nIyNqWJ4hFNazGlWnIPz9Cnt8Vpok4yV+tmWzyOTVQo3fFpokfTFoeLeVkNt+il76VtX5KDboqA1CnV6sjJk0Dqa9DKkt3TE0OatGrB+zBzK5jaY7CWt5ptBDByTPk4iq7QRWiSXOrFojfmdV9DHlAoXrzZ5smbsCwhXQ5TSawBeGbh2KCQo0wl6Z9/ZuxwaTEg498ApwZL7SqUkrU5veTfn9B5TA1ybmXc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PczG+Pl4paWa3vOukjhMjhH/AzEuOh8Ab28oNM/OalA=;
 b=mQxj+HzWc/bWAlXN2wTUPYf495M6BrPqyCnPNSYucoilCxcKHtuCXnCsRCybp8HVpmBb7Hy5cFwsKu8ZSR4s37JTXv6iQqfuWT1diDgbCJw6nKe4MZXec+1t3NAkhthRLLt7XoUYFQKR5zXAhVE+BOaR4jbnDHB8LKteqBDK+FZB3Ufw6u49gzopmBbauVLj7sLZ3/Uz/psfAcp7okTtGgo/G+3UVp9WTI5Qc6mQ2Gw6YiO5sTkkUcVtthq14veiAcQxadAajkmyZiBpHlMxx+agLudveKFyeB3g//VmHZx5c9z2E6lXVUfKNkHfCOxO/0xxfz1z73SuueGvwpuzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PczG+Pl4paWa3vOukjhMjhH/AzEuOh8Ab28oNM/OalA=;
 b=TkdhW6KyYqsRRQjb5QRtnyTivzejN3inqa7eVcHJm2gDt3GREpWJW3Mwka6yQsyUuXtebPSv2/EjTU4+lNPtCFFO5Y4vYfjll0V7G71A8ZYgWgiM4Hd/yRQwgmK73S7ZARSy5e0Zf4YVhbudBhjfZn/BgP4CLMO2tWiHKZO1Lzg=
Received: from DU7P195CA0003.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::19)
 by AM0PR02MB5937.eurprd02.prod.outlook.com (2603:10a6:208:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 00:06:53 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::54) by DU7P195CA0003.outlook.office365.com
 (2603:10a6:10:54d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Tue,
 16 Sep 2025 00:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 00:06:52 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Tue, 16 Sep
 2025 02:06:52 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 16 Sep 2025 02:06:52 +0200
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 236F222C5
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 02:06:52 +0200 (CEST)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id 920801204B6; Tue, 16 Sep 2025 02:06:51 +0200 (CEST)
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 5/5] parse: Make include_all support absolute paths
Date: Tue, 16 Sep 2025 02:06:48 +0200
Message-ID: <20250916000648.1182372-5-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916000648.1182372-1-pkj@axis.com>
References: <20250916000648.1182372-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|AM0PR02MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6fe26a-2410-4ec0-812c-08ddf4b4f0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qyJuhT0scwxbdln/so3pNfuuhLPZSOyTeVekM7QsZIg8LvTr/MNJGfYFWGhS?=
 =?us-ascii?Q?lzE5f9y1Gj1VHQZIODVveEiwQQQkKFzl5zsikQBPG6kOOWmqremyYEBP2O85?=
 =?us-ascii?Q?Ivlo1qSUO9F7OZ22DGq2S8YlXkb2EwogdSDes9G2haYYbhmukhpzIZ5+Ggpx?=
 =?us-ascii?Q?2SJOCeg7sODF78zTaJvVbl6xu1TU9UpwPycm0melPdW4DklZ/k1z6zty2TQe?=
 =?us-ascii?Q?UglFPFG0OBdLe7TekhOMpgyQG6Y8rfCCVJo0XY0/s3OUPW98mwPIIH8jgsTK?=
 =?us-ascii?Q?rGBg++gOWtrs9i2DVH6dvVjFpvq4dYTZB9rVk1kXYzZT97zbKzFeY+Qo4EkL?=
 =?us-ascii?Q?WY9OCiPBGHl5iK7uqp+wWwc2lTWGkGckwexp+KGISjqQ7L9uVc4W5YD+nOqG?=
 =?us-ascii?Q?izTQsE7D4T3Sg+GGvAp/zQEAcqSt79cMaE0xrEJi7Jsu8UaSMgvV4OygFegq?=
 =?us-ascii?Q?zpCHSP+hHrlRbOh1yV0IdrBpotELaGVvUhH2qBjcR0jmOjg0QLCNCeahMAhQ?=
 =?us-ascii?Q?ufSV6XpTF/HH61WZX0E2Hw+bo5CAdL/EOPkvvdjjVY3gdpxbRLtZmkvoZcen?=
 =?us-ascii?Q?kmZ5H4/ybmbzjQ5h7ews7oPyi/H1NclXKh8k2z8FYV309tp5+YtlUo6Tz9w8?=
 =?us-ascii?Q?8m1ukJ9jleouMdGHOboDPVN/yFL9UsEmeONFVvKzPXPRSx4HqJI6/i3snXxp?=
 =?us-ascii?Q?sPj4IIOmiFIcSVccXOdix5S9I6+HmpR2MaowtvCPJ4X7YbcMEjvWMJj8Gp+T?=
 =?us-ascii?Q?truUbRNr65MJW4vZPNo1r3VTfA574ajI2SVpy8iTbZZWmlCFHvwxzYMUADNq?=
 =?us-ascii?Q?/yxct+U1N1gSRnITFjPIVPBaLOprPCcQlEdddLD8/90QT8Y0R2gcT6HHks8r?=
 =?us-ascii?Q?z/D9JBt/iLxY38AF+Cib6PxdTZSAzk///o20gH7PBufjlhlvKiJWeSZJ48vp?=
 =?us-ascii?Q?KcR6d8aUHLiUb7qrrG3QBPZXeoA9PlayDgxTl5CkwclXpagtfV4uy3Ho5HBH?=
 =?us-ascii?Q?KtjSQCZsds5OdxrJTyOfeZETQ/iYc25E2zEZiM4qPE7nT2sNkHhVPj0yJ+Ow?=
 =?us-ascii?Q?wiuDMPvn9R5CPKjIk9TxN85TjC1F8/hb9t4x3I4Yc0ExJ7LBpFgOWsrkbSXU?=
 =?us-ascii?Q?waaar047oiIIakLcu3FriH9Sg4r6r3DlE5iY1A43m+9AM3+ZfxrkyDUIweoc?=
 =?us-ascii?Q?tWh0N9lMzto4kO4uqoS3JV70oU3RARGv7dSsRxQP5B/ChIDiesEAK9V7YWIz?=
 =?us-ascii?Q?sqbg+41nVjXUL2T2uK8kh1LQmY1vta3d23BLKf385nzn0pbNg/rXgB5CA9Le?=
 =?us-ascii?Q?h4OpMjZSwJPMAsiJ+LoA/beBQOPxJ9zRfWjQjeFP3QxKBEMAWtgBu9qBlTQ+?=
 =?us-ascii?Q?QAVBzsDDrNRK6ccNDFlnmOMbpiWPvh1QgQZFnX6ArmpOfgcJoGJyd4okfexu?=
 =?us-ascii?Q?/ZLe9AYZ55D+HSIvLuZd0e3FoTZif6Rq4uU4yRu6alaws7ffGY00vviOiak/?=
 =?us-ascii?Q?nO+IFz2rFSaCv4Au36gPTOcOcV7kwH94UE18?=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 00:06:52.5342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6fe26a-2410-4ec0-812c-08ddf4b4f0b0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5937
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Sep 2025 00:06:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18036

While it does not make much sense to use an absolute path with
include_all, if one is used, it should only be included once, rather
than once per path in BBPATH.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 bitbake/lib/bb/tests/parse.py                | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/=
parse/parse_py/ConfHandler.py
index af3af2ccee..caf526044c 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -67,7 +67,7 @@ def include(parentfn, fns, lineno, data, error_out, all=
=3DFalse):
=20
     # "include" or "require" accept zero to n space-separated file names t=
o include.
     for fn in fns.split():
-        if all:
+        if all and not os.path.isabs(fn):
             for path in data.getVar("BBPATH").split(":"):
                 include_single_file(parentfn, os.path.join(path, fn), line=
no, data, error_out)
         else:
diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
index 2f77c90f60..b4033f8cfd 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -500,6 +500,7 @@ EXTRA_OECONF:append =3D " foobar"
             test_helper("include_all someother.conf", None)
             test_helper("include_all some3.conf", " foobar")
             test_helper("include_all ${@''}", None)
+            test_helper("include_all " + tempdir + "/conf2/some.conf", " b=
ar")
=20
             self.d.setVar("BBPATH", tempdir + "/conf2" + ":" + tempdir + "=
/conf1")
=20

