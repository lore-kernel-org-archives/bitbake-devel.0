Return-Path: <chris.laplante@agilent.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr790044.outbound.protection.outlook.com [40.107.79.44])
	by mail.openembedded.org (Postfix) with ESMTP id 30AB67F5B9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=cVAxHiUp9hffcqRox5O+mvrCgw7AClB0OwpBXUIM0ur+yPl9PTEhfcVuk1wXD/z1yFtY5bTTVWRUd1AScnfFQd9VPx4o9b6zoCHxI+fdSbHWzRcstvAGPW0qsfi1AuF+GckZ1mc7tW1mpqiVJ1wAh5NNNPu7giZ8aM9E8Mv8rx+20jYuax0GDhqAJfdB7ZCVgccEjFhDSTtS5y9++Xpss7AMNxAZwqeCgxWtznZ3HQWhymae53hQFRU1BkYLodaBbGHu9Y3Cqxl9lmHyJYnr603Q2J0on07uzwP2b7Q5G3wG0vVO+7GHPC1083pqhqBo41COduiJRJxB5vWNkDV0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TXE8G4x4lSSIIa/UlD75zeuzqFSVSFO/HnTLhK7v15k=;
	b=jvJx/yVj95W3r/+Pzi3GpgFe0qAeD10FN6cOfR9CzGdHQAD7bFUAQ/sLg18tBPNOTSIjyIom2GipIemELiSjLex0YM95/0Y9qg81A+mGY15Y7Vt1Pr0MSBo11jWdGb9HXXMyq7G0zSVMEsXjOhDEEmWk4t7q+m34AoEOdiPlNcwlQjk9NJmwyFzcPqdmjecHsUA40qWlIU36cWOw+RDbHwKl8vXR2dCzUc5v1eRfQHJS8FxalNz49pOEM75EXx6GeyNS6r2Ag6qhrRPCRCm0v3KZXnix7tLuUcSchXJINj3+sPUmyXxXUSznyfkxidXjmmfe3kgVn02LPzBrQjnlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TXE8G4x4lSSIIa/UlD75zeuzqFSVSFO/HnTLhK7v15k=;
	b=pEfal2sEElKg7yB6h6q8UdBYl3qE5oT27WYwy6LZia+016P4BIW0u+7hZ78VNN+rUaYJt/3xXW7Y59watCWzFPwUGK2MzianuCE+hxggUMT75mgpxopV0Eo3QxaME/YpIHHx7tZ8Wn8NrIpYA/J+BOQJOyWc1++RJ3oaYgD4IWA=
Received: from BN8PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:60::30)
	by DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:185::29) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Fri, 11 Oct 2019 16:23:34 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::204) by BN8PR12CA0017.outlook.office365.com
	(2603:10b6:408:60::30) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:34 +0000
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
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:33 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:25 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:07 -0400
Message-ID: <54e0fdde718a04a6706cea9272bc46a2361f68b3.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(29502001)(86362001)(478600001)(50226002)(2351001)(14444005)(36756003)(186003)(36906005)(8676002)(51416003)(7636002)(246002)(118296001)(305945005)(316002)(106002)(8936002)(48376002)(26005)(76176011)(6916009)(16586007)(5660300002)(446003)(11346002)(126002)(426003)(50466002)(2616005)(107886003)(44832011)(356004)(476003)(54906003)(4326008)(6666004)(336012)(2906002)(70206006)(486006)(956004)(47776003)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3225;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc7e8ac-03f0-49cd-f6bb-08d74e675cb5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32256BD9076C4C30607DD1BB8B970@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rp8VHShnar37XAnlSchl+RHBgfw4WLZ3gSnOzRN8BcMaxXC9lUtd+GSu/JM4JHUi0+pEjO2S9xl8ltKCZd4n0Z/hzG1cmN2qP30WxG42J0/RG/+PuWWsoi1JFFBZDt/VNSbUMeKSMoavBSGIGvbJCvsWwMaBnIGk2HAh2P+VKv84Tv1WXyQZEyOyUoOPuyGGCRcaln4+0Snzi8bFMwl9q3B0jLUKfMN0k65KQTEZ4nAAgvnIB2fPT23GcphZBYD+88QtNj4AGbY3WR1v5LIc1/yGSz4Er2XRZFsueXU/AbPY+JpmtARoK0GB6imZCzma8l42cSX6IXvT9f2O4PpSTZ1HsG3gaNR1ZNVZmqw3Bh3kqeljB4GN1M9YOC1LeuGQmpnBhvpsJK7AcHsZlnLECWE+5jTeCh4nRuGl38lyRQc=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:33.9130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc7e8ac-03f0-49cd-f6bb-08d74e675cb5
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
Subject: [PATCH 7/9] bitbake: contrib/vim: indenting for assignments; tweak Python indenting
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:36 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 56 ++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 782137f..ed2bd32 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -109,7 +109,12 @@ function GetPythonIndent(lnum)
             \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
             \ searchpair_stopline, searchpair_timeout)
     if p > 0
