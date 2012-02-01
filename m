Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsbqD-00075W-F5
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:11:21 +0100
Received: by opal (Postfix, from userid 111)
	id 7DD091033C; Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120201150346.7DD091033C@opal>
Date: Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: list overlayed classes in show-overlayed
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
X-List-Received-Date: Wed, 01 Feb 2012 15:11:21 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: f6493e4bad005a82580380d800ebf4c438292f5b
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=f6493e4bad005a82580380d800ebf4c438292f5b

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Mon Jan 30 16:25:54 2012 +0000

bitbake-layers: list overlayed classes in show-overlayed

Classes (.bbclass files) can be overlayed in a layer although they are
currently located by BitBake in a different way (via BBPATH instead of
using layer priority) and thus it is useful to be able to see when this
is in effect and which layer's class is actually being used.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 95150de..c85e26e 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -165,6 +165,53 @@ Options:
 
         items_listed = self.list_recipes('Overlayed recipes', None, True, show_same_ver_only, show_filenames, True)
 
+        # Check for overlayed .bbclass files
+        classes = defaultdict(list)
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
+        bbpath = str(self.config_data.getVar('BBPATH', True))
+        overlayed_class_found = False
+        for (classfile, classdirs) in classes.items():
+            if len(classdirs) > 1:
+                if not overlayed_class_found:
+                    logger.plain('=== Overlayed classes ===')
+                    overlayed_class_found = True
+
+                mainfile = bb.utils.which(bbpath, os.path.join('classes', classfile))
+                if show_filenames:
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
+                        if show_filenames:
+                            print('  %s' % fullpath)
+                        else:
+                            print('  %s' % self.get_layer_name(os.path.dirname(classdir)))
+
+        if overlayed_class_found:
+            items_listed = True;
+
         if not items_listed:
             logger.note('No overlayed files found')
 



