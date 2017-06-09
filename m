Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 70F6A782A3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 15:14:16 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga104.jf.intel.com with ESMTP; 09 Jun 2017 08:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,317,1493708400"; d="scan'208";a="272296068"
Received: from therfet-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.41.2])
	by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2017 08:14:17 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Jun 2017 17:13:51 +0200
Message-Id: <0a09a1775b6514a2a1cdc47b79198a1307d00074.1497021176.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1497021176.git.paul.eggleton@linux.intel.com>
References: <cover.1497021176.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] command / cooker: drop Hob support commands and functions
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
X-List-Received-Date: Fri, 09 Jun 2017 15:14:16 -0000

Drop a number of the commands and support functions that were created
solely to support functionality in the now-removed Hob UI. In most cases
we now have this functionality elsewhere e.g. to modify config files and
recipes we have bb.utils.edit_metadata_file() and friends, and in OE we
have oe.recipeutils.patch_recipe_file() and friends which build on top of
the former. Additionally, some of it represented pretty egregious
incursion of OE metadata-specific references into BitBake code.

For now I have left in the find*File functions and commands as they are
relatively generic and possibly still useful, but they might be removed
in future.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py |  60 -----------------
 lib/bb/cooker.py  | 193 ------------------------------------------------------
 2 files changed, 253 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index ab51d8e..34d0763 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -233,60 +233,11 @@ class CommandsSync:
         command.cooker.configuration.postfile = postfiles
     setPrePostConfFiles.needconfig = False
 
-    def getCpuCount(self, command, params):
-        """
-        Get the CPU count on the bitbake server
-        """
-        return bb.utils.cpu_count()
-    getCpuCount.readonly = True
-    getCpuCount.needconfig = False
-
     def matchFile(self, command, params):
         fMatch = params[0]
         return command.cooker.matchFile(fMatch)
     matchFile.needconfig = False
 
-    def generateNewImage(self, command, params):
-        image = params[0]
-        base_image = params[1]
-        package_queue = params[2]
-        timestamp = params[3]
-        description = params[4]
-        return command.cooker.generateNewImage(image, base_image,
-                        package_queue, timestamp, description)
-
-    def ensureDir(self, command, params):
-        directory = params[0]
-        bb.utils.mkdirhier(directory)
-    ensureDir.needconfig = False
-
-    def setVarFile(self, command, params):
-        """
-        Save a variable in a file; used for saving in a configuration file
-        """
-        var = params[0]
-        val = params[1]
-        default_file = params[2]
-        op = params[3]
-        command.cooker.modifyConfigurationVar(var, val, default_file, op)
-    setVarFile.needconfig = False
-
-    def removeVarFile(self, command, params):
-        """
-        Remove a variable declaration from a file
-        """
-        var = params[0]
-        command.cooker.removeConfigurationVar(var)
-    removeVarFile.needconfig = False
-
-    def createConfigFile(self, command, params):
-        """
-        Create an extra configuration file
-        """
-        name = params[0]
-        command.cooker.createConfigFile(name)
-    createConfigFile.needconfig = False
-
     def setEventMask(self, command, params):
         handlerNum = params[0]
         llevel = params[1]
@@ -645,17 +596,6 @@ class CommandsAsync:
         command.finishAsyncCommand()
     generateTargetsTree.needcache = True
 