-        if s:is_python_func_def(p)
+        if s:is_bb_python_func_def(p)
+          " Handle first non-empty line inside a BB Python task
+          if p == plnum
+              return shiftwidth()
+          endif
+
           " Handle the user actually trying to close a BitBake Python task
           let line = getline(a:lnum)
           if line =~ '^\s*}'
@@ -241,6 +246,7 @@ unlet s:keepcpo
 
 
 let b:did_indent = 1
+setlocal indentkeys+=0\"
 
 
 function BitbakeIndent(lnum)
@@ -248,13 +254,57 @@ function BitbakeIndent(lnum)
         return -1
     endif
 
-    let stack = synstack(a:lnum, col("."))
+    let stack = synstack(a:lnum, 1)
     if len(stack) == 0
         return -1
     endif
 
     let name = synIDattr(stack[0], "name")
-    "echo name
+
+    " TODO: support different styles of indentation for assignments. For now,
+    " we only support like this:
+    " VAR = " \
+    "     value1 \
+    "     value2 \
+    " "
+    "
+    " i.e. each value indented by shiftwidth(), with the final quote " completely unindented.
+    if name == "bbVarValue"
+        " Quote handling is tricky. kernel.bbclass has this line for instance:
+        "     EXTRA_OEMAKE = " HOSTCC="${BUILD_CC} ${BUILD_CFLAGS} ${BUILD_LDFLAGS}" " HOSTCPP="${BUILD_CPP}""
+        " Instead of trying to handle crazy cases like that, just assume that a
+        " double-quote on a line by itself (following an assignment) means the
+        " user is closing the assignment, and de-dent.
+        if getline(a:lnum) =~ '^\s*"$'
+            return 0
+        endif
+
+        let prevstack = synstack(a:lnum - 1, 1)
+        if len(prevstack) == 0
+            return -1
+        endif
+
+        let prevname = synIDattr(prevstack[0], "name")
+
+        " Only indent if there was actually a continuation character on
+        " the previous line, to avoid misleading indentation.
+        let prevlinelastchar = synIDattr(synID(a:lnum - 1, col([a:lnum - 1, "$"]) - 1, 1), "name")
+        let prev_continued = prevlinelastchar == "bbContinue"
+
+        " Did the previous line introduce an assignment?
+        if index(["bbVarDef", "bbVarFlagDef"], prevname) != -1
+            if prev_continued
+                return shiftwidth()
+            endif
+        endif
+
+        if !prev_continued
+            return 0
+        endif
+
+        " Autoindent can take it from here
+        return -1
+    endif
 
     if index(["bbPyDefRegion", "bbPyFuncRegion"], name) != -1
         let ret = GetPythonIndent(a:lnum)
-- 
2.7.4


