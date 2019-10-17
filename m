Return-Path: <chris.laplante@agilent.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr780079.outbound.protection.outlook.com [40.107.78.79])
	by mail.openembedded.org (Postfix) with ESMTP id 6905F7F6B6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=koCl9WGTjDFVM+euGsqseFqkyrMVxspyM5y9vX+J0JW7RsG2XMpp68H/ed+REgKnir9fatGTxDhBieKBRuU+i1rgna1QECxXWp6cnqfdLUC2ENEaoCc69uLFL9gG4jTiKyoebQ4T8e2HdJy069h6RVOxWoUOp7tAtqQSjBPAGxwhXm1/7Vo5lKxicDM2x6/aKkHUWLx6KqgW0gA4X3neMydjM7Ssuebjg3g/+gWrOz5sd58iGW+ZFR+Q3kQj513Xy9aDiqqwe0eB/V90PxC/ZHTM4+I2z9W+gcmIDToy10+NuMf/XjbpN5UrEqNEt+DOAne++uzNOlsxnyMFVMn+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=XSKL1dbnjUF00WWIP2jLMp6TKiJm5x3EUiGHsa7ZeVA=;
	b=cu19zJmF/MuF3/5ewPz2VHMBxp0/kGGWVI3anATUszrGZNWdPg5mss0/M6fpUB/a50H3D5TDJULzmq/a45KjYj9smlUVPugkVtI+szoU5WPYsDpcN3sq2qjRHHJoHPcQSEd9IMn3vDPVo7wuERgWNO+FHhulFXKM6cPCM6JZmjQjuQjWsEI1jqEte6gTp7n5nk2AvdJViaAWm0DhrAOBYMmZE4q3IUQOC5XxFRhqIivHvshmIxUm0Df+DmG6W2I5xULaBs5PRuDkTTfm0Wgum7ygZ+iVoIQFjzB/8R+FvHKpiS+Rj1buTLeJuGD/7DWRvvU5asYpzu7n3Sh/YbaCSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=XSKL1dbnjUF00WWIP2jLMp6TKiJm5x3EUiGHsa7ZeVA=;
	b=D65iEuyCIlMJqf3H+bPWVqs0FnxDhEIzaKlF9+BYFNe+7sTMK5hIwCfjHzvCLdp1NlxH6Z8lluG+F+zECutvFnmJEVSOuiQErLouYez4SU5drKnfsFzSBlEv8epQ4GpICBiLX2w1UWaZPWFnp+GG7xmva81NPCMILZTGbHmrKYY=
Received: from BN6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:405:70::18)
	by MN2PR12MB3245.namprd12.prod.outlook.com (2603:10b6:208:103::24)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Thu, 17 Oct 2019 16:37:16 +0000
Received: from DM3NAM05FT036.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::209) by BN6PR12CA0032.outlook.office365.com
	(2603:10b6:405:70::18) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via
	Frontend Transport; Thu, 17 Oct 2019 16:37:16 +0000
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
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:15 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:25 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:52 -0400
Message-ID: <879c0a0e303ace0c5df2e1535f6debee338b2d36.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(189003)(199004)(29502001)(86362001)(5660300002)(498600001)(36756003)(107886003)(106002)(47776003)(54906003)(70206006)(16586007)(6666004)(356004)(6916009)(4326008)(76176011)(2906002)(305945005)(186003)(118296001)(50226002)(48376002)(26005)(50466002)(126002)(336012)(476003)(956004)(2351001)(2616005)(426003)(51416003)(8936002)(8676002)(246002)(446003)(44832011)(486006)(7636002)(11346002)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3245;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg1.windmz.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91bb20de-9a0c-42ce-1bab-08d753204503
X-MS-TrafficTypeDiagnostic: MN2PR12MB3245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3245F25BB75B8FB3C7014F7A8B6D0@MN2PR12MB3245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVFlgfhkShJ0bYP+dpvMx10m/KxPDOq+bzD0jtzSH3eU2R/qtuPXUMGoZp7uYRITrqctVwzkSozG4CeWLZ0KR4TlpS9mNRDOCvLlbOyc12u0nNNP2udy9mEqtIv2vKtdt+SKa5gne2CcOJ+07dqh5DqNx8AmocByVPedvRECctutgzthP1KiLjmLsyWn044jr/cjS1OFSuBvYHi4kznjtGWs21e8ZXXZUzwS97ylJ4AFOqhVpGxAYZd/n9TduvL9OZKtZt1UKS44uWWT9V6ua2YAp5CQ+0XdtwyfxQ3Emct5cgdkyo3CxIHUn1xmF4EubF9V0zyILjOH5IrdQXeBQ8YRPfY5xRz/lP3+1P2WBHqFt2qSeW/5YZfi0tFhQav+hvB6LFO9jip7rQxYHbeusa80SUCQ1AVzLUZHbhXcNNU=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:15.6833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bb20de-9a0c-42ce-1bab-08d753204503
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3245
Subject: [PATCH v2 6/9] bitbake: contrib/vim: renaming & comments
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
X-List-Received-Date: Thu, 17 Oct 2019 16:37:16 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index fc428a2..76f84e5 100644
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
@@ -85,7 +85,7 @@ function GetPythonIndent(lnum)
     if parlnum > 0
       " We may have found the opening brace of a BitBake Python task, e.g. 'python do_task {'
       " If so, ignore it here - it will be handled later.
-      if s:is_python_func_def(parlnum)
+      if s:is_bb_python_func_def(parlnum)
         let parlnum = 0
         let plindent = indent(plnum)
         let plnumstart = plnum
@@ -180,6 +180,7 @@ function GetPythonIndent(lnum)
   endif
 
   " If the previous line was a stop-execution statement...
+  " TODO: utilize this logic to deindent when ending a bbPyDefRegion
   if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\|bb\.fatal\)\>'
     " See if the user has already dedented
     if indent(a:lnum) > indent(plnum) - shiftwidth()
@@ -258,7 +259,7 @@ function BitbakeIndent(lnum)
 
     if index(["bbPyDefRegion", "bbPyFuncRegion"], name) != -1
         let ret = GetPythonIndent(a:lnum)
-        " Should always be indented by at least one shiftwidth; but allow
+        " Should normally always be indented by at least one shiftwidth; but allow
         " return of -1 (defer to autoindent) or -2 (force indent to 0)
         if ret == 0
             return shiftwidth()
-- 
2.7.4


