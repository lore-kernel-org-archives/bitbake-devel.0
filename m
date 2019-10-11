Return-Path: <chris.laplante@agilent.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr780080.outbound.protection.outlook.com [40.107.78.80])
	by mail.openembedded.org (Postfix) with ESMTP id F2A087F598
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=W7DGo4nqus0oS1qR+8dK9xa4vu7cr97Jjxc/vwzV+eARlSMURu3wqBA5/G+Kpj9G1fka0qYVW9lG7vfc4y1K5HCZ3GRY6DQtEwrjDA3onTgeDNStXuLB4WJCH7zIigNIPKo9okP+Ud3wuHz9kpE7siez8o+cMVz2EZoMrt6bn7rDhyFbU6/VH2w+/xJ82/f/VJ1SnkYyZj/eHZDZd+ERLaS0LKoPdYEZZ8hUtbMTHp5QgIEQadM4IuRIGGYhOcuw9JPM+G7DuKdJ4diqZfpfYYIlNn0S5gJkGIZ+8OGQNFlTUKIlC8y8pu06gZRq//cF5JJZVUYNPd3oTP1xbbmkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=N4u/K+8vkEEzcs3OGR8eBNNid7x+tTrdnJ7F3H7o5SQ=;
	b=KnyvSiCloCwZDLuXnh4Kt2spNAJZSdrwtPxdg/kwKuslNZ840coGBCHfXmjsLTfj8n3EJEXtwdnrU96ro95RIwi9GACorZn3Nu20vUw1I0275K6rqs9A1lWa6l3rxLmPLTyfrM2fPQiSNRnnmpSUa5Kiylkl3/pqeMRtAJPxJ3XMjS5TWUW6qbN6t4IXHHjvUoLg2Y8KCAHQMCKms9NTZu7dedRUurSiJFFqiS9GSWdMVZEt6BeSknU7uSD56p2efSD/qoSfMGLbdCv+yIURQqBxdttMWfOA4Zio0vO92p18eLCBgcJXl10JOeJvmnzONYP3+4Qq6hEZQV4BtgHYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=N4u/K+8vkEEzcs3OGR8eBNNid7x+tTrdnJ7F3H7o5SQ=;
	b=UTzxt0WngPFbwXMmsIH9DAPy7HnsIm60XaJ9EQeDywSfCCe67+stL3vT4e24hvNk1COs/yRqVv5Ls5kWopjrwyQ2T9IbBEiUEk3tllulp4w46iz0ukfcJ7AvKX328jvwGrDOy0LM+5seIOqCL9xslEYRM61OTm6bFm2Unkerx54=
Received: from BN8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:60::42)
	by BY5PR12MB4003.namprd12.prod.outlook.com (2603:10b6:a03:196::16)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Fri, 11 Oct 2019 16:23:28 +0000
Received: from CO1NAM05FT045.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::208) by BN8PR12CA0029.outlook.office365.com
	(2603:10b6:408:60::42) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:27 +0000
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
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:27 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:22 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:02 -0400
Message-ID: <b87bd9ba2c3183a6ccb7a277ea334ef5efa228fa.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(29502001)(199004)(189003)(36756003)(16586007)(316002)(50466002)(54906003)(44832011)(48376002)(2906002)(36906005)(446003)(956004)(11346002)(76176011)(47776003)(486006)(126002)(426003)(50226002)(476003)(2616005)(8936002)(336012)(246002)(106002)(26005)(8676002)(118296001)(186003)(7636002)(5660300002)(478600001)(51416003)(305945005)(4326008)(86362001)(70206006)(107886003)(2351001)(356004)(6666004)(6916009)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4003;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg3.windmz.agilent.com,cos.smtp.agilent.com; A:1;
	MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1217d2af-3fe7-4010-1b74-08d74e6758b7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4003DA360C3D390CDA6D01608B970@BY5PR12MB4003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LeWhu2PKfB8wrZeCkDoiux+KPh1Mj35OYqbfLwI3uALSF7xNP/kwE4QfEDResfwF4mQjHlFJG+t0c7vQCyd5iJd9IumOE9oyDDdastsgU3EibNk69AKod3yNuX87dXwugZAHR/yX75lm823iQAhdL/FJltwdmWnhAZgJV6Y4jHzhqYsS40yPPhgqr3DPCcL1fUalrRhuNiTVNQDtr3MaO6HA76wPvGppuYdGnq1VPaIXgpwv2D019FNeoMboX/ztUnTT1Cru2D598QqwjCJNc3my7RSZsuRRrfGyRWw/zycXEWE7U5ez5Wr9CbzROMEwK/S8v4L7HB9jQUOpD7wab8Emwx3BydUR0Lc7hgw3atnNfnV1ryqsSAU7mapVljpunYA2i4mdQ1yHbqV7Xv20YReFwAuH1fz1MQ9KlEog14=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:27.2106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1217d2af-3fe7-4010-1b74-08d74e6758b7
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4003
Subject: [PATCH 2/9] bitbake: contrib/vim: Modify Python indentation to work with 'python do_task {'
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:28 -0000
Content-Type: text/plain

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/bitbake.vim | 44 +++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/bitbake/contrib/vim/bitbake.vim b/bitbake/contrib/vim/bitbake.vim
index f02b21b..f81f6d6 100644
--- a/bitbake/contrib/vim/bitbake.vim
+++ b/bitbake/contrib/vim/bitbake.vim
@@ -78,8 +78,14 @@ function GetPythonIndent(lnum)
             \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
             \ searchpair_stopline, searchpair_timeout)
     if parlnum > 0
-      let plindent = indent(parlnum)
-      let plnumstart = parlnum
+      if s:is_python_func_def(parlnum)
+        let parlnum = 0
+        let plindent = indent(plnum)
+        let plnumstart = plnum
+      else
+        let plindent = indent(parlnum)
+        let plnumstart = parlnum
+      endif
     else
       let plindent = indent(plnum)
       let plnumstart = plnum
@@ -97,22 +103,26 @@ function GetPythonIndent(lnum)
             \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
             \ searchpair_stopline, searchpair_timeout)
     if p > 0
-      if p == plnum
-        " When the start is inside parenthesis, only indent one 'shiftwidth'.
-        let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
-            \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
-            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
-            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
-            \ searchpair_stopline, searchpair_timeout)
-        if pp > 0
-          return indent(plnum) + (exists("g:pyindent_nested_paren") ? eval(g:pyindent_nested_paren) : shiftwidth())
+        if s:is_python_func_def(p)
+          let p = 0
+        else
+          if p == plnum
+            " When the start is inside parenthesis, only indent one 'shiftwidth'.
+            let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
+                \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
+                \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
+                \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
+                \ searchpair_stopline, searchpair_timeout)
+            if pp > 0
+              return indent(plnum) + (exists("g:pyindent_nested_paren") ? eval(g:pyindent_nested_paren) : shiftwidth())
+            endif
+            return indent(plnum) + (exists("g:pyindent_open_paren") ? eval(g:pyindent_open_paren) : (shiftwidth() * 2))
+          endif
+          if plnumstart == p
+            return indent(plnum)
+          endif
+          return plindent
         endif
-        return indent(plnum) + (exists("g:pyindent_open_paren") ? eval(g:pyindent_open_paren) : (shiftwidth() * 2))
-      endif
-      if plnumstart == p
-        return indent(plnum)
-      endif
-      return plindent
     endif
 
   endif
-- 
2.7.4


