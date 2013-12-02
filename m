Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 5FA506B1A9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 18:58:58 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 02 Dec 2013 10:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,812,1378882800"; d="scan'208";a="443340812"
Received: from pmcgurk-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.121.184])
	by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2013 10:58:56 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Dec 2013 18:58:47 +0000
Message-Id: <2c5896594ec12a2a06085b5a54f9cd742a20a47c.1386010573.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386010573.git.paul.eggleton@linux.intel.com>
References: <cover.1386010573.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386010573.git.paul.eggleton@linux.intel.com>
References: <cover.1386010573.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] hob: fix package property dialog for changes to FILES_INFO
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
X-List-Received-Date: Mon, 02 Dec 2013 18:58:58 -0000

The FILES_INFO structure is now much simpler, so remove all of the
horrible mangling we had to do here in order to read it.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/crumbs/hig/propertydialog.py | 44 ++++++++++++----------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig/propertydialog.py b/lib/bb/ui/crumbs/hig/propertydialog.py
index 9ab7d75..09b9ce6 100644
--- a/lib/bb/ui/crumbs/hig/propertydialog.py
+++ b/lib/bb/ui/crumbs/hig/propertydialog.py
@@ -105,13 +105,14 @@ class PropertyDialog(CrumbsDialog):
                 
         def create_package_visual_elements(self):
 
+                import json
+
                 name = self.properties['name']
                 binb = self.properties['binb']
                 size = self.properties['size']
                 recipe = self.properties['recipe']
-                file_list = self.properties['files_list']
+                file_list = json.loads(self.properties['files_list'])
 
-                file_list = file_list.strip("{}'")
                 files_temp = ''
                 paths_temp = ''
                 files_binb = []
@@ -180,7 +181,7 @@ class PropertyDialog(CrumbsDialog):
 
                 #################################### FILES BROUGHT BY PACKAGES ###################################
 
-                if file_list != '':
+                if file_list:
                 
                         self.textWindow = gtk.ScrolledWindow()
                         self.textWindow.set_shadow_type(gtk.SHADOW_IN)
@@ -199,33 +200,18 @@ class PropertyDialog(CrumbsDialog):
                         col1.set_cell_data_func(self.cell1, self.regex_field)
                         self.packagefiles_tv.append_column(col1)
 
-                        for items in file_list.split(']'):
-                            if len(items) > 1:
-                                paths_temp = items.split(":")[0]
-                                paths_binb.append(paths_temp.strip(" ,'"))
-                                files_temp = items.split(":")[1]
-                                files_binb.append(files_temp.strip(" ['"))
+                        items = file_list.keys()
+                        items.sort()
+                        for item in items:
+                                fullpath = item
+                                while len(item) > 35:
+                                        item = item[:len(item)/2] + "" + item[len(item)/2+1:]
+                                if len(item) == 35:
+                                        item = item[:len(item)/2] + "..." + item[len(item)/2+3:]
+                                        self.tooltip_items[item] = fullpath
+
+                                packagefiles_store.append([str(item)])
 
-                        unsorted_list = []
-                        
-                        for items in range(len(paths_binb)):
-                              if len(files_binb[items]) > 1:
-                                  for aduse in (files_binb[items].split(",")):
-                                        unsorted_list.append(paths_binb[items].split(name)[len(paths_binb[items].split(name))-1] + '/' + aduse.strip(" '"))
-                       
-                         
-                        unsorted_list.sort()
-                        for items in unsorted_list:
-                                temp = items
-                                while len(items) > 35:
-                                        items = items[:len(items)/2] + "" + items[len(items)/2+1:]
-                                if len(items) == 35:
-                                        items = items[:len(items)/2] + "..." + items[len(items)/2+3:]
-                                        self.tooltip_items[items] = temp
-
-                                packagefiles_store.append([str(items)])
-                                
-                                
                         self.packagefiles_tv.set_model(packagefiles_store)
 
                         tips = gtk.Tooltips()
-- 
1.8.1.2


