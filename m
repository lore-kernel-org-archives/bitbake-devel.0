Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UJ34B-0007df-T2 for bitbake-devel@lists.openembedded.org;
	Fri, 22 Mar 2013 15:35:37 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2MES1vZ032590; Fri, 22 Mar 2013 14:28:01 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LTtHPmDwhF4k; Fri, 22 Mar 2013 14:28:01 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r2MERrSW032572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 22 Mar 2013 14:27:56 GMT
Message-ID: <1363961898.3097.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Mar 2013 14:18:18 +0000
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: "Chiang, Terence" <terence.chiang@intel.com>
Subject: [PATCH] bitbake/fetch: Add git submodules fetcher
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 22 Mar 2013 14:35:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This adds very basic git submodule support to the fetcher. It can be
used by replacing a git:// url prefix with a gitsm:// prefix, otherwise
behaviour is the same as the git fetcher. Whilst this code should be
functional, its not as efficient as the usual git fetcher due to the
need to checkout the tree to fetch/update the submodule information. git
doesn't support submodule operations on the bare clones the standard git
fetcher uses which is also problematic.

This code does however give a starting point to people wanting to use
submodules.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 4cfe089..1bf67dd 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1497,6 +1497,7 @@ class Fetch(object):
 
 from . import cvs
 from . import git
+from . import gitsm
 from . import local
 from . import svn
 from . import wget
@@ -1513,6 +1514,7 @@ methods.append(local.Local())
 methods.append(wget.Wget())
 methods.append(svn.Svn())
 methods.append(git.Git())
+methods.append(gitsm.GitSM())
 methods.append(cvs.Cvs())
 methods.append(svk.Svk())
 methods.append(ssh.SSH())
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 63ff00b..052802e 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -234,7 +234,7 @@ class Git(FetchMethod):
             def_destsuffix = "git/"
 
         destsuffix = ud.parm.get("destsuffix", def_destsuffix)
-        destdir = os.path.join(destdir, destsuffix)
+        destdir = ud.destdir = os.path.join(destdir, destsuffix)
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
new file mode 100644
index 0000000..572b637
--- /dev/null
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -0,0 +1,78 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+"""
+BitBake 'Fetch' git submodules implementation
+"""
+
+# Copyright (C) 2013 Richard Purdie
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
+from   bb    import data
+from   bb.fetch2.git import Git
+from   bb.fetch2 import runfetchcmd
+from   bb.fetch2 import logger
+
+class GitSM(Git):
+    def supports(self, url, ud, d):
+        """
+        Check to see if a given url can be fetched with git.
+        """
+        return ud.type in ['gitsm']
+
+    def uses_submodules(self, ud, d):
+        for name in ud.names:
+            try:
+                runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True)
+                return True
+            except bb.fetch.FetchError:
+                pass
+        return False
+
+    def update_submodules(self, u, ud, d):
+        # We have to convert bare -> full repo, do the submodule bit, then convert back
+        tmpclonedir = ud.clonedir + ".tmp"
+        gitdir = tmpclonedir + os.sep + ".git"
+        bb.utils.remove(tmpclonedir, True)
+        os.mkdir(tmpclonedir)
+        os.rename(ud.clonedir, gitdir)
+        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare = false/'", d)
+        os.chdir(tmpclonedir)
+        runfetchcmd("git reset --hard", d)
+        runfetchcmd("git submodule init", d)
+        runfetchcmd("git submodule update", d)
+        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d)
+        os.rename(gitdir, ud.clonedir,)
+        bb.utils.remove(tmpclonedir, True)
+
+    def download(self, loc, ud, d):
+        Git.download(self, loc, ud, d)
+
+        os.chdir(ud.clonedir)
+        submodules = self.uses_submodules(ud, d)
+        if submodules:
+            self.update_submodules(loc, ud, d)
+
+    def unpack(self, ud, destdir, d):
+        Git.unpack(self, ud, destdir, d)
+        
+        os.chdir(ud.destdir)
+        submodules = self.uses_submodules(ud, d)
+        if submodules:
+            runfetchcmd("cp -r " + ud.clonedir + "/modules " + ud.destdir + "/.git/", d)
+            runfetchcmd("git submodule init", d)
+            runfetchcmd("git submodule update", d)
+




