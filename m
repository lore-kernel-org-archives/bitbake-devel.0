Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id D220E6C17F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 09:35:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wAE9Z2VJ015234
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:35:13 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 14 Nov 2018 01:34:52 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Nov 2018 17:46:37 +0800
Message-ID: <56c65a88041679ad0b1783a2cb1fd65e2bbbe41f.1542188647.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542188647.git.liezhi.yang@windriver.com>
References: <cover.1542188647.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/6] bitbake: parse/ast: fix line number for anonymous function
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
X-List-Received-Date: Wed, 14 Nov 2018 09:35:23 -0000
Content-Type: text/plain

Fixed:
- Define an error anonymous function in base.bbclass:
  15
  16 python() {
  17     Compile error
  18 }

  $ bitbake -p
  ERROR: Error in compiling python function in /buildarea1/lyang1/poky/meta/classes/base.bbclass, line 18:

  The code lines resulting in this error were:
       0001:def __anon_18__buildarea1_lyang1_poky_meta_classes_base_bbclass(d):
   *** 0002:    Compile error
       0003:
  SyntaxError: invalid syntax (base.bbclass, line 18)

  The lineno should be 17, but it reported 18, this would mislead people a lot
  when there more lines.

- Now fix it to:
  ERROR: Error in compiling python function in /buildarea1/lyang1/poky/meta/classes/base.bbclass, line 17:

  The code lines resulting in this error were:
       0001:def __anon_18__buildarea1_lyang1_poky_meta_classes_base_bbclass(d):
   *** 0002:    Compile error
       0003:
  SyntaxError: invalid syntax (base.bbclass, line 17)

This is because the anonymous function is constructed by:
text = "def %s(d):\n" % (funcname) + text

The len(self.body) doesn't include the "def " line, the length of the function
should be "len(self.body) + 1", so we need pass "self.lineno - (len(self.body) + 1)"
which is the same as 'self.lineno - len(self.body) - 1' to
bb.methodpool.insert_method() as we already had done to named function. Otherwise, the
lineno is wrong, and would cause other problems such as report which line is
wrong, but the line is not what we want since it reports incorrect line.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 9d20c32..6d7c80b 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -178,7 +178,7 @@ class MethodNode(AstNode):
             funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(MethodNode.tr_tbl)))
             self.python = True
             text = "def %s(d):\n" % (funcname) + text
-            bb.methodpool.insert_method(funcname, text, self.filename, self.lineno - len(self.body))
+            bb.methodpool.insert_method(funcname, text, self.filename, self.lineno - len(self.body) - 1)
             anonfuncs = data.getVar('__BBANONFUNCS', False) or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
-- 
2.7.4


