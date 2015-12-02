Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 9EE026FFD3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 18:00:00 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47013511pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=3VhkL0321BYIZkDMsBnFaMKOrGdbFuokT30vjBpJfFQ=;
	b=wIZ0QL7Ihj/GzYPie5pMPEhvpAvOLoQduOcEzv2TFkeiiIbRXmBdeUIVPbPZjjbhLS
	6lFFFLaRtQR96lv8LfqVLxPwnI0PD+NsMnMIdXo1xHZBkwFxiNPg5/9uhI7SrABXEGMM
	7lHsm5pP1sVs5pgpizTsIRouL7rxYZz3tvOOLW879kvIrf2Ab86KREuZb/pTFlNtkAMp
	kUbqpdPqKgBPLTYblSgYue3D3WIZYwWT/22Mw9pI7ckRYLcWnER9ZkkSY/TpbjzlQlqi
	byqucPws5fK8J80Ej4ixVDq/L5T8PmCApH6qhWMZl6c8QLB9jE8OyiPkkD4U5ArAijJF
	unag==
X-Received: by 10.98.13.156 with SMTP id 28mr6474550pfn.106.1449079201332;
	Wed, 02 Dec 2015 10:00:01 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.10.00.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 10:00:00 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:58 -0800
Message-Id: <10fdad641fca9e5af54781fbcd4bf49279c36328.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 26/30] toaster: get rid of complicated heuristics
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
X-List-Received-Date: Wed, 02 Dec 2015 18:00:01 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed buildinfohelper code which was trying to guess layer version of
the recipe using build request information. The code caused creation of
duplicated recipes as it resulted in layer version from layer index
instead of returning build layer version. As a result of this Toaster
UI was not showing any information about recipes.

Default approach used to find layer version seems to work much better as
it finds proper layer version. Now toaster will use it as the only
way to find layer version.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 47 +++++++++-----------------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 5ea9284..1d41bba 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -815,44 +815,15 @@ class BuildInfoHelper(object):
         assert path.startswith("/")
         assert 'build' in self.internal_state
 
-        if self.brbe is None:
-            def _slkey_interactive(layer_version):
-                assert isinstance(layer_version, Layer_Version)
-                return len(layer_version.local_path)
-
-            # Heuristics: we always match recipe to the deepest layer path in the discovered layers
-            for lvo in sorted(self.orm_wrapper.layer_version_objects, reverse=True, key=_slkey_interactive):
-                # we can match to the recipe file path
-                if path.startswith(lvo.local_path):
-                    return lvo
-
-        else:
-            br_id, be_id = self.brbe.split(":")
-            from bldcontrol.bbcontroller import getBuildEnvironmentController
-            bc = getBuildEnvironmentController(pk = be_id)
-
-            def _slkey_managed(layer_version):
-                return len(bc.getGitCloneDirectory(layer_version.giturl, layer_version.commit) + layer_version.dirpath)
-
-            # Heuristics: we match the path to where the layers have been checked out
-            for brl in sorted(BuildRequest.objects.get(pk = br_id).brlayer_set.all(), reverse = True, key = _slkey_managed):
-                localdirname = os.path.join(bc.getGitCloneDirectory(brl.giturl, brl.commit), brl.dirpath)
-                # we get a relative path, unless running in HEAD mode where the path is absolute
-                if not localdirname.startswith("/"):
-                    localdirname = os.path.join(bc.be.sourcedir, localdirname)
-                if path.startswith(localdirname):
-                    # If the build request came from toaster this field
-                    # should contain the information from the layer_version
-                    # That created this build request.
-                    if brl.layer_version:
-                        return brl.layer_version
-
-                    #logger.warn("-- managed: matched path %s with layer %s " % (path, localdirname))
-                    # we matched the BRLayer, but we need the layer_version that generated this br
-
-                    for lvo in self.orm_wrapper.layer_version_objects:
-                        if brl.name == lvo.layer.name:
-                            return lvo
+        def _slkey_interactive(layer_version):
+            assert isinstance(layer_version, Layer_Version)
+            return len(layer_version.local_path)
+
+        # Heuristics: we always match recipe to the deepest layer path in the discovered layers
+        for lvo in sorted(self.orm_wrapper.layer_version_objects, reverse=True, key=_slkey_interactive):
+            # we can match to the recipe file path
+            if path.startswith(lvo.local_path):
+                return lvo
 
         #if we get here, we didn't read layers correctly; dump whatever information we have on the error log
         logger.warn("Could not match layer version for recipe path %s : %s", path, self.orm_wrapper.layer_version_objects)
-- 
1.9.1


