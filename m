Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1D3ED780A1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 15:39:20 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v6SFdLhD008332
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Fri, 28 Jul 2017 08:39:21 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.294.0;
	Fri, 28 Jul 2017 08:39:22 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jul 2017 10:37:20 -0500
Message-ID: <1501256242-37784-4-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
Cc: toaster@yoctoproject.org
Subject: [PATCH 3/5] lib/bblayers: Add support for the new layer modules
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
X-List-Received-Date: Fri, 28 Jul 2017 15:39:20 -0000
Content-Type: text/plain

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bblayers/layerindex.py        | 313 +++++++++++---------------------------
 lib/layers/layerindex/__init__.py |  28 +++-
 lib/layers/layerindex/cooker.py   |   2 +-
 lib/layers/layerindex/restapi.py  |  95 +++++++-----
 lib/layers/manager/__init__.py    |  59 ++++---
 5 files changed, 210 insertions(+), 287 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 506c110..d1dac0b 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -1,10 +1,10 @@
+import layers.manager
+import layers.layerindex
+
 import argparse
-import http.client
-import json
 import logging
 import os
 import subprocess
-import urllib.parse
 
 from bblayers.action import ActionPlugin
 
@@ -21,235 +21,108 @@ class LayerIndexPlugin(ActionPlugin):
     This class inherits ActionPlugin to get do_add_layer.
     """
 
-    def get_json_data(self, apiurl):
-        proxy_settings = os.environ.get("http_proxy", None)
-        conn = None
-        _parsedurl = urllib.parse.urlparse(apiurl)
-        path = _parsedurl.path
-        query = _parsedurl.query
-
-        def parse_url(url):
-            parsedurl = urllib.parse.urlparse(url)
-            if parsedurl.netloc[0] == '[':
-                host, port = parsedurl.netloc[1:].split(']', 1)
-                if ':' in port:
-                    port = port.rsplit(':', 1)[1]
-                else:
-                    port = None
-            else:
-                if parsedurl.netloc.count(':') == 1:
-                    (host, port) = parsedurl.netloc.split(":")
-                else:
-                    host = parsedurl.netloc
-                    port = None
-            return (host, 80 if port is None else int(port))
-
-        if proxy_settings is None:
-            host, port = parse_url(apiurl)
-            conn = http.client.HTTPConnection(host, port)
-            conn.request("GET", path + "?" + query)
-        else:
-            host, port = parse_url(proxy_settings)
-            conn = http.client.HTTPConnection(host, port)
-            conn.request("GET", apiurl)
-
-        r = conn.getresponse()
-        if r.status != 200:
-            raise Exception("Failed to read " + path + ": %d %s" % (r.status, r.reason))
-        return json.loads(r.read().decode())
-
-    def get_layer_deps(self, layername, layeritems, layerbranches, layerdependencies, branchnum, selfname=False):
-        def layeritems_info_id(items_name, layeritems):
-            litems_id = None
-            for li in layeritems:
-                if li['name'] == items_name:
-                    litems_id = li['id']
-                    break
-            return litems_id
-
-        def layerbranches_info(items_id, layerbranches):
-            lbranch = {}
-            for lb in layerbranches:
-                if lb['layer'] == items_id and lb['branch'] == branchnum:
-                    lbranch['id'] = lb['id']
-                    lbranch['vcs_subdir'] = lb['vcs_subdir']
-                    break
-            return lbranch
-
-        def layerdependencies_info(lb_id, layerdependencies):
-            ld_deps = []
-            for ld in layerdependencies:
-                if ld['layerbranch'] == lb_id and not ld['dependency'] in ld_deps:
-                    ld_deps.append(ld['dependency'])
-            if not ld_deps:
-                logger.error("The dependency of layerDependencies is not found.")
-            return ld_deps
-
-        def layeritems_info_name_subdir(items_id, layeritems):
-            litems = {}
-            for li in layeritems:
-                if li['id'] == items_id:
-                    litems['vcs_url'] = li['vcs_url']
-                    litems['name'] = li['name']
-                    break
-            return litems
-
-        if selfname:
-            selfid = layeritems_info_id(layername, layeritems)
-            lbinfo = layerbranches_info(selfid, layerbranches)
-            if lbinfo:
-                selfsubdir = lbinfo['vcs_subdir']
-            else:
-                logger.error("%s is not found in the specified branch" % layername)
-                return
-            selfurl = layeritems_info_name_subdir(selfid, layeritems)['vcs_url']
-            if selfurl:
-                return selfurl, selfsubdir
-            else:
-                logger.error("Cannot get layer %s git repo and subdir" % layername)
-                return
-        ldict = {}
-        itemsid = layeritems_info_id(layername, layeritems)
-        if not itemsid:
-            return layername, None
-        lbid = layerbranches_info(itemsid, layerbranches)
-        if lbid:
-            lbid = layerbranches_info(itemsid, layerbranches)['id']
-        else:
-            logger.error("%s is not found in the specified branch" % layername)
-            return None, None
-        for dependency in layerdependencies_info(lbid, layerdependencies):
-            lname = layeritems_info_name_subdir(dependency, layeritems)['name']
-            lurl = layeritems_info_name_subdir(dependency, layeritems)['vcs_url']
-            lsubdir = layerbranches_info(dependency, layerbranches)['vcs_subdir']
-            ldict[lname] = lurl, lsubdir
-        return None, ldict
-
-    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
-        layername = self.get_layer_name(url)
-        if os.path.splitext(layername)[1] == '.git':
-            layername = os.path.splitext(layername)[0]
-        repodir = os.path.join(fetchdir, layername)
-        layerdir = os.path.join(repodir, subdir)
-        if not os.path.exists(repodir):
-            if fetch_layer:
-                result = subprocess.call('git clone %s %s' % (url, repodir), shell = True)
-                if result:
-                    logger.error("Failed to download %s" % url)
-                    return None, None
-                else:
-                    return layername, layerdir
-            else:
-                logger.plain("Repository %s needs to be fetched" % url)
-                return layername, layerdir
-        elif os.path.exists(layerdir):
-            return layername, layerdir
-        else:
-            logger.error("%s is not in %s" % (url, subdir))
-        return None, None
-
     def do_layerindex_fetch(self, args):
         """Fetches a layer from a layer index along with its dependent layers, and adds them to conf/bblayers.conf.
 """
-        apiurl = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_URL')
-        if not apiurl:
+
+        def _construct_url(baseurl, branch):
+            if baseurl[-1] != '/':
+                baseurl += '/'
+            baseurl += "api/"
+            baseurl += ";type=restapi"
+
+            if branch:
+                baseurl += ";branch=%s" % branch
+
+            return baseurl
+
+
+        # General URL to use based on standard setting
+        indexurl = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_URL')
+
+        if not indexurl:
             logger.error("Cannot get BBLAYERS_LAYERINDEX_URL")
             return 1
-        else:
-            if apiurl[-1] != '/':
-                apiurl += '/'
-            apiurl += "api/"
-        apilinks = self.get_json_data(apiurl)
-        branches = self.get_json_data(apilinks['branches'])
-
-        branchnum = 0
-        for branch in branches:
-            if branch['name'] == args.branch:
-                branchnum = branch['id']
-                break
-        if branchnum == 0:
-            validbranches = ', '.join([branch['name'] for branch in branches])
-            logger.error('Invalid layer branch name "%s". Valid branches: %s' % (args.branch, validbranches))
+
+        layerManager = layers.manager.LayerManager(self.tinfoil.config_data, self.tinfoil.cooker)
+
+        remoteIndex = layers.layerindex.LayerIndex(self.tinfoil.config_data)
+
+        # Set the default...
+        branch = self.tinfoil.config_data.getVar('LAYERSERIES_CORENAMES') or 'master'
+        if args.branch:
+            branch = args.branch
+
+        logger.debug(1, 'Trying branch %s' % branch)
+        try:
+            remoteIndex.load_layerindex(_construct_url(indexurl, branch))
+        except Exception:
+            if branch == args.branch:
+                logger.error('Branch %s is not available' % branch)
+                return 1
+            logger.debug(1, 'Falling back to branch master')
+            remoteIndex.load_layerindex(_construct_url(indexurl, 'master'), reload=True)
+
+        if remoteIndex.is_empty():
             return 1
 
-        ignore_layers = []
-        for collection in self.tinfoil.config_data.getVar('BBFILE_COLLECTIONS').split():
-            lname = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % collection)
-            if lname:
-                ignore_layers.append(lname)
+        # If we want the display to include already downloaded
+        # keep the following line, otherwise comment out.
+        cookerIndex = layers.layerindex.LayerIndex(self.tinfoil.config_data)
+        cookerIndex.load_layerindex('file://local;type=cooker', load='layerDependencies')
+
+        lIndex = cookerIndex + remoteIndex
 
+        ignore_layers = []
         if args.ignore:
             ignore_layers.extend(args.ignore.split(','))
 
-        layeritems = self.get_json_data(apilinks['layerItems'])
-        layerbranches = self.get_json_data(apilinks['layerBranches'])
-        layerdependencies = self.get_json_data(apilinks['layerDependencies'])
-        invaluenames = []
-        repourls = {}
-        printlayers = []
-
-        def query_dependencies(layers, layeritems, layerbranches, layerdependencies, branchnum):
-            depslayer = []
-            for layername in layers:
-                invaluename, layerdict = self.get_layer_deps(layername, layeritems, layerbranches, layerdependencies, branchnum)
-                if layerdict:
-                    repourls[layername] = self.get_layer_deps(layername, layeritems, layerbranches, layerdependencies, branchnum, selfname=True)
-                    for layer in layerdict:
-                        if not layer in ignore_layers:
-                            depslayer.append(layer)
-                        printlayers.append((layername, layer, layerdict[layer][0], layerdict[layer][1]))
-                        if not layer in ignore_layers and not layer in repourls:
-                            repourls[layer] = (layerdict[layer][0], layerdict[layer][1])
-                if invaluename and not invaluename in invaluenames:
-                    invaluenames.append(invaluename)
-            return depslayer
-
-        depslayers = query_dependencies(args.layername, layeritems, layerbranches, layerdependencies, branchnum)
-        while depslayers:
-            depslayer = query_dependencies(depslayers, layeritems, layerbranches, layerdependencies, branchnum)
-            depslayers = depslayer
-        if invaluenames:
-            for invaluename in invaluenames:
+        layernames = ' '.join(args.layername)
+        (dependencies, invalidnames) = lIndex.get_dependencies(names=layernames, ignores=ignore_layers)
+
+        if invalidnames:
+            for invaluename in invalidnames:
                 logger.error('Layer "%s" not found in layer index' % invaluename)
             return 1
-        logger.plain("%s  %s  %s  %s" % ("Layer".ljust(19), "Required by".ljust(19), "Git repository".ljust(54), "Subdirectory"))
-        logger.plain('=' * 115)
-        for layername in args.layername:
-            layerurl = repourls[layername]
-            logger.plain("%s %s %s %s" % (layername.ljust(20), '-'.ljust(20), layerurl[0].ljust(55), layerurl[1]))
-        printedlayers = []
-        for layer, dependency, gitrepo, subdirectory in printlayers:
-            if dependency in printedlayers:
-                continue
-            logger.plain("%s %s %s %s" % (dependency.ljust(20), layer.ljust(20), gitrepo.ljust(55), subdirectory))
-            printedlayers.append(dependency)
-
-        if repourls:
-            fetchdir = self.tinfoil.config_data.getVar('BBLAYERS_FETCH_DIR')
-            if not fetchdir:
-                logger.error("Cannot get BBLAYERS_FETCH_DIR")
-                return 1
-            if not os.path.exists(fetchdir):
-                os.makedirs(fetchdir)
-            addlayers = []
-            for repourl, subdir in repourls.values():
-                name, layerdir = self.get_fetch_layer(fetchdir, repourl, subdir, not args.show_only)
-                if not name:
-                    # Error already shown
-                    return 1
-                addlayers.append((subdir, name, layerdir))
-        if not args.show_only:
-            for subdir, name, layerdir in set(addlayers):
-                if os.path.exists(layerdir):
-                    if subdir:
-                        logger.plain("Adding layer \"%s\" to conf/bblayers.conf" % subdir)
-                    else:
-                        logger.plain("Adding layer \"%s\" to conf/bblayers.conf" % name)
-                    localargs = argparse.Namespace()
-                    localargs.layerdir = layerdir
-                    self.do_add_layer(localargs)
+        logger.plain("%s  %s  %s" % ("Layer".ljust(49), "Git repository (branch)".ljust(54), "Subdirectory"))
+        logger.plain('=' * 125)
+
+        for deplayerbranch in dependencies:
+            layerBranch = dependencies[deplayerbranch][0]
+
+            # This is the local content, uncomment to hide local
+            # layers from the display.
+            #if layerBranch.index['CONFIG']['TYPE'] == 'cooker':
+            #    continue
+
+            layerDeps = dependencies[deplayerbranch][1:]
+
+            requiredby = []
+            recommendedby = []
+            for dep in layerDeps:
+                if dep.is_required():
+                    requiredby.append(dep.get_layer().get_name())
                 else:
-                    break
+                    recommendedby.append(dep.get_layer().get_name())
+
+            logger.plain('%s %s %s' % (("%s:%s:%s" %
+                                  (layerBranch.index['CONFIG']['DESCRIPTION'],
+                                  layerBranch.get_branch().get_name(),
+                                  layerBranch.get_layer().get_name())).ljust(50),
+                                  ("%s (%s)" % (layerBranch.get_layer().get_vcs_url(),
+                                  layerBranch.get_actual_branch())).ljust(55),
+                                  layerBranch.get_vcs_subdir()
+                                               ))
+            if requiredby:
+                logger.plain('  required by: %s' % ' '.join(requiredby))
+            if recommendedby:
+                logger.plain('  recommended by: %s' % ' '.join(recommendedby))
+
+        if args.show_only != True:
+            layerManager.setup(dependencies)
+            layerManager.fetch()
+            layerManager.unpack()
+            layerManager.update_bblayers()
 
     def do_layerindex_show_depends(self, args):
         """Find layer dependencies from layer index.
