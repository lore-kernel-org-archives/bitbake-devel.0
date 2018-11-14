Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 828C66C3E9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 09:34:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wAE9YpGD016358
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:34:51 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 14 Nov 2018 01:34:51 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Nov 2018 17:46:36 +0800
Message-ID: <fca29bed76a86d1458885eca096fcb38312dc3ee.1542188647.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542188647.git.liezhi.yang@windriver.com>
References: <cover.1542188647.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/6] bitbake: utils: better_compile(): Fix line number when report errors
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
X-List-Received-Date: Wed, 14 Nov 2018 09:34:50 -0000
Content-Type: text/plain

Fixed:
- Add an error line in base.bbclass, e.g.:
  15
  16 def oe_import(d):
  17     import sys
  18     Compile error
  19     bbpath = d.getVar("BBPATH").split(":")
  [snip]

  Note the "Compile error" line, I added it for reporting errors.

  $ bitbake -p
  ERROR: Error in compiling python function in /buildarea1/lyang1/poky/meta/classes/base.bbclass, line 15:

  The code lines resulting in this error were:
       0014:    import oe.data
       0015:    for toimport in oe.data.typed_value("OE_IMPORTS", d):
       0016:        imported = __import__(toimport)
       0017:        inject(toimport.split(".", 1)[0], imported)
   *** 0018:
       0019:    return ""
       0020:
  SyntaxError: invalid syntax (base.bbclass, line 18)

  There are 2 problems:
  - The "line 15" is incorrect, it is a blank line, not the error line.
  - The "*** 0018" points to incorrect position.

  These two problems would mislead people a lot sometimes.

- Now fix it to:
  $ bitbake -p
  ERROR: Error in compiling python function in /buildarea1/lyang1/poky/meta/classes/base.bbclass, line 18:

  The code lines resulting in this error were:
       0001:def oe_import(d):
       0002:    import sys
   *** 0003:    Compile error
       0004:    bbpath = d.getVar("BBPATH").split(":")
                [snip]
  SyntaxError: invalid syntax (base.bbclass, line 18)

Please see comments in the code for more details on how it is fixed.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/utils.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 73b6cb4..0322ffb 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -317,10 +317,13 @@ def better_compile(text, file, realfile, mode = "exec", lineno = 0):
         error = []
         # split the text into lines again
         body = text.split('\n')
-        error.append("Error in compiling python function in %s, line %s:\n" % (realfile, lineno))
+        error.append("Error in compiling python function in %s, line %s:\n" % (realfile, e.lineno))
         if hasattr(e, "lineno"):
             error.append("The code lines resulting in this error were:")
-            error.extend(_print_trace(body, e.lineno))
+            # e.lineno: line's position in reaflile
+            # lineno: function name's "position -1" in realfile
+            # e.lineno - lineno: line's relative position in function
+            error.extend(_print_trace(body, e.lineno - lineno))
         else:
             error.append("The function causing this error was:")
             for line in body:
-- 
2.7.4


