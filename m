Return-Path: <krystian.garlinski@comarch.pl>
Received: from odzwierny0.comarch.com (odzwierny0.comarch.com [217.74.69.8])
	by mail.openembedded.org (Postfix) with ESMTP id F41577BE9D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jan 2019 07:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	authenticated as krystian.garlinski@comarch.com
	by odzwierny0.comarch.com with esmtpsa (TLSv1:AES256-SHA:256)(ComArch
	ESMTP) id 1ggm75-0007cM-V5; Tue, 08 Jan 2019 08:47:52 +0100
From: =?UTF-8?q?Krystian=20Garli=C5=84ski?= <krystian.garlinski@comarch.pl>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Jan 2019 08:47:37 +0100
Message-Id: <20190108074737.15427-1-krystian.garlinski@comarch.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CA-Antivirus: Scanned by ComArch Antivirus on odzwierny0.comarch.com
X-CA-Is-Spam: No
Subject: [PATCH v2] fetch2/gitsm.py: Change the URI construction logic
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
X-List-Received-Date: Tue, 08 Jan 2019 07:47:53 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Git allows to use both the proper URI's and SCP-like short style syntax
for the SSH protocol. This commit changes construction logic to detect which
one of the two is used in the submodule specification and to build a correct
URI out of it.

Signed-off-by: Krystian Garliński <krystian.garlinski@comarch.pl>
---
 lib/bb/fetch2/gitsm.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 35729dbc..95d5f652 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -32,6 +32,7 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your r
 import os
 import bb
 import copy
+import re
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
@@ -39,6 +40,8 @@ from   bb.fetch2 import Fetch
 from   bb.fetch2 import BBFetchException
 
 class GitSM(Git):
+    scp_regex = re.compile(r'^([a-zA-Z0-9_]+)@([a-zA-Z0-9._-]+):(.+)$')
+
     def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with git.
@@ -88,8 +91,17 @@ class GitSM(Git):
             module_hash = module_hash.split()[2]
 
             # Build new SRC_URI
-            proto = uris[module].split(':', 1)[0]
-            url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
+            uri = uris[module]
+            match = GitSM.scp_regex.match(uri)
+
+            if match:
+                # this URI follows the short SCP-like syntax
+                url = 'gitsm://{}@{}/{}'.format(match.group(1), match.group(2), match.group(3))
+                proto = 'ssh'
+            else:
+                proto = uri.split(':', 1)[0]
+                url = 'gitsm' + uri[len(proto):]
+
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
             url += ";bareclone=1;nocheckout=1;nobranch=1"
-- 
2.19.1