@@ -261,10 +134,10 @@ class LayerIndexPlugin(ActionPlugin):
     def register_commands(self, sp):
         parser_layerindex_fetch = self.add_command(sp, 'layerindex-fetch', self.do_layerindex_fetch)
         parser_layerindex_fetch.add_argument('-n', '--show-only', help='show dependencies and do nothing else', action='store_true')
-        parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
+        parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)')
         parser_layerindex_fetch.add_argument('-i', '--ignore', help='assume the specified layers do not need to be fetched/added (separate multiple layers with commas, no spaces)', metavar='LAYER')
         parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
 
         parser_layerindex_show_depends = self.add_command(sp, 'layerindex-show-depends', self.do_layerindex_show_depends)
-        parser_layerindex_show_depends.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
+        parser_layerindex_show_depends.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)')
         parser_layerindex_show_depends.add_argument('layername', nargs='+', help='layer to query')
diff --git a/lib/layers/layerindex/__init__.py b/lib/layers/layerindex/__init__.py
index 0c7c483..beb7df9 100644
--- a/lib/layers/layerindex/__init__.py
+++ b/lib/layers/layerindex/__init__.py
@@ -407,7 +407,7 @@ invalid is just a list of dependencies that were not found.
 
         if names:
             for name in names.split():
-                if name in ignores:
+                if ignores and name in ignores:
                     continue
 
                 # Since we don't have a branch, we have to just find the first
