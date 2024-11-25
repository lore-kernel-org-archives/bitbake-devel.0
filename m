Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C62D58D6E
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 17:22:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.74])
 by mx.groups.io with SMTP id smtpd.web11.24313.1732555353747269265
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 09:22:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=BL9lytWz;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.244.74, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2nwfd8/flyV7lZCjCzhgi5Qk0xAUq8wx9Yn3vf5DBb4S1Q3PkDO6pKub/Vt1WijSvZoJaMLRCWoFAoYlEZo3Vd4r58vkGPHoleJm1bzEyIKRW6mSCJvxN83O6WS5knh4QLGbzTufRQ/q4Ibz3Vm5AOiBxk4WiwO/edYJrGUklExa4bVjoNsne2Y+Qh0OxL3C5eIB8qSJkw9F52WFSRnjWswmhaInh8eU3BHx4MjP6/oN0TmBe1m1ASE3gItudIHsC8mCeydKbafudcf9qBQ0JCYcdZSlJKeGfdTr5/MQawWJOPBJRNjx3xu3ZIlkpMByQawBNPE/vLS8x5E22+9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFR0L+r362k99SUGX90JZxUt2Yw63p8Kk9psiNhi57E=;
 b=x1M7pKfGBLQ8KWobROhw1Y7zsYBVSb8qBCKx7qPIwJIWGj4o1+JQFoCgBV8uIgLjJlmLFVP/lrurPwbv9wb4ZOiNG+VJsHm52xNj4yKNB7BvyCHalUe/6zPrMK3fdge9I2lFxH1kYIGrsOnw31gH7oCaGWBAiaPRI8mes6uQJR4RU2XnoD5CcFnWKmlh7LEDuARpM0aIKoSpabZ/WA9wYlZtbSRcp6HC//soMZeNQimDctwN7j29QqLMYtQeOeRGLg5WeZaZioOV6V4etGw5aB/akFgWFlWsFb7sJPavg3A1OathvQkVmEI67JdsK6FM/mJmLY4zJMLozjzGm8ppwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFR0L+r362k99SUGX90JZxUt2Yw63p8Kk9psiNhi57E=;
 b=BL9lytWzHJUnYnrpXlduj+itFtbrLxGyr1tsWoydZjHPSWBFbGEIlEj5jWExvwSdNJFnImL7SZrTeK5tVW06YYvbP5o3kPF4iFS+tUOtG+WD0dYLNfnkRfrh7u4FPbfxkUkzNHVZcIO4rRy+zfsFbHs5Sf0ereHYwOU+aDJreZowY68ljwkL6KCWgHb/Cr9Hz+9dBayq4FSzhUz4FSx9rN4tHFcJYpzBz76rgWyGeiXjOzisqiBXfBTvI3D7fstpghVy5ZgB7EpFgeTuYwBZstoIOKRVSd8fCplWeax1Lp0+M/dpRmgP05tBwkCLkIVdF2MZQJHzqimJX0TCeNOajQ==
