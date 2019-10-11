Return-Path: <chris.laplante@agilent.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
	(mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
	by mail.openembedded.org (Postfix) with ESMTP id C8BEC7F598
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Oct 2019 16:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=XD+eD8roJmjTUi+SQ1JDn1JhnCUabVkgVTILf2/mpIyfgAduisyGtsH9UXdgcfR6uTlSqRm5R4k50Qb0q7UBoG+oqtLJNJPXc2P8Pu32eR9OqmkDwH1CW+TzjaJvxppSYj4vUczojQH7wtKM4W8FrWvCHcvbnqLHz42caglhbnF0568YIlKmjWIhbuBVfCoCvWptBgR6ipwYg+g1piSCJAMgc5GMTpGeutRs1cMUZqt1W0p7bl0am92PKKPJj1gDq8UVaypg5qp56AhwJGxQcOrqSYK0ER3+giBoVraVTP+IxE/Ark9dawkfKx9lDreIb7FKnbjfcS1eEVmdWZMPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hReAxYTTH/ixoz7/6jAACjiIcyen2T0sPGhfhgSJ2RI=;
	b=JVdegXt/6RJAZux31bpnLuUiKc7xO5SngHGt0O84hTyluRNQ4nDPO6k08RMyiZ+rcQcwcI+O4ldA4rViLhKglJFTOhosCp1KLpxnji+EahhJFxz+w3ntOPDFZlc+ane/Jyed3NgjY3ghiyEhGldT4y9zMNGnjamLB06bNL3qevXJa1QUE4cy2RC1VGAVwweXaORR8zv6LhEuVWEdBOSrgZdrbJlxEYk12TnnWHIrKtjXz3ySsQrxi8j9y82wWbtJH3JaQSrg/dMZuhp+Mk7IvzbwlkwyEONBEM8szMaiPbHnX5Cn0lgLd5SSQTNuNh4CZ1voPwUHCRvXNFXQpEhYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.34) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=hReAxYTTH/ixoz7/6jAACjiIcyen2T0sPGhfhgSJ2RI=;
	b=EGM8sElOMf6fttynGWZ8F3Rp5Y/IKSV0W3d++uAYzVfpYtMcyupmeuwpRcWQpzVBTF2wDjcRFP5vroNcJ8P2K1yQVjxRzRgf1clF3Ryz+xweYbsPQfZJmchbxllqy5IRpYdHOh4++5m377Be0FJvDKdG2ElndFKebZhZu81ydoI=
Received: from BN6PR1201CA0021.namprd12.prod.outlook.com
	(2603:10b6:405:4c::31) by DM5PR12MB1755.namprd12.prod.outlook.com
	(2603:10b6:3:107::9) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.18;
	Fri, 11 Oct 2019 16:23:22 +0000
Received: from CO1NAM05FT047.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e50::206) by BN6PR1201CA0021.outlook.office365.com
	(2603:10b6:405:4c::31) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via
	Frontend Transport; Fri, 11 Oct 2019 16:23:21 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.34)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.34 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.34; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.34) by
	CO1NAM05FT047.mail.protection.outlook.com (10.152.96.162) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2367.5 via Frontend Transport; Fri, 11 Oct 2019 16:23:21 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.34) with Microsoft SMTP Server id
	15.1.1713.5; Fri, 11 Oct 2019 10:23:19 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Oct 2019 12:23:01 -0400
Message-ID: <d14ef26853f00ec375884830e627c2c7a454cb5d.1570810590.git.chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1570810590.git.chris.laplante@agilent.com>
References: <cover.1570810590.git.chris.laplante@agilent.com>
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg3.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.34; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(979002)(346002)(396003)(376002)(136003)(39860400002)(29502001)(189003)(199004)(47776003)(2351001)(478600001)(305945005)(7636002)(6916009)(14444005)(2906002)(8676002)(356004)(246002)(6666004)(4326008)(50466002)(107886003)(106002)(118296001)(48376002)(5660300002)(8936002)(36756003)(54906003)(316002)(50226002)(16586007)(36906005)(76176011)(26005)(51416003)(126002)(476003)(2616005)(446003)(11346002)(956004)(44832011)(86362001)(186003)(426003)(336012)(486006)(70206006)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1755;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg3.windmz.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c5b69d-76c9-4ad0-9622-08d74e675543
X-MS-TrafficTypeDiagnostic: DM5PR12MB1755:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1755459A49233C739A2609DD8B970@DM5PR12MB1755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 0187F3EA14
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJAMlB7w0IWvjcJynOvfcjMPYajWhFZu/E9nywWRmyWW6AwqdpiN9QFYVtXTsTMh7ieypCQpjkkbxDZS1dG+9mn8QWdaOpATT9wLQdKbZxpiZ6gS/zvy3WoZzkqmZfk5+GPtaJZYsqOJvrSr0Y6unw/rzcxxBU4VjX6qVg6q6TUIZj7lQn6SU9mZvie+fSBmFh55v7MhtamDei42R+3kWJAPxs82YzxXQl6te7OPx0VKYhV1hjwKOeFdaGdOe2vLQsv0usRclF6v8kDdtT6ESAflzNs4DqzubFZqlrY24yS8p5wbkY+GdndhQbQbnA7HW2sqj4jiKY4SekoHW/RnI1VcjOK2iFcgYIPoGGnu1cyZPh70OlM3WXGjRGZxJ8gojl/TETYPz4ZekhK1QVc6oVM+sjtQSIdyvUxY+qH3l4Q=
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 16:23:21.3934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c5b69d-76c9-4ad0-9622-08d74e675543
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.34]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
Subject: [PATCH 1/9] bitbake: contrib/vim: initial commit, with unmodified code from indent/python.vim
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
X-List-Received-Date: Fri, 11 Oct 2019 16:23:22 -0000
Content-Type: text/plain

The intention of this commit is so that git history will clearly
show the changes I made to the Python indent code.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/contrib/vim/bitbake.vim | 237 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100644 bitbake/contrib/vim/bitbake.vim

diff --git a/bitbake/contrib/vim/bitbake.vim b/bitbake/contrib/vim/bitbake.vim
new file mode 100644
index 0000000..f02b21b
--- /dev/null
+++ b/bitbake/contrib/vim/bitbake.vim
@@ -0,0 +1,237 @@
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


