Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id 38CAB6FF60
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:41:11 +0000 (UTC)
Received: by mail-pf0-f174.google.com with SMTP id 206so62387977pfu.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Rzv594fua+kt/mEBNVKPex7ia8090dxjGeCVjj9yOg4=;
	b=0Qab2OL+3+ORsHCEpXAL9SQV06EwpBUuDaQxzpnNEwxmNxDHlWkOQZeuyvPkOZSu02
	IRCHQQu/fG/I4ES10aCI+tLlQ9xYhjl+3eH0YFLjO0/y8xkxH1Yu38qb3oQZBGj8pMam
	2Vc7CxVpHsANbM4iiLwjtnp0Z8XGXT7YV1+HPCPavCVmYaifAo7ybmwz6HLkfCnKsxnX
	03zGSVfgHqIEXSd7CyOc9S5NfH7OMLS7NLF3Aze5zfBvojkRbiIh42GHVosRVu93gsXi
	AlSm7xy2MB7CA0KellOk31fnjcjyfnqu3Pltyhv1ynp5qJ896QUZPSVpc8RsnKA4eWgG
	LxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Rzv594fua+kt/mEBNVKPex7ia8090dxjGeCVjj9yOg4=;
	b=Xzqc1dJyYBp8rffmpJ2TJh66Qa0d8DUbCO4I9SNQtxbDmBs/ma9x3RzS80D5qyEZd5
	VvyGp2CktzQ6zZUeCrKE845I/WxgiieAfuF0iq3CELD94iCvJ9QgDagVOTct3MZVdhHN
	/DjITLzbVzVYB+QSK9lGWKG1FtEY4VO4FMQz8mTSPxPqNY2VtULHPE6UeAo1R8s8KmN5
	RmcaRcouhTAA7OMIapLp59ffSD4bgMUn6phDVbiuC0FTIUDLxhSPXowfw0P4f5mKLVta
	SlFC3GuYWQbRf4P7/hDf3x0jZwv1+qU7F/PVkitdmbTX82tzQroy72aF2CVh44o/T44M
	5YXg==
X-Gm-Message-State: AOPr4FV18mc5vagk6YrzwNNQgqMe/IncDMgAnEc54Dbd1W5YkuHS2u6XHU98IFiureiu0Q==
X-Received: by 10.98.67.150 with SMTP id l22mr39086093pfi.85.1462045272481;
	Sat, 30 Apr 2016 12:41:12 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	d78sm33226530pfb.59.2016.04.30.12.41.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:41:11 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:41:00 -0700
Message-Id: <b5acd266233c34a439097e8024ab8cbcb7e1e77c.1462041562.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
References: <4fceafdd226761b2716466f9fd522db9be554971.1462041562.git.chris_larson@mentor.com>
In-Reply-To: <cover.1462041562.git.chris_larson@mentor.com>
References: <cover.1462041562.git.chris_larson@mentor.com>
X-Mailman-Approved-At: Fri, 06 May 2016 09:12:57 +0000
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [RFC master][PATCH 4/4] bitbake-layers: convert to plugin-based
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
X-List-Received-Date: Sat, 30 Apr 2016 19:41:12 -0000

From: Christopher Larson <chris_larson@mentor.com>

This uses bb.utils.load_plugins, based on the plugin handling in recipetool
and devtool in oe-core.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 bin/bitbake-layers                 | 1065 ++----------------------------------
 bitbake/lib/bblayers/__init__.py   |    2 +
 bitbake/lib/bblayers/action.py     |  233 ++++++++
 bitbake/lib/bblayers/common.py     |   33 ++
 bitbake/lib/bblayers/layerindex.py |  270 +++++++++
 bitbake/lib/bblayers/query.py      |  499 +++++++++++++++++
 6 files changed, 1097 insertions(+), 1005 deletions(-)
 create mode 100644 bitbake/lib/bblayers/__init__.py
 create mode 100644 bitbake/lib/bblayers/action.py
 create mode 100644 bitbake/lib/bblayers/common.py
 create mode 100644 bitbake/lib/bblayers/layerindex.py
 create mode 100644 bitbake/lib/bblayers/query.py

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index d47a669..d8ffa95 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -23,1048 +23,103 @@
 import logging
 import os
 import sys
-import fnmatch
-from collections import defaultdict
 import argparse
-import re
-import httplib, urlparse, json
-import subprocess
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
 sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
-import bb.cache
-import bb.cooker
-import bb.providers
-import bb.utils
 import bb.tinfoil
 
 
+def tinfoil_init(parserecipes):
+    import bb.tinfoil
+    tinfoil = bb.tinfoil.Tinfoil(tracking=True)
+    tinfoil.prepare(not parserecipes)
+    tinfoil.logger.setLevel(logger.getEffectiveLevel())
+    return tinfoil
+
+
 def logger_create(name, output=sys.stderr):
     logger = logging.getLogger(name)
-    console = logging.StreamHandler(output)
-    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
-    if output.isatty():
-        format.enable_color()
-    console.setFormatter(format)
-    logger.addHandler(console)
+    loggerhandler = logging.StreamHandler(output)
+    loggerhandler.setFormatter(logging.Formatter("%(levelname)s: %(message)s"))
+    logger.addHandler(loggerhandler)
     logger.setLevel(logging.INFO)
     return logger
 
