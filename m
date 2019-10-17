Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-eopbgr760050.outbound.protection.outlook.com [40.107.76.50])
	by mail.openembedded.org (Postfix) with ESMTP id 968387F523
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2019 16:37:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=m06bb/y8kOFPKA0ttnwmr4oHwyjZIYuFXmwHkyX+x9+eGdzt+WVCL/TqoKa19Rm/PzciwfoN/NYQTOq7meRfY12W70rH1EhO6bXCVxu4byna2awntbQkd7CLlXQMAqsM1xWFUVpQ2ubyZG0UO8p7NA/TVEtdyFcr8bQVhZnZWwZJMARSuOtQmbjtJOMHd8oZEhtCZ2P5lt2vccQcjalNKGs1TFpXjn3mm0w3G7R4bgyx7z34crYLmK+SPYvH40qNm21adhCePSBIRMk/P5sMEyIbjugY0Gd+KgsnOjU6pyrC2mAnYOO4d2i1ranbNGASwRut1+7X7q3J9oNRhd6G7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pBF4AdGBX7XnXKbczHbn3YJfXm/Gx4tl+NBr5sBj+vc=;
	b=bnpgkwR6EWQxpsnhG0UMw4oncYFqjGtqekjiTku8pgZ052vfzm5WdFZzgmdhyw/6cd4xzS+w1+lIT0UslyDQPXJ+Pm8+u2P/aoqYd5GV2vXo9MfEhlUFkZNYzUCoiWA/FaJH7/ZpIItitBi99JK9xmhH/nBhpHqGUE4KCK0qCePyDKpdU8xgWembXO4D0cGNL/dbTP0q4e3xWkfRNlAIESHUCxXky2CEUGAbgcB/L6VuB5tfQeeIc8jCP51Ni2oxNJKyHVT3pT7peQBM2JxRP8sOmqIQi8olPbxdQFa6jKb545mnQ49Dxk5iLXz+HefnfhIcC5WiWQjrimfQYXoCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pBF4AdGBX7XnXKbczHbn3YJfXm/Gx4tl+NBr5sBj+vc=;
	b=qvKz+/thi9hGu0Fdq/E8kT+uWqXaOJEjgtL+Rn6r0z2y45gdH4QTIHRyd8EqsXWf5vDWwL6fIrQrEjKPM9uypg6K5IZdzwiAgy8mWq6obgNYIXlnM7BmR0IAeG5wU63f18VlULMR9OxmXmoZD3MAOxjXAf5qlowBFuZdY+zEldQ=
Received: from BN6PR1201CA0011.namprd12.prod.outlook.com
	(2603:10b6:405:4c::21) by BL0PR12MB2449.namprd12.prod.outlook.com
	(2603:10b6:207:40::10) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Thu, 17 Oct 2019 16:37:09 +0000
Received: from DM3NAM05FT021.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::204) by BN6PR1201CA0011.outlook.office365.com
	(2603:10b6:405:4c::21) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via
	Frontend Transport; Thu, 17 Oct 2019 16:37:09 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.37)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.37 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
	DM3NAM05FT021.mail.protection.outlook.com (10.152.98.130) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.2367.5 via Frontend Transport; Thu, 17 Oct 2019 16:37:08 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 17 Oct 2019 10:36:22 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 17 Oct 2019 12:36:47 -0400
Message-ID: <17ce7bb75ef9f946bf51b28ef4dc9c90b46643a2.1571329975.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1571329975.git.chris.laplante@agilent.com>
References: <cover.1571329975.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(189003)(29502001)(199004)(8676002)(106002)(246002)(316002)(76176011)(51416003)(50466002)(16586007)(47776003)(54906003)(118296001)(86362001)(107886003)(8936002)(50226002)(6916009)(26005)(186003)(126002)(356004)(14444005)(36756003)(476003)(6666004)(2616005)(336012)(5660300002)(2906002)(446003)(44832011)(70206006)(7636002)(2351001)(305945005)(4326008)(486006)(11346002)(956004)(426003)(478600001)(48376002)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2449;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:wpcosapexchedg1.windmz.agilent.com,cos.smtp.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95d2b08-45cd-46a8-7170-08d753204104
X-MS-TrafficTypeDiagnostic: BL0PR12MB2449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2449AA78F3CE510DD8385B278B6D0@BL0PR12MB2449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PyepmlvYoWYCKVVmtDRchjjVOlSe/XluPq5DcQL+MJTnRSBoaEQ9YBYpXkJUS5wdHeOVRSIJ8ANcc+bTY1nuRDyLJ01IC5BFuDW3sk2zI5zzBF2R91cK0yvoELW+oBYF0s6bmjtoSeBafrqUw0yU2Ww86f7D0uQ9rBmMmZ7Vr29U/2qY5uWrse85DMiY1ScWbi0uzoH6KUL2FLPrv2lOlHMA3iFrjQbprq6BzHuyWBdOJfWR/eVqBsu/NYwSAPrcWV1PmLrXISdmaZdp1sQOc5mxM6dHw22opSoZNOTfXwSicCDf5TUTH2e2lafrU4IY+HcAsfOpxPo0ieh/QlnxthWOS4aV8Samr9SC7GxXJrhzk6oN/A8A5NUXSdPjQO3ufC9NBcy8E6gmPup9hk4OE2vVFSrng8XMue11PFCx/Y=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 16:37:08.9832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95d2b08-45cd-46a8-7170-08d753204104
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2449
Subject: [PATCH v2 1/9] bitbake: contrib/vim: initial commit, with unmodified code from indent/python.vim
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
X-List-Received-Date: Thu, 17 Oct 2019 16:37:09 -0000
Content-Type: text/plain

