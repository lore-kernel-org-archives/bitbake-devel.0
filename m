Return-Path: <pascal.bach@siemens.com>
X-Greylist: delayed 591 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 29 Jan 2015 09:02:06 UTC
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by mail.openembedded.org (Postfix) with ESMTP id E366F60024
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 09:02:05 +0000 (UTC)
Received: from mail3.siemens.de (localhost [127.0.0.1])
	by thoth.sbs.de (8.14.3/8.14.3) with ESMTP id t0T8qA2h013634
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 09:52:10 +0100
Received: from localhost.localdomain (MD159NTC.ww002.siemens.net
	[139.16.79.114])
	by mail3.siemens.de (8.14.3/8.14.3) with ESMTP id t0T8qAVf016759;
	Thu, 29 Jan 2015 09:52:10 +0100
From: Pascal Bach <pascal.bach@siemens.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Jan 2015 09:52:04 +0100
Message-Id: <1422521524-30172-1-git-send-email-pascal.bach@siemens.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH 1/2] bitbake: Fix issue if path contains '&'
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
X-List-Received-Date: Thu, 29 Jan 2015 09:02:12 -0000

Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 bitbake/lib/bb/parse/ast.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 4e5a06e..22c71e9 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -139,7 +139,7 @@ class DataNode(AstNode):
             data.setVar(key, val, **loginfo)
 
 class MethodNode(AstNode):
-    tr_tbl = string.maketrans('/.+-@%', '______')
+    tr_tbl = string.maketrans('/.+-@%&', '_______')
 
     def __init__(self, filename, lineno, func_name, body):
         AstNode.__init__(self, filename, lineno)
-- 
1.7.10.4


