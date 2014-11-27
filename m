Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id D2FB0723AD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:11 +0000 (UTC)
Received: by mail-wg0-f50.google.com with SMTP id k14so6960700wgh.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=U2PG0yFsOkSmgKyQYH/2PscLbpX9AaOp7SDtLzOAeXc=;
	b=P9uEX1s/tRTktJIuO1JYFBqNgmmm3/KpH/JWl4odjXd57QBV5y5TT+jzlHBsVR3KTm
	3X7mtTUSpmgkIZME46nX61OBsGa3War8ImVf2V4o7JLfQ4MH/J37N6W2ouJI3azL7Bhp
	aM8cZjg+Jcii9ir1EpqOUqD0sC+h6Dy3ts1pJJBCtGxwoI0VkTQAxLbdAYMFymSQuuZz
	7Sisq7R+vMcAnWGCaCKuT/Mec9SQXJ7/wVjBP1/PsHbr1yxZIoLueZH1OJmqn6mP4bGs
	/HZDKB3mK5I6MIeEdPF+bNBzfV3EGMHBvHW9FcEujJEGsbghrLLtIMZAdzCKb9QNLKpJ
	xo+w==
X-Gm-Message-State: ALoCoQkP6woo9xepAwKQemRLCHSVlEaSiGlnhOqe70nW3jJoMEwtYbjFe1jAexC0Rd5DFCzqBXIJ
X-Received: by 10.194.58.8 with SMTP id m8mr16397691wjq.43.1417108092207;
	Thu, 27 Nov 2014 09:08:12 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id i3sm26091281wix.0.2014.11.27.09.08.09
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 06F49564130; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:58 +0000
Message-Id: <e764834f3c7c7da9356fa11b62e1fa8f643986fc.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 07/14] toaster: fix loadconf path calculation
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Fixing the path calculation for local layer sources, as the
path need to be absolute.

Added tests for pieces of code.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../bldcontrol/management/commands/loadconf.py     | 42 +++++++++++++---------
 lib/toaster/bldcontrol/tests.py                    | 19 ++++++++++
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/loadconf.py b/lib/toaster/bldcontrol/management/commands/loadconf.py
index 6e1f97a..2257a71 100644
--- a/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -5,20 +5,29 @@ import os
 
 from checksettings import DN
 
+def _reduce_canon_path(path):
+    components = []
+    for c in path.split("/"):
+        if c == "..":
+            del components[-1]
+        elif c == ".":
+            pass
+        else:
+            components.append(c)
+    if len(components) < 2:
+        components.append('')
+    return "/".join(components)
+
+def _get_id_for_sourcetype(s):
+    for i in LayerSource.SOURCE_TYPE:
+        if s == i[1]:
+            return i[0]
+    raise Exception("Could not find definition for sourcetype " + s)
+
 class Command(BaseCommand):
     help = "Loads a toasterconf.json file in the database"
     args = "filepath"
 
-    def _reduce_canon_path(self, path):
-        components = []
-        for c in path.split("/"):
-            if c == "..":
-                del components[-1]
-            elif c == ".":
-                pass
-            else:
-                components.append(c)
-        return "/".join(components)
 
 
     def _import_layer_config(self, filepath):
@@ -71,16 +80,13 @@ class Command(BaseCommand):
             assert 'name' in lsi
             assert 'branches' in lsi
 
-            def _get_id_for_sourcetype(s):
-                for i in LayerSource.SOURCE_TYPE:
-                    if s == i[1]:
-                        return i[0]
-                raise Exception("Could not find definition for sourcetype " + s)
 
             if _get_id_for_sourcetype(lsi['sourcetype']) == LayerSource.TYPE_LAYERINDEX or lsi['apiurl'].startswith("/"):
                 apiurl = lsi['apiurl']
             else:
-                apiurl = self._reduce_canon_path(os.path.join(DN(filepath), lsi['apiurl']))
+                apiurl = _reduce_canon_path(os.path.join(DN(os.path.abspath(filepath)), lsi['apiurl']))
+
+            assert ((_get_id_for_sourcetype(lsi['sourcetype']) == LayerSource.TYPE_LAYERINDEX) or apiurl.startswith("/")), (lsi['sourcetype'],apiurl)
 
             try:
                 ls = LayerSource.objects.get(sourcetype = _get_id_for_sourcetype(lsi['sourcetype']), apiurl = apiurl)
@@ -102,7 +108,7 @@ class Command(BaseCommand):
                     if layerinfo['local_path'].startswith("/"):
                         lo.local_path = layerinfo['local_path']
                     else:
-                        lo.local_path = self._reduce_canon_path(os.path.join(DN(DN(DN(filepath))), layerinfo['local_path']))
+                        lo.local_path = _reduce_canon_path(os.path.join(ls.apiurl, layerinfo['local_path']))
 
                     if not os.path.exists(lo.local_path):
                         raise Exception("Local layer path %s must exists." % lo.local_path)
@@ -110,6 +116,8 @@ class Command(BaseCommand):
                     lo.vcs_url = layerinfo['vcs_url']
                     if layerinfo['vcs_url'].startswith("remote:"):
                         lo.vcs_url = _read_git_url_from_local_repository(layerinfo['vcs_url'])
+                    else:
+                        lo.vcs_url = layerinfo['vcs_url']
 
                     if 'layer_index_url' in layerinfo:
                         lo.layer_index_url = layerinfo['layer_index_url']
diff --git a/lib/toaster/bldcontrol/tests.py b/lib/toaster/bldcontrol/tests.py
index 37d6524..5a9d1df 100644
--- a/lib/toaster/bldcontrol/tests.py
+++ b/lib/toaster/bldcontrol/tests.py
@@ -141,3 +141,22 @@ class RunBuildsCommandTests(TestCase):
         self.assertTrue(br.state == BuildRequest.REQ_INPROGRESS, "Request is not updated")
         # no more selections possible here
         self.assertRaises(IndexError, command._selectBuildRequest)
+
+
+class UtilityTests(TestCase):
+    def test_reduce_path(self):
+        from bldcontrol.management.commands.loadconf import _reduce_canon_path, _get_id_for_sourcetype
+
+        self.assertTrue( _reduce_canon_path("/") == "/")
+        self.assertTrue( _reduce_canon_path("/home/..") == "/")
+        self.assertTrue( _reduce_canon_path("/home/../ana") == "/ana")
+        self.assertTrue( _reduce_canon_path("/home/../ana/..") == "/")
+        self.assertTrue( _reduce_canon_path("/home/ana/mihai/../maria") == "/home/ana/maria")
+
+    def test_get_id_for_sorucetype(self):
+        from bldcontrol.management.commands.loadconf import _reduce_canon_path, _get_id_for_sourcetype
+        self.assertTrue( _get_id_for_sourcetype("layerindex") == 1)
+        self.assertTrue( _get_id_for_sourcetype("local") == 0)
+        self.assertTrue( _get_id_for_sourcetype("imported") == 2)
+        with self.assertRaises(Exception):
+            _get_id_for_sourcetype("unknown")
-- 
1.9.1


