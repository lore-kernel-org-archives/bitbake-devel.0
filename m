Return-Path: <krystian.garlinski@comarch.pl>
X-Greylist: delayed 1150 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 20 Dec 2018 10:42:34 UTC
Received: from odzwierny2.comarch.com (odzwierny2.comarch.com [217.74.69.10])
	by mail.openembedded.org (Postfix) with ESMTP id 85D476C494
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Dec 2018 10:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	authenticated as krystian.garlinski@comarch.com
	by odzwierny2.comarch.com with esmtpsa (TLSv1:AES256-SHA:256)(ComArch
	ESMTP) id 1gZvUC-0004t0-AE; Thu, 20 Dec 2018 11:23:24 +0100
From: =?UTF-8?q?Krystian=20Garli=C5=84ski?= <krystian.garlinski@comarch.pl>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Dec 2018 11:23:14 +0100
Message-Id: <20181220102314.24543-1-krystian.garlinski@comarch.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CA-Antivirus: Scanned by ComArch Antivirus on odzwierny2.comarch.com
X-CA-Is-Spam: No
Subject: [PATCH] fetch2/gitsm.py: Change the URI construction logic
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
X-List-Received-Date: Thu, 20 Dec 2018 10:42:34 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Git allows to use both the proper URI's and SCP-like short style syntax
for the SSH protocol. This commit changes construction logic to detect which
one of the two is used in the submodule specification and to build a correct
URI out of it.

Signed-off-by: Krystian Garliński <krystian.garlinski@comarch.pl>
---
 lib/bb/fetch2/gitsm.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 35729dbc..59828355 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -32,6 +32,9 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your r
 import os
 import bb
 import copy
+import re
+from   urllib.parse import urlparse
+from   urllib.parse import urlunparse
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
@@ -39,6 +42,8 @@ from   bb.fetch2 import Fetch
 from   bb.fetch2 import BBFetchException
 
 class GitSM(Git):
+    scp_regex = re.compile(r'^([a-zA-Z0-9_]+)@([a-zA-Z0-9._-]+):(.+)$')
+
     def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with git.
@@ -88,8 +93,18 @@ class GitSM(Git):
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
+                result = urlparse(uris[module], scheme='ssh')
+                proto = result.scheme
+                url = urlunparse(result._replace(scheme='gitsm'))
+
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
             url += ";bareclone=1;nocheckout=1;nobranch=1"
-- 
2.19.1


