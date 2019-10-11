Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810054.outbound.protection.outlook.com [40.107.81.54])
	by mail.openembedded.org (Postfix) with ESMTP id BC2DC7F5B9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=fEz565wEcGIBkQTcDZt5IW14u/FORxIu8j+j8BDtogOxHR05hiLzfSqvsxN6RXzYaShY2tadI3VLbN+Ag+5fTeym5Ywwfo6Tek+8BwKq3LJY1jvmm6kk7s2TMhlgHd8KsJopyVSeQIpW/dEI3baZvC3rbbbe6JOyPWpBxCPFoERFuttQORi0qCSrNeWDO8SCKRpsHvV59t9ZS6ohQ9xFHon3HVMK+ydQmDNAoT2sEL3WrZG3pvGXKo6yuhoxdQb6WUua4mbir3SxYfisWuldbdLJtwAkiQ91DV8+gxgJXLcv5OUWAUsLBW2MHxkZCmLskDrUIg0bGvvda59Xr6f6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SYvlnYozCccrnz/VtqCCu5uWSuONvur/K9BshP+SG1Q=;
	b=cYr20uNNBIES3N5JUYVqzKqm8kbl+ku6AJZlY/NV1jV8As5LdDNmMpojyk50EFDTzmYCoqnozE+0eakY/vRwsSdKqHYSDOOi2V10JXOaaTel5nk1doRhz9aE/rkPVKQh7gURj6rQxNIRTy2N7d7L20YokwC1/jVpofWgubC+87/sMPColHUu5GmUC1r8kX+Rgx46+l8ChB9bR1AENPY+3iTR9jkRb29lxEpWX18PRWWuzjAOnFgGyiPy6h+BkH/G6ry6SGW2JEaPFLuJv4VCzE33i70EOu13ynAH7e23w/cSPMrn+t/YdUuvgQJVdWJnqiDLqZiAgGUA8Vcl58nxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SYvlnYozCccrnz/VtqCCu5uWSuONvur/K9BshP+SG1Q=;
	b=rhdJW1pJY4PS0zI7UVcvqD+dQeXLz5xdyxXDfhPIQ9O/dfyrBayLFE5ELA/TW1GczV/nM6ZzG4Ioublq70MdGbsY4l1oMhn5eCY8H6/Pzg6BjZlAp8ZYI4bN+uBa+oInqSxONpCYogLHly+4xHVS+NxbpNS3OPs8zucAnDzk8r8=
Received: from BN8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:60::42)
	by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18;
	Fri, 11 Oct 2019 16:23:32 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::208) by BN8PR12CA0029.outlook.office365.com
	(2603:10b6:408:60::42) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:32 +0000
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
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:32 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:24 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:06 -0400
Message-ID: <04412d1ae59990919a0ff1ca32583d4e103feee5.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(29502001)(6916009)(106002)(118296001)(336012)(956004)(36906005)(48376002)(2906002)(54906003)(86362001)(16586007)(2616005)(11346002)(446003)(6666004)(126002)(316002)(356004)(486006)(476003)(44832011)(426003)(2351001)(36756003)(246002)(478600001)(50466002)(7636002)(8936002)(305945005)(76176011)(5660300002)(51416003)(8676002)(186003)(70206006)(26005)(107886003)(47776003)(50226002)(4326008)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4261;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1949298-0f78-4441-2320-08d74e675ba6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4261:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4261CEFA26C4BBE93A1EC9968B970@CH2PR12MB4261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1lWKbrUzQrA9FMZMpm7mgNcVT81NEcMn9pqZBK76Eo7EE2KYjWFKg/5JGvCyTpV+xaSeoy3I0VskMs6JJW1N7haHhyoBMkcvK/fKZfvINNKTgdiZGXGQqC/RkWrPvNCj5cNSyRNrYQSMtGCQPjgQKQtd0srUcOBmx7QbIODye3QL0pvhMbbLZ6NrPg/IZPZVFW4RH0hbB/8VSgVsN931NDSQPAUHCE055zU4hNK+qyomfW/e1YO8odNlhQGaF1q0QPs0o3rCHuajSYE6rm8ZVn4Bo4XsmbJXB0W7jVhU0ZY13YISqSxtqpWvfqJJ/LQlBUXvCE3gS+YehFW3Wb0Ucgp2k4K1y7lPKRbtSEOaxWNK7NNlVnTh2xXaj346IIA4jsKmiAtAQ4pOViJaQtySD4ClIsz8RO1p/5cwY4AIOo=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:32.1346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1949298-0f78-4441-2320-08d74e675ba6
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
Subject: [PATCH 6/9] bitbake: contrib/vim: renaming & comments
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:33 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 3a0ca86..782137f 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -12,7 +12,7 @@ unlet b:did_indent
 setlocal indentexpr=BitbakeIndent(v:lnum)
 setlocal autoindent nolisp
 
-function s:is_python_func_def(lnum)
+function s:is_bb_python_func_def(lnum)
     let stack = synstack(a:lnum, 1)
     if len(stack) == 0
         return 0
@@ -84,7 +84,7 @@ function GetPythonIndent(lnum)
     if parlnum > 0
       " We may have found the opening brace of a BitBake Python task, e.g. 'python do_task {'
       " If so, ignore it here - it will be handled later.
-      if s:is_python_func_def(parlnum)
+      if s:is_bb_python_func_def(parlnum)
         let parlnum = 0
         let plindent = indent(plnum)
         let plnumstart = plnum
@@ -179,6 +179,7 @@ function GetPythonIndent(lnum)
   endif
 
   " If the previous line was a stop-execution statement...
+  " TODO: utilize this logic to deindent when ending a bbPyDefRegion
   if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\|bb\.fatal\)\>'
     " See if the user has already dedented
     if indent(a:lnum) > indent(plnum) - shiftwidth()
@@ -257,7 +258,7 @@ function BitbakeIndent(lnum)
 
     if index(["bbPyDefRegion", "bbPyFuncRegion"], name) != -1
         let ret = GetPythonIndent(a:lnum)
-        " Should always be indented by at least one shiftwidth; but allow
+        " Should normally always be indented by at least one shiftwidth; but allow
         " return of -1 (defer to autoindent) or -2 (force indent to 0)
         if ret == 0
             return shiftwidth()
-- 
2.7.4


