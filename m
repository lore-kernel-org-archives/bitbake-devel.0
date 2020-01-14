Return-Path: <frazer.clews@codethink.co.uk>
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
	[78.40.148.184])
	by mail.openembedded.org (Postfix) with ESMTP id 9D5287FAB2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jan 2020 14:46:59 +0000 (UTC)
Received: from [167.98.27.226] (helo=localhost.co.uk)
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1irNNB-0004m0-1E; Tue, 14 Jan 2020 14:40:49 +0000
From: frazer.clews@codethink.co.uk
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jan 2020 14:40:24 +0000
Message-Id: <20200114144024.163030-1-frazer.clews@codethink.co.uk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 14 Jan 2020 22:30:13 +0000
Subject: [PATCH] lib: amend code to use proper singleton comparisons where possible
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
X-List-Received-Date: Tue, 14 Jan 2020 14:47:00 -0000
Content-Transfer-Encoding: 8bit

From: Frazer Clews <frazer.clews@codethink.co.uk>

amend the code to handle singleton comparisons properly so it only checks
if they only refer to the same object or not, and not bother
comparing the values.

Signed-off-by: Frazer Clews <frazer.clews@codethink.co.uk>
---
 lib/bb/command.py                             |  2 +-
 lib/bb/cooker.py                              |  8 ++++----
 lib/bb/data.py                                |  2 +-
 lib/bb/event.py                               |  2 +-
 lib/bb/fetch2/__init__.py                     |  4 ++--
 lib/bb/fetch2/git.py                          |  2 +-
 lib/bb/fetch2/osc.py                          |  2 +-
 lib/bb/fetch2/perforce.py                     |  2 +-
 lib/bb/fetch2/ssh.py                          |  2 +-
 lib/bb/parse/ast.py                           | 20 +++++++++----------
 lib/bb/providers.py                           |  6 +++---
 lib/bb/taskdata.py                            |  2 +-
 lib/bb/ui/buildinfohelper.py                  |  8 ++++----
 lib/bb/ui/knotty.py                           |  2 +-
 lib/bb/ui/ncurses.py                          |  2 +-
 lib/bb/ui/taskexp.py                          |  2 +-
 lib/bb/ui/toasterui.py                        |  2 +-
 lib/bb/ui/uievent.py                          |  2 +-
 lib/bs4/__init__.py                           |  2 +-
 lib/bs4/builder/_html5lib.py                  |  2 +-
 lib/ply/yacc.py                               |  6 +++---
 lib/prserv/db.py                              | 14 ++++++-------
 lib/pyinotify.py                              |  4 ++--
 .../management/commands/checksettings.py      |  2 +-
 lib/toaster/orm/models.py                     |  4 ++--
 .../toastergui/templatetags/projecttags.py    |  4 ++--
 lib/toaster/toastergui/views.py               | 18 ++++++++---------
 .../management/commands/buildimport.py        |  2 +-
 28 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 378f389b..c8e13528 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -65,7 +65,7 @@ class Command:
             # Can run synchronous commands straight away
             command_method = getattr(self.cmds_sync, command)
             if ro_only:
-                if not hasattr(command_method, 'readonly') or False == getattr(command_method, 'readonly'):
+                if not hasattr(command_method, 'readonly') or not getattr(command_method, 'readonly'):
                     return None, "Not able to execute not readonly commands in readonly mode"
             try:
                 self.cooker.process_inotify_updates()
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b74affa7..aee16bbf 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1208,7 +1208,7 @@ class BBCooker:
             for c in collection_list:
                 calc_layer_priority(c)
                 regex = self.data.getVar("BBFILE_PATTERN_%s" % c)
-                if regex == None:
+                if regex is None:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
                     errors = True
                     continue
@@ -1314,7 +1314,7 @@ class BBCooker:
         self.parseConfiguration()
 
         # If we are told to do the None task then query the default task
-        if (task == None):
+        if task is None:
             task = self.configuration.cmd
         if not task.startswith("do_"):
             task = "do_%s" % task
@@ -1458,7 +1458,7 @@ class BBCooker:
         self.buildSetVars()
 
         # If we are told to do the None task then query the default task
-        if (task == None):
+        if task is None:
             task = self.configuration.cmd
 
         if not task.startswith("do_"):