@@ -441,7 +441,7 @@ invalid is just a list of dependencies that were not found.
         for layerBranch in layerBranches:
             name = layerBranch.get_layer().get_name()
             # Do we ignore it?
-            if name in ignores:
+            if ignores and name in ignores:
                 continue
 
             if 'layerDependencies_layerBranchId' not in layerBranch.index:
@@ -469,7 +469,7 @@ invalid is just a list of dependencies that were not found.
                             depLayerBranch = rdepLayerBranch
 
                     # Is this dependency on the list to be ignored?
-                    if depLayerBranch.get_layer().get_name() in ignores:
+                    if ignores and depLayerBranch.get_layer().get_name() in ignores:
                         continue
 
                     # Previously found dependencies have been processed, as
@@ -823,7 +823,19 @@ class LayerDependency(LayerIndexItem_LayerBranch):
             branchId = self.get_layerbranch().get_branch_id()
             layerBranch = self.index['layerBranches_layerId_branchId']["%s:%s" % (layerId, branchId)]
         except KeyError:
-            logger.error('Unable to find layerBranches_layerId_branchId in index')
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
         except IndexError:
             logger.error("LayerBranch not found layerId %s -- BranchId %s" % (layerId, branchId))
 
@@ -832,10 +844,10 @@ class LayerDependency(LayerIndexItem_LayerBranch):
 
 class Recipe(LayerIndexItem_LayerBranch):
     def define_data(self, id,
-                    filename, filepath, pn, pv,
-                    summary, description, section, license,
-                    homepage, bugtracker, provides, bbclassextend,
-                    inherits, blacklisted, layerbranch, updated=None):
+                    filename, filepath, pn, pv, layerbranch,
+                    summary="", description="", section="", license="",
+                    homepage="", bugtracker="", provides="", bbclassextend="",
+                    inherits="", blacklisted="", updated=None):
         self.data = {}
         self.data['id'] = id
         self.data['filename'] = filename
