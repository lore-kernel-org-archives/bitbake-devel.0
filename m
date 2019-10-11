Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680067.outbound.protection.outlook.com [40.107.68.67])
	by mail.openembedded.org (Postfix) with ESMTP id 3CF377F598
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=P4uvO4EcKIsdP89L4f6yD0O/GeyQZ5DUvtNBoKJsyrOmhQwswX55bSxvAD8Tr8JclLNiuuh4BfcUERSdAPob1Lc6VEKAk/QseJEFZ9aBKUK+NvtB+37iaPaanWW8zu0GFUvJm9ZbD3atTz53wPHiZqinQxVyyASa7/UMycraQVCJ86aoTJhYFVVghDTbzC0GPCSh9GEyf8KXHHRDsH890hvJ/CksoFamF3XFRabmCLnNFFOp7Dj3kLoNpof8/ZEMBhv+QgP1uQp67JuoirE96JdTvnyWJkzgLDBRBASk5ARVnNByejSL779ir86m1gWTuYabyR2R4CxeqOSgcIIr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=L0Hun6UHUEwfqGSus7Fm2dRkGOdnYfTke7DFU/nGutE=;
	b=idDSy4fUEk6ysUCuGs3n9v4ZIakNbzQ/YXDavulFQfF0JaeEIbixezttnAoCwBwOitIc7TTsLypt2OQi/pPsXShpOAXrUGHJT1UIM4/5tIWE0SlIPatMBYBvPOlpEF6ig2Zz/HqnsNmusHBLPriFViXAUZiTobYPhduVbQUdmpKg0B2jidIca31BtxzHIvPYXfXIE9NRX+X4siIM/1qYnB7oW8BEIvniEzqkIAqcnag6rqg2WcNfviY10yPMt08utnJRAULho60Lvhdbgv23hM7EpH11iE3WYbnLOCtRZMOvBufulX/a+qUYfawgOSQiEuIlj3gKDtrd0MvGstvsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=L0Hun6UHUEwfqGSus7Fm2dRkGOdnYfTke7DFU/nGutE=;
	b=A6k63rVkRODF8BeH6aeEMLjwf2TBRII8iW6f/4ebGum7ikCa4MExP+N2ZDNnUq5KpoOIXs52zjUQpnLGwe8Cr2AuLbSEGgbngaHwwW7xlOXSQkHdESzExYcQ7CpAKyoCY/Pk2fpvkEii0dKjBVllXe3pqF7y2Q9MtyDypsFSy4E=
Received: from BN8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:60::42)
	by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Fri, 11 Oct 2019 16:23:30 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::208) by BN8PR12CA0029.outlook.office365.com
	(2603:10b6:408:60::42) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:29 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.34)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.34 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
	CO1NAM05FT045.mail.protection.outlook.com (10.152.96.159) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:29 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:23 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:04 -0400
Message-ID: <2176325f5fe03b970aea7ac31e5cb2129c483da6.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(29502001)(7636002)(54906003)(186003)(2906002)(106002)(50466002)(36906005)(4744005)(316002)(16586007)(44832011)(36756003)(426003)(26005)(956004)(2616005)(476003)(126002)(336012)(2351001)(486006)(76176011)(51416003)(305945005)(5660300002)(86362001)(6916009)(11346002)(446003)(8936002)(8676002)(246002)(48376002)(118296001)(107886003)(70206006)(4326008)(356004)(6666004)(478600001)(14444005)(50226002)(47776003)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4260;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1691f6b3-16ba-43af-2074-08d74e675a29
X-MS-TrafficTypeDiagnostic: BY5PR12MB4260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4260996BDCD1BA359E7ED7E98B970@BY5PR12MB4260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTAGVgjbKx/AC28qKPuzJt6yzbxeybHMm4NU1zXl4nRI119wHjebhlQsfOx6kxuS0gXrwBKcAn6vYaK6Xw7VmYTwFAYQIT4sBYgTscE7m2eBGnI/sB95jQg3mnYsyeJRACbOYJOvi/qUe+qunoKYver0fvy0ziT8QO5YLqPE+BxlqulBbhKPGqXorOeeAq2MwY2OIPWom8WY08bzJmccspU4UxqalC+384cu6sMmCl3uaAfjIy0ggpimyS/zpgZMWIMnEvYCFxkfBMOFuMZOuYBArwlwkwFI7Xwx9ljEKrTMP0KAvXab1G+hmvgRC+uPAseGSv4l2sK8Omy39aU/K0F/cY1RzAWwR0ecJIzeuwmJoSGOyP2wTSN7S5HyaPvWALT45C9tJcBWcAkHhc/nE5m8SqABZJqB1DN9GgYg4CM=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:29.6296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1691f6b3-16ba-43af-2074-08d74e675a29
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
Subject: [PATCH 4/9] bitbake: contrib/vim: Special handling of bb.fatal
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:30 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 76968dd..6bd7b1e 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -175,7 +175,7 @@ function GetPythonIndent(lnum)
   endif
 
   " If the previous line was a stop-execution statement...
-  if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
+  if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\|bb\.fatal\)\>'
     " See if the user has already dedented
     if indent(a:lnum) > indent(plnum) - shiftwidth()
       " If not, recommend one dedent
-- 
2.7.4


