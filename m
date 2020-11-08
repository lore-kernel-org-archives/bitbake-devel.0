Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.42])
 by mx.groups.io with SMTP id smtpd.web12.3224.1604873537607307292
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 08 Nov 2020 14:12:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=vNQ0SQms;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.92.42, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWnlIt+ZLNrY2UwidEJeOw7765DIP3v5O9U/Fo7sP5bFP9MO7FGCP4i98sKsV4OeKqZGE15Rc2/G3ZBgIs815Xrk/Wq9IDsyIPQgFCNXZc9Fiq4BxhHKkkF8GLPbG3bqLdgq9Bn4+3EPZ+hHqh03mQMc3awJq67PC6nSNCucP9q0Cxboc57R1CNmEpiZIG98cun8D8O18SzGQJRJb2XSkKbTQNHA75Gh7sZJlHC8yTd+E1VQPD2tVNU/+YADunrrR5WK4bxYRXTQ9imWlaNeBaGaucaMPVcsaEtGufsYeuMMEiJqGwFY+oXaBGL/N1Jk218bLcQ198IStpKfnNSn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXUN86A7057LGt5iT60mpVloA0EjNcJiIibDeH2pTBY=;
 b=oPTj8n0kN3tVQJi4bVl8hhJZJyrbFkKHvMaUXxFvHhljE9lMKAuQIDjDHj8fKUHfUySKDBONNG5PKxk+Pk+t/jAdM4RNhURvvRebtJW4O1UohstiBbN7JNu0nrITs1FMaTmpjLI3APX4Q5Kps5C2Fq1WEheGuFs5sdJphYr7PdYwOYaVVpENMGkrEQY3SRpqZsQJQZshhrbAnAR3U/jfDDBmG3c2XLVA6JwCiSJlVXsh8kPd9ZUDFg2s6fo+8X3CL9Xf9h2S7aRWgkU8Kj4CUKVtZcKrdNxTtGVLe/nHXEnUuwviKP/hNBEfM7jQAFI8+su8b48IOPDvWmM4XpsnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXUN86A7057LGt5iT60mpVloA0EjNcJiIibDeH2pTBY=;
 b=vNQ0SQmsl96THk5ScmlE6z6Ysbwx4DLIRitEOQc5+UxZWXlcbzG07fmy2mPe56OlrkOf4fdl7AwXm7Nt/v+aN+wE+kcAgYuA5Tj6GotWIyw6v+611NkiW8lKkirppf+NMEZUvdjHZvWk+ZvRZaUbRH0XkRGFxPA0FDGhCS2NNggaAWwg2X3fR9Wq5t+4kFPxGlqQXuSxUpX0Gu/WV36P9iZ5jmqU0YezUdGc4Z7s61YE4JbtE7H6ORRO1r2esItz5T+1MY3uApCdZ3lHaoEntlq5GFDPdb4AxNG3SjfIQChI7357TxzCgakja0Z5BN26rmetrhqRxfCVIzfrAIXDpQ==
Received: from CO2PR04CA0053.namprd04.prod.outlook.com (2603:10b6:102:1::21)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 22:12:16 +0000
Received: from MW2NAM12FT060.eop-nam12.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::dc) by CO2PR04CA0053.outlook.office365.com
 (2603:10b6:102:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Sun, 8 Nov 2020 22:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 MW2NAM12FT060.mail.protection.outlook.com (10.13.181.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.19 via Frontend Transport; Sun, 8 Nov 2020 22:12:15 +0000
Received: from laplante-lm-19.localdomain (10.46.38.234) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.2044.4; Sun, 8 Nov 2020 15:12:14 -0700
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH v3 00/10] optparse => argparse
Date: Sun, 8 Nov 2020 17:10:49 -0500
Message-ID: <20201108221059.16854-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 10.46.38.234 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd5a159-eeef-43b8-859c-08d8843359b6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4097:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<BY5PR12MB4097ECE29E66FD8AEA820D4A8BEB0@BY5PR12MB4097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zCpHhbZIHZu0v8lyJM/M+jCHEs7KVC7lkMljnMCV0P0FbkSeuNGJi8FiWYUR+8nCtUnDCQSvJIbWQKWkhl6h9BIbMYn5ebM32bF1/63EFgwyvBo0lpqapT4s9PMfCikVWEEDuCaVOZS984pAQk8DYaWyXIcobU2R++hYwy3IKE8SrEXGbY5wXMyZv0Cqr+ZNQNTcYkfi+rFNQNbreDxnEJZzGaN2v5f1CaMSE61bHRQmfkuJSOto5YfDlLpdT8NFlt1LW6PoQRffvIXVKCBlepf+wpXzphaZj/YvUdglb68XGSBInJDWjA2dnIRvyz89H05vjdXIvZ0D1v+LDTipC2RCgIHvnED0JWUPmLV/esUyvwGSKmzobM/ms5DH79WExJjXbD/9cKu+o58tKqwBO3oOmKmoA0HdzrkdHaor/uw=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:cos.smtp.agilent.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(29502001)(46966005)(70206006)(4326008)(1076003)(82310400003)(107886003)(2616005)(6666004)(36756003)(426003)(7636003)(8676002)(47076004)(82740400003)(478600001)(336012)(86362001)(36906005)(6916009)(316002)(186003)(2906002)(5660300002)(26005)(44832011)(8936002)(356005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 22:12:15.4948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd5a159-eeef-43b8-859c-08d8843359b6
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT060.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
Content-Type: text/plain

v1: initial
v2: fix intermixed argument parsing
v3: fix TinfoilConfigParameters defaulting of 'ui' with string, reorder
    patches

Chris Laplante (10):
  cookerdata: tweak to avoid mutable default argument
  tests/arg_parser: add stub for testing arg parsing
  tests/arg_parser: add test for 'bitbake -S none world'
  main: migrate from optparse to argparse
  main: group --help options to make them easier to read
  main: rename list_extension_modules => load_extension_modules to
    clarify its function
  tests/arg_parser: add test for lazy loading of bb.ui modules
  main: fix parsing of intermixed arguments
  tinfoil: use knotty module itself as default 'ui' arg to keep up with
    changes in setup_bitbake
  tests/arg_parser: add test for default TinfoilConfigParameters 'ui'

 bin/bitbake-selftest       |   3 +-
 lib/bb/cookerdata.py       |   6 +-
 lib/bb/main.py             | 327 +++++++++++++++++++------------------
 lib/bb/tests/arg_parser.py |  62 +++++++
 lib/bb/tinfoil.py          |   9 +-
 5 files changed, 240 insertions(+), 167 deletions(-)
 create mode 100644 lib/bb/tests/arg_parser.py

--
2.17.1

