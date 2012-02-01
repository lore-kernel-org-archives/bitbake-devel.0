Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsbqC-000757-Cz
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:11:20 +0100
Received: by opal (Postfix, from userid 111)
	id 3600F10336; Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120201150346.3600F10336@opal>
Date: Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: use directory name as layer name
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
X-List-Received-Date: Wed, 01 Feb 2012 15:11:20 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 35d2c1c618826e961dbf4b9889b829f469346d74
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=35d2c1c618826e961dbf4b9889b829f469346d74

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Mon Jan 30 16:25:51 2012 +0000

bitbake-layers: use directory name as layer name

It turns out that using the collection name as specified within
layer.conf (i.e. what gets added to BBFILE_COLLECTIONS) as a name to
refer to the layer is not particularly useful, since layer creators
aren't necessarily setting these to a meaningful value - e.g. OE-Core
uses "normal", meta-oe uses "openembedded-layer", etc. In any case,
BitBake uses the directory name in its list of configured layers in the
system information presented upon starting a build, so let's just do the
same here and avoid confusion.

Also rename the get_append_layer function to get_file_layer since it is
in no way specific to bbappends.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |   39 ++++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 041aa19..9d453ca 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -60,6 +60,7 @@ class Commands(cmd.Cmd):
         self.config_data = self.cooker.configuration.data
         bb.providers.logger.setLevel(logging.ERROR)
         self.cooker_data = None
+        self.bblayers = (self.config_data.getVar('BBLAYERS', True) or "").split()
 
     def register_idle_function(self, function, data):
         pass
@@ -113,13 +114,11 @@ class Commands(cmd.Cmd):
         logger.plain('')
         logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
         logger.plain('=' * 74)
-        layerdirs = str(self.config_data.getVar('BBLAYERS', True)).split()
-        for layerdir in layerdirs:
-            layername = '?'
+        for layerdir in self.bblayers:
+            layername = self.get_layer_name(layerdir)
             layerpri = 0
             for layer, _, regex, pri in self.cooker.status.bbfile_config_priorities:
                 if regex.match(os.path.join(layerdir, 'test')):
-                    layername = layer
                     layerpri = pri
                     break
 
@@ -184,18 +183,16 @@ build results (as the layer priority order has effectively changed).
             return
 
         self.check_prepare_cooker()
-        layers = (self.config_data.getVar('BBLAYERS', True) or "").split()
+        layers = self.bblayers
         if len(arglist) > 2:
             layernames = arglist[:-1]
             found_layernames = []
             found_layerdirs = []
             for layerdir in layers:
-                for layername, _, regex, _ in self.cooker.status.bbfile_config_priorities:
-                    if layername in layernames:
-                        if regex.match(os.path.join(layerdir, 'test')):
-                            found_layerdirs.append(layerdir)
-                            found_layernames.append(layername)
-                            break
+                layername = self.get_layer_name(layerdir)
+                if layername in layernames:
+                    found_layerdirs.append(layerdir)
+                    found_layernames.append(layername)
 
             for layername in layernames:
                 if not layername in found_layernames:
@@ -271,10 +268,9 @@ build results (as the layer priority order has effectively changed).
         first_regex = None
         layerdir = layers[0]
         for layername, pattern, regex, _ in self.cooker.status.bbfile_config_priorities:
-            if (not layernames) or layername in layernames:
-                if regex.match(os.path.join(layerdir, 'test')):
-                    first_regex = regex
-                    break
+            if regex.match(os.path.join(layerdir, 'test')):
+                first_regex = regex
+                break
 
         if first_regex:
             # Find the BBFILES entries that match (which will have come from this conf/layer.conf file)
@@ -300,17 +296,22 @@ build results (as the layer priority order has effectively changed).
                             if not entry_found:
                                 logger.warning("File %s does not match the flattened layer's BBFILES setting, you may need to edit conf/layer.conf or move the file elsewhere" % f1full)
 
-    def get_append_layer(self, appendname):
+    def get_file_layer(self, filename):
         for layer, _, regex, _ in self.cooker.status.bbfile_config_priorities:
-            if regex.match(appendname):
-                return layer
+            if regex.match(filename):
+                for layerdir in self.bblayers:
+                    if regex.match(os.path.join(layerdir, 'test')):
+                        return self.get_layer_name(layerdir)
         return "?"
 
+    def get_layer_name(self, layerdir):
+        return os.path.basename(layerdir.rstrip(os.sep))
+
     def apply_append(self, appendname, recipename):
         appendfile = open(appendname, 'r')
         recipefile = open(recipename, 'a')
         recipefile.write('\n')
-        recipefile.write('##### bbappended from %s #####\n' % self.get_append_layer(appendname))
+        recipefile.write('##### bbappended from %s #####\n' % self.get_file_layer(appendname))
         recipefile.writelines(appendfile.readlines())
         recipefile.close()
         appendfile.close()



