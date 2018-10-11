Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 06F8B60596
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Oct 2018 21:18:33 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w9BLIYIu012686
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Oct 2018 14:18:35 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.408.0;
	Thu, 11 Oct 2018 14:18:34 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 11 Oct 2018 17:18:33 -0400
Message-ID: <20181011211833.25717-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH] layerindexlib: Fix various type checking errors
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
X-List-Received-Date: Thu, 11 Oct 2018 21:18:34 -0000
Content-Type: text/plain

In the list_obj function, we can't check if the requested object is 'in',
the index data -- as it's actually an attribute of the object.  Move to hasattr.

The remaining items were incorrect usages of 'type' for class type comparison.
Instead move to 'isinstance'.  Remaing 'type' comparisons are still valid.  The
code was also reordered slightly to avoid a lot of:

if not isinstance(x, y):
   ...
else:
   ...

reordering it removes the not and makes the code slightly easier to read.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/layerindexlib/__init__.py | 51 +++++++++++++++++++++----------------------
 lib/layerindexlib/cooker.py   | 19 +++++++++-------
 2 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
index 74f3e2e..cb79cb3 100644
--- a/lib/layerindexlib/__init__.py
+++ b/lib/layerindexlib/__init__.py
@@ -448,7 +448,7 @@ layerBranches set.  If not, they are effectively blank.'''
 This function is used to implement debugging and provide the user info.
 '''
         for lix in self.indexes:
-            if object not in lix:
+            if not hasattr(lix, object):
                 continue
 
             logger.plain ('')
@@ -1046,15 +1046,15 @@ class LayerBranch(LayerIndexItemObj):
         self.id = id
         self.collection = collection
         self.version = version
-        if type(layer) != type(LayerItem):
-            self.layer_id = layer
-        else:
+        if isinstance(layer, LayerItem):
             self.layer = layer
-
-        if type(branch) != type(Branch):
-            self.branch_id = branch
         else:
+            self.layer_id = layer
+
+        if isinstance(branch, Branch):
             self.branch = branch
+        else:
+            self.branch_id = branch
 
         self.vcs_subdir = vcs_subdir
         self.vcs_last_fetch = vcs_last_fetch
@@ -1088,7 +1088,7 @@ class LayerBranch(LayerIndexItemObj):
 
     @layer.setter
     def layer(self, value):
-        if type(value) != type(LayerItem):
+        if not isinstance(value, LayerItem):
             raise TypeError('value is not a LayerItem')
         if self.index != value.index:
             raise AttributeError('Object and value do not share the same index and thus key set.')
@@ -1122,7 +1122,7 @@ class LayerBranch(LayerIndexItemObj):
 
     @branch.setter
     def branch(self, value):
-        if type(value) != type(LayerItem):
+        if not isinstance(value, LayerItem):
             raise TypeError('value is not a LayerItem')
         if self.index != value.index:
             raise AttributeError('Object and value do not share the same index and thus key set.')
@@ -1181,7 +1181,7 @@ class LayerIndexItemObj_LayerBranch(LayerIndexItemObj):
 
     @layerbranch.setter
     def layerbranch(self, value):
-        if type(value) != type(LayerBranch):
+        if not isinstance(value, LayerBranch):
             raise TypeError('value (%s) is not a layerBranch' % type(value))
         if self.index != value.index:
             raise AttributeError('Object and value do not share the same index and thus key set.')
@@ -1207,14 +1207,14 @@ class LayerIndexItemObj_LayerBranch(LayerIndexItemObj):
 class LayerDependency(LayerIndexItemObj_LayerBranch):
     def define_data(self, id, layerbranch, dependency, required=True):
         self.id = id
-        if type(layerbranch) != type(LayerBranch):
-            self.layerbranch_id = layerbranch
-        else:
+        if isinstance(layerbranch, LayerBranch):
             self.layerbranch = layerbranch
-        if type(dependency) != type(LayerDependency):
-            self.dependency_id = dependency
         else:
+            self.layerbranch_id = layerbranch
+        if isinstance(dependency, LayerDependency):
             self.dependency = dependency
+        else:
+            self.dependency_id = dependency
         self.required = required
 
     @property
@@ -1240,7 +1240,7 @@ class LayerDependency(LayerIndexItemObj_LayerBranch):
 
     @dependency.setter
     def dependency(self, value):
