Return-Path: <chris.laplante@agilent.com>
X-Greylist: delayed 7263 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 07 Jun 2019 21:58:34 UTC
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700081.outbound.protection.outlook.com [40.107.70.81])
	by mail.openembedded.org (Postfix) with ESMTP id 679D07E4EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2019 21:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jJg6M73uPK1z6NUlb9mTVTcgASFtI7/uT+wwwD/HPn4=;
	b=Q0YWBUVxi68urIEsFWJTw0k5W6j3oQm3SoSSKcIrq1jzYUG5IqLjN00xmUbdhXuQYH+3iXj3tvHjSr0ZiQfZCAayvym28DsGKZ88VjQJU9/Ze2zNugxlu3o/XTuyvj3LXmEbjEmKFTmMU02DQvPsKW25+Xp22Gw0y7NobVGHjIc=
Received: from MN2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:208:a8::23)
	by DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b5::24) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15;
	Fri, 7 Jun 2019 18:24:31 +0000
Received: from BY2NAM05FT003.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e52::201) by MN2PR12CA0010.outlook.office365.com
	(2603:10b6:208:a8::23) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22 via
	Frontend Transport; Fri, 7 Jun 2019 18:24:30 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	BY2NAM05FT003.mail.protection.outlook.com (10.152.100.140) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1987.5 via Frontend Transport; Fri, 7 Jun 2019 18:24:30 +0000
Received: from localhost.localdomain (10.46.26.152) by edgeappmail.agilent.com
	(192.25.218.41) with Microsoft SMTP Server id 15.1.1713.5;
	Fri, 7 Jun 2019 12:24:29 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 7 Jun 2019 14:24:00 -0400
Message-ID: <1559931844-116966-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(189003)(29502001)(199004)(16586007)(49486002)(44832011)(126002)(486006)(186003)(77096007)(476003)(26005)(336012)(2616005)(106002)(426003)(51416003)(2351001)(36906005)(316002)(246002)(6916009)(356004)(5660300002)(305945005)(478600001)(8936002)(8676002)(47776003)(50466002)(48376002)(50226002)(86362001)(7636002)(6666004)(4326008)(36756003)(2906002)(4744005)(73956011)(70206006)(107886003)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2533;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,exch.smtp.agilent.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38162040-825a-441b-b777-08d6eb7561ea
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);
	SRVR:DM5PR12MB2533; 
X-MS-TrafficTypeDiagnostic: DM5PR12MB2533:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2533F6F8C55823AAE2CA736F8B100@DM5PR12MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0061C35778
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vHKkR3sSq1yOzNlYm8yKT6EdWwlrnxtL6j4HR3YO0An25/lk6N43uLEnDr9StA6RAW4Rh8flPS+YDAQIM4Gg2qHvZnpxXpCqQCsdp0vlw2a4dCDFfgZSgylEX+yMQljxcZFvsymzyQTD1y73fZGwSbeY9BitjB4i5Ddd2wFWGv4i4N5eRanGeAYYhvLRq97tWxPZRiIXoxDP78gsOGu+QGfDSLFeHxJNYRxSDiTyWlN5uyPMaATX2F60bpFl/NEhhDZ0+RrpaUp0OZ2+Ri1cRYSH/knO8TYlbb+sgDZD0rMrNEb2dcC9JL07R48SvxD+9po9wJ/NboZZXSS5+Wrb1CUA7hQEyYnXE19z0ThtU/0dWTJ9hzBfifWMwU6yE0EuBwCstOE+oIAPWwT3/7HvcM+P1LlzZy4N0s/qG/wqfRA=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2019 18:24:30.1893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38162040-825a-441b-b777-08d6eb7561ea
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2533
Subject: [PATCH 0/4] Progress handling enhancements
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 07 Jun 2019 21:58:35 -0000
Content-Type: text/plain

This series of patches supersedes a couple of individual patches I had submitted in the past but that were not merged (either because of feedback or because people forgot about them, I guess).

For simplicity and to consolidate my work, I have prepared this patch set.

An additional change to poky is necessary (I will submit it soon) for functionality in the last commit to be fully usable. But no harm will come from merging this patch set before the poky change.

Chris Laplante (4):
  bitbake: knotty: allow progress rate for indeterminate bars
  bitbake: build: extract progress handler creation logic into its own
    method
  bitbake: build/progress: use context managers for progress handlers
  bitbake: build: implement custom progress handlers injected via
    OE_EXTRA_IMPORTS

 lib/bb/build.py     | 79 +++++++++++++++++++++++++++++++++++++++++++----------
 lib/bb/progress.py  | 16 ++++++++++-
 lib/bb/ui/knotty.py |  2 +-
 3 files changed, 80 insertions(+), 17 deletions(-)

--
2.7.4