@@ -1691,7 +1691,7 @@ class CookerCollectFiles(object):
     def calc_bbfile_priority( self, filename, matched = None ):
         for _, _, regex, pri in self.bbfile_config_priorities:
             if regex.match(filename):
-                if matched != None:
+                if matched is not None:
                     if not regex in matched:
                         matched.add(regex)
                 return pri
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 0d75d0c1..6dc02172 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -79,7 +79,7 @@ def expand(s, d, varname = None):
     return d.expand(s, varname)
 
 def expandKeys(alterdata, readdata = None):
-    if readdata == None:
+    if readdata is None:
         readdata = alterdata
 
     todolist = {}
diff --git a/lib/bb/event.py b/lib/bb/event.py
index d44621ed..94d35edb 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -347,7 +347,7 @@ def set_UIHmask(handlerNum, level, debug_domains, mask):
 
 def getName(e):
     """Returns the name of a class or class instance"""
-    if getattr(e, "__name__", None) == None:
+    if getattr(e, "__name__", None) is None:
         return e.__class__.__name__
     else:
         return e.__name__
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 731c1608..18a6819d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1081,7 +1081,7 @@ def try_mirrors(fetch, d, origud, mirrors, check = False):
 
     for index, uri in enumerate(uris):
         ret = try_mirror_url(fetch, origud, uds[index], ld, check)
-        if ret != False:
+        if ret:
             return ret
     return None
 
@@ -1351,7 +1351,7 @@ class FetchMethod(object):
         """
 
         # We cannot compute checksums for directories
-        if os.path.isdir(urldata.localpath) == True:
+        if os.path.isdir(urldata.localpath):
             return False
         if urldata.localpath.find("*") != -1:
             return False
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index fa41b078..fe0a384a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -671,7 +671,7 @@ class Git(FetchMethod):
 
             # search for version in the line
             tag = tagregex.search(tag_head)
-            if tag == None:
+            if tag is None:
                 continue
 
             tag = tag.group('pver')
diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 3e567155..3eb411af 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -43,7 +43,7 @@ class Osc(FetchMethod):
         else:
             pv = d.getVar("PV", False)
             rev = bb.fetch2.srcrev_internal_helper(ud, d)
-            if rev and rev != True:
+            if rev and not rev:
                 ud.revision = rev
             else:
                 ud.revision = ""
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 54d001ec..51628ffb 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -105,7 +105,7 @@ class Perforce(FetchMethod):
         if command == 'changes':
             p4cmd = '%s%s changes -m 1 //%s' % (ud.basecmd, p4opt, pathnrev)
         elif command == 'print':
-            if depot_filename != None:
+            if depot_filename is not None:
                 p4cmd = '%s%s print -o "p4/%s" "%s"' % (ud.basecmd, p4opt, filename, depot_filename)
             else:
                 raise FetchError('No depot file name provided to p4 %s' % command, ud.url)
diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index f5be060c..49730166 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -60,7 +60,7 @@ class SSH(FetchMethod):
     '''Class to fetch a module or modules via Secure Shell'''
 
     def supports(self, urldata, d):
-        return __pattern__.match(urldata.url) != None
+        return __pattern__.match(urldata.url) is not None
 
     def supports_checksum(self, urldata):
         return False
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index f0911e6f..6d8a5c5f 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -93,7 +93,7 @@ class DataNode(AstNode):
         self.groupd = groupd
 
     def getFunc(self, key, data):
-        if 'flag' in self.groupd and self.groupd['flag'] != None:
+        if 'flag' in self.groupd and self.groupd['flag'] is not None:
             return data.getVarFlag(key, self.groupd['flag'], expand=False, noweakdefault=True)
         else:
             return data.getVar(key, False, noweakdefault=True, parsing=True)
@@ -106,36 +106,36 @@ class DataNode(AstNode):
             'file': self.filename,
             'line': self.lineno,
         }
-        if "exp" in groupd and groupd["exp"] != None:
+        if "exp" in groupd and groupd["exp"] is not None:
             data.setVarFlag(key, "export", 1, op = 'exported', **loginfo)
 
         op = "set"
-        if "ques" in groupd and groupd["ques"] != None:
+        if "ques" in groupd and groupd["ques"] is not None:
             val = self.getFunc(key, data)
             op = "set?"
-            if val == None:
+            if val is None:
                 val = groupd["value"]
-        elif "colon" in groupd and groupd["colon"] != None:
+        elif "colon" in groupd and groupd["colon"] is not None:
             e = data.createCopy()
             op = "immediate"
             val = e.expand(groupd["value"], key + "[:=]")
-        elif "append" in groupd and groupd["append"] != None:
+        elif "append" in groupd and groupd["append"] is not None:
             op = "append"
             val = "%s %s" % ((self.getFunc(key, data) or ""), groupd["value"])
-        elif "prepend" in groupd and groupd["prepend"] != None:
+        elif "prepend" in groupd and groupd["prepend"] is not None:
             op = "prepend"
             val = "%s %s" % (groupd["value"], (self.getFunc(key, data) or ""))
-        elif "postdot" in groupd and groupd["postdot"] != None:
+        elif "postdot" in groupd and groupd["postdot"] is not None:
             op = "postdot"
             val = "%s%s" % ((self.getFunc(key, data) or ""), groupd["value"])
-        elif "predot" in groupd and groupd["predot"] != None:
+        elif "predot" in groupd and groupd["predot"] is not None:
             op = "predot"
             val = "%s%s" % (groupd["value"], (self.getFunc(key, data) or ""))
         else:
             val = groupd["value"]
 
         flag = None
-        if 'flag' in groupd and groupd['flag'] != None:
+        if 'flag' in groupd and groupd['flag'] is not None:
             flag = groupd['flag']
         elif groupd["lazyques"]:
             flag = "_defaultval"
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index f80963cb..81459c36 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -92,11 +92,11 @@ def preferredVersionMatch(pe, pv, pr, preferred_e, preferred_v, preferred_r):
     Check if the version pe,pv,pr is the preferred one.
     If there is preferred version defined and ends with '%', then pv has to start with that version after removing the '%'
     """
