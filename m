Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD3C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 14:37:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.68])
 by mx.groups.io with SMTP id smtpd.web10.211901.1724078264291146180
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Aug 2024 07:37:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=Wx8+plyr;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.68, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIRsgP/MLfQM0vu7EeKtXdE9nvWity1HnPYCqUNHfaXbJbeyhh7WfHcc5ahI/Qxv2/UeASG6L1OqGD78y+5XrRgdzukHgSZsJOK8DaFRyu7+uBuQl6Fq5HhhpeNN12QZDaxWWdBi0wBD3dVWDgYNtr8pHh75BTovbRWbyAklpSwgG/n21q2ryGp/d2vOw2TQvbqUGhDG9dzUew4WGlXNZqHaWXtSWRoR4sCeSOZblRGWtzTcScOF0l9kUkD2LCYai2BVFXCqOY8v07O4Ckt5IgNmi+62f9XHtohJ0e4t+hVXWFF1v2dbUTrpYmDGA7di7HprsuenHsnlK4/NDsU5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEosHUS88vcSJ5IfNqtBRH0Gv+4FjTt6OFbkYSS94cM=;
 b=mqSJJaxbtMX+oMws51w1nblpRT9hFVMKp6ubvE3LUia/9HNoVl0kCjWp0rhOPDu4eilZL/rYcD0S/ye3WH6sztEEBbWEynubF0RbcEGxDvXvUN85SN2hfWgE6dDGgzkxprZwjgCp/KngF7OKlMlDMPgCMNFMiDm6fsmhD+odQDqME/3bJWZfhPiTYLkj9Cn8jawfC1Hp4WxGrWyVqR7GaOYFW173lKax7oQLCKNK19mc/glmHyoLb9CZv/06FEBIDFBkxcQexrX8qsptv9qLj+qv3xeQUbhongP2FB2AyIiM9Jlyv5kCeWYY9NlHPL2kAF1kqNCH/rcX3hQFlSNFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEosHUS88vcSJ5IfNqtBRH0Gv+4FjTt6OFbkYSS94cM=;
 b=Wx8+plyrCuU2kR7XgZjZ2oHQTep4hMkeo9GrI9EM9l7R1bEa91B0bQUO0jIlGn8h+kaNQ0SmCwMag6JB7B9cVpQHNPTHv7kRIPjyusHE4VcPC/NYudFAh8pn1rNFDn9j8hlAd7GbIXBOHytgjScGMg1wWrw/rDVKt0BtyLpvNeS24pYEphynH3eadtp7h8oL3cEGcyRTJIc7MDt5hCaJaQ45FeY/licad79MkzX/pi81dQvZ/AAr4T/MRpSwdw4SwVwJ98/o2s1CUVbduDN0/yKk+C6/smt9j1vUeza7Jg/9e7FycBG8j2eJexgreIn0IhivYeSFeF7ESHT6ZwPsMw==
Received: from BN0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:e7::18)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:37:40 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::b0) by BN0PR03CA0043.outlook.office365.com
 (2603:10b6:408:e7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Mon, 19 Aug 2024 14:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.34)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.34; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.34) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 14:37:39 +0000
