Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id EBF8C753E3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Jul 2018 02:29:17 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w6O2TIkp026259
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 19:29:19 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.399.0;
	Mon, 23 Jul 2018 19:29:18 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 23 Jul 2018 22:29:11 -0400
Message-ID: <20180724022914.185634-3-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180724022914.185634-1-mark.hatle@windriver.com>
References: <20180724022914.185634-1-mark.hatle@windriver.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 24 Jul 2018 15:13:08 +0000
Subject: [PATCH 2/5 v2] layerindexlib: Initial layer index processing module implementation
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
X-List-Received-Date: Tue, 24 Jul 2018 02:29:18 -0000
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
 bin/bitbake-selftest                               |    6 +-
 lib/layerindexlib/README                           |   28 +
 lib/layerindexlib/__init__.py                      | 1364 ++++++++++++++++++++
 lib/layerindexlib/cooker.py                        |  341 +++++
 lib/layerindexlib/plugin.py                        |   60 +
 lib/layerindexlib/restapi.py                       |  398 ++++++
 lib/layerindexlib/tests/__init__.py                |    0
 lib/layerindexlib/tests/common.py                  |   43 +
 lib/layerindexlib/tests/cooker.py                  |  123 ++
 lib/layerindexlib/tests/layerindexobj.py           |  226 ++++
 lib/layerindexlib/tests/restapi.py                 |  174 +++
 lib/layerindexlib/tests/testdata/README            |   11 +
 .../tests/testdata/build/conf/bblayers.conf        |   15 +
 .../tests/testdata/layer1/conf/layer.conf          |   17 +
 .../tests/testdata/layer2/conf/layer.conf          |   20 +
 .../tests/testdata/layer3/conf/layer.conf          |   19 +
 .../tests/testdata/layer4/conf/layer.conf          |   22 +
 17 files changed, 2866 insertions(+), 1 deletion(-)
 create mode 100644 lib/layerindexlib/README
 create mode 100644 lib/layerindexlib/__init__.py
 create mode 100644 lib/layerindexlib/cooker.py
 create mode 100644 lib/layerindexlib/plugin.py
 create mode 100644 lib/layerindexlib/restapi.py
 create mode 100644 lib/layerindexlib/tests/__init__.py
 create mode 100644 lib/layerindexlib/tests/common.py
 create mode 100644 lib/layerindexlib/tests/cooker.py
 create mode 100644 lib/layerindexlib/tests/layerindexobj.py
 create mode 100644 lib/layerindexlib/tests/restapi.py
 create mode 100644 lib/layerindexlib/tests/testdata/README
 create mode 100644 lib/layerindexlib/tests/testdata/build/conf/bblayers.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer1/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer2/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer3/conf/layer.conf
 create mode 100644 lib/layerindexlib/tests/testdata/layer4/conf/layer.conf

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index afe1603..7564de3 100755
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
+         "layerindexlib.tests.layerindexobj",
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
index 0000000..74f3e2e
--- /dev/null
+++ b/lib/layerindexlib/__init__.py
@@ -0,0 +1,1364 @@
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
+from collections import OrderedDict
+from layerindexlib.plugin import LayerIndexPluginUrlError
+
+logger = logging.getLogger('BitBake.layerindexlib')
+
+# Exceptions
+
+class LayerIndexException(Exception):
+    '''LayerIndex Generic Exception'''
+    def __init__(self, message):
+         self.msg = message
+         Exception.__init__(self, message)
+
+    def __str__(self):
+         return self.msg
+
+class LayerIndexUrlError(LayerIndexException):
+    '''Exception raised when unable to access a URL for some reason'''
+    def __init__(self, url, message=""):
+        if message:
+            msg = "Unable to access layerindex url %s: %s" % (url, message)
+        else:
+            msg = "Unable to access layerindex url %s" % url
+        self.url = url
+        LayerIndexException.__init__(self, msg)
+
+class LayerIndexFetchError(LayerIndexException):
+    '''General layerindex fetcher exception when something fails'''
+    def __init__(self, url, message=""):
+        if message:
+            msg = "Unable to fetch layerindex url %s: %s" % (url, message)
+        else:
+            msg = "Unable to fetch layerindex url %s" % url
+        self.url = url
+        LayerIndexException.__init__(self, msg)
+
+
+# Interface to the overall layerindex system
+# the layer may contain one or more individual indexes
+class LayerIndex():
+    def __init__(self, d):
+        if not d:
+            raise LayerIndexException("Must be initialized with bb.data.")
+
+        self.data = d
+
+        # List of LayerIndexObj
+        self.indexes = []
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
+        for indexEnt in self.indexes:
+            newIndex.indexes.append(indexEnt)
+
+        for indexEnt in other.indexes:
+            newIndex.indexes.append(indexEnt)
+
+        return newIndex
+
+    def _parse_params(self, params):
+        '''Take a parameter list, return a dictionary of parameters.
+
+           Expected to be called from the data of urllib.parse.urlparse(url).params
+
+           If there are two conflicting parameters, last in wins...
+        '''
+
+        param_dict = {}
+        for param in params.split(';'):
+           if not param:
+               continue
+           item = param.split('=', 1)
+           logger.debug(1, item)
+           param_dict[item[0]] = item[1]
+
+        return param_dict
+
+    def _fetch_url(self, url, username=None, password=None, debuglevel=0):
+        '''Fetch data from a specific URL.
+
+           Fetch something from a specific URL.  This is specifically designed to
+           fetch data from a layerindex-web instance, but may be useful for other
+           raw fetch actions.
+
+           It is not designed to be used to fetch recipe sources or similar.  the
+           regular fetcher class should used for that.
+
+           It is the responsibility of the caller to check BB_NO_NETWORK and related
+           BB_ALLOWED_NETWORKS.
+        '''
+
+        if not url:
+            raise LayerIndexUrlError(url, "empty url")
+
+        import urllib
+        from urllib.request import urlopen, Request
+        from urllib.parse import urlparse
+
+        up = urlparse(url)
+
+        if username:
+            logger.debug(1, "Configuring authentication for %s..." % url)
+            password_mgr = urllib.request.HTTPPasswordMgrWithDefaultRealm()
+            password_mgr.add_password(None, "%s://%s" % (up.scheme, up.netloc), username, password)
+            handler = urllib.request.HTTPBasicAuthHandler(password_mgr)
+            opener = urllib.request.build_opener(handler, urllib.request.HTTPSHandler(debuglevel=debuglevel))
+        else:
+            opener = urllib.request.build_opener(urllib.request.HTTPSHandler(debuglevel=debuglevel))
+
+        urllib.request.install_opener(opener)
+
+        logger.debug(1, "Fetching %s (%s)..." % (url, ["without authentication", "with authentication"][bool(username)]))
+
+        try:
+            res = urlopen(Request(url, headers={'User-Agent': 'Mozilla/5.0 (bitbake/lib/layerindex)'}, unverifiable=True))
+        except urllib.error.HTTPError as e:
+            logger.debug(1, "HTTP Error: %s: %s" % (e.code, e.reason))
+            logger.debug(1, " Requested: %s" % (url))
+            logger.debug(1, " Actual:    %s" % (e.geturl()))
+
+            if e.code == 404:
+                logger.debug(1, "Request not found.")
+                raise LayerIndexFetchError(url, e)
+            else:
+                logger.debug(1, "Headers:\n%s" % (e.headers))
+                raise LayerIndexFetchError(url, e)
+        except OSError as e:
+            error = 0
+            reason = ""
+
+            # Process base OSError first...
+            if hasattr(e, 'errno'):
+                error = e.errno
+                reason = e.strerror
+
+            # Process gaierror (socket error) subclass if available.
+            if hasattr(e, 'reason') and hasattr(e.reason, 'errno') and hasattr(e.reason, 'strerror'):
+                error = e.reason.errno
+                reason = e.reason.strerror
+                if error == -2:
+                    raise LayerIndexFetchError(url, "%s: %s" % (e, reason))
+
+            if error and error != 0:
+                raise LayerIndexFetchError(url, "Unexpected exception: [Error %s] %s" % (error, reason))
+            else:
+                raise LayerIndexFetchError(url, "Unable to fetch OSError exception: %s" % e)
+
+        finally:
+            logger.debug(1, "...fetching %s (%s), done." % (url, ["without authentication", "with authentication"][bool(username)]))
+
+        return res
+
+
+    def load_layerindex(self, indexURI, load=['layerDependencies', 'recipes', 'machines', 'distros'], reload=False):
+        '''Load the layerindex.
+
+           indexURI - An index to load.  (Use multiple calls to load multiple indexes)
+           
+           reload - If reload is True, then any previously loaded indexes will be forgotten.
+           
+           load - List of elements to load.  Default loads all items.
+                  Note: plugs may ignore this.
+
+The format of the indexURI:
+
+  <url>;branch=<branch>;cache=<cache>;desc=<description>
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
+  http://layers.openembedded.org/layerindex/api/;branch=master;desc=OpenEmbedded%20Layer%20Index
+  cooker://
+'''
+        if reload:
+            self.indexes = []
+
+        logger.debug(1, 'Loading: %s' % indexURI)
+
+        if not self.plugins:
+            raise LayerIndexException("No LayerIndex Plugins available")
+
+        for plugin in self.plugins:
+            # Check if the plugin was initialized
+            logger.debug(1, 'Trying %s' % plugin.__class__)
+            if not hasattr(plugin, 'type') or not plugin.type:
+                continue
+            try:
+                # TODO: Implement 'cache', for when the network is not available
+                indexEnt = plugin.load_index(indexURI, load)
+                break
+            except LayerIndexPluginUrlError as e:
+                logger.debug(1, "%s doesn't support %s" % (plugin.type, e.url))
+            except NotImplementedError:
+                pass
+        else:
+            logger.debug(1, "No plugins support %s" % indexURI)
+            raise LayerIndexException("No plugins support %s" % indexURI)
+
+        # Mark CONFIG data as something we've added...
+        indexEnt.config['local'] = []
+        indexEnt.config['local'].append('config')
+
+        # No longer permit changes..
+        indexEnt.lockData()
+
+        self.indexes.append(indexEnt)
+
+    def store_layerindex(self, indexURI, index=None):
+        '''Store one layerindex
+
+Typically this will be used to create a local cache file of a remote index.
+
+  file://<path>;branch=<branch>
+
+We can write out in either the restapi or django formats.  The split option
+will write out the individual elements split by layer and related components.
+'''
+        if not index:
+            logger.warning('No index to write, nothing to do.')
+            return
+
+        if not self.plugins:
+            raise LayerIndexException("No LayerIndex Plugins available")
+
+        for plugin in self.plugins:
+            # Check if the plugin was initialized
+            logger.debug(1, 'Trying %s' % plugin.__class__)
+            if not hasattr(plugin, 'type') or not plugin.type:
+                continue
+            try:
+                plugin.store_index(indexURI, index)
+                break
+            except LayerIndexPluginUrlError as e:
+                logger.debug(1, "%s doesn't support %s" % (plugin.type, e.url))
+            except NotImplementedError:
+                logger.debug(1, "Store not implemented in %s" % plugin.type)
+                pass
+        else:
+            logger.debug(1, "No plugins support %s" % url)
+            raise LayerIndexException("No plugins support %s" % url)
+
+
+    def is_empty(self):
+        '''Return True or False if the index has any usable data.
+
+We check the indexes entries to see if they have a branch set, as well as
+layerBranches set.  If not, they are effectively blank.'''
+
+        found = False
+        for index in self.indexes:
+            if index.__bool__():
+                found = True
+                break
+        return not found
+
+
+    def find_vcs_url(self, vcs_url, branch=None):
+        '''Return the first layerBranch with the given vcs_url
+
+           If a branch has not been specified, we will iterate over the branches in
+           the default configuration until the first vcs_url/branch match.'''
+
+        for index in self.indexes:
+            logger.debug(1, ' searching %s' % index.config['DESCRIPTION'])
+            layerBranch = index.find_vcs_url(vcs_url, [branch])
+            if layerBranch:
+                return layerBranch
+        return None
+
+    def find_collection(self, collection, version=None, branch=None):
+        '''Return the first layerBranch with the given collection name
+
+           If a branch has not been specified, we will iterate over the branches in
+           the default configuration until the first collection/branch match.'''
+
+        logger.debug(1, 'find_collection: %s (%s) %s' % (collection, version, branch))
+
+        if branch:
+            branches = [branch]
+        else:
+            branches = None
+
+        for index in self.indexes:
+            logger.debug(1, ' searching %s' % index.config['DESCRIPTION'])
+            layerBranch = index.find_collection(collection, version, branches)
+            if layerBranch:
+                return layerBranch
+        else:
+            logger.debug(1, 'Collection %s (%s) not found for branch (%s)' % (collection, version, branch))
+        return None
+
+    def find_layerbranch(self, name, branch=None):
+        '''Return the layerBranch item for a given name and branch
+
+           If a branch has not been specified, we will iterate over the branches in
+           the default configuration until the first name/branch match.'''
+
+        if branch:
+            branches = [branch]
+        else:
+            branches = None
+
+        for index in self.indexes:
+            layerBranch = index.find_layerbranch(name, branches)
+            if layerBranch:
+                return layerBranch
+        return None
+
+    def find_dependencies(self, names=None, layerbranches=None, ignores=None):
+        '''Return a tuple of all dependencies and valid items for the list of (layer) names
+
+        The dependency scanning happens depth-first.  The returned
+        dependencies should be in the best order to define bblayers.
+
+          names - list of layer names (searching layerItems)
+          branches - when specified (with names) only this list of branches are evaluated
+
+          layerbranches - list of layerbranches to resolve dependencies
+
+          ignores - list of layer names to ignore
+
+        return: (dependencies, invalid)
+
+          dependencies[LayerItem.name] = [ LayerBranch, LayerDependency1, LayerDependency2, ... ]
+          invalid = [ LayerItem.name1, LayerItem.name2, ... ]
+        '''
+
+        invalid = []
+
+        # Convert name/branch to layerbranches
+        if layerbranches is None:
+            layerbranches = []
+
+        for name in names:
+            if ignores and name in ignores:
+                continue
+
+            for index in self.indexes:
+                layerbranch = index.find_layerbranch(name)
+                if not layerbranch:
+                    # Not in this index, hopefully it's in another...
+                    continue
+                layerbranches.append(layerbranch)
+                break
+            else:
+                invalid.append(name)
+
+
+        def _resolve_dependencies(layerbranches, ignores, dependencies, invalid):
+            for layerbranch in layerbranches:
+                if ignores and layerbranch.layer.name in ignores:
+                    continue
+
+                # Get a list of dependencies and then recursively process them
+                for layerdependency in layerbranch.index.layerDependencies_layerBranchId[layerbranch.id]:
+                    deplayerbranch = layerdependency.dependency_layerBranch
+
+                    if ignores and deplayerbranch.layer.name in ignores:
+                        continue
+
+                    # This little block is why we can't re-use the LayerIndexObj version,
+                    # we must be able to satisfy each dependencies across layer indexes and
+                    # use the layer index order for priority.  (r stands for replacement below)
+
+                    # If this is the primary index, we can fast path and skip this
+                    if deplayerbranch.index != self.indexes[0]:
+                        # Is there an entry in a prior index for this collection/version?
+                        rdeplayerbranch = self.find_collection(
+                                              collection=deplayerbranch.collection,
+                                              version=deplayerbranch.version
+                                          )
+                        if rdeplayerbranch != deplayerbranch:
+                                logger.debug(1, 'Replaced %s:%s:%s with %s:%s:%s' % \
+                                      (deplayerbranch.index.config['DESCRIPTION'],
+                                       deplayerbranch.branch.name,
+                                       deplayerbranch.layer.name,
+                                       rdeplayerbranch.index.config['DESCRIPTION'],
+                                       rdeplayerbranch.branch.name,
+                                       rdeplayerbranch.layer.name))
+                                deplayerbranch = rdeplayerbranch
+
+                    # New dependency, we need to resolve it now... depth-first
+                    if deplayerbranch.layer.name not in dependencies:
+                        (dependencies, invalid) = _resolve_dependencies([deplayerbranch], ignores, dependencies, invalid)
+
+                    if deplayerbranch.layer.name not in dependencies:
+                        dependencies[deplayerbranch.layer.name] = [deplayerbranch, layerdependency]
+                    else:
+                        if layerdependency not in dependencies[deplayerbranch.layer.name]:
+                            dependencies[deplayerbranch.layer.name].append(layerdependency)
+
+            return (dependencies, invalid)
+
+        # OK, resolve this one...
+        dependencies = OrderedDict()
+        (dependencies, invalid) = _resolve_dependencies(layerbranches, ignores, dependencies, invalid)
+
+        for layerbranch in layerbranches:
+            if layerbranch.layer.name not in dependencies:
+                dependencies[layerbranch.layer.name] = [layerbranch]
+
+        return (dependencies, invalid)
+
+
+    def list_obj(self, object):
+        '''Print via the plain logger object information
+
+This function is used to implement debugging and provide the user info.
+'''
+        for lix in self.indexes:
+            if object not in lix:
+                continue
+
+            logger.plain ('')
+            logger.plain ('Index: %s' % lix.config['DESCRIPTION'])
+
+            output = []
+
+            if object == 'branches':
+                logger.plain ('%s %s %s' % ('{:26}'.format('branch'), '{:34}'.format('description'), '{:22}'.format('bitbake branch')))
+                logger.plain ('{:-^80}'.format(""))
+                for branchid in lix.branches:
+                    output.append('%s %s %s' % (
+                                  '{:26}'.format(lix.branches[branchid].name),
+                                  '{:34}'.format(lix.branches[branchid].short_description),
+                                  '{:22}'.format(lix.branches[branchid].bitbake_branch)
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'layerItems':
+                logger.plain ('%s %s' % ('{:26}'.format('layer'), '{:34}'.format('description')))
+                logger.plain ('{:-^80}'.format(""))
+                for layerid in lix.layerItems:
+                    output.append('%s %s' % (
+                                  '{:26}'.format(lix.layerItems[layerid].name),
+                                  '{:34}'.format(lix.layerItems[layerid].summary)
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'layerBranches':
+                logger.plain ('%s %s %s' % ('{:26}'.format('layer'), '{:34}'.format('description'), '{:19}'.format('collection:version')))
+                logger.plain ('{:-^80}'.format(""))
+                for layerbranchid in lix.layerBranches:
+                    output.append('%s %s %s' % (
+                                  '{:26}'.format(lix.layerBranches[layerbranchid].layer.name),
+                                  '{:34}'.format(lix.layerBranches[layerbranchid].layer.summary),
+                                  '{:19}'.format("%s:%s" %
+                                                          (lix.layerBranches[layerbranchid].collection,
+                                                           lix.layerBranches[layerbranchid].version)
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
+                for layerDependency in lix.layerDependencies:
+                    if not lix.layerDependencies[layerDependency].dependency_layerBranch:
+                        continue
+
+                    output.append('%s %s %s %s' % (
+                                  '{:19}'.format(lix.layerDependencies[layerDependency].layerbranch.branch.name),
+                                  '{:26}'.format(lix.layerDependencies[layerDependency].layerbranch.layer.name),
+                                  '{:11}'.format('requires' if lix.layerDependencies[layerDependency].required else 'recommends'),
+                                  '{:26}'.format(lix.layerDependencies[layerDependency].dependency_layerBranch.layer.name)
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
+                for recipe in lix.recipes:
+                    output.append('%s %s %s' % (
+                                  '{:30}'.format(lix.recipes[recipe].pn),
+                                  '{:30}'.format(lix.recipes[recipe].pv),
+                                  lix.recipes[recipe].layer.name
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'machines':
+                logger.plain ('%s %s %s' % ('{:24}'.format('machine'), '{:34}'.format('description'), '{:19}'.format('layer')))
+                logger.plain ('{:-^80}'.format(""))
+                for machine in lix.machines:
+                    output.append('%s %s %s' % (
+                                  '{:24}'.format(lix.machines[machine].name),
+                                  '{:34}'.format(lix.machines[machine].description)[:34],
+                                  '{:19}'.format(lix.machines[machine].layerbranch.layer.name)
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+            if object == 'distros':
+                logger.plain ('%s %s %s' % ('{:24}'.format('distro'), '{:34}'.format('description'), '{:19}'.format('layer')))
+                logger.plain ('{:-^80}'.format(""))
+                for distro in lix.distros:
+                    output.append('%s %s %s' % (
+                                  '{:24}'.format(lix.distros[distro].name),
+                                  '{:34}'.format(lix.distros[distro].description)[:34],
+                                  '{:19}'.format(lix.distros[distro].layerbranch.layer.name)
+                                 ))
+                for line in sorted(output):
+                    logger.plain (line)
+
+                continue
+
+        logger.plain ('')
+
+
+# This class holds a single layer index instance
+# The LayerIndexObj is made up of dictionary of elements, such as:
+#   index['config'] - configuration data for this index
+#   index['branches'] - dictionary of Branch objects, by id number
+#   index['layerItems'] - dictionary of layerItem objects, by id number
+#   ...etc...  (See: http://layers.openembedded.org/layerindex/api/)
+#
+# The class needs to manage the 'index' entries and allow easily adding
+# of new items, as well as simply loading of the items.
+class LayerIndexObj():
+    def __init__(self):
+        super().__setattr__('_index', {})
+        super().__setattr__('_lock', False)
+
+    def __bool__(self):
+        '''False if the index is effectively empty
+
+           We check the index to see if it has a branch set, as well as
+           layerbranches set.  If not, it is effectively blank.'''
+
+        if not bool(self._index):
+            return False
+
+        try:
+            if self.branches and self.layerBranches:
+                return True
+        except AttributeError:
+            pass
+
+        return False
+
+    def __getattr__(self, name):
+        if name.startswith('_'):
+            return super().__getattribute__(name)
+
+        if name not in self._index:
+            raise AttributeError('%s not in index datastore' % name)
+
+        return self._index[name]
+
+    def __setattr__(self, name, value):
+        if self.isLocked():
+            raise TypeError("Can not set attribute '%s': index is locked" % name)
+
+        if name.startswith('_'):
+            super().__setattr__(name, value)
+            return
+
+        self._index[name] = value
+
+    def __delattr__(self, name):
+        if self.isLocked():
+            raise TypeError("Can not delete attribute '%s': index is locked" % name)
+
+        if name.startswith('_'):
+            super().__delattr__(name)
+
+        self._index.pop(name)
+
+    def lockData(self):
+        '''Lock data object (make it readonly)'''
+        super().__setattr__("_lock", True)
+
+    def unlockData(self):
+        '''unlock data object (make it readonly)'''
+        super().__setattr__("_lock", False)
+
+        # When the data is unlocked, we have to clear the caches, as
+        # modification is allowed!
+        del(self._layerBranches_layerId_branchId)
+        del(self._layerDependencies_layerBranchId)
+        del(self._layerBranches_vcsUrl)
+
+    def isLocked(self):
+        '''Is this object locked (readonly)?'''
+        return self._lock
+
+    def add_element(self, indexname, objs):
+        '''Add a layer index object to index.<indexname>'''
+        if indexname not in self._index:
+            self._index[indexname] = {}
+
+        for obj in objs:
+            if obj.id in self._index[indexname]:
+                if self._index[indexname][obj.id] == obj:
+                    continue
+                raise LayerIndexError('Conflict adding object %s(%s) to index' % (indexname, obj.id))
+            self._index[indexname][obj.id] = obj
+
+    def add_raw_element(self, indexname, objtype, rawobjs):
+        '''Convert a raw layer index data item to a layer index item object and add to the index'''
+        objs = []
+        for entry in rawobjs:
+            objs.append(objtype(self, entry))
+        self.add_element(indexname, objs)
+
+    # Quick lookup table for searching layerId and branchID combos
+    @property
+    def layerBranches_layerId_branchId(self):
+        def createCache(self):
+            cache = {}
+            for layerbranchid in self.layerBranches:
+                layerbranch = self.layerBranches[layerbranchid]
+                cache["%s:%s" % (layerbranch.layer_id, layerbranch.branch_id)] = layerbranch
+            return cache
+
+        if self.isLocked():
+            cache = getattr(self, '_layerBranches_layerId_branchId', None)
+        else:
+            cache = None
+
+        if not cache:
+            cache = createCache(self)
+
+        if self.isLocked():
+            super().__setattr__('_layerBranches_layerId_branchId', cache)
+
+        return cache
+
+    # Quick lookup table for finding all dependencies of a layerBranch
+    @property
+    def layerDependencies_layerBranchId(self):
+        def createCache(self):
+            cache = {}
+            # This ensures empty lists for all branchids
+            for layerbranchid in self.layerBranches:
+                cache[layerbranchid] = []
+
+            for layerdependencyid in self.layerDependencies:
+                layerdependency = self.layerDependencies[layerdependencyid]
+                cache[layerdependency.layerbranch_id].append(layerdependency)
+            return cache
+
+        if self.isLocked():
+            cache = getattr(self, '_layerDependencies_layerBranchId', None)
+        else:
+            cache = None
+
+        if not cache:
+            cache = createCache(self)
+
+        if self.isLocked():
+            super().__setattr__('_layerDependencies_layerBranchId', cache)
+
+        return cache
+
+    # Quick lookup table for finding all instances of a vcs_url
+    @property
+    def layerBranches_vcsUrl(self):
+        def createCache(self):
+            cache = {}
+            for layerbranchid in self.layerBranches:
+                layerbranch = self.layerBranches[layerbranchid]
+                if layerbranch.layer.vcs_url not in cache:
+                   cache[layerbranch.layer.vcs_url] = [layerbranch]
+                else:
+                   cache[layerbranch.layer.vcs_url].append(layerbranch)
+            return cache
+
+        if self.isLocked():
+            cache = getattr(self, '_layerBranches_vcsUrl', None)
+        else:
+            cache = None
+
+        if not cache:
+            cache = createCache(self)
+
+        if self.isLocked():
+            super().__setattr__('_layerBranches_vcsUrl', cache)
+
+        return cache
+
+
+    def find_vcs_url(self, vcs_url, branches=None):
+        ''''Return the first layerBranch with the given vcs_url
+
+            If a list of branches has not been specified, we will iterate on
+            all branches until the first vcs_url is found.'''
+
+        if not self.__bool__():
+            return None
+
+        for layerbranch in self.layerBranches_vcsUrl:
+            if branches and layerbranch.branch.name not in branches:
+                continue
+
+            return layerbranch
+
+        return None
+
+
+    def find_collection(self, collection, version=None, branches=None):
+        '''Return the first layerBranch with the given collection name
+
+           If a list of branches has not been specified, we will iterate on
+           all branches until the first collection is found.'''
+
+        if not self.__bool__():
+            return None
+
+        for layerbranchid in self.layerBranches:
+            layerbranch = self.layerBranches[layerbranchid]
+            if branches and layerbranch.branch.name not in branches:
+                continue
+
+            if layerbranch.collection == collection and \
+                (version is None or version == layerbranch.version):
+                return layerbranch
+
+        return None
+
+
+    def find_layerbranch(self, name, branches=None):
+        '''Return the first layerbranch whose layer name matches
+
+           If a list of branches has not been specified, we will iterate on
+           all branches until the first layer with that name is found.'''
+
+        if not self.__bool__():
+            return None
+
+        for layerbranchid in self.layerBranches:
+            layerbranch = self.layerBranches[layerbranchid]
+            if branches and layerbranch.branch.name not in branches:
+                continue
+
+            if layerbranch.layer.name == name:
+                return layerbranch
+
+        return None
+
+    def find_dependencies(self, names=None, branches=None, layerBranches=None, ignores=None):
+        '''Return a tuple of all dependencies and valid items for the list of (layer) names
+
+        The dependency scanning happens depth-first.  The returned
+        dependencies should be in the best order to define bblayers.
+
+          names - list of layer names (searching layerItems)
+          branches - when specified (with names) only this list of branches are evaluated
+
+          layerBranches - list of layerBranches to resolve dependencies
+
+          ignores - list of layer names to ignore
+
+        return: (dependencies, invalid)
+
+          dependencies[LayerItem.name] = [ LayerBranch, LayerDependency1, LayerDependency2, ... ]
+          invalid = [ LayerItem.name1, LayerItem.name2, ... ]'''
+
+        invalid = []
+
+        # Convert name/branch to layerBranches
+        if layerbranches is None:
+            layerbranches = []
+
+        for name in names:
+            if ignores and name in ignores:
+                continue
+
+            layerbranch = self.find_layerbranch(name, branches)
+            if not layerbranch:
+                invalid.append(name)
+            else:
+                layerbranches.append(layerbranch)
+
+        for layerbranch in layerbranches:
+            if layerbranch.index != self:
+                raise LayerIndexException("Can not resolve dependencies across indexes with this class function!")
+
+        def _resolve_dependencies(layerbranches, ignores, dependencies, invalid):
+            for layerbranch in layerbranches:
+                if ignores and layerBranch.layer.name in ignores:
+                    continue
+
+                for layerdependency in layerbranch.index.layerDependencies_layerBranchId[layerBranch.id]:
+                    deplayerbranch = layerDependency.dependency_layerBranch
+
+                    if ignores and deplayerbranch.layer.name in ignores:
+                        continue
+
+                    # New dependency, we need to resolve it now... depth-first
+                    if deplayerbranch.layer.name not in dependencies:
+                        (dependencies, invalid) = _resolve_dependencies([deplayerbranch], ignores, dependencies, invalid)
+
+                    if deplayerbranch.layer.name not in dependencies:
+                        dependencies[deplayerbranch.layer.name] = [deplayerbranch, layerdependency]
+                    else:
+                        if layerdependency not in dependencies[deplayerbranch.layer.name]:
+                            dependencies[deplayerbranch.layer.name].append(layerdependency)
+
+                return (dependencies, invalid)
+
+        # OK, resolve this one...
+        dependencies = OrderedDict()
+        (dependencies, invalid) = _resolve_dependencies(layerbranches, ignores, dependencies, invalid)
+
+        # Is this item already in the list, if not add it
+        for layerbranch in layerbranches:
+            if layerbranch.layer.name not in dependencies:
+                dependencies[layerbranch.layer.name] = [layerbranch]
+
+        return (dependencies, invalid)
+
+
+# Define a basic LayerIndexItemObj.  This object forms the basis for all other
+# objects.  The raw Layer Index data is stored in the _data element, but we
+# do not want users to access data directly.  So wrap this and protect it
+# from direct manipulation.
+#
+# It is up to the insantiators of the objects to fill them out, and once done
+# lock the objects to prevent further accidently manipulation.
+#
+# Using the getattr, setattr and properties we can access and manipulate
+# the data within the data element.
+class LayerIndexItemObj():
+    def __init__(self, index, data=None, lock=False):
+        if data is None:
+            data = {}
+
+        if type(data) != type(dict()):
+            raise TypeError('data (%s) is not a dict' % type(data))
+
+        super().__setattr__('_lock',  lock)
+        super().__setattr__('index', index)
+        super().__setattr__('_data',  data)
+
+    def __eq__(self, other):
+        if self.__class__ != other.__class__:
+            return False
+        res=(self._data == other._data)
+        return res
+
+    def __bool__(self):
+        return bool(self._data)
+
+    def __getattr__(self, name):
+        # These are internal to THIS class, and not part of data
+        if name == "index" or name.startswith('_'):
+            return super().__getattribute__(name)
+
+        if name not in self._data:
+            raise AttributeError('%s not in datastore' % name)
+
+        return self._data[name]
+
+    def _setattr(self, name, value, prop=True):
+        '''__setattr__ like function, but with control over property object behavior'''
+        if self.isLocked():
+            raise TypeError("Can not set attribute '%s': Object data is locked" % name)
+
+        if name.startswith('_'):
+            super().__setattr__(name, value)
+            return
+
+        # Since __setattr__ runs before properties, we need to check if
+        # there is a setter property and then execute it
+        # ... or return self._data[name]
+        propertyobj = getattr(self.__class__, name, None)
+        if prop and isinstance(propertyobj, property):
+            if propertyobj.fset:
+                propertyobj.fset(self, value)
+            else:
+                raise AttributeError('Attribute %s is readonly, and may not be set' % name)
+        else:
+            self._data[name] = value
+
+    def __setattr__(self, name, value):
+        self._setattr(name, value, prop=True)
+
+    def _delattr(self, name, prop=True):
+        # Since __delattr__ runs before properties, we need to check if
+        # there is a deleter property and then execute it
+        # ... or we pop it ourselves..
+        propertyobj = getattr(self.__class__, name, None)
+        if prop and isinstance(propertyobj, property):
+            if propertyobj.fdel:
+                propertyobj.fdel(self)
+            else:
+                raise AttributeError('Attribute %s is readonly, and may not be deleted' % name)
+        else:
+            self._data.pop(name)
+
+    def __delattr__(self, name):
+        self._delattr(name, prop=True)
+
+    def lockData(self):
+        '''Lock data object (make it readonly)'''
+        super().__setattr__("_lock", True)
+
+    def unlockData(self):
+        '''unlock data object (make it readonly)'''
+        super().__setattr__("_lock", False)
+
+    def isLocked(self):
+        '''Is this object locked (readonly)?'''
+        return self._lock
+
+# Branch object
+class Branch(LayerIndexItemObj):
+    def define_data(self, id, name, bitbake_branch,
+                 short_description=None, sort_priority=1,
+                 updates_enabled=True, updated=None,
+                 update_environment=None):
+        self.id = id
+        self.name = name
+        self.bitbake_branch = bitbake_branch
+        self.short_description = short_description or name
+        self.sort_priority = sort_priority
+        self.updates_enabled = updates_enabled
+        self.updated = updated or datetime.datetime.today().isoformat()
+        self.update_environment = update_environment
+
+    @property
+    def name(self):
+        return self.__getattr__('name')
+
+    @name.setter
+    def name(self, value):
+        self._data['name'] = value
+
+        if self.bitbake_branch == value:
+            self.bitbake_branch = ""
+
+    @name.deleter
+    def name(self):
+        self._delattr('name', prop=False)
+
+    @property
+    def bitbake_branch(self):
+        try:
+            return self.__getattr__('bitbake_branch')
+        except AttributeError:
+            return self.name
+
+    @bitbake_branch.setter
+    def bitbake_branch(self, value):
+        if self.name == value:
+            self._data['bitbake_branch'] = ""
+        else:
+            self._data['bitbake_branch'] = value
+
+    @bitbake_branch.deleter
+    def bitbake_branch(self):
+        self._delattr('bitbake_branch', prop=False)
+
+
+class LayerItem(LayerIndexItemObj):
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
+        self.id = id
+        self.name = name
+        self.status = status
+        self.layer_type = layer_type
+        self.summary = summary or name
+        self.description = description or summary or name
+        self.vcs_url = vcs_url
+        self.vcs_web_url = vcs_web_url
+        self.vcs_web_tree_base_url = vcs_web_tree_base_url
+        self.vcs_web_file_base_url = vcs_web_file_base_url
+        self.index_preference = index_preference
+        self.classic = classic
+        self.updated = updated or datetime.datetime.today().isoformat()
+
+
+class LayerBranch(LayerIndexItemObj):
+    def define_data(self, id, collection, version, layer, branch,
+                 vcs_subdir="", vcs_last_fetch=None,
+                 vcs_last_rev=None, vcs_last_commit=None,
+                 actual_branch="",
+                 updated=None):
+        self.id = id
+        self.collection = collection
+        self.version = version
+        if type(layer) != type(LayerItem):
+            self.layer_id = layer
+        else:
+            self.layer = layer
+
+        if type(branch) != type(Branch):
+            self.branch_id = branch
+        else:
+            self.branch = branch
+
+        self.vcs_subdir = vcs_subdir
+        self.vcs_last_fetch = vcs_last_fetch
+        self.vcs_last_rev = vcs_last_rev
+        self.vcs_last_commit = vcs_last_commit
+        self.actual_branch = actual_branch
+        self.updated = updated or datetime.datetime.today().isoformat()
+
+    # This is a little odd, the _data attribute is 'layer', but it's really
+    # referring to the layer id.. so lets adjust this to make it useful
+    @property
+    def layer_id(self):
+        return self.__getattr__('layer')
+
+    @layer_id.setter
+    def layer_id(self, value):
+        self._setattr('layer', value, prop=False)
+
+    @layer_id.deleter
+    def layer_id(self):
+        self._delattr('layer', prop=False)
+
+    @property
+    def layer(self):
+        try:
+            return self.index.layerItems[self.layer_id]
+        except KeyError:
+            raise AttributeError('Unable to find layerItems in index to map layer_id %s' % self.layer_id)
+        except IndexError:
+            raise AttributeError('Unable to find layer_id %s in index layerItems' % self.layer_id)
+
+    @layer.setter
+    def layer(self, value):
+        if type(value) != type(LayerItem):
+            raise TypeError('value is not a LayerItem')
+        if self.index != value.index:
+            raise AttributeError('Object and value do not share the same index and thus key set.')
+        self.layer_id = value.id
+
+    @layer.deleter
+    def layer(self):
+        del self.layer_id
+
+    @property
+    def branch_id(self):
+        return self.__getattr__('branch')
+
+    @branch_id.setter
+    def branch_id(self, value):
+        self._setattr('branch', value, prop=False)
+
+    @branch_id.deleter
+    def branch_id(self):
+        self._delattr('branch', prop=False)
+
+    @property
+    def branch(self):
+        try:
+            logger.debug(1, "Get branch object from branches[%s]" % (self.branch_id))
+            return self.index.branches[self.branch_id]
+        except KeyError:
+            raise AttributeError('Unable to find branches in index to map branch_id %s' % self.branch_id)
+        except IndexError:
+            raise AttributeError('Unable to find branch_id %s in index branches' % self.branch_id)
+
+    @branch.setter
+    def branch(self, value):
+        if type(value) != type(LayerItem):
+            raise TypeError('value is not a LayerItem')
+        if self.index != value.index:
+            raise AttributeError('Object and value do not share the same index and thus key set.')
+        self.branch_id = value.id
+
+    @branch.deleter
+    def branch(self):
+        del self.branch_id
+
+    @property
+    def actual_branch(self):
+        if self.__getattr__('actual_branch'):
+            return self.__getattr__('actual_branch')
+        else:
+            return self.branch.name
+
+    @actual_branch.setter
+    def actual_branch(self, value):
+        logger.debug(1, "Set actual_branch to %s .. name is %s" % (value, self.branch.name))
+        if value != self.branch.name:
+            self._setattr('actual_branch', value, prop=False)
+        else:
+            self._setattr('actual_branch', '', prop=False)
+
+    @actual_branch.deleter
+    def actual_branch(self):
+        self._delattr('actual_branch', prop=False)
+
+# Extend LayerIndexItemObj with common LayerBranch manipulations
+# All of the remaining LayerIndex objects refer to layerbranch, and it is
+# up to the user to follow that back through the LayerBranch object into
+# the layer object to get various attributes.  So add an intermediate set
+# of attributes that can easily get us the layerbranch as well as layer.
+
+class LayerIndexItemObj_LayerBranch(LayerIndexItemObj):
+    @property
+    def layerbranch_id(self):
+        return self.__getattr__('layerbranch')
+
+    @layerbranch_id.setter
+    def layerbranch_id(self, value):
+        self._setattr('layerbranch', value, prop=False)
+
+    @layerbranch_id.deleter
+    def layerbranch_id(self):
+        self._delattr('layerbranch', prop=False)
+
+    @property
+    def layerbranch(self):
+        try:
+            return self.index.layerBranches[self.layerbranch_id]
+        except KeyError:
+            raise AttributeError('Unable to find layerBranches in index to map layerbranch_id %s' % self.layerbranch_id)
+        except IndexError:
+            raise AttributeError('Unable to find layerbranch_id %s in index branches' % self.layerbranch_id)
+
+    @layerbranch.setter
+    def layerbranch(self, value):
+        if type(value) != type(LayerBranch):
+            raise TypeError('value (%s) is not a layerBranch' % type(value))
+        if self.index != value.index:
+            raise AttributeError('Object and value do not share the same index and thus key set.')
+        self.layerbranch_id = value.id
+
+    @layerbranch.deleter
+    def layerbranch(self):
+        del self.layerbranch_id
+
+    @property
+    def layer_id(self):
+        return self.layerbranch.layer_id
+
+    # Doesn't make sense to set or delete layer_id
+
+    @property
+    def layer(self):
+        return self.layerbranch.layer
+
+    # Doesn't make sense to set or delete layer
+
+
+class LayerDependency(LayerIndexItemObj_LayerBranch):
+    def define_data(self, id, layerbranch, dependency, required=True):
+        self.id = id
+        if type(layerbranch) != type(LayerBranch):
+            self.layerbranch_id = layerbranch
+        else:
+            self.layerbranch = layerbranch
+        if type(dependency) != type(LayerDependency):
+            self.dependency_id = dependency
+        else:
+            self.dependency = dependency
+        self.required = required
+
+    @property
+    def dependency_id(self):
+        return self.__getattr__('dependency')
+
+    @dependency_id.setter
+    def dependency_id(self, value):
+        self._setattr('dependency', value, prop=False)
+
+    @dependency_id.deleter
+    def dependency_id(self):
+        self._delattr('dependency', prop=False)
+
+    @property
+    def dependency(self):
+        try:
+            return self.index.layerItems[self.dependency_id]
+        except KeyError:
+            raise AttributeError('Unable to find layerItems in index to map layerbranch_id %s' % self.dependency_id)
+        except IndexError:
+            raise AttributeError('Unable to find dependency_id %s in index layerItems' % self.dependency_id)
+
+    @dependency.setter
+    def dependency(self, value):
+        if type(value) != type(LayerDependency):
+            raise TypeError('value (%s) is not a dependency' % type(value))
+        if self.index != value.index:
+            raise AttributeError('Object and value do not share the same index and thus key set.')
+        self.dependency_id = value.id
+
+    @dependency.deleter
+    def dependency(self):
+        self._delattr('dependency', prop=False)
+
+    @property
+    def dependency_layerBranch(self):
+        layerid = self.dependency_id
+        branchid = self.layerbranch.branch_id
+
+        try:
+            return self.index.layerBranches_layerId_branchId["%s:%s" % (layerid, branchid)]
+        except IndexError:
+            # layerBranches_layerId_branchId -- but not layerId:branchId
+            raise AttributeError('Unable to find layerId:branchId %s:%s in index layerBranches_layerId_branchId' % (layerid, branchid))
+        except KeyError:
+            raise AttributeError('Unable to find layerId:branchId %s:%s in layerItems and layerBranches' % (layerid, branchid))
+
+    # dependency_layerBranch doesn't make sense to set or del
+
+
+class Recipe(LayerIndexItemObj_LayerBranch):
+    def define_data(self, id,
+                    filename, filepath, pn, pv, layerbranch,
+                    summary="", description="", section="", license="",
+                    homepage="", bugtracker="", provides="", bbclassextend="",
+                    inherits="", blacklisted="", updated=None):
+        self.id = id
+        self.filename = filename
+        self.filepath = filepath
+        self.pn = pn
+        self.pv = pv
+        self.summary = summary
+        self.description = description
+        self.section = section
+        self.license = license
+        self.homepage = homepage
+        self.bugtracker = bugtracker
+        self.provides = provides
+        self.bbclassextend = bbclassextend
+        self.inherits = inherits
+        self.updated = updated or datetime.datetime.today().isoformat()
+        self.blacklisted = blacklisted
+        if type(layerbranch) != type(LayerBranch):
+            self.layerbranch_id = layerbranch
+        else:
+            self.layerbranch = layerbranch
+
+    @property
+    def fullpath(self):
+        return os.path.join(self.filepath, self.filename)
+
+    # Set would need to understand how to split it
+    # del would we del both parts?
+
+    @property
+    def inherits(self):
+        if 'inherits' not in self._data:
+            # Older indexes may not have this, so emulate it
+            if '-image-' in self.pn:
+                return 'image'
+        return self.__getattr__('inherits')
+
+    @inherits.setter
+    def inherits(self, value):
+        return self._setattr('inherits', value, prop=False)
+
+    @inherits.deleter
+    def inherits(self):
+        return self._delattr('inherits', prop=False)
+
+
+class Machine(LayerIndexItemObj_LayerBranch):
+    def define_data(self, id,
+                    name, description, layerbranch,
+                    updated=None):
+        self.id = id
+        self.name = name
+        self.description = description
+        if type(layerbranch) != type(LayerBranch):
+            self.layerbranch_id = layerbranch
+        else:
+            self.layerbranch = layerbranch
+        self.updated = updated or datetime.datetime.today().isoformat()
+
+class Distro(LayerIndexItemObj_LayerBranch):
+    def define_data(self, id,
+                    name, description, layerbranch,
+                    updated=None):
+        self.id = id
+        self.name = name
+        self.description = description
+        if type(layerbranch) != type(LayerBranch):
+            self.layerbranch_id = layerbranch
+        else:
+            self.layerbranch = layerbranch
+        self.updated = updated or datetime.datetime.today().isoformat()
+
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
diff --git a/lib/layerindexlib/cooker.py b/lib/layerindexlib/cooker.py
new file mode 100644
index 0000000..248a597
--- /dev/null
+++ b/lib/layerindexlib/cooker.py
@@ -0,0 +1,341 @@
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
+from urllib.parse import unquote, urlparse
+
+import layerindexlib
+
+import layerindexlib.plugin
+
+logger = logging.getLogger('BitBake.layerindexlib.cooker')
+
+import bb.utils
+
+def plugin_init(plugins):
+    return CookerPlugin()
+
+class CookerPlugin(layerindexlib.plugin.IndexPlugin):
+    def __init__(self):
+        self.type = "cooker"
+
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
+        d = self.layerindex.data
+
+        if not branches:
+            raise LayerIndexFetchError("No branches specified for _load_bblayers!")
+
+        index = layerindexlib.LayerIndexObj()
+
+        branchId = 0
+        index.branches = {}
+
+        layerItemId = 0
+        index.layerItems = {}
+
+        layerBranchId = 0
+        index.layerBranches = {}
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
+        for branch in branches:
+            branchId += 1
+            index.branches[branchId] = layerindexlib.Branch(index, None)
+            index.branches[branchId].define_data(branchId, branch, bb_branch)
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
+            index.layerItems[layerItemId] = layerindexlib.LayerItem(index, None)
+            index.layerItems[layerItemId].define_data(layerItemId, layername, description=layerpath, vcs_url=layerurl)
+
+            for branchId in index.branches:
+                layerBranchId += 1
+                index.layerBranches[layerBranchId] = layerindexlib.LayerBranch(index, None)
+                index.layerBranches[layerBranchId].define_data(layerBranchId, entry, layerversion, layerItemId, branchId,
+                                               vcs_subdir=layersubdir, vcs_last_rev=layerrev, actual_branch=layerbranch)
+
+        return index
+
+
+    def load_index(self, url, load):
+        """
+            Fetches layer information from a build configuration.
+
+            The return value is a dictionary containing API,
+            layer, branch, dependency, recipe, machine, distro, information.
+
+            url type should be 'cooker'.
+            url path is ignored
+        """
+
+        up = urlparse(url)
+
+        if up.scheme != 'cooker':
+            raise layerindexlib.plugin.LayerIndexPluginUrlError(self.type, url)
+
+        d = self.layerindex.data
+
+        params = self.layerindex._parse_params(up.params)
+
+        # Only reason to pass a branch is to emulate them...
+        if 'branch' in params:
+            branches = params['branch'].split(',')
+        else:
+            branches = ['HEAD']
+
+        logger.debug(1, "Loading cooker data branches %s" % branches)
+
+        index = self._load_bblayers(branches=branches)
+
+        index.config = {}
+        index.config['TYPE'] = self.type
+        index.config['URL'] = url
+
+        if 'desc' in params:
+            index.config['DESCRIPTION'] = unquote(params['desc'])
+        else:
+            index.config['DESCRIPTION'] = 'local'
+
+        if 'cache' in params:
+            index.config['CACHE'] = params['cache']
+
+        index.config['BRANCH'] = branches
+
+        # ("layerDependencies", layerindexlib.LayerDependency)
+        layerDependencyId = 0
+        if "layerDependencies" in load:
+            index.layerDependencies = {}
+            for layerBranchId in index.layerBranches:
+                branchName = index.layerBranches[layerBranchId].branch.name
+                collection = index.layerBranches[layerBranchId].collection
+
+                def add_dependency(layerDependencyId, index, deps, required):
+                    try:
+                        depDict = bb.utils.explode_dep_versions2(deps)
+                    except bb.utils.VersionStringException as vse:
+                        bb.fatal('Error parsing LAYERDEPENDS_%s: %s' % (c, str(vse)))
+
+                    for dep, oplist in list(depDict.items()):
+                        # We need to search ourselves, so use the _ version...
+                        depLayerBranch = index.find_collection(dep, branches=[branchName])
+                        if not depLayerBranch:
+                            # Missing dependency?!
+                            logger.error('Missing dependency %s (%s)' % (dep, branchName))
+                            continue
+
+                        # We assume that the oplist matches...
+                        layerDependencyId += 1
+                        layerDependency = layerindexlib.LayerDependency(index, None)
+                        layerDependency.define_data(id=layerDependencyId,
+                                        required=required, layerbranch=layerBranchId,
+                                        dependency=depLayerBranch.layer_id)
+
+                        logger.debug(1, '%s requires %s' % (layerDependency.layer.name, layerDependency.dependency.name))
+                        index.add_element("layerDependencies", [layerDependency])
+
+                    return layerDependencyId
+
+                deps = d.getVar("LAYERDEPENDS_%s" % collection)
+                if deps:
+                    layerDependencyId = add_dependency(layerDependencyId, index, deps, True)
+
+                deps = d.getVar("LAYERRECOMMENDS_%s" % collection)
+                if deps:
+                    layerDependencyId = add_dependency(layerDependencyId, index, deps, False)
+
+        # Need to load recipes here (requires cooker access)
+        recipeId = 0
+        ## TODO: NOT IMPLEMENTED
+        # The code following this is an example of what needs to be
+        # implemented.  However, it does not work as-is.
+        if False and 'recipes' in load:
+            index.recipes = {}
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
+                    recipe = layerindexlib.Recipe(index, None)
+                    recipe.define_data(id=recipeId,
+                                   filename=filename, filepath=filepath,
+                                   pn=pn, pv=pv,
+                                   summary=pn, description=pn, section='?',
+                                   license='?', homepage='?', bugtracker='?',
+                                   provides='?', bbclassextend='?', inherits='?',
+                                   blacklisted='?', layerbranch=depBranchId)
+
+                    index = addElement("recipes", [recipe], index)
+
+        # ("machines", layerindexlib.Machine)
+        machineId = 0
+        if 'machines' in load:
+            index.machines = {}
+
+            for layerBranchId in index.layerBranches:
+                # load_bblayers uses the description to cache the actual path...
+                machine_path = index.layerBranches[layerBranchId].getDescription()
+                machine_path = os.path.join(machine_path, 'conf/machine')
+                if os.path.isdir(machine_path):
+                    for (dirpath, _, filenames) in os.walk(machine_path):
+                        # Ignore subdirs...
+                        if not dirpath.endswith('conf/machine'):
+                            continue
+                        for fname in filenames:
+                            if fname.endswith('.conf'):
+                                machineId += 1
+                                machine = layerindexlib.Machine(index, None)
+                                machine.define_data(id=machineId, name=fname[:-5],
+                                                    description=fname[:-5],
+                                                    layerbranch=collection_layerbranch[entry])
+
+                                index.add_element("machines", [machine])
+
+        # ("distros", layerindexlib.Distro)
+        distroId = 0
+        if 'distros' in load:
+            index.distros = {}
+
+            for layerBranchId in index.layerBranches:
+                # load_bblayers uses the description to cache the actual path...
+                distro_path = index.layerBranches[layerBranchId].getDescription()
+                distro_path = os.path.join(distro_path, 'conf/distro')
+                if os.path.isdir(distro_path):
+                    for (dirpath, _, filenames) in os.walk(distro_path):
+                        # Ignore subdirs...
+                        if not dirpath.endswith('conf/distro'):
+                            continue
+                        for fname in filenames:
+                            if fname.endswith('.conf'):
+                                distroId += 1
+                                distro = layerindexlib.Distro(index, None)
+                                distro.define_data(id=distroId, name=fname[:-5],
+                                                    description=fname[:-5],
+                                                    layerbranch=collection_layerbranch[entry])
+
+                                index.add_element("distros", [distro])
+
+        return index
diff --git a/lib/layerindexlib/plugin.py b/lib/layerindexlib/plugin.py
new file mode 100644
index 0000000..92a2e97
--- /dev/null
+++ b/lib/layerindexlib/plugin.py
@@ -0,0 +1,60 @@
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
+logger = logging.getLogger('BitBake.layerindexlib.plugin')
+
+class LayerIndexPluginException(Exception):
+    """LayerIndex Generic Exception"""
+    def __init__(self, message):
+         self.msg = message
+         Exception.__init__(self, message)
+
+    def __str__(self):
+         return self.msg
+
+class LayerIndexPluginUrlError(LayerIndexPluginException):
+    """Exception raised when a plugin does not support a given URL type"""
+    def __init__(self, plugin, url):
+        msg = "%s does not support %s:" % (plugin, url)
+        self.plugin = plugin
+        self.url = url
+        LayerIndexPluginException.__init__(self, msg)
+
+class IndexPlugin():
+    def __init__(self):
+        self.type = None
+
+    def init(self, layerindex):
+        self.layerindex = layerindex
+
+    def plugin_type(self):
+        return self.type
+
+    def load_index(self, uri):
+        raise NotImplementedError('load_index is not implemented')
+
+    def store_index(self, uri, index):
+        raise NotImplementedError('store_index is not implemented')
+
diff --git a/lib/layerindexlib/restapi.py b/lib/layerindexlib/restapi.py
new file mode 100644
index 0000000..d08eb20
--- /dev/null
+++ b/lib/layerindexlib/restapi.py
@@ -0,0 +1,398 @@
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
+from urllib.parse import unquote
+from urllib.parse import urlparse
+
+import layerindexlib
+import layerindexlib.plugin
+
+logger = logging.getLogger('BitBake.layerindexlib.restapi')
+
+def plugin_init(plugins):
+    return RestApiPlugin()
+
+class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
+    def __init__(self):
+        self.type = "restapi"
+
+    def load_index(self, url, load):
+        """
+            Fetches layer information from a local or remote layer index.
+
+            The return value is a LayerIndexObj.
+
+            url is the url to the rest api of the layer index, such as:
+            http://layers.openembedded.org/layerindex/api/
+
+            Or a local file...
+        """
+
+        up = urlparse(url)
+
+        if up.scheme == 'file':
+            return self.load_index_file(up, url, load)
+
+        if up.scheme == 'http' or up.scheme == 'https':
+            return self.load_index_web(up, url, load)
+
+        raise layerindexlib.plugin.LayerIndexPluginUrlError(self.type, url)
+
+
+    def load_index_file(self, up, url, load):
+        """
+            Fetches layer information from a local file or directory.
+
+            The return value is a LayerIndexObj.
+
+            ud is the parsed url to the local file or directory.
+        """
+        if not os.path.exists(up.path):
+            raise FileNotFoundError(up.path)
+
+        index = layerindexlib.LayerIndexObj()
+
+        index.config = {}
+        index.config['TYPE'] = self.type
+        index.config['URL'] = url
+
+        params = self.layerindex._parse_params(up.params)
+
+        if 'desc' in params:
+            index.config['DESCRIPTION'] = unquote(params['desc'])
+        else:
+            index.config['DESCRIPTION'] = up.path
+
+        if 'cache' in params:
+            index.config['CACHE'] = params['cache']
+
+        if 'branch' in params:
+            branches = params['branch'].split(',')
+            index.config['BRANCH'] = branches
+        else:
+            branches = ['*']
+
+
+        def load_cache(path, index, branches=[]):
+            logger.debug(1, 'Loading json file %s' % path)
+            with open(path, 'rt', encoding='utf-8') as f:
+                pindex = json.load(f)
+
+            # Filter the branches on loaded files...
+            newpBranch = []
+            for branch in branches:
+                if branch != '*':
+                    if 'branches' in pindex:
+                        for br in pindex['branches']:
+                            if br['name'] == branch:
+                                newpBranch.append(br)
+                else:
+                    if 'branches' in pindex:
+                        for br in pindex['branches']:
+                            newpBranch.append(br)
+
+            if newpBranch:
+                index.add_raw_element('branches', layerindexlib.Branch, newpBranch)
+            else:
+                logger.debug(1, 'No matching branches (%s) in index file(s)' % branches)
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
+                    index.add_raw_element(lName, lType, pindex[lName])
+
+
+        if not os.path.isdir(up.path):
+            load_cache(up.path, index, branches)
+            return index
+
+        logger.debug(1, 'Loading from dir %s...' % (up.path))
+        for (dirpath, _, filenames) in os.walk(up.path):
+            for filename in filenames:
+                if not filename.endswith('.json'):
+                    continue
+                fpath = os.path.join(dirpath, filename)
+                load_cache(fpath, index, branches)
+
+        return index
+
+
+    def load_index_web(self, up, url, load):
+        """
+            Fetches layer information from a remote layer index.
+
+            The return value is a LayerIndexObj.
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
+            up = urlparse(apiurl)
+
+            username=up.username
+            password=up.password
+
+            # Strip username/password and params
+            if up.port:
+                up_stripped = up._replace(params="", netloc="%s:%s" % (up.hostname, up.port))
+            else:
+                up_stripped = up._replace(params="", netloc=up.hostname)
+
+            res = self.layerindex._fetch_url(up_stripped.geturl(), username=username, password=password)
+
+            try:
+                parsed = json.loads(res.read().decode('utf-8'))
+            except ConnectionResetError:
+                if retry:
+                    logger.debug(1, "%s: Connection reset by peer.  Retrying..." % url)
+                    parsed = _get_json_response(apiurl=up_stripped.geturl(), username=username, password=password, retry=False)
+                    logger.debug(1, "%s: retry successful.")
+                else:
+                    raise LayerIndexFetchError('%s: Connection reset by peer.  Is there a firewall blocking your connection?' % apiurl)
+
+            return parsed
+
+        index = layerindexlib.LayerIndexObj()
+
+        index.config = {}
+        index.config['TYPE'] = self.type
+        index.config['URL'] = url
+
+        params = self.layerindex._parse_params(up.params)
+
+        if 'desc' in params:
+            index.config['DESCRIPTION'] = unquote(params['desc'])
+        else:
+            index.config['DESCRIPTION'] = up.hostname
+
+        if 'cache' in params:
+            index.config['CACHE'] = params['cache']
+
+        if 'branch' in params:
+            branches = params['branch'].split(',')
+            index.config['BRANCH'] = branches
+        else:
+            branches = ['*']
+
+        try:
+            index.apilinks = _get_json_response(apiurl=url, username=up.username, password=up.password)
+        except Exception as e:
+            raise layerindexlib.LayerIndexFetchError(url, e)
+
+        # Local raw index set...
+        pindex = {}
+
+        # Load all the requested branches at the same time time,
+        # a special branch of '*' means load all branches
+        filter = ""
+        if "*" not in branches:
+            filter = "?filter=name:%s" % "OR".join(branches)
+
+        logger.debug(1, "Loading %s from %s" % (branches, index.apilinks['branches']))
+
+        # The link won't include username/password, so pull it from the original url
+        pindex['branches'] = _get_json_response(index.apilinks['branches'] + filter,
+                                                    username=up.username, password=up.password)
+        if not pindex['branches']:
+            logger.debug(1, "No valid branches (%s) found at url %s." % (branch, url))
+            return index
+        index.add_raw_element("branches", layerindexlib.Branch, pindex['branches'])
+
+        # Load all of the layerItems (these can not be easily filtered)
+        logger.debug(1, "Loading %s from %s" % ('layerItems', index.apilinks['layerItems']))
+
+
+        # The link won't include username/password, so pull it from the original url
+        pindex['layerItems'] = _get_json_response(index.apilinks['layerItems'],
+                                                  username=up.username, password=up.password)
+        if not pindex['layerItems']:
+            logger.debug(1, "No layers were found at url %s." % (url))
+            return index
+        index.add_raw_element("layerItems", layerindexlib.LayerItem, pindex['layerItems'])
+
+
+	# From this point on load the contents for each branch.  Otherwise we
+	# could run into a timeout.
+        for branch in index.branches:
+            filter = "?filter=branch__name:%s" % index.branches[branch].name
+
+            logger.debug(1, "Loading %s from %s" % ('layerBranches', index.apilinks['layerBranches']))
+
+            # The link won't include username/password, so pull it from the original url
+            pindex['layerBranches'] = _get_json_response(index.apilinks['layerBranches'] + filter,
+                                                  username=up.username, password=up.password)
+            if not pindex['layerBranches']:
+                logger.debug(1, "No valid layer branches (%s) found at url %s." % (branches or "*", url))
+                return index
+            index.add_raw_element("layerBranches", layerindexlib.LayerBranch, pindex['layerBranches'])
+
+
+            # Load the rest, they all have a similar format
+            # Note: the layer index has a few more items, we can add them if necessary
+            # in the future.
+            filter = "?filter=layerbranch__branch__name:%s" % index.branches[branch].name
+            for (lName, lType) in [("layerDependencies", layerindexlib.LayerDependency),
+                                   ("recipes", layerindexlib.Recipe),
+                                   ("machines", layerindexlib.Machine),
+                                   ("distros", layerindexlib.Distro)]:
+                if lName not in load:
+                    continue
+                logger.debug(1, "Loading %s from %s" % (lName, index.apilinks[lName]))
+
+                # The link won't include username/password, so pull it from the original url
+                pindex[lName] = _get_json_response(index.apilinks[lName] + filter,
+                                            username=up.username, password=up.password)
+                index.add_raw_element(lName, lType, pindex[lName])
+
+        return index
+
+    def store_index(self, url, index):
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
+        up = urlparse(url)
+
+        if up.scheme != 'file':
+            raise layerindexlib.plugin.LayerIndexPluginUrlError(self.type, url)
+
+        logger.debug(1, "Storing to %s..." % up.path)
+
+        try:
+            layerbranches = index.layerBranches
+        except KeyError:
+            logger.error('No layerBranches to write.')
+            return
+
+
+        def filter_item(layerbranchid, objects):
+            filtered = []
+            for obj in getattr(index, objects, None):
+                try:
+                    if getattr(index, objects)[obj].layerbranch_id == layerbranchid:
+                       filtered.append(getattr(index, objects)[obj]._data)
+                except AttributeError:
+                    logger.debug(1, 'No obj.layerbranch_id: %s' % objects)
+                    # No simple filter method, just include it...
+                    try:
+                        filtered.append(getattr(index, objects)[obj]._data)
+                    except AttributeError:
+                        logger.debug(1, 'No obj._data: %s %s' % (objects, type(obj)))
+                        filtered.append(obj)
+            return filtered
+
+
+        # Write out to a single file.
+        # Filter out unnecessary items, then sort as we write for determinism
+        if not os.path.isdir(up.path):
+            pindex = {}
+
+            pindex['branches'] = []
+            pindex['layerItems'] = []
+            pindex['layerBranches'] = []
+
+            for layerbranchid in layerbranches:
+                if layerbranches[layerbranchid].branch._data not in pindex['branches']:
+                    pindex['branches'].append(layerbranches[layerbranchid].branch._data)
+
+                if layerbranches[layerbranchid].layer._data not in pindex['layerItems']:
+                    pindex['layerItems'].append(layerbranches[layerbranchid].layer._data)
+
+                if layerbranches[layerbranchid]._data not in pindex['layerBranches']:
+                    pindex['layerBranches'].append(layerbranches[layerbranchid]._data)
+
+                for entry in index._index:
+                    # Skip local items, apilinks and items already processed
+                    if entry in index.config['local'] or \
+                       entry == 'apilinks' or \
+                       entry == 'branches' or \
+                       entry == 'layerBranches' or \
+                       entry == 'layerItems':
+                        continue
+                    if entry not in pindex:
+                        pindex[entry] = []
+                    pindex[entry].extend(filter_item(layerbranchid, entry))
+
+            bb.debug(1, 'Writing index to %s' % up.path)
+            with open(up.path, 'wt') as f:
+                json.dump(layerindexlib.sort_entry(pindex), f, indent=4)
+            return
+
+
+        # Write out to a directory one file per layerBranch
+        # Prepare all layer related items, to create a minimal file.
+        # We have to sort the entries as we write so they are deterministic
+        for layerbranchid in layerbranches:
+            pindex = {}
+
+            for entry in index._index:
+                # Skip local items, apilinks and items already processed
+                if entry in index.config['local'] or \
+                   entry == 'apilinks' or \
+                   entry == 'branches' or \
+                   entry == 'layerBranches' or \
+                   entry == 'layerItems':
+                    continue
+                pindex[entry] = filter_item(layerbranchid, entry)
+
+            # Add the layer we're processing as the first one...
+            pindex['branches'] = [layerbranches[layerbranchid].branch._data]
+            pindex['layerItems'] = [layerbranches[layerbranchid].layer._data]
+            pindex['layerBranches'] = [layerbranches[layerbranchid]._data]
+
+            # We also need to include the layerbranch for any dependencies...
+            for layerdep in pindex['layerDependencies']:
+                layerdependency = layerindexlib.LayerDependency(index, layerdep)
+
+                layeritem = layerdependency.dependency
+                layerbranch = layerdependency.dependency_layerBranch
+
+                # We need to avoid duplicates...
+                if layeritem._data not in pindex['layerItems']:
+                    pindex['layerItems'].append(layeritem._data)
+
+                if layerbranch._data not in pindex['layerBranches']:
+                    pindex['layerBranches'].append(layerbranch._data)
+
+            # apply mirroring adjustments here....
+
+            fname = index.config['DESCRIPTION'] + '__' + pindex['branches'][0]['name'] + '__' + pindex['layerItems'][0]['name']
+            fname = fname.translate(str.maketrans('/ ', '__'))
+            fpath = os.path.join(up.path, fname)
+
+            bb.debug(1, 'Writing index to %s' % fpath + '.json')
+            with open(fpath + '.json', 'wt') as f:
+                json.dump(layerindexlib.sort_entry(pindex), f, indent=4)
diff --git a/lib/layerindexlib/tests/__init__.py b/lib/layerindexlib/tests/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/layerindexlib/tests/common.py b/lib/layerindexlib/tests/common.py
new file mode 100644
index 0000000..22a5458
--- /dev/null
+++ b/lib/layerindexlib/tests/common.py
@@ -0,0 +1,43 @@
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
+        # At least one variable needs to be set
+        self.d.setVar('DL_DIR', os.getcwd())
+
+        if os.environ.get("BB_SKIP_NETTESTS") == "yes":
+            self.d.setVar('BB_NO_NETWORK', '1')
+
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
index 0000000..9ce6e8c
--- /dev/null
+++ b/lib/layerindexlib/tests/cooker.py
@@ -0,0 +1,123 @@
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
+        self.layerindex = layerindexlib.LayerIndex(self.d)
+        self.layerindex.load_layerindex('cooker://', load=['layerDependencies'])
+
+    def test_layerindex_is_empty(self):
+        self.assertFalse(self.layerindex.is_empty(), msg="Layerindex is not empty!")
+
+    def test_dependency_resolution(self):
+        # Verify depth first searching...
+        (dependencies, invalidnames) = self.layerindex.find_dependencies(names=['meta-python'])
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
+            self.assertEqual(layerBranch.layer.name, "openembedded-core", msg='Top dependency not openembedded-core')
+
+            # meta-python should cause an openembedded-core dependency, if not assert!
+            for dep in layerDeps:
+                if dep.layer.name == 'meta-python':
+                    break
+            else:
+                self.assertTrue(False, msg='meta-python was not found')
+
+            # Only check the first element...
+            break
+        else:
+            if first:
+                # Empty list, this is bad.
+                self.assertTrue(False, msg='Empty list of dependencies')
+
+            # Last dep should be the requested item
+            layerBranch = dependencies[deplayerbranch][0]
+            self.assertEqual(layerBranch.layer.name, "meta-python", msg='Last dependency not meta-python')
+
+    def test_find_collection(self):
+        def _check(collection, expected):
+            self.logger.debug(1, "Looking for collection %s..." % collection)
+            result = self.layerindex.find_collection(collection)
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
+    def test_find_layerbranch(self):
+        def _check(name, expected):
+            self.logger.debug(1, "Looking for layerbranch %s..." % name)
+            result = self.layerindex.find_layerbranch(name)
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
diff --git a/lib/layerindexlib/tests/layerindexobj.py b/lib/layerindexlib/tests/layerindexobj.py
new file mode 100644
index 0000000..e2fbb95
--- /dev/null
+++ b/lib/layerindexlib/tests/layerindexobj.py
@@ -0,0 +1,226 @@
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
+class LayerIndexObjectsTest(LayersTest):
+    def setUp(self):
+        from layerindexlib import LayerIndexObj, Branch, LayerItem, LayerBranch, LayerDependency, Recipe, Machine, Distro
+
+        LayersTest.setUp(self)
+
+        self.index = LayerIndexObj()
+
+        branchId = 0
+        layerItemId = 0
+        layerBranchId = 0
+        layerDependencyId = 0
+        recipeId = 0
+        machineId = 0
+        distroId = 0
+
+        self.index.branches = {}
+        self.index.layerItems = {}
+        self.index.layerBranches = {}
+        self.index.layerDependencies = {}
+        self.index.recipes = {}
+        self.index.machines = {}
+        self.index.distros = {}
+
+        branchId += 1
+        self.index.branches[branchId] = Branch(self.index)
+        self.index.branches[branchId].define_data(branchId,
+                                        'test_branch', 'bb_test_branch')
+        self.index.branches[branchId].lockData()
+
+        layerItemId +=1
+        self.index.layerItems[layerItemId] = LayerItem(self.index)
+        self.index.layerItems[layerItemId].define_data(layerItemId,
+                                        'test_layerItem', vcs_url='git://git_test_url/test_layerItem')
+        self.index.layerItems[layerItemId].lockData()
+
+        layerBranchId +=1
+        self.index.layerBranches[layerBranchId] = LayerBranch(self.index)
+        self.index.layerBranches[layerBranchId].define_data(layerBranchId,
+                                        'test_collection', '99', layerItemId,
+                                        branchId)
+
+        recipeId += 1
+        self.index.recipes[recipeId] = Recipe(self.index)
+        self.index.recipes[recipeId].define_data(recipeId, 'test_git.bb',
+                                        'recipes-test', 'test', 'git',
+                                        layerBranchId)
+
+        machineId += 1
+        self.index.machines[machineId] = Machine(self.index)
+        self.index.machines[machineId].define_data(machineId,
+                                        'test_machine', 'test_machine',
+                                        layerBranchId)
+
+        distroId += 1
+        self.index.distros[distroId] = Distro(self.index)
+        self.index.distros[distroId].define_data(distroId,
+                                        'test_distro', 'test_distro',
+                                        layerBranchId)
+
+        layerItemId +=1
+        self.index.layerItems[layerItemId] = LayerItem(self.index)
+        self.index.layerItems[layerItemId].define_data(layerItemId, 'test_layerItem 2',
+                                        vcs_url='git://git_test_url/test_layerItem')
+
+        layerBranchId +=1
+        self.index.layerBranches[layerBranchId] = LayerBranch(self.index)
+        self.index.layerBranches[layerBranchId].define_data(layerBranchId,
+                                        'test_collection_2', '72', layerItemId,
+                                        branchId, actual_branch='some_other_branch')
+
+        layerDependencyId += 1
+        self.index.layerDependencies[layerDependencyId] = LayerDependency(self.index)
+        self.index.layerDependencies[layerDependencyId].define_data(layerDependencyId,
+                                        layerBranchId, 1)
+
+        layerDependencyId += 1
+        self.index.layerDependencies[layerDependencyId] = LayerDependency(self.index)
+        self.index.layerDependencies[layerDependencyId].define_data(layerDependencyId,
+                                        layerBranchId, 1, required=False)
+
+    def test_branch(self):
+        branch = self.index.branches[1]
+        self.assertEqual(branch.id, 1)
+        self.assertEqual(branch.name, 'test_branch')
+        self.assertEqual(branch.short_description, 'test_branch')
+        self.assertEqual(branch.bitbake_branch, 'bb_test_branch')
+
+    def test_layerItem(self):
+        layerItem = self.index.layerItems[1]
+        self.assertEqual(layerItem.id, 1)
+        self.assertEqual(layerItem.name, 'test_layerItem')
+        self.assertEqual(layerItem.summary, 'test_layerItem')
+        self.assertEqual(layerItem.description, 'test_layerItem')
+        self.assertEqual(layerItem.vcs_url, 'git://git_test_url/test_layerItem')
+        self.assertEqual(layerItem.vcs_web_url, None)
+        self.assertIsNone(layerItem.vcs_web_tree_base_url)
+        self.assertIsNone(layerItem.vcs_web_file_base_url)
+        self.assertIsNotNone(layerItem.updated)
+
+        layerItem = self.index.layerItems[2]
+        self.assertEqual(layerItem.id, 2)
+        self.assertEqual(layerItem.name, 'test_layerItem 2')
+        self.assertEqual(layerItem.summary, 'test_layerItem 2')
+        self.assertEqual(layerItem.description, 'test_layerItem 2')
+        self.assertEqual(layerItem.vcs_url, 'git://git_test_url/test_layerItem')
+        self.assertIsNone(layerItem.vcs_web_url)
+        self.assertIsNone(layerItem.vcs_web_tree_base_url)
+        self.assertIsNone(layerItem.vcs_web_file_base_url)
+        self.assertIsNotNone(layerItem.updated)
+
+    def test_layerBranch(self):
+        layerBranch = self.index.layerBranches[1]
+        self.assertEqual(layerBranch.id, 1)
+        self.assertEqual(layerBranch.collection, 'test_collection')
+        self.assertEqual(layerBranch.version, '99')
+        self.assertEqual(layerBranch.vcs_subdir, '')
+        self.assertEqual(layerBranch.actual_branch, 'test_branch')
+        self.assertIsNotNone(layerBranch.updated)
+        self.assertEqual(layerBranch.layer_id, 1)
+        self.assertEqual(layerBranch.branch_id, 1)
+        self.assertEqual(layerBranch.layer, self.index.layerItems[1])
+        self.assertEqual(layerBranch.branch, self.index.branches[1])
+
+        layerBranch = self.index.layerBranches[2]
+        self.assertEqual(layerBranch.id, 2)
+        self.assertEqual(layerBranch.collection, 'test_collection_2')
+        self.assertEqual(layerBranch.version, '72')
+        self.assertEqual(layerBranch.vcs_subdir, '')
+        self.assertEqual(layerBranch.actual_branch, 'some_other_branch')
+        self.assertIsNotNone(layerBranch.updated)
+        self.assertEqual(layerBranch.layer_id, 2)
+        self.assertEqual(layerBranch.branch_id, 1)
+        self.assertEqual(layerBranch.layer, self.index.layerItems[2])
+        self.assertEqual(layerBranch.branch, self.index.branches[1])
+
+    def test_layerDependency(self):
+        layerDependency = self.index.layerDependencies[1]
+        self.assertEqual(layerDependency.id, 1)
+        self.assertEqual(layerDependency.layerbranch_id, 2)
+        self.assertEqual(layerDependency.layerbranch, self.index.layerBranches[2])
+        self.assertEqual(layerDependency.layer_id, 2)
+        self.assertEqual(layerDependency.layer, self.index.layerItems[2])
+        self.assertTrue(layerDependency.required)
+        self.assertEqual(layerDependency.dependency_id, 1)
+        self.assertEqual(layerDependency.dependency, self.index.layerItems[1])
+        self.assertEqual(layerDependency.dependency_layerBranch, self.index.layerBranches[1])
+
+        layerDependency = self.index.layerDependencies[2]
+        self.assertEqual(layerDependency.id, 2)
+        self.assertEqual(layerDependency.layerbranch_id, 2)
+        self.assertEqual(layerDependency.layerbranch, self.index.layerBranches[2])
+        self.assertEqual(layerDependency.layer_id, 2)
+        self.assertEqual(layerDependency.layer, self.index.layerItems[2])
+        self.assertFalse(layerDependency.required)
+        self.assertEqual(layerDependency.dependency_id, 1)
+        self.assertEqual(layerDependency.dependency, self.index.layerItems[1])
+        self.assertEqual(layerDependency.dependency_layerBranch, self.index.layerBranches[1])
+
+    def test_recipe(self):
+        recipe = self.index.recipes[1]
+        self.assertEqual(recipe.id, 1)
+        self.assertEqual(recipe.layerbranch_id, 1)
+        self.assertEqual(recipe.layerbranch, self.index.layerBranches[1])
+        self.assertEqual(recipe.layer_id, 1)
+        self.assertEqual(recipe.layer, self.index.layerItems[1])
+        self.assertEqual(recipe.filename, 'test_git.bb')
+        self.assertEqual(recipe.filepath, 'recipes-test')
+        self.assertEqual(recipe.fullpath, 'recipes-test/test_git.bb')
+        self.assertEqual(recipe.summary, "")
+        self.assertEqual(recipe.description, "")
+        self.assertEqual(recipe.section, "")
+        self.assertEqual(recipe.pn, 'test')
+        self.assertEqual(recipe.pv, 'git')
+        self.assertEqual(recipe.license, "")
+        self.assertEqual(recipe.homepage, "")
+        self.assertEqual(recipe.bugtracker, "")
+        self.assertEqual(recipe.provides, "")
+        self.assertIsNotNone(recipe.updated)
+        self.assertEqual(recipe.inherits, "")
+
+    def test_machine(self):
+        machine = self.index.machines[1]
+        self.assertEqual(machine.id, 1)
+        self.assertEqual(machine.layerbranch_id, 1)
+        self.assertEqual(machine.layerbranch, self.index.layerBranches[1])
+        self.assertEqual(machine.layer_id, 1)
+        self.assertEqual(machine.layer, self.index.layerItems[1])
+        self.assertEqual(machine.name, 'test_machine')
+        self.assertEqual(machine.description, 'test_machine')
+        self.assertIsNotNone(machine.updated)
+
+    def test_distro(self):
+        distro = self.index.distros[1]
+        self.assertEqual(distro.id, 1)
+        self.assertEqual(distro.layerbranch_id, 1)
+        self.assertEqual(distro.layerbranch, self.index.layerBranches[1])
+        self.assertEqual(distro.layer_id, 1)
+        self.assertEqual(distro.layer, self.index.layerItems[1])
+        self.assertEqual(distro.name, 'test_distro')
+        self.assertEqual(distro.description, 'test_distro')
+        self.assertIsNotNone(distro.updated)
diff --git a/lib/layerindexlib/tests/restapi.py b/lib/layerindexlib/tests/restapi.py
new file mode 100644
index 0000000..bfaac43
--- /dev/null
+++ b/lib/layerindexlib/tests/restapi.py
@@ -0,0 +1,174 @@
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
+            self.layerindex = layerindexlib.LayerIndex(self.d)
+            self.layerindex.load_layerindex('http://layers.openembedded.org/layerindex/api/;branch=sumo', load=['layerDependencies'])
+
+        def test_layerindex_is_empty(self):
+            self.assertFalse(self.layerindex.is_empty(), msg="Layerindex is empty")
+
+        def test_layerindex_store_file(self):
+            self.layerindex.store_layerindex('file://%s/file.json' % self.tempdir, self.layerindex.indexes[0])
+
+            self.assertTrue(os.path.isfile('%s/file.json' % self.tempdir), msg="Temporary file was not created by store_layerindex")
+
+            reload = layerindexlib.LayerIndex(self.d)
+            reload.load_layerindex('file://%s/file.json' % self.tempdir)
+
+            self.assertFalse(reload.is_empty(), msg="Layerindex is empty")
+
+            # Calculate layerItems in original index that should NOT be in reload
+            layerItemNames = []
+            for itemId in self.layerindex.indexes[0].layerItems:
+                layerItemNames.append(self.layerindex.indexes[0].layerItems[itemId].name)
+
+            for layerBranchId in self.layerindex.indexes[0].layerBranches:
+                layerItemNames.remove(self.layerindex.indexes[0].layerBranches[layerBranchId].layer.name)
+
+            for itemId in reload.indexes[0].layerItems:
+                self.assertFalse(reload.indexes[0].layerItems[itemId].name in layerItemNames, msg="Item reloaded when it shouldn't have been")
+
+            # Compare the original to what we wrote...
+            for type in self.layerindex.indexes[0]._index:
+                if type == 'apilinks' or \
+                   type == 'layerItems' or \
+                   type in self.layerindex.indexes[0].config['local']:
+                    continue
+                for id in getattr(self.layerindex.indexes[0], type):
+                    self.logger.debug(1, "type %s" % (type))
+
+                    self.assertTrue(id in getattr(reload.indexes[0], type), msg="Id number not in reloaded index")
+
+                    self.logger.debug(1, "%s ? %s" % (getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id]))
+
+                    self.assertEqual(getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id], msg="Reloaded contents different")
+
+        def test_layerindex_store_split(self):
+            self.layerindex.store_layerindex('file://%s' % self.tempdir, self.layerindex.indexes[0])
+
+            reload = layerindexlib.LayerIndex(self.d)
+            reload.load_layerindex('file://%s' % self.tempdir)
+
+            self.assertFalse(reload.is_empty(), msg="Layer index is empty")
+
+            for type in self.layerindex.indexes[0]._index:
+                if type == 'apilinks' or \
+                   type == 'layerItems' or \
+                   type in self.layerindex.indexes[0].config['local']:
+                    continue
+                for id in getattr(self.layerindex.indexes[0] ,type):
+                    self.logger.debug(1, "type %s" % (type))
+
+                    self.assertTrue(id in getattr(reload.indexes[0], type), msg="Id number missing from reloaded data")
+
+                    self.logger.debug(1, "%s ? %s" % (getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id]))
+
+                    self.assertEqual(getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id], msg="reloaded data does not match original")
+
+        def test_dependency_resolution(self):
+            # Verify depth first searching...
+            (dependencies, invalidnames) = self.layerindex.find_dependencies(names=['meta-python'])
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
+                self.assertEqual(layerBranch.layer.name, "openembedded-core", msg='OpenEmbedded-Core is no the first dependency')
+
+                # meta-python should cause an openembedded-core dependency, if not assert!
+                for dep in layerDeps:
+                    if dep.layer.name == 'meta-python':
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
+                self.assertEqual(layerBranch.layer.name, "meta-python", msg="Last dependency not meta-python")
+
+    def test_find_collection(self):
+        def _check(collection, expected):
+            self.logger.debug(1, "Looking for collection %s..." % collection)
+            result = self.layerindex.find_collection(collection)
+            if expected:
+                self.assertIsNotNone(result, msg="Did not find %s when it should be there" % collection)
+            else:
+                self.assertIsNone(result, msg="Found %s when it shouldn't be there" % collection)
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
+    def test_find_layerbranch(self):
+        def _check(name, expected):
+            self.logger.debug(1, "Looking for layerbranch %s..." % name)
+
+            for index in self.layerindex.indexes:
+                for layerbranchid in index.layerBranches:
+                    self.logger.debug(1, "Present: %s" % index.layerBranches[layerbranchid].layer.name)
+            result = self.layerindex.find_layerbranch(name)
+            if expected:
+                self.assertIsNotNone(result, msg="Did not find %s when it should be there" % collection)
+            else:
+                self.assertIsNone(result, msg="Found %s when it shouldn't be there" % collection)
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


