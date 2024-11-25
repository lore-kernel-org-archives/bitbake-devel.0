Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DC0D58D6D
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 17:19:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.43])
 by mx.groups.io with SMTP id smtpd.web11.24233.1732555175193356704
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Nov 2024 09:19:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=byvSb4dj;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.43, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgPJdJSp5oD1wXBiwzXvOiUywhPYbsxvvQAD5JE43WH8YsvSNGBWk605kYkB3U0t+ZHNhG/iyeGX7eKlOWAN53StIFw2AbOhHPr6tRn6TIlKMrYX7VX5xlgPA1BgSKMlhoPkv3j6MzQC0UYDGM19ezzccb0/FWiR/C2UxVq5dMklwLB/VCc05osjvDnFBLhJQyodwWYP9Ce369o/OUWYlG/ZP2i0rqJEPCa8wKlRlaBbygRfVzrSwKCj6q+Ih1BooIqA7x5ticKKxD+kWp6cSJ4ZmHjgO3Ju92+hNdNM9SQfOOf8PXV55y9rJ0/ywnhitKYmyO6pBvxv+L1Ru0BlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xiby56bHUEI2CwueM09nLvigMVM6RVVWHa7N3hAyEPQ=;
 b=L2vTfWPWmKedvynhviv+97SWP/uaKCp/hDZ/Yoonf2VUZ3DhRafeNajuFg99Zh1X4wJi/9iZ54W3Mzvy8RPNJ1ZeTWZ6PFe8b6rbeYaCR5aSccrAUQMpVSHTcZlj5dZyNi2U5JqkjrjlYLkVDNcbXDEkmZUB+j6OzlWJgsvLESl2KfK73ViJ/cC4gYM8OFZC3JPXEOIz+N7rgT7a6RR+iM3VPyVNG9mNuoFKsm6nGoLOILkbCviLb3Ruhm6hHn6UuQvNFjLnBw9x8Bm5F4AEGdXIgDX8ya1FQzTgcd7UUZPCpn5MurGMbANxVTKmk3lc9RE3iAiJCwbCWFJGY+Rg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xiby56bHUEI2CwueM09nLvigMVM6RVVWHa7N3hAyEPQ=;
 b=byvSb4djJnTjHM0Lho4XqI6QmkixzUBcsBNDlaXJpuH6AjYBlMOlIlDzkqXW2wGFGiUHAecfjPto8KPNu6w7EqQohdMP0y7M6ekF5jJEw/V/etPa+a2H4Ay0Z60M1kZbJ/IPBg87GFpSjTFU6QlB+sVyxYkLJe+ZbAOvJsdbJHyWcORRuYWQksxYdH5vyhejyF2NTtp6QeFFACiUFX/AhzZBDlEqEn7dB2Kh4zB50aUmzq2ofg2sC1MHU3iITZtJ/RML7rtzg8wW2e37lsomdZEN3r40U6fSjwBfbenDo0fSe5ISICOy0FLCjS4H46Z0WW804/YsJ9lVjoqXPkmy5Q==
