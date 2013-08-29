Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id F3D986BC98
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 13:27:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7TDeCUS014150 for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 14:40:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fH___LvEDKm3 for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 14:40:11 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7TDe6Nw014147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 14:40:08 +0100
Message-ID: <1377782849.1059.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 29 Aug 2013 14:27:29 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cookerdata: Allow bblayers.conf to be found using BBPATH
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
X-List-Received-Date: Thu, 29 Aug 2013 13:27:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



It should be possible to run a build anywhere on the filesystem and have
bitbake find the correct build directory if its set somehow. The BBPATH
variable makes perfect sense for this usage. Therefore use any available
value of BBPATH to search for conf/bblayers.conf before walking the parent
directory structure.

This restores the option of being able to run bitbake from anywhere if
the user has set things up to operate in that environment.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 8a0bc22..0b278b1 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -177,14 +177,21 @@ def _inherit(bbclass, data):
     bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
     return data
 
-def findConfigFile(configfile):
+def findConfigFile(configfile, data):
+    search = []
+    bbpath = data.getVar("BBPATH", True)
+    if bbpath:
+        for i in bbpath.split(":"):
+            search.append(os.path.join(i, "conf", configfile))
     path = os.getcwd()
     while path != "/":
-        confpath = os.path.join(path, "conf", configfile)
-        if os.path.exists(confpath):
-            return confpath
-
+        search.append(os.path.join(path, "conf", configfile))
         path, _ = os.path.split(path)
+
+    for i in search:
+        if os.path.exists(i):
+            return i
+
     return None
 
 class CookerDataBuilder(object):
@@ -225,8 +232,8 @@ class CookerDataBuilder(object):
             logger.exception("Error parsing configuration files")
             sys.exit(1)
 
-    def _findLayerConf(self):
-        return findConfigFile("bblayers.conf")
+    def _findLayerConf(self, data):
+        return findConfigFile("bblayers.conf", data)
 
     def parseConfigurationFiles(self, prefiles, postfiles):
         data = self.data
@@ -236,7 +243,7 @@ class CookerDataBuilder(object):
         for f in prefiles:
             data = parse_config_file(f, data)
 
-        layerconf = self._findLayerConf()
+        layerconf = self._findLayerConf(data)
         if layerconf:
             parselog.debug(2, "Found bblayers.conf (%s)", layerconf)
             # By definition bblayers.conf is in conf/ of TOPDIR.



