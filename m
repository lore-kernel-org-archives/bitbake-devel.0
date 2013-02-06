Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U31Un-000824-6S
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Feb 2013 10:40:49 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r169OvEb015986
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Feb 2013 01:24:57 -0800 (PST)
Received: from pek-usp-3.wrs.com (128.224.163.124) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Wed, 6 Feb 2013 01:24:56 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Feb 2013 17:28:16 +0800
Message-ID: <66a31eae92aaf7967451df4e96a1059f19920860.1360138241.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <cover.1360138241.git.liezhi.yang@windriver.com>
References: <cover.1360138241.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] bitbake-layers: make show-cross-depends avoid long path
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
X-List-Received-Date: Wed, 06 Feb 2013 09:40:51 -0000
Content-Type: text/plain

The "bitbake-layers show-cross-depends" print the absolute path in the
past, now it will print the relative path (relative to the layer dir) by
default, and add the "-f" option to make it print the absolute path.

For example:

$ bitbake-layers show-cross-depends
[snip]
meta-intel/meta-jasperforest/conf/machine/jasperforest.conf requires meta/conf/machine/include/ia32-base.inc
[snip]

$ bitbake-layers show-cross-depends -f
[snip]
/path/to/poky/meta-intel/meta-jasperforest/conf/machine/jasperforest.conf requires /path/to/poky/meta/conf/machine/include/ia32-base.inc
[snip]

[YOCTO #3824]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-layers | 56 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 774ce2d..b48590f 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -463,6 +463,21 @@ build results (as the layer priority order has effectively changed).
                         return self.get_layer_name(layerdir)
         return "?"
 
+    def get_file_layerdir(self, filename):
+        for layer, _, regex, _ in self.bbhandler.cooker.status.bbfile_config_priorities:
+            if regex.match(filename):
+                for layerdir in self.bblayers:
+                    if regex.match(os.path.join(layerdir, 'test')) and re.match(layerdir, filename):
+                        return layerdir
+        return "?"
+
+    def remove_layer_prefix(self, f):
+        """Remove the layer_dir prefix, e.g., f = /path/to/layer_dir/foo/blah, the
+           return value will be: layer_dir/foo/blah"""
+        f_layerdir = self.get_file_layerdir(f)
+        prefix = os.path.join(os.path.dirname(f_layerdir), '')
+        return f[len(prefix):] if f.startswith(prefix) else f
+
     def get_layer_name(self, layerdir):
         return os.path.basename(layerdir.rstrip(os.sep))
 
@@ -545,14 +560,27 @@ Recipes are listed with the bbappends that apply to them as subitems.
     def do_show_cross_depends(self, args):
         """figure out the dependency between recipes that crosses a layer boundary.
 
-usage: show-cross-depends
+usage: show-cross-depends [-f]
 
 Figure out the dependency between recipes that crosses a layer boundary.
 
+Options:
+  -f   show full file path
+
 NOTE:
 The .bbappend file can impact the dependency.
 """
         self.bbhandler.prepare()
+
+        show_filenames = False
+        for arg in args.split():
+            if arg == '-f':
+                show_filenames = True
+            else:
+                sys.stderr.write("show-cross-depends: invalid option %s\n" % arg)
+                self.do_help('')
+                return
+
         pkg_fn = self.bbhandler.cooker_data.pkg_fn
         bbpath = str(self.bbhandler.config_data.getVar('BBPATH', True))
         self.require_re = re.compile(r"require\s+(.+)")
@@ -573,7 +601,7 @@ The .bbappend file can impact the dependency.
                             self.bbhandler.cooker.configuration.data,
                             self.bbhandler.cooker_data,
                             self.bbhandler.cooker_data.pkg_pn)
-                    self.check_cross_depends("DEPENDS", layername, f, best[3])
+                    self.check_cross_depends("DEPENDS", layername, f, best[3], show_filenames)
 
             # The RDPENDS
             all_rdeps = self.bbhandler.cooker_data.rundeps[f].values()
@@ -590,7 +618,7 @@ The .bbappend file can impact the dependency.
                     best = bb.providers.filterProvidersRunTime(all_p, rdep,
                                     self.bbhandler.cooker.configuration.data,
                                     self.bbhandler.cooker_data)[0][0]
-                    self.check_cross_depends("RDEPENDS", layername, f, best)
+                    self.check_cross_depends("RDEPENDS", layername, f, best, show_filenames)
 
             # The inherit class
             cls_re = re.compile('classes/')
@@ -602,7 +630,12 @@ The .bbappend file can impact the dependency.
                     if not cls_re.match(cls):
                         inherit_layername = self.get_file_layer(cls)
                         if inherit_layername != layername:
-                            logger.plain("%s inherits %s" % (f, cls))
+                            if not show_filenames:
+                                f_short = self.remove_layer_prefix(f)
+                                cls = self.remove_layer_prefix(cls)
+                            else:
+                                f_short = f
+                            logger.plain("%s inherits %s" % (f_short, cls))
 
             # The 'require/include xxx' in the bb file
             pv_re = re.compile(r"\${PV}")
@@ -617,7 +650,7 @@ The .bbappend file can impact the dependency.
                     if pv_re.search(needed_file) and f in self.bbhandler.cooker_data.pkg_pepvpr:
                         pv = self.bbhandler.cooker_data.pkg_pepvpr[f][1]
                         needed_file = re.sub(r"\${PV}", pv, needed_file)
-                    self.print_cross_files(bbpath, keyword, layername, f, needed_file)
+                    self.print_cross_files(bbpath, keyword, layername, f, needed_file, show_filenames)
                 line = fnfile.readline()
             fnfile.close()
 
@@ -644,17 +677,20 @@ The .bbappend file can impact the dependency.
                                 bbclass=".bbclass"
                             # Find a 'require/include xxxx'
                             if m:
-                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass)
+                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, show_filenames)
                             line = ffile.readline()
                         ffile.close()
 
-    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename):
+    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename, show_filenames):
         """Print the depends that crosses a layer boundary"""
         needed_file = bb.utils.which(bbpath, needed_filename)
         if needed_file:
             # Which layer is this file from
             needed_layername = self.get_file_layer(needed_file)
             if needed_layername != layername:
+                if not show_filenames:
+                    f = self.remove_layer_prefix(f)
+                    needed_file = self.remove_layer_prefix(needed_file)
                 logger.plain("%s %s %s" %(f, keyword, needed_file))
     def match_inherit(self, line):
         """Match the inherit xxx line"""
@@ -669,11 +705,15 @@ The .bbappend file can impact the dependency.
             keyword = "includes"
         return (m, keyword)
 
-    def check_cross_depends(self, keyword, layername, f, needed_file):
+    def check_cross_depends(self, keyword, layername, f, needed_file, show_filenames):
         """Print the DEPENDS/RDEPENDS file that crosses a layer boundary"""
         best_realfn = bb.cache.Cache.virtualfn2realfn(needed_file)[0]
         needed_layername = self.get_file_layer(best_realfn)
         if needed_layername != layername:
+            if not show_filenames:
+                f = self.remove_layer_prefix(f)
+                best_realfn = self.remove_layer_prefix(best_realfn)
+
             logger.plain("%s %s %s" % (f, keyword, best_realfn))
 
 if __name__ == '__main__':
-- 
1.7.11.2