-    if (pr == preferred_r or preferred_r == None):
-        if (pe == preferred_e or preferred_e == None):
+    if pr == preferred_r or preferred_r is None:
+        if pe == preferred_e or preferred_e is None:
             if preferred_v == pv:
                 return True
-            if preferred_v != None and preferred_v.endswith('%') and pv.startswith(preferred_v[:len(preferred_v)-1]):
+            if preferred_v is not None and preferred_v.endswith('%') and pv.startswith(preferred_v[:len(preferred_v)-1]):
                 return True
     return False
 
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 8c25e09e..d13a1249 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -362,7 +362,7 @@ class TaskData:
             bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees(item), reasons=["No eligible PROVIDERs exist for '%s'" % item]), cfgData)
             raise bb.providers.NoProvider(item)
 
-        if len(eligible) > 1 and foundUnique == False:
+        if len(eligible) > 1 and not foundUnique:
             if item not in self.consider_msgs_cache:
                 providers_list = []
                 for fn in eligible:
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 5cbca97f..82c62e33 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -935,7 +935,7 @@ class BuildInfoHelper(object):
 
             # only reset the build name if the one on the server is actually
             # a valid value for the build_name field
-            if build_name != None:
+            if build_name is not None:
                 build_info['build_name'] = build_name
                 changed = True
 
@@ -1194,7 +1194,7 @@ class BuildInfoHelper(object):
         evdata = BuildInfoHelper._get_data_from_event(event)
 
         for t in self.internal_state['targets']:
-            if t.is_image == True:
+            if t.is_image:
                 output_files = list(evdata.keys())
                 for output in output_files:
                     if t.target in output and 'rootfs' in output and not output.endswith(".manifest"):
@@ -1236,7 +1236,7 @@ class BuildInfoHelper(object):
                 task_information['outcome'] = Task.OUTCOME_PREBUILT
         else:
             task_information['task_executed'] = True
-            if 'noexec' in vars(event) and event.noexec == True:
+            if 'noexec' in vars(event) and event.noexec:
                 task_information['task_executed'] = False
                 task_information['outcome'] = Task.OUTCOME_EMPTY
                 task_information['script_type'] = Task.CODING_NA
