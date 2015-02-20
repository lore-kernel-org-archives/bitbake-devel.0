Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 9A3B573632
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Feb 2015 17:52:58 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 20 Feb 2015 09:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,616,1418112000"; d="scan'208";a="680980816"
Received: from marazel-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.23.180])
	by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2015 09:52:55 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Feb 2015 17:52:43 +0000
Message-Id: <fce9c52b5dd744d2339bf857223092171c0b8f58.1424454574.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1424454574.git.paul.eggleton@linux.intel.com>
References: <cover.1424454574.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1424454574.git.paul.eggleton@linux.intel.com>
References: <cover.1424454574.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] bitbake-layers: add ability to fetch layers and their dependencies from layer index
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
X-List-Received-Date: Fri, 20 Feb 2015 17:52:58 -0000

From: Chong Lu <Chong.Lu@windriver.com>

Add a command to query layer dependencies from a layer index such as the
OpenEmbedded Layer Index at http://layers.openembedded.org. Fetches the
layer and its dependencies and adds them into conf/bblayers.conf.

[YOCTO #5348]

Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 252 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index fc62386..a86ad1c 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -27,6 +27,8 @@ import fnmatch
 from collections import defaultdict
 import argparse
 import re
+import httplib, urlparse, json
+import subprocess
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
@@ -127,6 +129,246 @@ Removes the specified layer from bblayers.conf
             return 1
 
 
+    def get_json_data(self, apiurl):
+        proxy_settings = os.environ.get("http_proxy", None)
+        conn = None
+        _parsedurl = urlparse.urlparse(apiurl)
+        path = _parsedurl.path
+        query = _parsedurl.query
+        def parse_url(url):
+            parsedurl = urlparse.urlparse(url)
+            if parsedurl.netloc[0] == '[':
+                host, port = parsedurl.netloc[1:].split(']', 1)
+                if ':' in port:
+                    port = port.rsplit(':', 1)[1]
+                else:
+                    port = None
+            else:
+                if parsedurl.netloc.count(':') == 1:
+                    (host, port) = parsedurl.netloc.split(":")
+                else:
+                    host = parsedurl.netloc
+                    port = None
+            return (host, 80 if port is None else int(port))
+
+        if proxy_settings is None:
+            host, port = parse_url(apiurl)
+            conn = httplib.HTTPConnection(host, port)
+            conn.request("GET", path + "?" + query)
+        else:
+            host, port = parse_url(proxy_settings)
+            conn = httplib.HTTPConnection(host, port)
+            conn.request("GET", apiurl)
+
+        r = conn.getresponse()
+        if r.status != 200:
+            raise Exception("Failed to read " + path + ": %d %s" % (r.status, r.reason))
+        return json.loads(r.read())
+
+
+    def get_layer_deps(self, layername, layeritems, layerbranches, layerdependencies, branchnum, selfname=False):
+        def layeritems_info_id(items_name, layeritems):
+            litems_id = None
+            for li in layeritems:
+                if li['name'] == items_name:
+                    litems_id = li['id']
+                    break
+            return litems_id
+
+        def layerbranches_info(items_id, layerbranches):
+            lbranch = {}
+            for lb in layerbranches:
+                if lb['layer'] == items_id and lb['branch'] == branchnum:
+                    lbranch['id'] = lb['id']
+                    lbranch['vcs_subdir'] = lb['vcs_subdir']
+                    break
+            return lbranch
+
+        def layerdependencies_info(lb_id, layerdependencies):
+            ld_deps = []
+            for ld in layerdependencies:
+                if ld['layerbranch'] == lb_id and not ld['dependency'] in ld_deps:
+                    ld_deps.append(ld['dependency'])
+            if not ld_deps:
+                logger.error("The dependency of layerDependencies is not found.")
+            return ld_deps
+
+        def layeritems_info_name_subdir(items_id, layeritems):
+            litems = {}
+            for li in layeritems:
+                if li['id'] == items_id:
+                    litems['vcs_url'] = li['vcs_url']
+                    litems['name'] = li['name']
+                    break
+            return litems
+
+        if selfname:
+            selfid = layeritems_info_id(layername, layeritems)
+            lbinfo = layerbranches_info(selfid, layerbranches)
+            if lbinfo:
+                selfsubdir = lbinfo['vcs_subdir']
+            else:
+                logger.error("%s is not found in the specified branch" % layername)
+                return
+            selfurl = layeritems_info_name_subdir(selfid, layeritems)['vcs_url']
+            if selfurl:
+                return selfurl, selfsubdir
+            else:
+                logger.error("Cannot get layer %s git repo and subdir" % layername)
+                return
+        ldict = {}
+        itemsid = layeritems_info_id(layername, layeritems)
+        if not itemsid:
+            return layername, None
+        lbid = layerbranches_info(itemsid, layerbranches)
+        if lbid:
+            lbid = layerbranches_info(itemsid, layerbranches)['id']
+        else:
+            logger.error("%s is not found in the specified branch" % layername)
+            return None, None
+        for dependency in layerdependencies_info(lbid, layerdependencies):
+            lname = layeritems_info_name_subdir(dependency, layeritems)['name']
+            lurl = layeritems_info_name_subdir(dependency, layeritems)['vcs_url']
+            lsubdir = layerbranches_info(dependency, layerbranches)['vcs_subdir']
+            ldict[lname] = lurl, lsubdir
+        return None, ldict
+
+
+    def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
+        layername = self.get_layer_name(url)
+        if os.path.splitext(layername)[1] == '.git':
+            layername = os.path.splitext(layername)[0]
+        repodir = os.path.join(fetchdir, layername)
+        layerdir = os.path.join(repodir, subdir)
+        if not os.path.exists(repodir):
+            if fetch_layer:
+                result = subprocess.call('git clone %s %s' % (url, repodir), shell = True)
+                if result:
+                    logger.error("Failed to download %s" % url)
+                    return None, None
+                else:
+                    return layername, layerdir
+            else:
+                logger.plain("Repository %s needs to be fetched" % url)
+                return layername, layerdir
+        elif os.path.exists(layerdir):
+            return layername, layerdir
+        else:
+            logger.error("%s is not in %s" % (url, subdir))
+        return None, None
+
+
+    def do_layerindex_fetch(self, args):
+        """Fetches a layer from a layer index along with its dependent layers, and adds them to conf/bblayers.conf.
+"""
+        self.init_bbhandler(config_only = True)
+        apiurl = self.bbhandler.config_data.getVar('BBLAYERS_LAYERINDEX_URL', True)
+        if not apiurl:
+            logger.error("Cannot get BBLAYERS_LAYERINDEX_URL")
+        else:
+            if apiurl[-1] != '/':
+                apiurl += '/'
+            apiurl += "api/"
+        apilinks = self.get_json_data(apiurl)
+        branches = self.get_json_data(apilinks['branches'])
+
+        branchnum = 0
+        for branch in branches:
+            if branch['name'] == args.branch:
+                branchnum = branch['id']
+                break
+        if branchnum == 0:
+            validbranches = ', '.join([branch['name'] for branch in branches])
+            logger.error('Invalid layer branch name "%s". Valid branches: %s' % (args.branch, validbranches))
+            return 1
+
+        ignore_layers = []
+        for collection in self.bbhandler.config_data.getVar('BBFILE_COLLECTIONS', True).split():
+            lname = self.bbhandler.config_data.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % collection, True)
+            if lname:
+                ignore_layers.append(lname)
+
+        if args.ignore:
+            ignore_layers.extend(args.ignore.split(','))
+
+        layeritems = self.get_json_data(apilinks['layerItems'])
+        layerbranches = self.get_json_data(apilinks['layerBranches'])
+        layerdependencies = self.get_json_data(apilinks['layerDependencies'])
+        invaluenames = []
+        repourls = {}
+        printlayers = []
+        def query_dependencies(layers, layeritems, layerbranches, layerdependencies, branchnum):
+            depslayer = []
+            for layername in layers:
+                invaluename, layerdict = self.get_layer_deps(layername, layeritems, layerbranches, layerdependencies, branchnum)
+                if layerdict:
+                    repourls[layername] = self.get_layer_deps(layername, layeritems, layerbranches, layerdependencies, branchnum, selfname=True)
+                    for layer in layerdict:
+                        if not layer in ignore_layers:
+                            depslayer.append(layer)
+                        printlayers.append((layername, layer, layerdict[layer][0], layerdict[layer][1]))
+                        if not layer in ignore_layers and not layer in repourls:
+                            repourls[layer] = (layerdict[layer][0], layerdict[layer][1])
+                if invaluename and not invaluename in invaluenames:
+                    invaluenames.append(invaluename)
+            return depslayer
+
+        depslayers = query_dependencies(args.layername, layeritems, layerbranches, layerdependencies, branchnum)
+        while depslayers:
+            depslayer = query_dependencies(depslayers, layeritems, layerbranches, layerdependencies, branchnum)
+            depslayers = depslayer
+        if invaluenames:
+            for invaluename in invaluenames:
+                logger.error('Layer "%s" not found in layer index' % invaluename)
+            return 1
+        logger.plain("%s  %s  %s  %s" % ("Layer".ljust(19), "Required by".ljust(19), "Git repository".ljust(54), "Subdirectory"))
+        logger.plain('=' * 115)
+        for layername in args.layername:
+            layerurl = repourls[layername]
+            logger.plain("%s %s %s %s" % (layername.ljust(20), '-'.ljust(20), layerurl[0].ljust(55), layerurl[1]))
+        printedlayers = []
+        for layer, dependency, gitrepo, subdirectory in printlayers:
+            if dependency in printedlayers:
+                continue
+            logger.plain("%s %s %s %s" % (dependency.ljust(20), layer.ljust(20), gitrepo.ljust(55), subdirectory))
+            printedlayers.append(dependency)
+
+        if repourls:
+            fetchdir = self.bbhandler.config_data.getVar('BBLAYERS_FETCH_DIR', True)
+            if not fetchdir:
+                logger.error("Cannot get BBLAYERS_FETCH_DIR")
+                return 1
+            if not os.path.exists(fetchdir):
+                os.makedirs(fetchdir)
+            addlayers = []
+            for repourl, subdir in repourls.values():
+                name, layerdir = self.get_fetch_layer(fetchdir, repourl, subdir, not args.show_only)
+                if not name:
+                    # Error already shown
+                    return 1
+                addlayers.append((subdir, name, layerdir))
+        if not args.show_only:
+            for subdir, name, layerdir in set(addlayers):
+                if os.path.exists(layerdir):
+                    if subdir:
+                        logger.plain("Adding layer \"%s\" to conf/bblayers.conf" % subdir)
+                    else:
+                        logger.plain("Adding layer \"%s\" to conf/bblayers.conf" % name)
+                    localargs = argparse.Namespace()
+                    localargs.layerdir = layerdir
+                    self.do_add_layer(localargs)
+                else:
+                    break
+
+
+    def do_layerindex_show_depends(self, args):
+        """Find layer dependencies from layer index.
+"""
+        args.show_only = True
+        args.ignore = []
+        self.do_layerindex_fetch(args)
+
+
     def version_str(self, pe, pv, pr = None):
         verstr = "%s" % pv
         if pr:
@@ -759,6 +1001,16 @@ def main():
     parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
     parser_show_cross_depends.add_argument('-i', '--ignore', help='ignore dependencies on items in the specified layer(s) (split multiple layer names with commas, no spaces)', metavar='LAYERNAME')
 
+    parser_layerindex_fetch = add_command('layerindex-fetch', cmds.do_layerindex_fetch)
+    parser_layerindex_fetch.add_argument('-n', '--show-only', help='show dependencies and do nothing else', action='store_true')
+    parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
+    parser_layerindex_fetch.add_argument('-i', '--ignore', help='assume the specified layers do not need to be fetched/added (separate multiple layers with commas, no spaces)', metavar='LAYER')
+    parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
+
+    parser_layerindex_show_depends = add_command('layerindex-show-depends', cmds.do_layerindex_show_depends)
+    parser_layerindex_show_depends.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
+    parser_layerindex_show_depends.add_argument('layername', nargs='+', help='layer to query')
+
     args = parser.parse_args()
 
     if args.debug:
-- 
1.9.3


