Return-Path: <chris.laplante@agilent.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr740058.outbound.protection.outlook.com [40.107.74.58])
	by mail.openembedded.org (Postfix) with ESMTP id 1E9B07F6D7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=VY8TPDJJGnIiMQmPXFsKsVX/7xIng2ySSCQV85K0nxJOM1ZfO53way6/u6dIAtrNwc7X3/XmVhGCC84qXlk62FENb32cCvHCvHjtJTDEwIgquIqW70qgdH97grB5cxS/L2Nqw0ICiwfgUZhYevEPMpMWRRTqdy7PyaFzmCG/4xbQbhjW/U5F6KdQk+cmwxrbZBV6FSCKkhjouzeHzEKJkvQk9kDPCboENBXlAozGVghpzs7/2gvWgjyacqKthsdt7gIBU4siX1FLlAPoCOA8sKgiDXcFC89nGYrYh5FcquBTUBfAc7QGKWKP0oOyybL22LDWzgSfZ5zFtBVxWjdHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=mmhgG5iT5KNDGTZporOOb8QV2W2eNP6bj+nJcQIEf8c=;
	b=Ns5COZ6T66ugowgPNy4LC7lX/G0Z8ry0csP0a0DgIFU/PDqGD6dxrXZi4p56wRERAzD2ROQMr4T0HRNUcs0lg3Jt45Bl1VxY0Wk7824eLvlmSlzuzIPiysFCb7WEBu1Yx2OQqxdfpYL2GbJE1ZToHAWp1xcdxRBmWd71JfxET+VoBPxYDuNjrjWHYvCrGPralHMr9obvQlSmg9DNte3rpUgHZwFTEDmqJJWQThoraaoM9gl1JWuIBiOSMxEkIETggEDRVe2u/m416lNl2N+FQ9J4kSBALMRqlJOcmEozEqNSHYcs3KX6sxkcV0q0QHayN99IyNG029CNV4iLHgUoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=mmhgG5iT5KNDGTZporOOb8QV2W2eNP6bj+nJcQIEf8c=;
	b=NXNufqAaJ3H8RQjI0t2ggz38tZ8Ww5jL4jzj9mNVedLVuKu+4cebWNW0F8TZJE/6spW6NXuNXWlN2vTYiTk7dwvKAsIryoXgYgtyit8ytaqRCMQ9gYQ2ROWjc1jHfItIp2vTOFc0vmKOvJnn6N8ryiQZxVfssjlEErzDExloMb8=
Received: from BN6PR12CA0028.namprd12.prod.outlook.com (2603:10b6:405:70::14)
	by BY5PR12MB3682.namprd12.prod.outlook.com (2603:10b6:a03:195::12)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Thu, 17 Oct 2019 16:37:17 +0000
Received: from DM3NAM05FT036.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::207) by BN6PR12CA0028.outlook.office365.com
	(2603:10b6:405:70::14) with Microsoft SMTP Server (version=TLS1_2,
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
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:16 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:26 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:53 -0400
Message-ID: <1246d20a022e82ab47b38b1a92e75c35d63ea754.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(199004)(189003)(29502001)(8936002)(8676002)(50226002)(7636002)(305945005)(2351001)(48376002)(47776003)(2906002)(14444005)(118296001)(2616005)(476003)(107886003)(4326008)(54906003)(11346002)(186003)(126002)(51416003)(356004)(486006)(76176011)(6666004)(316002)(26005)(478600001)(446003)(956004)(86362001)(16586007)(70206006)(50466002)(426003)(106002)(36756003)(336012)(5660300002)(44832011)(6916009)(246002)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3682;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg1.windmz.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77897a93-ac5f-47a1-4824-08d753204572
X-MS-TrafficTypeDiagnostic: BY5PR12MB3682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB368219433E9F632A867BAAA78B6D0@BY5PR12MB3682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ak19PZVI4CqB9fiK5LdH8tHuFCNzALh0JGgfbmF1oJLi4x5bDIf/YbkOxcUgEIG6IgOgk1Z3GRXN7L7aHITqdxv+YQtqNwCj/Mn7ZrQtaOTrdrZ8/hmRo+5G4LENeRpff4srRpjbqOPubWeEEY9UyIdEpo8IhnZHi5ZSLKNKVu3u2IO/RVqZmgF8SnrvIibqOjGIDOSHAqiR1osk1bYlC8O7Mmk8dPIiGp88EQY8h7PvJjQoJqaylAkiDpZKdWlB5c3ycGg7Pc/uWUnWJ7tKTcb/B14j25LrNs9KG91tD46MP3wnwshormGgKLn+uYn1QsWOqnxEGx4Ge55j4WGUSgjCxJvWDMR0/gMzz50Uzx11/VjqxidE8oRmmPH8Fq/hskPsdQErYYfO2A7Upj8ufgzhNXpeTzbvW2u1cOwM2oQ=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:16.3999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77897a93-ac5f-47a1-4824-08d753204572
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3682
Subject: [PATCH v2 7/9] bitbake: contrib/vim: indenting for assignments; tweak Python indenting
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
X-List-Received-Date: Thu, 17 Oct 2019 16:37:17 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/indent/bitbake.vim | 56 ++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
index 76f84e5..1d0a6e8 100644
--- a/bitbake/contrib/vim/indent/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -110,7 +110,12 @@ function GetPythonIndent(lnum)
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
@@ -242,6 +247,7 @@ unlet s:keepcpo
 
 
 let b:did_indent = 1
+setlocal indentkeys+=0\"
 
 
 function BitbakeIndent(lnum)
@@ -249,13 +255,57 @@ function BitbakeIndent(lnum)
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