The intention of this commit is so that git history will clearly
show the changes made to the Python indent code.

Taken from Vim commit 7a9bd7c1e0ce1baf5a02daf36eeae3638aa315c7

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/bitbake.vim | 238 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)
 create mode 100644 bitbake/contrib/vim/bitbake.vim

diff --git a/bitbake/contrib/vim/bitbake.vim b/bitbake/contrib/vim/bitbake.vim
new file mode 100644
index 0000000..a210cf5
--- /dev/null
+++ b/bitbake/contrib/vim/bitbake.vim
@@ -0,0 +1,238 @@
+if exists("b:did_indent")
+    finish
+endif
+
+runtime! indent/sh.vim
+unlet b:did_indent
+
+setlocal indentexpr=BitbakeIndent(v:lnum)
+setlocal autoindent nolisp
+
+function s:is_python_func_def(lnum)
+    let stack = synstack(a:lnum, 1)
+    if len(stack) == 0
+        return 0
+    endif
+
+    let top = synIDattr(stack[0], "name")
+    echo top
+
+    return synIDattr(stack[0], "name") == "bbPyFuncDef"
+endfunction
+
+"""" begin modified from indent/python.vim, upstream commit 7a9bd7c1e0ce1baf5a02daf36eeae3638aa315c7
+"""" This copied code is licensed the same as Vim itself.
+setlocal indentkeys+=<:>,=elif,=except
+
+let s:keepcpo= &cpo
+set cpo&vim
+
+let s:maxoff = 50	" maximum number of lines to look backwards for ()
+
+function GetPythonIndent(lnum)
+
+  " If this line is explicitly joined: If the previous line was also joined,
+  " line it up with that one, otherwise add two 'shiftwidth'
+  if getline(a:lnum - 1) =~ '\\$'
+    if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
+      return indent(a:lnum - 1)
+    endif
+    return indent(a:lnum - 1) + (exists("g:pyindent_continue") ? eval(g:pyindent_continue) : (shiftwidth() * 2))
+  endif
+
+  " If the start of the line is in a string don't change the indent.
+  if has('syntax_items')
+	\ && synIDattr(synID(a:lnum, 1, 1), "name") =~ "String$"
+    return -1
+  endif
+
+  " Search backwards for the previous non-empty line.
+  let plnum = prevnonblank(v:lnum - 1)
+
+  if plnum == 0
+    " This is the first non-empty line, use zero indent.
+    return 0
+  endif
+
+  call cursor(plnum, 1)
+
+  " Identing inside parentheses can be very slow, regardless of the searchpair()
+  " timeout, so let the user disable this feature if he doesn't need it
+  let disable_parentheses_indenting = get(g:, "pyindent_disable_parentheses_indenting", 0)
+
+  if disable_parentheses_indenting == 1
+    let plindent = indent(plnum)
+    let plnumstart = plnum
+  else
+    " searchpair() can be slow sometimes, limit the time to 150 msec or what is
+    " put in g:pyindent_searchpair_timeout
+    let searchpair_stopline = 0
+    let searchpair_timeout = get(g:, 'pyindent_searchpair_timeout', 150)
+
+    " If the previous line is inside parenthesis, use the indent of the starting
+    " line.
+    " Trick: use the non-existing "dummy" variable to break out of the loop when
+    " going too far back.
+    let parlnum = searchpair('(\|{\|\[', '', ')\|}\|\]', 'nbW',
+            \ "line('.') < " . (plnum - s:maxoff) . " ? dummy :"
+            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
+            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
+            \ searchpair_stopline, searchpair_timeout)
+    if parlnum > 0
+      let plindent = indent(parlnum)
+      let plnumstart = parlnum
+    else
+      let plindent = indent(plnum)
+      let plnumstart = plnum
+    endif
+
+    " When inside parenthesis: If at the first line below the parenthesis add
+    " two 'shiftwidth', otherwise same as previous line.
+    " i = (a
+    "       + b
+    "       + c)
+    call cursor(a:lnum, 1)
+    let p = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
+            \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
+            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
+            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
+            \ searchpair_stopline, searchpair_timeout)
+    if p > 0
+      if p == plnum
+        " When the start is inside parenthesis, only indent one 'shiftwidth'.
+        let pp = searchpair('(\|{\|\[', '', ')\|}\|\]', 'bW',
+            \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
+            \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
+            \ . " =~ '\\(Comment\\|Todo\\|String\\)$'",
+            \ searchpair_stopline, searchpair_timeout)
+        if pp > 0
+          return indent(plnum) + (exists("g:pyindent_nested_paren") ? eval(g:pyindent_nested_paren) : shiftwidth())
+        endif
+        return indent(plnum) + (exists("g:pyindent_open_paren") ? eval(g:pyindent_open_paren) : (shiftwidth() * 2))
+      endif
+      if plnumstart == p
+        return indent(plnum)
+      endif
+      return plindent
+    endif
+
+  endif
+
+
+  " Get the line and remove a trailing comment.
+  " Use syntax highlighting attributes when possible.
+  let pline = getline(plnum)
+  let pline_len = strlen(pline)
+  if has('syntax_items')
+    " If the last character in the line is a comment, do a binary search for
+    " the start of the comment.  synID() is slow, a linear search would take
+    " too long on a long line.
+    if synIDattr(synID(plnum, pline_len, 1), "name") =~ "\\(Comment\\|Todo\\)$"
+      let min = 1
+      let max = pline_len
+      while min < max
+	let col = (min + max) / 2
+	if synIDattr(synID(plnum, col, 1), "name") =~ "\\(Comment\\|Todo\\)$"
+	  let max = col
+	else
+	  let min = col + 1
+	endif
+      endwhile
+      let pline = strpart(pline, 0, min - 1)
+    endif
+  else
+    let col = 0
+    while col < pline_len
+      if pline[col] == '#'
+	let pline = strpart(pline, 0, col)
+	break
+      endif
+      let col = col + 1
+    endwhile
+  endif
+
+  " If the previous line ended with a colon, indent this line
+  if pline =~ ':\s*$'
+    return plindent + shiftwidth()
+  endif
+
+  " If the previous line was a stop-execution statement...
+  if getline(plnum) =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
+    " See if the user has already dedented
+    if indent(a:lnum) > indent(plnum) - shiftwidth()
+      " If not, recommend one dedent
+      return indent(plnum) - shiftwidth()
+    endif
+    " Otherwise, trust the user
+    return -1
+  endif
+
+  " If the current line begins with a keyword that lines up with "try"
+  if getline(a:lnum) =~ '^\s*\(except\|finally\)\>'
+    let lnum = a:lnum - 1
+    while lnum >= 1
+      if getline(lnum) =~ '^\s*\(try\|except\)\>'
+	let ind = indent(lnum)
+	if ind >= indent(a:lnum)
+	  return -1	" indent is already less than this
+	endif
+	return ind	" line up with previous try or except
+      endif
+      let lnum = lnum - 1
+    endwhile
+    return -1		" no matching "try"!
+  endif
+
+  " If the current line begins with a header keyword, dedent
+  if getline(a:lnum) =~ '^\s*\(elif\|else\)\>'
+
+    " Unless the previous line was a one-liner
+    if getline(plnumstart) =~ '^\s*\(for\|if\|try\)\>'
+      return plindent
+    endif
+
+    " Or the user has already dedented
+    if indent(a:lnum) <= plindent - shiftwidth()
+      return -1
+    endif
+
+    return plindent - shiftwidth()
+  endif
+
+  " When after a () construct we probably want to go back to the start line.
+  " a = (b
+  "       + c)
+  " here
+  if parlnum > 0
+    return plindent
+  endif
+
+  return -1
+
+endfunction
+
+let &cpo = s:keepcpo
+unlet s:keepcpo
+
+""" end of stuff from indent/python.vim
+
+
+let b:did_indent = 1
+
+
+function BitbakeIndent(lnum)
+    let stack = synstack(a:lnum, col("."))
+    if len(stack) == 0
+        return -1
+    endif
+
+    let name = synIDattr(stack[0], "name")
+
+    if index(["bbPyDefRegion", "bbPyFuncRegion"], name) != -1
+        let ret = GetPythonIndent(a:lnum)
+        return ret
+    endif
+
+    return -1
+    "return s:pythonIndentExpr()
+endfunction
-- 
2.7.4


