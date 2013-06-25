Return-Path: <Li.Wang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 409626080B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jun 2013 06:31:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r5P6VOuj021720
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jun 2013 23:31:24 -0700 (PDT)
Received: from lwang1-OptiPlex-9010.corp.ad.wrs.com (128.224.162.157) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.342.3; Mon, 24 Jun 2013 23:31:24 -0700
From: Li Wang <li.wang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Jun 2013 14:31:14 +0800
Message-ID: <1372141875-17591-1-git-send-email-li.wang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 1/2] bitbake: python funcname can not include special character @
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 25 Jun 2013 06:31:24 -0000
Content-Type: text/plain

[YOCTO #4772]

When path:file change to python function, it maybe include '@' character.
So, add the special character to change to '_' for avoid error.

Signed-off-by: Li Wang <li.wang@windriver.com>
---
 bitbake/lib/bb/parse/ast.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 6e7fd84..d4b8b09 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -147,7 +147,7 @@ class MethodNode(AstNode):
     def eval(self, data):
         text = '\n'.join(self.body)
         if self.func_name == "__anonymous":
-            funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(string.maketrans('/.+-', '____'))))
+            funcname = ("__anon_%s_%s" % (self.lineno, self.filename.translate(string.maketrans('/.+-@', '_____'))))
             text = "def %s(d):\n" % (funcname) + text
             bb.methodpool.insert_method(funcname, text, self.filename)
             anonfuncs = data.getVar('__BBANONFUNCS') or []
-- 
1.7.9.5