diff --git a/lib/layers/layerindex/cooker.py b/lib/layers/layerindex/cooker.py
index 229f668..76a8739 100644
--- a/lib/layers/layerindex/cooker.py
+++ b/lib/layers/layerindex/cooker.py
@@ -125,7 +125,7 @@ class CookerPlugin(IndexPlugin):
                 if deps:
                     layerDependencyId = add_dependency(layerDependencyId, lindex, deps, False)
 
-        # Need to load recipes here
+        # Need to load recipes here (requires cooker access)
         recipeId = 0
         if False and 'recipes' in load.split():  ## TODO NOT IMPLEMENTED
             lindex['recipes'] = {}
diff --git a/lib/layers/layerindex/restapi.py b/lib/layers/layerindex/restapi.py
index d6d29a4..4a2e9d9 100644
--- a/lib/layers/layerindex/restapi.py
+++ b/lib/layers/layerindex/restapi.py
@@ -90,7 +90,8 @@ class RestApiPlugin(IndexPlugin):
 
         def load_cache(path, lindex, branches=None):
             logger.debug(1, 'Loading json file %s' % path)
-            pindex = json.load(open(path, 'rt', encoding='utf-8'))
+            with open(path, 'rt', encoding='utf-8') as f:
+                pindex = json.load(f)
 
             # Filter the branches on loaded files...
             newpBranch = []
