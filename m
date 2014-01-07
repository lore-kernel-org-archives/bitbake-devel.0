Return-Path: <otavio.salvador@gmail.com>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
	[209.85.216.172])
	by mail.openembedded.org (Postfix) with ESMTP id E80C56CA2A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 15:58:37 +0000 (UTC)
Received: by mail-qc0-f172.google.com with SMTP id e16so308974qcx.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Jan 2014 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id:organization;
	bh=CRR8SZX9k3fsatB4Aiw2BIfkfM9hiZUSaCklcUyC5JE=;
	b=wnskqhchxGbCblSlTFju7wJ8edl4i2OZ+UxEAr51o8C/2GuOdIAxIChNKZUnzNg3qe
	Sx8ufxAlAouglwd04SMSD2AmbaUIirGf691j3YiL2227AEbKzxeIe6Ds6DCCB5V9Be8T
	yUZR5nDw/GTFgQxTyVuzXVUTMi40K283X2JS4K1JronyhwPMITcFoGSyT0ouzNz+sfJW
	kN3pMt9cQ3/R0aeuCYRqJNtQYwxqu0YZIg35psMtHcDpfzrRCe2pyO4PGzWWDDChz+4F
	8+xC8ojXSMwu27rKQpzfyO65c+NkU9+el9ZVanQScf+SyuCJdWDUF6uqjqEOVGeYH/rp
	za2Q==
X-Received: by 10.224.66.134 with SMTP id n6mr190262524qai.39.1389110318799;
	Tue, 07 Jan 2014 07:58:38 -0800 (PST)
Received: from nano.lab.ossystems.com.br ([177.194.208.225])
	by mx.google.com with ESMTPSA id a5sm105451230qae.2.2014.01.07.07.58.36
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 Jan 2014 07:58:37 -0800 (PST)
Sender: Otavio Salvador <otavio.salvador@gmail.com>
Received: by nano.lab.ossystems.com.br (Postfix, from userid 1000)
	id 8BB0D17755555; Tue,  7 Jan 2014 13:58:34 -0200 (BRST)
From: Otavio Salvador <otavio@ossystems.com.br>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jan 2014 13:58:33 -0200
Message-Id: <1389110313-32362-1-git-send-email-otavio@ossystems.com.br>
X-Mailer: git-send-email 1.8.5.2
Organization: O.S. Systems Software LTDA.
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH] bitbake: gitannex.py: Add Git Annex support
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
X-List-Received-Date: Tue, 07 Jan 2014 15:58:38 -0000

This add a Git Annex backend which reuses the Git fetcher code; it
allows managing files with git, without checking the file contents
into git, being useful when dealing with files larger than git can
currently easily handle, whether due to limitations in memory, time,
or disk space.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
Please keep me in Cc as I am not subscribed to the mailing list

 bitbake/lib/bb/fetch2/__init__.py |  2 ++
 bitbake/lib/bb/fetch2/gitannex.py | 76 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 bitbake/lib/bb/fetch2/gitannex.py

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index b9f673c..a51e333 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1514,6 +1514,7 @@ class Fetch(object):
 from . import cvs
 from . import git
 from . import gitsm
+from . import gitannex
 from . import local
 from . import svn
 from . import wget
@@ -1531,6 +1532,7 @@ methods.append(wget.Wget())
 methods.append(svn.Svn())
 methods.append(git.Git())
 methods.append(gitsm.GitSM())
+methods.append(gitannex.GitANNEX())
 methods.append(cvs.Cvs())
 methods.append(svk.Svk())
 methods.append(ssh.SSH())
diff --git a/bitbake/lib/bb/fetch2/gitannex.py b/bitbake/lib/bb/fetch2/gitannex.py
new file mode 100644
index 0000000..02711b0
--- /dev/null
+++ b/bitbake/lib/bb/fetch2/gitannex.py
@@ -0,0 +1,76 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+"""
+BitBake 'Fetch' git annex implementation
+"""
+
+# Copyright (C) 2014 Otavio Salvador
+# Copyright (C) 2014 O.S. Systems Software LTDA.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import os
+import bb
+from   bb import data
+from   bb.fetch2.git import Git
+from   bb.fetch2 import runfetchcmd
+from   bb.fetch2 import logger
+
+class GitANNEX(Git):
+    def supports(self, url, ud, d):
+        """
+        Check to see if a given url can be fetched with git.
+        """
+        return ud.type in ['gitannex']
+
+    def uses_annex(self, ud, d):
+        for name in ud.names:
+            try:
+                runfetchcmd("%s rev-list git-annex" % (ud.basecmd), d, quiet=True)
+                return True
+            except bb.fetch.FetchError:
+                pass
+
+        return False
+
+    def update_annex(self, u, ud, d):
+        try:
+            runfetchcmd("%s annex get --all" % (ud.basecmd), d, quiet=True)
+        except bb.fetch.FetchError:
+            return False
+        runfetchcmd("chmod u+w -R %s/annex" % (ud.clonedir), d, quiet=True)
+
+        return True
+
+    def download(self, loc, ud, d):
+        Git.download(self, loc, ud, d)
+
+        os.chdir(ud.clonedir)
+        annex = self.uses_annex(ud, d)
+        if annex:
+            self.update_annex(loc, ud, d)
+
+    def unpack(self, ud, destdir, d):
+        Git.unpack(self, ud, destdir, d)
+
+        os.chdir(ud.destdir)
+        try:
+            runfetchcmd("%s annex sync" % (ud.basecmd), d)
+        except bb.fetch.FetchError:
+            pass
+
+        annex = self.uses_annex(ud, d)
+        if annex:
+            runfetchcmd("%s annex get" % (ud.basecmd), d)
+            runfetchcmd("chmod u+w -R %s/.git/annex" % (ud.destdir), d, quiet=True)
-- 
1.8.5.2


