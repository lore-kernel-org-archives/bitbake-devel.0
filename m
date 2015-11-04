Return-Path: <zoltan.kuscsik@linaro.org>
Received: from mail-yk0-f171.google.com (mail-yk0-f171.google.com
	[209.85.160.171])
	by mail.openembedded.org (Postfix) with ESMTP id DDB8060034
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Nov 2015 04:05:20 +0000 (UTC)
Received: by ykek133 with SMTP id k133so52740056yke.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Nov 2015 20:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linaro_org.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=FoKtU7Mfxiz//9LGyHCNhyonAhGt6Gs7ZAZZyA4AU+o=;
	b=rXx6n85feCdxjqz6EacjgIRAV3XvAFt+ot0vOPlyvI+kHsskU7nN73/xs7rCtmE/XH
	P1eVzSmykVJ1cQt2YRT/B4nOs13FkxnrCZIaHnmqsJKyoVQc41O9Wrmkjye2CQua71MY
	mQFs3PNsovu25sJHkQi3sqQaGGMv+gHyCpXwmIhDudFs7Qv9pvSzx24X1NBBTrvUz93H
	QDPupOtUnBEQ8YL0wqrG96GLzP+UkfoAq6Wt+GKkccSsRbL/yPEOWwh33HF1YhgXhVwq
	K2hnzd5hvzAMEyCowg6j5YTZofJwEOiu/EH0XImJmsiUDkcNnosRppvmfj/rM0R2IkKE
	TZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=FoKtU7Mfxiz//9LGyHCNhyonAhGt6Gs7ZAZZyA4AU+o=;
	b=H6r8QKehQHnYnwIjcNQVGanRCOc8uuL6Z5svDEf698Xkt0+xRGp7pvkSdhaNx6YtMW
	BANTyYl2rbtYjkIPOt1TxDFab10Cmlcfx5pUacPYEm0+aolwzmZe+z4VRL4sJumF569w
	QNKDzTjUdbMQNhNGClVKhc/EXU6/GpMvYPMXV9hskKL+yRwSS6DeXJTPD+8vai87quD6
	sUjdGqhvy+oEpMf4T8SlzCNGSV9Yg2JXGyNq7Kbpz+pABn+4WAkVh+uDuhfdXrYu9D0u
	wIjQ2wqmr7tmFEG9bRI2lyOHbWV/KOc7YouiZuoRQvTqDajb2knkoOiEBYOwsnVeJ6D1
	npuw==
X-Gm-Message-State: ALoCoQl0WJ7odKMNC2zo7pNmPaRXuwaGqmxh363bwocTB8SJSdOzNrqHfhLH6TwkRUL2aWXHFEt2
X-Received: by 10.31.172.22 with SMTP id v22mr3512311vke.75.1446609920553;
	Tue, 03 Nov 2015 20:05:20 -0800 (PST)
Received: from static.71.106.40.188.clients.your-server.de
	(static.71.106.40.188.clients.your-server.de. [188.40.106.71])
	by smtp.gmail.com with ESMTPSA id
	d65sm8707863vka.23.2015.11.03.20.05.18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 03 Nov 2015 20:05:19 -0800 (PST)
From: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Nov 2015 05:04:53 +0100
Message-Id: <1446609893-7391-1-git-send-email-zoltan.kuscsik@linaro.org>
X-Mailer: git-send-email 1.9.1
Subject: [PATCHv2] bb.fetch2: added support for gclient
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
X-List-Received-Date: Wed, 04 Nov 2015 04:05:22 -0000

Gclient is tool for updating source code from
multiple SCM repository locations.

Signed-off-by: Zoltan Kuscsik <zoltan.kuscsik@linaro.org>
---
 lib/bb/fetch2/__init__.py |   2 +
 lib/bb/fetch2/gclient.py  | 151 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 lib/bb/fetch2/gclient.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 288a1c8..f93446f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1775,6 +1775,7 @@ from . import hg
 from . import osc
 from . import repo
 from . import clearcase
+from . import gclient
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1791,3 +1792,4 @@ methods.append(hg.Hg())
 methods.append(osc.Osc())
 methods.append(repo.Repo())
 methods.append(clearcase.ClearCase())
+methods.append(gclient.Gclient())
diff --git a/lib/bb/fetch2/gclient.py b/lib/bb/fetch2/gclient.py
new file mode 100644
index 0000000..bc46509
--- /dev/null
+++ b/lib/bb/fetch2/gclient.py
@@ -0,0 +1,151 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+"""
+BitBake "Fetch" gclient implementation
+
+gclient fetcher support the SRC_URI in the following format:
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
+  Pass --name command line argument to gclient. Not default is empty.
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
+        Check to see if a given url can be fetched with gclient.
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
+            raise bb.fetch2.ParameterError("Conflicting revision setting SRC_URI. Specify only one of the options: 'branch', 'tag', 'res'.", ud.url)
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
+        if ud.deps_file:
+            extra_params.append("--deps-file=%s" % ud.deps_file)
+
+        if ud.project_name:
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