Received: from chris-virtual-machine.localdomain (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 08:37:34 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 0/2] ui/knotty: print log paths for failed tasks in summary
Date: Mon, 19 Aug 2024 10:36:11 -0400
Message-ID: <20240819143613.1380185-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ff9a4b-9eb1-4c1f-d79d-08dcc05c7a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eEVkGq7pFf+Y+9KJ2vg6RxOyGmNQtkCP0OPolcc70ZpIek103xrIRNNxNY2u?=
 =?us-ascii?Q?gWOcb7YvH5XUQ6qF+dZb4hn6ZX/74Ozw7VIGQIngJ7v3UK3Ql1tP+RdYaQ0a?=
 =?us-ascii?Q?terP2bJjEiZ2sbaonMbi/v9zycrYrjElyYWB2ReNKHql+ybLKRSLVwrsKHTf?=
 =?us-ascii?Q?P42JBPlcV5Flz/M3Sx251CEYPrYfTWXpNLSq7fZq9hb5N0Rek3mtIougcXtc?=
 =?us-ascii?Q?zEzEqdYDLXCJt0pmZkDCG8W1k/fdnNsS5qugmrCqlMxc/AWOHNp1yOXlGu0k?=
 =?us-ascii?Q?LsQKN3ZbEOu9Df2L8R18lwY6Lm+Aap8RFu1xdVitHaNUOVlvo3Lb3P0vqgyf?=
 =?us-ascii?Q?P+lfJF4iltRKZBWz6lMG0TWuY2sJEbjS7e3kbCOtQ4oTjHeb/mQwLeGcHtNP?=
 =?us-ascii?Q?BmWbsh1BmsP1xbKeJCHpZEEH23m2choT6+wgtxOSmA9x5Yz+vtN5SjAwiP+d?=
 =?us-ascii?Q?jelfbR7KKAYyIO9XrFIk3gpoSP8QXtQen8wQsQklAjnw5ZjxFQ5oF3uCr2Yl?=
 =?us-ascii?Q?Ht/08k6xcqSWxk4iZjEzzPbFwhG5jmvbM2u34MH+un8M7+Q0roYDmLRO+Pv8?=
 =?us-ascii?Q?UsD6jdebw0k/qPsPpU1kJA2oShEqRih80kWIO9CjW7ao2bGnEHpfPah+sXOI?=
 =?us-ascii?Q?824cMeW2qq2iCFge534JOEgmk7XJZqptqjcFUKiivB0p00EAmkWynFRyxQUe?=
 =?us-ascii?Q?TuNGRwxyjNh+fVzlxiqznqBdO/B0hW4ZaXdqJ1Uf9qZujF4Wn91O9uzCqRyw?=
 =?us-ascii?Q?HjmAsgSIcnH1iUbk5tQMKvdNdJLU/Jn3H+CuuwBTP8m94JJibMXwHbNpV6RR?=
 =?us-ascii?Q?pCI4unfv6myZ8OShBkADYorauscwaomHMKrlqa+4kRQ5TcXa4KUEg93CCYwb?=
 =?us-ascii?Q?fG9eRafC3z5kCGPF8AYFYnyOTjgMfIsPCtCT+B3otSBfWc9CqDhRfsN04uaB?=
 =?us-ascii?Q?GovoaVy3hBIxHdIzgsI0H8PrIMgYH5hQKu6ovHg3/CmJgFsCCciqw+v7BiNi?=
 =?us-ascii?Q?XQU1PJesshZzdpJYM4n0WUFaTLJCsKLeNTnW+H2+MNdtMaec3peBmuk5W102?=
 =?us-ascii?Q?iWBonBrJpQ3TGhSJisFWR/9ivbVQn8leJgpWPDfVLnJ+uSeDezTjrd5Jh1je?=
 =?us-ascii?Q?L/KCe5BDUreLMhBa4hXUS+/cQ0oOOaTbhG3dCFnWVosaGwuc8zkOv/qVoUYq?=
 =?us-ascii?Q?99+3g2GaMEZABxLsnvPitbVnzrxldh6PdH1TC6tTsYZ5k62t416tn+URFus+?=
 =?us-ascii?Q?tpDcsLt6J8I7ZimCu4YrQjkEuwbtDwvkdrqUuwvJSuPdMSRkWOQbU7lrNcnf?=
 =?us-ascii?Q?3oHqJNONlIX67MvgZvMRkZVYglx4lKSWz7AaXmoel00hXOUMwiJte+V1OCCA?=
 =?us-ascii?Q?7JkOTMPFpgDy7ODY+MOyuTAb4ivQC24ae7thVhwMRlAZMTpckdiJRpHYheXO?=
 =?us-ascii?Q?upp/opVOx2lCxsXI7OLLBNaiV4Jad4vn?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg3.windmz.agilent.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:37:39.7140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ff9a4b-9eb1-4c1f-d79d-08dcc05c7a35
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.34];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Aug 2024 14:37:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16496

From: Chris Laplante <chris.laplante@agilent.com>

I believe this patch is ready for wider testing. So far, no issues have
been observed with hyperlink handling even on terminals that don't
support it. This may need to be tweaked in the future, but for now,
let's get it out there.

v1: initial
v2: check NO_COLOR and isatty

Chris Laplante (2):
  ui/knotty: print log paths for failed tasks in summary
  ui/knotty: respect NO_COLOR & check for tty; rename print_hyperlink =3D>
    format_hyperlink

 lib/bb/ui/knotty.py | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--
2.34.1


