Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id B2892787DA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 20:34:21 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w6CKYGIp016516
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 13:34:17 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.399.0;
	Thu, 12 Jul 2018 13:34:16 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Jul 2018 16:34:10 -0400
Message-ID: <20180712203413.118578-3-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180712203413.118578-1-mark.hatle@windriver.com>
References: <20180712203413.118578-1-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 14 Jul 2018 08:49:07 +0000
Subject: [PATCH 2/5] layerindexlib: Initial layer index processing module implementation
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
X-List-Received-Date: Thu, 12 Jul 2018 20:34:22 -0000
Content-Type: text/plain

The layer index module is expected to be used by various parts of the system
in order to access a layerindex-web (such as layers.openembedded.org) and
perform basic processing on the information, such as dependency scanning.

Along with the layerindex implementation are associated tests.  The tests
properly honor BB_SKIP_NETTESTS='yes' to prevent test failures.

Tests Implemented:
   - Branch, LayerItem, LayerBranch, LayerDependency, Recipe, Machine and
      Distro objects
   - LayerIndex setup using the layers.openembedded.org restapi
   - LayerIndex storing and retrieving from a file
   - LayerIndex verify dependency resolution ordering
   - LayerIndex setup using simulated cooker data

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 bin/bitbake-selftest                               |   6 +-
 lib/layerindexlib/README                           |  28 +
 lib/layerindexlib/__init__.py                      | 974 +++++++++++++++++++++
 lib/layerindexlib/common.py                        | 161 ++++
 lib/layerindexlib/cooker.py                        | 338 +++++++
 lib/layerindexlib/restapi.py                       | 375 ++++++++
 lib/layerindexlib/tests/__init__.py                |   0
 lib/layerindexlib/tests/common.py                  |  37 +
 lib/layerindexlib/tests/cooker.py                  | 125 +++
 lib/layerindexlib/tests/layerindex.py              | 233 +++++
 lib/layerindexlib/tests/restapi.py                 | 170 ++++
 lib/layerindexlib/tests/testdata/README            |  11 +
 .../tests/testdata/build/conf/bblayers.conf        |  15 +
 .../tests/testdata/layer1/conf/layer.conf          |  17 +
 .../tests/testdata/layer2/conf/layer.conf          |  20 +
 .../tests/testdata/layer3/conf/layer.conf          |  19 +
 .../tests/testdata/layer4/conf/layer.conf          |  22 +
 17 files changed, 2550 insertions(+), 1 deletion(-)
 create mode 100644 lib/layerindexlib/README
 create mode 100644 lib/layerindexlib/__init__.py
 create mode 100644 lib/layerindexlib/common.py
 create mode 100644 lib/layerindexlib/cooker.py
 create mode 100644 lib/layerindexlib/restapi.py
 create mode 100644 lib/layerindexlib/tests/__init__.py
 create mode 100644 lib/layerindexlib/tests/common.py
 create mode 100644 lib/layerindexlib/tests/cooker.py
 create mode 100644 lib/layerindexlib/tests/layerindex.py
 create mode 100644 lib/layerindexlib/tests/restapi.py
 create mode 100644 lib/layerindexlib/tests/testdata/README
 create mode 100644 lib/layerindexlib/tests/testdata/build/conf/bblayers.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer1/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer2/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer3/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer4/conf/layer.conf

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index afe1603..7ead688 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -22,6 +22,7 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib
 import unittest
 try:
     import bb
+    import layerindexlib
 except RuntimeError as exc:
     sys.exit(str(exc))
 
@@ -31,7 +32,10 @@ tests = ["bb.tests.codeparser",
          "bb.tests.event",
          "bb.tests.fetch",
          "bb.tests.parse",
-         "bb.tests.utils"]
+         "bb.tests.utils",
+         "layerindexlib.tests.layerindex",
+         "layerindexlib.tests.restapi",
+         "layerindexlib.tests.cooker"]
 
 for t in tests:
     t = '.'.join(t.split('.')[:3])
