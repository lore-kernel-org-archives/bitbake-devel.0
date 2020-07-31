Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.43])
 by mx.groups.io with SMTP id smtpd.web10.21213.1596210211161586250
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2020 08:43:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=DmF39Mtm;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.223.43, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8JK3EIcy3rCWnFqhBzZKSjoaKZp8Or/S/JA9IjFBSqXvvtGv+I+qW1R43pgW1sRd0toYGTDPiskNevw0H8CVcS6H6i6CE6k10DsToVWxeUc9Sqq8gZuzD/dvfMDRFwXggMukqLJiDDtCXvLEExLp38gMxZeFnXvLPOi32LOTHgMlwCI56q6d7hA0VV2dsaobf7weCflV6PZWzRPALiyq51anodr/+wfQA4sYGiBXzIWntj2nIa5wOFhxnvt8gAzkyqJpfu+UuQl17V+YuWfk7J5cyHor6EXB4SrhCZu68/RVpa+Td157ojtx4j9Rl6+lZesXcGPLFWmvAsixyHqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jfUwLr9wulib8Pntw3sutpblkGVK2TBTAdozEUL0v4=;
 b=a74/neEesKtqHD0AHB+9evFJBtC/JBwsxwwHRfJT/ni9XZUZNEd6z9HMrIqGXhqt/kChobgX6YSR39dbRyBR8HRKrEeLM3mCDHFv5dbpUx0qK/d2JWE2M1PxW1+m9euNmTj2aXqCNDkoaT3oi4mCC/RX87mLjALhU4h7sxL+zAAn1zt6YWSDPR2Kr7vKQniNQgrHFoWIyYKHOeRxCuq5RvF7ORl7OukoaWUbtdAXN6nr6ufYNWv+e+w21oq+wahmqUWy3nzKXTiO1VSJzpFZ6E8fpFiPidmw4DUWOOw5r/HNKF/JV6mfGDqEunLroJtcBz9HMF4dbPDyUGhqYJIXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jfUwLr9wulib8Pntw3sutpblkGVK2TBTAdozEUL0v4=;
 b=DmF39MtmJyGyjuEzIuPo+bM3h9pvfKbkn87j8nZ6Dc9cN9Lp8ChHFGL7LuY9cgycB1I5cwYJe2thL71CRABFlMc+PtOqVGc4CIdQ6UYVkrOIjwR3DoIzRKfSmRDClSRWM+nMStRlNgIYdWVNBW+pv/ij8WML02s11/Gyd2hRZRsOz84qUQ7M35Jze8zVnTx0D3849gRD6i7snVgc5tslciPh7MRfzoceLM/Ths0b6Clyn0ZKBaUT+MQVUpzVGcOrNCtvHt6ggk6ltuAl8nVIJSk6eFk+7QCaKBRSvMLgYV6izVvV3Ge7QkW6imoGt3YK4LSocxeAwyuk5wvAg6K/yg==
Received: from DM5PR20CA0039.namprd20.prod.outlook.com (2603:10b6:3:13d::25)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 15:43:30 +0000
Received: from DM6NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::1) by DM5PR20CA0039.outlook.office365.com
 (2603:10b6:3:13d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Fri, 31 Jul 2020 15:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT048.mail.protection.outlook.com (10.13.178.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.14 via Frontend Transport; Fri, 31 Jul 2020 15:43:29 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Fri, 31 Jul 2020 09:43:26 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 0/4] bb.progress formatting and ANSI color code
Date: Fri, 31 Jul 2020 11:42:45 -0400
Message-ID: <20200731154249.89999-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e1a661-a91f-4a10-80ba-08d835687933
X-MS-TrafficTypeDiagnostic: BY5PR12MB4051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR12MB40514DCDDB2F85C8EE64324D8B4E0@BY5PR12MB4051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rZO0muh2CMKbDoGORBaKVpxX0J5KAPgWHT2aAT7cT8hyY8XT8dmMn2IsclwjvHTkFGB++mP+bP2OduLO9w5uw7/BUEp3HciS57a+HffGAOf132kd/cQUfNHqOzwZs0J/9/KLJSOlHbd8BtFSw/QbUMorBWWdZtrbBpqovlQPbs64L1KbLDYQjE7LIXswlhikAjAyyEma4Cf1FMKXJqWTOKOHg1alQ7MO2O6uSA97zoD/Hs8oRQCvRFUMdskUeZ0lc1upbtBZpXb19azdjLAlOjBptfyReQaVWed+BCerk6fuFR0YI24BiLpFYHNGcm00F+E5m8DmySHJvtnnvnvidihMVMeedZtE7DvRiipyYcrWYaN2KKXzqopj/VJd/WfWuo7C38JlHugr0P+d/P4sTzKemKsrqovxuqJvnd4Xkf0=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(396003)(136003)(29502001)(46966005)(6666004)(5660300002)(83380400001)(7636003)(1076003)(70206006)(82310400002)(336012)(86362001)(2906002)(107886003)(356005)(4744005)(44832011)(316002)(2616005)(956004)(478600001)(186003)(8936002)(4326008)(47076004)(426003)(26005)(6916009)(8676002)(36906005)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 15:43:29.7245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e1a661-a91f-4a10-80ba-08d835687933
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT048.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
Content-Type: text/plain

v1: initial (just syntax and format)
v2: adds ANSI color code stuff
v3: adds test suite

Chris Laplante (4):
  progress: modernize syntax, format
  progress: fix hypothetical NameError if 'progress' isn't set
  progress: filter ANSI escape codes before looking for progress text
  tests/color: add test suite for ANSI color code filtering

 bin/bitbake-selftest  |  1 +
 lib/bb/progress.py    | 60 +++++++++++++++++++--------
 lib/bb/tests/color.py | 95 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 16 deletions(-)
 create mode 100644 lib/bb/tests/color.py

--
2.17.1

