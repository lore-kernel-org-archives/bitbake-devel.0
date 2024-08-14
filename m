Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E37BC52D7D
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 13:51:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.67])
 by mx.groups.io with SMTP id smtpd.web11.98542.1723643462772518268
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Aug 2024 06:51:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=clP+r8Ps;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.94.67, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6LFjONTxHLpzFZKo4V+KJZOR4WZmHUVyJQmFCkYF5z1Tk7LmWP8D31yhRjz0pCjeZQimKXj2ccnVHa7Qen3qHk4kzLkngstnEIFIjY8nFWHraxTqJhisIoiH20APl4Yf396y386pM9P7bMGuVRlsjaMELsF6pQfjuOwFOxtXqiHGxyZio7ERInxzvogpvbgQPjOITY2+STYq3ecIt5Ix7vsL2a3M7Mb+CDT7YKHAEYtUpyh6LB/3LwXex0xLfqep6QUmUKdIjLnLAFed1VqzXpeBEFt808peBnPYykH7P+5RYUY2w8ESeEAqYWsCEItLkb7WJwK6qVsOqpN3gifkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyxLWY8/3QD7c9Kvi7gE9rE0kwKWrAVolcSjfmQ5JIc=;
 b=yjCNYqpyjnTi47liN9vq1BrxhJA0KxKMZxRmVCdV9vO0rT3BoyOgqEK/QCd1BROGXmHsTokQ8o2FH+4b8r9hnJ9gSGNVrXNzILAXpYk7ZGtGbHIIoEPh4mi81/6XbooqP7nz9S++sXhaj/9LAfzXwWShVkoeHZQLWbKOSWAJhM2X94iMcrgLIhiH6MWZJU8LLq5VkOd/LIX3RWNvD37vbf4Jm+8cFHVwoOnnb3yz06w2VmeaCiWj8yLL9f52sorD88Id7ZDTskK1vzTKGZVeQle6kx2iaZ1C9C8kOLTBxK2NLAFyht7N+CxgNpF898DYmoLv2gQtlGrckt65zUoS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyxLWY8/3QD7c9Kvi7gE9rE0kwKWrAVolcSjfmQ5JIc=;
 b=clP+r8PsiorYnAupvo9iVeMKMyVoF7JKbOfdFJLSNcCt2hVeZBX+T7MrijWzwKPl1aEqZbn4DYVpeNQ2JmaroPoNyFgMBa6Khk/yxRENUj2Rb8qljeApjK1tsEmgJupd1SHhELdzodHN1ds5GjGZJtbN8Ng5PuIRF2qb5mbddNw8+guHS7zuBwdi4TqwtCteHdyYndLweRb+0DnLX+a6xxaAJajRk1yMMnO8NvYEBM0AmhCrNtiJ4CerGI5euXkgLdNKlQnTmeaVun3pTFn4Mz8jg8/KhRCcB9vgxWAkQtt9Uifcob11WY77lNmr+n4Mk5g8dbVJe5eHt4UK8JVFJw==
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 13:50:59 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::a6) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 13:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 13:50:58 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 07:50:54 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 0/1] ui/knotty: print log paths for failed tasks in summary
Date: Wed, 14 Aug 2024 09:50:36 -0400
Message-ID: <20240814135037.4018930-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cb3bc9-0228-40f3-d5eb-08dcbc68206e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5xIQLceeBb8XcVuNWEBoCy98IwIH3JUfj+M4NyyskjHcsK1n9LerF+2+4NuG?=
 =?us-ascii?Q?sdQCa/gJ7e1sdX35h3NXCyR7ydL50C2OS89+xN7D7lm/NZzjfhSJ+ykfmDxG?=
 =?us-ascii?Q?EuLky1tSSUG/GMPkvwxornwPrqV/OfQiYEJLkeANgB9qndB5VIZLdGD9lnl3?=
 =?us-ascii?Q?cBurKQv8RglNmd1BsKicHm5qNoYEahDN8AQgmtK6+95QXeq5UWC07JeHXtwC?=
 =?us-ascii?Q?l0vfHjOOuwlwxhMU+Y3gLlbI1jnENR+bA5+sT552fb4f1jPsl6A1LMDFwMZL?=
 =?us-ascii?Q?6SJALib1LW1lWuxrXJ0SuARx0gsRs7vMt4nWuejFe7u910fB725x4cePjSlC?=
 =?us-ascii?Q?91/9TPDalQ5GtlXQzNQJhvZcz3aSmJNH+aexMZzLGc0zfDf6KfD8I32P09U7?=
 =?us-ascii?Q?+YJsoLgOWml4mppetcSzp3jAtJozO69GQy7PXry9HnBMf+nrcrd0H4UWRe8u?=
 =?us-ascii?Q?RObl/tgvD2LDceSFK7AmG4uNSelzVq944n7lrHn2I+3mjFKvpc02EzXBlVY9?=
 =?us-ascii?Q?cbPn4AcJvkNDv5zgkpttfEtqzk5bsHYVfC73C8KXTKfS103f1HdhVKSY/lPO?=
 =?us-ascii?Q?ozyow1z2W40yJSQpxrTSuHTXd8W6AzeTMemnI/JzIX1vVEEceVK/Nwp4zx8j?=
 =?us-ascii?Q?NlKBAcV6jOL/FgQaQZM+XqbWoFnm4PwuT7m/lnw2K1dMTqve+nTGVZGYYKJM?=
 =?us-ascii?Q?ODWuZ1wMCv3OLUC6JE7Mcc02uCSH8Z2sqOm7jvaE2dHZXpa9+sUZB6KViaqu?=
 =?us-ascii?Q?Dg/FQlaQcYEazkaboRgKxlYk+MS1Lac3imF1zM3AcFNvPdkC0L01V22B+WA+?=
 =?us-ascii?Q?ECmp/GUODtPoJkjyOD/mo2O2SeXOG3vcW8KkGHBiaF3CmNpgn5nqxfvdLZZU?=
 =?us-ascii?Q?JojELBSwJSFMOO68h4IOPil/njpAL3pdFqUjED8OZVnNokXFwTTGowvhfPBE?=
 =?us-ascii?Q?qX60yRo1CsaIRZ1dzCqGBB5BYrZUZn1ClM2CTSNeMuDnWstGhuJuhjQ/OBFW?=
 =?us-ascii?Q?s8HQbwz8zB/T099qwjvXshOPfA8m/T4g6p7ob1vyTehp3XB69J2e12MogaAU?=
 =?us-ascii?Q?hQiXP6c2mmBBQal+v/wKob7qHIq69RWAe7++svKxnJ/wbeCICWDTDTaITJsb?=
 =?us-ascii?Q?HLkckufM7Dqcl7P2t/AhX+dSxK/+kTSgsbFii2Too6unoR5ZHnPYcrPovjfV?=
 =?us-ascii?Q?IkRfA2opucExCDIoPawNEU/6FCfx6Oe0s2YO9c5ZWzYaAotE5rh/J3ZY7JGU?=
 =?us-ascii?Q?G4lDs3rwacbMlSX5XogBrkDjyvzElufsN8duqvc9Aj2kV4703VI1wdizuw1D?=
 =?us-ascii?Q?eIHQoooBfKoeR41IusDrQpM+DnNgMawTxniWhMphjCjaTiDxl25RrbMpaR18?=
 =?us-ascii?Q?K9PS7LwGqJpgzzEk23TFejbKX4PwTk1uWpevjQ2I9Y2bxeibCDFnWagH5H4r?=
 =?us-ascii?Q?sM/I2fxiYilh6LzC4kR3X4XjrPv0RKM8?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 13:50:58.5898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cb3bc9-0228-40f3-d5eb-08dcbc68206e
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Aug 2024 13:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16484

From: Chris Laplante <chris.laplante@agilent.com>

I believe this patch is ready for wider testing. So far, no issues have
been observed with hyperlink handling even on terminals that don't
support it. This may need to be tweaked in the future, but for now,
let's get it out there.

Chris Laplante (1):
  ui/knotty: print log paths for failed tasks in summary

 lib/bb/ui/knotty.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--
2.34.1


