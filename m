Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rkfnx-0005Tc-0X
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:48:13 +0100
Received: by opal (Postfix, from userid 111)
	id 7B5541032F; Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120110174903.7B5541032F@opal>
Date: Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: flatten: allow specifying layers to flatten
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
X-List-Received-Date: Tue, 10 Jan 2012 17:48:13 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 379b12107ec921b4458eda320078374a509164c1
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=379b12107ec921b4458eda320078374a509164c1

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Sun Jan  8 12:06:49 2012 +0000

bitbake-layers: flatten: allow specifying layers to flatten

You can now optionally specify two or more layers to flatten into the
output, rather than flattening all of the layers in the current
configuration (but this is still the default behaviour if no layers are
specified). Note that this means the output layer may still contain
bbappends where the corresponding recipes are not present in the list of
layers to flatten. There is also a caveat when a layer not being
flattened would be "inbetween" the flattened layers (see the command
help for details.)

Implements feature request in [YOCTO #1564].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |   75 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index b2781bb..572487d 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -139,9 +139,10 @@ Highest priority recipes are listed with the recipes they overlay as subitems.
     def do_flatten(self, args):
         """flattens layer configuration into a separate output directory.
 
-usage: flatten <outputdir>
+usage: flatten [layer1 layer2 [layer3]...] <outputdir>
 
-Takes the current layer configuration and builds a "flattened" directory
+Takes the specified layers (or all layers in the current layer
+configuration if none are specified) and builds a "flattened" directory
 containing the contents of all layers, with any overlayed recipes removed
 and bbappends appended to the corresponding recipes. Note that some manual
 cleanup may still be necessary afterwards, in particular:
@@ -149,21 +150,59 @@ cleanup may still be necessary afterwards, in particular:
 * where non-recipe files (such as patches) are overwritten (the flatten
   command will show a warning for these)
 * where anything beyond the normal layer setup has been added to
-  layer.conf (only the lowest priority layer's layer.conf is used)
+  layer.conf (only the lowest priority number layer's layer.conf is used)
 * overridden/appended items from bbappends will need to be tidied up
+
+Warning: if you flatten several layers where another layer is intended to
+be used "inbetween" them (in layer priority order) such that recipes /
+bbappends in the layers interact, and then attempt to use the new output
+layer together with that other layer, you may no longer get the same
+build results (as the layer priority order has effectively changed).
 """
         arglist = args.split()
-        if len(arglist) != 1:
+        if len(arglist) < 1:
             logger.error('Please specify an output directory')
             self.do_help('flatten')
             return
 
-        if os.path.exists(arglist[0]) and os.listdir(arglist[0]):
-            logger.error('Directory %s exists and is non-empty, please clear it out first' % arglist[0])
+        if len(arglist) == 2:
+            logger.error('If you specify layers to flatten you must specify at least two')
+            self.do_help('flatten')
+            return
+
+        outputdir = arglist[-1]
+        if os.path.exists(outputdir) and os.listdir(outputdir):
+            logger.error('Directory %s exists and is non-empty, please clear it out first' % outputdir)
             return
 
         self.check_prepare_cooker()
         layers = (self.config_data.getVar('BBLAYERS', True) or "").split()
+        if len(arglist) > 2:
+            layernames = arglist[:-1]
+            found_layernames = []
+            found_layerdirs = []
+            for layerdir in layers:
+                for layername, _, regex, _ in self.cooker.status.bbfile_config_priorities:
+                    if layername in layernames:
+                        if regex.match(os.path.join(layerdir, 'test')):
+                            found_layerdirs.append(layerdir)
+                            found_layernames.append(layername)
+                            break
+
+            for layername in layernames:
+                if not layername in found_layernames:
+                    logger.error('Unable to find layer %s in current configuration, please run "%s show_layers" to list configured layers' % (layername, os.path.basename(sys.argv[0])))
+                    return
+            layers = found_layerdirs
+
+        # Ensure a specified path matches our list of layers
+        def layer_path_match(path):
+            for layerdir in layers:
+                if path.startswith(os.path.join(layerdir, '')):
+                    return layerdir
+            return None
+
+        appended_recipes = []
         for layer in layers:
             overlayed = []
             for f in self.cooker.overlayed.iterkeys():
@@ -181,7 +220,7 @@ cleanup may still be necessary afterwards, in particular:
                         ext = os.path.splitext(f1)[1]
                         if ext != '.bbappend':
                             fdest = f1full[len(layer):]
-                            fdest = os.path.normpath(os.sep.join([arglist[0],fdest]))
+                            fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
                             bb.utils.mkdirhier(os.path.dirname(fdest))
                             if os.path.exists(fdest):
                                 if f1 == 'layer.conf' and root.endswith('/conf'):
@@ -196,7 +235,27 @@ cleanup may still be necessary afterwards, in particular:
                                     if appends:
                                         logger.plain('  Applying appends to %s' % fdest )
                                         for appendname in appends:
-                                            self.apply_append(appendname, fdest)
+                                            if layer_path_match(appendname):
+                                                self.apply_append(appendname, fdest)
+                                    appended_recipes.append(f1)
+
+        # Take care of when some layers are excluded and yet we have included bbappends for those recipes
+        for recipename in self.cooker_data.appends.iterkeys():
+            if recipename not in appended_recipes:
+                appends = self.cooker_data.appends[recipename]
+                first_append = None
+                for appendname in appends:
+                    layer = layer_path_match(appendname)
+                    if layer:
+                        if first_append:
+                            self.apply_append(appendname, first_append)
+                        else:
+                            fdest = appendname[len(layer):]
+                            fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
+                            bb.utils.mkdirhier(os.path.dirname(fdest))
+                            bb.utils.copyfile(appendname, fdest)
+                            first_append = fdest
+
 
     def get_append_layer(self, appendname):
         for layer, _, regex, _ in self.cooker.status.bbfile_config_priorities:



