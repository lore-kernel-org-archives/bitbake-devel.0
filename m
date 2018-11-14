Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 563A66C17F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 09:35:38 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wAE9ZdH2004610
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:35:39 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 14 Nov 2018 01:35:38 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Nov 2018 17:46:41 +0800
Message-ID: <756af795985c9bedd5b65ce3a4cc18f2937e2094.1542188647.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542188647.git.liezhi.yang@windriver.com>
References: <cover.1542188647.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 6/6] bitbake: BBHandler: Fix __python_func_regexp__ for comment lines
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
X-List-Received-Date: Wed, 14 Nov 2018 09:35:38 -0000
Content-Type: text/plain

Fixed:
- Add a comment in base.bbclass:
  def oe_import(d):
      import sys
  # Comment
      bbpath = d.getVar("BBPATH").split(":")
  [snip]

  Note, '# Comment' is started with '#', it is legal in python's syntax
  (though maybe not a good style), but bitbake reported errors:

  $ bitbake -p
  ERROR: ParseError at /path/to/base.bbclass:20: unparsed line: '    bbpath = d.getVar("BBPATH").split(":")'

  This error report would mislead people, the real problem is that '# Comment'
  is not supported, but it reports the next line, this may make it hard to debug
  the code are complicated.

We can make __python_func_regexp__ handle '^#' to fix the problem, since it
already can handle blank line "^$" in a python function, so it would be pretty
safe to handle "^#" as well.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/parse/parse_py/BBHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index e5039e3..01fc47e 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -45,7 +45,7 @@ __addtask_regexp__       = re.compile("addtask\s+(?P<func>\w+)\s*((before\s*(?P<
 __deltask_regexp__       = re.compile("deltask\s+(?P<func>\w+)")
 __addhandler_regexp__    = re.compile( r"addhandler\s+(.+)" )
 __def_regexp__           = re.compile( r"def\s+(\w+).*:" )
-__python_func_regexp__   = re.compile( r"(\s+.*)|(^$)" )
+__python_func_regexp__   = re.compile( r"(\s+.*)|(^$)|(^#)" )
 
 __infunc__ = []
 __inpython__ = False
-- 
2.7.4


