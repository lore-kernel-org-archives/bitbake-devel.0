Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3CC5DF94
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 17:06:48 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6.1787332002340696199
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 10:06:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=XjVD88oY;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.46.30, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLsvUGNq3NUyLEAg+LUWSQPbdyZPnIlDCQw25fbJc5SF8I0LCKjUZY/uqIUgrCwaVx+3Fy9ei50Q6v1j8qGFv3hmo/ormpXKHOmHRk0dhg/L1i0sLmvqFe42/3AzgGhcYc0Ut4cQfYQDenqUr9jyvbbtkZNkUk5MO5k9tXCIrTzb/kbgL5pYXTjWh07jKlnMO8rIlLn0lMfD5TEhrT/RlLjV4IYXP1TB/q4Y+aQILlt6e1Oi+WxO6rTWLmAvjG3Ub6c2suImkvmm9QUvSJCgklnarDaalsHKHtFtnrzL0saebVQIX9L0KqJ8FRnEdo1E71RTz+CJcojJXWFaijve1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w97PciDW7rZjDwjoOzqA4wAFmSv+2vATKYU2TI6DsvM=;
 b=Dmgo2StQbaENeWeHBoLvIezy4VypW8BcfUTqlW6nL1tF5k+EqyrG3wwTQKgfSWn+3GqTcslly9kxINTcoXM+9n1QhheZoLqbTsKxyLENut+va3Fgvp5s0VCgRSobF+OPBHJiVZCzSILOoTeCxNuqQCJa/JE70tgFZSuW2THPSmVuKilx0BuStQAcAkkqT70CfbB2vCtrIOXWGWqYWpzkvCnWJj4S/U6z4Vi6AqmreBrfwMLfKWuqN4rFLmt8NoZGibdqGhMN5oebOiNPQ+CtBatVLVhkRb3Cyct7tz5pNSfUh4yYUSlIeRrb2sM13k2mMYtSczBhMKd1FmglXsQJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.36) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w97PciDW7rZjDwjoOzqA4wAFmSv+2vATKYU2TI6DsvM=;
 b=XjVD88oYFFtrkowZ7lYxsoBMqDRj1F/0vYkN8lPzKKzhlNQvhawNz9MvCC2cQUAbJv0LFPW77dGF2d8/t6OkHmdfydzFMrzjj/aEWETysXaPRjlB0mQRJwHlJERehFtcH6r1DMVL87ikswt3yIrbVr5ot8LaHUo0ZGZf5VKevR19w2wdj5U/PLLYt4JUVEchrxR/gRi/jJawt1BRSjcn1SHyuUHeTyQ8I33zoPLrpqiSJNSdtW/CM9XWGss+Zql6gpNhA/uZJ8L6P3SrupNSEizRiE9rZ6RsXwFVOJPqiD8IDuKYtpiMoto9szqSWpyGOJe6Hyj8wTGVby0j/khp8Q==
Received: from IA1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::7)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 17:06:36 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:464:cafe::d) by IA1P220CA0023.outlook.office365.com
 (2603:10b6:208:464::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 17:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.36)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.36; helo=wpcosapexchedg5.windmz.agilent.com; pr=C
Received: from wpcosapexchedg5.windmz.agilent.com (192.25.218.36) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 17:06:36 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 21 Aug 2026 11:06:29 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 0/3] Remove bb.fetch compatibility shim module
Date: Fri, 21 Aug 2026 13:06:21 -0400
Message-ID: <20260821170624.436725-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c407c3-037d-4938-b67a-08deffa68efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	2262UBaGvyIZthDiVFLaasW0288rxEA1JIPP2GvURKKGgw1zNO2jALhQ+QmU2wZ3hy1N8gy2ld8ER4oyw+sJDKmH8CTx+Wx63PuMd7csRUF4JLasZaFgSuh1dGk7kL8c40tfoLhSPM1U9yZ85ItISmVVudhT3++JRvYSwU5V5xeO9Rl2DkJalLsNoIhkKKO+LXlL0FzW35ajxnWBw+1WojPVvSppzBXF8H8V/GnAHiHcp6WhNAfUA8UORB9N0Eb2nkI+NohnQ5jmF2X4PuK4b0EuC14PU1WJvO4iOpnfWQUiZ/g9SVo+vC535mlHFqkcptACxisG4TRF7ba5VxH3x3G6UU0xQGXCBITkc0hYQ3kn4XJTQzVQYTXA6QqpeLuYp6UVQjT+mepvEcJIA+qzbU/3skQ8dz2t4cdcZfYEP8dlHGSTwhXqx1YHufV6CsKBAkf60B0xaCmCcLLaVAJX+dUxhcSCBaQe/yAvFoc44YRUtKFsBGOZwIwu6i/zWbSiNMfoAWjE1zqWliYZ+fPblZPQDGa2A+kx/+pks1Nxjq1ZcNveLdfZ2hIMahTpNP0IL1DITYMtDyreZHgOI5Ia6QOLhpDPeaKl/54/fJaQdXITRpuzW8dDNzl5OXXN3ciOEWC1Fvtr5Cxvpe2G0DvFHZ3u8sv2q9kmNd7jHhX6+8ijGwEkKHAQ42DUpZre++cMjLAfbs2qS2l1R3U+nuhdEA==
X-Forefront-Antispam-Report: 
	CIP:192.25.218.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:wpcosapexchedg5.windmz.agilent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	sVBvHGCr6ybZnGz2rzG65PjjqnA/OckXyN5RpfXPVoGzTVPEr8DKR2abnXPWLt1xQ3DB7KSzxVQuGmKfGgGWZBlQFOsUMfPQNiP5rG08ydD6X8OTfhtwkQmthslnPWOgIYe3R1ywNtrOwZktpKPihPqAkB1L5lMAq6KH14jLzAzed0GjgIZiTK45Q5QOsAm62c1UGgFHwZOK9ZfjoxCP7stP2LsK294mAJRG9e1QjrOLHDjpHXjXdjBzdJH7O3KLOsLc37OoSx5VmpK8J5eZn+JZuwV0BSjuzS+7enxU0NNuIBHv5kpDSXFh9aP7sItopxoPvIGw/9Va9DYWxFl4L7bKPCPeS4qR0K4lwGz6AEZg8Kxar56Wi2mLw0C0ZejuM0MVbIpKQTHSbhpj6OgYkPWv98X+toPxrqjcKV5yDr1ZY5ss6ICJMBgHmAESPFSt
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:06:36.0371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c407c3-037d-4938-b67a-08deffa68efb
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.36];Helo=[wpcosapexchedg5.windmz.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 17:06:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20008

From: Chris Laplante <chris.laplante@agilent.com>

fetch2 replaced fetch a long time ago (2012) so I argue it is time to
say goodbye the bb.fetch shim.

Chris Laplante (3):
  bin/bitbake-setup: use bb.fetch2, not bb.fetch
  lib: use bb.fetch2, not bb.fetch
  lib: remove bb.fetch shim module; cleanup fallout

 bin/bitbake-setup         |  20 ++--
 lib/bb/__init__.py        |   4 +-
 lib/bb/build.py           |   2 +-
 lib/bb/command.py         |   2 +-
 lib/bb/cooker.py          |   6 +-
 lib/bb/cookerdata.py      |  13 +-
 lib/bb/fetch2/gitannex.py |   8 +-
 lib/bb/fetch2/wget.py     |   6 +-
 lib/bb/tests/fetch.py     | 244 +++++++++++++++++++-------------------
 9 files changed, 155 insertions(+), 150 deletions(-)

--
2.43.0