@@ -1776,7 +1776,7 @@ class BuildInfoHelper(object):
         image_file_extensions_unique = {}
         image_fstypes = self.server.runCommand(
             ['getVariable', 'IMAGE_FSTYPES'])[0]
-        if image_fstypes != None:
+        if image_fstypes is not None:
             image_types_str = image_fstypes.strip()
             image_file_extensions = re.sub(r' {2,}', ' ', image_types_str)
             image_file_extensions_unique = set(image_file_extensions.split(' '))
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index c6abb2a1..9047746e 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -448,7 +448,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         if error:
             logger.error("Command '%s' failed: %s" % (cmdline, error))
             return 1
-        elif ret != True:
+        elif not ret:
             logger.error("Command '%s' failed: returned %s" % (cmdline, ret))
             return 1
 
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index c422732b..8df528e2 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -239,7 +239,7 @@ class NCursesUI:
             if error:
                 print("Error running command '%s': %s" % (cmdline, error))
                 return
-            elif ret != True:
+            elif not ret:
                 print("Couldn't get default commandlind! %s" % ret)
                 return
         except xmlrpc.client.Fault as x:
diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 50a943cd..8448cb39 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -202,7 +202,7 @@ def main(server, eventHandler, params):
         if error:
             print("Error running command '%s': %s" % (cmdline, error))
             return 1
-        elif ret != True:
+        elif not ret:
             print("Error running command '%s': returned %s" % (cmdline, ret))
             return 1
     except client.Fault as x:
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 51892c9a..9260f5d9 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -176,7 +176,7 @@ def main(server, eventHandler, params):
         if error:
             logger.error("Command '%s' failed: %s" % (cmdline, error))
             return 1
-        elif ret != True:
+        elif not ret:
             logger.error("Command '%s' failed: returned %s" % (cmdline, ret))
             return 1
 
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index fedb0506..13d0d4a0 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -46,7 +46,7 @@ class BBUIEventQueue:
                 self.EventHandle = ret
                 error = ""
 
-            if self.EventHandle != None:
+            if self.EventHandle is not None:
                 break
 
             errmsg = "Could not register UI event handler. Error: %s, host %s, "\
diff --git a/lib/bs4/__init__.py b/lib/bs4/__init__.py
index f6fdfd50..e35725b8 100644
--- a/lib/bs4/__init__.py
+++ b/lib/bs4/__init__.py
@@ -427,7 +427,7 @@ class BeautifulSoup(Tag):
         if self.is_xml:
             # Print the XML declaration
             encoding_part = ''
-            if eventual_encoding != None:
+            if eventual_encoding is not None:
                 encoding_part = ' encoding="%s"' % eventual_encoding
             prefix = '<?xml version="1.0"%s?>\n' % encoding_part
         else:
diff --git a/lib/bs4/builder/_html5lib.py b/lib/bs4/builder/_html5lib.py
index 2b7a70aa..a8552828 100644
--- a/lib/bs4/builder/_html5lib.py
+++ b/lib/bs4/builder/_html5lib.py
@@ -322,7 +322,7 @@ class Element(treebuildersbase.Node):
         return self.element.contents
 
     def getNameTuple(self):
-        if self.namespace == None:
+        if self.namespace is None:
             return namespaces["html"], self.name
         else:
             return self.namespace, self.name
diff --git a/lib/ply/yacc.py b/lib/ply/yacc.py
index d50886ed..561784f2 100644
--- a/lib/ply/yacc.py
+++ b/lib/ply/yacc.py
@@ -488,7 +488,7 @@ class LRParser:
                     # --! DEBUG
                     return result
 
-            if t == None:
+            if t is None:
 
                 # --! DEBUG
                 debug.error('Error  : %s',
@@ -766,7 +766,7 @@ class LRParser:
                     n = symstack[-1]
                     return getattr(n,"value",None)
 
-            if t == None:
+            if t is None:
 
                 # We have some kind of parsing error here.  To handle
                 # this, we are going to push the current token onto
@@ -1021,7 +1021,7 @@ class LRParser:
                     n = symstack[-1]
                     return getattr(n,"value",None)
 
-            if t == None:
+            if t is None:
 
                 # We have some kind of parsing error here.  To handle
                 # this, we are going to push the current token onto
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 117d8c05..cb2a2461 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -71,7 +71,7 @@ class PRTable(object):
         data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
         row=data.fetchone()
-        if row != None:
+        if row is not None:
             return row[0]
         else:
             #no value found, try to insert
@@ -87,7 +87,7 @@ class PRTable(object):
             data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                                (version, pkgarch, checksum))
             row=data.fetchone()
