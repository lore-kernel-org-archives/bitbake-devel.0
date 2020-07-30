Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by mx.groups.io with SMTP id smtpd.web10.4661.1596101062092472760
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2020 02:24:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.1.11, mailfrom: liezhi.yang@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 06U9OGWP006382
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2020 02:24:16 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Jul 2020
 02:24:15 -0700
From: "Robert Yang" <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/3] utils.py: get_file_layer(): Improve performance
Date: Thu, 30 Jul 2020 02:23:42 -0700
Message-ID: <20200730092342.7420-3-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730092342.7420-1-liezhi.yang@windriver.com>
References: <20200730092342.7420-1-liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 lib/bb/utils.py       | 12 +++++++++---
 lib/bblayers/query.py | 10 ++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 03568474d..ca5c38683 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1472,14 +1472,20 @@ def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
 
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
index ee2db0efe..be2d84c35 100644
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
2.26.2

