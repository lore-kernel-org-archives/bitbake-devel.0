Return-Path: <chris.laplante@agilent.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr800052.outbound.protection.outlook.com [40.107.80.52])
	by mail.openembedded.org (Postfix) with ESMTP id B47FB6C3B1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=A9splK4+czUH9CXp6J+ngN1Sb+tsXtJfM0Si1oawMVRS/ygl/FYRHBsCd7hi8RJuoRBmD9O8RPHinQNedDkL6tNUvMOa1H8Y3Y9CKDymRKaUofW3icyWl9cvzHEW8GKoOQ/hXxwl53JooQx11HB3cv81bnAl5toHbEFF80+H8lVhErrAHb+ook9xMv6lGhxb4XJKEZp/g1caFUi6eOtQeLrUW01zfg4KxfbXW2U8M7ESXTANMH1FHHyCyA+5Ijqj0tQdxKRXHr35F0pOou5e8UgfINziEipdcsGNW8q/rGDEASBMiZO+LMYNS5LxNRYFYGPRlvSOZxx+XJ/AlIfxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Vyo73qanttp0eBMBrJ7DHlsU9C09HP3IusS7QD2XRIs=;
	b=JS2KrZ5EOKB0ChCaZ0Crl2dpRbNZCjDyDUC/W9GJa1Rp/a65GOWBUl3l5jLD+RqO8Ax9zNbaK1+nj+4oB98vcXc8kHtPE2vCNyJ2vvIIQrtTJiLSpcJCLypUHPTpXm5zxBD4mcjsOnpQUTxM6o4bhbL9Z93kfJXFD2QT2x4jwM0aCgPUP8Vy275//kasB3CS4V8IAH8vAWD2cfDGsmN/UXE4XZtdfc3JROJN1K1iGSZ3F0eZ812bXZO6w2tICF4sgm6J91yd9Z8JpJs1aVb4xfovHclm4zr6p7b4rnyFIDCTKl6ufyfL/7Z1CzTlzuWs4rOh8Dk+cn2ajpOWxmOaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Vyo73qanttp0eBMBrJ7DHlsU9C09HP3IusS7QD2XRIs=;
	b=Bfs1FSdE5bB1hUzFtDfxXUmXpvdQik+IUsoyhBjH5C5qHP60g65H/0HL+1y8Vc77raVzF+ZnPN98pbcuKpoGF2y1ZDEg+EDiMiWVICFPuNePf8srZ4QoGj6rCFS/nDCxY7TRJTVwTfNQCjrBuzXwslO1wj16QGiIAkgBhqDnpjc=
Received: from MWHPR12CA0036.namprd12.prod.outlook.com (2603:10b6:301:2::22)
	by BYAPR12MB3063.namprd12.prod.outlook.com (2603:10b6:a03:d6::21) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22;
	Thu, 17 Oct 2019 16:36:56 +0000
Received: from DM3NAM05FT034.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::208) by MWHPR12CA0036.outlook.office365.com
	(2603:10b6:301:2::22) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via
	Frontend Transport; Thu, 17 Oct 2019 16:36:56 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.41)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.41 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
	DM3NAM05FT034.mail.protection.outlook.com (10.152.98.146) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:36:55 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
	15.1.1713.5; Thu, 17 Oct 2019 10:36:54 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:46 -0400
Message-ID: <cover.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg2.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.41; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(29502001)(189003)(199004)(476003)(2351001)(6306002)(966005)(2616005)(44832011)(4001150100001)(186003)(47776003)(36756003)(6916009)(14444005)(956004)(50466002)(126002)(305945005)(70206006)(7636002)(486006)(8676002)(48376002)(6666004)(2906002)(4326008)(336012)(356004)(426003)(106002)(36906005)(316002)(8936002)(86362001)(16586007)(26005)(54906003)(50226002)(5660300002)(478600001)(246002)(51416003)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3063;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,exch.smtp.agilent.com; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55677675-dac4-486b-d26e-08d75320392e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3063:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3063D6A19C4F519E48BC440E8B6D0@BYAPR12MB3063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gc3T6ifmVJielxmJMXWKgAsKu/BWUsRrQdlE/k2yi1jxoqHB8h5qwNOs7iJ75Xo5Plho/W6vnqPYidpDorruLtEw72l0W3DKvSvt2nOwElj/R0wLezFn8Y9UDXDAQUjUKy6QX5UVKUT/8sjPIkbbuK3xW6u2KQ84O/4YuDqSMGftQVPPu4bBnMRbRcGzs/O2AZez5jCBK29+tAWezfODTkopH191AdQyxZAXSObK2s275CyfViNhxBZRbbbobIZ43NYnxkem5XxUdVvus728LVBQIrPEQWbxkuEZcWSQSOhNSXNXh3Bp6y14Mkf+e0hpZniXmh9Kx2+Z1bLM6ika3SjFJJrDn90NQuqeswFZIklObkRBuZo5dRfd4eq2MlSAQgG2cxNPW9sf3iKG+V2fcwNDPwBnJT578xIewrO+awCu2GfXL+kUYRjKSZJaglPBiJHFbpH95zbyzuys5MYGXg==
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:36:55.8392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55677675-dac4-486b-d26e-08d75320392e
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.41]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3063
Subject: [PATCH v2 0/9] BitBake Vim indentation plugin
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
X-List-Received-Date: Thu, 17 Oct 2019 16:36:57 -0000
Content-Type: text/plain

This patchset adds Vim indentation support for the BitBake language.

It supports indenting variable assignments, Python and shell tasks/functions.
To accomplish Python indentation, it uses a hacked-up version of the Python indenter
from Vim upstream. The upstream shell indenter is used directly, without
modification, however in the future it will be necessary to modify the shell
indenter to properly support "fakeroot" shell tasks.

Changes:
    v1->v2: mention the license of the copied Python indent code
            add upstream commit ID from which code was taken to commit message


The following changes since commit 52a625582e616aeb7a60411b58211e9fe1365863:

  kernel-dev: don't use _append += (2019-10-15 14:17:58 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib cpl/bitbake-vim
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=cpl/bitbake-vim

Chris Laplante (9):
  bitbake: contrib/vim: initial commit, with unmodified code from
    indent/python.vim
  bitbake: contrib/vim: Modify Python indentation to work with 'python
    do_task {'
  bitbake: contrib/vim: More Python indenting; move indent file to
    correct directory
  bitbake: contrib/vim: Special handling of bb.fatal
  bitbake: contrib/vim: don't redeclare indenter
  bitbake: contrib/vim: renaming & comments
  bitbake: contrib/vim: indenting for assignments; tweak Python
    indenting
  bitbake: contrib/vim: handle shell indenting
  bitbake: contrib/vim: Add copyright and license notice

 bitbake/contrib/vim/indent/bitbake.vim | 343 +++++++++++++++++++++++++++++++++
 1 file changed, 343 insertions(+)
 create mode 100644 bitbake/contrib/vim/indent/bitbake.vim

--
2.7.4


