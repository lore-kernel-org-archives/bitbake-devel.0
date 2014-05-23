Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (unknown [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 5E7606B3AB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 May 2014 15:22:30 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 May 2014 08:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,894,1392192000"; d="scan'208";a="545581327"
Received: from bidesilv-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.159])
	by orsmga002.jf.intel.com with ESMTP; 23 May 2014 08:22:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 May 2014 16:22:14 +0100
Message-Id: <697e66171549af07f6ed5adfd0e979e2fa4dd73f.1400858501.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1400858501.git.paul.eggleton@linux.intel.com>
References: <cover.1400858501.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1400858501.git.paul.eggleton@linux.intel.com>
References: <cover.1400858501.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] bitbake-layers: show-cross-depends: add option to ignore a layer
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
X-List-Received-Date: Fri, 23 May 2014 15:22:30 -0000

By default, show-cross-depends shows dependencies on OE-Core (i.e.
"meta") which is not particularly useful. Add an option to allow you to
hide those. For example, to hide all dependencies on OE-Core:

  bitbake-layers show-cross-depends -i meta

Multiple layers can be specified by using commas as separators (no
spaces).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 2a7f829..826a3e7 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -566,26 +566,29 @@ Recipes are listed with the bbappends that apply to them as subitems.
     def do_show_cross_depends(self, args):
         """figure out the dependency between recipes that crosses a layer boundary.
 
-usage: show-cross-depends [-f]
+usage: show-cross-depends [-f] [-i layer1[,layer2[,layer3...]]]
 
 Figure out the dependency between recipes that crosses a layer boundary.
 
 Options:
   -f   show full file path
+  -i   ignore dependencies on items in the specified layer(s)
 
 NOTE:
 The .bbappend file can impact the dependency.
 """
-        self.init_bbhandler()
+        import optparse
 
-        show_filenames = False
-        for arg in args.split():
-            if arg == '-f':
-                show_filenames = True
-            else:
-                sys.stderr.write("show-cross-depends: invalid option %s\n" % arg)
-                self.do_help('')
-                return
+        parser = optparse.OptionParser(usage="show-cross-depends [-f] [-i layer1[,layer2[,layer3...]]]")
+        parser.add_option("-f", "",
+                action="store_true", dest="show_filenames")
+        parser.add_option("-i", "",
+                action="store", dest="ignore_layers", default="")
+
+        options, args = parser.parse_args(sys.argv)
+        ignore_layers = options.ignore_layers.split(',')
+
+        self.init_bbhandler()
 
         pkg_fn = self.bbhandler.cooker_data.pkg_fn
         bbpath = str(self.bbhandler.config_data.getVar('BBPATH', True))
@@ -607,7 +610,7 @@ The .bbappend file can impact the dependency.
                             self.bbhandler.config_data,
                             self.bbhandler.cooker_data,
                             self.bbhandler.cooker_data.pkg_pn)
-                    self.check_cross_depends("DEPENDS", layername, f, best[3], show_filenames)
+                    self.check_cross_depends("DEPENDS", layername, f, best[3], options.show_filenames, ignore_layers)
 
             # The RDPENDS
             all_rdeps = self.bbhandler.cooker_data.rundeps[f].values()
@@ -624,7 +627,7 @@ The .bbappend file can impact the dependency.
                     best = bb.providers.filterProvidersRunTime(all_p, rdep,
                                     self.bbhandler.config_data,
                                     self.bbhandler.cooker_data)[0][0]
-                    self.check_cross_depends("RDEPENDS", layername, f, best, show_filenames)
+                    self.check_cross_depends("RDEPENDS", layername, f, best, options.show_filenames, ignore_layers)
 
             # The inherit class
             cls_re = re.compile('classes/')
@@ -635,8 +638,8 @@ The .bbappend file can impact the dependency.
                     # ignore the classes/cls.
                     if not cls_re.match(cls):
                         inherit_layername = self.get_file_layer(cls)
-                        if inherit_layername != layername:
-                            if not show_filenames:
+                        if inherit_layername != layername and not inherit_layername in ignore_layers:
+                            if not options.show_filenames:
                                 f_short = self.remove_layer_prefix(f)
                                 cls = self.remove_layer_prefix(cls)
                             else:
@@ -656,7 +659,7 @@ The .bbappend file can impact the dependency.
                     if pv_re.search(needed_file) and f in self.bbhandler.cooker_data.pkg_pepvpr:
                         pv = self.bbhandler.cooker_data.pkg_pepvpr[f][1]
                         needed_file = re.sub(r"\${PV}", pv, needed_file)
-                    self.print_cross_files(bbpath, keyword, layername, f, needed_file, show_filenames)
+                    self.print_cross_files(bbpath, keyword, layername, f, needed_file, options.show_filenames, ignore_layers)
                 line = fnfile.readline()
             fnfile.close()
 
@@ -683,21 +686,22 @@ The .bbappend file can impact the dependency.
                                 bbclass=".bbclass"
                             # Find a 'require/include xxxx'
                             if m:
-                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, show_filenames)
+                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, options.show_filenames, ignore_layers)
                             line = ffile.readline()
                         ffile.close()
 
-    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename, show_filenames):
+    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename, show_filenames, ignore_layers):
         """Print the depends that crosses a layer boundary"""
         needed_file = bb.utils.which(bbpath, needed_filename)
         if needed_file:
             # Which layer is this file from
             needed_layername = self.get_file_layer(needed_file)
-            if needed_layername != layername:
+            if needed_layername != layername and not needed_layername in ignore_layers:
                 if not show_filenames:
                     f = self.remove_layer_prefix(f)
                     needed_file = self.remove_layer_prefix(needed_file)
                 logger.plain("%s %s %s" %(f, keyword, needed_file))
+
     def match_inherit(self, line):
         """Match the inherit xxx line"""
         return (self.inherit_re.match(line), "inherits")
@@ -711,11 +715,11 @@ The .bbappend file can impact the dependency.
             keyword = "includes"
         return (m, keyword)
 
-    def check_cross_depends(self, keyword, layername, f, needed_file, show_filenames):
+    def check_cross_depends(self, keyword, layername, f, needed_file, show_filenames, ignore_layers):
         """Print the DEPENDS/RDEPENDS file that crosses a layer boundary"""
         best_realfn = bb.cache.Cache.virtualfn2realfn(needed_file)[0]
         needed_layername = self.get_file_layer(best_realfn)
-        if needed_layername != layername:
+        if needed_layername != layername and not needed_layername in ignore_layers:
             if not show_filenames:
                 f = self.remove_layer_prefix(f)
                 best_realfn = self.remove_layer_prefix(best_realfn)
-- 
1.9.0


