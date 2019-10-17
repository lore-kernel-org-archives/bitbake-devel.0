Return-Path: <chris.laplante@agilent.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr800055.outbound.protection.outlook.com [40.107.80.55])
	by mail.openembedded.org (Postfix) with ESMTP id D7E8A7F6CC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=f7MMPzZRS9FdLX0Qav3lNbfACKg9/0TrdsM6X+1wJ/5IQnxIsWpoQTKTcsWOOPlHgbR+IhTjgfRzsTLeoFTRXQuX/8o0j9MKtCpZZLVmmY91afT/m8ghyZuah/ULI3I7ps1GvzyLZUaWrWX0gR+aGaj/F+EC8h9m8dEcmcJha+vUDNrM4FsUlU/FiWbJlKyvI0pKBo6lFY04kbbwsw+RHNE8F2FScptUHVx92RV/rEOtK+aU6fKISDqVQHrnZgxDxuI47z/t/A4QVWmQN9iFineBtAqP+XPBtmm7UXpYAWz4U2kGgtQhFxnDsQvIxjNyHcoh/llot/6ck7H99W7Zyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=O9ut4535ss21yo0NiUOGrxWzsYlOTUVy7iWRC/TJK8k=;
	b=bJZxO13MBaND0+g0hTWNgsEuhywPPzOk1+l03PSju8K6dhXX4fV2XoFAVksc7wq0GU6hqsnvQN0ESozTbh1SgSh9xJKkcXtywXPs+erJZArFbBva8c8mGjJrtUu4osLJsjSStQ8rmprwPzl+d/ZoqDcC22XjADzOgKGHpDONzd9mgPRKMMOfmrhFkqMqxd6D6jKFKpT3BnIvgHmtVWX+VNccOTskxMLGFGRCMwmxaIjm0VWVCjr04b46TlBdVpGErSnuf/l/Adan9LKwDQZuEP6GWsOxlsiOYfVuQZ0iM8CB8kFGt/si8iEP5pbGdxCn2O2KGywX2GVyHM6IQytsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=O9ut4535ss21yo0NiUOGrxWzsYlOTUVy7iWRC/TJK8k=;
	b=Z37tgXYM4PfZhpnJKo6GFMLz39W66xkmw1CTdtq/oeZziLkonxGPy4wxPaV6GfCWTuvjLbFAm+FrCmWDNdQ8ACZ5F/xJsVoq4utckGs4qRnD13DCxlNcRZ5jdyHUf6HL5+YN7aTOk0PjHxJPO4gdaMEMi5eSBNjvZV8lgRn3o+M=
Received: from BN6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:405:70::13)
	by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.23;
	Thu, 17 Oct 2019 16:37:19 +0000
Received: from DM3NAM05FT036.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::203) by BN6PR12CA0027.outlook.office365.com
	(2603:10b6:405:70::13) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via
	Frontend Transport; Thu, 17 Oct 2019 16:37:18 +0000
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
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:18 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:27 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:55 -0400
Message-ID: <59ed83bcad54fd47d80fa7cf8a77b8a4a5180f1a.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(29502001)(189003)(199004)(2906002)(4326008)(107886003)(36756003)(51416003)(186003)(76176011)(2351001)(316002)(50226002)(54906003)(118296001)(106002)(16586007)(478600001)(8936002)(50466002)(7636002)(356004)(6666004)(48376002)(246002)(70206006)(86362001)(126002)(486006)(476003)(956004)(11346002)(446003)(47776003)(2616005)(8676002)(6916009)(26005)(5660300002)(426003)(336012)(305945005)(44832011)(4744005)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4314;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg1.windmz.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4b4ef73-9772-4a9a-167a-08d7532046cd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4314CF96A862F02754A044878B6D0@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8j32/23BnPokNttKFQ05UJhoBVmLbuU2z0hTa6HJJIjMLlF3s976rcVYsuVIHsTnOydYJ2ETz9ysocIWvgO3BNab/oUXulbIbPdU7ve3KDKdGEo67Qdbz33WD8H9FyeQVMJGTTAupItqWbP+55JT0qBKK3UG6CSkWbcRMKldK4vMg7e+DsqGp5GN/Cz//ncrH0woLnd2EcVcbnG/iA41trZzMHsmfK9bAb3G9LUXIIHjGwYUBfxOHFXhS9L30iCwP6V7GDz8kxLks5nDIGKF/tkgt/7xWwb7HQ+F+GivIO6bsg35lTDJRD3AaBnYD07TQs/6G5LQZiQC7weIB5v5eyd7I7oa+RsVs5BAljwIdqgpPix2UyWr5nWq4qGBF44paOv3YIFOKysn4s8vTcwkChrwneqk18AIk5mhPfNO33k=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:18.6688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b4ef73-9772-4a9a-167a-08d7532046cd
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
Subject: [PATCH v2 9/9] bitbake: contrib/vim: Add copyright and license notice
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
X-List-Received-Date: Thu, 17 Oct 2019 16:37:19 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 1d99395..1381034 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -1,3 +1,10 @@
+" Vim indent file
+" Language:             BitBake
+" Copyright:            Copyright (C) 2019 Agilent Technologies, Inc.
+" Maintainer:           Chris Laplante <chris.laplante@agilent.com>
+" License:              You may redistribute this under the same terms as Vim itself
+
+
 if exists("b:did_indent")
     finish
 endif
-- 
2.7.4


