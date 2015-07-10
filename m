Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D3649607BB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 16:42:32 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 10 Jul 2015 09:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,447,1432623600"; d="scan'208";a="603810815"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.155])
	by orsmga003.jf.intel.com with ESMTP; 10 Jul 2015 09:42:31 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jul 2015 11:44:44 -0500
Message-Id: <1436546684-30539-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] parse/ast.py: MethodNode fix character mapping error
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
X-List-Received-Date: Fri, 10 Jul 2015 16:42:38 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When found an anonymous function the func name is made by filename
and lineno, the filename need to be converted to string before using
translation because produces an error of encoding.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/parse/ast.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 1130b14..4937006 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -149,7 +149,7 @@ class MethodNode(AstNode):
     def eval(self, data):
         text = '\n'.join(self.body)
         if self.func_name == "__anonymous":
-            funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(MethodNode.tr_tbl)))
+            funcname = ("__anon_%s_%s" % (self.lineno, str(self.filename).translate(MethodNode.tr_tbl)))
             text = "def %s(d):\n" % (funcname) + text
             bb.methodpool.insert_method(funcname, text, self.filename)
             anonfuncs = data.getVar('__BBANONFUNCS', False) or []
-- 
1.9.1


