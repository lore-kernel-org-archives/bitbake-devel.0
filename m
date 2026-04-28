Return-Path: <johan.anderholm@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310EFF886D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 14:04:04 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13863.1777385039941503695
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 07:04:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=Kw/bJ6F7;
 spf=pass (domain: axis.com, ip: 52.101.65.65, mailfrom: johan.anderholm@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRn0MqFCWH+OQnMYL/nl9GiErfKVsvNXcp69nERmGbd6KsQafSXSNgLkbSi2tciNI1IpKi+qfseMj8/XCEtP867xuSMOzNvlS2okgkuhHkrXaAAVflEmzQ0oY3q/3ZIDLGbgqv2dPULBGyl8KFQfQhy2gsqQkUOWKYvPWmw3vjXYjg5pTYt4nGgxUhWsejYcBgMO84jvXz4T9CNLSsTPmMjRN8NUNRWag9RW5h0PYJPPoWmlXzuHaX3zoLnLQgYdy7ldEr/Dt3sJImCrvs2HeezPSalfJKyNSob2T33FyPAleO8J1u8HURJ5E/Smts7snYEfLO5P7+7AjNW5s1xHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5Q7UqWiD91nQbsdXgqeroeXh+KeWvl5ReH0elwDtkE=;
 b=rRxt+8gva2htETiXQ5vZHFa4TcbWm9WeZFOf1JhneBoySLi7whhL/QYkvZe7TsJh1qoYH90fMwNsLrhAxbtX/Aa8IhOtfZP2ahEU0aC3OZ1jd7519dw/imV4RHatVBCgsMZqaukdbeFH+ebHKPotnmiAgAaIOKsBotJZUWP6FMl3s5xuP2Ylq6VSeKrno8qmm+hBofhRtBbUS7WpO8R4b47pHKOWNu0yTQl/Z20HewKHBgIYf3DdcBcDklEmrmAdlvaoiSwTcLO2R26g5T3h6mHdz1NdkmN3JWykOSeXAk/qMbDEgFqIOoZR5FWZCbFZFb1SSRMTKIblmfwYd4J6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5Q7UqWiD91nQbsdXgqeroeXh+KeWvl5ReH0elwDtkE=;
 b=Kw/bJ6F7E9Vwq6pdLg2cSTmwUqWpYg2EjsbLub7lS788hKsihd97lDzw8IOsGkcpQbYrmic6RWj/znMIflGeDY6v2SAY50A7TAh/0tivUddQf1uEkKIs3ezBgiPgRqU8iOBJfcgncCnhK+i7GcZ5Yj1ItPYsxnpgNC2U9xE1y4c=
Received: from CWLP265CA0485.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::9)
 by DB9PR02MB8346.eurprd02.prod.outlook.com (2603:10a6:10:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 14:03:55 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:400:18a:cafe::75) by CWLP265CA0485.outlook.office365.com
 (2603:10a6:400:18a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 14:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 14:03:40 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 28 Apr
 2026 16:03:40 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 28 Apr 2026 16:03:40 +0200
Received: from bldod238s600920-7.se.axis.com (bldod238s600920-7.se.axis.com [10.64.16.16])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 00D87768
	for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 16:03:40 +0200 (CEST)
Received: by bldod238s600920-7.se.axis.com (Postfix, from userid 20481)
	id F2111609E493; Tue, 28 Apr 2026 16:03:39 +0200 (CEST)
From: Johan Anderholm <johanam@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/2] crate.io data access policy (user agent)
Date: Tue, 28 Apr 2026 16:03:24 +0200
Message-ID: <20260428140325.3948844-1-johanam@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|DB9PR02MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 99240546-1166-4a3c-de27-08dea52ef361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	g0eU9IORwXwnnVgvmIu38VdtE/MHg0CWMOkzkTAZjjoREGXzjsGMh7J1Nnanl1wJd98bquyohUhvevy/hpw1kRvrBeWd1JSIWwPxSVyXdo233BUMkxqPgzX1NLR715VGoSHfp4dV/KoiBQvlWpzGfa906wg1Uy+D1o3JODFL6EcGV5hxILxPmgZ3P/XflA96gaJRF5LmSk5umWTxSpWfocBXKgCQiTkm3vFcRdNVid7eDOIyGJDg4oEdUcBHNt20PuT4F+OaFkLnpAAUgzA+ACasH20PwKLJC6YWkAfWy2PXCcw7p1JAA/7nXjr4tFoxNlb4PwrV1KQrXGBKZD3Vnel9CkHoPKkakxkOsJ5p4EC4aGoh4Ji2NeXhsXfxOdkcHlKDshj1REqshUJD7JXmLpS0umaIqkCFo+KjtfJkLyszIeD8wjRO4ITeLDx8eKGxF1r51M3OdVoIiqwjtQ4lqKLf85wen/aEj25A2KYskfxLloRyebDksquoZ/58kPNyzJMkOAyWiBp76eM/LTHzhXnrzS941svq+WDfb32oeROx7cZjV/j1JdFgkPZT1w7w5sH2Le4xT3caERDWTyyOupUYHzJmMHrROIYQAUHfgv48/YGROU0TPEdi8f9h3AYFTy/Qw8EGiDDxWKOOGcJEW0mHgOLhVchl/S/pXtyipy6vw2m8qTSNcj1tBlOQWnEkm0EoxfP/6fF8++qTba0CD3CuVBuJAhkqrHZw4oYc2Sw=
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	FaNQSachwYOBpqrSHnU+7BHOOQdluV1EaelNke+UpWwukcczKlOMsMwKdcowYcN/5IiXSUQvM5gJ2djUcATj9z9D393f0fl0LKu4CfBf8E/HS69/s0uPkKH2NH0pgF4yp3DB3FJ84bJj4FxNKU6yi+TZ/Wbn1XA1x/iYbCQGvy4ehpi4wO2mjCfPRC3bYE16gs/PAH30n8P2ut95GyUVGnywERLlruEW9ZcGNHNAEYaidvAdLEE+MZbauDR3QCloUv2roaRreqTmQ+0XAYUsBjUFy+kJ36G9K29w2J+SRybr6kZg/Jz/GMac2YxyR+o+cATDu+p0YgTCUG9bjBeylxfnd/XLcnGvO2gPB8IBomNEGZl/iHkzZLGxytDhXb3QCramGvltt30PHI05ufQ/hYqUPQ49sP+yp7aouwWT5LJtlHQJZFWqtpj15t7P5Jo4
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:03:40.3174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99240546-1166-4a3c-de27-08dea52ef361
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8346
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 14:04:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19401

These patches addresses the part about setting an application specific
user agent when making API calls to crates.io:

https://crates.io/data-access#api

I'm a little bit hesitant on the first patch, as that changes how checkstat=
us
identifies slightly by adding contact information. Another option would be
to leave it intact except for the crate fetcher. But I feel this is introdu=
cing
more complexity in favor of, quite possibly excessive, defensiveness.

A third option is to leave out the contact information altogether and just =
use
bitbake/<version> since the request about contact information is only
"strongly suggested".

Johan Anderholm (2):
  fetch2/wget: allow identifying with a bitbake user agent
  fetch2/crate: identify as bitbake to crates.io

 lib/bb/fetch2/crate.py | 18 +++++++++++++++++-
 lib/bb/fetch2/wget.py  | 19 ++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

--=20
2.34.1


