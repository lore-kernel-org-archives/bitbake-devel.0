Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RruB6-0000QG-UO
	for bitbake-devel@lists.openembedded.org;
	Mon, 30 Jan 2012 17:34:01 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 30 Jan 2012 08:26:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="104198244"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.192])
	by orsmga002.jf.intel.com with ESMTP; 30 Jan 2012 08:26:02 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 30 Jan 2012 16:25:54 +0000
Message-Id: <59da9f391294e134cffc913c4f21ca8706bbe1eb.1327940413.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 6/6] bitbake-layers: list overlayed classes in show-overlayed
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
X-List-Received-Date: Mon, 30 Jan 2012 16:34:01 -0000

Classes (.bbclass files) can be overlayed in a layer although they are
currently located by BitBake in a different way (via BBPATH instead of
using layer priority) and thus it is useful to be able to see when this
is in effect and which layer's class is actually being used.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   47 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 95150de..c85e26e 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
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
 
-- 
1.7.5.4



