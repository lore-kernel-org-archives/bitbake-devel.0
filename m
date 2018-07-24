Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 761CD753E3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Jul 2018 02:29:18 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w6O2TJ1P006420
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jul 2018 19:29:19 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.399.0;
	Mon, 23 Jul 2018 19:29:19 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 23 Jul 2018 22:29:12 -0400
Message-ID: <20180724022914.185634-4-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180724022914.185634-1-mark.hatle@windriver.com>
References: <20180724022914.185634-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/5 v2] bblayers/layerindex.py: Switch to use the new layerindexlib class
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
X-List-Received-Date: Tue, 24 Jul 2018 02:29:19 -0000
Content-Type: text/plain

Display changes:
The output will now include references to the layers that the user already
has on their system.  It does this by querying the cooker derived index.

The code that enables this behavior is labeled as 'TODO' currently.  As
part of the work we need to make a final determination if this is the
desired output.

Also changed the default branch to no longer define itself as 'master'.

When the user does NOT set a branch, the default is now the
'LAYERSERIES_CORENAMES', and if that doesn't exist 'master'.  This is
subtly different in behavior, but more consistent with user expectations.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bblayers/layerindex.py | 304 ++++++++++++++++++---------------------------
 1 file changed, 119 insertions(+), 185 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 53c858d..121c7d5 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -1,10 +1,9 @@
+import layerindexlib
+
 import argparse
-import http.client
-import json
 import logging
 import os
 import subprocess
-import urllib.parse
 
 from bblayers.action import ActionPlugin
 
@@ -21,110 +20,6 @@ class LayerIndexPlugin(ActionPlugin):
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
     def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
         layername = self.get_layer_name(url)
         if os.path.splitext(layername)[1] == '.git':
@@ -136,95 +31,124 @@ class LayerIndexPlugin(ActionPlugin):
                 result = subprocess.call('git clone %s %s' % (url, repodir), shell = True)
                 if result:
                     logger.error("Failed to download %s" % url)
-                    return None, None
+                    return None, None, None
                 else:
-                    return layername, layerdir
+                    return subdir, layername, layerdir
             else:
                 logger.plain("Repository %s needs to be fetched" % url)
-                return layername, layerdir
+                return subdir, layername, layerdir
         elif os.path.exists(layerdir):
-            return layername, layerdir
+            return subdir, layername, layerdir
         else:
             logger.error("%s is not in %s" % (url, subdir))
-        return None, None
+        return None, None, None
 
     def do_layerindex_fetch(self, args):
         """Fetches a layer from a layer index along with its dependent layers, and adds them to conf/bblayers.conf.
 """
-        apiurl = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_URL')
-        if not apiurl:
-            logger.error("Cannot get BBLAYERS_LAYERINDEX_URL")
-            return 1
+
+        def _construct_url(baseurls, branches):
+            urls = []
+            for baseurl in baseurls:
+                if baseurl[-1] != '/':
+                    baseurl += '/'
+
+                if not baseurl.startswith('cooker'):
+                    baseurl += "api/"
+
+                if branches:
+                    baseurl += ";branch=%s" % ','.join(branches)
+
+                urls.append(baseurl)
+
+            return urls
+
+
+        # Set the default...
+        if args.branch:
+            branches = [args.branch]
         else:
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
-            return 1
+            branches = (self.tinfoil.config_data.getVar('LAYERSERIES_CORENAMES') or 'master').split()
+        logger.debug(1, 'Trying branches: %s' % branches)
 
         ignore_layers = []
