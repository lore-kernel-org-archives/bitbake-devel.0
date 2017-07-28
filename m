Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id D110B7851C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 15:39:18 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6SFdJtH028825
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Jul 2017 08:39:19 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.294.0;
	Fri, 28 Jul 2017 08:39:20 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jul 2017 10:37:18 -0500
Message-ID: <1501256242-37784-2-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 28 Jul 2017 15:43:32 +0000
Cc: toaster@yoctoproject.org
Subject: [PATCH 1/5] lib/layers: Initial layer and layer index implementeation
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
X-List-Received-Date: Fri, 28 Jul 2017 15:39:19 -0000
Content-Type: text/plain

This module provides two components, layerindex, which is used to talk a
layerindex, such as layers.openembedded.org.

The other module is the 'manager'.  This module will handle downloading,
re-writing the bblayers to match the downloads and other related layer
management tasks.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/layers/__init__.py            |   0
 lib/layers/layerindex/__init__.py | 962 ++++++++++++++++++++++++++++++++++++++
 lib/layers/layerindex/common.py   | 146 ++++++
 lib/layers/layerindex/cooker.py   | 223 +++++++++
 lib/layers/layerindex/restapi.py  | 348 ++++++++++++++
 lib/layers/manager/__init__.py    | 242 ++++++++++
 lib/layers/manager/common.py      |  60 +++
 lib/layers/manager/fetch2.py      | 210 +++++++++
 8 files changed, 2191 insertions(+)
 create mode 100644 lib/layers/__init__.py
 create mode 100644 lib/layers/layerindex/__init__.py
 create mode 100644 lib/layers/layerindex/common.py
 create mode 100644 lib/layers/layerindex/cooker.py
 create mode 100644 lib/layers/layerindex/restapi.py
 create mode 100644 lib/layers/manager/__init__.py
 create mode 100644 lib/layers/manager/common.py
 create mode 100644 lib/layers/manager/fetch2.py

