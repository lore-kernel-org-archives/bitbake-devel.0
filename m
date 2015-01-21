Return-Path: <Chong.Lu@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E5A4D72858
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 08:07:30 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0L87VbB006841
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 00:07:31 -0800 (PST)
Received: from pek-hostel-deb02.wrs.com (128.224.153.152) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.174.1; Wed, 21 Jan 2015 00:07:31 -0800
From: Chong Lu <Chong.Lu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Jan 2015 16:02:50 +0800
Message-ID: <f2b66e0cab16d7c47f81dd6fcc669f7f7021b3bd.1421827025.git.Chong.Lu@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1421827025.git.Chong.Lu@windriver.com>
References: <cover.1421827025.git.Chong.Lu@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake-layers: add a ability to query layer dependencies from layer index
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
X-List-Received-Date: Wed, 21 Jan 2015 08:07:31 -0000
Content-Type: text/plain

Add a command to query layer dependencies from layer index. Fetch layer and its
dependency layers and add them into conf/bblayers.conf.

[YOCTO #5348]

Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
---
 bitbake/bin/bitbake-layers | 174 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 9879498..0b00e4c 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -27,6 +27,8 @@ import sys
 import fnmatch
 from collections import defaultdict
 import re
+import httplib, urlparse, json
+import subprocess
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
@@ -157,6 +159,178 @@ usage: remove-layer <layerdir>
                 sys.stderr.write("No layers matching %s found in BBLAYERS\n" % item)
 
 
+    def get_json_data(self, apiurl):
+        proxy_settings = os.environ.get("http_proxy", None)
+        conn = None
+        _parsedurl = urlparse.urlparse(apiurl)
+        path = _parsedurl.path
+        query = _parsedurl.query
+        def parse_url(url):
+            parsedurl = urlparse.urlparse(url)
+            try:
+                (host, port) = parsedurl.netloc.split(":")
+            except ValueError:
+                host = parsedurl.netloc
+                port = None
+
+            if port is None:
+                port = 80
+            else:
+                port = int(port)
+            return (host, port)
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
+    def get_layer_deps(self, layername, layeritems, layerbranches, layerdependencies, selfname=False):
+        def layeritems_info_id(items_name, layeritems):
+            litems_id = ""
+            for li in layeritems:
+                if li['name'] == items_name:
+                    litems_id = li['id']
+                    break
+            if litems_id:
+                return litems_id
+
+        def layerbranches_info(items_id, layerbranches):
+            lbranch = {}
+            for lb in layerbranches:
+                # branch is master.
+                if lb['layer'] == items_id and lb['branch'] == 1:
+                    lbranch['id'] = lb['id']
+                    lbranch['vcs_subdir'] = lb['vcs_subdir']
+                    break
+            if not lbranch['id']:
+                logger.error("The id of layerBranches is not found.")
+                return
+            else:
+                return lbranch
+
+        def layerdependencies_info(lb_id, layerdependencies):
+            ld_deps = []
+            for ld in layerdependencies:
+                if ld['layerbranch'] == lb_id and not ld['dependency'] in ld_deps:
+                    ld_deps.append(ld['dependency'])
+            if not ld_deps:
+                logger.error("The dependency of layerDependencies is not found.")
+                return
+            else:
+                return ld_deps
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
+            selfsubdir = layerbranches_info(selfid, layerbranches)['vcs_subdir']
+            selfurl = layeritems_info_name_subdir(selfid, layeritems)['vcs_url']
+            if selfsubdir and selfurl:
+                return selfurl, selfsubdir
+            else:
+                logger.error("Can NOT get %s git repo and subdir" % layername)
+                return
+        ldict = {}
+        itemsid = layeritems_info_id(layername, layeritems)
+        if not itemsid:
+            return layername, None
+        lbid = layerbranches_info(itemsid, layerbranches)['id']
+        for dependency in layerdependencies_info(lbid, layerdependencies):
+            lname = layeritems_info_name_subdir(dependency, layeritems)['name']
+            lurl = layeritems_info_name_subdir(dependency, layeritems)['vcs_url']
+            lsubdir = layerbranches_info(dependency, layerbranches)['vcs_subdir']
+            ldict[lname] = lurl, lsubdir
+        return None, ldict
+
+
+    def get_fetch_layer(self, fetchdir, url, subdir):
+        layername = self.get_layer_name(url)
+        if os.path.splitext(layername)[1] == '.git':
+            layername = os.path.splitext(layername)[0]
+        repodir = os.path.join(fetchdir, layername)
+        layerdir = os.path.join(repodir, subdir)
+        if not os.path.exists(repodir):
+            logger.plain("Cloning into '%s'..." % repodir)
+            result = subprocess.call('git clone -q %s %s' % (url, repodir), shell = True)
+            if result:
+                logger.error("Failed to download %s" % url)
+            else:
+                return layername, layerdir
+        elif os.path.exists(layerdir):
+            return layername, layerdir
+        else:
+            logger.error("%s is not in %s" % (url, subdir))
+
+
+    def do_show_layer_deps(self, layernames):
+        """Find layer dependencies from layer index. Fetch it and its dependency layers. Add them to conf/bblayers.conf.
+
+usage: show-layer-deps <layername,...>
+"""
+        if not layernames:
+            sys.stderr.write("Please specify layer name.\n")
+            return
+        self.init_bbhandler()
+        apiurl = self.bbhandler.config_data.getVar('BITBAKE_LAYERINDEX_URL', True)
+        if not apiurl:
+            logger.error("Can NOT get BITBAKE_LAYERINDEX_URL.")
+        apilinks = self.get_json_data(apiurl)
+        layeritems = self.get_json_data(apilinks['layerItems'])
+        layerbranches = self.get_json_data(apilinks['layerBranches'])
+        layerdependencies = self.get_json_data(apilinks['layerDependencies'])
+        valuenames = []
+        invaluenames = []
+        repourls = []
+        display = True
+        for layername in layernames.split(','):
+            if not layername == "meta":
+                invaluename, layerdict = self.get_layer_deps(layername, layeritems, layerbranches, layerdependencies)
+                if layerdict:
+                    repourls.append(self.get_layer_deps(layername, layeritems, layerbranches, layerdependencies, selfname=True))
+                    for layer in layerdict:
+                        if display:
+                            logger.plain("%s  %s  %s  %s" % ("Layer".ljust(20), "Dependencies".ljust(20), "Git repository".ljust(55), "Subdirectory"))
+                            logger.plain('=' * 115)
+                            display = False
+                        logger.plain("%s  %s  %s  %s" % (layername.ljust(20), layer.ljust(20), layerdict[layer][0].ljust(55), layerdict[layer][1]))
+                        if not layer == "openembedded-core" and not (layerdict[layer][0], layerdict[layer][1]) in repourls:
+                            repourls.append((layerdict[layer][0], layerdict[layer][1]))
+                if invaluename and not invaluename in invaluenames:
+                    invaluenames.append(invaluename)
+        for invaluename in invaluenames:
+            logger.warn("%s is not found in layer index." % invaluename)
+        fetchdir = self.bbhandler.config_data.getVar('LAYER_FETCH_DIR', True)
+        if not fetchdir:
+            logger.error("Can NOT get LAYER_FETCH_DIR.")
+            return
+        if not os.path.exists(fetchdir):
+            os.makedirs(fetchdir)
+        for repourl, subdir in repourls:
+            name, layerdir = self.get_fetch_layer(fetchdir, repourl, subdir)
+            if subdir:
+                logger.plain("Add \"%s\" to conf/bblayers.conf" % subdir)
+            else:
+                logger.plain("Add \"%s\" to conf/bblayers.conf" % name)
+            self.do_add_layer(layerdir)
+
+
     def version_str(self, pe, pv, pr = None):
         verstr = "%s" % pv
         if pr:
-- 
1.9.1


