Return-Path: <zoltan.kuscsik@linaro.org>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
	[209.85.220.179])
	by mail.openembedded.org (Postfix) with ESMTP id C474176104
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 16:14:45 +0000 (UTC)
Received: by qkcn129 with SMTP id n129so8537384qkc.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Nov 2015 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linaro_org.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=gitz/A4AXSikm4V5/8G3uZUI1S8Bukv8Dio35fS6K/Q=;
	b=xAwGIWCPG9EVfXhAawmEC8QQMw/bV27lhbev27tCsuulRJfPaC506pQmFXF7WmXuNc
	6Wuh0Uc28h0w741fHGHuVtXZQ++2Bkt7MxFZHVLlFQ+xXVCHroheRbc7/VVMmRu/Ccow
	tAJdtx28O1dO0kFqVyr64jKDNG8zfYP26MgeV2IBS0r5aGAGHQmDMqcXWCmzEfW+5RpS
	JJVay2tvDG6Ew3kwdFgxafkg/y6yHbjGPL63sRdidZYfvb+4rp4MMhobr3hLIjyZg4vw
	hJ8YEeB+pVVPZGblBkv4DfONadI5KnsX/iJYyF7IunSBmtkfMGOJHOj/a+bv/BM48Y8g
	9FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=gitz/A4AXSikm4V5/8G3uZUI1S8Bukv8Dio35fS6K/Q=;
	b=V+OaVydyfeVCab0GrHrKNzMjsf+vCOD8AHU3+kwVV+4CQRFapEi9Lii0tszxrZ4k9u
	+baZsgM2qtqzR+Ix2H1G6/VoA2Vki/z5a3U0TYn/tHd3HUE4bliN6LIObZLSKXIrNhhz
	pF1bV7JMIL0vkBfRkVaMlNCfntXzHQDpuFjfBE84n7v4KWgfVkVtYp80YGPZJ/t+x4P3
	7ThIJKjAHSeHhDMb6/q+zKHu1xRfn1ajeNaPIykrG6RqdqEf1jtE20sCzT+lP8u1dWUa
	sFb0B+obnSVwxpXTx+ykmepYcnzlSkE1zLuYkvUbbs1Ovvgpg1ShfvjvN0fHAqPGOCor
	cMLA==
X-Gm-Message-State: ALoCoQkL6p6z1wjc8mlP4uHZQ/UwXGaA1R4m6OhsyT5D2vIuEhRnam6pknQ8lJcaFUbV4o1ql5nW
X-Received: by 10.55.18.40 with SMTP id c40mr36938473qkh.99.1446567285035;
	Tue, 03 Nov 2015 08:14:45 -0800 (PST)
Received: from static.71.106.40.188.clients.your-server.de
	(static.71.106.40.188.clients.your-server.de. [188.40.106.71])
	by smtp.gmail.com with ESMTPSA id
	o77sm4533269qgd.15.2015.11.03.08.14.43
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 03 Nov 2015 08:14:44 -0800 (PST)
From: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Nov 2015 17:14:34 +0100
Message-Id: <1446567274-32344-1-git-send-email-zoltan.kuscsik@linaro.org>
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
X-List-Received-Date: Tue, 03 Nov 2015 16:14:45 -0000

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


