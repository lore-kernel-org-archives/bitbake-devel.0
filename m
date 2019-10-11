Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690049.outbound.protection.outlook.com [40.107.69.49])
	by mail.openembedded.org (Postfix) with ESMTP id 575CE7F598
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=SNKGeIu5NrSDX5OeeL8cwZfTWT7WZzV7cXfDUPC4PVac08nKuE9C1xJnToBRDbrSzd0nzqIHgJghsLJNBgiAd+VUw++yFx0T5Hf32I4nGciSuHmivyRLb9J4/ZiNsep3qJSsgFQ/pnoxZkOdk6jBQbBxKG2O6JjfGZkRM9ajQqbqjAb7kvMPaQRrn6uJ575F/U1filCfKz36VvrodXL2AQb+P2sLKW7d+m+W+9tq2S70QsbrrPcdQuGr2eLWMHkAaxBgthB5rNNCWebSZxzmK9Iaic1ekKfH2UOTezWIHZXbzRx2yt60UuqyqEkClZKU/1ZYkwOb/Iamzpi7WKaxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=j61lXuKkbyGTvIIGHtZ7L48zzHtj0eVuBWVDxeXDebo=;
	b=cOzS1ZAoelN2ZF57ACUt7CzdGAW/Xx7hGaqKIeEBqJ0g/5A/xd3I3KlMkcdBA03AlIXLL1Xuk5Gq6Xb5e5sDLFoch2Ywf0PFWHNlPSlo++7d5V02fJ/yi9EveraDN4TYzOu1wuhXi160NLdykHQOX+VhHoo7mBFufShYofOXqB7E0zulXK8bjsDxsyZxoFXVAHdBmbLtiEurrTmUrnr1oTu8L/+TKXCtYUg+8aG2Jx812hK39/Ur9hni4GuYtgdL7azevBRb5sJbnHMxQPJMvy8ti0J1xEVXKaUMFmt1wm2U/CGDRKCBePEl5FuQfd3rjJYYMitgnXQFFFsD4ZLhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=j61lXuKkbyGTvIIGHtZ7L48zzHtj0eVuBWVDxeXDebo=;
	b=XknqLCX8pIh/UTb4dxwGGpwYU2mkElAkmUCPlXGwQBY2oQ+FbFNr6Nd9AB0OsQGna50uooLaICSaKbTEwyBdX9dyhUcHQSHCvoEjGOax0AG3ewB/wXC37jsUnRH9Yx/N0IoLMMSgyL03U0qcgdWoH1amWrELaqVdBnSzXKNKKqk=
Received: from BN8PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:60::30)
	by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17;
	Fri, 11 Oct 2019 16:23:29 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::204) by BN8PR12CA0017.outlook.office365.com
	(2603:10b6:408:60::30) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18 via
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
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:28 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:23 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:03 -0400
Message-ID: <3966b28262177d4f942b53f15cd2841c6dee55e2.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(29502001)(6916009)(6666004)(4326008)(70206006)(107886003)(356004)(48376002)(2351001)(47776003)(8676002)(478600001)(2906002)(8936002)(36756003)(50226002)(486006)(86362001)(2616005)(476003)(44832011)(14444005)(5660300002)(956004)(246002)(126002)(26005)(426003)(336012)(11346002)(446003)(50466002)(106002)(7636002)(305945005)(316002)(16586007)(36906005)(51416003)(76176011)(118296001)(54906003)(186003)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4207;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bea00c92-d9f4-4da3-eed4-08d74e6759a7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42079AA9BA22BE2378CA5F1F8B970@MN2PR12MB4207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSjmAgHr/endrbFH7qnwXUDDqleQ6NLwx6Zx2rLW95drtq9Aam2UST0cG9KMV+EEaBFTd5MjrMW+ODBVFH8w11czopnC0UdB9lUrZW8dCcba1FXGeJTAdUnpyj0Rd6T++9wI2vPxdKUxtys1F+z9SpcxLkQxkoRORQotJDPZSvdhnJfcvy8zPRzfa8baxIWik3EYeHa/6LQlMrBmbxSsrohRVZt2Hq2kXgboGjWAIILLiC3pwarDgmXPvjg+VFcGfAy/ZQh1Fzw0hOObIqV+2X2M/Kf2XofD79dXIaA0Udl+UkmYkOCt2H3EpBnz8e5H6cGUwOn6r1nFNBn01GgAog5zMg0j4OmI2NuPDSzDu5997TFRR+GXAD8VvpgWNq+C3yvBS/3cuuJ8pNhwaPT3vySZux6T+wE+BsUA+GmfYok=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:28.7919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea00c92-d9f4-4da3-eed4-08d74e6759a7
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
Subject: [PATCH 3/9] bitbake: contrib/vim: More Python indenting; move indent file to correct directory
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:29 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/{ => indent}/bitbake.vim | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 rename bitbake/contrib/vim/{ => indent}/bitbake.vim (91%)

diff --git a/bitbake/contrib/vim/bitbake.vim b/bitbake/contrib/vim/indent/bitbake.vim
similarity index 91%
rename from bitbake/contrib/vim/bitbake.vim
rename to bitbake/contrib/vim/indent/bitbake.vim
index f81f6d6..76968dd 100644
--- a/bitbake/contrib/vim/bitbake.vim
+++ b/bitbake/contrib/vim/indent/bitbake.vim
@@ -78,6 +78,8 @@ function GetPythonIndent(lnum)
             \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
             \ searchpair_stopline, searchpair_timeout)
     if parlnum > 0
+      " We may have found the opening brace of a BitBake Python task, e.g. 'python do_task {'
+      " If so, ignore it here - it will be handled later.
       if s:is_python_func_def(parlnum)
         let parlnum = 0
         let plindent = indent(plnum)
@@ -104,6 +106,13 @@ function GetPythonIndent(lnum)
             \ searchpair_stopline, searchpair_timeout)
     if p > 0
         if s:is_python_func_def(p)
+          " Handle the user actually trying to close a BitBake Python task
+          let line = getline(a:lnum)
+          if line =~ '^\s*}'
+              return -2
+          endif
+
+          " Otherwise ignore the brace
           let p = 0
         else
           if p == plnum
@@ -230,15 +239,27 @@ let b:did_indent = 1
 
 
 function BitbakeIndent(lnum)
+    if !has('syntax_items')
+        return -1
+    endif
+
     let stack = synstack(a:lnum, col("."))
     if len(stack) == 0
         return -1
     endif
 
     let name = synIDattr(stack[0], "name")
+    "echo name
 
     if index(["bbPyDefRegion", "bbPyFuncRegion"], name) != -1
         let ret = GetPythonIndent(a:lnum)
+        " Should always be indented by at least one shiftwidth; but allow
+        " return of -1 (defer to autoindent) or -2 (force indent to 0)
+        if ret == 0
+            return shiftwidth()
+        elseif ret == -2
+            return 0
+        endif
         return ret
     endif
 
-- 
2.7.4