-            if row != None:
+            if row is not None:
                 return row[0]
             else:
                 raise prserv.NotFoundError
@@ -99,7 +99,7 @@ class PRTable(object):
                             % (self.table, self.table),
                             (version, pkgarch, checksum, version, pkgarch))
         row=data.fetchone()
-        if row != None:
+        if row is not None:
             return row[0]
         else:
             #no value found, try to insert
@@ -116,7 +116,7 @@ class PRTable(object):
             data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                                (version, pkgarch, checksum))
             row=data.fetchone()
-            if row != None:
+            if row is not None:
                 return row[0]
             else:
                 raise prserv.NotFoundError
@@ -132,7 +132,7 @@ class PRTable(object):
         data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
         row = data.fetchone()
-        if row != None:
+        if row is not None:
             val=row[0]
         else:
             #no value found, try to insert
@@ -147,7 +147,7 @@ class PRTable(object):
             data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
             row = data.fetchone()
-            if row != None:
+            if row is not None:
                 val = row[0]
         return val
 
@@ -170,7 +170,7 @@ class PRTable(object):
         data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
                             (version,pkgarch,checksum,value))
         row=data.fetchone()
-        if row != None:
+        if row is not None:
             return row[0]
         else:
             return None
diff --git a/lib/pyinotify.py b/lib/pyinotify.py
index 1528a22e..6ae40a2d 100644
--- a/lib/pyinotify.py
+++ b/lib/pyinotify.py
@@ -1274,7 +1274,7 @@ class Notifier:
             basename = os.path.basename(sys.argv[0]) or 'pyinotify'
             pid_file = os.path.join(dirname, basename + '.pid')
 
-        if pid_file != False and os.path.lexists(pid_file):
+        if pid_file and os.path.lexists(pid_file):
             err = 'Cannot daemonize: pid file %s already exists.' % pid_file
             raise NotifierError(err)
 
@@ -1308,7 +1308,7 @@ class Notifier:
         fork_daemon()
 
         # Write pid
