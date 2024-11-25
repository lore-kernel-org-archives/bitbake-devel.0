Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC81D58D69
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 17:12:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.67])
 by mx.groups.io with SMTP id smtpd.web10.23800.1732554765028933396
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 09:12:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=WKbuQ2Ye;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.67, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpkLAODN+6HHzDMGVxAiS2kmDfeJkdyEDmNA8JfjWW8kj+jT+H4pbpZ0zkZ+9A70IK27tg7/gnDCjKVkaS5rqZINeHDrcQu/Sq3M6qt6lZTdfUImS6BPKsGBrkVE+dtugBQqMrF3mJhfsLfwyzkckLKNlNlDyVQtptyhrqGaOOBFblSQHOozwKhAHT3BTdVrig70Zz2WUbGUbpobv3+wL1GvoC9yUslhZYvMopkqgPQIrdjuJb04/imDmvwCzPViuFkCphEyVbydqippNIHLMurK5V2fvISsfR+99EotMcmOnzG7ljhIfROeNzMLrv1URHHChqxRpYzUo7FiduWEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWFA0nM0bvTnti2oEFoHPEssYIHLxnh+tirdZWKj42I=;
 b=FEGc+dUiog1iP1NKyQIRejshfGAqX4sXO15cU3MpDkwwd77ZG4PDFPyyIK1dg+7tJ9AIbKRKLEaee/iMzpcvLXIe2M1FCIqugXZC8nqrYRXnF6lnEKueZoPaPtjFBRH/DTDbF96QvwhNfCfTJDYVLNkf1b6EJbzQ4dtGKTGIspjW0A+6Xc4nkt0oW4TOZgBulLZbGtRIB7FbIa4GQSyXATDqFNWpx4SLKOKvOGQnKlvr2DEDhVDdm2wrMj+nposvkJpR5DdsTD0Dgmw/4EwmUtocuuPt2JJPbdmUctHECDt8Y9oKqPI1zVzgp6vov1R2OvUXpOqSBkgRkiB1BhohBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWFA0nM0bvTnti2oEFoHPEssYIHLxnh+tirdZWKj42I=;
 b=WKbuQ2YeDHCzqQU64VqV2GmEqfGwGLjV57HMOOwL/8gTlVuXg0vTMhSKITKS1Vf22QtBit45qew7aZ+mWh8QwBRTh8Q/HkYlxRwIXuMr0lOB3FWWCGdNBm+kplJNc+gp50kobyuNtD9cHZPBXo9iy4X/ZqyTVckM1lknFobNB75V9xNNpg45ysyiDs5092e0GSLAQaUiBcUjP8uARtNAOg2dcKEmgGS/ik746E3RApLxuJD57gdRkNL17jUdkbnFIUYKNXB3JOuUYVHa09cR38RzewUYalQ6fRuA0BQd78UZRSrqCafiTVlbFql+j1q1Ls5tPwWuHhL3HhlY34pZ+Q==
