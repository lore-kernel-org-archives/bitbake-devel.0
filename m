Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.62])
 by mx.groups.io with SMTP id smtpd.web12.12269.1604673326146065872
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 06:35:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=YjPRaY3U;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.62, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zot8/tKa0KfTC9livQutMdGjIdtKDdZoA4OAIQJ+oSdAo9H7kuUcAyanoPOIbV6AoNieDiJFzrGtG1cMfZ2OQwIqjRmsik4RAk7guyzuewNYxW6Nlzj3bfrOzVbb6/6yj0YBIusGVRBoC/dTJjYvvnvdGS/JY4ebNnkRWUw8ZaGo6eX+LBzut8utxipkTxT753Tp7B4cGiIPEq5WdrEtHGhvFO9Yc+0p1shHVOuEDjUvRGtfpf7UWc2nBUw7UXarG/hH+AfNMqOhOI8XgQ6T1EZC1WkQfGFwqB4XNdWTOq+HPBXjJKqKJwEq37qTitQ6BETZE3OhTQBmbjrZbkRWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1PPcDrYRY9jK2LIzlAipEDmZARKsW9zXnTLF9GFvbU=;
 b=hrKt0E1q/3qn+XUBxEihPwSP4PjdwQAgACgZYAv6SzkK3+QM2dCS0WyXKOwI1TDjtav8dFR74sXP46FOqQ52EAdyfC8ZwSE7VoZJq4DofqV8gxTU4u1HGr1DLngDqDkP8pyW2RP6lLSd4b0hKwezHRRDHqbXeN9dNLHhfcYEC/tfzxG+hJlM6mlz0lQazOhDCgUGAebHm/7Tk3PxQPhncsVjONJT1eRSv4c+6hE4bgt6ll92tFqzM6PWDtfN5b83oeR7am2MGIpPQm7QFZyKt3pyH6s9gpnfdzk6moVej2RRamqyfOG4zB+1u6W6q5AR1wCSgMNOGpTeeAYfxJh/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1PPcDrYRY9jK2LIzlAipEDmZARKsW9zXnTLF9GFvbU=;
 b=YjPRaY3UfQtuMU+vvhGKSb7wG2IdKIMkPaQOGyybwnU3jkfJqkx6rAhby8r+DW2j5lBXgd9BwJaK/8pTA+LIJ94817P0L/L3K/ygEuGxjIgrcsmhDkV4MEpiPrqwzfPvj28UGJkGdP6OmM4/LXf7HNH20VlSscWurOvyQ09O6skNzNvuFxrH+0sBl1Z6oq6IZTzDQilzuKaOX6jZpSpzNzfwNgJPO0qwR96V76bRsJPVPEv4vh+2B6qeiw1Wqs362fqbqIR5F+K5VQRlKhoaOf89ZL5DGDUS4IlFoE4dsMbe71xpu7HCZ1WUDBtIA3KXYW1mnjIcaYY6JNFBsSh/9w==
Received: from BN6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:404:65::12)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 14:35:24 +0000
Received: from BN8NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::48) by BN6PR17CA0002.outlook.office365.com
 (2603:10b6:404:65::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 14:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
 BN8NAM12FT056.mail.protection.outlook.com (10.13.182.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 14:35:24 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 07:34:49 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/3] bb.ui: delete __init__.py to make bb.ui a namespace package
Date: Fri, 6 Nov 2020 09:34:56 -0500
Message-ID: <20201106143457.81958-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106143457.81958-1-chris.laplante@agilent.com>
References: <20201106143457.81958-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg1.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f469c407-6900-4049-155c-08d882613296
X-MS-TrafficTypeDiagnostic: BN8PR12MB3090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BN8PR12MB309092EF70240BD40594BEF68BED0@BN8PR12MB3090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AEGhugUeXgEXhNJ8MntU0QLnlHhbXUif4pWbEp4CfTWz29PdL19mfzQJS4oXlBZ1iusd1b/nQSPRbLLauulFvV3eEDdCp528poZublELTyT0LvD007K0TRHr2Jb97Ft63l+q+KEOKJT0DmjEE8j5slJqsp0qqCarTHzZrI3DkmLcLcrHp18vG7ZvpqVWRF49T3xJBP1rF2km60fZjaDFnaHNsOL6lyjNGPy0L8tYxO8Fv0uqmjLXfa3l4QPMVQQ+TLKVSUkphojhCWQq34UyqXNv/0hF8PXZODfqRJloByGJQElmTczWOX6jyggvGjVmyl4/y20m0U4ZswFw+O5oGJj0qVi4eka3RQ3f/vMMicCI3wTvrW3wonJU3efiEM6Hm3V70g/dzvdM1X0lP5opUuir/2pnmBS4vGFvV8pZWcJbf3D5MOxPgcm/zCDmbdau78wVDTxWIxjZJNLiTHGXc+khheS/MOKzBTZv2XFMQUS8LkQqvtl6Csd2xp66EJsQ
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(29502001)(46966005)(2906002)(5660300002)(186003)(4326008)(26005)(478600001)(86362001)(4744005)(7636003)(83380400001)(2616005)(82740400003)(70206006)(47076004)(426003)(336012)(36756003)(316002)(6666004)(6916009)(8676002)(44832011)(107886003)(1076003)(82310400003)(966005)(356005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 14:35:24.3601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f469c407-6900-4049-155c-08d882613296
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
Content-Type: text/plain

This would permit creation of third-party UI modules without having to
incorporate them directly into BitBake, with BitBake able to
automatically discover them in the same way it finds its built-in UIs.

See https://packaging.python.org/guides/packaging-namespace-packages/

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/ui/__init__.py | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 lib/bb/ui/__init__.py

diff --git a/lib/bb/ui/__init__.py b/lib/bb/ui/__init__.py
deleted file mode 100644
index 4b7ac36c..00000000
--- a/lib/bb/ui/__init__.py
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# BitBake UI Implementation
-#
-# Copyright (C) 2006-2007 Richard Purdie
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-- 
2.17.1