-        if pid_file != False:
+        if pid_file:
             flags = os.O_WRONLY|os.O_CREAT|os.O_NOFOLLOW|os.O_EXCL
             fd_pid = os.open(pid_file, flags, 0o0600)
             os.write(fd_pid,  bytes(str(os.getpid()) + '\n',
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index fe2c4dc2..21c21657 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -80,7 +80,7 @@ class Command(BaseCommand):
                         template_conf = os.environ.get("TEMPLATECONF", "")
                         custom_xml_only = os.environ.get("CUSTOM_XML_ONLY")
 
-                        if ToasterSetting.objects.filter(name='CUSTOM_XML_ONLY').count() > 0 or (not custom_xml_only == None):
+                        if ToasterSetting.objects.filter(name='CUSTOM_XML_ONLY').count() > 0 or custom_xml_only is not None:
                             # only use the custom settings
                             pass
                         elif "poky" in template_conf:
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index bb6b5dec..caf06972 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1647,14 +1647,14 @@ class CustomImageRecipe(Recipe):
         """
         # Check if we're aldready up-to-date or not
         target = self.get_last_successful_built_target()
-        if target == None:
+        if target is None:
             # So we've never actually built this Custom recipe but what about
             # the recipe it's based on?
             target = \
                 Target.objects.filter(Q(build__outcome=Build.SUCCEEDED) &
                                       Q(build__project=self.project) &
                                       Q(target=self.base_recipe.name)).last()
-            if target == None:
+            if target is None:
                 return
 
         if target.build.completed_on == self.last_updated:
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 1dbab3bd..8a9a01ef 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -212,7 +212,7 @@ def filtered_installedsize(size, installed_size):
     """If package.installed_size not null and not empty return it,
        else return package.size
     """
-    return size if (installed_size == 0) or (installed_size == "") or (installed_size == None) else installed_size
+    return size if (installed_size == 0) or (installed_size == "") or (installed_size is None) else installed_size
 
 @register.filter
 def filtered_packageversion(version, revision):
@@ -228,7 +228,7 @@ def filter_sizeovertotal(package_object, total_size):
         formatted nicely.
     """
     size = package_object.installed_size
-    if size == None or size == '':
+    if size is None or size == '':
         size = package_object.size
 
     return '{:.1%}'.format(float(size)/float(total_size))
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index d7acaff8..6d7290b6 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -51,7 +51,7 @@ class MimeTypeFinder(object):
     def get_mimetype(self, path):
         guess = mimetypes.guess_type(path, self._strict)
         guessed_type = guess[0]
-        if guessed_type == None:
+        if guessed_type is None:
             guessed_type = 'application/octet-stream'
         return guessed_type
 
@@ -126,7 +126,7 @@ def _lv_to_dict(prj, x = None):
     return {"id": x.pk,
             "name": x.layer.name,
             "tooltip": "%s | %s" % (x.layer.vcs_url,x.get_vcs_reference()),
-            "detail": "(%s" % x.layer.vcs_url + (")" if x.release == None else " | "+x.get_vcs_reference()+")"),
+            "detail": "(%s" % x.layer.vcs_url + (")" if x.release is None else " | "+x.get_vcs_reference()+")"),
             "giturl": x.layer.vcs_url,
             "layerdetailurl" : reverse('layerdetails', args=(prj.id,x.pk)),
             "revision" : x.get_vcs_reference(),
@@ -719,7 +719,7 @@ def _get_dir_entries(build_id, target_id, start):
                 resolved_id = o.sym_target_id
                 resolved_path = o.path
                 if target_packages.count():
-                    while resolved_id != "" and resolved_id != None:
+                    while resolved_id != "" and resolved_id is not None:
                         tf = Target_File.objects.get(pk=resolved_id)
                         resolved_path = tf.path
                         resolved_id = tf.sym_target_id
@@ -731,10 +731,10 @@ def _get_dir_entries(build_id, target_id, start):
                         entry['package_id'] = str(p.id)
                         entry['package'] = p.name
                 # don't use resolved path from above, show immediate link-to
-                if o.sym_target_id != "" and o.sym_target_id != None:
+                if o.sym_target_id != "" and o.sym_target_id is not None:
                     entry['link_to'] = Target_File.objects.get(pk=o.sym_target_id).path
             entry['size'] = filtered_filesizeformat(o.size)
-            if entry['link_to'] != None:
+            if entry['link_to'] is not None:
                 entry['permission'] = node_str[o.inodetype] + o.permission
             else:
                 entry['permission'] = node_str[o.inodetype] + o.permission
@@ -756,7 +756,7 @@ def dirinfo(request, build_id, target_id, file_path=None):
     objects = _get_dir_entries(build_id, target_id, '/')
     packages_sum = Package.objects.filter(id__in=Target_Installed_Package.objects.filter(target_id=target_id).values('package_id')).aggregate(Sum('installed_size'))
     dir_list = None
-    if file_path != None:
+    if file_path is not None:
         """
         Link from the included package detail file list page and is
         requesting opening the dir info to a specific file path.
@@ -1030,15 +1030,15 @@ def _get_package_dependency_count(package, target_id, is_installed):
 
 def _get_package_alias(package):
     alias = package.installed_name
-    if alias != None and alias != '' and alias != package.name:
+    if alias is not None and alias != '' and alias != package.name:
         return alias
     else:
         return ''
 
 def _get_fullpackagespec(package):
     r = package.name
-    version_good = package.version != None and  package.version != ''
-    revision_good = package.revision != None and package.revision != ''
+    version_good = package.version is not None and  package.version != ''
+    revision_good = package.revision is not None and package.revision != ''
     if version_good or revision_good:
         r += '_'
         if version_good:
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 408ad44e..aba0e4bd 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -507,7 +507,7 @@ class Command(BaseCommand):
         default_release = Release.objects.get(id=1)
 
         # SANITY: if 'reconfig' but project does not exist (deleted externally), switch to 'import'
-        if ("reconfigure" == options['command']) and (None == project):
+        if ("reconfigure" == options['command']) and project is None:
             options['command'] = 'import'
 
         # 'Configure':
-- 
2.24.1