diff --git a/lib/layerindexlib/README b/lib/layerindexlib/README
new file mode 100644
index 0000000..5d927af
--- /dev/null
+++ b/lib/layerindexlib/README
@@ -0,0 +1,28 @@
+The layerindexlib module is designed to permit programs to work directly
+with layer index information.  (See layers.openembedded.org...)
+
+The layerindexlib module includes a plugin interface that is used to extend
+the basic functionality.  There are two primary plugins available: restapi
+and cooker.
+
+The restapi plugin works with a web based REST Api compatible with the
+layerindex-web project, as well as the ability to store and retried a
+the information for one or more files on the disk.
+
+The cooker plugin works by reading the information from the current build
+project and processing it as if it were a layer index.
+
+
+TODO:
+
+__init__.py:
+Implement local on-disk caching (using the rest api store/load)
+Implement layer index style query operations on a combined index
+
+common.py:
+Stop network access if BB_NO_NETWORK or allowed hosts is restricted
+
+cooker.py:
+Cooker - Implement recipe parsing
+
+
diff --git a/lib/layerindexlib/__init__.py b/lib/layerindexlib/__init__.py
new file mode 100644
index 0000000..96644a3
--- /dev/null
+++ b/lib/layerindexlib/__init__.py
@@ -0,0 +1,974 @@
+# Copyright (C) 2016-2018 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+import datetime
+
+import logging
+import imp
+
+import bb.fetch2
+
+from collections import OrderedDict
+
+logger = logging.getLogger('BitBake.layerindexlib')
+
+class LayerIndex():
+    def __init__(self, d):
+        if d:
+            self.data = d
+        else:
+            import bb.data
+            self.data = bb.data.init()
+            # We need to use the fetcher to parse the URL
+            # it requires DL_DIR to be set
+            self.data.setVar('DL_DIR', os.getcwd())
+
+        self.lindex = []
+
+        self.plugins = []
+
+        import bb.utils
+        bb.utils.load_plugins(logger, self.plugins, os.path.dirname(__file__))
+        for plugin in self.plugins:
+            if hasattr(plugin, 'init'):
+                plugin.init(self)
+
+    def __add__(self, other):
+        newIndex = LayerIndex(self.data)
+
+        if self.__class__ != newIndex.__class__ or \
+           other.__class__ != newIndex.__class__:
+            raise TypeException("Can not add different types.")
+
+        for lindexEnt in self.lindex:
+            newIndex.lindex.append(lindexEnt)
+
+        for lindexEnt in other.lindex:
+            newIndex.lindex.append(lindexEnt)
+
+        return newIndex
+
+    def _get_plugin(self, type):
+        for plugin in self.plugins:
+            if hasattr(plugin, 'plugin_type'):
+                plugintype = plugin.plugin_type()
+                logger.debug(1, "Looking for IndexPlugin - %s ? %s" % (plugintype, type))
+                if plugintype and plugintype == type:
+                    return plugin
+        return None
+
+    loadRecipes = 1
+    def load_layerindex(self, indexURIs, reload=False, load='layerDependencies recipes machines distros'):
+        """Load the layerindex.
+
+indexURIs- This may be one or more indexes (white space seperated).
+
+reload - If reload is True, then any previously loaded indexes will be forgotten.
+
+load - Ability to NOT load certain elements for performance.  White space seperated list
+       of optional things to load.  (branches, layerItems and layerBranches is always
+       loaded.)   Note: the plugins are permitted to ignore this and load everything.
+
+The format of the indexURI:
+
+  <url>;type=<type>;branch=<branch>;cache=<cache>;desc=<description>
+
+  Note: the 'branch' parameter if set can select multiple branches by using
+  comma, such as 'branch=master,morty,pyro'.  However, many operations only look
+  at the -first- branch specified!
+
+  The cache value may be undefined, in this case a network failure will
+  result in an error, otherwise the system will look for a file of the cache
+  name and load that instead.
+
+  For example:
+
+  http://layers.openembedded.org/layerindex/api/;type=restapi;branch=master;desc=OpenEmbedded%20Layer%20Index
+  file://conf/bblayers.conf;type=internal
+
+restapi is either a web url or a local file or a local directory with one
+or more .json file in it in the restapi format
+
+internal refers to any layers loaded as part of a project conf/bblayers.conf
+"""
+        if reload:
+            self.lindex = []
+
+        logger.debug(1, 'Loading: %s' % indexURIs)
+
+        for url in indexURIs.split():
+            ud = bb.fetch2.FetchData(url, self.data)
+
+            if 'type' not in ud.parm:
+                raise bb.fetch2.MissingParameterError('type', url)
+
+            plugin = self._get_plugin(ud.parm['type'] or "restapi")
+
+            if not plugin:
+                raise NotImplementedError("%s: type %s is not available" % (url, ud.parm['type']))
+
+            # TODO: Implement 'cache', for when the network is not available
+            lindexEnt = plugin.load_index(ud, load)
+
+            if 'CONFIG' not in lindexEnt:
+                raise Exception('Internal Error: Missing configuration data in index %s' % url)
+
+            # Mark CONFIG data as something we've added...
+            lindexEnt['CONFIG']['local'] = []
+            lindexEnt['CONFIG']['local'].append('CONFIG')
+
+            if 'branches' not in lindexEnt:
+                raise Exception('Internal Error: No branches defined in index %s' % url)
+
+            # Create quick lookup layerBranches_layerId_branchId table
+            if 'layerBranches' in lindexEnt:
+                # Create associated quick lookup indexes
+                lindexEnt['layerBranches_layerId_branchId'] = {}
+                for layerBranchId in lindexEnt['layerBranches']:
+                    obj = lindexEnt['layerBranches'][layerBranchId]
+                    lindexEnt['layerBranches_layerId_branchId']["%s:%s" % (obj.get_layer_id(), obj.get_branch_id())] = obj
+                # Mark layerBranches_layerId_branchId as something we added
+                lindexEnt['CONFIG']['local'].append('layerBranches_layerId_branchId')
+
+            # Create quick lookup layerDependencies_layerBranchId table
+            if 'layerDependencies' in lindexEnt:
+                # Create associated quick lookup indexes
+                lindexEnt['layerDependencies_layerBranchId'] = {}
+                for layerDependencyId in lindexEnt['layerDependencies']:
+                    obj = lindexEnt['layerDependencies'][layerDependencyId]
+                    if obj.get_layerbranch_id() not in lindexEnt['layerDependencies_layerBranchId']:
+                        lindexEnt['layerDependencies_layerBranchId'][obj.get_layerbranch_id()] = [obj]
+                    else:
+                        lindexEnt['layerDependencies_layerBranchId'][obj.get_layerbranch_id()].append(obj)
+                # Mark layerDependencies_layerBranchId as something we added
+                lindexEnt['CONFIG']['local'].append('layerDependencies_layerBranchId')
+
+            # Create quick lookup layerUrls
+            if 'layerBranches' in lindexEnt:
+                # Create associated quick lookup indexes
+                lindexEnt['layerUrls'] = {}
+                for layerBranchId in lindexEnt['layerBranches']:
+                    obj = lindexEnt['layerBranches'][layerBranchId]
+                    vcs_url = obj.get_layer().get_vcs_url()
+                    if vcs_url not in lindexEnt['layerUrls']:
+                        lindexEnt['layerUrls'][vcs_url] = [obj]
+                    else:
+                        # We insert this if there is no subdir, we know it's the parent
+                        if not obj.get_vcs_subdir():
+                            lindexEnt['layerUrls'][vcs_url].insert(0, obj)
+                        else:
+                            lindexEnt['layerUrls'][vcs_url].append(obj)
+                # Mark layerUrls as something we added
+                lindexEnt['CONFIG']['local'].append('layerUrls')
+
+            self.lindex.append(lindexEnt)
+
+    def store_layerindex(self, indexURI, lindex=None):
+        """Store a layerindex
+
+Typically this will be used to create a local cache file of a remote index.
+
+  file://<path>;type=<type>;branch=<branch>
+
+We can write out in either the restapi or django formats.  The split option
+will write out the individual elements split by layer and related components.
+"""
+        if not lindex:
+            logger.warning('No index to write, nothing to do.')
+            return
+
+        ud = bb.fetch2.FetchData(indexURI, self.data)
+
+        if 'type' not in ud.parm:
+            raise bb.fetch2.MissingParameterError('type', indexURI)
+
+        plugin = self._get_plugin(ud.parm['type'])
+
+        if not plugin:
+            raise NotImplementedError("%s: type %s is not available" % (url, ud.parm['type']))
+
+        lindexEnt = plugin.store_index(ud, lindex)
+
+
+    def get_json_query(self, query):
+        """Return a query in restapi format
+
+This is a compatibility function.  It will acts like the web restapi query
+and return back the information related to a specific query.  It can be used
+but other components of the system that would rather deal with restapi
+style queries then the regular functions in this class.
+
+Note: only select queries are supported.  This will have to be expanded
+to support additional queries.
+
+This function will merge multiple databases together to return a single
+coherent 'superset' result, when more then one index has been loaded.
+"""
+
+        # TODO Implement get_json_query
+        raise Exception("get_json_query: not Implemented!")
+
+    def is_empty(self):
+        """Return True or False if the index has any usable data.
+
+We check the lindex entries to see if they have a branch set, as well as
+layerBranches set.  If not, they are effectively blank."""
+
+        found = False
+        for lindex in self.lindex:
+            if 'branches' in lindex and 'layerBranches' in lindex and \
+               lindex['branches'] and lindex['layerBranches']:
+                found = True
+                break
+        return not found
+
+
+    def find_vcs_url(self, vcs_url, branch=None):
+        """Return the first layerBranch with the given vcs_url
+
+If a branch has not been specified, we will iterate over the branches in
+the default configuration until the first vcs_url/branch match."""
+
+        for lindex in self.lindex:
+            logger.debug(1, ' searching %s' % lindex['CONFIG']['DESCRIPTION'])
+            layerBranch = self._find_vcs_url(lindex, vcs_url, branch)
+            if layerBranch:
+                return layerBranch
+        return None
+
+    def _find_vcs_url(self, lindex, vcs_url, branch=None):
+        if 'branches' not in lindex or 'layerBranches' not in lindex:
+            return None
+
+        if vcs_url in lindex['layerUrls']:
+            for layerBranch in lindex['layerUrls'][vcs_url]:
+                if branch and branch == layerBranch.get_branch().get_name():
+                    return layerBranch
+                if not branch:
+                    return layerBranch
+
+        return None
+
+
+    def find_collection(self, collection, version=None, branch=None):
+        """Return the first layerBranch with the given collection name
+
+If a branch has not been specified, we will iterate over the branches in
+the default configuration until the first colelction/branch match."""
+
+        logger.debug(1, 'find_collection: %s (%s) %s' % (collection, version, branch))
+
+        for lindex in self.lindex:
+            logger.debug(1, ' searching %s' % lindex['CONFIG']['DESCRIPTION'])
+            layerBranch = self._find_collection(lindex, collection, version, branch)
+            if layerBranch:
+                return layerBranch
+        else:
+            logger.debug(1, 'Collection %s (%s) not found for branch (%s)' % (collection, version, branch))
+        return None
+
+    def _find_collection(self, lindex, collection, version=None, branch=None):
+        if 'branches' not in lindex or 'layerBranches' not in lindex:
+            return None
+
+        def find_branch_layerItem(branch, collection, version):
+            for branchId in lindex['branches']:
+                if branch == lindex['branches'][branchId].get_name():
+                    break
+            else:
+                return None
+
+            for layerBranchId in lindex['layerBranches']:
+                if branchId == lindex['layerBranches'][layerBranchId].get_branch_id() and \
+                   collection == lindex['layerBranches'][layerBranchId].get_collection():
+                    if not version or version == lindex['layerBranches'][layerBranchId].get_version():
+                        return lindex['layerBranches'][layerBranchId]
+
+            return None
+
+        if branch:
+            layerBranch = find_branch_layerItem(branch, collection, version)
+            return layerBranch
+
+        # No branch, so we have to scan the branches in order...
+        # Use the config order if we have it...
+        if 'CONFIG' in lindex and 'BRANCH' in lindex['CONFIG']:
+            for branch in lindex['CONFIG']['BRANCH'].split(','):
+                layerBranch = find_branch_layerItem(branch, collection, version)
+                if layerBranch:
+                    return layerBranch
+
+        # ...use the index order if we don't...
+        else:
+            for branchId in lindex['branches']:
+                branch = lindex['branches'][branchId].get_name()
+                layerBranch = get_branch_layerItem(branch, collection, version)
+                if layerBranch:
+                    return layerBranch
+
+        return None
+
+
+    def get_layerbranch(self, name, branch=None):
+        """Return the layerBranch item for a given name and branch
+
+If a branch has not been specified, we will iterate over the branches in
+the default configuration until the first name/branch match."""
+
+        for lindex in self.lindex:
+            layerBranch = self._get_layerbranch(lindex, name, branch)
+            if layerBranch:
+                return layerBranch
+        return None
+
+    def _get_layerbranch(self, lindex, name, branch=None):
+        if 'branches' not in lindex or 'layerItems' not in lindex:
+            logger.debug(1, 'No branches or no layerItems in lindex %s' % (lindex['CONFIG']['DESCRIPTION']))
+            return None
+
+        def get_branch_layerItem(branch, name):
+            for branchId in lindex['branches']:
+                if branch == lindex['branches'][branchId].get_name():
+                    break
+            else:
+                return None
+
+            for layerItemId in lindex['layerItems']:
+                if name == lindex['layerItems'][layerItemId].get_name():
+                    break
+            else:
+                return None
+
+            key = "%s:%s" % (layerItemId, branchId)
+            if key in lindex['layerBranches_layerId_branchId']:
+                return lindex['layerBranches_layerId_branchId'][key]
+            return None
+
+        if branch:
+            layerBranch = get_branch_layerItem(branch, name)
+            return layerBranch
+
+        # No branch, so we have to scan the branches in order...
+        # Use the config order if we have it...
+        if 'CONFIG' in lindex and 'BRANCH' in lindex['CONFIG']:
+            for branch in lindex['CONFIG']['BRANCH'].split(','):
+                layerBranch = get_branch_layerItem(branch, name)
+                if layerBranch:
+                    return layerBranch
+
+        # ...use the index order if we don't...
+        else:
+            for branchId in lindex['branches']:
+                branch = lindex['branches'][branchId].get_name()
+                layerBranch = get_branch_layerItem(branch, name)
+                if layerBranch:
+                    return layerBranch
+        return None
+
+    def get_dependencies(self, names=None, layerBranches=None, ignores=None):
+        """Return a tuple of all dependencies and invalid items.
+
+The dependency scanning happens with a depth-first approach, so the returned
+dependencies should be in the best order to define a bblayers.
+
+names - a space deliminated list of layerItem names.
+Branches are resolved in the order of the specified index's load.  Subsequent
+branch resolution is on the same branch.
+
+layerBranches - a list of layerBranches to resolve dependencies
+Branches are the same as the passed in layerBranch.
+
+ignores - a list of layer names to ignore
+
+Return value: (dependencies, invalid)
+
+dependencies is an orderedDict, with the key being the layer name.
+The value is a list with the first ([0]) being the layerBranch, and subsequent
+items being the layerDependency entries that caused this to be added.
+
+invalid is just a list of dependencies that were not found.
+"""
+        invalid = []
+
+        if not layerBranches:
+            layerBranches = []
+
+        if names:
+            for name in names.split():
+                if ignores and name in ignores:
+                    continue
+
+                # Since we don't have a branch, we have to just find the first
+                # layerBranch with that name...
+                for lindex in self.lindex:
+                    layerBranch = self._get_layerbranch(lindex, name)
+                    if not layerBranch:
+                        # Not in this index, hopefully it's in another...
+                        continue
+
+                    if layerBranch not in layerBranches:
+                        layerBranches.append(layerBranch)
+                    break
+                else:
+                    logger.warning("Layer %s not found.  Marked as invalid." % name)
+                    invalid.append(name)
+                    layerBranch = None
+
+        # Format is required['name'] = [ layer_branch, dependency1, dependency2, ..., dependencyN ]
+        dependencies = OrderedDict()
+        (dependencies, invalid) = self._get_dependencies(layerBranches, ignores, dependencies, invalid)
+
+        for layerBranch in layerBranches:
+            if layerBranch.get_layer().get_name() not in dependencies:
+                dependencies[layerBranch.get_layer().get_name()] = [layerBranch]
+
+        return (dependencies, invalid)
+
+
+    def _get_dependencies(self, layerBranches, ignores, dependencies, invalid):
+        for layerBranch in layerBranches:
+            name = layerBranch.get_layer().get_name()
+            # Do we ignore it?
+            if ignores and name in ignores:
+                continue
+
+            if 'layerDependencies_layerBranchId' not in layerBranch.index:
+                raise Exception('Missing layerDepedencies_layerBranchId cache! %s' % layerBranch.index['CONFIG']['DESCRIPTION'])
+
+            # Get a list of dependencies and then recursively process them
+            if layerBranch.get_id() in layerBranch.index['layerDependencies_layerBranchId']:
+                for layerDependency in layerBranch.index['layerDependencies_layerBranchId'][layerBranch.get_id()]:
+                    depLayerBranch = layerDependency.get_dependency_layerBranch()
+
+                    # Do we need to resolve across indexes?
+                    if depLayerBranch.index != self.lindex[0]:
+                        rdepLayerBranch = self.find_collection(
+                                          collection=depLayerBranch.get_collection(),
+                                          version=depLayerBranch.get_version()
+                                     )
+                        if rdepLayerBranch != depLayerBranch:
+                            logger.debug(1, 'Replaced %s:%s:%s with %s:%s:%s' % \
+                                  (depLayerBranch.index['CONFIG']['DESCRIPTION'],
+                                   depLayerBranch.get_branch().get_name(),
+                                   depLayerBranch.get_layer().get_name(),
+                                   rdepLayerBranch.index['CONFIG']['DESCRIPTION'],
+                                   rdepLayerBranch.get_branch().get_name(),
+                                   rdepLayerBranch.get_layer().get_name()))
+                            depLayerBranch = rdepLayerBranch
+
+                    # Is this dependency on the list to be ignored?
+                    if ignores and depLayerBranch.get_layer().get_name() in ignores:
+                        continue
+
+                    # Previously found dependencies have been processed, as
+                    # have their dependencies...
+                    if depLayerBranch.get_layer().get_name() not in dependencies:
+                        (dependencies, invalid) = self._get_dependencies([depLayerBranch], ignores, dependencies, invalid)
+
+                    if depLayerBranch.get_layer().get_name() not in dependencies:
+                        dependencies[depLayerBranch.get_layer().get_name()] = [depLayerBranch, layerDependency]
+                    else:
+                        if layerDependency not in dependencies[depLayerBranch.get_layer().get_name()]:
+                            dependencies[depLayerBranch.get_layer().get_name()].append(layerDependency)
+
+        return (dependencies, invalid)
+
+
+    def list_obj(self, object):
+        """Print via the plain logger object information
+
+This function is used to implement debugging and provide the user info.
+"""
+        for lix in self.lindex:
+            if object not in lix:
+                continue
+
+            logger.plain ('')
+            logger.plain('Index: %s' % lix['CONFIG']['DESCRIPTION'])
+
+            output = []
+
+            if object == 'branches':
+                logger.plain ('%s %s %s' % ('{:26}'.format('branch'), '{:34}'.format('description'), '{:22}'.format('bitbake branch')))
+                logger.plain ('{:-^80}'.format(""))
+                for branchId in lix['branches']:
+                    output.append('%s %s %s' % (
+                                  '{:26}'.format(lix['branches'][branchId].get_name()),
+                                  '{:34}'.format(lix['branches'][branchId].get_short_description()),
+                                  '{:22}'.format(lix['branches'][branchId].get_bitbake_branch())
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'layerItems':
+                logger.plain ('%s %s' % ('{:26}'.format('layer'), '{:34}'.format('description')))
+                logger.plain ('{:-^80}'.format(""))
+                for layerId in lix['layerItems']:
+                    output.append('%s %s' % (
+                                  '{:26}'.format(lix['layerItems'][layerId].get_name()),
+                                  '{:34}'.format(lix['layerItems'][layerId].get_summary())
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'layerBranches':
+                logger.plain ('%s %s %s' % ('{:26}'.format('layer'), '{:34}'.format('description'), '{:19}'.format('collection:version')))
+                logger.plain ('{:-^80}'.format(""))
+                for layerBranchId in lix['layerBranches']:
+                    output.append('%s %s %s' % (
+                                  '{:26}'.format(lix['layerBranches'][layerBranchId].get_layer().get_name()),
+                                  '{:34}'.format(lix['layerBranches'][layerBranchId].get_layer().get_summary()),
+                                  '{:19}'.format("%s:%s" %
+                                                          (lix['layerBranches'][layerBranchId].get_collection(),
+                                                           lix['layerBranches'][layerBranchId].get_version())
+                                                )
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'layerDependencies':
+                logger.plain ('%s %s %s %s' % ('{:19}'.format('branch'), '{:26}'.format('layer'), '{:11}'.format('dependency'), '{:26}'.format('layer')))
+                logger.plain ('{:-^80}'.format(""))
+                for layerDependency in lix['layerDependencies']:
+                    if not lix['layerDependencies'][layerDependency].get_dependency_layerBranch():
+                        continue
+
+                    output.append('%s %s %s %s' % (
+                                  '{:19}'.format(lix['layerDependencies'][layerDependency].get_layerbranch().get_branch().get_name()),
+                                  '{:26}'.format(lix['layerDependencies'][layerDependency].get_layerbranch().get_layer().get_name()),
+                                  '{:11}'.format('requires' if lix['layerDependencies'][layerDependency].is_required() else 'recommends'),
+                                  '{:26}'.format(lix['layerDependencies'][layerDependency].get_dependency_layerBranch().get_layer().get_name())
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'recipes':
+                logger.plain ('%s %s %s' % ('{:20}'.format('recipe'), '{:10}'.format('version'), 'layer'))
+                logger.plain ('{:-^80}'.format(""))
+                output = []
+                for recipe in lix['recipes']:
+                    output.append('%s %s %s' % (
+                                  '{:30}'.format(lix['recipes'][recipe].get_pn()),
+                                  '{:30}'.format(lix['recipes'][recipe].get_pv()),
+                                  lix['recipes'][recipe].get_layer().get_name()
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'machines':
+                logger.plain ('%s %s %s' % ('{:24}'.format('machine'), '{:34}'.format('description'), '{:19}'.format('layer')))
+                logger.plain ('{:-^80}'.format(""))
+                for machine in lix['machines']:
+                    output.append('%s %s %s' % (
+                                  '{:24}'.format(lix['machines'][machine].get_name()),
+                                  ('{:34}'.format(lix['machines'][machine].get_description()))[:34],
+                                  '{:19}'.format(lix['machines'][machine].get_layerbranch().get_layer().get_name() )
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'distros':
+                logger.plain ('%s %s %s' % ('{:24}'.format('distro'), '{:34}'.format('description'), '{:19}'.format('layer')))
+                logger.plain ('{:-^80}'.format(""))
+                for distro in lix['distros']:
+                    output.append('%s %s %s' % (
+                                  '{:24}'.format(lix['distros'][distro].get_name()),
+                                  ('{:34}'.format(lix['distros'][distro].get_description()))[:34],
+                                  '{:19}'.format(lix['distros'][distro].get_layerbranch().get_layer().get_name() )
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+        logger.plain ('')
+
+# Define enough of the layer index types so we can easily resolve them...
+# It is up to the loaders to create the classes from the raw data
+class LayerIndexItem():
+    def __init__(self, index, data):
+        self.index = index
+        self.data = data
+
+    def __eq__(self, other):
+        if self.__class__ != other.__class__:
+            return False
+        res=(self.data == other.data)
+        logger.debug(2, 'Compare objects: %s ? %s : %s' % (self.get_id(), other.get_id(), res))
+        return res
+
+    def define_data(self, id):
+        self.data = {}
+        self.data['id'] = id
+
+    def get_id(self):
+        return self.data['id']
+
+
+class Branch(LayerIndexItem):
+    def define_data(self, id, name, bitbake_branch,
+                 short_description=None, sort_priority=1,
+                 updates_enabled=True, updated=None,
+                 update_environment=None):
+        self.data = {}
+        self.data['id'] = id
+        self.data['name'] = name
+        self.data['bitbake_branch'] = bitbake_branch
+        self.data['short_description'] = short_description or name
+        self.data['sort_priority'] = sort_priority
+        self.data['updates_enabled'] = updates_enabled
+        self.data['updated'] = updated or datetime.datetime.today().isoformat()
+        self.data['update_environment'] = update_environment
+
+    def get_name(self):
+        return self.data['name']
+
+    def get_short_description(self):
+        return self.data['short_description'].strip()
+
+    def get_bitbake_branch(self):
+        return self.data['bitbake_branch'] or self.get_name()
+
+
+class LayerItem(LayerIndexItem):
+    def define_data(self, id, name, status='P',
+                 layer_type='A', summary=None,
+                 description=None,
+                 vcs_url=None, vcs_web_url=None,
+                 vcs_web_tree_base_url=None,
+                 vcs_web_file_base_url=None,
+                 usage_url=None,
+                 mailing_list_url=None,
+                 index_preference=1,
+                 classic=False,
+                 updated=None):
+        self.data = {}
+        self.data['id'] = id
+        self.data['name'] = name
+        self.data['status'] = status
+        self.data['layer_type'] = layer_type
+        self.data['summary'] = summary or name
+        self.data['description'] = description or summary or name
+        self.data['vcs_url'] = vcs_url
+        self.data['vcs_web_url'] = vcs_web_url
+        self.data['vcs_web_tree_base_url'] = vcs_web_tree_base_url
+        self.data['vcs_web_file_base_url'] = vcs_web_file_base_url
+        self.data['index_preference'] = index_preference
+        self.data['classic'] = classic
+        self.data['updated'] = updated or datetime.datetime.today().isoformat()
+
+    def get_name(self):
+        return self.data['name']
+
+    def get_summary(self):
+        return self.data['summary']
+
+    def get_description(self):
+        return self.data['description'].strip()
+
+    def get_vcs_url(self):
+        return self.data['vcs_url']
+
+    def get_vcs_web_url(self):
+        return self.data['vcs_web_url']
+
+    def get_vcs_web_tree_base_url(self):
+        return self.data['vcs_web_tree_base_url']
+
+    def get_vcs_web_file_base_url(self):
+        return self.data['vcs_web_file_base_url']
+
+    def get_updated(self):
+        return self.data['updated']
+
+class LayerBranch(LayerIndexItem):
+    def define_data(self, id, collection, version, layer, branch,
+                 vcs_subdir="", vcs_last_fetch=None,
+                 vcs_last_rev=None, vcs_last_commit=None,
+                 actual_branch="",
+                 updated=None):
+        self.data = {}
+        self.data['id'] = id
+        self.data['collection'] = collection
+        self.data['version'] = version
+        self.data['layer'] = layer
+        self.data['branch'] = branch
+        self.data['vcs_subdir'] = vcs_subdir
+        self.data['vcs_last_fetch'] = vcs_last_fetch
+        self.data['vcs_last_rev'] = vcs_last_rev
+        self.data['vcs_last_commit'] = vcs_last_commit
+        self.data['actual_branch'] = actual_branch
+        self.data['updated'] = updated or datetime.datetime.today().isoformat()
+
+    def get_collection(self):
+        return self.data['collection']
+
+    def get_version(self):
+        return self.data['version']
+
+    def get_vcs_subdir(self):
+        return self.data['vcs_subdir']
+
+    def get_actual_branch(self):
+        return self.data['actual_branch'] or self.get_branch().get_name()
+
+    def get_updated(self):
+        return self.data['updated']
+
+    def get_layer_id(self):
+        return self.data['layer']
+
+    def get_branch_id(self):
+        return self.data['branch']
+
+    def get_layer(self):
+        layerItem = None
+        try:
+            layerItem = self.index['layerItems'][self.get_layer_id()]
+        except KeyError:
+            logger.error('Unable to find layerItems in index')
+        except IndexError:
+            logger.error('Unable to find layerId %s' % self.get_layer_id())
+        return layerItem
+
+    def get_branch(self):
+        branch = None
+        try:
+            branch = self.index['branches'][self.get_branch_id()]
+        except KeyError:
+            logger.error('Unable to find branches in index: %s' % self.index.keys())
+        except IndexError:
+            logger.error('Unable to find branchId %s' % self.get_branch_id())
+        return branch
+
+
+class LayerIndexItem_LayerBranch(LayerIndexItem):
+    def get_layerbranch_id(self):
+        return self.data['layerbranch']
+
+    def get_layerbranch(self):
+        layerBranch = None
+        try:
+            layerBranch = self.index['layerBranches'][self.get_layerbranch_id()]
+        except KeyError:
+            logger.error('Unable to find layerBranches in index')
+        except IndexError:
+            logger.error('Unable to find layerBranchId %s' % self.get_layerbranch_id())
+        return layerBranch
+
+    def get_layer_id(self):
+        layerBranch = self.get_layerbranch()
+        if layerBranch:
+            return layerBranch.get_layer_id()
+        return None
+
+    def get_layer(self):
+        layerBranch = self.get_layerbranch()
+        if layerBranch:
+            return layerBranch.get_layer()
+        return None
+
+class LayerDependency(LayerIndexItem_LayerBranch):
+    def define_data(self, id, layerbranch, dependency, required=True):
+        self.data = {}
+        self.data['id'] = id
+        self.data['layerbranch'] = layerbranch
+        self.data['dependency'] = dependency
+        self.data['required'] = required
+
+    def is_required(self):
+        return self.data['required']
+
+    def get_dependency_id(self):
+        return self.data['dependency']
+
+    def get_dependency_layer(self):
+        layerItem = None
+        try:
+            layerItem = self.index['layerItems'][self.get_dependency_id()]
+        except KeyError:
+            logger.error('Unable to find layerItems in index')
+        except IndexError:
+            logger.error('Unable to find layerId %s' % self.get_dependency_id())
+        return layerItem
+
+    def get_dependency_layerBranch(self):
+        layerBranch = None
+        try:
+            layerId = self.get_dependency_id()
+            branchId = self.get_layerbranch().get_branch_id()
+            layerBranch = self.index['layerBranches_layerId_branchId']["%s:%s" % (layerId, branchId)]
+        except KeyError:
+            logger.warning('Unable to find layerBranches_layerId_branchId in index')
+
+            # We don't have a quick lookup index, doing it the slower way...
+            layerId = self.get_dependency_id()
+            branchId = self.get_layerbranch().get_branch_id()
+            for layerBranchId in self.index['layerBranches']:
+                layerBranch = self.index['layerBranches'][layerBranchId]
+                if layerBranch.get_layer_id() == layerId and \
+                   layerBranch.get_branch_id() == branchId:
+                    break
+            else:
+                logger.error("LayerBranch not found layerId %s -- BranchId %s" % (layerId, branchId))
+                layerBranch = None
+        except IndexError:
+            logger.error("LayerBranch not found layerId %s -- BranchId %s" % (layerId, branchId))
+
+        return layerBranch
+
+
+class Recipe(LayerIndexItem_LayerBranch):
+    def define_data(self, id,
+                    filename, filepath, pn, pv, layerbranch,
+                    summary="", description="", section="", license="",
+                    homepage="", bugtracker="", provides="", bbclassextend="",
+                    inherits="", blacklisted="", updated=None):
+        self.data = {}
+        self.data['id'] = id
+        self.data['filename'] = filename
+        self.data['filepath'] = filepath
+        self.data['pn'] = pn
+        self.data['pv'] = pv
+        self.data['summary'] = summary
+        self.data['description'] = description
+        self.data['section'] = section
+        self.data['license'] = license
+        self.data['homepage'] = homepage
+        self.data['bugtracker'] = bugtracker
+        self.data['provides'] = provides
+        self.data['bbclassextend'] = bbclassextend
+        self.data['inherits'] = inherits
+        self.data['updated'] = updated or datetime.datetime.today().isoformat()
+        self.data['blacklisted'] = blacklisted
+        self.data['layerbranch'] = layerbranch
+
+    def get_filename(self):
+        return self.data['filename']
+
+    def get_filepath(self):
+        return self.data['filepath']
+
+    def get_fullpath(self):
+        return os.path.join(self.data['filepath'], self.data['filename'])
+
+    def get_summary(self):
+        return self.data['summary']
+
+    def get_description(self):
+        return self.data['description'].strip()
+
+    def get_section(self):
+        return self.data['section']
+
+    def get_pn(self):
+        return self.data['pn']
+
+    def get_pv(self):
+        return self.data['pv']
+
+    def get_license(self):
+        return self.data['license']
+
+    def get_homepage(self):
+        return self.data['homepage']
+
+    def get_bugtracker(self):
+        return self.data['bugtracker']
+
+    def get_provides(self):
+        return self.data['provides']
+
+    def get_updated(self):
+        return self.data['updated']
+
+    def get_inherits(self):
+        if 'inherits' not in self.data:
+            # Older indexes may not have this, so emulate it
+            if '-image-' in self.get_pn():
+                return 'image'
+        return self.data['inherits']
+
+
+class Machine(LayerIndexItem_LayerBranch):
+    def define_data(self, id,
+                    name, description, layerbranch,
+                    updated=None):
+        self.data = {}
+        self.data['id'] = id
+        self.data['name'] = name
+        self.data['description'] = description
+        self.data['layerbranch'] = layerbranch
+        self.data['updated'] = updated or datetime.datetime.today().isoformat()
+
+    def get_name(self):
+        return self.data['name']
+
+    def get_description(self):
+        return self.data['description'].strip()
+
+    def get_updated(self):
+        return self.data['updated']
+
+class Distro(LayerIndexItem_LayerBranch):
+    def define_data(self, id,
+                    name, description, layerbranch,
+                    updated=None):
+        self.data = {}
+        self.data['id'] = id
+        self.data['name'] = name
+        self.data['description'] = description
+        self.data['layerbranch'] = layerbranch
+        self.data['updated'] = updated or datetime.datetime.today().isoformat()
+
+    def get_name(self):
+        return self.data['name']
+
+    def get_description(self):
+        return self.data['description'].strip()
+
+    def get_updated(self):
+        return self.data['updated']
+
+# When performing certain actions, we may need to sort the data.
+# This will allow us to keep it consistent from run to run.
+def sort_entry(item):
+    newitem = item
+    try:
+        if type(newitem) == type(dict()):
+            newitem = OrderedDict(sorted(newitem.items(), key=lambda t: t[0]))
+            for index in newitem:
+                newitem[index] = sort_entry(newitem[index])
+        elif type(newitem) == type(list()):
+            newitem.sort(key=lambda obj: obj['id'])
+            for index, _ in enumerate(newitem):
+                newitem[index] = sort_entry(newitem[index])
+    except:
+        logger.error('Sort failed for item %s' % type(item))
+        pass
+
+    return newitem
diff --git a/lib/layerindexlib/common.py b/lib/layerindexlib/common.py
new file mode 100644
index 0000000..b895916
--- /dev/null
+++ b/lib/layerindexlib/common.py
@@ -0,0 +1,161 @@
+# Copyright (C) 2016-2018 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+# The file contains:
+#   LayerIndex exceptions
+#   Plugin base class
+#   Utility Functions for working on layerindex data
+
+import argparse
+import logging
+import os
+import bb.msg
+
+logger = logging.getLogger('BitBake.layerindexlib.common')
+
+class LayerIndexError(Exception):
+    """LayerIndex loading error"""
+    def __init__(self, message):
+         self.msg = message
+         Exception.__init__(self, message)
+
+    def __str__(self):
+         return self.msg
+
+class IndexPlugin():
+    def __init__(self):
+        self.type = None
+
+    def init(self, lindex):
+        self.lindex = lindex
+
+    def plugin_type(self):
+        return self.type
+
+    def load_index(self, uri):
+        raise NotImplementedError('load_index is not implemented')
+
+    def store_index(self, uri):
+        raise NotImplementedError('store_index is not implemented')
+
+# The following are some basic utility function used by the layerindex
+
+def fetch_url(url, username=None, password=None, debuglevel=0):
+    """
+        Fetch something from a specific URL.  This is specifically designed to
+        fetch data from a layer index.
+
+        It is not designed to be used to fetch recipe sources or similar, the
+        regular fetcher is designed for that.
+
+        TODO: Handle BB_NO_NETWORK or allowed hosts, etc.
+    """
+
+    assert url is not None
+
+    import urllib
+    from urllib.request import urlopen, Request
+    from urllib.parse import urlparse
+
+    up = urlparse(url)
+
+    if username:
+        logger.debug(1, "Configuring authentication for %s..." % url)
+        password_mgr = urllib.request.HTTPPasswordMgrWithDefaultRealm()
+        password_mgr.add_password(None, "%s://%s" % (up.scheme, up.netloc), username, password)
+        handler = urllib.request.HTTPBasicAuthHandler(password_mgr)
+        opener = urllib.request.build_opener(handler, urllib.request.HTTPSHandler(debuglevel=debuglevel))
+    else:
+        opener = urllib.request.build_opener(urllib.request.HTTPSHandler(debuglevel=debuglevel))
+
+    urllib.request.install_opener(opener)
+
+    logger.debug(1, "Fetching %s (%s)..." % (url, ["without authentication", "with authentication"][not not username]))
+
+    try:
+        res = urlopen(Request(url, headers={'User-Agent': 'Mozilla/5.0 (bitbake/lib/layerindex)'}, unverifiable=True))
+    except urllib.error.HTTPError as e:
+        logger.debug(1, "HTTP Error: %s: %s" % (e.code, e.reason))
+        logger.debug(1, " Requested: %s" % (url))
+        logger.debug(1, " Actual:    %s" % (e.geturl()))
+
+        if e.code == 404:
+            logger.debug(1, "Request not found.")
+            raise bb.fetch2.FetchError(e)
+        else:
+            logger.debug(1, "Headers:\n%s" % (e.headers))
+            raise bb.fetch2.FetchError(e)
+    except OSError as e:
+        error = 0
+        reason = ""
+
+        # Process base OSError first...
+        if hasattr(e, 'errno'):
+            error = e.errno
+            reason = e.strerror
+
+        # Process gaierror (socket error) subclass if available.
+        if hasattr(e, 'reason') and hasattr(e.reason, 'errno') and hasattr(e.reason, 'strerror'):
+            error = e.reason.errno
+            reason = e.reason.strerror
+            if error == -2:
+                raise bb.fetch2.FetchError(e)
+
+        if error and error != 0:
+            raise bb.fetch2.FetchError("Unable to fetch %s due to exception: [Error %s] %s" % (url, error, reason))
+        else:
+            raise bb.fetch2.FetchError("Unable to fetch %s due to OSError exception: %s" % (url, e))
+
+    finally:
+        logger.debug(1, "...fetching %s (%s), done." % (url, ["without authentication", "with authentication"][not not username]))
+
+    return res
+
+def add_raw_element(lName, lType, rawObjs, lindex):
+    """
+        Add a raw object of type lType to lindex[lname]
+    """
+    if lName not in rawObjs:
+        logger.debug(1, '%s not in loaded index' % lName)
+        return lindex
+
+    if lName not in lindex:
+        lindex[lName] = {}
+
+    for entry in rawObjs[lName]:
+        obj = lType(lindex, entry)
+        if obj.get_id() in lindex[lName]:
+            if lindex[lName][obj.get_id()] == obj:
+                continue
+            raise Exception('Conflict adding object %s(%s)' % (lName, obj.get_id()))
+        lindex[lName][obj.get_id()] = obj
+
+    return lindex
+
+def add_element(lName, Objs, lindex):
+    """
+        Add a layer index object to lindex[lName]
+    """
+    if lName not in lindex:
+        lindex[lName] = {}
+
+    for obj in Objs:
+        if obj.get_id() in lindex[lName]:
+            if lindex[lName][obj.get_id()] == obj:
+                continue
+            raise Exception('Conflict adding object %s(%s)' % (lName, obj.get_id()))
+        lindex[lName][obj.get_id()] = obj
+
+    return lindex
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
new file mode 100644
index 0000000..bdd37b0
--- /dev/null
+++ b/lib/layerindexlib/cooker.py
@@ -0,0 +1,338 @@
+# Copyright (C) 2016-2018 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+import logging
+import json
+
+from collections import OrderedDict, defaultdict
+
+from urllib.parse import unquote
+
+import layerindexlib
+
+from layerindexlib.common import IndexPlugin
+from layerindexlib.common import LayerIndexError
+from layerindexlib.common import add_element
+
+logger = logging.getLogger('BitBake.layerindexlib.cooker')
+
+import bb.utils
+
+def plugin_init(plugins):
+    return CookerPlugin()
+
+class CookerPlugin(IndexPlugin):
+    def __init__(self):
+        self.type = "cooker"
+        self.server_connection = None
+        self.ui_module = None
+        self.server = None
+
+    def _run_command(self, command, path, default=None):
+        try:
+            result, _ = bb.process.run(command, cwd=path)
+            result = result.strip()
+        except bb.process.ExecutionError:
+            result = default
+        return result
+
+    def _handle_git_remote(self, remote):
+        if "://" not in remote:
+            if ':' in remote:
+                # This is assumed to be ssh
+                remote = "ssh://" + remote
+            else:
+                # This is assumed to be a file path
+                remote = "file://" + remote
+        return remote
+
+    def _get_bitbake_info(self):
+        """Return a tuple of bitbake information"""
+
+        # Our path SHOULD be .../bitbake/lib/layerindex/cooker.py
+        bb_path = os.path.dirname(__file__) # .../bitbake/lib/layerindex/cooker.py
+        bb_path = os.path.dirname(bb_path)  # .../bitbake/lib/layerindex
+        bb_path = os.path.dirname(bb_path)  # .../bitbake/lib
+        bb_path = os.path.dirname(bb_path)  # .../bitbake
+        bb_path = self._run_command('git rev-parse --show-toplevel', os.path.dirname(__file__), default=bb_path)
+        bb_branch = self._run_command('git rev-parse --abbrev-ref HEAD', bb_path, default="<unknown>")
+        bb_rev = self._run_command('git rev-parse HEAD', bb_path, default="<unknown>")
+        for remotes in self._run_command('git remote -v', bb_path, default="").split("\n"):
+            remote = remotes.split("\t")[1].split(" ")[0]
+            if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
+                bb_remote = self._handle_git_remote(remote)
+                break
+        else:
+            bb_remote = self._handle_git_remote(bb_path)
+
+        return (bb_remote, bb_branch, bb_rev, bb_path)
+
+    def _load_bblayers(self, branches=None):
+        """Load the BBLAYERS and related collection information"""
+
+        d = self.lindex.data
+
+        if not branches:
+            branches = d.getVar('LAYERSERIES_CORENAMES') or "HEAD"
+
+        index = {}
+
+        branchId = 0
+        index['branches'] = {}
+
+        layerItemId = 0
+        index['layerItems'] = {}
+
+        layerBranchId = 0
+        index['layerBranches'] = {}
+
+        bblayers = d.getVar('BBLAYERS').split()
+
+        if not bblayers:
+            # It's blank!  Nothing to process...
+            return index
+
+        collections = d.getVar('BBFILE_COLLECTIONS')
+        layerconfs = d.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', d)
+        bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.items()}
+
+        (_, bb_branch, _, _) = self._get_bitbake_info()
+
+        for branch in branches.split():
+            branchId += 1
+            index['branches'][branchId] = layerindexlib.Branch(index, None)
+            index['branches'][branchId].define_data(branchId, branch, bb_branch)
+
+        for entry in collections.split():
+            layerpath = entry
+            if entry in bbfile_collections:
+                layerpath = bbfile_collections[entry]
+
+            layername = d.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % entry) or os.path.basename(layerpath)
+            layerversion = d.getVar('LAYERVERSION_%s' % entry) or ""
+            layerurl = self._handle_git_remote(layerpath)
+
+            layersubdir = ""
+            layerrev = "<unknown>"
+            layerbranch = "<unknown>"
+
+            if os.path.isdir(layerpath):
+                layerbasepath = self._run_command('git rev-parse --show-toplevel', layerpath, default=layerpath)
+                if os.path.abspath(layerpath) != os.path.abspath(layerbasepath):
+                    layersubdir = os.path.abspath(layerpath)[len(layerbasepath) + 1:]
+
+                layerbranch = self._run_command('git rev-parse --abbrev-ref HEAD', layerpath, default="<unknown>")
+                layerrev = self._run_command('git rev-parse HEAD', layerpath, default="<unknown>")
+
+                for remotes in self._run_command('git remote -v', layerpath, default="").split("\n"):
+                    remote = remotes.split("\t")[1].split(" ")[0]
+                    if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
+                        layerurl = self._handle_git_remote(remote)
+                        break
+
+            layerItemId += 1
+            index['layerItems'][layerItemId] = layerindexlib.LayerItem(index, None)
+            index['layerItems'][layerItemId].define_data(layerItemId, layername, description=layerpath, vcs_url=layerurl)
+
+            for branchId in index['branches']:
+                layerBranchId += 1
+                index['layerBranches'][layerBranchId] = layerindexlib.LayerBranch(index, None)
+                index['layerBranches'][layerBranchId].define_data(layerBranchId, entry, layerversion, layerItemId, branchId,
+                                               vcs_subdir=layersubdir, vcs_last_rev=layerrev, actual_branch=layerbranch)
+
+        return index
+
+
+    def load_index(self, ud, load):
+        """
+            Fetches layer information from a build configuration.
+
+            The return value is a dictionary containing API,
+            layer, branch, dependency, recipe, machine, distro, information.
+
+            ud path is ignored.
+        """
+
+        if ud.type != 'file':
+            raise bb.fetch2.FetchError('%s is not a supported protocol, only file, http and https are support.')
+
+        d = self.lindex.data
+
+        branches = d.getVar('LAYERSERIES_CORENAMES') or "HEAD"
+        if 'branch' in ud.parm:
+            branches = ' '.join(ud.parm['branch'].split(','))
+
+        logger.debug(1, "Loading cooker data branch %s" % branches)
+
+        lindex = self._load_bblayers(branches=branches)
+
+        lindex['CONFIG'] = {}
+        lindex['CONFIG']['TYPE'] = self.type
+        lindex['CONFIG']['URL'] = ud.url
+
+        if 'desc' in ud.parm:
+            lindex['CONFIG']['DESCRIPTION'] = unquote(ud.parm['desc'])
+        else:
+            lindex['CONFIG']['DESCRIPTION'] = ud.path
+
+        if 'cache' in ud.parm:
+            lindex['CONFIG']['CACHE'] = ud.parm['cache']
+
+        if 'branch' in ud.parm:
+            lindex['CONFIG']['BRANCH'] = ud.parm['branch']
+        else:
+            lindex['CONFIG']['BRANCH'] = d.getVar('LAYERSERIES_CORENAMES') or "HEAD"
+
+        # ("layerDependencies", layerindexlib.LayerDependency)
+        layerDependencyId = 0
+        if "layerDependencies" in load.split():
+            lindex['layerDependencies'] = {}
+            for layerBranchId in lindex['layerBranches']:
+                branchName = lindex['layerBranches'][layerBranchId].get_branch().get_name()
+                collection = lindex['layerBranches'][layerBranchId].get_collection()
+
+                def add_dependency(layerDependencyId, lindex, deps, required):
+                    try:
+                        depDict = bb.utils.explode_dep_versions2(deps)
+                    except bb.utils.VersionStringException as vse:
+                        bb.fatal('Error parsing LAYERDEPENDS_%s: %s' % (c, str(vse)))
+
+                    for dep, oplist in list(depDict.items()):
+                        # We need to search ourselves, so use the _ version...
+                        depLayerBranch = self.lindex._find_collection(lindex, dep, branch=branchName)
+                        if not depLayerBranch:
+                            # Missing dependency?!
+                            logger.error('Missing dependency %s (%s)' % (dep, branchName))
+                            continue
+
+                        # We assume that the oplist matches...
+                        layerDependencyId += 1
+                        layerDependency = layerindexlib.LayerDependency(lindex, None)
+                        layerDependency.define_data(id=layerDependencyId,
+                                        required=required, layerbranch=layerBranchId,
+                                        dependency=depLayerBranch.get_layer_id())
+
+                        logger.debug(1, '%s requires %s' % (layerDependency.get_layer().get_name(), layerDependency.get_dependency_layer().get_name()))
+                        lindex = add_element("layerDependencies", [layerDependency], lindex)
+
+                    return layerDependencyId
+
+                deps = d.getVar("LAYERDEPENDS_%s" % collection)
+                if deps:
+                    layerDependencyId = add_dependency(layerDependencyId, lindex, deps, True)
+
+                deps = d.getVar("LAYERRECOMMENDS_%s" % collection)
+                if deps:
+                    layerDependencyId = add_dependency(layerDependencyId, lindex, deps, False)
+
+        # Need to load recipes here (requires cooker access)
+        recipeId = 0
+        ## TODO: NOT IMPLEMENTED
+        # The code following this is an example of what needs to be
+        # implemented.  However, it does not work as-is.
+        if False and 'recipes' in load.split():
+            lindex['recipes'] = {}
+
+            ret = self.ui_module.main(self.server_connection.connection, self.server_connection.events, config_params)
+
+            all_versions = self._run_command('allProviders')
+
+            all_versions_list = defaultdict(list, all_versions)
+            for pn in all_versions_list:
+                for ((pe, pv, pr), fpath) in all_versions_list[pn]:
+                    realfn = bb.cache.virtualfn2realfn(fpath)
+
+                    filepath = os.path.dirname(realfn[0])
+                    filename = os.path.basename(realfn[0])
+
+                    # This is all HORRIBLY slow, and likely unnecessary
+                    #dscon = self._run_command('parseRecipeFile', fpath, False, [])
+                    #connector = myDataStoreConnector(self, dscon.dsindex)
+                    #recipe_data = bb.data.init()
+                    #recipe_data.setVar('_remote_data', connector)
+
+                    #summary = recipe_data.getVar('SUMMARY')
+                    #description = recipe_data.getVar('DESCRIPTION')
+                    #section = recipe_data.getVar('SECTION')
+                    #license = recipe_data.getVar('LICENSE')
+                    #homepage = recipe_data.getVar('HOMEPAGE')
+                    #bugtracker = recipe_data.getVar('BUGTRACKER')
+                    #provides = recipe_data.getVar('PROVIDES')
+
+                    layer = bb.utils.get_file_layer(realfn[0], self.config_data)
+
+                    depBranchId = collection_layerbranch[layer]
+
+                    recipeId += 1
+                    recipe = layerindexlib.Recipe(lindex, None)
+                    recipe.define_data(id=recipeId,
+                                   filename=filename, filepath=filepath,
+                                   pn=pn, pv=pv,
+                                   summary=pn, description=pn, section='?',
+                                   license='?', homepage='?', bugtracker='?',
+                                   provides='?', bbclassextend='?', inherits='?',
+                                   blacklisted='?', layerbranch=depBranchId)
+
+                    lindex = addElement("recipes", [recipe], lindex)
+
+        # ("machines", layerindexlib.Machine)
+        machineId = 0
+        if 'machines' in load.split():
+            lindex['machines'] = {}
+
+            for layerBranchId in lindex['layerBranches']:
+                # load_bblayers uses the description to cache the actual path...
+                machine_path = lindex['layerBranches'][layerBranchId].getDescription()
+                machine_path = os.path.join(machine_path, 'conf/machine')
+                if os.path.isdir(machine_path):
+                    for (dirpath, _, filenames) in os.walk(machine_path):
+                        # Ignore subdirs...
+                        if not dirpath.endswith('conf/machine'):
+                            continue
+                        for fname in filenames:
+                            if fname.endswith('.conf'):
+                                machineId += 1
+                                machine = layerindexlib.Machine(lindex, None)
+                                machine.define_data(id=machineId, name=fname[:-5],
+                                                    description=fname[:-5],
+                                                    layerbranch=collection_layerbranch[entry])
+
+                                lindex = add_element("machines", [machine], lindex)
+
+        # ("distros", layerindexlib.Distro)
+        distroId = 0
+        if 'distros' in load.split():
+            lindex['distros'] = {}
+
+            for layerBranchId in lindex['layerBranches']:
+                # load_bblayers uses the description to cache the actual path...
+                distro_path = lindex['layerBranches'][layerBranchId].getDescription()
+                distro_path = os.path.join(distro_path, 'conf/distro')
+                if os.path.isdir(distro_path):
+                    for (dirpath, _, filenames) in os.walk(distro_path):
+                        # Ignore subdirs...
+                        if not dirpath.endswith('conf/distro'):
+                            continue
+                        for fname in filenames:
+                            if fname.endswith('.conf'):
+                                distroId += 1
+                                distro = layerindexlib.Distro(lindex, None)
+                                distro.define_data(id=distroId, name=fname[:-5],
+                                                    description=fname[:-5],
+                                                    layerbranch=collection_layerbranch[entry])
+
+                                lindex = add_element("distros", [distro], lindex)
+
+        return lindex
diff --git a/lib/layerindexlib/restapi.py b/lib/layerindexlib/restapi.py
new file mode 100644
index 0000000..fde32d2
--- /dev/null
+++ b/lib/layerindexlib/restapi.py
@@ -0,0 +1,375 @@
+# Copyright (C) 2016-2018 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+import logging
+import bb.fetch2
+import json
+from urllib.parse import unquote
+
+import layerindexlib
+
+from layerindexlib.common import IndexPlugin
+from layerindexlib.common import fetch_url
+from layerindexlib.common import LayerIndexError
+from layerindexlib.common import add_raw_element
+
+logger = logging.getLogger('BitBake.layerindexlib.restapi')
+
+def plugin_init(plugins):
+    return RestApiPlugin()
+
+class RestApiPlugin(IndexPlugin):
+    def __init__(self):
+        self.type = "restapi"
+
+    def load_index(self, ud, load):
+        """
+            Fetches layer information from a local or remote layer index.
+
+            The return value is a dictionary containing API,
+            layer, branch, dependency, recipe, machine, distro, information.
+
+            url is the url to the rest api of the layer index, such as:
+            http://layers.openembedded.org/layerindex/api/
+
+            Or a local file...
+        """
+
+        if ud.type == 'file':
+            return self.load_index_file(ud, load)
+
+        if ud.type == 'http' or ud.type == 'https':
+            return self.load_index_web(ud, load)
+
+        raise bb.fetch2.FetchError('%s is not a supported protocol, only file, http and https are support.')
+
+
+    def load_index_file(self, ud, load):
+        """
+            Fetches layer information from a local file or directory.
+            The return value is a dictionary containing API,
+            layer, branch, dependency, recipe, machine, distro,
+            and template information.
+
+            ud is the parsed url to the local file or directory.
+        """
+        if not os.path.exists(ud.path):
+            raise FileNotFoundError(ud.path)
+
+        lindex = {}
+
+        lindex['CONFIG'] = {}
+        lindex['CONFIG']['TYPE'] = self.type
+        lindex['CONFIG']['URL'] = ud.url
+
+        if 'desc' in ud.parm:
+            lindex['CONFIG']['DESCRIPTION'] = unquote(ud.parm['desc'])
+        else:
+            lindex['CONFIG']['DESCRIPTION'] = ud.path
+
+        if 'cache' in ud.parm:
+            lindex['CONFIG']['CACHE'] = ud.parm['cache']
+
+        branches = None
+        if 'branch' in ud.parm:
+            branches = ud.parm['branch']
+            lindex['CONFIG']['BRANCH'] = branches
+
+
+        def load_cache(path, lindex, branches=None):
+            logger.debug(1, 'Loading json file %s' % path)
+            with open(path, 'rt', encoding='utf-8') as f:
+                pindex = json.load(f)
+
+            # Filter the branches on loaded files...
+            newpBranch = []
+            if branches:
+                for branch in (branches or "").split(','):
+                    if 'branches' in pindex:
+                        for br in pindex['branches']:
+                            if br['name'] == branch:
+                                newpBranch.append(br)
+            else:
+                if 'branches' in pindex:
+                    newpBranch = pindex['branches']
+
+            if newpBranch:
+                lindex = add_raw_element('branches', layerindexlib.Branch, { 'branches' : newpBranch }, lindex)
+            else:
+                logger.debug(1, 'No matching branchs (%s) in index file(s)' % branches)
+                # No matching branches.. return nothing...
+                return
+
+            for (lName, lType) in [("layerItems", layerindexlib.LayerItem),
+                                   ("layerBranches", layerindexlib.LayerBranch),
+                                   ("layerDependencies", layerindexlib.LayerDependency),
+                                   ("recipes", layerindexlib.Recipe),
+                                   ("machines", layerindexlib.Machine),
+                                   ("distros", layerindexlib.Distro)]:
+                if lName in pindex:
+                    lindex = add_raw_element(lName, lType, pindex, lindex)
+
+
+        if not os.path.isdir(ud.path):
+            load_cache(ud.path, lindex, branches)
+            return lindex
+
+        logger.debug(1, 'Loading from dir %s...' % (ud.path))
+        for (dirpath, _, filenames) in os.walk(ud.path):
+            for filename in filenames:
+                if not filename.endswith('.json'):
+                    continue
+                fpath = os.path.join(dirpath, filename)
+                load_cache(fpath, lindex, branches)
+
+        return lindex
+
+
+    def load_index_web(self, ud, load):
+        """
+            Fetches layer information from a remote layer index.
+            The return value is a dictionary containing API,
+            layer, branch, dependency, recipe, machine, distro,
+            and template information.
+
+            ud is the parsed url to the rest api of the layer index, such as:
+            http://layers.openembedded.org/layerindex/api/
+        """
+
+        def _get_json_response(apiurl=None, username=None, password=None, retry=True):
+            assert apiurl is not None
+
+            logger.debug(1, "fetching %s" % apiurl)
+
+            res = fetch_url(apiurl, username=username, password=password)
+
+            try:
+                parsed = json.loads(res.read().decode('utf-8'))
+            except ConnectionResetError:
+                if retry:
+                    logger.debug(1, "%s: Connection reset by peer.  Retrying..." % url)
+                    parsed = _get_json_response(apiurl=apiurl, username=username, password=password, retry=False)
+                    logger.debug(1, "%s: retry successful.")
+                else:
+                    raise bb.fetch2.FetchError('%s: Connection reset by peer.  Is there a firewall blocking your connection?' % apiurl)
+
+            return parsed
+
+        lindex = {}
+
+        lindex['CONFIG'] = {}
+        lindex['CONFIG']['TYPE'] = self.type
+        lindex['CONFIG']['URL'] = ud.url
+
+        if 'desc' in ud.parm:
+            lindex['CONFIG']['DESCRIPTION'] = unquote(ud.parm['desc'])
+        else:
+            lindex['CONFIG']['DESCRIPTION'] = ud.host
+
+        if 'cache' in ud.parm:
+            lindex['CONFIG']['CACHE'] = ud.parm['cache']
+
+        if 'branch' in ud.parm:
+            lindex['CONFIG']['BRANCH'] = ud.parm['branch']
+
+        try:
+            lindex['apilinks'] = _get_json_response(bb.fetch2.encodeurl( (ud.type, ud.host, ud.path, None, None, None) ),
+                                                    username=ud.user, password=ud.pswd)
+        except Exception as e:
+            raise LayerIndexError("Unable to load layer index %s: %s" % (ud.url, e))
+
+        branches = None
+        if 'branch' in ud.parm and ud.parm['branch']:
+            branches = ud.parm['branch']
+
+
+        # Local raw index set...
+        pindex = {}
+
+        # Load the branches element
+        filter = ""
+        if branches:
+            filter = "?filter=name:%s" % branches
+
+        logger.debug(1, "Loading %s from %s" % ('branches', lindex['apilinks']['branches']))
+        pindex['branches'] = _get_json_response(lindex['apilinks']['branches'] + filter,
+                                                username=ud.user, password=ud.pswd)
+        if not pindex['branches']:
+            logger.debug(1, "No valid branches (%s) found at url %s." % (branches or "*", ud.url))
+            return lindex
+        lindex = add_raw_element("branches", layerindexlib.Branch, pindex, lindex)
+
+
+        # Load all of the layerItems (these can not be easily filtered)
+        logger.debug(1, "Loading %s from %s" % ('layerItems', lindex['apilinks']['layerItems']))
+        pindex['layerItems'] = _get_json_response(lindex['apilinks']['layerItems'],
+                                                  username=ud.user, password=ud.pswd)
+        if not pindex['layerItems']:
+            logger.debug(1, "No layers were found at url %s." % (ud.url))
+            return lindex
+        lindex = add_raw_element("layerItems", layerindexlib.LayerItem, pindex, lindex)
+
+
+	# From this point on load the contents for each branch.  Otherwise we
+	# could run into a timeout.
+        for branch in lindex['branches']:
+            filter = "?filter=branch__name:%s" % lindex['branches'][branch].get_name()
+
+            logger.debug(1, "Loading %s from %s" % ('layerBranches', lindex['apilinks']['layerBranches']))
+            pindex['layerBranches'] = _get_json_response(lindex['apilinks']['layerBranches'] + filter,
+                                                  username=ud.user, password=ud.pswd)
+            if not pindex['layerBranches']:
+                logger.debug(1, "No valid layer branches (%s) found at url %s." % (branches or "*", ud.url))
+                return lindex
+            lindex = add_raw_element("layerBranches", layerindexlib.LayerBranch, pindex, lindex)
+
+
+            # Load the rest, they all have a similar format
+            filter = "?filter=layerbranch__branch__name:%s" % lindex['branches'][branch].get_name()
+            for (lName, lType) in [("layerDependencies", layerindexlib.LayerDependency),
+                                   ("recipes", layerindexlib.Recipe),
+                                   ("machines", layerindexlib.Machine),
+                                   ("distros", layerindexlib.Distro)]:
+                if lName not in load.split():
+                    continue
+                logger.debug(1, "Loading %s from %s" % (lName, lindex['apilinks'][lName]))
+                pindex[lName] = _get_json_response(lindex['apilinks'][lName] + filter,
+                                            username=ud.user, password=ud.pswd)
+                lindex = add_raw_element(lName, lType, pindex, lindex)
+
+
+        return lindex
+
+    def store_index(self, ud, lindex):
+        """
+            Store layer information into a local file/dir.
+
+            The return value is a dictionary containing API,
+            layer, branch, dependency, recipe, machine, distro, information.
+
+            ud is a parsed url to a directory or file.  If the path is a
+            directory, we will split the files into one file per layer.
+            If the path is to a file (exists or not) the entire DB will be
+            dumped into that one file.
+        """
+
+        if ud.type != 'file':
+            raise NotImplementedError('Writing to anything but a file url is not implemented: %s' % ud.url)
+
+        try:
+            layerBranches = lindex['layerBranches']
+        except KeyError:
+            logger.error('No layerBranches to write.')
+            return
+
+
+        def filter_item(layerBranchId, objects):
+            filtered = []
+            for obj in lindex[objects]:
+                try:
+                    if lindex[objects][obj].get_layerbranch_id() == layerBranchId:
+                       filtered.append(lindex[objects][obj].data)
+                except AttributeError:
+                    logger.debug(1, 'No obj.get_layerbranch_id(): %s' % objects)
+                    # No simple filter method, just include it...
+                    try:
+                        filtered.append(lindex[objects][obj].data)
+                    except AttributeError:
+                        logger.debug(1, 'No obj.data: %s %s' % (objects, type(obj)))
+                        filtered.append(obj)
+            return filtered
+
+
+        # Write out to a single file.
+        # Filter out unnecessary items, then sort as we write for determinism
+        if not os.path.isdir(ud.path):
+            pindex = {}
+
+            pindex['branches'] = []
+            pindex['layerItems'] = []
+            pindex['layerBranches'] = []
+
+            for layerBranchId in layerBranches:
+                if layerBranches[layerBranchId].get_branch().data not in pindex['branches']:
+                    pindex['branches'].append(layerBranches[layerBranchId].get_branch().data)
+
+                if layerBranches[layerBranchId].get_layer().data not in pindex['layerItems']:
+                    pindex['layerItems'].append(layerBranches[layerBranchId].get_layer().data)
+
+                if layerBranches[layerBranchId].data not in pindex['layerBranches']:
+                    pindex['layerBranches'].append(layerBranches[layerBranchId].data)
+
+                for entry in lindex:
+                    # Skip local items, apilinks and items already processed
+                    if entry in lindex['CONFIG']['local'] or \
+                       entry == 'apilinks' or \
+                       entry == 'branches' or \
+                       entry == 'layerBranches' or \
+                       entry == 'layerItems':
+                        continue
+                    if entry not in pindex:
+                        pindex[entry] = []
+                    pindex[entry].extend(filter_item(layerBranchId, entry))
+
+            bb.debug(1, 'Writing index to %s' % ud.path)
+            with open(ud.path, 'wt') as f:
+                json.dump(layerindexlib.sort_entry(pindex), f, indent=4)
+            return
+
+
+        # Write out to a directory one file per layerBranch
+        # Prepare all layer related items, to create a minimal file.
+        # We have to sort the entries as we write so they are deterministic
+        for layerBranchId in layerBranches:
+            pindex = {}
+
+            for entry in lindex:
+                # Skip local items, apilinks and items already processed
+                if entry in lindex['CONFIG']['local'] or \
+                   entry == 'apilinks' or \
+                   entry == 'branches' or \
+                   entry == 'layerBranches' or \
+                   entry == 'layerItems':
+                    continue
+                pindex[entry] = filter_item(layerBranchId, entry)
+
+            # Add the layer we're processing as the first one...
+            pindex['branches'] = [layerBranches[layerBranchId].get_branch().data]
+            pindex['layerItems'] = [layerBranches[layerBranchId].get_layer().data]
+            pindex['layerBranches'] = [layerBranches[layerBranchId].data]
+
+            # We also need to include the layerbranch for any dependencies...
+            for layerDep in pindex['layerDependencies']:
+                layerDependency = layerindexlib.LayerDependency(lindex, layerDep)
+
+                layerItem = layerDependency.get_dependency_layer()
+                layerBranch = layerDependency.get_dependency_layerBranch()
+
+                # We need to avoid duplicates...
+                if layerItem.data not in pindex['layerItems']:
+                    pindex['layerItems'].append(layerItem.data)
+
+                if layerBranch.data not in pindex['layerBranches']:
+                    pindex['layerBranches'].append(layerBranch.data)
+
+            # apply mirroring adjustments here....
+
+            fname = lindex['CONFIG']['DESCRIPTION'] + '__' + pindex['branches'][0]['name'] + '__' + pindex['layerItems'][0]['name']
+            fname = fname.translate(str.maketrans('/ ', '__'))
+            fpath = os.path.join(ud.path, fname)
+
+            bb.debug(1, 'Writing index to %s' % fpath + '.json')
+            with open(fpath + '.json', 'wt') as f:
+                json.dump(layerindexlib.sort_entry(pindex), f, indent=4)
diff --git a/lib/layerindexlib/tests/__init__.py b/lib/layerindexlib/tests/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/layerindexlib/tests/common.py b/lib/layerindexlib/tests/common.py
new file mode 100644
index 0000000..f73bf3d
--- /dev/null
+++ b/lib/layerindexlib/tests/common.py
@@ -0,0 +1,37 @@
+# Copyright (C) 2017-2018 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+import unittest
+import tempfile
+import os
+import bb
+
+import logging
+
+class LayersTest(unittest.TestCase):
+
+    def setUp(self):
+        self.origdir = os.getcwd()
+        self.d = bb.data.init()
+        self.tempdir = tempfile.mkdtemp()
+        self.logger = logging.getLogger("BitBake")
+
+    def tearDown(self):
+        os.chdir(self.origdir)
+        if os.environ.get("BB_TMPDIR_NOCLEAN") == "yes":
+            print("Not cleaning up %s. Please remove manually." % self.tempdir)
+        else:
+            bb.utils.prunedir(self.tempdir)
+
diff --git a/lib/layerindexlib/tests/cooker.py b/lib/layerindexlib/tests/cooker.py
new file mode 100644
index 0000000..b790732
--- /dev/null
+++ b/lib/layerindexlib/tests/cooker.py
@@ -0,0 +1,125 @@
+# Copyright (C) 2018 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+import unittest
+import tempfile
+import os
+import bb
+
+import layerindexlib
+from layerindexlib.tests.common import LayersTest
+
+import logging
+
+class LayerIndexCookerTest(LayersTest):
+
+    def setUp(self):
+        LayersTest.setUp(self)
+
+        # Note this is NOT a comprehensive test of cooker, as we can't easily
+        # configure the test data.  But we can emulate the basics of the layer.conf
+        # files, so that is what we will do.
+
+        new_topdir = os.path.join(os.path.dirname(__file__), "testdata")
+        new_bbpath = os.path.join(new_topdir, "build")
+
+        self.d.setVar('TOPDIR', new_topdir)
+        self.d.setVar('BBPATH', new_bbpath)
+
+        self.d = bb.parse.handle("%s/conf/bblayers.conf" % new_bbpath, self.d, True)
+        for layer in self.d.getVar('BBLAYERS').split():
+            self.d = bb.parse.handle("%s/conf/layer.conf" % layer, self.d, True)
+
+        self.lindex = layerindexlib.LayerIndex(self.d)
+        self.lindex.load_layerindex('file://%s/;type=cooker' % self.tempdir, load='layerDependencies')
+
+    def test_layerindex_is_empty(self):
+        self.assertFalse(self.lindex.is_empty())
+
+    def test_dependency_resolution(self):
+        # Verify depth first searching...
+        (dependencies, invalidnames) = self.lindex.get_dependencies(names='meta-python')
+
+        first = True
+        for deplayerbranch in dependencies:
+            layerBranch = dependencies[deplayerbranch][0]
+            layerDeps = dependencies[deplayerbranch][1:]
+
+            if not first:
+                continue
+
+            first = False
+
+            # Top of the deps should be openembedded-core, since everything depends on it.
+            self.assertEqual(layerBranch.get_layer().get_name(), "openembedded-core")
+
+            # meta-python should cause an openembedded-core dependency, if not assert!
+            for dep in layerDeps:
+                if dep.get_layer().get_name() == 'meta-python':
+                    break
+            else:
+                self.logger.debug(1, "meta-python was not found")
+                self.assetTrue(False)
+
+            # Only check the first element...
+            break
+        else:
+            if first:
+                # Empty list, this is bad.
+                self.logger.debug(1, "Empty list of dependencies")
+                self.assertTrue(False)
+
+            # Last dep should be the requested item
+            layerBranch = dependencies[deplayerbranch][0]
+            self.assertEqual(layerBranch.get_layer().get_name(), "meta-python")
+
+    def test_find_collection(self):
+        def _check(collection, expected):
+            self.logger.debug(1, "Looking for collection %s..." % collection)
+            result = self.lindex.find_collection(collection)
+            if expected:
+                self.assertIsNotNone(result, msg="Did not find %s when it shouldn't be there" % collection)
+            else:
+                self.assertIsNone(result, msg="Found %s when it should be there" % collection)
+
+        tests = [ ('core', True),
+                  ('openembedded-core', False),
+                  ('networking-layer', True),
+                  ('meta-python', True),
+                  ('openembedded-layer', True),
+                  ('notpresent', False) ]
+
+        for collection,result in tests:
+            _check(collection, result)
+
+    def test_get_layerbranch(self):
+        def _check(name, expected):
+            self.logger.debug(1, "Looking for layerbranch %s..." % name)
+            result = self.lindex.get_layerbranch(name)
+            if expected:
+                self.assertIsNotNone(result, msg="Did not find %s when it shouldn't be there" % collection)
+            else:
+                self.assertIsNone(result, msg="Found %s when it should be there" % collection)
+
+        tests = [ ('openembedded-core', True),
+                  ('core', False),
+                  ('networking-layer', True),
+                  ('meta-python', True),
+                  ('openembedded-layer', True),
+                  ('notpresent', False) ]
+
+        for collection,result in tests:
+            _check(collection, result)
+
diff --git a/lib/layerindexlib/tests/layerindex.py b/lib/layerindexlib/tests/layerindex.py
new file mode 100644
index 0000000..0fde894
--- /dev/null
+++ b/lib/layerindexlib/tests/layerindex.py
@@ -0,0 +1,233 @@
+# Copyright (C) 2017-2018 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+import unittest
+import tempfile
+import os
+import bb
+
+from layerindexlib.tests.common import LayersTest
+
+import logging
+
+class LayerObjectTest(LayersTest):
+    def setUp(self):
+        from layerindexlib import Branch, LayerItem, LayerBranch, LayerDependency, Recipe, Machine, Distro
+
+        LayersTest.setUp(self)
+
+        self.index = {}
+
+        branchId = 0
+        layerItemId = 0
+        layerBranchId = 0
+        layerDependencyId = 0
+        recipeId = 0
+        machineId = 0
+        distroId = 0
+
+        self.index['branches'] = {}
+        self.index['layerItems'] = {}
+        self.index['layerBranches'] = {}
+        self.index['layerDependencies'] = {}
+        self.index['recipes'] = {}
+        self.index['machines'] = {}
+        self.index['distros'] = {}
+
+        branchId += 1
+        self.index['branches'][branchId] = Branch(self.index, None)
+        self.index['branches'][branchId].define_data(branchId,
+                                        'test_branch', 'bb_test_branch')
+
+        layerItemId +=1
+        self.index['layerItems'][layerItemId] = LayerItem(self.index, None)
+        self.index['layerItems'][layerItemId].define_data(layerItemId, 'test_layerItem',
+                                        vcs_url='git://git_test_url/test_layerItem')
+
+        layerBranchId +=1
+        self.index['layerBranches'][layerBranchId] = LayerBranch(self.index, None)
+        self.index['layerBranches'][layerBranchId].define_data(layerBranchId,
+                                        'test_collection', '99', layerItemId,
+                                        branchId)
+
+        recipeId += 1
+        self.index['recipes'][recipeId] = Recipe(self.index, None)
+        self.index['recipes'][recipeId].define_data(recipeId, 'test_git.bb',
+                                        'recipes-test', 'test', 'git',
+                                        layerBranchId)
+
+        machineId += 1
+        self.index['machines'][machineId] = Machine(self.index, None)
+        self.index['machines'][machineId].define_data(machineId,
+                                        'test_machine', 'test_machine',
+                                        layerBranchId)
+
+        distroId += 1
+        self.index['distros'][distroId] = Distro(self.index, None)
+        self.index['distros'][distroId].define_data(distroId,
+                                        'test_distro', 'test_distro',
+                                        layerBranchId)
+
+        layerItemId +=1
+        self.index['layerItems'][layerItemId] = LayerItem(self.index, None)
+        self.index['layerItems'][layerItemId].define_data(layerItemId, 'test_layerItem 2',
+                                        vcs_url='git://git_test_url/test_layerItem')
+
+        layerBranchId +=1
+        self.index['layerBranches'][layerBranchId] = LayerBranch(self.index, None)
+        self.index['layerBranches'][layerBranchId].define_data(layerBranchId,
+                                        'test_collection_2', '72', layerItemId,
+                                        branchId, actual_branch='some_other_branch')
+
+        layerDependencyId += 1
+        self.index['layerDependencies'][layerDependencyId] = LayerDependency(self.index, None)
+        self.index['layerDependencies'][layerDependencyId].define_data(layerDependencyId,
+                                        layerBranchId, 1)
+
+        layerDependencyId += 1
+        self.index['layerDependencies'][layerDependencyId] = LayerDependency(self.index, None)
+        self.index['layerDependencies'][layerDependencyId].define_data(layerDependencyId,
+                                        layerBranchId, 1, required=False)
+
+    def test_branch(self):
+        branch = self.index['branches'][1]
+        self.assertEqual(branch.get_id(), 1)
+        self.assertEqual(branch.get_name(), 'test_branch')
+        self.assertEqual(branch.get_short_description(), 'test_branch')
+        self.assertEqual(branch.get_bitbake_branch(), 'bb_test_branch')
+
+    def test_layerItem(self):
+        layerItem = self.index['layerItems'][1]
+        self.assertEqual(layerItem.get_id(), 1)
+        self.assertEqual(layerItem.get_name(), 'test_layerItem')
+        self.assertEqual(layerItem.get_summary(), 'test_layerItem')
+        self.assertEqual(layerItem.get_description(), 'test_layerItem')
+        self.assertEqual(layerItem.get_vcs_url(), 'git://git_test_url/test_layerItem')
+        self.assertEqual(layerItem.get_vcs_web_url(), None)
+        self.assertIsNone(layerItem.get_vcs_web_tree_base_url())
+        self.assertIsNone(layerItem.get_vcs_web_file_base_url())
+        self.assertIsNotNone(layerItem.get_updated())
+
+        layerItem = self.index['layerItems'][2]
+        self.assertEqual(layerItem.get_id(), 2)
+        self.assertEqual(layerItem.get_name(), 'test_layerItem 2')
+        self.assertEqual(layerItem.get_summary(), 'test_layerItem 2')
+        self.assertEqual(layerItem.get_description(), 'test_layerItem 2')
+        self.assertEqual(layerItem.get_vcs_url(), 'git://git_test_url/test_layerItem')
+        self.assertIsNone(layerItem.get_vcs_web_url())
+        self.assertIsNone(layerItem.get_vcs_web_tree_base_url())
+        self.assertIsNone(layerItem.get_vcs_web_file_base_url())
+        self.assertIsNotNone(layerItem.get_updated())
+
+    def test_layerBranch(self):
+        layerBranch = self.index['layerBranches'][1]
+        self.assertEqual(layerBranch.get_id(), 1)
+        self.assertEqual(layerBranch.get_collection(), 'test_collection')
+        self.assertEqual(layerBranch.get_version(), '99')
+        self.assertEqual(layerBranch.get_vcs_subdir(), '')
+        self.assertEqual(layerBranch.get_actual_branch(), 'test_branch')
+        self.assertIsNotNone(layerBranch.get_updated())
+        self.assertEqual(layerBranch.get_layer_id(), 1)
+        self.assertEqual(layerBranch.get_branch_id(), 1)
+        self.assertEqual(layerBranch.get_layer(), self.index['layerItems'][1])
+        self.assertEqual(layerBranch.get_branch(), self.index['branches'][1])
+
+        layerBranch = self.index['layerBranches'][2]
+        self.assertEqual(layerBranch.get_id(), 2)
+        self.assertEqual(layerBranch.get_collection(), 'test_collection_2')
+        self.assertEqual(layerBranch.get_version(), '72')
+        self.assertEqual(layerBranch.get_vcs_subdir(), '')
+        self.assertEqual(layerBranch.get_actual_branch(), 'some_other_branch')
+        self.assertIsNotNone(layerBranch.get_updated())
+        self.assertEqual(layerBranch.get_layer_id(), 2)
+        self.assertEqual(layerBranch.get_branch_id(), 1)
+        self.assertEqual(layerBranch.get_layer(), self.index['layerItems'][2])
+        self.assertEqual(layerBranch.get_branch(), self.index['branches'][1])
+
+    def test_layerDependency(self):
+        layerDependency = self.index['layerDependencies'][1]
+        self.assertEqual(layerDependency.get_id(), 1)
+        self.assertEqual(layerDependency.get_layerbranch_id(), 2)
+        self.assertEqual(layerDependency.get_layerbranch(), self.index['layerBranches'][2])
+        self.assertEqual(layerDependency.get_layer_id(), 2)
+        self.assertEqual(layerDependency.get_layer(), self.index['layerItems'][2])
+        self.assertTrue(layerDependency.is_required())
+        self.assertEqual(layerDependency.get_dependency_id(), 1)
+        self.assertEqual(layerDependency.get_dependency_layer(), self.index['layerItems'][1])
+        self.assertEqual(layerDependency.get_dependency_layerBranch(), self.index['layerBranches'][1])
+
+        # Previous check used the fall back method.. now use the faster method
+        # Create quick lookup layerBranches_layerId_branchId table
+        if 'layerBranches' in self.index:
+            # Create associated quick lookup indexes
+            self.index['layerBranches_layerId_branchId'] = {}
+            for layerBranchId in self.index['layerBranches']:
+                obj = self.index['layerBranches'][layerBranchId]
+                self.index['layerBranches_layerId_branchId']["%s:%s" % (obj.get_layer_id(), obj.get_branch_id())] = obj
+
+        layerDependency = self.index['layerDependencies'][2]
+        self.assertEqual(layerDependency.get_id(), 2)
+        self.assertEqual(layerDependency.get_layerbranch_id(), 2)
+        self.assertEqual(layerDependency.get_layerbranch(), self.index['layerBranches'][2])
+        self.assertEqual(layerDependency.get_layer_id(), 2)
+        self.assertEqual(layerDependency.get_layer(), self.index['layerItems'][2])
+        self.assertFalse(layerDependency.is_required())
+        self.assertEqual(layerDependency.get_dependency_id(), 1)
+        self.assertEqual(layerDependency.get_dependency_layer(), self.index['layerItems'][1])
+        self.assertEqual(layerDependency.get_dependency_layerBranch(), self.index['layerBranches'][1])
+
+    def test_recipe(self):
+        recipe = self.index['recipes'][1]
+        self.assertEqual(recipe.get_id(), 1)
+        self.assertEqual(recipe.get_layerbranch_id(), 1)
+        self.assertEqual(recipe.get_layerbranch(), self.index['layerBranches'][1])
+        self.assertEqual(recipe.get_layer_id(), 1)
+        self.assertEqual(recipe.get_layer(), self.index['layerItems'][1])
+        self.assertEqual(recipe.get_filename(), 'test_git.bb')
+        self.assertEqual(recipe.get_filepath(), 'recipes-test')
+        self.assertEqual(recipe.get_fullpath(), 'recipes-test/test_git.bb')
+        self.assertEqual(recipe.get_summary(), "")
+        self.assertEqual(recipe.get_description(), "")
+        self.assertEqual(recipe.get_section(), "")
+        self.assertEqual(recipe.get_pn(), 'test')
+        self.assertEqual(recipe.get_pv(), 'git')
+        self.assertEqual(recipe.get_license(), "")
+        self.assertEqual(recipe.get_homepage(), "")
+        self.assertEqual(recipe.get_bugtracker(), "")
+        self.assertEqual(recipe.get_provides(), "")
+        self.assertIsNotNone(recipe.get_updated())
+        self.assertEqual(recipe.get_inherits(), "")
+
+    def test_machine(self):
+        machine = self.index['machines'][1]
+        self.assertEqual(machine.get_id(), 1)
+        self.assertEqual(machine.get_layerbranch_id(), 1)
+        self.assertEqual(machine.get_layerbranch(), self.index['layerBranches'][1])
+        self.assertEqual(machine.get_layer_id(), 1)
+        self.assertEqual(machine.get_layer(), self.index['layerItems'][1])
+        self.assertEqual(machine.get_name(), 'test_machine')
+        self.assertEqual(machine.get_description(), 'test_machine')
+        self.assertIsNotNone(machine.get_updated())
+
+    def test_distro(self):
+        distro = self.index['distros'][1]
+        self.assertEqual(distro.get_id(), 1)
+        self.assertEqual(distro.get_layerbranch_id(), 1)
+        self.assertEqual(distro.get_layerbranch(), self.index['layerBranches'][1])
+        self.assertEqual(distro.get_layer_id(), 1)
+        self.assertEqual(distro.get_layer(), self.index['layerItems'][1])
+        self.assertEqual(distro.get_name(), 'test_distro')
+        self.assertEqual(distro.get_description(), 'test_distro')
+        self.assertIsNotNone(distro.get_updated())
diff --git a/lib/layerindexlib/tests/restapi.py b/lib/layerindexlib/tests/restapi.py
new file mode 100644
index 0000000..9d5bedb
--- /dev/null
+++ b/lib/layerindexlib/tests/restapi.py
@@ -0,0 +1,170 @@
+# Copyright (C) 2017-2018 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+import unittest
+import tempfile
+import os
+import bb
+
+import layerindexlib
+from layerindexlib.tests.common import LayersTest
+
+import logging
+
+class LayerIndexWebRestApiTest(LayersTest):
+
+    if os.environ.get("BB_SKIP_NETTESTS") == "yes":
+        print("Unset BB_SKIP_NETTESTS to run network tests")
+    else:
+        def setUp(self):
+            LayersTest.setUp(self)
+            self.lindex = layerindexlib.LayerIndex(self.d)
+            self.lindex.load_layerindex('http://layers.openembedded.org/layerindex/api/;type=restapi;branch=sumo', load='layerDependencies')
+
+        def test_layerindex_is_empty(self):
+            self.assertFalse(self.lindex.is_empty())
+
+        def test_layerindex_store_file(self):
+            self.lindex.store_layerindex('file://%s/file.json;type=restapi' % self.tempdir, self.lindex.lindex[0])
+
+            self.assertTrue(os.path.isfile('%s/file.json' % self.tempdir))
+
+            reload = layerindexlib.LayerIndex(self.d)
+            reload.load_layerindex('file://%s/file.json;type=restapi' % self.tempdir)
+
+            self.assertFalse(reload.is_empty())
+
+            # Calculate layerItems in original index that should NOT be in reload
+            layerItemNames = []
+            for itemId in self.lindex.lindex[0]['layerItems']:
+                layerItemNames.append(self.lindex.lindex[0]['layerItems'][itemId].get_name())
+
+            for layerBranchId in self.lindex.lindex[0]['layerBranches']:
+                layerItemNames.remove(self.lindex.lindex[0]['layerBranches'][layerBranchId].get_layer().get_name())
+
+            for itemId in reload.lindex[0]['layerItems']:
+                self.assertFalse(reload.lindex[0]['layerItems'][itemId].get_name() in layerItemNames)
+
+            # Compare the original to what we wrote...
+            for type in self.lindex.lindex[0]:
+                if type == 'apilinks' or \
+                   type == 'layerItems' or \
+                   type in self.lindex.lindex[0]['CONFIG']['local']:
+                    continue
+                for id in self.lindex.lindex[0][type]:
+                    self.logger.debug(1, "type %s" % (type))
+
+                    self.assertTrue(id in reload.lindex[0][type])
+
+                    self.logger.debug(1, "%s ? %s" % (self.lindex.lindex[0][type][id], reload.lindex[0][type][id]))
+
+                    self.assertEqual(self.lindex.lindex[0][type][id], reload.lindex[0][type][id])
+
+        def test_layerindex_store_split(self):
+            self.lindex.store_layerindex('file://%s;type=restapi' % self.tempdir, self.lindex.lindex[0])
+
+            reload = layerindexlib.LayerIndex(self.d)
+            reload.load_layerindex('file://%s;type=restapi' % self.tempdir)
+
+            self.assertFalse(reload.is_empty())
+
+            for type in self.lindex.lindex[0]:
+                if type == 'apilinks' or \
+                   type == 'layerItems' or \
+                   type in self.lindex.lindex[0]['CONFIG']['local']:
+                    continue
+                for id in self.lindex.lindex[0][type]:
+                    self.logger.debug(1, "type %s" % (type))
+
+                    self.assertTrue(id in reload.lindex[0][type])
+
+                    self.logger.debug(1, "%s ? %s" % (self.lindex.lindex[0][type][id], reload.lindex[0][type][id]))
+
+                    self.assertEqual(self.lindex.lindex[0][type][id], reload.lindex[0][type][id])
+
+        def test_dependency_resolution(self):
+            # Verify depth first searching...
+            (dependencies, invalidnames) = self.lindex.get_dependencies(names='meta-python')
+
+            first = True
+            for deplayerbranch in dependencies:
+                layerBranch = dependencies[deplayerbranch][0]
+                layerDeps = dependencies[deplayerbranch][1:]
+
+                if not first:
+                    continue
+
+                first = False
+
+                # Top of the deps should be openembedded-core, since everything depends on it.
+                self.assertEqual(layerBranch.get_layer().get_name(), "openembedded-core")
+
+                # meta-python should cause an openembedded-core dependency, if not assert!
+                for dep in layerDeps:
+                    if dep.get_layer().get_name() == 'meta-python':
+                        break
+                else:
+                    self.logger.debug(1, "meta-python was not found")
+                    self.assetTrue(False)
+
+                # Only check the first element...
+                break
+            else:
+                # Empty list, this is bad.
+                self.logger.debug(1, "Empty list of dependencies")
+                self.assertIsNotNone(first, msg="Empty list of dependencies")
+
+                # Last dep should be the requested item
+                layerBranch = dependencies[deplayerbranch][0]
+                self.assertEqual(layerBranch.get_layer().get_name(), "meta-python")
+
+    def test_find_collection(self):
+        def _check(collection, expected):
+            self.logger.debug(1, "Looking for collection %s..." % collection)
+            result = self.lindex.find_collection(collection)
+            if expected:
+                self.assertIsNotNone(result, msg="Did not find %s when it shouldn't be there" % collection)
+            else:
+                self.assertIsNone(result, msg="Found %s when it should be there" % collection)
+
+        tests = [ ('core', True),
+                  ('openembedded-core', False),
+                  ('networking-layer', True),
+                  ('meta-python', True),
+                  ('openembedded-layer', True),
+                  ('notpresent', False) ]
+
+        for collection,result in tests:
+            _check(collection, result)
+
+    def test_get_layerbranch(self):
+        def _check(name, expected):
+            self.logger.debug(1, "Looking for layerbranch %s..." % name)
+            result = self.lindex.get_layerbranch(name)
+            if expected:
+                self.assertIsNotNone(result, msg="Did not find %s when it shouldn't be there" % collection)
+            else:
+                self.assertIsNone(result, msg="Found %s when it should be there" % collection)
+
+        tests = [ ('openembedded-core', True),
+                  ('core', False),
+                  ('meta-networking', True),
+                  ('meta-python', True),
+                  ('meta-oe', True),
+                  ('notpresent', False) ]
+
+        for collection,result in tests:
+            _check(collection, result)
+
diff --git a/lib/layerindexlib/tests/testdata/README b/lib/layerindexlib/tests/testdata/README
new file mode 100644
index 0000000..36ab40b
--- /dev/null
+++ b/lib/layerindexlib/tests/testdata/README
@@ -0,0 +1,11 @@
+This test data is used to verify the 'cooker' module of the layerindex.
+
+The module consists of a faux project bblayers.conf with four layers defined.
+
+layer1 - openembedded-core
+layer2 - networking-layer
+layer3 - meta-python
+layer4 - openembedded-layer (meta-oe)
+
+Since we do not have a fully populated cooker, we use this to test the
+basic index generation, and not any deep recipe based contents.
diff --git a/lib/layerindexlib/tests/testdata/build/conf/bblayers.conf b/lib/layerindexlib/tests/testdata/build/conf/bblayers.conf
new file mode 100644
index 0000000..40429b2
--- /dev/null
+++ b/lib/layerindexlib/tests/testdata/build/conf/bblayers.conf
@@ -0,0 +1,15 @@
+LAYERSERIES_CORENAMES = "sumo"
+
+# LAYER_CONF_VERSION is increased each time build/conf/bblayers.conf
+# changes incompatibly
+LCONF_VERSION = "7"
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+
+BBLAYERS ?= " \
+  ${TOPDIR}/layer1 \
+  ${TOPDIR}/layer2 \
+  ${TOPDIR}/layer3 \
+  ${TOPDIR}/layer4 \
+  "
diff --git a/lib/layerindexlib/tests/testdata/layer1/conf/layer.conf b/lib/layerindexlib/tests/testdata/layer1/conf/layer.conf
new file mode 100644
index 0000000..966d531
--- /dev/null
+++ b/lib/layerindexlib/tests/testdata/layer1/conf/layer.conf
@@ -0,0 +1,17 @@
+# We have a conf and classes directory, add to BBPATH
+BBPATH .= ":${LAYERDIR}"
+# We have recipes-* directories, add to BBFILES
+BBFILES += "${LAYERDIR}/recipes-*/*/*.bb"
+
+BBFILE_COLLECTIONS += "core"
+BBFILE_PATTERN_core = "^${LAYERDIR}/"
+BBFILE_PRIORITY_core = "5"
+
+LAYERSERIES_CORENAMES = "sumo"
+
+# This should only be incremented on significant changes that will
+# cause compatibility issues with other layers
+LAYERVERSION_core = "11"
+LAYERSERIES_COMPAT_core = "sumo"
+
+BBLAYERS_LAYERINDEX_NAME_core = "openembedded-core"
diff --git a/lib/layerindexlib/tests/testdata/layer2/conf/layer.conf b/lib/layerindexlib/tests/testdata/layer2/conf/layer.conf
new file mode 100644
index 0000000..7569d1c
--- /dev/null
+++ b/lib/layerindexlib/tests/testdata/layer2/conf/layer.conf
@@ -0,0 +1,20 @@
+# We have a conf and classes directory, add to BBPATH
+BBPATH .= ":${LAYERDIR}"
+
+# We have a packages directory, add to BBFILES
+BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
+            ${LAYERDIR}/recipes-*/*/*.bbappend"
+
+BBFILE_COLLECTIONS += "networking-layer"
+BBFILE_PATTERN_networking-layer := "^${LAYERDIR}/"
+BBFILE_PRIORITY_networking-layer = "5"
+
+# This should only be incremented on significant changes that will
+# cause compatibility issues with other layers
+LAYERVERSION_networking-layer = "1"
+
+LAYERDEPENDS_networking-layer = "core"
+LAYERDEPENDS_networking-layer += "openembedded-layer"
+LAYERDEPENDS_networking-layer += "meta-python"
+
+LAYERSERIES_COMPAT_networking-layer = "sumo"
diff --git a/lib/layerindexlib/tests/testdata/layer3/conf/layer.conf b/lib/layerindexlib/tests/testdata/layer3/conf/layer.conf
new file mode 100644
index 0000000..7089071
--- /dev/null
+++ b/lib/layerindexlib/tests/testdata/layer3/conf/layer.conf
@@ -0,0 +1,19 @@
+# We might have a conf and classes directory, append to BBPATH
+BBPATH .= ":${LAYERDIR}"
+
+# We have recipes directories, add to BBFILES
+BBFILES += "${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/recipes*/*/*.bbappend"
+
+BBFILE_COLLECTIONS += "meta-python"
+BBFILE_PATTERN_meta-python := "^${LAYERDIR}/"
+BBFILE_PRIORITY_meta-python = "7"
+
+# This should only be incremented on significant changes that will
+# cause compatibility issues with other layers
+LAYERVERSION_meta-python = "1"
+
+LAYERDEPENDS_meta-python = "core openembedded-layer"
+
+LAYERSERIES_COMPAT_meta-python = "sumo"
+
+LICENSE_PATH += "${LAYERDIR}/licenses"
diff --git a/lib/layerindexlib/tests/testdata/layer4/conf/layer.conf b/lib/layerindexlib/tests/testdata/layer4/conf/layer.conf
new file mode 100644
index 0000000..6649ee0
--- /dev/null
+++ b/lib/layerindexlib/tests/testdata/layer4/conf/layer.conf
@@ -0,0 +1,22 @@
+# We have a conf and classes directory, append to BBPATH
+BBPATH .= ":${LAYERDIR}"
+
+# We have a recipes directory, add to BBFILES
+BBFILES += "${LAYERDIR}/recipes-*/*/*.bb ${LAYERDIR}/recipes-*/*/*.bbappend"
+
+BBFILE_COLLECTIONS += "openembedded-layer"
+BBFILE_PATTERN_openembedded-layer := "^${LAYERDIR}/"
+
+# Define the priority for recipes (.bb files) from this layer,
+# choosing carefully how this layer interacts with all of the
+# other layers.
+
+BBFILE_PRIORITY_openembedded-layer = "6"
+
+# This should only be incremented on significant changes that will
+# cause compatibility issues with other layers
+LAYERVERSION_openembedded-layer = "1"
+
+LAYERDEPENDS_openembedded-layer = "core"
+
+LAYERSERIES_COMPAT_openembedded-layer = "sumo"
-- 
1.8.3.1