-logger = logger_create('bitbake-layers', sys.stdout)
-
-class UserError(Exception):
-    pass
-
-class Commands():
-    def __init__(self):
-        self.bbhandler = None
-        self.bblayers = []
-
-    def init_bbhandler(self, config_only = False):
-        if not self.bbhandler:
-            self.bbhandler = bb.tinfoil.Tinfoil(tracking=True)
-            self.bblayers = (self.bbhandler.config_data.getVar('BBLAYERS', True) or "").split()
-            self.bbhandler.prepare(config_only)
-            layerconfs = self.bbhandler.config_data.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', self.bbhandler.config_data)
-            self.bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.iteritems()}
-
-
-    def do_show_layers(self, args):
-        """show current configured layers"""
-        self.init_bbhandler(config_only = True)
-        logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
-        logger.plain('=' * 74)
-        for layer, _, regex, pri in self.bbhandler.cooker.recipecache.bbfile_config_priorities:
-            layerdir = self.bbfile_collections.get(layer, None)
-            layername = self.get_layer_name(layerdir)
-            logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), pri))
-
-
-    def do_add_layer(self, args):
-        """Add a layer to bblayers.conf
-
-Adds the specified layer to bblayers.conf
-"""
-        layerdir = os.path.abspath(args.layerdir)
-        if not os.path.exists(layerdir):
-            sys.stderr.write("Specified layer directory doesn't exist\n")
-            return 1
-
-        layer_conf = os.path.join(layerdir, 'conf', 'layer.conf')
-        if not os.path.exists(layer_conf):
-            sys.stderr.write("Specified layer directory doesn't contain a conf/layer.conf file\n")
-            return 1
-
-        bblayers_conf = os.path.join('conf', 'bblayers.conf')
-        if not os.path.exists(bblayers_conf):
-            sys.stderr.write("Unable to find bblayers.conf\n")
-            return 1
-
-        (notadded, _) = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
-        if notadded:
-            for item in notadded:
-                sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
-
-
-    def do_remove_layer(self, args):
-        """Remove a layer from bblayers.conf
-
-Removes the specified layer from bblayers.conf
-"""
-        bblayers_conf = os.path.join('conf', 'bblayers.conf')
-        if not os.path.exists(bblayers_conf):
-            sys.stderr.write("Unable to find bblayers.conf\n")
-            return 1
-
-        if args.layerdir.startswith('*'):
-            layerdir = args.layerdir
-        elif not '/' in args.layerdir:
-            layerdir = '*/%s' % args.layerdir
-        else:
-            layerdir = os.path.abspath(args.layerdir)
-        (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdir)
-        if notremoved:
-            for item in notremoved:
-                sys.stderr.write("No layers matching %s found in BBLAYERS\n" % item)
-            return 1
-
-
-    def get_json_data(self, apiurl):
-        proxy_settings = os.environ.get("http_proxy", None)
-        conn = None
-        _parsedurl = urlparse.urlparse(apiurl)
-        path = _parsedurl.path
-        query = _parsedurl.query
-        def parse_url(url):
-            parsedurl = urlparse.urlparse(url)
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
-            conn = httplib.HTTPConnection(host, port)
-            conn.request("GET", path + "?" + query)
-        else:
-            host, port = parse_url(proxy_settings)
-            conn = httplib.HTTPConnection(host, port)
-            conn.request("GET", apiurl)
-
-        r = conn.getresponse()
-        if r.status != 200:
-            raise Exception("Failed to read " + path + ": %d %s" % (r.status, r.reason))
-        return json.loads(r.read())
-
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
-
-    def do_layerindex_fetch(self, args):
-        """Fetches a layer from a layer index along with its dependent layers, and adds them to conf/bblayers.conf.
-"""
-        self.init_bbhandler(config_only = True)
-        apiurl = self.bbhandler.config_data.getVar('BBLAYERS_LAYERINDEX_URL', True)
-        if not apiurl:
-            logger.error("Cannot get BBLAYERS_LAYERINDEX_URL")
-            return 1
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
-            return 1
-
-        ignore_layers = []
-        for collection in self.bbhandler.config_data.getVar('BBFILE_COLLECTIONS', True).split():
-            lname = self.bbhandler.config_data.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % collection, True)
-            if lname:
-                ignore_layers.append(lname)
-
-        if args.ignore:
-            ignore_layers.extend(args.ignore.split(','))
-
-        layeritems = self.get_json_data(apilinks['layerItems'])
-        layerbranches = self.get_json_data(apilinks['layerBranches'])
-        layerdependencies = self.get_json_data(apilinks['layerDependencies'])
-        invaluenames = []
-        repourls = {}
-        printlayers = []
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
-            fetchdir = self.bbhandler.config_data.getVar('BBLAYERS_FETCH_DIR', True)
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
-                else:
-                    break
-
-
-    def do_layerindex_show_depends(self, args):
-        """Find layer dependencies from layer index.
-"""
-        args.show_only = True
-        args.ignore = []
-        self.do_layerindex_fetch(args)
-
-
-    def version_str(self, pe, pv, pr = None):
-        verstr = "%s" % pv
-        if pr:
-            verstr = "%s-%s" % (verstr, pr)
-        if pe:
-            verstr = "%s:%s" % (pe, verstr)
-        return verstr
-
-
-    def do_show_overlayed(self, args):
-        """list overlayed recipes (where the same recipe exists in another layer)
-
-Lists the names of overlayed recipes and the available versions in each
-layer, with the preferred version first. Note that skipped recipes that
-are overlayed will also be listed, with a " (skipped)" suffix.
-"""
-        self.init_bbhandler()
-
-        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, True, None)
-
-        # Check for overlayed .bbclass files
-        classes = defaultdict(list)
-        for layerdir in self.bblayers:
-            classdir = os.path.join(layerdir, 'classes')
-            if os.path.exists(classdir):
-                for classfile in os.listdir(classdir):
-                    if os.path.splitext(classfile)[1] == '.bbclass':
-                        classes[classfile].append(classdir)
-
-        # Locating classes and other files is a bit more complicated than recipes -
-        # layer priority is not a factor; instead BitBake uses the first matching
-        # file in BBPATH, which is manipulated directly by each layer's
-        # conf/layer.conf in turn, thus the order of layers in bblayers.conf is a
-        # factor - however, each layer.conf is free to either prepend or append to
-        # BBPATH (or indeed do crazy stuff with it). Thus the order in BBPATH might
-        # not be exactly the order present in bblayers.conf either.
-        bbpath = str(self.bbhandler.config_data.getVar('BBPATH', True))
-        overlayed_class_found = False
-        for (classfile, classdirs) in classes.items():
-            if len(classdirs) > 1:
-                if not overlayed_class_found:
-                    logger.plain('=== Overlayed classes ===')
-                    overlayed_class_found = True
-
-                mainfile = bb.utils.which(bbpath, os.path.join('classes', classfile))
-                if args.filenames:
-                    logger.plain('%s' % mainfile)
-                else:
-                    # We effectively have to guess the layer here
-                    logger.plain('%s:' % classfile)
-                    mainlayername = '?'
-                    for layerdir in self.bblayers:
-                        classdir = os.path.join(layerdir, 'classes')
-                        if mainfile.startswith(classdir):
-                            mainlayername = self.get_layer_name(layerdir)
-                    logger.plain('  %s' % mainlayername)
-                for classdir in classdirs:
-                    fullpath = os.path.join(classdir, classfile)
-                    if fullpath != mainfile:
-                        if args.filenames:
-                            print('  %s' % fullpath)
-                        else:
-                            print('  %s' % self.get_layer_name(os.path.dirname(classdir)))
-
-        if overlayed_class_found:
-            items_listed = True;
-
-        if not items_listed:
-            logger.plain('No overlayed files found.')
-
-
-    def do_show_recipes(self, args):
-        """list available recipes, showing the layer they are provided by
-
-Lists the names of recipes and the available versions in each
-layer, with the preferred version first. Optionally you may specify
-pnspec to match a specified recipe name (supports wildcards). Note that
-skipped recipes will also be listed, with a " (skipped)" suffix.
-"""
-        self.init_bbhandler()
-
-        inheritlist = args.inherits.split(',') if args.inherits else []
-        if inheritlist or args.pnspec or args.multiple:
-            title = 'Matching recipes:'
-        else:
-            title = 'Available recipes:'
-        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.multiple, inheritlist)
-
-
-    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only, inherits):
-        if inherits:
-            bbpath = str(self.bbhandler.config_data.getVar('BBPATH', True))
-            for classname in inherits:
-                classfile = 'classes/%s.bbclass' % classname
-                if not bb.utils.which(bbpath, classfile, history=False):
-                    raise UserError('No class named %s found in BBPATH' % classfile)
-
-        pkg_pn = self.bbhandler.cooker.recipecache.pkg_pn
-        (latest_versions, preferred_versions) = bb.providers.findProviders(self.bbhandler.config_data, self.bbhandler.cooker.recipecache, pkg_pn)
-        allproviders = bb.providers.allProviders(self.bbhandler.cooker.recipecache)
-
-        # Ensure we list skipped recipes
-        # We are largely guessing about PN, PV and the preferred version here,
-        # but we have no choice since skipped recipes are not fully parsed
-        skiplist = self.bbhandler.cooker.skiplist.keys()
-        skiplist.sort( key=lambda fileitem: self.bbhandler.cooker.collection.calc_bbfile_priority(fileitem) )
-        skiplist.reverse()
-        for fn in skiplist:
-            recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')
-            p = recipe_parts[0]
-            if len(recipe_parts) > 1:
-                ver = (None, recipe_parts[1], None)
-            else:
-                ver = (None, 'unknown', None)
-            allproviders[p].append((ver, fn))
-            if not p in pkg_pn:
-                pkg_pn[p] = 'dummy'
-                preferred_versions[p] = (ver, fn)
-
-        def print_item(f, pn, ver, layer, ispref):
-            if f in skiplist:
-                skipped = ' (skipped)'
-            else:
-                skipped = ''
-            if show_filenames:
-                if ispref:
-                    logger.plain("%s%s", f, skipped)
-                else:
-                    logger.plain("  %s%s", f, skipped)
-            else:
-                if ispref:
-                    logger.plain("%s:", pn)
-                logger.plain("  %s %s%s", layer.ljust(20), ver, skipped)
-
-        global_inherit = (self.bbhandler.config_data.getVar('INHERIT', True) or "").split()
-        cls_re = re.compile('classes/')
-
-        preffiles = []
-        items_listed = False
-        for p in sorted(pkg_pn):
-            if pnspec:
-                if not fnmatch.fnmatch(p, pnspec):
-                    continue
-
-            if len(allproviders[p]) > 1 or not show_multi_provider_only:
-                pref = preferred_versions[p]
-                realfn = bb.cache.Cache.virtualfn2realfn(pref[1])
-                preffile = realfn[0]
-
-                # We only display once per recipe, we should prefer non extended versions of the
-                # recipe if present (so e.g. in OpenEmbedded, openssl rather than nativesdk-openssl
-                # which would otherwise sort first).
-                if realfn[1] and realfn[0] in self.bbhandler.cooker.recipecache.pkg_fn:
-                    continue
-
-                if inherits:
-                    matchcount = 0
-                    recipe_inherits = self.bbhandler.cooker_data.inherits.get(preffile, [])
-                    for cls in recipe_inherits:
-                        if cls_re.match(cls):
-                            continue
-                        classname = os.path.splitext(os.path.basename(cls))[0]
-                        if classname in global_inherit:
-                            continue
-                        elif classname in inherits:
-                            matchcount += 1
-                    if matchcount != len(inherits):
-                        # No match - skip this recipe
-                        continue
-
-                if preffile not in preffiles:
-                    preflayer = self.get_file_layer(preffile)
-                    multilayer = False
-                    same_ver = True
-                    provs = []
-                    for prov in allproviders[p]:
-                        provfile = bb.cache.Cache.virtualfn2realfn(prov[1])[0]
-                        provlayer = self.get_file_layer(provfile)
-                        provs.append((provfile, provlayer, prov[0]))
-                        if provlayer != preflayer:
-                            multilayer = True
-                        if prov[0] != pref[0]:
-                            same_ver = False
-
-                    if (multilayer or not show_overlayed_only) and (same_ver or not show_same_ver_only):
-                        if not items_listed:
-                            logger.plain('=== %s ===' % title)
-                            items_listed = True
-                        print_item(preffile, p, self.version_str(pref[0][0], pref[0][1]), preflayer, True)
-                        for (provfile, provlayer, provver) in provs:
-                            if provfile != preffile:
-                                print_item(provfile, p, self.version_str(provver[0], provver[1]), provlayer, False)
-                        # Ensure we don't show two entries for BBCLASSEXTENDed recipes
-                        preffiles.append(preffile)
 