-        if type(value) != type(LayerDependency):
+        if not isinstance(value, LayerDependency):
             raise TypeError('value (%s) is not a dependency' % type(value))
         if self.index != value.index:
             raise AttributeError('Object and value do not share the same index and thus key set.')
@@ -1288,10 +1288,10 @@ class Recipe(LayerIndexItemObj_LayerBranch):
         self.inherits = inherits
         self.updated = updated or datetime.datetime.today().isoformat()
         self.blacklisted = blacklisted
-        if type(layerbranch) != type(LayerBranch):
-            self.layerbranch_id = layerbranch
-        else:
+        if isinstance(layerbranch, LayerBranch):
             self.layerbranch = layerbranch
+        else:
+            self.layerbranch_id = layerbranch
 
     @property
     def fullpath(self):
@@ -1324,10 +1324,10 @@ class Machine(LayerIndexItemObj_LayerBranch):
         self.id = id
         self.name = name
         self.description = description
-        if type(layerbranch) != type(LayerBranch):
-            self.layerbranch_id = layerbranch
-        else:
+        if isinstance(layerbranch, LayerBranch):
             self.layerbranch = layerbranch
+        else:
+            self.layerbranch_id = layerbranch
         self.updated = updated or datetime.datetime.today().isoformat()
 
 class Distro(LayerIndexItemObj_LayerBranch):
@@ -1337,13 +1337,12 @@ class Distro(LayerIndexItemObj_LayerBranch):
         self.id = id
         self.name = name
         self.description = description
-        if type(layerbranch) != type(LayerBranch):
-            self.layerbranch_id = layerbranch
-        else:
+        if isinstance(layerbranch, LayerBranch):
             self.layerbranch = layerbranch
+        else:
+            self.layerbranch_id = layerbranch
         self.updated = updated or datetime.datetime.today().isoformat()
 
-
 # When performing certain actions, we may need to sort the data.
 # This will allow us to keep it consistent from run to run.
 def sort_entry(item):
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
index 248a597..848f0e2 100644
--- a/lib/layerindexlib/cooker.py
+++ b/lib/layerindexlib/cooker.py
@@ -136,10 +136,13 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
                 layerrev = self._run_command('git rev-parse HEAD', layerpath, default="<unknown>")
 
                 for remotes in self._run_command('git remote -v', layerpath, default="").split("\n"):
-                    remote = remotes.split("\t")[1].split(" ")[0]
-                    if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
-                        layerurl = self._handle_git_remote(remote)
-                        break
+                    if not remotes:
+                        layerurl = self._handle_git_remote(layerpath)
+                    else:
+                        remote = remotes.split("\t")[1].split(" ")[0]
+                        if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
+                            layerurl = self._handle_git_remote(remote)
+                            break
 
             layerItemId += 1
             index.layerItems[layerItemId] = layerindexlib.LayerItem(index, None)
@@ -297,7 +300,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
 
             for layerBranchId in index.layerBranches:
                 # load_bblayers uses the description to cache the actual path...
-                machine_path = index.layerBranches[layerBranchId].getDescription()
+                machine_path = index.layerBranches[layerBranchId].layer.description
                 machine_path = os.path.join(machine_path, 'conf/machine')
                 if os.path.isdir(machine_path):
                     for (dirpath, _, filenames) in os.walk(machine_path):
@@ -310,7 +313,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
                                 machine = layerindexlib.Machine(index, None)
                                 machine.define_data(id=machineId, name=fname[:-5],
                                                     description=fname[:-5],
-                                                    layerbranch=collection_layerbranch[entry])
+                                                    layerbranch=index.layerBranches[layerBranchId])
 
                                 index.add_element("machines", [machine])
 
@@ -321,7 +324,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
 
             for layerBranchId in index.layerBranches:
                 # load_bblayers uses the description to cache the actual path...
-                distro_path = index.layerBranches[layerBranchId].getDescription()
+                distro_path = index.layerBranches[layerBranchId].layer.description
                 distro_path = os.path.join(distro_path, 'conf/distro')
                 if os.path.isdir(distro_path):
                     for (dirpath, _, filenames) in os.walk(distro_path):
@@ -334,7 +337,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
                                 distro = layerindexlib.Distro(index, None)
                                 distro.define_data(id=distroId, name=fname[:-5],
                                                     description=fname[:-5],
-                                                    layerbranch=collection_layerbranch[entry])
+                                                    layerbranch=index.layerBranches[layerBranchId])
 
                                 index.add_element("distros", [distro])
 
-- 
1.8.3.1