@@ -267,47 +268,72 @@ class RestApiPlugin(IndexPlugin):
         if ud.type != 'file':
             raise NotImplementedError('Writing to anything but a file url is not implemented: %s' % ud.url)
 
-        # Write out to a single file, we have to sort the entries as we write
-        if not os.path.isdir(ud.path):
-            pindex = {}
-            for entry in lindex:
-                # Check for either locally added item or apilinks to ignore
-                if entry in lindex['CONFIG']['local'] or \
-                   entry == 'apilinks':
-                    continue
-                pindex[entry] = []
-                for objId in lindex[entry]:
-                    pindex[entry].append(lindex[entry][objId].data)
-
-            bb.debug(1, 'Writing index to %s' % ud.path)
-            json.dump(layers.layerindex.sort_entry(pindex), open(ud.path, 'wt'), indent=4)
-            return
-
-        # Write out to a directory one file per layerBranch
         try:
             layerBranches = lindex['layerBranches']
         except KeyError:
             logger.error('No layerBranches to write.')
             return
 
-        for layerBranchId in layerBranches:
-            pindex = {}
 
-            def filter_item(layerBranchId, objects):
-                filtered = []
-                for obj in lindex[objects]:
+        def filter_item(layerBranchId, objects):
+            filtered = []
+            for obj in lindex[objects]:
+                try:
+                    if lindex[objects][obj].get_layerbranch_id() == layerBranchId:
+                       filtered.append(lindex[objects][obj].data)
+                except AttributeError:
+                    logger.debug(1, 'No obj.get_layerbranch_id(): %s' % objects)
+                    # No simple filter method, just include it...
                     try:
-                        if lindex[objects][obj].get_layerbranch_id() == layerBranchId:
-                            filtered.append(lindex[objects][obj].data)
+                        filtered.append(lindex[objects][obj].data)
                     except AttributeError:
-                        logger.debug(1, 'No obj.get_layerbranch_id(): %s' % objects)
-                        # No simple filter method, just include it...
-                        try:
-                            filtered.append(lindex[objects][obj].data)
-                        except AttributeError:
-                            logger.debug(1, 'No obj.data: %s %s' % (objects, type(obj)))
-                            filtered.append(obj)
-                return filtered
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
+                json.dump(layers.layerindex.sort_entry(pindex), f, indent=4)
+            return
+
+
+        # Write out to a directory one file per layerBranch
+        # Prepare all layer related items, to create a minimal file.
+        # We have to sort the entries as we write so they are deterministic
+        for layerBranchId in layerBranches:
+            pindex = {}
 
             for entry in lindex:
                 # Skip local items, apilinks and items already processed
@@ -345,4 +371,5 @@ class RestApiPlugin(IndexPlugin):
             fpath = os.path.join(ud.path, fname)
 
             bb.debug(1, 'Writing index to %s' % fpath + '.json')
-            json.dump(layers.layerindex.sort_entry(pindex), open(fpath + '.json', 'wt'), indent=4)
+            with open(fpath + '.json', 'wt') as f:
+                json.dump(layers.layerindex.sort_entry(pindex), f, indent=4)
diff --git a/lib/layers/manager/__init__.py b/lib/layers/manager/__init__.py
index 3145924..f0ef646 100644
--- a/lib/layers/manager/__init__.py
+++ b/lib/layers/manager/__init__.py
@@ -28,6 +28,9 @@ class LayerManager():
         _set_manager(self)
 
         self.data = d