Received: from BLAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:36e::16)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 17:19:28 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::21) by BLAPR05CA0009.outlook.office365.com
 (2603:10b6:208:36e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Mon,
 25 Nov 2024 17:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Mon, 25 Nov 2024 17:19:28 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 10:19:23 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [kirkstone][2.0][PATCH 1/2] persist_data: close connection in SQLTable __exit__
Date: Mon, 25 Nov 2024 12:19:08 -0500
Message-ID: <20241125171909.1405732-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: f99b0754-1f38-4978-ed21-08dd0d755161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AB4I6+BKbqKp2S0d3jhfeeRYe+c5G2yq2Y/LKhr6B2igAQom4Iz4B6BPVFa0?=
 =?us-ascii?Q?TAxAotG3W6MxIgl2vIvap7FF/ripUlmLH1JF/5JTzL2K4WS4s4o91hUKa5Cz?=
 =?us-ascii?Q?/ijhjUUMMMsNT5Iemqw9ztcN9hsvTX7QDW32WjAtMVHYDMSGEmhweYR5bRve?=
 =?us-ascii?Q?C4jDFjbsg3NJSk1iH9GBbLKN6yljjef90mHQULXQn+oghjR8EGYdeutMVGF/?=
 =?us-ascii?Q?VwDJoWGavbYe0Lr8PCafO14RFULVttftW8objy6nNbKqXF2+8HjO/EV/2cpN?=
 =?us-ascii?Q?S+S6z2o2lX2POID3ymPqdp5b0yMFvrVgXIM9HiH7ru0ODd3JtZPMScNWUxRu?=
 =?us-ascii?Q?1REAeyoSJBOceV413Eo0BNZ+yUle/+k5sj0E1EEkExGahQMZ+74U/D/A01hy?=
 =?us-ascii?Q?bPBDAIzwZWx9kyMFpP1VCqgaCUyhkOipjPIYQVhO0mKbOpKSi9baAAMGDtyE?=
 =?us-ascii?Q?nWy1ol9Av+6sY9KG0l/iAbdn43OejwTPVKFH8YSpKwKB90ZxSsZU9K+Aq76m?=
 =?us-ascii?Q?91LROE9AzuZfBuZ+uDH3pGwwaTXvtWt4xePbatW9b2rgt/ivkKSH5TXepT4k?=
 =?us-ascii?Q?DlGY5fYl7agFpLqAn7vY8iRH9Y1BWEWR7Np/42ECeuxnm7t2cJxIFfZsnceG?=
 =?us-ascii?Q?uZuuBzI64qhLjRhTQ9ZCAxVKYnUqBZabvyh1I+EdbnYE5CVm4DOHoN1b5s2+?=
 =?us-ascii?Q?ZmIjaJZGfpP13XN71JL7yuNpvDeiMUWtrYugYloyNFV9+iiktrUD4Mh5A0+E?=
 =?us-ascii?Q?sIvYD/E4j6TyBWCRYtRoeQYHrm+DesHm46BhgvW4lJ6tvvOxvSq4FSLmA+pr?=
 =?us-ascii?Q?Jy1cQRPxsTp+r9pHKY23f+y7d4ElLuC8ff3SGFoNLvz3AJBLE2x3/NdSSSdE?=
 =?us-ascii?Q?s45OQa7RLTR2hyYsLbDr3RJy1xqW9EwhJ1R6BBN0GmD26X1709v+P4BMbWlc?=
 =?us-ascii?Q?Iy8lphpTJoqX3YuKFi2Cw7lDaYget5gwI+jKmZZm7IU5hRiGNrDQh59UNZnn?=
 =?us-ascii?Q?Yt9QcI5uccgPRLco5dCaoX+2Ub9yNRyO3PK5e4oiIcmUquOK2TmfEFbswFkO?=
 =?us-ascii?Q?EexE4lhyiHEp0CNroBc5Iz1BiinzjOj2u5X3dI3HO/9MlcS6omaQ4Y1hfLGJ?=
 =?us-ascii?Q?0Mn4RFRN7AEhkmIjXN+GslgwUflI6m+fIOBw9kl2JO1uAA9pFWmSeKx8EWzA?=
 =?us-ascii?Q?1zDEFfwRQFOWjUEtWIfIQA6B6kK/PW+mqlRSN9o7VJ79WoDWvZyEqAgYWjOB?=
 =?us-ascii?Q?RaMgUaR8w44Rru5oi10PZfzAnrnh2mon+3ASJErmfWHRIUQKLqPC9zEdTosg?=
 =?us-ascii?Q?hSquvzGPryyTU6bD7eMW3je6kDpLBmIN0ymaOPrg+GAEtfrLc00wGvNA3o1G?=
 =?us-ascii?Q?fEHyQ+0hBFAjSqH/x43lkCS4z7VU7Ne8Q/4oxwwVte4OjtAKdw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:19:28.2935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f99b0754-1f38-4978-ed21-08dd0d755161
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 25 Nov 2024 17:19:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16830

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
index ce84a1582..784755452 100644
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


