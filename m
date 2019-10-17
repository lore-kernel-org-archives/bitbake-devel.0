Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr820049.outbound.protection.outlook.com [40.107.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 01E847F6C0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=f+2W5zxE9jT8j9vyGGE+jBSL994tVbP100CSNohI2YgVaa999VGagCKJy8xBFrTFIQxMR4CDlawF+vJ1IYz54uQFfbGs8FU3y9Fr5WWmPr3IVTuBoXsJ3BSL6e24PEFV0kSeGjndTPDHKGfBWwyJoaNyMloI6uq2/gNqdg6Lepr8SSBERN0BvGoZeJmSOqKm0sYV4PLvcYBdWesBLuyKBYCi2wqvcM+XjUCIcDO06HxBW2usdzJeaFZJ/Gvh+AT/3fouYx+XyeHveFVJHWOQNH6/c3KlQsmw6MkmlCt3V3ARdm0LvgtJGXYrlu+nUoDwsEwoVWBwqVgXhOeC4X9C0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=mIxbpJwaFcbfXyq90KvFBy1NCMz0FJx9YwOhMWmHQqc=;
	b=JTynB4q2U8xd4gO1wjlut09C56y9BoBdt4zv/pZHechpZDEHErjNi2OVMbfk8+P+HNqh57mAopw3twuXLI+fLuZ0LxCobV55U9vmkIncMNDU6Sj6I+DTOAeBjwlzn03p69KZaN/0Wr8XiqucDJDbB+UWryB8igc5v6lbH+HsAcrZg4QHCv9rRt4O/+r0ORnGDpmr7fi8m5kE32nuj3lRiTOKECAPqNoLCxJnm12kCGIYezQOJSDv8JCk4wkxBzRY479wqVwfCehasku6tp+i2ljRoOI16Jgb2SaQxx6LwzmRkhnYofFamaQuDm4Tl1oGmxCfprjsdmN6ywWiztq6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=mIxbpJwaFcbfXyq90KvFBy1NCMz0FJx9YwOhMWmHQqc=;
	b=caTWXK/kBNHwJzXKQeMDI5HHMt0oOjQXB6n+JoXbuWzv9vdfCwMBx0o+IktI9Q2/8xLdgi3lzKpEApk1te2POfadaSdccy7vHl4o/IcuHwbspqP5zJ7PwI1aWgpn7TgPDL1PIDHll4xjXa4BOXfnZrTyleG+bALJ//VfVfEGXj0=
Received: from BN6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:405:70::18)
	by BN8PR12MB3620.namprd12.prod.outlook.com (2603:10b6:408:49::27)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19;
	Thu, 17 Oct 2019 16:37:15 +0000
Received: from DM3NAM05FT036.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::209) by BN6PR12CA0032.outlook.office365.com
	(2603:10b6:405:70::18) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via
	Frontend Transport; Thu, 17 Oct 2019 16:37:15 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.37)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.37 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
	DM3NAM05FT036.mail.protection.outlook.com (10.152.98.149) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:14 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:25 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:51 -0400
Message-ID: <a12ff384ce194f69ceeb3a47abcf8806cf17a802.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(29502001)(4744005)(47776003)(44832011)(446003)(11346002)(956004)(486006)(126002)(426003)(107886003)(6666004)(356004)(4326008)(2616005)(476003)(5660300002)(86362001)(478600001)(118296001)(70206006)(2906002)(48376002)(316002)(305945005)(50466002)(51416003)(8936002)(106002)(2351001)(7636002)(54906003)(6916009)(16586007)(26005)(186003)(50226002)(336012)(246002)(8676002)(36756003)(76176011)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3620;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg1.windmz.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a40ed161-c8d7-465a-69be-08d753204487
X-MS-TrafficTypeDiagnostic: BN8PR12MB3620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3620990E7D8187590237628F8B6D0@BN8PR12MB3620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NPVpA/kgmhM22V9nAKTdQDZXVT06Y8AFY0vfJURs4yoWNdoARsRSibE0BZqbf2MP9jGWTIGF/xLDiVRiNOD1eMZl87SDh0E2QuabEPgrqvoEB0cJW9i04ysii1tRRaTlSCxBhGfmzF1J6M4BlrVyg/4c+GcFjyQ8mPhNSBQmEXbfdb4OdkIHQmA6YmHHnaU57a1fMEZpOzBcZK7iIWaoVx4RoDbKOdHnArH+iomDOouBxoXNdTmb/+2dyRL6E6hyODHiIAEt8Oeh78GihR5rdZVWa8z3+YSGSidnidXVQWB/LTJ+FGjvX7rh7TTdoUx6q6Mpc/HYNqzWt44vb9msvq27ncWS/ZJZqqsueBfJiS+Hwkuo7/xWPcpWyonGM90uQ1XLnGOOM9IKICRlQ2CnEyvvSTk45O0wKezr8PAg3I0=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:14.8737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40ed161-c8d7-465a-69be-08d753204487
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3620
Subject: [PATCH v2 5/9] bitbake: contrib/vim: don't redeclare indenter
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
X-List-Received-Date: Thu, 17 Oct 2019 16:37:15 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index d8bffe0..fc428a2 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -2,6 +2,10 @@ if exists("b:did_indent")
     finish
 endif
 
+if exists("*BitbakeIndent")
+    finish
+endif
+
 runtime! indent/sh.vim
 unlet b:did_indent
 
-- 
2.7.4


