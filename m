Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TyiC8-0003oY-Fd
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 13:15:49 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r0P8ZGq0019610
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 00:35:16 -0800 (PST)
Received: from pek-usp-13.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 25 Jan 2013 00:35:15 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2013 16:35:10 +0800
Message-ID: <ec2e1349f8ef7116f2f451b52b7d228199388147.1359080497.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1359080497.git.liezhi.yang@windriver.com>
References: <cover.1359080497.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 2/2] bitbake-layers: print the recipe's depends that crosses a layer boundary
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 25 Jan 2013 12:15:55 -0000
Content-Type: text/plain

Figure out the dependency between recipes that crosses a layer boundary

* Introduction:
  - For the .bb file, we need check the following depends:
    > Check the DEPENDS, RDEPENDS and inherits according to the
      cooker_data.
    > The cooker_data doesn't have the info about "require/include xxx",
      so we need check them manually.

  - For the .bbclass, .inc and .conf file, we can't get their file
    depends from the cooker_data, we need check them manually.

* Usage:
  $ bitbake-layer show-cross-depends

  I don't like the name "show-cross-depends", figure-out-cross-depends
  might be better, but most of the commands are "show-xxx" for bitbake-layers.

* Output: (snipped)
/work/poky/meta/recipes-support/libusb/libusb-compat_0.1.4.bb inherits /work/poky/meta-yocto/classes/poky-sanity.bbclass
/work/poky/meta-intel/meta-cedartrail/recipes-cdv-media/images/core-image-cdv-media.bb requires /work/poky/meta/recipes-sato/images/core-image-sato.bb
/work/poky/meta-yocto/recipes-core/tiny-init/tiny-init.bb RDEPENDS /work/poky/meta/recipes-core/busybox/busybox_1.20.2.bb
/work/poky/meta-intel/common/recipes-bsp/amt/lms_7.1.20.bb DEPENDS /work/poky/meta/recipes-devtools/autoconf/autoconf_2.69.bb
/work/poky/meta/classes/distrodata.bbclass includes /work/poky/meta-yocto/conf/distro/include/package_regex.inc
/work/poky/meta-intel/meta-sys940x/conf/machine/sys940x.conf requires /work/poky/meta/conf/machine/include/tune-atom.inc

[YOCTO #3387]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-layers |  133 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 133 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 956e7a9..774ce2d 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -542,6 +542,139 @@ Recipes are listed with the bbappends that apply to them as subitems.
                 notappended.append(basename)
         return appended, notappended
 
+    def do_show_cross_depends(self, args):
+        """figure out the dependency between recipes that crosses a layer boundary.
+
+usage: show-cross-depends
+
+Figure out the dependency between recipes that crosses a layer boundary.
+
+NOTE:
+The .bbappend file can impact the dependency.
+"""
+        self.bbhandler.prepare()
+        pkg_fn = self.bbhandler.cooker_data.pkg_fn
+        bbpath = str(self.bbhandler.config_data.getVar('BBPATH', True))
+        self.require_re = re.compile(r"require\s+(.+)")
+        self.include_re = re.compile(r"include\s+(.+)")
+        self.inherit_re = re.compile(r"inherit\s+(.+)")
+
+        # The bb's DEPENDS and RDEPENDS
+        for f in pkg_fn:
+            f = bb.cache.Cache.virtualfn2realfn(f)[0]
+            # Get the layername that the file is in
+            layername = self.get_file_layer(f)
+
+            # The DEPENDS
+            deps = self.bbhandler.cooker_data.deps[f]
+            for pn in deps:
+                if pn in self.bbhandler.cooker_data.pkg_pn:
+                    best = bb.providers.findBestProvider(pn,
+                            self.bbhandler.cooker.configuration.data,
+                            self.bbhandler.cooker_data,
+                            self.bbhandler.cooker_data.pkg_pn)
+                    self.check_cross_depends("DEPENDS", layername, f, best[3])
+
+            # The RDPENDS
+            all_rdeps = self.bbhandler.cooker_data.rundeps[f].values()
+            # Remove the duplicated or null one.
+            sorted_rdeps = {}
+            # The all_rdeps is the list in list, so we need two for loops
+            for k1 in all_rdeps:
+                for k2 in k1:
+                    sorted_rdeps[k2] = 1
+            all_rdeps = sorted_rdeps.keys()
+            for rdep in all_rdeps:
+                all_p = bb.providers.getRuntimeProviders(self.bbhandler.cooker_data, rdep)
+                if all_p:
+                    best = bb.providers.filterProvidersRunTime(all_p, rdep,
+                                    self.bbhandler.cooker.configuration.data,
+                                    self.bbhandler.cooker_data)[0][0]
+                    self.check_cross_depends("RDEPENDS", layername, f, best)
+
+            # The inherit class
+            cls_re = re.compile('classes/')
+            if f in self.bbhandler.cooker_data.inherits:
+                inherits = self.bbhandler.cooker_data.inherits[f]
+                for cls in inherits:
+                    # The inherits' format is [classes/cls, /path/to/classes/cls]
+                    # ignore the classes/cls.
+                    if not cls_re.match(cls):
+                        inherit_layername = self.get_file_layer(cls)
+                        if inherit_layername != layername:
+                            logger.plain("%s inherits %s" % (f, cls))
+
+            # The 'require/include xxx' in the bb file
+            pv_re = re.compile(r"\${PV}")
+            fnfile = open(f, 'r')
+            line = fnfile.readline()
+            while line:
+                m, keyword = self.match_require_include(line)
+                # Found the 'require/include xxxx'
+                if m:
+                    needed_file = m.group(1)
+                    # Replace the ${PV} with the real PV
+                    if pv_re.search(needed_file) and f in self.bbhandler.cooker_data.pkg_pepvpr:
+                        pv = self.bbhandler.cooker_data.pkg_pepvpr[f][1]
+                        needed_file = re.sub(r"\${PV}", pv, needed_file)
+                    self.print_cross_files(bbpath, keyword, layername, f, needed_file)
+                line = fnfile.readline()
+            fnfile.close()
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
+                        ffile = open(f, 'r')
+                        line = ffile.readline()
+                        while line:
+                            m, keyword = self.match_require_include(line)
+                            # Only bbclass has the "inherit xxx" here.
+                            bbclass=""
+                            if not m and f.endswith(".bbclass"):
+                                m, keyword = self.match_inherit(line)
+                                bbclass=".bbclass"
+                            # Find a 'require/include xxxx'
+                            if m:
+                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass)
+                            line = ffile.readline()
+                        ffile.close()
+
+    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename):
+        """Print the depends that crosses a layer boundary"""
+        needed_file = bb.utils.which(bbpath, needed_filename)
+        if needed_file:
+            # Which layer is this file from
+            needed_layername = self.get_file_layer(needed_file)
+            if needed_layername != layername:
+                logger.plain("%s %s %s" %(f, keyword, needed_file))
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
+    def check_cross_depends(self, keyword, layername, f, needed_file):
+        """Print the DEPENDS/RDEPENDS file that crosses a layer boundary"""
+        best_realfn = bb.cache.Cache.virtualfn2realfn(needed_file)[0]
+        needed_layername = self.get_file_layer(best_realfn)
+        if needed_layername != layername:
+            logger.plain("%s %s %s" % (f, keyword, best_realfn))
 
 if __name__ == '__main__':
     sys.exit(main(sys.argv[1:]) or 0)
-- 
1.7.1