-        return items_listed
+def logger_setup_color(logger, color='auto'):
+    from bb.msg import BBLogFormatter
+    console = logging.StreamHandler(sys.stdout)
+    formatter = BBLogFormatter("%(levelname)s: %(message)s")
+    console.setFormatter(formatter)
+    logger.handlers = [console]
+    if color == 'always' or (color == 'auto' and console.stream.isatty()):
+        formatter.enable_color()
 
 
-    def do_flatten(self, args):
-        """flatten layer configuration into a separate output directory.
-
-Takes the specified layers (or all layers in the current layer
-configuration if none are specified) and builds a "flattened" directory
-containing the contents of all layers, with any overlayed recipes removed
-and bbappends appended to the corresponding recipes. Note that some manual
-cleanup may still be necessary afterwards, in particular:
-
-* where non-recipe files (such as patches) are overwritten (the flatten
-  command will show a warning for these)
-* where anything beyond the normal layer setup has been added to
-  layer.conf (only the lowest priority number layer's layer.conf is used)
-* overridden/appended items from bbappends will need to be tidied up
-* when the flattened layers do not have the same directory structure (the
-  flatten command should show a warning when this will cause a problem)
-
-Warning: if you flatten several layers where another layer is intended to
-be used "inbetween" them (in layer priority order) such that recipes /
-bbappends in the layers interact, and then attempt to use the new output
-layer together with that other layer, you may no longer get the same
-build results (as the layer priority order has effectively changed).
-"""
-        if len(args.layer) == 1:
-            logger.error('If you specify layers to flatten you must specify at least two')
-            return 1
-
-        outputdir = args.outputdir
-        if os.path.exists(outputdir) and os.listdir(outputdir):
-            logger.error('Directory %s exists and is non-empty, please clear it out first' % outputdir)
-            return 1
-
-        self.init_bbhandler()
-        layers = self.bblayers
-        if len(args.layer) > 2:
-            layernames = args.layer
-            found_layernames = []
-            found_layerdirs = []
-            for layerdir in layers:
-                layername = self.get_layer_name(layerdir)
-                if layername in layernames:
-                    found_layerdirs.append(layerdir)
-                    found_layernames.append(layername)
-
-            for layername in layernames:
-                if not layername in found_layernames:
-                    logger.error('Unable to find layer %s in current configuration, please run "%s show-layers" to list configured layers' % (layername, os.path.basename(sys.argv[0])))
-                    return
-            layers = found_layerdirs
-        else:
-            layernames = []
-
-        # Ensure a specified path matches our list of layers
-        def layer_path_match(path):
-            for layerdir in layers:
-                if path.startswith(os.path.join(layerdir, '')):
-                    return layerdir
-            return None
-
-        applied_appends = []
-        for layer in layers:
-            overlayed = []
-            for f in self.bbhandler.cooker.collection.overlayed.iterkeys():
-                for of in self.bbhandler.cooker.collection.overlayed[f]:
-                    if of.startswith(layer):
-                        overlayed.append(of)
-
-            logger.plain('Copying files from %s...' % layer )
-            for root, dirs, files in os.walk(layer):
-                for f1 in files:
-                    f1full = os.sep.join([root, f1])
-                    if f1full in overlayed:
-                        logger.plain('  Skipping overlayed file %s' % f1full )
-                    else:
-                        ext = os.path.splitext(f1)[1]
-                        if ext != '.bbappend':
-                            fdest = f1full[len(layer):]
-                            fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
-                            bb.utils.mkdirhier(os.path.dirname(fdest))
-                            if os.path.exists(fdest):
-                                if f1 == 'layer.conf' and root.endswith('/conf'):
-                                    logger.plain('  Skipping layer config file %s' % f1full )
-                                    continue
-                                else:
-                                    logger.warn('Overwriting file %s', fdest)
-                            bb.utils.copyfile(f1full, fdest)
-                            if ext == '.bb':
-                                for append in self.bbhandler.cooker.collection.get_file_appends(f1full):
-                                    if layer_path_match(append):
-                                        logger.plain('  Applying append %s to %s' % (append, fdest))
-                                        self.apply_append(append, fdest)
-                                        applied_appends.append(append)
-
-        # Take care of when some layers are excluded and yet we have included bbappends for those recipes
-        for b in self.bbhandler.cooker.collection.bbappends:
-            (recipename, appendname) = b
-            if appendname not in applied_appends:
-                first_append = None
-                layer = layer_path_match(appendname)
-                if layer:
-                    if first_append:
-                        self.apply_append(appendname, first_append)
-                    else:
-                        fdest = appendname[len(layer):]
-                        fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
-                        bb.utils.mkdirhier(os.path.dirname(fdest))
-                        bb.utils.copyfile(appendname, fdest)
-                        first_append = fdest
-
-        # Get the regex for the first layer in our list (which is where the conf/layer.conf file will
-        # have come from)
-        first_regex = None
-        layerdir = layers[0]
-        for layername, pattern, regex, _ in self.bbhandler.cooker.recipecache.bbfile_config_priorities:
-            if regex.match(os.path.join(layerdir, 'test')):
-                first_regex = regex
-                break
-
-        if first_regex:
-            # Find the BBFILES entries that match (which will have come from this conf/layer.conf file)
-            bbfiles = str(self.bbhandler.config_data.getVar('BBFILES', True)).split()
-            bbfiles_layer = []
-            for item in bbfiles:
-                if first_regex.match(item):
-                    newpath = os.path.join(outputdir, item[len(layerdir)+1:])
-                    bbfiles_layer.append(newpath)
-
-            if bbfiles_layer:
-                # Check that all important layer files match BBFILES
-                for root, dirs, files in os.walk(outputdir):
-                    for f1 in files:
-                        ext = os.path.splitext(f1)[1]
-                        if ext in ['.bb', '.bbappend']:
-                            f1full = os.sep.join([root, f1])
-                            entry_found = False
-                            for item in bbfiles_layer:
-                                if fnmatch.fnmatch(f1full, item):
-                                    entry_found = True
-                                    break
-                            if not entry_found:
-                                logger.warning("File %s does not match the flattened layer's BBFILES setting, you may need to edit conf/layer.conf or move the file elsewhere" % f1full)
-
-    def get_file_layer(self, filename):
-        layerdir = self.get_file_layerdir(filename)
-        if layerdir:
-            return self.get_layer_name(layerdir)
-        else:
-            return '?'
-
-    def get_file_layerdir(self, filename):
-        layer = bb.utils.get_file_layer(filename, self.bbhandler.config_data)
-        return self.bbfile_collections.get(layer, None)
-
-    def remove_layer_prefix(self, f):
-        """Remove the layer_dir prefix, e.g., f = /path/to/layer_dir/foo/blah, the
-           return value will be: layer_dir/foo/blah"""
-        f_layerdir = self.get_file_layerdir(f)
-        if not f_layerdir:
-            return f
-        prefix = os.path.join(os.path.dirname(f_layerdir), '')
-        return f[len(prefix):] if f.startswith(prefix) else f
-
-    def get_layer_name(self, layerdir):
-        return os.path.basename(layerdir.rstrip(os.sep))
-
-    def apply_append(self, appendname, recipename):
-        with open(appendname, 'r') as appendfile:
-            with open(recipename, 'a') as recipefile:
-                recipefile.write('\n')
-                recipefile.write('##### bbappended from %s #####\n' % self.get_file_layer(appendname))
-                recipefile.writelines(appendfile.readlines())
-
-    def do_show_appends(self, args):
-        """list bbappend files and recipe files they apply to
-
-Lists recipes with the bbappends that apply to them as subitems.
-"""
-        self.init_bbhandler()
-
-        logger.plain('=== Appended recipes ===')
-
-        pnlist = list(self.bbhandler.cooker_data.pkg_pn.keys())
-        pnlist.sort()
-        appends = False
-        for pn in pnlist:
-            if self.show_appends_for_pn(pn):
-                appends = True
-
-        if self.show_appends_for_skipped():
-            appends = True
-
-        if not appends:
-            logger.plain('No append files found')
-
-    def show_appends_for_pn(self, pn):
-        filenames = self.bbhandler.cooker_data.pkg_pn[pn]
-
-        best = bb.providers.findBestProvider(pn,
-                                             self.bbhandler.config_data,
-                                             self.bbhandler.cooker_data,
-                                             self.bbhandler.cooker_data.pkg_pn)
-        best_filename = os.path.basename(best[3])
-
-        return self.show_appends_output(filenames, best_filename)
-
-    def show_appends_for_skipped(self):
-        filenames = [os.path.basename(f)
-                    for f in self.bbhandler.cooker.skiplist.iterkeys()]
-        return self.show_appends_output(filenames, None, " (skipped)")
-
-    def show_appends_output(self, filenames, best_filename, name_suffix = ''):
-        appended, missing = self.get_appends_for_files(filenames)
-        if appended:
-            for basename, appends in appended:
-                logger.plain('%s%s:', basename, name_suffix)
-                for append in appends:
-                    logger.plain('  %s', append)
-
-            if best_filename:
-                if best_filename in missing:
-                    logger.warn('%s: missing append for preferred version',
-                                best_filename)
-            return True
-        else:
-            return False
-
-    def get_appends_for_files(self, filenames):
-        appended, notappended = [], []
-        for filename in filenames:
-            _, cls = bb.cache.Cache.virtualfn2realfn(filename)
-            if cls:
-                continue
-
-            basename = os.path.basename(filename)
-            appends = self.bbhandler.cooker.collection.get_file_appends(basename)
-            if appends:
-                appended.append((basename, list(appends)))
-            else:
-                notappended.append(basename)
-        return appended, notappended
-
-    def do_show_cross_depends(self, args):
-        """Show dependencies between recipes that cross layer boundaries.
-
-Figure out the dependencies between recipes that cross layer boundaries.
-
-NOTE: .bbappend files can impact the dependencies.
-"""
-        ignore_layers = (args.ignore or '').split(',')
-
-        self.init_bbhandler()
-
-        pkg_fn = self.bbhandler.cooker_data.pkg_fn
-        bbpath = str(self.bbhandler.config_data.getVar('BBPATH', True))
-        self.require_re = re.compile(r"require\s+(.+)")
-        self.include_re = re.compile(r"include\s+(.+)")
-        self.inherit_re = re.compile(r"inherit\s+(.+)")
-
-        global_inherit = (self.bbhandler.config_data.getVar('INHERIT', True) or "").split()
-
-        # The bb's DEPENDS and RDEPENDS
-        for f in pkg_fn:
-            f = bb.cache.Cache.virtualfn2realfn(f)[0]
-            # Get the layername that the file is in
-            layername = self.get_file_layer(f)
-
-            # The DEPENDS
-            deps = self.bbhandler.cooker_data.deps[f]
-            for pn in deps:
-                if pn in self.bbhandler.cooker_data.pkg_pn:
-                    best = bb.providers.findBestProvider(pn,
-                            self.bbhandler.config_data,
-                            self.bbhandler.cooker_data,
-                            self.bbhandler.cooker_data.pkg_pn)
-                    self.check_cross_depends("DEPENDS", layername, f, best[3], args.filenames, ignore_layers)
-
-            # The RDPENDS
-            all_rdeps = self.bbhandler.cooker_data.rundeps[f].values()
-            # Remove the duplicated or null one.
-            sorted_rdeps = {}
-            # The all_rdeps is the list in list, so we need two for loops
-            for k1 in all_rdeps:
-                for k2 in k1:
-                    sorted_rdeps[k2] = 1
-            all_rdeps = sorted_rdeps.keys()
-            for rdep in all_rdeps:
-                all_p = bb.providers.getRuntimeProviders(self.bbhandler.cooker_data, rdep)
-                if all_p:
-                    if f in all_p:
-                        # The recipe provides this one itself, ignore
-                        continue
-                    best = bb.providers.filterProvidersRunTime(all_p, rdep,
-                                    self.bbhandler.config_data,
-                                    self.bbhandler.cooker_data)[0][0]
-                    self.check_cross_depends("RDEPENDS", layername, f, best, args.filenames, ignore_layers)
-
-            # The RRECOMMENDS
-            all_rrecs = self.bbhandler.cooker_data.runrecs[f].values()
-            # Remove the duplicated or null one.
-            sorted_rrecs = {}
-            # The all_rrecs is the list in list, so we need two for loops
-            for k1 in all_rrecs:
-                for k2 in k1:
-                    sorted_rrecs[k2] = 1
-            all_rrecs = sorted_rrecs.keys()
-            for rrec in all_rrecs:
-                all_p = bb.providers.getRuntimeProviders(self.bbhandler.cooker_data, rrec)
-                if all_p:
-                    if f in all_p:
-                        # The recipe provides this one itself, ignore
-                        continue
-                    best = bb.providers.filterProvidersRunTime(all_p, rrec,
-                                    self.bbhandler.config_data,
-                                    self.bbhandler.cooker_data)[0][0]
-                    self.check_cross_depends("RRECOMMENDS", layername, f, best, args.filenames, ignore_layers)
-
-            # The inherit class
-            cls_re = re.compile('classes/')
-            if f in self.bbhandler.cooker_data.inherits:
-                inherits = self.bbhandler.cooker_data.inherits[f]
-                for cls in inherits:
-                    # The inherits' format is [classes/cls, /path/to/classes/cls]
-                    # ignore the classes/cls.
-                    if not cls_re.match(cls):
-                        classname = os.path.splitext(os.path.basename(cls))[0]
-                        if classname in global_inherit:
-                            continue
-                        inherit_layername = self.get_file_layer(cls)
-                        if inherit_layername != layername and not inherit_layername in ignore_layers:
-                            if not args.filenames:
-                                f_short = self.remove_layer_prefix(f)
-                                cls = self.remove_layer_prefix(cls)
-                            else:
-                                f_short = f
-                            logger.plain("%s inherits %s" % (f_short, cls))
-
-            # The 'require/include xxx' in the bb file
-            pv_re = re.compile(r"\${PV}")
-            with open(f, 'r') as fnfile:
-                line = fnfile.readline()
-                while line:
-                    m, keyword = self.match_require_include(line)
-                    # Found the 'require/include xxxx'
-                    if m:
-                        needed_file = m.group(1)
-                        # Replace the ${PV} with the real PV
-                        if pv_re.search(needed_file) and f in self.bbhandler.cooker_data.pkg_pepvpr:
-                            pv = self.bbhandler.cooker_data.pkg_pepvpr[f][1]
-                            needed_file = re.sub(r"\${PV}", pv, needed_file)
-                        self.print_cross_files(bbpath, keyword, layername, f, needed_file, args.filenames, ignore_layers)
-                    line = fnfile.readline()
-
-        # The "require/include xxx" in conf/machine/*.conf, .inc and .bbclass
-        conf_re = re.compile(".*/conf/machine/[^\/]*\.conf$")
-        inc_re = re.compile(".*\.inc$")
-        # The "inherit xxx" in .bbclass
-        bbclass_re = re.compile(".*\.bbclass$")
-        for layerdir in self.bblayers:
-            layername = self.get_layer_name(layerdir)
-            for dirpath, dirnames, filenames in os.walk(layerdir):
-                for name in filenames:
-                    f = os.path.join(dirpath, name)
-                    s = conf_re.match(f) or inc_re.match(f) or bbclass_re.match(f)
-                    if s:
-                        with open(f, 'r') as ffile:
-                            line = ffile.readline()
-                            while line:
-                                m, keyword = self.match_require_include(line)
-                                # Only bbclass has the "inherit xxx" here.
-                                bbclass=""
-                                if not m and f.endswith(".bbclass"):
-                                    m, keyword = self.match_inherit(line)
-                                    bbclass=".bbclass"
-                                # Find a 'require/include xxxx'
-                                if m:
-                                    self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, args.filenames, ignore_layers)
-                                line = ffile.readline()
-
-    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename, show_filenames, ignore_layers):
-        """Print the depends that crosses a layer boundary"""
-        needed_file = bb.utils.which(bbpath, needed_filename)
-        if needed_file:
-            # Which layer is this file from
-            needed_layername = self.get_file_layer(needed_file)
-            if needed_layername != layername and not needed_layername in ignore_layers:
-                if not show_filenames:
-                    f = self.remove_layer_prefix(f)
-                    needed_file = self.remove_layer_prefix(needed_file)
-                logger.plain("%s %s %s" %(f, keyword, needed_file))
-
-    def match_inherit(self, line):
-        """Match the inherit xxx line"""
-        return (self.inherit_re.match(line), "inherits")
-
-    def match_require_include(self, line):
-        """Match the require/include xxx line"""
-        m = self.require_re.match(line)
-        keyword = "requires"
-        if not m:
-            m = self.include_re.match(line)
-            keyword = "includes"
-        return (m, keyword)
-
-    def check_cross_depends(self, keyword, layername, f, needed_file, show_filenames, ignore_layers):
-        """Print the DEPENDS/RDEPENDS file that crosses a layer boundary"""
-        best_realfn = bb.cache.Cache.virtualfn2realfn(needed_file)[0]
-        needed_layername = self.get_file_layer(best_realfn)
-        if needed_layername != layername and not needed_layername in ignore_layers:
-            if not show_filenames:
-                f = self.remove_layer_prefix(f)
-                best_realfn = self.remove_layer_prefix(best_realfn)
-
-            logger.plain("%s %s %s" % (f, keyword, best_realfn))
+logger = logger_create('bitbake-layers', sys.stdout)
 
 
 def main():
