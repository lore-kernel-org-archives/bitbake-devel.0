Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web10.17132.1599560551836168781
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Sep 2020 03:22:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 088AM0As026921
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Tue, 8 Sep 2020 03:22:21 -0700
Received: from ala-lpggp3.wrs.com (147.11.105.124) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 03:22:10 -0700
From: "Robert Yang" <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 3/3] utils.py: get_file_layer(): Improve performance
Date: Tue, 8 Sep 2020 03:21:47 -0700
Message-ID: <49db075be9d5cc6f01c076c2380d152fac254786.1599560025.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1599560025.git.liezhi.yang@windriver.com>
References: <cover.1599560025.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain

The following code costs a lot of time when there are lot of layers and recipes:

     for collection in collections:
         collection_res[collection] = d.getVar('BBFILE_PATTERN_%s' % collection) or ''

My build has more than 100 layers and 3000 recipes, which calls d.getVar() 300K
(3000 * 100) times and makes 'bitbake-layers show-recipes' very slow, add a
keyword argument to get_file_layer() can fix the problem, it can save about 90%
time in my build (6min -> 40s).

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/utils.py       | 12 +++++++++---
 bitbake/lib/bblayers/query.py | 10 ++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 5722fced97..fc78c5436b 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1458,14 +1458,20 @@ def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
 
     return (notadded, notremoved)
 
-
-def get_file_layer(filename, d):
-    """Determine the collection (as defined by a layer's layer.conf file) containing the specified file"""
+def get_collection_res(d):
     collections = (d.getVar('BBFILE_COLLECTIONS') or '').split()
     collection_res = {}
     for collection in collections:
         collection_res[collection] = d.getVar('BBFILE_PATTERN_%s' % collection) or ''
 
+    return collection_res
+
+
+def get_file_layer(filename, d, collection_res={}):
+    """Determine the collection (as defined by a layer's layer.conf file) containing the specified file"""
+    if not collection_res:
+        collection_res = get_collection_res(d)
+
     def path_to_layer(path):
         # Use longest path so we handle nested layers
         matchlen = 0
diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index ee2db0efed..be2d84c351 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -107,6 +107,8 @@ pnspec to match a specified recipe name (supports wildcards). Note that
 skipped recipes will also be listed, with a " (skipped)" suffix.
 """
 
+        self.collection_res = {}
+
         inheritlist = args.inherits.split(',') if args.inherits else []
         if inheritlist or args.pnspec or args.multiple:
             title = 'Matching recipes:'
@@ -222,7 +224,6 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                             multilayer = True
                         if prov[0] != pref[0]:
                             same_ver = False
-
                     if (multilayer or not show_overlayed_only) and (same_ver or not show_same_ver_only):
                         if not items_listed:
                             logger.plain('=== %s ===' % title)
@@ -243,8 +244,13 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         else:
             return '?'
 
+    def get_collection_res(self):
+        if not self.collection_res:
+            self.collection_res = bb.utils.get_collection_res(self.tinfoil.config_data)
+        return self.collection_res
+
     def get_file_layerdir(self, filename):
-        layer = bb.utils.get_file_layer(filename, self.tinfoil.config_data)
+        layer = bb.utils.get_file_layer(filename, self.tinfoil.config_data, self.get_collection_res())
         return self.bbfile_collections.get(layer, None)
 
     def remove_layer_prefix(self, f):
-- 
2.17.1