-    def findCoreBaseFiles(self, command, params):
-        """
-        Find certain files in COREBASE directory. i.e. Layers
-        """
-        subdir = params[0]
-        filename = params[1]
-
-        command.cooker.findCoreBaseFiles(subdir, filename)
-        command.finishAsyncCommand()
-    findCoreBaseFiles.needcache = False
-
     def findConfigFiles(self, command, params):
         """
         Find config files which provide appropriate values
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8846690..fb3faf8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -386,138 +386,6 @@ class BBCooker:
         if hasattr(self, "data"):
             self.data.disableTracking()
 
-    def modifyConfigurationVar(self, var, val, default_file, op):
-        if op == "append":
-            self.appendConfigurationVar(var, val, default_file)
-        elif op == "set":
-            self.saveConfigurationVar(var, val, default_file, "=")
-        elif op == "earlyAssign":
-            self.saveConfigurationVar(var, val, default_file, "?=")
-
-
-    def appendConfigurationVar(self, var, val, default_file):
-        #add append var operation to the end of default_file
-        default_file = bb.cookerdata.findConfigFile(default_file, self.data)
-
-        total = "#added by hob"
-        total += "\n%s += \"%s\"\n" % (var, val)
-
-        with open(default_file, 'a') as f:
-            f.write(total)
-
-        #add to history
-        loginfo = {"op":"append", "file":default_file, "line":total.count("\n")}
-        self.data.appendVar(var, val, **loginfo)
-
-    def saveConfigurationVar(self, var, val, default_file, op):
-
-        replaced = False
-        #do not save if nothing changed
-        if str(val) == self.data.getVar(var, False):
-            return
-
-        conf_files = self.data.varhistory.get_variable_files(var)
-
-        #format the value when it is a list
-        if isinstance(val, list):
-            listval = ""
-            for value in val:
-                listval += "%s   " % value
-            val = listval
-
-        topdir = self.data.getVar("TOPDIR", False)
-
-        #comment or replace operations made on var
-        for conf_file in conf_files:
-            if topdir in conf_file:
-                with open(conf_file, 'r') as f:
-                    contents = f.readlines()
-
-                lines = self.data.varhistory.get_variable_lines(var, conf_file)
-                for line in lines:
-                    total = ""
-                    i = 0
-                    for c in contents:
-                        total += c
-                        i = i + 1
-                        if i==int(line):
-                            end_index = len(total)
-                    index = total.rfind(var, 0, end_index)
-
-                    begin_line = total.count("\n",0,index)
-                    end_line = int(line)
-
-                    #check if the variable was saved before in the same way
-                    #if true it replace the place where the variable was declared
-                    #else it comments it
-                    if contents[begin_line-1]== "#added by hob\n":
-                        contents[begin_line] = "%s %s \"%s\"\n" % (var, op, val)
-                        replaced = True
-                    else:
-                        for ii in range(begin_line, end_line):
-                            contents[ii] = "#" + contents[ii]
-
-                with open(conf_file, 'w') as f:
-                    f.writelines(contents)
-
-        if replaced == False:
-            #remove var from history
-            self.data.varhistory.del_var_history(var)
-
-            #add var to the end of default_file
-            default_file = bb.cookerdata.findConfigFile(default_file, self.data)
-
-            #add the variable on a single line, to be easy to replace the second time
-            total = "\n#added by hob"
-            total += "\n%s %s \"%s\"\n" % (var, op, val)
-
-            with open(default_file, 'a') as f:
-                f.write(total)
-
-            #add to history
-            loginfo = {"op":"set", "file":default_file, "line":total.count("\n")}
-            self.data.setVar(var, val, **loginfo)
-
-    def removeConfigurationVar(self, var):
-        conf_files = self.data.varhistory.get_variable_files(var)
-        topdir = self.data.getVar("TOPDIR", False)
-
-        for conf_file in conf_files:
-            if topdir in conf_file:
-                with open(conf_file, 'r') as f:
-                    contents = f.readlines()
-
-                lines = self.data.varhistory.get_variable_lines(var, conf_file)
-                for line in lines:
-                    total = ""
-                    i = 0
-                    for c in contents:
-                        total += c
-                        i = i + 1
-                        if i==int(line):
-                            end_index = len(total)
-                    index = total.rfind(var, 0, end_index)
-
-                    begin_line = total.count("\n",0,index)
-
-                    #check if the variable was saved before in the same way
-                    if contents[begin_line-1]== "#added by hob\n":
-                        contents[begin_line-1] = contents[begin_line] = "\n"
-                    else:
-                        contents[begin_line] = "\n"
-                    #remove var from history
-                    self.data.varhistory.del_var_history(var, conf_file, line)
-                    #remove variable
-                    self.data.delVar(var)
-
-                with open(conf_file, 'w') as f:
-                    f.writelines(contents)
-
-    def createConfigFile(self, name):
-        path = os.getcwd()
-        confpath = os.path.join(path, "conf", name)
-        open(confpath, 'w').close()
-
     def parseConfiguration(self):
         # Set log file verbosity
         verboselogs = bb.utils.to_boolean(self.data.getVar("BB_VERBOSE_LOGS", False))
@@ -1038,18 +906,6 @@ class BBCooker:
                     providerlog.error("conflicting preferences for %s: both %s and %s specified", providee, provider, self.recipecaches[mc].preferred[providee])
                 self.recipecaches[mc].preferred[providee] = provider
 
-    def findCoreBaseFiles(self, subdir, configfile):
-        corebase = self.data.getVar('COREBASE') or ""
-        paths = []
-        for root, dirs, files in os.walk(corebase + '/' + subdir):
-            for d in dirs:
-                configfilepath = os.path.join(root, d, configfile)
-                if os.path.exists(configfilepath):
-                    paths.append(os.path.join(root, d))
-
-        if paths:
-            bb.event.fire(bb.event.CoreBaseFilesFound(paths), self.data)
-
     def findConfigFilePath(self, configfile):
         """
         Find the location on disk of configfile and if it exists and was parsed by BitBake
@@ -1548,55 +1404,6 @@ class BBCooker:
         return dump
 
 
-    def generateNewImage(self, image, base_image, package_queue, timestamp, description):
-        '''
-        Create a new image with a "require"/"inherit" base_image statement
-        '''
-        if timestamp:
-            image_name = os.path.splitext(image)[0]
-            timestr = time.strftime("-%Y%m%d-%H%M%S")
-            dest = image_name + str(timestr) + ".bb"
-        else:
-            if not image.endswith(".bb"):
-                dest = image + ".bb"
-            else:
-                dest = image
-
-        basename = False
-        if base_image:
-            with open(base_image, 'r') as f:
-                require_line = f.readline()
-                p = re.compile("IMAGE_BASENAME *=")
-                for line in f:
-                    if p.search(line):
-                        basename = True
-
-        with open(dest, "w") as imagefile:
-            if base_image is None:
-                imagefile.write("inherit core-image\n")
-            else:
-                topdir = self.data.getVar("TOPDIR", False)
-                if topdir in base_image:
-                    base_image = require_line.split()[1]
-                imagefile.write("require " + base_image + "\n")
-            image_install = "IMAGE_INSTALL = \""
-            for package in package_queue:
-                image_install += str(package) + " "
-            image_install += "\"\n"
-            imagefile.write(image_install)
-
-            description_var = "DESCRIPTION = \"" + description + "\"\n"
-            imagefile.write(description_var)
-
-            if basename:
-                # If this is overwritten in a inherited image, reset it to default
-                image_basename = "IMAGE_BASENAME = \"${PN}\"\n"
-                imagefile.write(image_basename)
-
-        self.state = state.initial
-        if timestamp:
-            return timestr
-
     def updateCacheSync(self):
         if self.state == state.running:
             return
-- 
2.9.4


