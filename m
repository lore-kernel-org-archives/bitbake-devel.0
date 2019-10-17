Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
	by mail.openembedded.org (Postfix) with ESMTP id 11D287F6E2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=WoXlUwDcrunEybazNDIN9+5SEWZB2pj+ox68BBE8z2QwEDo0abXmo2sRvKcwOkT3SESzwui7MPA/A4/0S0eN793mrggU9prdz0ATa/RzOZCedrJ13MmKEU7cU1Zw2CoeQhZQzqB+2bWH+1b1N+dbZNufIrB9mYdT8B22fW3vsih5JFWXnqdMrxQBuHLZTjbFEZO75/60ZeVpaL0STgHm7HBgrV+D9dzs/WV4pNntWkv3Ft/a6JHu40WlJdTAf4SAPfXq5V8vMbnSW3qytEBU9ypvTWibpnF3woTAZS2JLb5v1/Q2xKINb0Gx8aexNTk/xiKT3fzyZWE27RHos1ljPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=UQtM12tmvCxGIZAqWWRYoHmxoEsGbrNlV1ks/vnoBtw=;
	b=bG6qVi27TbHwledrPG0JAVg89kNoiTEqThjaieqLRQiYrfZi7wlQR/2V3AamnEvzmXzTuZMMfyByA4XANad7BRvkOGrT3fFt9E7jqHIj8s9psH0gLaRR4NMF0LBdrw83zrD/EyULQ3e+HVfadeydnu+IBj5es4dXOgtQq6F9+BUf11OFtB3jV5ovI7tS3Vev5g70gSrBORfQn5BujviyN/wtMsLCBJd1r3pUN0PiX08TOAoLRajtVM32sJWP/9fxMEH0RsliUe+Cwj5w8j5inesYRu8r31qfabHvbUyXlEzNp0X5WVtjzLoTqoh4YJgQmunHkWIi48q644+hyEIkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=UQtM12tmvCxGIZAqWWRYoHmxoEsGbrNlV1ks/vnoBtw=;
	b=B1ZwRfDJeN8fp/tPgMl1ZqNG4NSp8kZTehIb8YTHGNQWVXPwC1oGYToWq/tlTHApgj9z65GD5eQHopwkTdQsb9yrRSlm/Mr181LRTCzSnJwUNgkxi4ZabkAyq9DjzIIwzfpjkUz8TFEMZn1a/O2N8hxESHwlU6GWNUlcKJOQ9ww=
Received: from BN6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:405:70::18)
	by DM5PR12MB1820.namprd12.prod.outlook.com (2603:10b6:3:10d::15) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19;
	Thu, 17 Oct 2019 16:37:14 +0000
Received: from DM3NAM05FT036.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::209) by BN6PR12CA0032.outlook.office365.com
	(2603:10b6:405:70::18) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via
	Frontend Transport; Thu, 17 Oct 2019 16:37:14 +0000
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
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:13 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:24 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:50 -0400
Message-ID: <abc04876b08acb0a5191a67b4b94a16b1daeebb1.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(29502001)(189003)(199004)(107886003)(316002)(70206006)(4744005)(86362001)(2351001)(106002)(5660300002)(478600001)(4326008)(16586007)(6916009)(6666004)(356004)(54906003)(8676002)(476003)(186003)(2906002)(336012)(14444005)(246002)(426003)(48376002)(2616005)(11346002)(956004)(50226002)(126002)(26005)(446003)(8936002)(36756003)(7636002)(51416003)(47776003)(118296001)(50466002)(305945005)(44832011)(76176011)(486006)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1820;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg1.windmz.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acc1241d-393a-44e9-4af7-08d7532043fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1820:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18207F7E0E06DFB75375F0858B6D0@DM5PR12MB1820.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuftiefvQVGf6XbddxNwS9V+4KIB8sZd091gBFkjUNQMxPraJ9xVRBNoBZZOnohUfvHU5Dm4PRh6bDFO9k03xofTasWjCKfq3bih0rq9mcBHcAmEQ1zjFp6u+Zvl1hUMVZMLTthr7Sien+cplZI7rjrwWOpnOpQEmoVsDktTit1p+TnC8NoPqm9gAPpQxomYyrFhHyevlejhXnBfy7xapNWkFeOy5SG1UT3pWbfec8qrmLkJXBoaD2F1hHkPHo7lpZeic8N0tc2dThjvP5GiNaAbmtPxxaewBaO1yyAMWmSXt40tRhdVMTETKspPLAm5HvkOKY/r7oVT8sAvn6KZsANHrl2lNc/zWWQHFSLeEpyjt330X9p4nnZBU7eIKlxOfXrvmKl7g+ySXKR+NXQL6wLLEBu8RHTW3w6HkDPcj6A=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:13.9533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc1241d-393a-44e9-4af7-08d7532043fc
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1820
Subject: [PATCH v2 4/9] bitbake: contrib/vim: Special handling of bb.fatal
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
X-List-Received-Date: Thu, 17 Oct 2019 16:37:14 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 1c35cb3..d8bffe0 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -176,7 +176,7 @@ function GetPythonIndent(lnum)
   endif
 
   " If the previous line was a stop-execution statement...
-  if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
+  if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\|bb\.fatal\)\>'
     " See if the user has already dedented
     if indent(a:lnum) > indent(plnum) - shiftwidth()
       " If not, recommend one dedent
-- 
2.7.4