-        for collection in self.tinfoil.config_data.getVar('BBFILE_COLLECTIONS').split():
-            lname = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % collection)
-            if lname:
-                ignore_layers.append(lname)
-
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
-                logger.error('Layer "%s" not found in layer index' % invaluename)
-            return 1
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
+        # Load the cooker DB
+        cookerIndex = layerindexlib.LayerIndex(self.tinfoil.config_data)
+        cookerIndex.load_layerindex('cooker://', load='layerDependencies')
+
+        # Fast path, check if we already have what has been requested!
+        (dependencies, invalidnames) = cookerIndex.find_dependencies(names=args.layername, ignores=ignore_layers)
+        if not args.show_only and not invalidnames:
+            logger.plain("You already have the requested layer(s): %s" % args.layername)
+            return 0
+
+        # The information to show is already in the cookerIndex
+        if invalidnames:
+            # General URL to use to access the layer index
+            # While there is ONE right now, we're expect users could enter several
+            apiurl = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_URL').split()
+            if not apiurl:
+                logger.error("Cannot get BBLAYERS_LAYERINDEX_URL")
+                return 1
+
+            remoteIndex = layerindexlib.LayerIndex(self.tinfoil.config_data)
+
+            for remoteurl in _construct_url(apiurl, branches):
+                logger.plain("Loading %s..." % remoteurl)
+                remoteIndex.load_layerindex(remoteurl)
+
+            if remoteIndex.is_empty():
+                logger.error("Remote layer index %s is empty for branches %s" % (apiurl, branches))
+                return 1
+
+            lIndex = cookerIndex + remoteIndex
+
+            (dependencies, invalidnames) = lIndex.find_dependencies(names=args.layername, ignores=ignore_layers)
+
+            if invalidnames:
+                for invaluename in invalidnames:
+                    logger.error('Layer "%s" not found in layer index' % invaluename)
+                return 1
+
+        logger.plain("%s  %s  %s" % ("Layer".ljust(49), "Git repository (branch)".ljust(54), "Subdirectory"))
+        logger.plain('=' * 125)
+
+        for deplayerbranch in dependencies:
+            layerBranch = dependencies[deplayerbranch][0]
+
+            # TODO: Determine display behavior
+            # This is the local content, uncomment to hide local
+            # layers from the display.
+            #if layerBranch.index.config['TYPE'] == 'cooker':
+            #    continue
+
+            layerDeps = dependencies[deplayerbranch][1:]
+
+            requiredby = []
+            recommendedby = []
+            for dep in layerDeps:
+                if dep.required:
+                    requiredby.append(dep.layer.name)
+                else:
+                    recommendedby.append(dep.layer.name)
+
+            logger.plain('%s %s %s' % (("%s:%s:%s" %
+                                  (layerBranch.index.config['DESCRIPTION'],
+                                  layerBranch.branch.name,
+                                  layerBranch.layer.name)).ljust(50),
+                                  ("%s (%s)" % (layerBranch.layer.vcs_url,
+                                  layerBranch.actual_branch)).ljust(55),
+                                  layerBranch.vcs_subdir
+                                               ))
+            if requiredby:
+                logger.plain('  required by: %s' % ' '.join(requiredby))
+            if recommendedby:
+                logger.plain('  recommended by: %s' % ' '.join(recommendedby))
+
+        if dependencies:
             fetchdir = self.tinfoil.config_data.getVar('BBLAYERS_FETCH_DIR')
             if not fetchdir:
                 logger.error("Cannot get BBLAYERS_FETCH_DIR")
@@ -232,8 +156,18 @@ class LayerIndexPlugin(ActionPlugin):
             if not os.path.exists(fetchdir):
                 os.makedirs(fetchdir)
             addlayers = []
-            for repourl, subdir in repourls.values():
-                name, layerdir = self.get_fetch_layer(fetchdir, repourl, subdir, not args.show_only)
+
+            for deplayerbranch in dependencies:
+                layerBranch = dependencies[deplayerbranch][0]
+
+                if layerBranch.index.config['TYPE'] == 'cooker':
+                    # Anything loaded via cooker is already local, skip it
+                    continue
+
+                subdir, name, layerdir = self.get_fetch_layer(fetchdir,
+                                                      layerBranch.layer.vcs_url,
+                                                      layerBranch.vcs_subdir,
+                                                      not args.show_only)
                 if not name:
                     # Error already shown
                     return 1
@@ -242,7 +176,7 @@ class LayerIndexPlugin(ActionPlugin):
             localargs = argparse.Namespace()
             localargs.layerdir = []
             localargs.force = args.force
-            for subdir, name, layerdir in set(addlayers):
+            for subdir, name, layerdir in addlayers:
                 if os.path.exists(layerdir):
                     if subdir:
                         logger.plain("Adding layer \"%s\" (%s) to conf/bblayers.conf" % (subdir, layerdir))
@@ -265,10 +199,10 @@ class LayerIndexPlugin(ActionPlugin):
     def register_commands(self, sp):
         parser_layerindex_fetch = self.add_command(sp, 'layerindex-fetch', self.do_layerindex_fetch)
         parser_layerindex_fetch.add_argument('-n', '--show-only', help='show dependencies and do nothing else', action='store_true')
-        parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
+        parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch')
         parser_layerindex_fetch.add_argument('-i', '--ignore', help='assume the specified layers do not need to be fetched/added (separate multiple layers with commas, no spaces)', metavar='LAYER')
         parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
 
         parser_layerindex_show_depends = self.add_command(sp, 'layerindex-show-depends', self.do_layerindex_show_depends)
-        parser_layerindex_show_depends.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
+        parser_layerindex_show_depends.add_argument('-b', '--branch', help='branch name to fetch')
         parser_layerindex_show_depends.add_argument('layername', nargs='+', help='layer to query')
-- 
1.8.3.1


