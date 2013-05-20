Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 51CA8608C5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2013 22:00:52 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KM4CF3025954; Mon, 20 May 2013 23:04:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id e4ATOqh2oCF5; Mon, 20 May 2013 23:04:12 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KM48UW025948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 20 May 2013 23:04:10 +0100
Message-ID: <1369087231.11013.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 May 2013 23:00:31 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: "Damian, Alexandru" <alexandru.damian@intel.com>
Subject: [PATCH] cooker: Split configuration parsing code into cookerdata
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 20 May 2013 22:00:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


In order to have a memory resident bitbake and to allow task execution, we need
to be able to rebuild the base configuration without a cooker. This moves the
code into its own class so it can be built independently.

The interface is less than ideal here but I didn't want to add parsing methods
a subclassed DataSmart, at least until we've experimented further with this code
and are certain that makes sense. At the very least, the methods are ugly and need
cleaning up.  Spliting the code out seems to be the right thing to do though and
should unblock various activities on BitBake so I believe this code is a step in
the right direction.

Based on a patch from Alexandru Damian <alexandru.damian@intel.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ca54455..daf37eb 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -93,15 +93,6 @@ class BBCooker:
 
         self.configuration = configuration
 
-        # Keep a datastore of the initial environment variables and their
-        # values from when BitBake was launched to enable child processes
-        # to use environment variables which have been cleaned from the
-        # BitBake processes env
-        self.savedenv = bb.data.init()
-        savedenv = configuration.params.environment
-        for k in savedenv:
-            self.savedenv.setVar(k, savedenv[k])
-
         self.caches_array = []
         # Currently, only Image Creator hob ui needs extra cache.
         # So, we save Extra Cache class name and container file
@@ -170,16 +161,12 @@ class BBCooker:
         self.parser = None
 
     def initConfigurationData(self):
-        self.configuration.data = bb.data.init()
-        if self.configuration.tracking:
-            self.configuration.data.enableTracking()
-
+        worker = False
         if not self.configuration.server_register_idlecallback:
-            self.configuration.data.setVar("BB_WORKERCONTEXT", "1")
+            worker = True
 
-        filtered_keys = bb.utils.approved_variables()
-        bb.data.inheritFromOS(self.configuration.data, self.savedenv, filtered_keys)
-        self.configuration.data.setVar("BB_ORIGENV", self.savedenv)
+        self.databuilder = bb.cookerdata.CookerDataBuilder(self.configuration.params, worker)
+        self.configuration.data = self.databuilder.data
 
     def enableDataTracking(self):
         self.configuration.data.enableTracking()
@@ -189,15 +176,9 @@ class BBCooker:
 
     def loadConfigurationData(self):
         self.initConfigurationData()
-
-        try:
-            self.parseConfigurationFiles(self.configuration.prefile,
-                                         self.configuration.postfile)
-        except SyntaxError:
-            sys.exit(1)
-        except Exception:
-            logger.exception("Error parsing configuration files")
-            sys.exit(1)
+        self.databuilder.parseBaseConfiguration()
+        self.configuration.data = self.databuilder.data
+        self.configuration.data_hash = self.databuilder.data_hash
 
     def saveConfigurationVar(self, var, val, default_file):
 
@@ -260,7 +241,7 @@ class BBCooker:
             self.configuration.data.varhistory.del_var_history(var)
 
             #add var to the end of default_file
-            default_file = self._findConfigFile(default_file)
+            default_file = bb.cookerdata.findConfigFile(default_file)
 
             with open(default_file, 'r') as f:
                 contents = f.readlines()
