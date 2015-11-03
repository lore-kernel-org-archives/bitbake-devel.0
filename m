Return-Path: <zoltan.kuscsik@static.71.106.40.188.clients.your-server.de>
X-Greylist: delayed 415 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 03 Nov 2015 16:17:47 UTC
Received: from static.71.106.40.188.clients.your-server.de
	(static.71.106.40.188.clients.your-server.de [188.40.106.71])
	by mail.openembedded.org (Postfix) with ESMTP id 9F91C763F2
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 16:17:47 +0000 (UTC)
Received: by static.71.106.40.188.clients.your-server.de (Postfix,
	from userid 1002)
	id C4EAA6E08140; Tue,  3 Nov 2015 17:10:51 +0100 (CET)
From: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Nov 2015 17:10:45 +0100
Message-Id: <1446567045-31179-1-git-send-email-zoltan.kuscsik@linaro.org>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] bb.fetch2: added support for gclient
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
X-List-Received-Date: Tue, 03 Nov 2015 16:17:48 -0000

Gclient is tool for updating source code from
multiple SCM repository locations.

Signed-off-by: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
---
 lib/bb/fetch2/__init__.py |   3 +-
 lib/bb/fetch2/gclient.py  | 151 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/fetch2/gclient.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 288a1c8..5ca3bc7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1529,7 +1529,6 @@ class Fetch(object):
         fn = d.getVar('FILE', True)
         if cache and fn and fn in urldata_cache:
             self.ud = urldata_cache[fn]
-
         for url in urls:
             if url not in self.ud:
                 try:
@@ -1775,6 +1774,7 @@ from . import hg
 from . import osc
 from . import repo
 from . import clearcase
+from . import gclient
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1791,3 +1791,4 @@ methods.append(hg.Hg())
 methods.append(osc.Osc())
 methods.append(repo.Repo())
 methods.append(clearcase.ClearCase())
+methods.append(gclient.Gclient())
diff --git a/lib/bb/fetch2/gclient.py b/lib/bb/fetch2/gclient.py
new file mode 100644
index 0000000..de06eb5
--- /dev/null
+++ b/lib/bb/fetch2/gclient.py
@@ -0,0 +1,151 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+"""
+BitBake "Fetch" gclient implementation
+
+gclient fetcher support the SRCU_URI in the following format:
+
+    SRC_URI = "gclient://some.host/path/;optionA=xxx,optionB=xy"
+
+Supported SRC_UIR options are:
+
+- branch
+  The git branch of the root gclient project. The default is
+  "master".
+
+- tag
+  Git tag for gclient to retrieve.
+
+- protocol
+  The method to use for accessing the gclient core project. The default
+   is https.
+
+- project-name
+  Passing the --name command line argument to gclient. Not default is empty.
+
+- rev
+  Specify git commit id for gclient. Default is empty.
+
+- deps-file
+  Set the --deps-file command line argument for gclient.
+
+"""
+
+# Copyright (C) 2015 Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
+#
+# Based on git.py which is:
+# Copyright (C) 2005 Richard Purdie
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
+from   bb.fetch2 import FetchMethod
+from   bb.fetch2 import runfetchcmd
+import string
+
+class Gclient(FetchMethod):
+    """Class to fetch a module or modules using gclient"""
+
+    def __fetch_url(self, ud):
+        return "%s://%s%s" % (ud.proto, ud.host, ud.path)
+
+    def supports(self, ud, d):
+        """
+        Check to see if a given url can be fetched with repo.
+        """
+        return ud.type in ["gclient"]
+
+    def urldata_init(self, ud, d):
+        """
+        Init gclient
+        """
+        ud.proto = ud.parm.get('protocol', 'https')
+
+        ud.branch = ud.parm.get('branch', 'master')
+        ud.tag = ud.parm.get('tag','')
+        ud.rev = ud.parm.get('rev','')
+        
+        ud.deps_file = ud.parm.get('deps-file', '')
+        ud.project_name = ud.parm.get('project-name', '')
+
+        if( ( ('tag' in ud.parm) + ('branch' in ud.parm) + ('res' in ud.parm)) > 1):
+            raise bb.fetch2.ParameterError("Confliting revision setting SRC_URI. Setting only one of the options: 'branch', 'tag', 'res'.", ud.url)
+
+        dldir = d.getVar("DL_DIR", True) 
+    
+        gclient_src_name = 'gclient_%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
+
+        ud.syncdir = os.path.join(dldir, gclient_src_name)
+        ud.localfile = ud.syncdir
+
+        if ud.tag:
+            ud.revision =  "refs/tags/%s" % ud.tag
+        elif ud.rev:
+            ud.revision = ud.rev
+        else:
+            ud.revision = "refs/heads/%s" % ud.branch
+
+    def download(self, ud, d):
+        """Fetch url"""
+
+        if not os.path.exists(ud.localpath):
+            bb.utils.mkdirhier(ud.localpath)
+        os.chdir(ud.localpath)
+        gclient_url = self.__fetch_url(ud)
+
+
+        # Add optional parameters
+        extra_params=[]
+        if(ud.deps_file):
+            extra_params.append("--deps-file=%s" % ud.deps_file)
+
+        if(ud.project_name):
+            extra_params.append("--name=%s" % ud.project_name)
+
+        extra_args = string.join(extra_params, sep = " ")
+
+        runfetchcmd("gclient config %s %s " % (gclient_url, extra_args), d)
+
+        # Gclient parameters used
+        # -f                    - force sync
+        # -nohooks              - skip hooks execution at this time
+        # --with_branch_heads   - gclient can't find a commit ID if it is not in a branch
+        #
+        # Note: We should enable --no-history after some more testing 
+
+        runfetchcmd("gclient sync --with_branch_heads -f  --nohooks --revision %s" % ud.revision, d)
+
+    def unpack(self, ud, destdir, d):
+        """ Unpack the src to destdir """
+        destsuffix = "gclient/"
+        destdir = ud.destdir = os.path.join(destdir, destsuffix)
+        # Use rsync for copying. Creating a tar package here would be very
+        # time consuming.
+        runfetchcmd("rsync -av %s/ %s/" %(ud.syncdir, destdir), d)
+        return True
+
+    def need_update(self, ud, d):
+        return True
+
+    def clean(self, ud, d):
+        """ Clean the gclient directory """
+        bb.utils.remove(ud.localpath, True)
+
+    def localpath(self, ud, dr):
+        return ud.syncdir
+
+    def supports_srcrev(self):
+        return False
-- 
1.9.1


