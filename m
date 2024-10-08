Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBE0CEFC33
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 17:04:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.46])
 by mx.groups.io with SMTP id smtpd.web10.1012.1728407044190478556
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 10:04:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=uRf73wZa;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.46, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhrfiFL6cOKxIk59VLTXYzkOxqeTIy5brKrntO+O0FqWErXvRKkZskKZhr80MygzkrjO8+jJdYxOxmrl/KVz/JCfdiXgfrhLVlrflvJqattaq9vNmb9YzTn+/2FRQmmT2k0mwCDsSMqdCjuf2EwVgs9IxOy7+6GMAE3DeYFLDMjlSqlgaix6k4wSyL/b3xr2jYJ7hcfZvFFXzXrRUwkygzRME7R+oGRq/vo9aLIGkz0PolmOgWRrjldLosbO08EEXfvNebCW7XIOHbAbyX4psYXJuud6x+Bjg1bbnq/5DusThpmN2Vs31uiqMPkG6X1BKrrZyswqMUpulUj4qBh7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gung9KRq6mcISvP1HepcjlEyHlnLbGQxOVLWtZvAqEk=;
 b=zVOwhEn1whGn1Wq3zcAJ4OtWNroiooCI4MfadxayxGgNda2NZ3LPzH6gtO2E4Zc+j7+RxJBERdiXGqUzGqL79Njxf53tfVvkfjlQIbfXBkuE8vc+wHAl8AAh94FtmWoQfQf6eP1S4aa/OG2KQ2kwAbVdaabIh3VE0q27JDGIaKw+IUYXj431yNlceICsD3l0JxDaCeYP1kc2gkC/2Xqr3U1fHXx4+amU+avNQNYRRAhV2F+g/EPCEj+IvsP0v2VUt4AqsYcvPzxgvR2Q78UJNAENUbYl+8t2XEsubXLXiuLObNN8yTQm2sPG6UvUKutmXiFJqMdtO3R18I3toYyycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gung9KRq6mcISvP1HepcjlEyHlnLbGQxOVLWtZvAqEk=;
 b=uRf73wZayDYTTbZg4km9ijBLqnQKf/IVeTz7otU4T7PeX3f/vGYvCzhlg3x0aM31lY9Wr7jnQwfYmq1X/z8m6F5mve5K5FnkqKt8GnlsCValZyb57SdPxy++FnmTLBsWSn6ZCyMXvM72fCi7jXYfY+vXWkoC+c3ygAGlRx7LADE9RKK64ahjGnaSKZdlJ2LiMnjIzo2GBKEqgOM4vcNcNE+6Fk1KuANNqMPV4+EhVEmQs9woTdMX30oMi8lKpoixZ3DtG3QlVu5ik4FjpRLseVhXR6G+DWJK7PD5xWwqSarDkWxPnw44jS7EacHBc5gpjIZacCxAU/bw0CSZMhkSGQ==
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 17:04:00 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::e6) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 17:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 17:04:00 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 11:03:18 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] bitbake-server: use with to avoid ResourceWarning
Date: Tue, 8 Oct 2024 13:03:14 -0400
Message-ID: <20241008170313.2392646-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b5a183-142b-4f0a-699b-08dce7bb3463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aS8f45wkUlJbYWEHpOz5HLkUXM/5HK8akYT3Wjl6Zgy63VQrj9BywSgi2c08?=
 =?us-ascii?Q?hM45V+YlJDSupLDVjXU0GhlK64GTXUr3NWtZETb+QIVLMnPZ7GP7ZFljySug?=
 =?us-ascii?Q?t0l6bPDJZrjqVhQfMDEWvp7NLu6+58YZVsry54j/1aozRhj/ozVWnE+hai3I?=
 =?us-ascii?Q?Cx0kpgLZy/heO7SLhqIYLLUpvxKYJyz0WsfClc9YmK9ERPysPT22FNDf3Ugx?=
 =?us-ascii?Q?3DwPynCtU5MPs9lc3XL59l9wdAxZ+AWBzkHV/LT2QMvPV4CobXpMJt0zp54Z?=
 =?us-ascii?Q?FxqaMaBTuNbj6+l3c22bz0hcFWc5GJJi7ie948CXaG6l/a3V2C6WauTgRFT+?=
 =?us-ascii?Q?wRTyPwMw9GZFTQD/kpY1kYqwTgfq9BT4+g7vM0qUqYm07nJ2/tmsJjh176u0?=
 =?us-ascii?Q?yBpMNyvz0VAaaHf3YcaFqeGjFVQprDI9VohyohmPapH2QueSqPwLK2SP6Jid?=
 =?us-ascii?Q?/ctO5ffOzOhSn5906b6p91Uy9fdKy+eTQZH3AIED+KbFEvm7baIK4j/Pszzm?=
 =?us-ascii?Q?++vbrYVE4yBIGMOg9/ARWEeKOOmgfRHnm1ZbNMKcscdYNIEbebPOXTr4m/ju?=
 =?us-ascii?Q?9Ewa6KnKg20VjN4tBC3bQBRoE2Q3MAMqqovgyNiqzqjvMeOq0PO0GSEvVxPM?=
 =?us-ascii?Q?Cw0otreCaxSUZ5+XnqSG4f8rI3keiRbDBsnw8Bz10EZ6qRBlKsgVhkSWYj6M?=
 =?us-ascii?Q?F8OYqI3+jimLhJ+4rItKtZPgnmr75r2y6xMTaJ40flluHEY1XNork4MPq+cy?=
 =?us-ascii?Q?2XWnAD6+04XhRVJ172Od3eVyxJUlSSPlnZ/9RcfG6rIGS5M61yVmD+g8jNHd?=
 =?us-ascii?Q?3sRkoOdXydZ7mARQlcnOPUdrdaoYI8g2boLZyrxkE6ka02ubPYJF6xTZBkfm?=
 =?us-ascii?Q?jo01HZBHEdihGV2rBrGQo34+VzG09oHDoAmtBfbZqi6DkSrVK0cDPkT6eWW1?=
 =?us-ascii?Q?sMFSAWNL0reOJus9PMiGLkUBC959qjdLvqnB/cscbdpLP2/81CRMSXyatWVm?=
 =?us-ascii?Q?5yBmQr6qK/Oand3Va0mDBNfhGhXc9nODa8QP6kfOPxjwIxuTXtowTYH4SItz?=
 =?us-ascii?Q?vx0+TZT2G36BWltO/QUqCKA1zWFm2UVLT6K+xEsJ078k20DM1Vi5IfeK5ItF?=
 =?us-ascii?Q?Fj4dTN+uAyDWLNy31kq6YHtoEVssXP/ON4bjcu9CadqZOAgKMaD9uIVxNCAb?=
 =?us-ascii?Q?5YBViubmOIwecGRtaq+/I/S5b5EwFRC8DAKUVuGvuRb/py8vWRTVHPZclBuD?=
 =?us-ascii?Q?neJJARIAr2E2wrWmOVddE9DcWGuZ1LHBpHmSeoAijuqDSQkn/2h8ucAIjyvC?=
 =?us-ascii?Q?V+9GFrQb0/uHxMS1sr7Tr61DQjrISsIBtOzEA+C2OAcEv3Til8ukL9VV2C2A?=
 =?us-ascii?Q?DSwj+X5XrehWmN040LRcfJC1eYPx?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 17:04:00.2036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b5a183-142b-4f0a-699b-08dce7bb3463
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 17:04:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16662

From: Chris Laplante <chris.laplante@agilent.com>

Prevents the following warning in bitbake-cookerdaemon.log:

2386729 10:54:16.195427 Exiting (socket: True)
2386729 10:54:16.201065 Exiting as we could obtain the lock
sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper name=3D'/home/lapl=
ante/main_yocto/build/bitbake-cookerdaemon.log' mode=3D'a+' encoding=3D'UTF=
-8'>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bin/bitbake-server | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-server b/bin/bitbake-server
index 454a3919aa..e367ec2c12 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -38,9 +38,9 @@ if xmlrpcinterface[0] =3D=3D "None":
 with open('/dev/null', 'r') as si:
     os.dup2(si.fileno(), sys.stdin.fileno())
=20
-so =3D open(logfile, 'a+')
-os.dup2(so.fileno(), sys.stdout.fileno())
-os.dup2(so.fileno(), sys.stderr.fileno())
+with open(logfile, 'a+') as so:
+    os.dup2(so.fileno(), sys.stdout.fileno())
+    os.dup2(so.fileno(), sys.stderr.fileno())
=20
 # Have stdout and stderr be the same so log output matches chronologically
 # and there aren't two seperate buffers
--=20
2.43.0


