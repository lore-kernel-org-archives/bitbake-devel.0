Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Qbzhf-0000gm-Gn
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 20:41:36 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 29 Jun 2011 11:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,444,1304319600"; d="scan'208";a="24396435"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.126])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2011 11:37:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Jun 2011 19:37:39 +0100
Message-Id: <23a601ad81abf80c10297ff8722a2fbc204b900d.1309372176.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
Subject: [RFC PATCH 3/5] bitbake/cooker: implement layer dependencies, make priority optional
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
X-List-Received-Date: Wed, 29 Jun 2011 18:41:36 -0000

Implement (optionally versioned) dependencies between layers, and if layer
priorities are not specified using BBFILE_PRIORITY_layername (now
optional) then work out the layer priority based on dependencies.

Define LAYERDEPENDS_layername in layer.conf to specify the dependencies
of a layer (list of layer names, split with spaces in the usual way);
LAYERVERSION_layername can be defined for each layer allowing specific
version dependencies to be specified via depname:version in the list of
dependencies. An error will be produced if any dependency is missing or
the version numbers do not match exactly (if specified).

Note: default priority if unspecified for a layer with no dependencies is
lowest defined priority + 1 (or 1 if no priorities are defined).

Addresses [YOCTO #790].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |   79 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5fc2baa..59519f8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -702,26 +702,87 @@ class BBCooker:
         """Handle collections"""
         self.status.bbfile_config_priorities = []
         if collections:
+            collection_priorities = {}
+            collection_depends = {}
             collection_list = collections.split()
+            min_prio = 0
             for c in collection_list:
+                # Get collection priority if defined explicitly
+                priority = bb.data.getVar("BBFILE_PRIORITY_%s" % c, self.configuration.data, 1)
+                if priority:
+                    try:
+                        prio = int(priority)
+                    except ValueError:
+                        parselog.error("invalid value for BBFILE_PRIORITY_%s: \"%s\"", c, priority)
+                    if min_prio == 0 or prio < min_prio:
+                        min_prio = prio
+                    collection_priorities[c] = prio
+                else:
+                    collection_priorities[c] = None
+
+                # Check dependencies and store information for priority calculation
+                deps = bb.data.getVar("LAYERDEPENDS_%s" % c, self.configuration.data, 1)
+                if deps:
+                    depnamelist = []
+                    deplist = deps.split()
+                    for dep in deplist:
+                        depsplit = dep.split(':')
+                        if len(depsplit) > 1:
+                            try:
+                                depver = int(depsplit[1])
+                            except ValueError:
+                                parselog.error("invalid version value in LAYERDEPENDS_%s: \"%s\"", c, dep)
+                                continue
+                        else:
+                            depver = None
+                        dep = depsplit[0]
+                        depnamelist.append(dep)
+
+                        if dep in collection_list:
+                            if depver:
+                                layerver = bb.data.getVar("LAYERVERSION_%s" % dep, self.configuration.data, 1)
+                                if layerver:
+                                    try:
+                                        lver = int(layerver)
+                                    except ValueError:
+                                        parselog.error("invalid value for LAYERVERSION_%s: \"%s\"", c, layerver)
+                                        continue
+                                    if lver <> depver:
+                                        parselog.error("Layer dependency %s of layer %s is at version %d, expected %d", dep, c, lver, depver)
+                                else:
+                                    parselog.error("Layer dependency %s of layer %s has no version, expected %d", dep, c, depver)
+                        else:
+                            parselog.error("Layer dependency %s of layer %s not found", dep, c)
+                    collection_depends[c] = depnamelist
+                else:
+                    collection_depends[c] = []
+
+            # Recursively work out collection priorities based on dependencies
+            def calc_layer_priority(collection):
+                if not collection_priorities[collection]:
+                    max_depprio = min_prio
+                    for dep in collection_depends[collection]:
+                        calc_layer_priority(dep)
+                        depprio = collection_priorities[dep]
+                        if depprio > max_depprio:
+                            max_depprio = depprio
+                    max_depprio += 1
+                    parselog.debug(1, "Calculated priority of layer %s as %d", collection, max_depprio)
+                    collection_priorities[collection] = max_depprio
+
+            # Calculate all layer priorities using calc_layer_priority and store in bbfile_config_priorities
+            for c in collection_list:
+                calc_layer_priority(c)
                 regex = bb.data.getVar("BBFILE_PATTERN_%s" % c, self.configuration.data, 1)
                 if regex == None:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
                     continue
-                priority = bb.data.getVar("BBFILE_PRIORITY_%s" % c, self.configuration.data, 1)
-                if priority == None:
-                    parselog.error("BBFILE_PRIORITY_%s not defined" % c)
-                    continue
                 try:
                     cre = re.compile(regex)
                 except re.error:
                     parselog.error("BBFILE_PATTERN_%s \"%s\" is not a valid regular expression", c, regex)
                     continue
-                try:
-                    pri = int(priority)
-                    self.status.bbfile_config_priorities.append((c, regex, cre, pri))
-                except ValueError:
-                    parselog.error("invalid value for BBFILE_PRIORITY_%s: \"%s\"", c, priority)
+                self.status.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
 
     def buildSetVars(self):
         """
-- 
1.7.4.1