Received: from BN9PR03CA0430.namprd03.prod.outlook.com (2603:10b6:408:113::15)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 17:22:27 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::67) by BN9PR03CA0430.outlook.office365.com
 (2603:10b6:408:113::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.21 via Frontend Transport; Mon,
 25 Nov 2024 17:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Mon, 25 Nov 2024 17:22:26 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:22:23 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [styhead][2.10][PATCH 1/2] persist_data: close connection in SQLTable __exit__
Date: Mon, 25 Nov 2024 12:22:03 -0500
Message-ID: <20241125172204.1601601-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 33935f33-2f30-4bd9-57f9-08dd0d75bb7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UpiVriItJBYo9amiBN91cL+0EGRV1QbSMqVMpDLQ44pe4nbmw8b8Op/D8SVs?=
 =?us-ascii?Q?9H856mlQOtG3DA2uBEp9wio9IAsKu88xwqzuUUoe9DTd91LrD5f3T0L2eNzW?=
 =?us-ascii?Q?CsNkR1uluSW+Vp0/iRitfH2qVVz1ZdDdD8TL0rxngF3ytvB8rzb4HzLp650u?=
 =?us-ascii?Q?bNMWcmJEbh8H13p6+ZeFGQiLlyfRJxdYq/ETI3uW0VwW2e2JAQEwpG0zGAnB?=
 =?us-ascii?Q?eb0NoTNzCyklf7JFMrIXCUkJCivCFXTL2mHwUgjkfp7nedCscVEnItmrF7zZ?=
 =?us-ascii?Q?Z20vatYp5nMF1KFKybfoKdXtkUKtZuBJbWz8RgSB8hZahmck5vp2Xs3xfHLc?=
 =?us-ascii?Q?wZiFdtH6kqyLYgr81wUe7ZQJHTRoYUNf1BnbKUWgu9bjcE9T8iSVitQUJpmm?=
 =?us-ascii?Q?YtRNlEOvSdK7z7Ta+IzEW9aQrUa5u3nQMRI0VA3zfRqAM1gQveaR76QZ+xG/?=
 =?us-ascii?Q?+u6vWfyAL8chMvBPODCxjxNgBZ3DsL6jYZ0MeIoHylGvD0P7CKXBGCNjee0l?=
 =?us-ascii?Q?YKm/AUXfwmxLIDeZhheSyZ4wrrBZmP/RVRY/KLnIE1PRARXQCF0VSAsNRrc8?=
 =?us-ascii?Q?YlEU/Eoelc1+ZiUZeaU8ZI1wwN8bI4lpkNIoBB1O+U9JhAXu7TxUjve+OTmr?=
 =?us-ascii?Q?JGDYT7wF5XCUoel5kK1yUwo8Y3w7bd4MSTWJ+Bn3adAFBYCTwAEuliVNpdba?=
 =?us-ascii?Q?48XlAIugvCLPBdC5h/3IkgsPJA6cOTjQg1dRPY6zgYGGyGpD8s+YPOHTSI0I?=
 =?us-ascii?Q?KWpZGrM2vKdessjj1kNfk3rjbNSOj0bYRsIEVUSMbclNhjFXXtdAc8tTLkN8?=
 =?us-ascii?Q?oeeFhBepZQ/aWq6KIz2wtF37LCn7q5xVkl5mXH8BuRSMO4w2ZXL4BWJOLVCC?=
 =?us-ascii?Q?okC+ZV2QIO8x+P/B543RKHLbNA49Lt79Zvd+UFRw7fL3vvNtlmOLbft4lU71?=
 =?us-ascii?Q?6Mv11XBvVKvWUmBUdzW/ceJCOjOC53Gc3BVMIhEwyiztNm8DYNCPofe5sU8j?=
 =?us-ascii?Q?ocIPZUghXmoOEl4V6IeAXrddmfo3bCHMoFoBLqCKr1x35t5bE7MYFvpABf9p?=
 =?us-ascii?Q?WdSSv09jdYcTu612zDTfWfMHALLBLPprqM/NE1172hH+TSy4aKBmgih5igim?=
 =?us-ascii?Q?rV1xNDoheDteMTrirRZMkqIyEK4Q09Vg1ptCYIOTzIlL+yJfq95pkrl8hxrK?=
 =?us-ascii?Q?nVQbrDWjlVZppcBmGvStUiw9tC4NTmTKGvj/kxyeRHwVAZhTBuA5ny8RDIcg?=
 =?us-ascii?Q?JjweHAzlqfgv/Nh05sNsWncwEo4JJvHoT681L2Gwa7Xi71Ngv/NIW1Kw6rsu?=
 =?us-ascii?Q?Rj4g/Hs55M3otPygI7boi+cvdymVv2R0RbznDiQIjUjHtlyZxCP5YQcWW4dA?=
 =?us-ascii?Q?Mxn+KfMNt9RJasG+B6SHMGSjq7FlWf4n7+LBEvvL7vA3ehS1Ig=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:22:26.4054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33935f33-2f30-4bd9-57f9-08dd0d75bb7d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 17:22:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16832

From: Chris Laplante <chris.laplante@agilent.com>

A Connection's __exit__ does not close the connection, but rather deals
with transactions. See https://docs.python.org/3/library/sqlite3.html#how-t=
o-use-the-connection-context-manager

This change is not necessary on 'master' because persist_data was
removed.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
(cherry picked from commit b0fba0f5af555ff970406b5cf3bf8fb113d953d1)
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