-
-    cmds = Commands()
-
-    def add_command(cmdname, function, *args, **kwargs):
-        # Convert docstring for function to help (one-liner shown in main --help) and description (shown in subcommand --help)
-        docsplit = function.__doc__.splitlines()
-        help = docsplit[0]
-        if len(docsplit) > 1:
-            desc = '\n'.join(docsplit[1:])
-        else:
-            desc = help
-        subparser = subparsers.add_parser(cmdname, *args, help=help, description=desc, formatter_class=argparse.RawTextHelpFormatter, **kwargs)
-        subparser.set_defaults(func=function)
-        return subparser
-
-    parser = argparse.ArgumentParser(description="BitBake layers utility",
-                                     epilog="Use %(prog)s <subcommand> --help to get help on a specific command")
+    parser = argparse.ArgumentParser(
+        description="BitBake layers utility",
+        epilog="Use %(prog)s <subcommand> --help to get help on a specific command",
+        add_help=False)
     parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
     parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
-    subparsers = parser.add_subparsers(title='subcommands', metavar='<subcommand>')
-
-    parser_show_layers = add_command('show-layers', cmds.do_show_layers)
-
-    parser_add_layer = add_command('add-layer', cmds.do_add_layer)
-    parser_add_layer.add_argument('layerdir', help='Layer directory to add')
-
-    parser_remove_layer = add_command('remove-layer', cmds.do_remove_layer)
-    parser_remove_layer.add_argument('layerdir', help='Layer directory to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
-    parser_remove_layer.set_defaults(func=cmds.do_remove_layer)
-
-    parser_show_overlayed = add_command('show-overlayed', cmds.do_show_overlayed)
-    parser_show_overlayed.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
-    parser_show_overlayed.add_argument('-s', '--same-version', help='only list overlayed recipes where the version is the same', action='store_true')
+    parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
 
-    parser_show_recipes = add_command('show-recipes', cmds.do_show_recipes)
-    parser_show_recipes.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
-    parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
-    parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class', metavar='CLASS', default='')
-    parser_show_recipes.add_argument('pnspec', nargs='?', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
+    global_args, unparsed_args = parser.parse_known_args()
 
-    parser_show_appends = add_command('show-appends', cmds.do_show_appends)
+    # Help is added here rather than via add_help=True, as we don't want it to
+    # be handled by parse_known_args()
+    parser.add_argument('-h', '--help', action='help', default=argparse.SUPPRESS,
+                        help='show this help message and exit')
+    subparsers = parser.add_subparsers(title='subcommands', metavar='<subcommand>')
 
-    parser_flatten = add_command('flatten', cmds.do_flatten)
-    parser_flatten.add_argument('layer', nargs='*', help='Optional layer(s) to flatten (otherwise all are flattened)')
-    parser_flatten.add_argument('outputdir', help='Output directory')
+    if global_args.debug:
+        logger.setLevel(logging.DEBUG)
+    elif global_args.quiet:
+        logger.setLevel(logging.ERROR)
 
-    parser_show_cross_depends = add_command('show-cross-depends', cmds.do_show_cross_depends)
-    parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
-    parser_show_cross_depends.add_argument('-i', '--ignore', help='ignore dependencies on items in the specified layer(s) (split multiple layer names with commas, no spaces)', metavar='LAYERNAME')
+    logger_setup_color(logger, global_args.color)
 
-    parser_layerindex_fetch = add_command('layerindex-fetch', cmds.do_layerindex_fetch)
-    parser_layerindex_fetch.add_argument('-n', '--show-only', help='show dependencies and do nothing else', action='store_true')
-    parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
-    parser_layerindex_fetch.add_argument('-i', '--ignore', help='assume the specified layers do not need to be fetched/added (separate multiple layers with commas, no spaces)', metavar='LAYER')
-    parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
+    plugins = []
+    tinfoil = tinfoil_init(False)
+    for path in ([topdir] +
+                 tinfoil.config_data.getVar('BBPATH', True).split(':')):
+        pluginpath = os.path.join(path, 'lib', 'bblayers')
+        bb.utils.load_plugins(logger, plugins, pluginpath)
 
-    parser_layerindex_show_depends = add_command('layerindex-show-depends', cmds.do_layerindex_show_depends)
-    parser_layerindex_show_depends.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
-    parser_layerindex_show_depends.add_argument('layername', nargs='+', help='layer to query')
+    registered = False
+    for plugin in plugins:
+        if hasattr(plugin, 'register_commands'):
+            registered = True
+            plugin.register_commands(subparsers)
+        if hasattr(plugin, 'tinfoil_init'):
+            plugin.tinfoil_init(tinfoil)
 
-    args = parser.parse_args()
+    if not registered:
+        logger.error("No commands registered - missing plugins?")
+        sys.exit(1)
 
-    if args.debug:
-        logger.setLevel(logging.DEBUG)
-    elif args.quiet:
-        logger.setLevel(logging.ERROR)
+    args = parser.parse_args(unparsed_args, namespace=global_args)
 
-    try:
-        ret = args.func(args)
-    except UserError as err:
-        logger.error(str(err))
-        ret = 1
+    if getattr(args, 'parserecipes', False):
+        tinfoil.config_data.disableTracking()
+        tinfoil.parseRecipes()
+        tinfoil.config_data.enableTracking()
 
-    return ret
+    return args.func(args)
 
 
 if __name__ == "__main__":
     try:
         ret = main()
+    except bb.BBHandledException:
+        ret = 1
     except Exception:
         ret = 1
         import traceback
diff --git a/bitbake/lib/bblayers/__init__.py b/bitbake/lib/bblayers/__init__.py
new file mode 100644
index 0000000..3ad9513
--- /dev/null
+++ b/bitbake/lib/bblayers/__init__.py
@@ -0,0 +1,2 @@
+from pkgutil import extend_path
+__path__ = extend_path(__path__, __name__)
diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
new file mode 100644
index 0000000..36f3987
--- /dev/null
+++ b/bitbake/lib/bblayers/action.py
@@ -0,0 +1,233 @@
+import fnmatch
+import logging
+import os
+import sys
+
+import bb.utils
+
+from bblayers.common import LayerPlugin
+
+logger = logging.getLogger('bitbake-layers')
+
+
+def plugin_init(plugins):
+    return ActionPlugin()
+
+
+class ActionPlugin(LayerPlugin):
+    def do_add_layer(self, args):
+        """Add a layer to bblayers.conf."""
+        layerdir = os.path.abspath(args.layerdir)
+        if not os.path.exists(layerdir):
+            sys.stderr.write("Specified layer directory doesn't exist\n")
+            return 1
+
+        layer_conf = os.path.join(layerdir, 'conf', 'layer.conf')
+        if not os.path.exists(layer_conf):
+            sys.stderr.write("Specified layer directory doesn't contain a conf/layer.conf file\n")
+            return 1
+
+        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        if not os.path.exists(bblayers_conf):
+            sys.stderr.write("Unable to find bblayers.conf\n")
+            return 1
+
+        notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
+        if notadded:
+            for item in notadded:
+                sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
+
+    def do_remove_layer(self, args):
+        """Remove a layer from bblayers.conf."""
+        bblayers_conf = os.path.join('conf', 'bblayers.conf')
+        if not os.path.exists(bblayers_conf):
+            sys.stderr.write("Unable to find bblayers.conf\n")
+            return 1
+
+        if args.layerdir.startswith('*'):
+            layerdir = args.layerdir
+        elif not '/' in args.layerdir:
+            layerdir = '*/%s' % args.layerdir
+        else:
+            layerdir = os.path.abspath(args.layerdir)
+        (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdir)
+        if notremoved:
+            for item in notremoved:
+                sys.stderr.write("No layers matching %s found in BBLAYERS\n" % item)
+            return 1
+
+    def do_flatten(self, args):
+        """flatten layer configuration into a separate output directory.
+
+Takes the specified layers (or all layers in the current layer
+configuration if none are specified) and builds a "flattened" directory
+containing the contents of all layers, with any overlayed recipes removed
+and bbappends appended to the corresponding recipes. Note that some manual
+cleanup may still be necessary afterwards, in particular:
+
+* where non-recipe files (such as patches) are overwritten (the flatten
+  command will show a warning for these)
+* where anything beyond the normal layer setup has been added to
+  layer.conf (only the lowest priority number layer's layer.conf is used)
+* overridden/appended items from bbappends will need to be tidied up
+* when the flattened layers do not have the same directory structure (the
+  flatten command should show a warning when this will cause a problem)
+
+Warning: if you flatten several layers where another layer is intended to
+be used "inbetween" them (in layer priority order) such that recipes /
+bbappends in the layers interact, and then attempt to use the new output
+layer together with that other layer, you may no longer get the same
+build results (as the layer priority order has effectively changed).
+"""
+        if len(args.layer) == 1:
+            logger.error('If you specify layers to flatten you must specify at least two')
+            return 1
+
+        outputdir = args.outputdir
+        if os.path.exists(outputdir) and os.listdir(outputdir):
+            logger.error('Directory %s exists and is non-empty, please clear it out first' % outputdir)
+            return 1
+
+        layers = self.bblayers
+        if len(args.layer) > 2:
+            layernames = args.layer
+            found_layernames = []
+            found_layerdirs = []
+            for layerdir in layers:
+                layername = self.get_layer_name(layerdir)
+                if layername in layernames:
+                    found_layerdirs.append(layerdir)
+                    found_layernames.append(layername)
+
+            for layername in layernames:
+                if not layername in found_layernames:
+                    logger.error('Unable to find layer %s in current configuration, please run "%s show-layers" to list configured layers' % (layername, os.path.basename(sys.argv[0])))
+                    return
+            layers = found_layerdirs
+        else:
+            layernames = []
+
+        # Ensure a specified path matches our list of layers
+        def layer_path_match(path):
+            for layerdir in layers:
+                if path.startswith(os.path.join(layerdir, '')):
+                    return layerdir
+            return None
+
+        applied_appends = []
+        for layer in layers:
+            overlayed = []
+            for f in self.tinfoil.cooker.collection.overlayed.iterkeys():
+                for of in self.tinfoil.cooker.collection.overlayed[f]:
+                    if of.startswith(layer):
+                        overlayed.append(of)
+
+            logger.plain('Copying files from %s...' % layer )
+            for root, dirs, files in os.walk(layer):
+                if '.git' in dirs:
+                    dirs.remove('.git')
+                if '.hg' in dirs:
+                    dirs.remove('.hg')
+
+                for f1 in files:
+                    f1full = os.sep.join([root, f1])
+                    if f1full in overlayed:
+                        logger.plain('  Skipping overlayed file %s' % f1full )
+                    else:
+                        ext = os.path.splitext(f1)[1]
+                        if ext != '.bbappend':
+                            fdest = f1full[len(layer):]
+                            fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
+                            bb.utils.mkdirhier(os.path.dirname(fdest))
+                            if os.path.exists(fdest):
+                                if f1 == 'layer.conf' and root.endswith('/conf'):
+                                    logger.plain('  Skipping layer config file %s' % f1full )
+                                    continue
+                                else:
+                                    logger.warn('Overwriting file %s', fdest)
+                            bb.utils.copyfile(f1full, fdest)
+                            if ext == '.bb':
+                                for append in self.tinfoil.cooker.collection.get_file_appends(f1full):
+                                    if layer_path_match(append):
+                                        logger.plain('  Applying append %s to %s' % (append, fdest))
+                                        self.apply_append(append, fdest)
+                                        applied_appends.append(append)
+
+        # Take care of when some layers are excluded and yet we have included bbappends for those recipes
+        for b in self.tinfoil.cooker.collection.bbappends:
+            (recipename, appendname) = b
+            if appendname not in applied_appends:
+                first_append = None
+                layer = layer_path_match(appendname)
+                if layer:
+                    if first_append:
+                        self.apply_append(appendname, first_append)
+                    else:
+                        fdest = appendname[len(layer):]
+                        fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
+                        bb.utils.mkdirhier(os.path.dirname(fdest))
+                        bb.utils.copyfile(appendname, fdest)
+                        first_append = fdest
+
+        # Get the regex for the first layer in our list (which is where the conf/layer.conf file will
+        # have come from)
+        first_regex = None
+        layerdir = layers[0]
+        for layername, pattern, regex, _ in self.tinfoil.cooker.recipecache.bbfile_config_priorities:
+            if regex.match(os.path.join(layerdir, 'test')):
+                first_regex = regex
+                break
+
+        if first_regex:
+            # Find the BBFILES entries that match (which will have come from this conf/layer.conf file)
+            bbfiles = str(self.tinfoil.config_data.getVar('BBFILES', True)).split()
+            bbfiles_layer = []
+            for item in bbfiles:
+                if first_regex.match(item):
+                    newpath = os.path.join(outputdir, item[len(layerdir)+1:])
+                    bbfiles_layer.append(newpath)
+
+            if bbfiles_layer:
+                # Check that all important layer files match BBFILES
+                for root, dirs, files in os.walk(outputdir):
+                    for f1 in files:
+                        ext = os.path.splitext(f1)[1]
+                        if ext in ['.bb', '.bbappend']:
+                            f1full = os.sep.join([root, f1])
+                            entry_found = False
+                            for item in bbfiles_layer:
+                                if fnmatch.fnmatch(f1full, item):
+                                    entry_found = True
+                                    break
+                            if not entry_found:
+                                logger.warning("File %s does not match the flattened layer's BBFILES setting, you may need to edit conf/layer.conf or move the file elsewhere" % f1full)
+
+    def get_file_layer(self, filename):
+        layerdir = self.get_file_layerdir(filename)
+        if layerdir:
+            return self.get_layer_name(layerdir)
+        else:
+            return '?'
+
+    def get_file_layerdir(self, filename):
+        layer = bb.utils.get_file_layer(filename, self.tinfoil.config_data)
+        return self.bbfile_collections.get(layer, None)
+
+    def apply_append(self, appendname, recipename):
+        with open(appendname, 'r') as appendfile:
+            with open(recipename, 'a') as recipefile:
+                recipefile.write('\n')
+                recipefile.write('##### bbappended from %s #####\n' % self.get_file_layer(appendname))
+                recipefile.writelines(appendfile.readlines())
+
+    def register_commands(self, sp):
+        parser_add_layer = self.add_command(sp, 'add-layer', self.do_add_layer, parserecipes=False)
+        parser_add_layer.add_argument('layerdir', help='Layer directory to add')
+
+        parser_remove_layer = self.add_command(sp, 'remove-layer', self.do_remove_layer, parserecipes=False)
+        parser_remove_layer.add_argument('layerdir', help='Layer directory to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
+        parser_remove_layer.set_defaults(func=self.do_remove_layer)
+
+        parser_flatten = self.add_command(sp, 'flatten', self.do_flatten)
+        parser_flatten.add_argument('layer', nargs='*', help='Optional layer(s) to flatten (otherwise all are flattened)')
+        parser_flatten.add_argument('outputdir', help='Output directory')
diff --git a/bitbake/lib/bblayers/common.py b/bitbake/lib/bblayers/common.py
new file mode 100644
index 0000000..360b9d7
--- /dev/null
+++ b/bitbake/lib/bblayers/common.py
@@ -0,0 +1,33 @@
+import argparse
+import logging
+import os
+
+logger = logging.getLogger('bitbake-layers')
+
+
+class LayerPlugin():
+    def __init__(self):
+        self.tinfoil = None
+        self.bblayers = []
+
+    def tinfoil_init(self, tinfoil):
+        self.tinfoil = tinfoil
+        self.bblayers = (self.tinfoil.config_data.getVar('BBLAYERS', True) or "").split()
+        layerconfs = self.tinfoil.config_data.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', self.tinfoil.config_data)
+        self.bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.iteritems()}
+
+    @staticmethod
+    def add_command(subparsers, cmdname, function, parserecipes=True, *args, **kwargs):
+        """Convert docstring for function to help."""
+        docsplit = function.__doc__.splitlines()
+        help = docsplit[0]
+        if len(docsplit) > 1:
+            desc = '\n'.join(docsplit[1:])
+        else:
+            desc = help
+        subparser = subparsers.add_parser(cmdname, *args, help=help, description=desc, formatter_class=argparse.RawTextHelpFormatter, **kwargs)
+        subparser.set_defaults(func=function, parserecipes=parserecipes)
+        return subparser
+
+    def get_layer_name(self, layerdir):
+        return os.path.basename(layerdir.rstrip(os.sep))
diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
new file mode 100644
index 0000000..3c39d8a
--- /dev/null
+++ b/bitbake/lib/bblayers/layerindex.py
@@ -0,0 +1,270 @@
+import argparse
+import httplib
+import json
+import logging
+import os
+import subprocess
+import urlparse
+
+from bblayers.action import ActionPlugin
+
+logger = logging.getLogger('bitbake-layers')
+
+
+def plugin_init(plugins):
+    return LayerIndexPlugin()
+
+
+class LayerIndexPlugin(ActionPlugin):
+    """Subcommands for interacting with the layer index.
+
+    This class inherits ActionPlugin to get do_add_layer.
+    """
+
+    def get_json_data(self, apiurl):
+        proxy_settings = os.environ.get("http_proxy", None)
+        conn = None
+        _parsedurl = urlparse.urlparse(apiurl)
+        path = _parsedurl.path
+        query = _parsedurl.query
+
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
+    def do_layerindex_fetch(self, args):
+        """Fetches a layer from a layer index along with its dependent layers, and adds them to conf/bblayers.conf.
+"""
+        apiurl = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_URL', True)
+        if not apiurl:
+            logger.error("Cannot get BBLAYERS_LAYERINDEX_URL")
+            return 1
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
+        for collection in self.tinfoil.config_data.getVar('BBFILE_COLLECTIONS', True).split():
+            lname = self.tinfoil.config_data.getVar('BBLAYERS_LAYERINDEX_NAME_%s' % collection, True)
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
+
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
+            fetchdir = self.tinfoil.config_data.getVar('BBLAYERS_FETCH_DIR', True)
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
+    def do_layerindex_show_depends(self, args):
+        """Find layer dependencies from layer index.
+"""
+        args.show_only = True
+        args.ignore = []
+        self.do_layerindex_fetch(args)
+
+    def register_commands(self, sp):
+        parser_layerindex_fetch = self.add_command(sp, 'layerindex-fetch', self.do_layerindex_fetch)
+        parser_layerindex_fetch.add_argument('-n', '--show-only', help='show dependencies and do nothing else', action='store_true')
+        parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
+        parser_layerindex_fetch.add_argument('-i', '--ignore', help='assume the specified layers do not need to be fetched/added (separate multiple layers with commas, no spaces)', metavar='LAYER')
+        parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
+
+        parser_layerindex_show_depends = self.add_command(sp, 'layerindex-show-depends', self.do_layerindex_show_depends)
+        parser_layerindex_show_depends.add_argument('-b', '--branch', help='branch name to fetch (default %(default)s)', default='master')
+        parser_layerindex_show_depends.add_argument('layername', nargs='+', help='layer to query')
diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
new file mode 100644
index 0000000..22053da
--- /dev/null
+++ b/bitbake/lib/bblayers/query.py
@@ -0,0 +1,499 @@
+import collections
+import fnmatch
+import logging
+import os
+import re
+
+import bb.cache
+import bb.providers
+import bb.utils
+
+from bblayers.common import LayerPlugin
+
+logger = logging.getLogger('bitbake-layers')
+
+
+def plugin_init(plugins):
+    return QueryPlugin()
+
+
+class QueryPlugin(LayerPlugin):
+    def do_show_layers(self, args):
+        """show current configured layers."""
+        logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
+        logger.plain('=' * 74)
+        for layer, _, regex, pri in self.tinfoil.cooker.recipecache.bbfile_config_priorities:
+            layerdir = self.bbfile_collections.get(layer, None)
+            layername = self.get_layer_name(layerdir)
+            logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), pri))
+
+    def version_str(self, pe, pv, pr = None):
+        verstr = "%s" % pv
+        if pr:
+            verstr = "%s-%s" % (verstr, pr)
+        if pe:
+            verstr = "%s:%s" % (pe, verstr)
+        return verstr
+
+    def do_show_overlayed(self, args):
+        """list overlayed recipes (where the same recipe exists in another layer)
+
+Lists the names of overlayed recipes and the available versions in each
+layer, with the preferred version first. Note that skipped recipes that
+are overlayed will also be listed, with a " (skipped)" suffix.
+"""
+
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, True, None)
+
+        # Check for overlayed .bbclass files
+        classes = collections.defaultdict(list)
+        for layerdir in self.bblayers:
+            classdir = os.path.join(layerdir, 'classes')
+            if os.path.exists(classdir):
+                for classfile in os.listdir(classdir):
+                    if os.path.splitext(classfile)[1] == '.bbclass':
+                        classes[classfile].append(classdir)
+
+        # Locating classes and other files is a bit more complicated than recipes -
+        # layer priority is not a factor; instead BitBake uses the first matching
+        # file in BBPATH, which is manipulated directly by each layer's
+        # conf/layer.conf in turn, thus the order of layers in bblayers.conf is a
+        # factor - however, each layer.conf is free to either prepend or append to
+        # BBPATH (or indeed do crazy stuff with it). Thus the order in BBPATH might
+        # not be exactly the order present in bblayers.conf either.
+        bbpath = str(self.tinfoil.config_data.getVar('BBPATH', True))
+        overlayed_class_found = False
+        for (classfile, classdirs) in classes.items():
+            if len(classdirs) > 1:
+                if not overlayed_class_found:
+                    logger.plain('=== Overlayed classes ===')
+                    overlayed_class_found = True
+
+                mainfile = bb.utils.which(bbpath, os.path.join('classes', classfile))
+                if args.filenames:
+                    logger.plain('%s' % mainfile)
+                else:
+                    # We effectively have to guess the layer here
+                    logger.plain('%s:' % classfile)
+                    mainlayername = '?'
+                    for layerdir in self.bblayers:
+                        classdir = os.path.join(layerdir, 'classes')
+                        if mainfile.startswith(classdir):
+                            mainlayername = self.get_layer_name(layerdir)
+                    logger.plain('  %s' % mainlayername)
+                for classdir in classdirs:
+                    fullpath = os.path.join(classdir, classfile)
+                    if fullpath != mainfile:
+                        if args.filenames:
+                            print('  %s' % fullpath)
+                        else:
+                            print('  %s' % self.get_layer_name(os.path.dirname(classdir)))
+
+        if overlayed_class_found:
+            items_listed = True;
+
+        if not items_listed:
+            logger.plain('No overlayed files found.')
+
+    def do_show_recipes(self, args):
+        """list available recipes, showing the layer they are provided by
+
+Lists the names of recipes and the available versions in each
+layer, with the preferred version first. Optionally you may specify
+pnspec to match a specified recipe name (supports wildcards). Note that
+skipped recipes will also be listed, with a " (skipped)" suffix.
+"""
+
+        inheritlist = args.inherits.split(',') if args.inherits else []
+        if inheritlist or args.pnspec or args.multiple:
+            title = 'Matching recipes:'
+        else:
+            title = 'Available recipes:'
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.multiple, inheritlist)
+
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only, inherits):
+        if inherits:
+            bbpath = str(self.tinfoil.config_data.getVar('BBPATH', True))
+            for classname in inherits:
+                classfile = 'classes/%s.bbclass' % classname
+                if not bb.utils.which(bbpath, classfile, history=False):
+                    logger.error('No class named %s found in BBPATH', classfile)
+                    return 1
+
+        pkg_pn = self.tinfoil.cooker.recipecache.pkg_pn
+        (latest_versions, preferred_versions) = bb.providers.findProviders(self.tinfoil.config_data, self.tinfoil.cooker.recipecache, pkg_pn)
+        allproviders = bb.providers.allProviders(self.tinfoil.cooker.recipecache)
+
+        # Ensure we list skipped recipes
+        # We are largely guessing about PN, PV and the preferred version here,
+        # but we have no choice since skipped recipes are not fully parsed
+        skiplist = self.tinfoil.cooker.skiplist.keys()
+        skiplist.sort( key=lambda fileitem: self.tinfoil.cooker.collection.calc_bbfile_priority(fileitem) )
+        skiplist.reverse()
+        for fn in skiplist:
+            recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')
+            p = recipe_parts[0]
+            if len(recipe_parts) > 1:
+                ver = (None, recipe_parts[1], None)
+            else:
+                ver = (None, 'unknown', None)
+            allproviders[p].append((ver, fn))
+            if not p in pkg_pn:
+                pkg_pn[p] = 'dummy'
+                preferred_versions[p] = (ver, fn)
+
+        def print_item(f, pn, ver, layer, ispref):
+            if f in skiplist:
+                skipped = ' (skipped)'
+            else:
+                skipped = ''
+            if show_filenames:
+                if ispref:
+                    logger.plain("%s%s", f, skipped)
+                else:
+                    logger.plain("  %s%s", f, skipped)
+            else:
+                if ispref:
+                    logger.plain("%s:", pn)
+                logger.plain("  %s %s%s", layer.ljust(20), ver, skipped)
+
+        global_inherit = (self.tinfoil.config_data.getVar('INHERIT', True) or "").split()
+        cls_re = re.compile('classes/')
+
+        preffiles = []
+        items_listed = False
+        for p in sorted(pkg_pn):
+            if pnspec:
+                if not fnmatch.fnmatch(p, pnspec):
+                    continue
+
+            if len(allproviders[p]) > 1 or not show_multi_provider_only:
+                pref = preferred_versions[p]
+                realfn = bb.cache.Cache.virtualfn2realfn(pref[1])
+                preffile = realfn[0]
+
+                # We only display once per recipe, we should prefer non extended versions of the
+                # recipe if present (so e.g. in OpenEmbedded, openssl rather than nativesdk-openssl
+                # which would otherwise sort first).
+                if realfn[1] and realfn[0] in self.tinfoil.cooker.recipecache.pkg_fn:
+                    continue
+
+                if inherits:
+                    matchcount = 0
+                    recipe_inherits = self.tinfoil.cooker_data.inherits.get(preffile, [])
+                    for cls in recipe_inherits:
+                        if cls_re.match(cls):
+                            continue
+                        classname = os.path.splitext(os.path.basename(cls))[0]
+                        if classname in global_inherit:
+                            continue
+                        elif classname in inherits:
+                            matchcount += 1
+                    if matchcount != len(inherits):
+                        # No match - skip this recipe
+                        continue
+
+                if preffile not in preffiles:
+                    preflayer = self.get_file_layer(preffile)
+                    multilayer = False
+                    same_ver = True
+                    provs = []
+                    for prov in allproviders[p]:
+                        provfile = bb.cache.Cache.virtualfn2realfn(prov[1])[0]
+                        provlayer = self.get_file_layer(provfile)
+                        provs.append((provfile, provlayer, prov[0]))
+                        if provlayer != preflayer:
+                            multilayer = True
+                        if prov[0] != pref[0]:
+                            same_ver = False
+
+                    if (multilayer or not show_overlayed_only) and (same_ver or not show_same_ver_only):
+                        if not items_listed:
+                            logger.plain('=== %s ===' % title)
+                            items_listed = True
+                        print_item(preffile, p, self.version_str(pref[0][0], pref[0][1]), preflayer, True)
+                        for (provfile, provlayer, provver) in provs:
+                            if provfile != preffile:
+                                print_item(provfile, p, self.version_str(provver[0], provver[1]), provlayer, False)
+                        # Ensure we don't show two entries for BBCLASSEXTENDed recipes
+                        preffiles.append(preffile)
+
+        return items_listed
+
+    def get_file_layer(self, filename):
+        layerdir = self.get_file_layerdir(filename)
+        if layerdir:
+            return self.get_layer_name(layerdir)
+        else:
+            return '?'
+
+    def get_file_layerdir(self, filename):
+        layer = bb.utils.get_file_layer(filename, self.tinfoil.config_data)
+        return self.bbfile_collections.get(layer, None)
+
+    def remove_layer_prefix(self, f):
+        """Remove the layer_dir prefix, e.g., f = /path/to/layer_dir/foo/blah, the
+           return value will be: layer_dir/foo/blah"""
+        f_layerdir = self.get_file_layerdir(f)
+        if not f_layerdir:
+            return f
+        prefix = os.path.join(os.path.dirname(f_layerdir), '')
+        return f[len(prefix):] if f.startswith(prefix) else f
+
+    def do_show_appends(self, args):
+        """list bbappend files and recipe files they apply to
+
+Lists recipes with the bbappends that apply to them as subitems.
+"""
+
+        logger.plain('=== Appended recipes ===')
+
+        pnlist = list(self.tinfoil.cooker_data.pkg_pn.keys())
+        pnlist.sort()
+        appends = False
+        for pn in pnlist:
+            if self.show_appends_for_pn(pn):
+                appends = True
+
+        if self.show_appends_for_skipped():
+            appends = True
+
+        if not appends:
+            logger.plain('No append files found')
+
+    def show_appends_for_pn(self, pn):
+        filenames = self.tinfoil.cooker_data.pkg_pn[pn]
+
+        best = bb.providers.findBestProvider(pn,
+                                             self.tinfoil.config_data,
+                                             self.tinfoil.cooker_data,
+                                             self.tinfoil.cooker_data.pkg_pn)
+        best_filename = os.path.basename(best[3])
+
+        return self.show_appends_output(filenames, best_filename)
+
+    def show_appends_for_skipped(self):
+        filenames = [os.path.basename(f)
+                    for f in self.tinfoil.cooker.skiplist.iterkeys()]
+        return self.show_appends_output(filenames, None, " (skipped)")
+
+    def show_appends_output(self, filenames, best_filename, name_suffix = ''):
+        appended, missing = self.get_appends_for_files(filenames)
+        if appended:
+            for basename, appends in appended:
+                logger.plain('%s%s:', basename, name_suffix)
+                for append in appends:
+                    logger.plain('  %s', append)
+
+            if best_filename:
+                if best_filename in missing:
+                    logger.warn('%s: missing append for preferred version',
+                                best_filename)
+            return True
+        else:
+            return False
+
+    def get_appends_for_files(self, filenames):
+        appended, notappended = [], []
+        for filename in filenames:
+            _, cls = bb.cache.Cache.virtualfn2realfn(filename)
+            if cls:
+                continue
+
+            basename = os.path.basename(filename)
+            appends = self.tinfoil.cooker.collection.get_file_appends(basename)
+            if appends:
+                appended.append((basename, list(appends)))
+            else:
+                notappended.append(basename)
+        return appended, notappended
+
+    def do_show_cross_depends(self, args):
+        """Show dependencies between recipes that cross layer boundaries.
+
+Figure out the dependencies between recipes that cross layer boundaries.
+
+NOTE: .bbappend files can impact the dependencies.
+"""
+        ignore_layers = (args.ignore or '').split(',')
+
+        pkg_fn = self.tinfoil.cooker_data.pkg_fn
+        bbpath = str(self.tinfoil.config_data.getVar('BBPATH', True))
+        self.require_re = re.compile(r"require\s+(.+)")
+        self.include_re = re.compile(r"include\s+(.+)")
+        self.inherit_re = re.compile(r"inherit\s+(.+)")
+
+        global_inherit = (self.tinfoil.config_data.getVar('INHERIT', True) or "").split()
+
+        # The bb's DEPENDS and RDEPENDS
+        for f in pkg_fn:
+            f = bb.cache.Cache.virtualfn2realfn(f)[0]
+            # Get the layername that the file is in
+            layername = self.get_file_layer(f)
+
+            # The DEPENDS
+            deps = self.tinfoil.cooker_data.deps[f]
+            for pn in deps:
+                if pn in self.tinfoil.cooker_data.pkg_pn:
+                    best = bb.providers.findBestProvider(pn,
+                            self.tinfoil.config_data,
+                            self.tinfoil.cooker_data,
+                            self.tinfoil.cooker_data.pkg_pn)
+                    self.check_cross_depends("DEPENDS", layername, f, best[3], args.filenames, ignore_layers)
+
+            # The RDPENDS
+            all_rdeps = self.tinfoil.cooker_data.rundeps[f].values()
+            # Remove the duplicated or null one.
+            sorted_rdeps = {}
+            # The all_rdeps is the list in list, so we need two for loops
+            for k1 in all_rdeps:
+                for k2 in k1:
+                    sorted_rdeps[k2] = 1
+            all_rdeps = sorted_rdeps.keys()
+            for rdep in all_rdeps:
+                all_p = bb.providers.getRuntimeProviders(self.tinfoil.cooker_data, rdep)
+                if all_p:
+                    if f in all_p:
+                        # The recipe provides this one itself, ignore
+                        continue
+                    best = bb.providers.filterProvidersRunTime(all_p, rdep,
+                                    self.tinfoil.config_data,
+                                    self.tinfoil.cooker_data)[0][0]
+                    self.check_cross_depends("RDEPENDS", layername, f, best, args.filenames, ignore_layers)
+
+            # The RRECOMMENDS
+            all_rrecs = self.tinfoil.cooker_data.runrecs[f].values()
+            # Remove the duplicated or null one.
+            sorted_rrecs = {}
+            # The all_rrecs is the list in list, so we need two for loops
+            for k1 in all_rrecs:
+                for k2 in k1:
+                    sorted_rrecs[k2] = 1
+            all_rrecs = sorted_rrecs.keys()
+            for rrec in all_rrecs:
+                all_p = bb.providers.getRuntimeProviders(self.tinfoil.cooker_data, rrec)
+                if all_p:
+                    if f in all_p:
+                        # The recipe provides this one itself, ignore
+                        continue
+                    best = bb.providers.filterProvidersRunTime(all_p, rrec,
+                                    self.tinfoil.config_data,
+                                    self.tinfoil.cooker_data)[0][0]
+                    self.check_cross_depends("RRECOMMENDS", layername, f, best, args.filenames, ignore_layers)
+
+            # The inherit class
+            cls_re = re.compile('classes/')
+            if f in self.tinfoil.cooker_data.inherits:
+                inherits = self.tinfoil.cooker_data.inherits[f]
+                for cls in inherits:
+                    # The inherits' format is [classes/cls, /path/to/classes/cls]
+                    # ignore the classes/cls.
+                    if not cls_re.match(cls):
+                        classname = os.path.splitext(os.path.basename(cls))[0]
+                        if classname in global_inherit:
+                            continue
+                        inherit_layername = self.get_file_layer(cls)
+                        if inherit_layername != layername and not inherit_layername in ignore_layers:
+                            if not args.filenames:
+                                f_short = self.remove_layer_prefix(f)
+                                cls = self.remove_layer_prefix(cls)
+                            else:
+                                f_short = f
+                            logger.plain("%s inherits %s" % (f_short, cls))
+
+            # The 'require/include xxx' in the bb file
+            pv_re = re.compile(r"\${PV}")
+            with open(f, 'r') as fnfile:
+                line = fnfile.readline()
+                while line:
+                    m, keyword = self.match_require_include(line)
+                    # Found the 'require/include xxxx'
+                    if m:
+                        needed_file = m.group(1)
+                        # Replace the ${PV} with the real PV
+                        if pv_re.search(needed_file) and f in self.tinfoil.cooker_data.pkg_pepvpr:
+                            pv = self.tinfoil.cooker_data.pkg_pepvpr[f][1]
+                            needed_file = re.sub(r"\${PV}", pv, needed_file)
+                        self.print_cross_files(bbpath, keyword, layername, f, needed_file, args.filenames, ignore_layers)
+                    line = fnfile.readline()
+
+        # The "require/include xxx" in conf/machine/*.conf, .inc and .bbclass
+        conf_re = re.compile(".*/conf/machine/[^\/]*\.conf$")
+        inc_re = re.compile(".*\.inc$")
+        # The "inherit xxx" in .bbclass
+        bbclass_re = re.compile(".*\.bbclass$")
+        for layerdir in self.bblayers:
+            layername = self.get_layer_name(layerdir)
+            for dirpath, dirnames, filenames in os.walk(layerdir):
+                for name in filenames:
+                    f = os.path.join(dirpath, name)
+                    s = conf_re.match(f) or inc_re.match(f) or bbclass_re.match(f)
+                    if s:
+                        with open(f, 'r') as ffile:
+                            line = ffile.readline()
+                            while line:
+                                m, keyword = self.match_require_include(line)
+                                # Only bbclass has the "inherit xxx" here.
+                                bbclass=""
+                                if not m and f.endswith(".bbclass"):
+                                    m, keyword = self.match_inherit(line)
+                                    bbclass=".bbclass"
+                                # Find a 'require/include xxxx'
+                                if m:
+                                    self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, args.filenames, ignore_layers)
+                                line = ffile.readline()
+
+    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename, show_filenames, ignore_layers):
+        """Print the depends that crosses a layer boundary"""
+        needed_file = bb.utils.which(bbpath, needed_filename)
+        if needed_file:
+            # Which layer is this file from
+            needed_layername = self.get_file_layer(needed_file)
+            if needed_layername != layername and not needed_layername in ignore_layers:
+                if not show_filenames:
+                    f = self.remove_layer_prefix(f)
+                    needed_file = self.remove_layer_prefix(needed_file)
+                logger.plain("%s %s %s" %(f, keyword, needed_file))
+
+    def match_inherit(self, line):
+        """Match the inherit xxx line"""
+        return (self.inherit_re.match(line), "inherits")
+
+    def match_require_include(self, line):
+        """Match the require/include xxx line"""
+        m = self.require_re.match(line)
+        keyword = "requires"
+        if not m:
+            m = self.include_re.match(line)
+            keyword = "includes"
+        return (m, keyword)
+
+    def check_cross_depends(self, keyword, layername, f, needed_file, show_filenames, ignore_layers):
+        """Print the DEPENDS/RDEPENDS file that crosses a layer boundary"""
+        best_realfn = bb.cache.Cache.virtualfn2realfn(needed_file)[0]
+        needed_layername = self.get_file_layer(best_realfn)
+        if needed_layername != layername and not needed_layername in ignore_layers:
+            if not show_filenames:
+                f = self.remove_layer_prefix(f)
+                best_realfn = self.remove_layer_prefix(best_realfn)
+
+            logger.plain("%s %s %s" % (f, keyword, best_realfn))
+
+    def register_commands(self, sp):
+        self.add_command(sp, 'show-layers', self.do_show_layers)
+
+        parser_show_overlayed = self.add_command(sp, 'show-overlayed', self.do_show_overlayed)
+        parser_show_overlayed.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
+        parser_show_overlayed.add_argument('-s', '--same-version', help='only list overlayed recipes where the version is the same', action='store_true')
+
+        parser_show_recipes = self.add_command(sp, 'show-recipes', self.do_show_recipes)
+        parser_show_recipes.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
+        parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
+        parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class', metavar='CLASS', default='')
+        parser_show_recipes.add_argument('pnspec', nargs='?', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
+
+        self.add_command(sp, 'show-appends', self.do_show_appends)
+
+        parser_show_cross_depends = self.add_command(sp, 'show-cross-depends', self.do_show_cross_depends)
+        parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
+        parser_show_cross_depends.add_argument('-i', '--ignore', help='ignore dependencies on items in the specified layer(s) (split multiple layer names with commas, no spaces)', metavar='LAYERNAME')
-- 
2.8.0


