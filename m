Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 72C2C767E5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564817"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:27 +0100
Message-Id: <664a7e59248a24197a0b262a0fa37a36f2d2a353.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 12/13] bitbake-layers: use "with open" consistently
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:46 -0000

It's best practice to use "with open..." rather than open & close where
practical.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 62 +++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 8cf7196..5518c63 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -705,13 +705,11 @@ build results (as the layer priority order has effectively changed).
         return os.path.basename(layerdir.rstrip(os.sep))
 
     def apply_append(self, appendname, recipename):
-        appendfile = open(appendname, 'r')
-        recipefile = open(recipename, 'a')
-        recipefile.write('\n')
-        recipefile.write('##### bbappended from %s #####\n' % self.get_file_layer(appendname))
-        recipefile.writelines(appendfile.readlines())
-        recipefile.close()
-        appendfile.close()
+        with open(appendname, 'r') as appendfile:
+            with open(recipename, 'a') as recipefile:
+                recipefile.write('\n')
+                recipefile.write('##### bbappended from %s #####\n' % self.get_file_layer(appendname))
+                recipefile.writelines(appendfile.readlines())
 
     def do_show_appends(self, args):
         """list bbappend files and recipe files they apply to
@@ -879,20 +877,19 @@ NOTE: .bbappend files can impact the dependencies.
 
             # The 'require/include xxx' in the bb file
             pv_re = re.compile(r"\${PV}")
-            fnfile = open(f, 'r')
-            line = fnfile.readline()
-            while line:
-                m, keyword = self.match_require_include(line)
-                # Found the 'require/include xxxx'
-                if m:
-                    needed_file = m.group(1)
-                    # Replace the ${PV} with the real PV
-                    if pv_re.search(needed_file) and f in self.bbhandler.cooker_data.pkg_pepvpr:
-                        pv = self.bbhandler.cooker_data.pkg_pepvpr[f][1]
-                        needed_file = re.sub(r"\${PV}", pv, needed_file)
-                    self.print_cross_files(bbpath, keyword, layername, f, needed_file, args.filenames, ignore_layers)
+            with open(f, 'r') as fnfile:
                 line = fnfile.readline()
-            fnfile.close()
+                while line:
+                    m, keyword = self.match_require_include(line)
+                    # Found the 'require/include xxxx'
+                    if m:
+                        needed_file = m.group(1)
+                        # Replace the ${PV} with the real PV
+                        if pv_re.search(needed_file) and f in self.bbhandler.cooker_data.pkg_pepvpr:
+                            pv = self.bbhandler.cooker_data.pkg_pepvpr[f][1]
+                            needed_file = re.sub(r"\${PV}", pv, needed_file)
+                        self.print_cross_files(bbpath, keyword, layername, f, needed_file, args.filenames, ignore_layers)
+                    line = fnfile.readline()
 
         # The "require/include xxx" in conf/machine/*.conf, .inc and .bbclass
         conf_re = re.compile(".*/conf/machine/[^\/]*\.conf$")
@@ -906,20 +903,19 @@ NOTE: .bbappend files can impact the dependencies.
                     f = os.path.join(dirpath, name)
                     s = conf_re.match(f) or inc_re.match(f) or bbclass_re.match(f)
                     if s:
-                        ffile = open(f, 'r')
-                        line = ffile.readline()
-                        while line:
-                            m, keyword = self.match_require_include(line)
-                            # Only bbclass has the "inherit xxx" here.
-                            bbclass=""
-                            if not m and f.endswith(".bbclass"):
-                                m, keyword = self.match_inherit(line)
-                                bbclass=".bbclass"
-                            # Find a 'require/include xxxx'
-                            if m:
-                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, args.filenames, ignore_layers)
+                        with open(f, 'r') as ffile:
                             line = ffile.readline()
-                        ffile.close()
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
 
     def print_cross_files(self, bbpath, keyword, layername, f, needed_filename, show_filenames, ignore_layers):
         """Print the depends that crosses a layer boundary"""
-- 
2.1.0