@@ -700,7 +681,7 @@ class BBCooker:
         Find the location on disk of configfile and if it exists and was parsed by BitBake
         emit the ConfigFilePathFound event with the path to the file.
         """
-        path = self._findConfigFile(configfile)
+        path = bb.cookerdata.findConfigFile(configfile)
         if not path:
             return
 
@@ -835,76 +816,6 @@ class BBCooker:
         else:
             shell.start( self )
 
-    def _findConfigFile(self, configfile):
-        path = os.getcwd()
-        while path != "/":
-            confpath = os.path.join(path, "conf", configfile)
-            if os.path.exists(confpath):
-                return confpath
-
-            path, _ = os.path.split(path)
-        return None
-
-    def _findLayerConf(self):
-        return self._findConfigFile("bblayers.conf")
-
-    def parseConfigurationFiles(self, prefiles, postfiles):
-        data = self.configuration.data
-        bb.parse.init_parser(data)
-
-        # Parse files for loading *before* bitbake.conf and any includes
-        for f in prefiles:
-            data = _parse(f, data)
-
-        layerconf = self._findLayerConf()
-        if layerconf:
-            parselog.debug(2, "Found bblayers.conf (%s)", layerconf)
-            data = _parse(layerconf, data)
-
-            layers = (data.getVar('BBLAYERS', True) or "").split()
-
-            data = bb.data.createCopy(data)
-            for layer in layers:
-                parselog.debug(2, "Adding layer %s", layer)
-                data.setVar('LAYERDIR', layer)
-                data = _parse(os.path.join(layer, "conf", "layer.conf"), data)
-                data.expandVarref('LAYERDIR')
-
-            data.delVar('LAYERDIR')
-
-        if not data.getVar("BBPATH", True):
-            raise SystemExit("The BBPATH variable is not set")
-
-        data = _parse(os.path.join("conf", "bitbake.conf"), data)
-
-        # Parse files for loading *after* bitbake.conf and any includes
-        for p in postfiles:
-            data = _parse(p, data)
-
-        # Handle any INHERITs and inherit the base class
-        bbclasses  = ["base"] + (data.getVar('INHERIT', True) or "").split()
-        for bbclass in bbclasses:
-            data = _inherit(bbclass, data)
-
-        # Nomally we only register event handlers at the end of parsing .bb files
-        # We register any handlers we've found so far here...
-        for var in data.getVar('__BBHANDLERS') or []:
-            bb.event.register(var, data.getVar(var))
-
-        if data.getVar("BB_WORKERCONTEXT", False) is None:
-            bb.fetch.fetcher_init(data)
-        bb.codeparser.parser_cache_init(data)
-        bb.event.fire(bb.event.ConfigParsed(), data)
-
-        if data.getVar("BB_INVALIDCONF") is True:
-            data.setVar("BB_INVALIDCONF", False)
-            self.parseConfigurationFiles(self.configuration.prefile,
-                                         self.configuration.postfile)
-        else:
-            bb.parse.init_parser(data)
-            data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
-            self.configuration.data = data
-            self.configuration.data_hash = data.get_hash()
 
     def handleCollections( self, collections ):
         """Handle collections"""
@@ -1501,26 +1412,6 @@ class CookerCollectFiles(object):
 
         return priorities
 
-def catch_parse_error(func):
-    """Exception handling bits for our parsing"""
-    @wraps(func)
-    def wrapped(fn, *args):
-        try:
-            return func(fn, *args)
-        except (IOError, bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
-            parselog.critical("Unable to parse %s: %s" % (fn, exc))
-            sys.exit(1)
-    return wrapped
-
-@catch_parse_error
-def _parse(fn, data, include=True):
-    return bb.parse.handle(fn, data, include)
-
-@catch_parse_error
-def _inherit(bbclass, data):
-    bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
-    return data
-
 class ParsingFailure(Exception):
     def __init__(self, realexception, recipe):
         self.realexception = realexception
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 3c2469e..0b436b3 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -126,3 +126,133 @@ class CookerConfiguration(object):
     def setServerRegIdleCallback(self, srcb):
         self.server_register_idlecallback = srcb
 
+def catch_parse_error(func):
+    """Exception handling bits for our parsing"""
+    @wraps(func)
+    def wrapped(fn, *args):
+        try:
+            return func(fn, *args)
+        except (IOError, bb.parse.ParseError, bb.data_smart.ExpansionError) as exc:
+            parselog.critical("Unable to parse %s: %s" % (fn, exc))
+            sys.exit(1)
+    return wrapped
+
+@catch_parse_error
+def _parse(fn, data, include=True):
+    return bb.parse.handle(fn, data, include)
+
+@catch_parse_error
+def _inherit(bbclass, data):
+    bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
+    return data
+
+def findConfigFile(configfile):
+    path = os.getcwd()
+    while path != "/":
+        confpath = os.path.join(path, "conf", configfile)
+        if os.path.exists(confpath):
+            return confpath
+
+        path, _ = os.path.split(path)
+    return None
+
+class CookerDataBuilder(object):
+
+    def __init__(self, params, worker = False):
+
+        self.prefiles = params.prefile
+        self.postfiles = params.postfile
+        self.tracking = params.tracking
+
+        self.data = bb.data.init()
+        if self.tracking:
+            self.data.enableTracking()
+
+        # Keep a datastore of the initial environment variables and their
+        # values from when BitBake was launched to enable child processes
+        # to use environment variables which have been cleaned from the
+        # BitBake processes env
+        self.savedenv = bb.data.init()
+        savedenv = params.environment
+        for k in savedenv:
+            self.savedenv.setVar(k, savedenv[k])
+
+        filtered_keys = bb.utils.approved_variables()
+        bb.data.inheritFromOS(self.data, self.savedenv, filtered_keys)
+        self.data.setVar("BB_ORIGENV", self.savedenv)
+        
+        if worker:
+            self.data.setVar("BB_WORKERCONTEXT", "1")
+
+    def parseBaseConfiguration(self):
+        try:
+            self.parseConfigurationFiles(self.prefiles, self.postfiles)
+        except SyntaxError:
+            sys.exit(1)
+        except Exception:
+            logger.exception("Error parsing configuration files")
+            sys.exit(1)
+
+    def _findLayerConf(self):
+        return findConfigFile("bblayers.conf")
+
+    def parseConfigurationFiles(self, prefiles, postfiles):
+        data = self.data
+        bb.parse.init_parser(data)
+
+        # Parse files for loading *before* bitbake.conf and any includes
+        for f in prefiles:
+            data = _parse(f, data)
+
+        layerconf = self._findLayerConf()
+        if layerconf:
+            parselog.debug(2, "Found bblayers.conf (%s)", layerconf)
+            data = _parse(layerconf, data)
+
+            layers = (data.getVar('BBLAYERS', True) or "").split()
+
+            data = bb.data.createCopy(data)
+            for layer in layers:
+                parselog.debug(2, "Adding layer %s", layer)
+                data.setVar('LAYERDIR', layer)
+                data = _parse(os.path.join(layer, "conf", "layer.conf"), data)
+                data.expandVarref('LAYERDIR')
+
+            data.delVar('LAYERDIR')
+
+        if not data.getVar("BBPATH", True):
+            raise SystemExit("The BBPATH variable is not set")
+
+        data = _parse(os.path.join("conf", "bitbake.conf"), data)
+
+        # Parse files for loading *after* bitbake.conf and any includes
+        for p in postfiles:
+            data = _parse(p, data)
+
+        # Handle any INHERITs and inherit the base class
+        bbclasses  = ["base"] + (data.getVar('INHERIT', True) or "").split()
+        for bbclass in bbclasses:
+            data = _inherit(bbclass, data)
+
+        # Nomally we only register event handlers at the end of parsing .bb files
+        # We register any handlers we've found so far here...
+        for var in data.getVar('__BBHANDLERS') or []:
+            bb.event.register(var, data.getVar(var))
+
+        if data.getVar("BB_WORKERCONTEXT", False) is None:
+            bb.fetch.fetcher_init(data)
+        bb.codeparser.parser_cache_init(data)
+        bb.event.fire(bb.event.ConfigParsed(), data)
+
+        if data.getVar("BB_INVALIDCONF") is True:
+            data.setVar("BB_INVALIDCONF", False)
+            self.parseConfigurationFiles(self.prefiles, self.postfiles)
+            return
+
+        bb.parse.init_parser(data)
+        data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
+        self.data = data
+        self.data_hash = data.get_hash()
+
+
+




