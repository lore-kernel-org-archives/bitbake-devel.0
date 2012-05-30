Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SZg9H-0005x7-Ia
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 12:29:03 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4UAIiv4012655
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 May 2012 03:18:44 -0700 (PDT)
Received: from usp-ub10.corp.ad.wrs.com (128.224.163.69) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Wed, 30 May 2012 03:18:44 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 May 2012 18:19:08 +0800
Message-ID: <f81c119d72fac8da90b4a4ccb0df56e6d858105d.1338367258.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1338367258.git.liezhi.yang@windriver.com>
References: <cover.1338367258.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] HOB: 'str' object has no attribute 'close'
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
X-List-Received-Date: Wed, 30 May 2012 10:29:04 -0000
Content-Type: text/plain

For builddetailspage.py:
  The "f" was a stream in the past, it is a string now, so it doesn't
  need f.close(), and change its name to "branch".

  And we don't need the "2>&1" since bb.process.run() can handle it, it
  will raise exception when error occurs, we should handle the exception
  ourselves if we want to ignore the error.

For hig.py:
  Use bb.process.Popen() since it doesn't need the return value. If we
  use bb.process.run(), the parent process will wait for the child process
  to terminate to get the result.

[YOCTO #2511]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    7 +++----
 bitbake/lib/bb/ui/crumbs/hig.py              |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 0741a7b..b1afe10 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -98,11 +98,10 @@ class BuildConfigurationTreeView(gtk.TreeView):
         for path in src_config_info.layers:
             import os, os.path
             if os.path.exists(path):
-                f, errors = bb.process.run('cd %s; git branch 2>&1 | grep "^* " | tr -d "* "' % path)
-                if f:
-                    branch = f.strip('\n')
+                branch = bb.process.run('cd %s; git branch | grep "^* " | tr -d "* "' % path)[0]
+                if branch:
+                    branch = branch.strip('\n')
                     vars.append(self.set_vars("Branch:", branch))
-                    f.close()
                 break
 
         self.set_config_model(vars)
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 38f890b..17b9408 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -829,7 +829,7 @@ class DeployImageDialog (CrumbsDialog):
                 cmdline = bb.ui.crumbs.utils.which_terminal()
                 if cmdline:
                     cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
-                    bb.process.run(shlex.split(cmdline))
+                    bb.process.Popen(shlex.split(cmdline))
 
     def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
-- 
1.7.1



