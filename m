Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.57])
 by mx.groups.io with SMTP id smtpd.web10.3080.1604873547753650537
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=joCd6B4l;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.57, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlShT2278Ra5RZcwvXBUh/IdY4HmxKC/6G2JnX5S/OXz8ext8qoraF7DG5zmEd2w7qYfIQZAKdpMirvZx1hXtieL5h9csfm/lB0URPlb01aSlbsbSGkIpirqc9j5LZZ65XQ3Jc2Cs4MRjHwHGokWJFlq16oQe57uqIglJMFRfh6anPtdRuMtpjKNdjNPulCYfjlQGusYv9D0jQ+pJLt+PnURsxAQ613E9QFxD/XH9qY6uRClEClzA7rlbMBBxHbQ8r4yVeWMDzllVoIIZrGDaH0XMMiEdyYiJkkiuxl2H2+yj0GXANHZj6MjI4YPh2f7kWRutoXDItzo4PMsjQFWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx4Ax5oDwpuF+oaL8QDAmlg1VsSkFDpO/laxL2uD+Pw=;
 b=L2OKoJQ9SiuYwz5DvzbLi9+hQNYIv3qvgfu3tb/Y6S9BPsTdiYQr5q1gjSv1BavPrRKvbQ9qGzD/wp4Nx9v6QKLoUDhAXpnRGjNiuZhZ+VngDqf5hjpQWGEzJv1RPNV8EtWOVp7eRn52OunCSBy9sq9hryM4D9Smq3ze8Ir2RcRcaxQEEAgeqVioVztQ4g8jlhW9UvlN6yOUCw1SHtOyIGdAnA7tAQqzKNLck3L7+ZxUYIpJL84L95wNQfvo8jwp9J8S7vAhWupTRtWi1KGQNsVllxg642OSqcxvJpzUqfacRTNHhwR4MYLsZ9q79xOpqV3MD0EXOUvSinfZ4Z6iSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx4Ax5oDwpuF+oaL8QDAmlg1VsSkFDpO/laxL2uD+Pw=;
 b=joCd6B4ld1Jf2qgP5lCA/R8IFPRUk9f0xoX+4I88IC7tpbRLCi39HAdhdQQJgOHtXDu0Eb1zJVSB0SRBX0Uzi6XDGfpIVGs/+um1Lgoms5BwvYOvI0WdYDpjupCJASC5WZUTF0FjQS1ADMF2IYk9OJXW2/mP66K+fnzb8Uc6qMkOQRthI+m+XfVzjVNUcd+BxSvTLGH6uh0orjzfEP6r9mRMvB8Q8ZtRhfSUxnmAYT99tgwm2glcTHy5T+VHZHAFGUf/Slo12eA42nKAbebEOx5fBRGrTFDY8tjT08rYkGqnawyv4XXf8vLkZF3Xg6iWzGigjIYfGR8ZZSQ7Xm+wDA==
Received: from MWHPR13CA0014.namprd13.prod.outlook.com (2603:10b6:300:16::24)
 by MN2PR12MB3952.namprd12.prod.outlook.com (2603:10b6:208:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Sun, 8 Nov
 2020 22:12:25 +0000
Received: from MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::62) by MWHPR13CA0014.outlook.office365.com
 (2603:10b6:300:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT046.mail.protection.outlook.com (10.13.181.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:24 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:19 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 09/10] tinfoil: use knotty module itself as default 'ui' arg to keep up with changes in setup_bitbake
Date: Sun, 8 Nov 2020 17:10:58 -0500
Message-ID: <20201108221059.16854-10-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201108221059.16854-1-chris.laplante@agilent.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2404df86-d10f-47e3-62af-08d884335f34
X-MS-TrafficTypeDiagnostic: MN2PR12MB3952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<MN2PR12MB395279DC98F0B7D923F336978BEB0@MN2PR12MB3952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LKKWQedxC24opMa9DITHgx69378BiqA53PSZV8EGpkeH9dmg9ZNeIq/OVkgJHwEi9p8Pltzb33ivb6kD3OWhXg66/k4VGBBZwZj8TKpWn7krHJBL/JRzrt7TpSWXwscOM0NFZHn9KCEldQxbAeiKSnHFZBKhl02nPpxsG4pVzbQptWF+s8RpFTvvoHiviNxYyPF7v7Dgpgj55sn15pyfdiT7lTlEiUFrpBdcwkLOHNok/hhRClTtMZv5ajduGdYu4XsW7FNf+cxZGRl1Dti0sFbn+/j1yffT54s4457gCgVNd7XWaMtwl5BnGssVd8clXFdEBNTgDfeVDFQ4r5UNE6tAggPlvIxiDtgzoaKG2qX88BnVUUGM0DJPgtVAeICEgqB2tUoFmo13suJwWTGXPdeyP1W+cYP9N+GZ9e/YWvw=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(29502001)(46966005)(2906002)(36756003)(356005)(86362001)(107886003)(478600001)(4744005)(186003)(7636003)(6916009)(83380400001)(8676002)(82310400003)(44832011)(82740400003)(36906005)(426003)(316002)(336012)(4326008)(5660300002)(6666004)(2616005)(1076003)(70206006)(8936002)(26005)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:24.7213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2404df86-d10f-47e3-62af-08d884335f34
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3952
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/tinfoil.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 763c3298..766a45db 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -867,13 +867,14 @@ class TinfoilConfigParameters(BitBakeConfigParameters):
     def __init__(self, config_only, **options):
         self.initial_options = options
         # Apply some sane defaults
-        if not 'parse_only' in options:
+        if 'parse_only' not in options:
             self.initial_options['parse_only'] = not config_only
         #if not 'status_only' in options:
         #    self.initial_options['status_only'] = config_only
-        if not 'ui' in options:
-            self.initial_options['ui'] = 'knotty'
-        if not 'argv' in options:
+        if 'ui' not in options:
+            import importlib
+            self.initial_options['ui'] = importlib.import_module("bb.ui.knotty")
+        if 'argv' not in options:
             self.initial_options['argv'] = []
 
         super(TinfoilConfigParameters, self).__init__()
-- 
2.17.1