+        # Cooker isn't currently used by this module, but may be referenced
+        # by other layer modules or plugins.  This is a single convienent
+        # place to define it.
         self.cooker = cooker
 
         self.local_index = None  # What is in the bblayers.conf
@@ -86,12 +89,6 @@ class LayerManager():
 
         default_branches = d.getVar('LAYERSERIES_CORENAMES') or "HEAD"
 
-        collections = d.getVar('BBFILE_COLLECTIONS')
-        layerconfs = d.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', d)
-        bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.items()}
-
-        bblayers = d.getVar('BBLAYERS').split()
-
         index = {}
 
         branchId = 0
@@ -103,6 +100,16 @@ class LayerManager():
         layerBranchId = 0
         index['layerBranches'] = {}
 
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
         (_, bb_branch, _, _) = self.get_bitbake_info()
 
         for branch in default_branches.split():
@@ -111,27 +118,31 @@ class LayerManager():
             index['branches'][branchId].define_data(branchId, branch, bb_branch)
 
         for entry in collections.split():
-            layername = d.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % entry) or os.path.basename(bbfile_collections[entry])
+            layerpath = entry
+            if entry in bbfile_collections:
+                layerpath = bbfile_collections[entry]
 
-            layerpath = bbfile_collections[entry]
-            layersubdir = ""
+            layername = d.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % entry) or os.path.basename(layerpath)
+            layerversion = d.getVar('LAYERVERSION_%s' % entry) or ""
+            layerurl = _handle_git_remote(layerpath)
 
-            layerbasepath = self._run_command('git rev-parse --show-toplevel', layerpath, default=layerpath)
-            if os.path.abspath(layerpath) != os.path.abspath(layerbasepath):
-                layersubdir = os.path.abspath(layerpath)[len(layerbasepath) + 1:]
+            layersubdir = ""
+            layerrev = "<unknown>"
+            layerbranch = "<unknown>"
 
-            layerversion = d.getVar('LAYERVERSION_%s' % entry) or ""
+            if os.path.isdir(layerpath):
+                layerbasepath = self._run_command('git rev-parse --show-toplevel', layerpath, default=layerpath)
+                if os.path.abspath(layerpath) != os.path.abspath(layerbasepath):
+                    layersubdir = os.path.abspath(layerpath)[len(layerbasepath) + 1:]
 
-            layerbranch = self._run_command('git rev-parse --abbrev-ref HEAD', layerpath, default="<unknown>")
-            layerrev = self._run_command('git rev-parse HEAD', layerpath, default="<unknown>")
+                layerbranch = self._run_command('git rev-parse --abbrev-ref HEAD', layerpath, default="<unknown>")
+                layerrev = self._run_command('git rev-parse HEAD', layerpath, default="<unknown>")
 
-            for remotes in self._run_command('git remote -v', layerpath, default="").split("\n"):
-                remote = remotes.split("\t")[1].split(" ")[0]
-                if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
-                    layerurl = _handle_git_remote(remote)
-                    break
-                else:
-                    layerurl = _handle_git_remote(layerpath)
+                for remotes in self._run_command('git remote -v', layerpath, default="").split("\n"):
+                    remote = remotes.split("\t")[1].split(" ")[0]
+                    if "(fetch)" == remotes.split("\t")[1].split(" ")[1]:
+                        layerurl = _handle_git_remote(remote)
+                        break
 
             layerItemId += 1
             index['layerItems'][layerItemId] = layers.layerindex.LayerItem(index, None)
@@ -141,7 +152,7 @@ class LayerManager():
                 layerBranchId += 1
                 index['layerBranches'][layerBranchId] = layers.layerindex.LayerBranch(index, None)
                 index['layerBranches'][layerBranchId].define_data(layerBranchId, entry, layerversion, layerItemId, branchId,
-                                               vcs_subdir=layersubdir, vcs_last_rev= layerrev, actual_branch=layerbranch)
+                                               vcs_subdir=layersubdir, vcs_last_rev=layerrev, actual_branch=layerbranch)
 
         return index
 
@@ -150,7 +161,7 @@ class LayerManager():
 
     # You are not allowed to have two of the same url, but different branches
     def get_clone_directory(self, url):
-        baseDir = get_clone_base_directory()
+        baseDir = self.get_clone_base_directory()
         if not baseDir:
             return None
         repo = os.path.basename(url)
-- 
1.8.3.1


