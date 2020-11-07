Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.51])
 by mx.groups.io with SMTP id smtpd.web09.6768.1604715675470608728
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Nov 2020 18:21:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=T+ovDYTF;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.51, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/Jpp3lB9NwlL770qdOB87vS/6usyG4YrN0B0Na1WQ6oxIpJ39QzILgxJDGbu9c8FJjSBPIwt0IVW6M00oVijlKmD0pV21NapJK3u7fYSK4dnE23ZKKmHUshqD6kGu5LExFmPyKoJldqQ1g/03/DSpFcPzTEPGnGrAFgxP7pVTaV/SczXITi8UBdmlWHyv1LUQ4TQ4K3nNFjkgKmfHSa2NlhJ+Guwuo8cE2ujGmLdNH235P3MLAtLWViXD0jAzlQNeqh/BSdAfgelXhSl66xArkEQIHMXrKilKLepj7HCwD9O39hf1BJKxzP05nIuTDXLNCzOAIFIeLokffKLh9W4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQCpsWRDAMCoAMbSf3u92GyYw/+tPS0N5rUCspIakR8=;
 b=czPNWR5CxjfgLUUCTtmjTJ8iGR/Y0QUQm9T0+OPV57U8j2EkjffXFsdqQmsZwCTo39kiX4qqW+/SuX6v8KmTmmeKywHIjMlMYJo8RIkTCJvc405VcGgdxu4af3FnVz1I64kU5KQmcxMpMis0FInDRzU0WTA2sW2Pqaa0GbX7szd4+bTe/q4qN98ykQ0TffJ0ZfFHbPwQ6QigOMLvHqfSVwaDTkbZkz3mE3O8TV6Gx+Duw+w4w62v8kPmJBiSje5H6PpwD2GKStrMyPPV4hiPk+XGE0CrE2Ru6eEdvCYSdxDgjfceqRmVFsacS2HdLe86vp5xGemRyygrdGYQ3e2mZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQCpsWRDAMCoAMbSf3u92GyYw/+tPS0N5rUCspIakR8=;
 b=T+ovDYTFh5nTZyAb7ehFJqNpDVIfOiKuW4/JXfrcz2JXpm3JwryqUeTnMp/p/+BtngK86AtegsFXEGB/YjNYgtYi8xUzlD3F9rsAeFvC0caMLQNZaOoFSIT9+QfiQdtSyjifVYG9Zng6FLzPz2K27FkWafxTgjISN5KPUfuvsAWe3PkZ4M8Ib4ZdZ3PlDldtvVz7d0M4oyo3ZbBpRP/uDPCPCQo3yiT6pcm04LbTwk2aAbfoVzVyw/GmbwQwFNtuNrTGRWwu0O+PGfB3mc8Bo8Ry4O0o6Ns8Ng5JnEreOEvY8Y7Yju4U5rc6MYepLZVG7utJK3IqkAzNj6SGgFso4g==
Received: from DM5PR15CA0049.namprd15.prod.outlook.com (2603:10b6:3:ae::11) by
 CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.22; Sat, 7 Nov 2020 02:21:14 +0000
Received: from DM6NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::8f) by DM5PR15CA0049.outlook.office365.com
 (2603:10b6:3:ae::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Sat, 7 Nov 2020 02:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 DM6NAM12FT044.mail.protection.outlook.com (10.13.178.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Sat, 7 Nov 2020 02:21:13 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Fri, 6 Nov 2020 19:21:11 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v2 0/5] optparse => argparse
Date: Fri, 6 Nov 2020 21:21:01 -0500
Message-ID: <20201107022106.84056-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae476a43-4dfc-431a-1961-08d882c3cce0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CH2PR12MB421532CE4037510870D1F8CE8BEC0@CH2PR12MB4215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	96+FE+aBKzKuZO4KYGk3cM3Bo/izPCiH0wFF+HVIZPPdmjhHTGkWREK26aTDXOFVHSrvTALkkhW3oro6B8ubiKUIy0zg9u2WPDEyeLHqPPBpGJvGqlAN9gkazeWSsR8Zk96ykA6W/sSeNHkovOBETWh/TDWjpgyqhhkKszZVt+wCEWM6UatEkG7nHpxNl38CXd+oewgzFQ/98HTlZCMck1OMV8Vc0XHtlfV7bTBj8sZ3tMQJAeIuZVnwgs4jJIk+QrleSkfP6SNj4HtTr/8lYJg+RRxcdimI6fpOUBZT71Maj9dfl5gFIrD3unWDBJu2uB59pwXFuEuleD2QNEumqXtxoZOdtNKEVX2tODdz9g4fPjUKi82fYOSKtAe4UGyisaNzDf1YWTB/CkvhcewJdkaOyW3W2JW9JUz+ZPKjrsA=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(29502001)(46966005)(2616005)(36906005)(2906002)(6666004)(426003)(1076003)(82740400003)(316002)(44832011)(8936002)(4744005)(70206006)(36756003)(86362001)(7636003)(83380400001)(4326008)(356005)(8676002)(186003)(47076004)(5660300002)(26005)(82310400003)(478600001)(336012)(6916009)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2020 02:21:13.8718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae476a43-4dfc-431a-1961-08d882c3cce0
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM6NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
Content-Type: text/plain

v1: initial
v2: fix intermixed argument parsing

Chris Laplante (5):
  main: migrate from optparse to argparse
  main: group --help options to make them easier to read
  main: rename list_extension_modules => load_extension_modules to
    clarify its function
  tests/arg_parser: add test for lazy loading of bb.ui modules
  main: fix parsing of intermixed arguments

 bin/bitbake-selftest       |   3 +-
 lib/bb/main.py             | 331 +++++++++++++++++++------------------
 lib/bb/tests/arg_parser.py |  30 ++++
 3 files changed, 203 insertions(+), 161 deletions(-)
 create mode 100644 lib/bb/tests/arg_parser.py

--
2.17.1