diff --git a/lib/layers/__init__.py b/lib/layers/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/layers/layerindex/__init__.py b/lib/layers/layerindex/__init__.py
new file mode 100644
index 0000000..0c7c483
--- /dev/null
+++ b/lib/layers/layerindex/__init__.py
@@ -0,0 +1,962 @@
+# Copyright (C) 2016-2017 Wind River Systems, Inc.
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
+logger = logging.getLogger('BitBake.layers.layerindex')
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
+  'OR', such as 'branch=masterORmortyORpyro'.  However, many operations on look
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
+            plugin = self._get_plugin(ud.parm['type'])
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
+            for branch in lindex['CONFIG']['BRANCH'].split('OR'):
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
+            for branch in lindex['CONFIG']['BRANCH'].split('OR'):
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
+                if name in ignores:
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
+            if name in ignores:
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
+                    if depLayerBranch.get_layer().get_name() in ignores:
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
+            logger.error('Unable to find layerBranches_layerId_branchId in index')
+        except IndexError:
+            logger.error("LayerBranch not found layerId %s -- BranchId %s" % (layerId, branchId))
+
+        return layerBranch
+
+
+class Recipe(LayerIndexItem_LayerBranch):
+    def define_data(self, id,
+                    filename, filepath, pn, pv,
+                    summary, description, section, license,
+                    homepage, bugtracker, provides, bbclassextend,
+                    inherits, blacklisted, layerbranch, updated=None):
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
diff --git a/lib/layers/layerindex/common.py b/lib/layers/layerindex/common.py
new file mode 100644
index 0000000..eb0cd75
--- /dev/null
+++ b/lib/layers/layerindex/common.py
@@ -0,0 +1,146 @@
+# Copyright (C) 2016-2017 Wind River Systems, Inc.
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
+import argparse
+import logging
+import os
+import bb.msg
+
+logger = logging.getLogger('BitBake.layerindex.common')
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
+# Fetch something from a specific URL.  This is specifically designed to
+# fetch data from a layer index or related element.  It should NOT be
+# used to fetch recipe contents or similar.
+#
+# TODO: Handle BB_NO_NETWORK or allowed hosts, etc.
+#
+def fetch_url(url, username=None, password=None, debuglevel=0):
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
+# Add a raw object of type lType to lindex[lname]
+def add_raw_element(lName, lType, rawObjs, lindex):
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
+# Add a layer index object to lindex[lName]
+def add_element(lName, Objs, lindex):
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
diff --git a/lib/layers/layerindex/cooker.py b/lib/layers/layerindex/cooker.py
new file mode 100644
index 0000000..229f668
--- /dev/null
+++ b/lib/layers/layerindex/cooker.py
@@ -0,0 +1,223 @@
+# Copyright (C) 2016-2017 Wind River Systems, Inc.
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
+import layers.layerindex
+
+from layers.layerindex.common import IndexPlugin
+from layers.layerindex.common import LayerIndexError
+from layers.layerindex.common import add_element
+
+from layers.manager import _get_manager
+
+logger = logging.getLogger('BitBake.layerindex.cooker')
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
+        manager = _get_manager()
+        if not manager:
+            raise Exception('layer manager object has not been setup!')
+
+        localdata = self.lindex.data.createCopy()
+        # If the URL passed in branches, then we fake it...
+        if 'branch' in ud.parm:
+            localdata.setVar('LAYERSERIES_CORENAMES', ' '.join(ud.parm['branch'].split('OR')))
+
+        lindex = manager.load_bblayers(localdata)
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
+            lindex['CONFIG']['BRANCH'] = localdata.getVar('LAYERSERIES_CORENAMES') or "HEAD"
+
+        # ("layerDependencies", layerindex.LayerDependency)
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
+                        layerDependency = layers.layerindex.LayerDependency(lindex, None)
+                        layerDependency.define_data(id=layerDependencyId,
+                                        required=required, layerbranch=layerBranchId,
+                                        dependency=depLayerBranch.get_layer_id())
+
+                        logger.debug(1, '%s requires %s' % (layerDependency.get_layer().get_name(), layerDependency.get_dependency_layer().get_name()))
+                        lindex = add_element("layerDependencies", [layerDependency], lindex)
+
+                    return layerDependencyId
+
+                deps = localdata.getVar("LAYERDEPENDS_%s" % collection)
+                if deps:
+                    layerDependencyId = add_dependency(layerDependencyId, lindex, deps, True)
+
+                deps = localdata.getVar("LAYERRECOMMENDS_%s" % collection)
+                if deps:
+                    layerDependencyId = add_dependency(layerDependencyId, lindex, deps, False)
+
+        # Need to load recipes here
+        recipeId = 0
+        if False and 'recipes' in load.split():  ## TODO NOT IMPLEMENTED
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
+                    recipe = layerindex.Recipe(lindex, None)
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
+        # ("machines", layerindex.Machine)
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
+                                machine = layers.layerindex.Machine(lindex, None)
+                                machine.define_data(id=machineId, name=fname[:-5],
+                                                    description=fname[:-5],
+                                                    layerbranch=collection_layerbranch[entry])
+
+                                lindex = add_element("machines", [machine], lindex)
+
+        # ("distros", layerindex.Distro)
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
+                                distro = layers.layerindex.Distro(lindex, None)
+                                distro.define_data(id=distroId, name=fname[:-5],
+                                                    description=fname[:-5],
+                                                    layerbranch=collection_layerbranch[entry])
+
+                                lindex = add_element("distros", [distro], lindex)
+
+        return lindex
diff --git a/lib/layers/layerindex/restapi.py b/lib/layers/layerindex/restapi.py
new file mode 100644
index 0000000..d6d29a4
--- /dev/null
+++ b/lib/layers/layerindex/restapi.py
@@ -0,0 +1,348 @@
+# Copyright (C) 2016-2017 Wind River Systems, Inc.
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
+import layers.layerindex
+
+from layers.layerindex.common import IndexPlugin
+from layers.layerindex.common import fetch_url
+from layers.layerindex.common import LayerIndexError
+from layers.layerindex.common import add_raw_element
+
+logger = logging.getLogger('BitBake.layers.layerindex.restapi')
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
+            pindex = json.load(open(path, 'rt', encoding='utf-8'))
+
+            # Filter the branches on loaded files...
+            newpBranch = []
+            if branches:
+                for branch in (branches or "").split('OR'):
+                    if 'branches' in pindex:
+                        for br in pindex['branches']:
+                            if br['name'] == branch:
+                                newpBranch.append(br)
+            else:
+                if 'branches' in pindex:
+                    newpBranch = pindex['branches']
+
+            if newpBranch:
+                lindex = add_raw_element('branches', layers.layerindex.Branch, { 'branches' : newpBranch }, lindex)
+            else:
+                logger.debug(1, 'No matching branchs (%s) in index file(s)' % branches)
+                # No matching branches.. return nothing...
+                return
+
+            for (lName, lType) in [("layerItems", layers.layerindex.LayerItem),
+                                   ("layerBranches", layers.layerindex.LayerBranch),
+                                   ("layerDependencies", layers.layerindex.LayerDependency),
+                                   ("recipes", layers.layerindex.Recipe),
+                                   ("machines", layers.layerindex.Machine),
+                                   ("distros", layers.layerindex.Distro)]:
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
+        lindex = add_raw_element("branches", layers.layerindex.Branch, pindex, lindex)
+
+
+        # Load all of the layerItems (these can not be easily filtered)
+        logger.debug(1, "Loading %s from %s" % ('layerItems', lindex['apilinks']['layerItems']))
+        pindex['layerItems'] = _get_json_response(lindex['apilinks']['layerItems'],
+                                                  username=ud.user, password=ud.pswd)
+        if not pindex['layerItems']:
+            logger.debug(1, "No layers were found at url %s." % (ud.url))
+            return lindex
+        lindex = add_raw_element("layerItems", layers.layerindex.LayerItem, pindex, lindex)
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
+            lindex = add_raw_element("layerBranches", layers.layerindex.LayerBranch, pindex, lindex)
+
+
+            # Load the rest, they all have a similar format
+            filter = "?filter=layerbranch__branch__name:%s" % lindex['branches'][branch].get_name()
+            for (lName, lType) in [("layerDependencies", layers.layerindex.LayerDependency),
+                                   ("recipes", layers.layerindex.Recipe),
+                                   ("machines", layers.layerindex.Machine),
+                                   ("distros", layers.layerindex.Distro)]:
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
+        # Write out to a single file, we have to sort the entries as we write
+        if not os.path.isdir(ud.path):
+            pindex = {}
+            for entry in lindex:
+                # Check for either locally added item or apilinks to ignore
+                if entry in lindex['CONFIG']['local'] or \
+                   entry == 'apilinks':
+                    continue
+                pindex[entry] = []
+                for objId in lindex[entry]:
+                    pindex[entry].append(lindex[entry][objId].data)
+
+            bb.debug(1, 'Writing index to %s' % ud.path)
+            json.dump(layers.layerindex.sort_entry(pindex), open(ud.path, 'wt'), indent=4)
+            return
+
+        # Write out to a directory one file per layerBranch
+        try:
+            layerBranches = lindex['layerBranches']
+        except KeyError:
+            logger.error('No layerBranches to write.')
+            return
+
+        for layerBranchId in layerBranches:
+            pindex = {}
+
+            def filter_item(layerBranchId, objects):
+                filtered = []
+                for obj in lindex[objects]:
+                    try:
+                        if lindex[objects][obj].get_layerbranch_id() == layerBranchId:
+                            filtered.append(lindex[objects][obj].data)
+                    except AttributeError:
+                        logger.debug(1, 'No obj.get_layerbranch_id(): %s' % objects)
+                        # No simple filter method, just include it...
+                        try:
+                            filtered.append(lindex[objects][obj].data)
+                        except AttributeError:
+                            logger.debug(1, 'No obj.data: %s %s' % (objects, type(obj)))
+                            filtered.append(obj)
+                return filtered
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
+                layerDependency = layers.layerindex.LayerDependency(lindex, layerDep)
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
+            json.dump(layers.layerindex.sort_entry(pindex), open(fpath + '.json', 'wt'), indent=4)
diff --git a/lib/layers/manager/__init__.py b/lib/layers/manager/__init__.py
new file mode 100644
index 0000000..3145924
--- /dev/null
+++ b/lib/layers/manager/__init__.py
@@ -0,0 +1,242 @@
+# Copyright (C) 2017 Wind River Systems, Inc.
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
+
+import layers.layerindex
+
+import tempfile
+
+import shutil
+
+logger = logging.getLogger('BitBake.layers.manager')
+
+class LayerManager():
+    def __init__(self, d, cooker):
+        _set_manager(self)
+
+        self.data = d
+        self.cooker = cooker
+
+        self.local_index = None  # What is in the bblayers.conf
+        self.layers = None       # The layers we want to setup (get_dependency format)
+        self.ignore = None       # Specific items to ignore on fetch/unpack
+
+        self.plugins = []
+        bb.utils.load_plugins(logger, self.plugins, os.path.dirname(__file__))
+        for plugin in self.plugins:
+            if hasattr(plugin, 'init'):
+                plugin.init(self)
+
+    def get_plugin(self, type):
+        for plugin in self.plugins:
+            if hasattr(plugin, 'plugin_type'):
+                plugintype = plugin.plugin_type()
+                logger.debug(1, "Looking for LayerManagerPlugin - %s ? %s" % (plugintype, type))
+                if plugintype and plugintype == type:
+                    return plugin
+        return None
+
+    def _run_command(self, command, path, default=None):
+        try:
+            result, _ = bb.process.run(command, cwd=path)
+            result = result.strip()
+        except bb.process.ExecutionError:
+            result = default
+        return result
+
+    def get_bitbake_info(self):
+        """Return a tuple of bitbake information"""
+
+        # Our path SHOULD be .../bitbake/lib/layers/manager/__init__.py
+        bb_path = os.path.dirname(__file__) # .../bitbake/lib/layers/manager/__init__.py
+        bb_path = os.path.dirname(bb_path)  # .../bitbake/lib/layers/manager
+        bb_path = os.path.dirname(bb_path)  # .../bitbake/lib/layers
+        bb_path = os.path.dirname(bb_path)  # .../bitbake/lib
+        bb_path = os.path.dirname(bb_path)  # .../bitbake
+        bb_path = self._run_command('git rev-parse --show-toplevel', os.path.dirname(__file__), default=bb_path)
+        bb_branch = self._run_command('git rev-parse --abbrev-ref HEAD', bb_path, default="<unknown>")
+        bb_rev = self._run_command('git rev-parse HEAD', bb_path, default="<unknown>")
+        for remotes in self._run_command('git remote -v', bb_path, default="").split("\n"):
+            remote = remotes.split("\t")[1].split(" ")[0]
+            if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
+                bb_remote = _handle_git_remote(remote)
+                break
+        else:
+            bb_remote = _handle_git_remote(bb_path)
+
+        return (bb_remote, bb_branch, bb_rev, bb_path)
+
+    def load_bblayers(self, d=None):
+        """Load the BBLAYERS and related collection information"""
+        if d is None:
+            d = self.data
+
+        default_branches = d.getVar('LAYERSERIES_CORENAMES') or "HEAD"
+
+        collections = d.getVar('BBFILE_COLLECTIONS')
+        layerconfs = d.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', d)
+        bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.items()}
+
+        bblayers = d.getVar('BBLAYERS').split()
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
+        (_, bb_branch, _, _) = self.get_bitbake_info()
+
+        for branch in default_branches.split():
+            branchId += 1
+            index['branches'][branchId] = layers.layerindex.Branch(index, None)
+            index['branches'][branchId].define_data(branchId, branch, bb_branch)
+
+        for entry in collections.split():
+            layername = d.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % entry) or os.path.basename(bbfile_collections[entry])
+
+            layerpath = bbfile_collections[entry]
+            layersubdir = ""
+
+            layerbasepath = self._run_command('git rev-parse --show-toplevel', layerpath, default=layerpath)
+            if os.path.abspath(layerpath) != os.path.abspath(layerbasepath):
+                layersubdir = os.path.abspath(layerpath)[len(layerbasepath) + 1:]
+
+            layerversion = d.getVar('LAYERVERSION_%s' % entry) or ""
+
+            layerbranch = self._run_command('git rev-parse --abbrev-ref HEAD', layerpath, default="<unknown>")
+            layerrev = self._run_command('git rev-parse HEAD', layerpath, default="<unknown>")
+
+            for remotes in self._run_command('git remote -v', layerpath, default="").split("\n"):
+                remote = remotes.split("\t")[1].split(" ")[0]
+                if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
+                    layerurl = _handle_git_remote(remote)
+                    break
+                else:
+                    layerurl = _handle_git_remote(layerpath)
+
+            layerItemId += 1
+            index['layerItems'][layerItemId] = layers.layerindex.LayerItem(index, None)
+            index['layerItems'][layerItemId].define_data(layerItemId, layername, description=layerpath, vcs_url=layerurl)
+
+            for branchId in index['branches']:
+                layerBranchId += 1
+                index['layerBranches'][layerBranchId] = layers.layerindex.LayerBranch(index, None)
+                index['layerBranches'][layerBranchId].define_data(layerBranchId, entry, layerversion, layerItemId, branchId,
+                                               vcs_subdir=layersubdir, vcs_last_rev= layerrev, actual_branch=layerbranch)
+
+        return index
+
+    def get_clone_base_directory(self):
+        return self.data.getVar('BBLAYERS_FETCH_DIR')
+
+    # You are not allowed to have two of the same url, but different branches
+    def get_clone_directory(self, url):
+        baseDir = get_clone_base_directory()
+        if not baseDir:
+            return None
+        repo = os.path.basename(url)
+        return os.path.join(baseDir, repo)
+
+    def setup(self, layers, ignore=None):
+        """Setup the data structures for fetch and unpack and update bblayers.conf
+
+layers - format returned by LayerIndex.getDependencies
+ignore - a text string with a space deliminated list of layerItem names to ignore when downloading."""
+
+        self.local_index = self.load_bblayers()
+        self.layers = layers
+        self.ignore = (ignore or "").split()
+
+        self.index_fetcher = self.data.getVar('BBLAYERS_FETCHER_TYPE') or 'fetch2'
+
+        plugin = self.get_plugin(self.index_fetcher)
+        if not plugin:
+            raise NotImplementedError("layer manager plugin %s is not available" % index_fetcher)
+
+        plugin.setup()
+
+
+    def fetch(self):
+        """Fetch the layers from setup"""
+
+        plugin = self.get_plugin(self.index_fetcher)
+        if not plugin:
+            raise NotImplementedError("layer manager plugin %s is not available" % index_fetcher)
+
+        plugin.fetch()
+
+
+    def unpack(self):
+        """unpack the layers from fetch"""
+
+        plugin = self.get_plugin(self.index_fetcher)
+        if not plugin:
+            raise NotImplementedError("layer manager plugin %s is not available" % index_fetcher)
+
+        plugin.unpack()
+
+
+    def update_bblayers(self):
+        """Update the bblayers.conf file"""
+
+        plugin = self.get_plugin(self.index_fetcher)
+        if not plugin:
+            raise NotImplementedError("layer manager plugin %s is not available" % index_fetcher)
+
+        layerdirs = plugin.get_new_layers()
+
+        topdir = self.data.getVar('TOPDIR')
+        bblayers_conf = os.path.join(topdir, 'conf', 'bblayers.conf')
+        if not os.path.exists(bblayers_conf):
+            raise Exception('Unable to find bblayers.conf: %s' % bblayers_conf)
+
+        # Back up bblayers.conf to tempdir before we add layers
+        tempdir = tempfile.mkdtemp()
+        backup = tempdir + "/bblayers.conf.bak"
+        shutil.copy2(bblayers_conf, backup)
+
+        try:
+            notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None)
+        except Exception as e:
+            shutil.copy2(backup, bblayers_conf)
+            raise e
+        finally:
+            # Remove the back up copy of bblayers.conf
+            shutil.rmtree(tempdir)
+
+def _set_manager(manager):
+    global _manager
+    _manager = manager
+
+def _get_manager():
+    global _manager
+    return _manager
+
+def _handle_git_remote(remote):
+    if "://" not in remote:
+        if ':' in remote:
+            # This is assumed to be ssh
+            remote = "ssh://" + remote
+        else:
+            # This is assumed to be a file path
+            remote = "file://" + remote
+    return remote
diff --git a/lib/layers/manager/common.py b/lib/layers/manager/common.py
new file mode 100644
index 0000000..35f318d
--- /dev/null
+++ b/lib/layers/manager/common.py
@@ -0,0 +1,60 @@
+# Copyright (C) 2017 Wind River Systems, Inc.
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
+import os
+import bb.msg
+
+logger = logging.getLogger('BitBake.layerindex.common')
+
+class LayerManagerError(Exception):
+    """LayerManager error"""
+    def __init__(self, message):
+         self.msg = message
+         Exception.__init__(self, message)
+
+    def __str__(self):
+         return self.msg
+
+class DownloadPlugin():
+    def __init__(self, manager):
+        self.type = None
+
+    def init(self, manager):
+        self.manager = manager
+        self.data = self.manager.data
+
+    def plugin_type(self):
+        return self.type
+
+    def setup(self, layers, ignore):
+        """Setup the download"""
+
+        raise NotImplementedError('setup is not implemented')
+
+    def fetch(self):
+        """Fetch the layers from setup"""
+
+        raise NotImplementedError('fetch is not implemented')
+
+    def unpack(self):
+        """Fetch the layers from setup"""
+
+        raise NotImplementedError('fetch is not implemented')
+
+    def get_new_layers(self):
+        """Return a list of layers that we've unpacked"""
+
+        raise NotImplementedError('get_new_layers is not implemented')
diff --git a/lib/layers/manager/fetch2.py b/lib/layers/manager/fetch2.py
new file mode 100644
index 0000000..894a15d
--- /dev/null
+++ b/lib/layers/manager/fetch2.py
@@ -0,0 +1,210 @@
+# Copyright (C) 2017 Wind River Systems, Inc.
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
+from layers.manager.common import DownloadPlugin
+
+import logging
+import bb.fetch2
+
+import layers.layerindex
+
+logger = logging.getLogger('BitBake.layers.manager.fetch2')
+
+def plugin_init(plugins):
+    return Fetch2Plugin()
+
+class Fetch2Plugin(DownloadPlugin):
+    def __init__(self):
+        self.type = "fetch2"
+
+        # Dictionary of names and their replacements
+        self.rename = {}
+
+    def setup(self):
+        if not self.manager:
+            raise Exception('plugin was not initialized properly.')
+
+        # Reset this...
+        self.rename = {}
+
+        local_index = self.manager.local_index
+        layers = self.manager.layers
+        ignore = self.manager.ignore
+
+        def gen_src_uri(uri, branch):
+            if "://" not in uri:
+                type = 'file'
+                path = uri
+            else:
+                type, path = uri.split('://', 1)
+            return 'git://%s;protocol=%s;branch=%s;rev=%s' % (path, type, branch, branch)
+
+        # Format:
+        # url[<vcs_url>] = [ <src_uri>, layer_name1, layer_name2, ... layer_name3 ]
+        local_urls = {}
+        for layerBranchId in local_index['layerBranches']:
+            layerBranch = local_index['layerBranches'][layerBranchId]
+            url = layerBranch.get_layer().get_vcs_url()
+            if url not in local_urls:
+                local_urls[url] = [gen_src_uri(url, layerBranch.get_branch().get_name())]
+            if layerBranch.get_layer().get_name() not in local_urls[url]:
+                local_urls[url].append(layerBranch.get_layer().get_name())
+
+        remote_urls = {}
+        for deplayerbranch in layers:
+            layerBranch = layers[deplayerbranch][0]
+            url = layerBranch.get_layer().get_vcs_url()
+            if url not in local_urls:
+                if url not in remote_urls:
+                    remote_urls[url] = [gen_src_uri(url, layerBranch.get_branch().get_name())]
+                if layerBranch.get_layer().get_name() not in remote_urls[url]:
+                    remote_urls[url].append(layerBranch.get_layer().get_name())
+
+        self.local_urls = local_urls
+        self.remote_urls = remote_urls
+
+        #self.debug()
+
+        # define defaults here... and verify we're not going to break something!
+
+        fetchdir = self.manager.data.getVar('BBLAYERS_FETCH_DIR')
+
+        src_uri = ""
+        for url in remote_urls:
+            original = ondisk = os.path.join(fetchdir, os.path.basename(url).rstrip('.git'))
+            while os.path.exists(ondisk):
+                # Add '_' until it's unique
+                ondisk += "_"
+            if original != ondisk:
+                print('Rename destination from %s to %s' % (original, ondisk))
+                self.rename[original] = ondisk
+
+            src_uri += " " + remote_urls[url][0] + ";destsuffix=%s" % ondisk
+
+        self.src_uri = src_uri.strip()
+
+
+    def fetch(self):
+        src_uri = self.src_uri
+        if not src_uri:
+            # Nothing to fetch
+            self.fetcher = None
+            return
+
+        logger.plain('Fetching...')
+
+        remote_urls = self.remote_urls
+        localdata = self.manager.data.createCopy()
+
+        fetchdir = localdata.getVar('BBLAYERS_FETCH_DIR')
+
+        localdata.setVar('SRC_URI', src_uri)
+
+        localdata.delVar('MIRRORS')
+        localdata.delVar('PREMIRRORS')
+        mirrors = localdata.getVar('BBLAYERS_MIRRORS')
+        if mirrors:
+            localdata.setVar('PREMIRRORS', mirrors)
+
+        dldir = localdata.getVar('BBLAYERS_DL_DIR')
+        if not dldir:
+            dldir = os.path.join(fetchdir, '_layers')
+        localdata.setVar('DL_DIR', dldir)
+        localdata.setVar('FILESPATH', dldir)
+
+        if localdata.getVar('BB_NO_NETWORK') == '1' and localdata.getVar('BBLAYERS_ALLOW_NETWORK'):
+            localdata.delVar('BB_NO_NETWORK')
+
+        self.fetcher = bb.fetch2.Fetch(src_uri.split(), localdata, cache=False)
+        self.fetcher.download()
+
+    def unpack(self):
+        if not self.fetcher:
+            # Nothing to unpack
+            return
+
+        logger.plain('Unpacking...')
+        fetchdir = self.manager.data.getVar('BBLAYERS_FETCH_DIR')
+        self.fetcher.unpack(fetchdir)
+
+    def get_new_layers(self):
+        layers = self.manager.layers
+        remote_urls = self.remote_urls
+
+        fetchdir = self.manager.data.getVar('BBLAYERS_FETCH_DIR')
+
+        new_layers = []
+
+        local_layers = []
+        local_index = self.manager.local_index
+        for layerBranchId in local_index['layerBranches']:
+            layerBranch = local_index['layerBranches'][layerBranchId]
+            local_layers.append(layerBranch.get_layer().get_name())
+
+        for deplayerbranch in layers:
+            layerBranch = layers[deplayerbranch][0]
+            if layerBranch.get_layer().get_name() in local_layers:
+                # We already have it
+                continue
+
+            scm_path = os.path.join(fetchdir,
+                             os.path.basename(layerBranch.get_layer().get_vcs_url())).rstrip('.git')
+            if scm_path in self.rename:
+                scm_path = self.rename[scm_path]
+
+            path = os.path.join(scm_path,
+                                layerBranch.get_vcs_subdir() or "")
+
+            if not os.path.isdir(path):
+                raise Exception('Expected layer path %s does not exist.' % path)
+                continue
+
+            new_layers.append(path)
+
+        return new_layers
+
+
+    def debug(self):
+        #### Debugging
+        layers = self.manager.layers
+        remote_urls = self.remote_urls
+
+        logger.plain("%s  %s  %s" % ("Layer".ljust(24), "Git repository (branch)".ljust(54), "Subdirectory"))
+        logger.plain('=' * 105)
+
+        for deplayerbranch in layers:
+            layerBranch = layers[deplayerbranch][0]
+            layerDeps = layers[deplayerbranch][1:]
+
+            requiredby = []
+            recommendedby = []
+            for dep in layerDeps:
+                if dep.is_required():
+                    requiredby.append(dep.get_layer().get_name())
+                else:
+                    recommendedby.append(dep.get_layer().get_name())
+
+            required = False
+            if (not requiredby and not recommendedby) or requiredby:
+                required = True
+
+            logger.plain('%s%s %s %s' % (
+                                  [' ', '+'][layerBranch.get_layer().get_vcs_url() in remote_urls],
+                                  layerBranch.get_layer().get_name().ljust(24),
+                                  ("%s (%s)" % (layerBranch.get_layer().get_vcs_url(),
+                                  layerBranch.get_actual_branch())).ljust(55),
+                                  layerBranch.get_vcs_subdir()
+                                               ))
+        #### Debugging
-- 
1.8.3.1


