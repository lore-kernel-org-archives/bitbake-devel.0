Return-Path: <johan.anderholm@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E043FF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 13:51:46 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45753.1777297899264322163
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2026 06:51:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=eaGZnfIN;
 spf=pass (domain: axis.com, ip: 52.101.84.4, mailfrom: johan.anderholm@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6Ayqdcmv2WvQTDmPtko7No58CIO6DmdFLVGBcARmOUZXLTf3NZzprBRdnyzmSqBE12WjAvJs1nKJVjw/bwaC55xjQFoOPJIWumFIGktQhkCEIreRxo5QOOsbidM3rXr6CvI6JqAPgszFh0tdFylplcCH4fYsrwp9/zeTHyYu9wFDJe0lBBgPs3HTXL0InSB3ncB4GmU5yRt33GYSeIMJm/8ct/HUeHA4fr7ncJILbWJUFJbsOEPrEahEihCrhVavb+qvgJpWIWpjyO3LrHJa+oiU1wNCa5JMxcv453nB6aa4VXUDQ0MWLYxNR8J48nUKNz4p9GIJoxgvMNzZl/XsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xphWDBuLdYArHnWhSKS00oU8IcgDhsarKhwGBypZg+0=;
 b=KH3Swk8WJYtBA+EdyMWQUj8gln64KUBD0MGrpVonq7Jrg7zf+xKtnUxxV9Zd7VOsQuPTVlMBV90Zt0SwQkk5i7dMfZ+S9HnEj0nwHmYkKehf3XNrQUoY+xXh2Q1z8OfHSzTpMbxEsK+TYofykkuDt269bNUZp/j6cTjndlEWmXGkUrpJ4j5Wv5Ts9aeSEjGyElShfVzIqR67tLy5dDFksUXrfHeSNAuVdfuOcYvGGSmsEEkN0SyMqaC5Kdstxup0r6O0QHBQvMiNFuCT5CKfp7/YsA/UktuRraprW7IG3XudzPmgShk3uSM4IczyoaLWqoNZrnv78mEU5L4791Q66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xphWDBuLdYArHnWhSKS00oU8IcgDhsarKhwGBypZg+0=;
 b=eaGZnfINLcfxQekWgVanP91r2T5GoZQRhYwMfnZsQTTluKfwgrBaqGf7eaO9eH8zPuX0MkFDg8gkUChUeu8uFwuCiNJeW2wbrfnJQsdFsn2mj02LgKSpCuKxV/gQB6L6QbQY//HPzF/TDSf2y3otoa5SLA287VHpxh8gIKjcTB4=
Received: from CWLP265CA0495.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::7)
 by PA1PR02MB11126.eurprd02.prod.outlook.com (2603:10a6:102:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:51:33 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:400:18b:cafe::e0) by CWLP265CA0495.outlook.office365.com
 (2603:10a6:400:18b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 13:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 13:51:31 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 27 Apr
 2026 15:51:30 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 27 Apr
 2026 15:51:30 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 27 Apr 2026 15:51:30 +0200
Received: from bldod238s600920-7.se.axis.com (bldod238s600920-7.se.axis.com [10.64.16.16])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id B79772DF9
	for <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 15:51:30 +0200 (CEST)
Received: by bldod238s600920-7.se.axis.com (Postfix, from userid 20481)
	id AF356609AE2B; Mon, 27 Apr 2026 15:51:30 +0200 (CEST)
From: Johan Anderholm <johanam@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/1] crates.io data access policy
Date: Mon, 27 Apr 2026 15:51:22 +0200
Message-ID: <20260427135122.1504143-1-johanam@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|PA1PR02MB11126:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4b48b2-4c2e-4553-5836-08dea464165f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	1uV0w2337dl+Me2UQUm9mN+73r9LAxzP1HCRMLQ2draPv3J/XyONVTww6SPo00VXsJMde/kShL68KFhstkpaoiL5gyZMS3cxm4EVqIldDy9yLRA/SgLRNsu9xDPhbKPqjrls1lBkM4oZ1mLssXPdWDDQ69ztJ/b3yG8YBJOhlkNpT7sUzdBp8DEYnazWPCpQInD6MpIGbuePciY2Qz0v3+DGhQ9vdh9BolNPZlo8uWAAq4cYpmc6IQOr7H/YPPbEh4wY9AiEs53hOD7vYC367t7pPHSNB7S4OQp8Wqjzt298cWyvh8Rs6riBKirJlCPguGab9+XEGNHMUtWpu5DZ3zNGX10WkekNyg+aORob0vUDya/btYW6IGn896l2X1vPI8hIIZJjcixXc5Pj5MdGznOWb03TLEu9NQlctaPbRE3Wad5Ji5M0X4XTMGqCfPGOxGnSTuxrVOX3TnramVJzXLHi7uI/b2+Be2FEPgR3LIXZcdNjya6Qc/e2nkPqymENBvG3dq9PzN4/GOGrXUmVZFiZmivPLnK0iPr1DBJ4cliKWiUUVnZFTpMSiiu6XHvhpx+5+TLRr6vtoseMJ+POghxetkATMyZMVCvPelwye0JPEha/hyFoFGLVW/odlPXn3WwOnpwcpx1dEPqoVETm8B+V8jEW3iDK2N77Deb1dJKxX9TwTZ5Jzn9PBs0rfTS4XhCW+9iPNABpCucdgWGQZxDwW7BJ6hXZqZ8FziDB0tg=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	HoRSR57vKGy8jjsXIte/QMg+zL1zR8YrSTRjcI4o+nKOZDzPZYb7gNCd94SuYCDqQF+KtNU4RJ5S7fYFiyWhpeC+Ylx2MghsHQEMX4YDgM3wQBq72QZ9OOT8DD/H8J6PpyCdUCPb4lEJKQNJGo93abPJ+SD7dA+jD13mMH6hu9jbndyLFtMQ2J31zUL5zlqkekW7QnrZyTfK/uYI3/rZvlsMu545npI+Y8xvthqywXsoXiH80jdp+3yRg0pU6V2sfhvpXo+i55raJOVssi6CYFqEXd9qMPWBRHZilrdOEu+rmlbuNc+BpLkugkZBtdl3tnIy7RuIWfY0MaKCNW/jh6JPnr9Acceb3kpUHd5uuwBmZEhrT56p0B/fAjPM75caoeoaVfI60W9WSHS8d40uyg1YsbOWq8RLhBO/figKsZHFYT1xoeh7ZzXBP4PwYKNp
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:51:31.1836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4b48b2-4c2e-4553-5836-08dea464165f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR02MB11126
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2026 13:51:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19395

It appears that the crate fetcher does not adhere to the data access policy
of crates.io as is described here:

https://crates.io/data-access#api

Namely the part about adding a user-agent identifying the application and
information on how to reach the project in case of issues.

Also users are requested to use the CDN instead of the download API, as tha=
t
does not have a 1 request per second limit:

https://github.com/rust-lang/crates.io/issues/13482#issuecomment-4304855751

This patch addresses the request to use a CDN and seems to fix a recent
breakage of the crate fetcher. It does not address the part about a user-ag=
ent
since I do not know how to do that, and I do not know what to put in it any=
way.

Johan Anderholm (1):
  fetch2/crate: use CDN for fetching crates

 lib/bb/fetch2/crate.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--=20
2.34.1