Received: from ROAP284CA0256.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:f1::14) by
 DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.18; Mon, 25 Nov 2024 17:12:35 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10d6:10:f1:cafe::1b) by ROAP284CA0256.outlook.office365.com
 (2603:10d6:10:f1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend
 Transport; Mon, 25 Nov 2024 17:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 17:12:33 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:12:31 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [scarthgap][2.8][PATCH 1/2] persist_data: close connection in SQLTable __exit__
Date: Mon, 25 Nov 2024 12:12:03 -0500
Message-ID: <20241125171204.1263284-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b67b4b8-c39b-4384-fe6a-08dd0d745a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rNCyS1chu2QqjgLzf/e6YsEzLnaC3kpYHoNHEHb4+4sQOurk82iugBwswVsO?=
 =?us-ascii?Q?lOLe/E3qZLqE+RIo0pZTi9EQoKc5RgivrFOPoEleOUa4wBx/r8hE7Xc/i/Nk?=
 =?us-ascii?Q?zcC3DwNJ84nhOamvCnbmBuKUo4Y4ldUZ3OFnkaTAO+ZRWPi5WyWPUES9rnyh?=
 =?us-ascii?Q?+zxcly7xjUMkXGr3JF9T9sBlvigAjiKGaBHzmbTDCY4FhV1jsVsC14CqT6+C?=
 =?us-ascii?Q?fhvwKyp9z1KsxK/mscVfZdopIxVwArYiV2Ut9xBz8Hm2+7tsLWVQ+PTCAMBB?=
 =?us-ascii?Q?eHYVhlSMZnbWsaFI7vo6qovVuh5/PCXVdkHQ1aBiTtd3KuFTA424Aw7YBQjS?=
 =?us-ascii?Q?BMzB6ruidRNzEA+Q/lZqs8w0s31EPxc1q2JEyDIQnSABxze0yDuvlwqkDyfS?=
 =?us-ascii?Q?HLzxiivbjblTtv9oxDhrs+VL+2du7K4V7UDTCTK+xdmBQY6DCnvi2yJlFfQS?=
 =?us-ascii?Q?wVjLpD5LNngyK+VpzgYlEkDi9ciXSlM+PrV2CMpYVLl7EUU1SfoR+8r2S50N?=
 =?us-ascii?Q?NP+mp3Kgq5elPCr/GwjVvLxK2hOMn1Bq8438Gpi0VV5RorO21TTniVaVJ9TG?=
 =?us-ascii?Q?wX8IeCaE7/aWC3JJ8bhAMFfRv/f26JGAmOWy/Z8qNljYhWmrw+XVsw8nOSCd?=
 =?us-ascii?Q?vvpfqfblWQYM4jS0SRHOHnlFHCpeF+zzclUYdAM65Nqo5RFJMEMcJj9RcnCA?=
 =?us-ascii?Q?Pzvr4RhfURBKg83zrfTc9PrS6NBVtlL88rg27Jkmf33KWc8ulAnxtlThom1s?=
 =?us-ascii?Q?YSuMq95r/UlCR8O5L/UFAFMGxyHXgR9sf8fdeqFDWBC6ZK2psqkdg9GnIS+M?=
 =?us-ascii?Q?4Vw0gCZPxx3wkz8gVxiRieF97luNedS7ItfKwWzaRCNdc3/o7LScfTLXeDeq?=
 =?us-ascii?Q?p4Ta9EedewH+dkzWh2CDHRR1ByDt3AKg1eC6dN5O3N3udoPkk4vRqLmP0Orl?=
 =?us-ascii?Q?V2jrK5j58Mega0aSWeEW4zSXYemc1fYf4FRVX/EHp7IDZW+NlYTb4rjKCPFF?=
 =?us-ascii?Q?JO6aVj7OAVJKWwVt5I+VV6Fz5P69HdgVvnK3IefHgEmt8zi35OcaFO6i8BZP?=
 =?us-ascii?Q?yBp55Gl/l0sujCk9n79rNEaT2PDLfpCqoRwg8fnW9YWUWkmd7joAQ2WWJ/gW?=
 =?us-ascii?Q?b0o6u9dhGUtn6Jyl8hhsy4oR6EOIQjofzgFqjGTXfVUAt5qBWyt9kX1Pz6I+?=
 =?us-ascii?Q?da7ypt0QoQlHLhzysrowPvOT08/q6N9LVOEVsfr+5mU8Xnwss/elNH0QQ1Kn?=
 =?us-ascii?Q?sOJ81m9R63XnXL6wVNMgsxXxWtdDGzpMNtrE+uuHJHnxeTNKnfg0eX7uKDPC?=
 =?us-ascii?Q?5zJjt+TwZ5cQrxM4VjzfQ6YS0ArCtXmT3t/4Tnknizi6qZED4HGaGOPxJ9EM?=
 =?us-ascii?Q?ZNBBR/+3NRje+8TEZr/d0FnfVCzNSC9PVhCKBls1qI5OCl+ebw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:12:33.3850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b67b4b8-c39b-4384-fe6a-08dd0d745a07
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 17:12:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16828

From: Chris Laplante <chris.laplante@agilent.com>

A Connection's __exit__ does not close the connection, but rather deals
with transactions. See https://docs.python.org/3/library/sqlite3.html#how-t=
o-use-the-connection-context-manager

This change is not necessary on 'master' because persist_data was
removed.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/persist_data.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index bcca791ed..c4454b153 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -154,6 +154,7 @@ class SQLTable(collections.abc.MutableMapping):
=20
     def __exit__(self, *excinfo):
         self.connection.__exit__(*excinfo)
+        self.connection.close()
=20
     @_Decorators.retry()
     @_Decorators.transaction
--=20
2.43.0


