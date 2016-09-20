Return-Path: <brian.avery@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B20F573186
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2016 01:42:55 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP; 19 Sep 2016 18:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,365,1470726000"; d="scan'208";a="11555886"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga004.jf.intel.com with ESMTP; 19 Sep 2016 18:42:56 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Sep 2016 18:44:20 -0700
Message-Id: <fc0d7c4b56391b0a2cae5fdaf0fd995d878769d5.1474335720.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1474335720.git.brian.avery@intel.com>
References: <cover.1474335720.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 1/1] toaster: buildinfohelper local layer don't construct path using git info
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
X-List-Received-Date: Tue, 20 Sep 2016 01:42:55 -0000

From: Michael Wood <michael.g.wood@intel.com>

When the layer is local source don't try and work out the location of
the layer by using the git information (getGitCloneDirectory)

[YOCTO #10199]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 2246960..b2c74dd 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -451,7 +451,11 @@ class ORMWrapper(object):
             # note that this is different
             buildrequest = BuildRequest.objects.get(pk = br_id)
             for brl in buildrequest.brlayer_set.all():
-                localdirname = os.path.join(bc.getGitCloneDirectory(brl.giturl, brl.commit), brl.dirpath)
+                if brl.local_source_dir:
+                    localdirname = os.path.join(brl.local_source_dir,
+                                                brl.dirpath)
+                else:
+                    localdirname = os.path.join(bc.getGitCloneDirectory(brl.giturl, brl.commit), brl.dirpath)
                 # we get a relative path, unless running in HEAD mode where the path is absolute
                 if not localdirname.startswith("/"):
                     localdirname = os.path.join(bc.be.sourcedir, localdirname)
@@ -981,8 +985,6 @@ class BuildInfoHelper(object):
     def _get_layer_version_for_path(self, path):
         self._ensure_build()
 
-        assert path.startswith("/")
-
         def _slkey_interactive(layer_version):
             assert isinstance(layer_version, Layer_Version)
             return len(layer_version.local_path)
-- 
1.9.1


