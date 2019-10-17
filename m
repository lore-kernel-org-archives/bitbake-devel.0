Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr700076.outbound.protection.outlook.com [40.107.70.76])
	by mail.openembedded.org (Postfix) with ESMTP id D96607F6E6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=CMflYtyNADQY4pPg7bALShvXRfJ9539a7ntSfXRaJWLJcX7hKH2i0qYRh07PnxIysJMQ1yOSRY5+u6SivWj+fSY3LKN8twbbFwij5W6srTN37DpiH4tm6VoTT907dGZSL1k4EPn6wkoDcN4fTTkKHkLOgYJ2C9Ul5QtlTtXSPAg5/OjMn6drTV6bUSq5Q5hhMBgpwAvLdPwpOfLX5qVw87fpr0rjlX182HrS3K8+VUG82jkKjHZrvynF1C/lHrMLxDbYz/oOd+qmVm6xGISszOAaYtxC60rJ4XdgEl46rCOXDBCIkOAq32+AfyWl2iHcPEIMKhy+RlcGAjRy0dktRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Xolq/Dm4o4QSj9C1/+lQMNCfBkt1OUE3OPIpW2f0PvY=;
	b=iZMDbq1mu6tvRCB4PovZHvmOOIC1NQKB4V0C0qQWw757vL0p7wr0aXsGMjf1Z2hiU+YZdefvmuxODCKkhLDmGhM34MySfG9SzXzdSnkJnyogtseIHQBscd5Df7dOIBYOeh51WixItybDupJdYb5tejp3RKCJ6GKeF7u+vbv3gltOFB/NrbiD5T5Antbxvl4ZWlHOMoUdCLkzXAIw5yBUEn2CWz37OhC9w3+c0B5RUfEY5a2/GU6rjVQCzGtSKSV4SpKstfjO6JEAln5QXXfMPjDTuBgE5LvkjayWAOWLu3x+rtgnyfoBpXOXEVGR745ZGpGeufikoaDHCkEUmUB92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Xolq/Dm4o4QSj9C1/+lQMNCfBkt1OUE3OPIpW2f0PvY=;
	b=jZQdJPNz3v92UPgAxjGZSzq6N37obTXQxPBo2Ws0U13hhrmN8rQhG8ME+F0Vk+1Rol6SmxfbXiuQYdWfSPABzDXojgVUidC45uwv5U/uzHabLNtiAujNw6mNZGE/aZIoTDHNQQIQtVcbZ5a9QQdWVtXNyJVB6ppnmICjDsQ4rnA=
Received: from BN6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:405:70::13)
	by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Thu, 17 Oct 2019 16:37:18 +0000
Received: from DM3NAM05FT036.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::203) by BN6PR12CA0027.outlook.office365.com
	(2603:10b6:405:70::13) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via
	Frontend Transport; Thu, 17 Oct 2019 16:37:17 +0000
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
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:17 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:27 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:54 -0400
Message-ID: <f98285cb179418d94d5602d83845cc00d5debd83.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(199004)(189003)(29502001)(246002)(76176011)(2351001)(8676002)(6916009)(51416003)(186003)(50226002)(47776003)(70206006)(4326008)(26005)(6666004)(44832011)(107886003)(486006)(446003)(356004)(118296001)(5660300002)(126002)(476003)(2616005)(956004)(11346002)(336012)(426003)(8936002)(305945005)(7636002)(36756003)(86362001)(48376002)(14444005)(16586007)(54906003)(498600001)(2906002)(50466002)(106002)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4178;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg1.windmz.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4655fd19-80b8-4862-c555-08d753204609
X-MS-TrafficTypeDiagnostic: BY5PR12MB4178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4178A9CE0C35FB95BBB1A4638B6D0@BY5PR12MB4178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QhdQRGJ3Zc6waxtPQ3c4pmjob5sxLEg5hiNDkWi1c9utisHfARUfUfkmHjJdlJHIu30LVw0jsQpDd8Amn2kKOuUomGqAHJqd2tolEclDBgn7AOD7ONMy9094hZCrOJB40WXGktQISGA2vwH2m+VfoBdRtzZ2jFKsRcAarmqwhO45diqoatYVLVuYQnloz9XFMCe+M62DnZcUgjSJeujaCrIqWm+kuTU3cPhHijjqc7ODglhoaPfWP1znW42bSS65hHTJmTkSJobYae5eDvECvu+ZP/Hb+7Srn9i0jmx2XQZBhk0JiNEeEEkhqfjal3M6ZXtcfDUfRTGfku8iq/GYci7LbvsdTIuOU0nFCzlNTFkNXW4nq1MbIWuwvLU9S+8Ry7S/u7XMyjKUDd0JZeCFBo8JeynDULGXR4fBhj/G2Y=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:17.4017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4655fd19-80b8-4862-c555-08d753204609
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
Subject: [PATCH v2 8/9] bitbake: contrib/vim: handle shell indenting
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
 bitbake/contrib/vim/indent/bitbake.vim | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 1d0a6e8..1d99395 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -319,6 +319,18 @@ function BitbakeIndent(lnum)
         return ret
     endif
 
+    " TODO: GetShIndent doesn't detect tasks prepended with 'fakeroot'
+    " Need to submit a patch upstream to Vim to provide an extension point.
+    " Unlike the Python indenter, the Sh indenter is way too large to copy and
+    " modify here.
+    if name == "bbShFuncRegion"
+        return GetShIndent()
+    endif
+
+    " TODO:
+    "   + heuristics for de-denting out of a bbPyDefRegion? e.g. when the user
+    "       types an obvious BB keyword like addhandler or addtask, or starts
+    "       writing a shell task. Maybe too hard to implement...
+
     return -1
-    "return s:pythonIndentExpr()
 endfunction
-- 
2.7.4


