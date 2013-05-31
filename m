Return-Path: <bogdan.a.marinescu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id B1F27608F7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 14:19:28 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 31 May 2013 07:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,779,1363158000"; d="scan'208";a="310562873"
Received: from bogdanm.rb.intel.com ([10.237.105.166])
	by azsmga001.ch.intel.com with ESMTP; 31 May 2013 07:19:24 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 May 2013 17:19:14 +0300
Message-Id: <1370009954-14292-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] bitbake: add event masks
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
X-List-Received-Date: Fri, 31 May 2013 14:19:29 -0000

Add more arguments to an "addhandler" command. Each argument (after the
first one, which is the name of the handler) is the name of an event class
that the handler wants to be notified on. "*" is a shortcut for "listen
to all events". This changes the current behaviour of bitbake, which is
to broadcast all events to all listeners; instead, only the handlers
that registered themselves to an event with "addhandler" will receive
that event. This should improve performance, although only performance
measurements will be confirm or deny this claim.
This is part of the fix for YOCTO #3812, but implements filtering only
for class event handlers; the other part (events filter for UIs) will be
the subject of a different patch.

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/cookerdata.py                       |    3 +-
 bitbake/lib/bb/event.py                            |   23 +++++--
 bitbake/lib/bb/parse/ast.py                        |   18 +++--
 meta/classes/base.bbclass                          |    9 ++-
 meta/classes/bugzilla.bbclass                      |    2 +-
 meta/classes/buildhistory.bbclass                  |    9 ++-
 meta/classes/buildstats.bbclass                    |    2 +-
 meta/classes/cross.bbclass                         |    5 +-
 meta/classes/distrodata.bbclass                    |   48 +++++++-------
 meta/classes/migrate_localcount.bbclass            |   69 ++++++++++----------
 meta/classes/multilib.bbclass                      |    5 +-
 meta/classes/multilib_global.bbclass               |    2 +-
 meta/classes/native.bbclass                        |    5 +-
 meta/classes/nativesdk.bbclass                     |    5 +-
 meta/classes/packageinfo.bbclass                   |   51 +++++++--------
 meta/classes/prexport.bbclass                      |    2 +-
 meta/classes/primport.bbclass                      |    2 +-
 meta/classes/recipe_sanity.bbclass                 |    5 +-
 meta/classes/sanity.bbclass                        |    2 +-
 meta/classes/tinderclient.bbclass                  |    2 +-
 meta/classes/typecheck.bbclass                     |    9 ++-
 meta/conf/distro/include/csl-versions.inc          |    4 +-
 .../distro/include/tcmode-external-sourcery.inc    |   10 +--
 23 files changed, 141 insertions(+), 151 deletions(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 149878f..4add06a 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -251,7 +251,8 @@ class CookerDataBuilder(object):
         # Nomally we only register event handlers at the end of parsing .bb files
         # We register any handlers we've found so far here...
         for var in data.getVar('__BBHANDLERS') or []:
-            bb.event.register(var, data.getVar(var))
+            (name, mask) = var
+            bb.event.register(name, data.getVar(name), mask)
 
         if data.getVar("BB_WORKERCONTEXT", False) is None:
             bb.fetch.fetcher_init(data)
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 2826e35..d269c04 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -63,6 +63,8 @@ def clean_class_handlers():
 _handlers = clean_class_handlers()
 _ui_handlers = {}
 _ui_handler_seq = 0
+_event_handler_map = {}
+_catchall_handlers = {}
 
 def execute_handler(name, handler, event, d):
     event.data = d
@@ -86,11 +88,14 @@ def fire_class_handlers(event, d):
     if isinstance(event, logging.LogRecord):
         return
 
+    eid = str(event.__class__)[8:-2]
+    evt_hmap = _event_handler_map.get(eid, {})
     for name, handler in _handlers.iteritems():
-        try:
-            execute_handler(name, handler, event, d)
-        except Exception:
-            continue
+        if name in _catchall_handlers or name in evt_hmap:
+            try:
+                execute_handler(name, handler, event, d)
+            except Exception:
+                continue
 
 ui_queue = []
 @atexit.register
@@ -167,7 +172,7 @@ def fire_from_worker(event, d):
     fire_ui_handlers(event, d)
 
 noop = lambda _: None
-def register(name, handler):
+def register(name, handler, mask=[]):
     """Register an Event handler"""
 
     # already registered
@@ -192,6 +197,14 @@ def register(name, handler):
         else:
             _handlers[name] = handler
 
+        if not mask:
+            _catchall_handlers[name] = True
+        else:
+            for m in mask:
+                if _event_handler_map.get(m, None) is None:
+                    _event_handler_map[m] = {}
+                _event_handler_map[m][name] = True
+
         return Registered
 
 def remove(name, handler):
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 713bef1..3e31ba6 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -266,9 +266,17 @@ class BBHandlerNode(AstNode):
 
     def eval(self, data):
         bbhands = data.getVar('__BBHANDLERS') or []
-        for h in self.hs:
-            bbhands.append(h)
-            data.setVarFlag(h, "handler", 1)
+        name = self.hs[0]
+        if len(self.hs) == 1:
+            bb.warn("event handler '" + name + "' does not have an event mask")
+            bbhands.append((name, None))
+        else:
+            evlist = self.hs[1:]
+            if '*' in evlist:
+                bbhands.append((name, None))
+            else:
+                bbhands.append((name, evlist))
+        data.setVarFlag(name, "handler", 1)
         data.setVar('__BBHANDLERS', bbhands)
 
 class InheritNode(AstNode):
@@ -320,8 +328,8 @@ def finalize(fn, d, variant = None):
     all_handlers = {}
     for var in d.getVar('__BBHANDLERS') or []:
         # try to add the handler
-        handler = d.getVar(var)
-        bb.event.register(var, handler)
+        (name, mask) = var
+        bb.event.register(name, d.getVar(name), mask)
 
     bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
diff --git a/meta/classes/base.bbclass b/meta/classes/base.bbclass
index b1642a2..0e7d56f 100644
--- a/meta/classes/base.bbclass
+++ b/meta/classes/base.bbclass
@@ -32,12 +32,11 @@ def oe_import(d):
         inject(toimport.split(".", 1)[0], imported)
 
 python oe_import_eh () {
-    if isinstance(e, bb.event.ConfigParsed):
-        oe_import(e.data)
-        e.data.setVar("NATIVELSBSTRING", lsb_distro_identifier(e.data))
+    oe_import(e.data)
+    e.data.setVar("NATIVELSBSTRING", lsb_distro_identifier(e.data))
 }
 
-addhandler oe_import_eh
+addhandler oe_import_eh bb.event.ConfigParsed
 
 def lsb_distro_identifier(d):
     adjust = d.getVar('LSB_DISTRO_ADJUST', True)
@@ -298,7 +297,7 @@ def buildcfg_neededvars(d):
     if pesteruser:
         bb.fatal('The following variable(s) were not set: %s\nPlease set them directly, or choose a MACHINE or DISTRO that sets them.' % ', '.join(pesteruser))
 
-addhandler base_eventhandler
+addhandler base_eventhandler bb.event.ConfigParsed bb.event.BuildStarted
 python base_eventhandler() {
     if isinstance(e, bb.event.ConfigParsed):
         e.data.setVar('BB_VERSION', bb.__version__)
diff --git a/meta/classes/bugzilla.bbclass b/meta/classes/bugzilla.bbclass
index 006763d..c1dd966 100644
--- a/meta/classes/bugzilla.bbclass
+++ b/meta/classes/bugzilla.bbclass
@@ -70,7 +70,7 @@ def bugzilla_add_comment(debug_file, server, args, bug_number, text):
         print >> debug_file, repr(e)
         return False
 
-addhandler bugzilla_eventhandler
+addhandler bugzilla_eventhandler bb.event.MsgNote bb.build.TaskFailed 
 python bugzilla_eventhandler() {
     import glob
     import xmlrpclib, httplib
diff --git a/meta/classes/buildhistory.bbclass b/meta/classes/buildhistory.bbclass
index d39408b..ad3f292 100644
--- a/meta/classes/buildhistory.bbclass
+++ b/meta/classes/buildhistory.bbclass
@@ -525,13 +525,12 @@ END
 }
 
 python buildhistory_eventhandler() {
-    if isinstance(e, bb.event.BuildCompleted):
-        if e.data.getVar('BUILDHISTORY_FEATURES', True).strip():
-            if e.data.getVar("BUILDHISTORY_COMMIT", True) == "1":
-                bb.build.exec_func("buildhistory_commit", e.data)
+    if e.data.getVar('BUILDHISTORY_FEATURES', True).strip():
+        if e.data.getVar("BUILDHISTORY_COMMIT", True) == "1":
+            bb.build.exec_func("buildhistory_commit", e.data)
 }
 
-addhandler buildhistory_eventhandler
+addhandler buildhistory_eventhandler bb.event.BuildCompleted
 
 
 # FIXME this ought to be moved into the fetcher
diff --git a/meta/classes/buildstats.bbclass b/meta/classes/buildstats.bbclass
index e12e14f..a15d521 100644
--- a/meta/classes/buildstats.bbclass
+++ b/meta/classes/buildstats.bbclass
@@ -277,5 +277,5 @@ python run_buildstats () {
         file.close()
 }
 
-addhandler run_buildstats
+addhandler run_buildstats bb.event.BuildStarted bb.event.BuildCompleted bb.build.TaskStarted bb.build.TaskSucceeded bb.build.TaskFailed
 
diff --git a/meta/classes/cross.bbclass b/meta/classes/cross.bbclass
index eaba4d1..a917d6a 100644
--- a/meta/classes/cross.bbclass
+++ b/meta/classes/cross.bbclass
@@ -58,9 +58,6 @@ do_populate_sysroot[sstate-inputdirs] = "${SYSROOT_DESTDIR}/${STAGING_DIR_NATIVE
 do_populate_sysroot[stamp-extra-info] = ""
 
 python cross_virtclass_handler () {
-    if not isinstance(e, bb.event.RecipePreFinalise):
-        return
-
     classextend = e.data.getVar('BBCLASSEXTEND', True) or ""
     if "cross" not in classextend:
         return
@@ -72,7 +69,7 @@ python cross_virtclass_handler () {
     bb.data.setVar("OVERRIDES", e.data.getVar("OVERRIDES", False) + ":virtclass-cross", e.data)
 }
 
-addhandler cross_virtclass_handler
+addhandler cross_virtclass_handler bb.event.RecipePreFinalise
 
 do_install () {
 	oe_runmake 'DESTDIR=${D}' install
diff --git a/meta/classes/distrodata.bbclass b/meta/classes/distrodata.bbclass
index cedacc2..b7713a4 100644
--- a/meta/classes/distrodata.bbclass
+++ b/meta/classes/distrodata.bbclass
@@ -1,15 +1,13 @@
 include conf/distro/include/package_regex.inc
-addhandler distro_eventhandler
+addhandler distro_eventhandler bb.event.BuildStarted
 python distro_eventhandler() {
-
-    if bb.event.getName(e) == "BuildStarted":
-        import oe.distro_check as dc
-        logfile = dc.create_log_file(e.data, "distrodata.csv")
-        lf = bb.utils.lockfile("%s.lock" % logfile)
-        f = open(logfile, "a")
-        f.write("Package,Description,Owner,License,VerMatch,Version,Upsteam,Reason,Recipe Status,Distro 1,Distro 2,Distro 3\n")
-        f.close()
-        bb.utils.unlockfile(lf)
+    import oe.distro_check as dc
+    logfile = dc.create_log_file(e.data, "distrodata.csv")
+    lf = bb.utils.lockfile("%s.lock" % logfile)
+    f = open(logfile, "a")
+    f.write("Package,Description,Owner,License,VerMatch,Version,Upsteam,Reason,Recipe Status,Distro 1,Distro 2,Distro 3\n")
+    f.close()
+    bb.utils.unlockfile(lf)
 
     return
 }
@@ -196,7 +194,7 @@ do_distrodataall() {
         :
 }
 
-addhandler checkpkg_eventhandler
+addhandler checkpkg_eventhandler bb.event.BuildStarted bb.event.BuildCompleted
 python checkpkg_eventhandler() {
     def parse_csv_file(filename):
         package_dict = {}
@@ -792,12 +790,11 @@ do_checkpkgall() {
         :
 }
 
-addhandler distro_check_eventhandler
+addhandler distro_check_eventhandler bb.event.BuildStarted
 python distro_check_eventhandler() {
-    if bb.event.getName(e) == "BuildStarted":
-        """initialize log files."""
-        import oe.distro_check as dc
-        result_file = dc.create_log_file(e.data, "distrocheck.csv")
+    """initialize log files."""
+    import oe.distro_check as dc
+    result_file = dc.create_log_file(e.data, "distrocheck.csv")
     return
 }
 
@@ -838,17 +835,16 @@ do_distro_checkall() {
 #Use this task to generate the missing license text data for pkg-report system,
 #then we can search those recipes which license text isn't exsit in common-licenses directory
 #
-addhandler checklicense_eventhandler
+addhandler checklicense_eventhandler bb.event.BuildStarted
 python checklicense_eventhandler() {
-    if bb.event.getName(e) == "BuildStarted":
-        """initialize log files."""
-        import oe.distro_check as dc
-        logfile = dc.create_log_file(e.data, "missinglicense.csv")
-        lf = bb.utils.lockfile("%s.lock" % logfile)
-        f = open(logfile, "a")
-        f.write("Package\tLicense\tMissingLicense\n")
-        f.close()
-        bb.utils.unlockfile(lf)
+    """initialize log files."""
+    import oe.distro_check as dc
+    logfile = dc.create_log_file(e.data, "missinglicense.csv")
+    lf = bb.utils.lockfile("%s.lock" % logfile)
+    f = open(logfile, "a")
+    f.write("Package\tLicense\tMissingLicense\n")
+    f.close()
+    bb.utils.unlockfile(lf)
     return
 }
 
diff --git a/meta/classes/migrate_localcount.bbclass b/meta/classes/migrate_localcount.bbclass
index 3916ad4..d93a0bf 100644
--- a/meta/classes/migrate_localcount.bbclass
+++ b/meta/classes/migrate_localcount.bbclass
@@ -6,41 +6,40 @@ python migrate_localcount_handler () {
     if not e.data:
         return
 
-    if isinstance(e, bb.event.RecipeParsed):
-        pv = e.data.getVar('PV', True)
-        if not 'AUTOINC' in pv:
-            return
-
-        localcounts = bb.persist_data.persist('BB_URI_LOCALCOUNT', e.data)
-        pn = e.data.getVar('PN', True)
-        revs = localcounts.get_by_pattern('%%-%s_rev' % pn)
-        counts = localcounts.get_by_pattern('%%-%s_count' % pn)
-        if not revs or not counts:
-            return
-
-        if len(revs) != len(counts):
-            bb.warn("The number of revs and localcounts don't match in %s" % pn)
-            return
-
-        version = e.data.getVar('PRAUTOINX', True)
-        srcrev = bb.fetch2.get_srcrev(e.data)
-        base_ver = 'AUTOINC-%s' % version[:version.find(srcrev)]
-        pkgarch = e.data.getVar('PACKAGE_ARCH', True)
-        value = max(int(count) for count in counts)
-
-        if len(revs) == 1:
-            if srcrev != ('AUTOINC+%s' % revs[0]):
-                value += 1
-        else:
-            value += 1
+    pv = e.data.getVar('PV', True)
+    if not 'AUTOINC' in pv:
+        return
+
+    localcounts = bb.persist_data.persist('BB_URI_LOCALCOUNT', e.data)
+    pn = e.data.getVar('PN', True)
+    revs = localcounts.get_by_pattern('%%-%s_rev' % pn)
+    counts = localcounts.get_by_pattern('%%-%s_count' % pn)
+    if not revs or not counts:
+        return
 
-        bb.utils.mkdirhier(e.data.getVar('PRSERV_DUMPDIR', True))
-        df = e.data.getVar('LOCALCOUNT_DUMPFILE', True)
-        flock = bb.utils.lockfile("%s.lock" % df)
-        with open(df, 'a') as fd:
-            fd.write('PRAUTO$%s$%s$%s = "%s"\n' %
-                    (base_ver, pkgarch, srcrev, str(value)))
-        bb.utils.unlockfile(flock)
+    if len(revs) != len(counts):
+        bb.warn("The number of revs and localcounts don't match in %s" % pn)
+        return
+
+    version = e.data.getVar('PRAUTOINX', True)
+    srcrev = bb.fetch2.get_srcrev(e.data)
+    base_ver = 'AUTOINC-%s' % version[:version.find(srcrev)]
+    pkgarch = e.data.getVar('PACKAGE_ARCH', True)
+    value = max(int(count) for count in counts)
+
+    if len(revs) == 1:
+        if srcrev != ('AUTOINC+%s' % revs[0]):
+            value += 1
+    else:
+        value += 1
+
+    bb.utils.mkdirhier(e.data.getVar('PRSERV_DUMPDIR', True))
+    df = e.data.getVar('LOCALCOUNT_DUMPFILE', True)
+    flock = bb.utils.lockfile("%s.lock" % df)
+    with open(df, 'a') as fd:
+        fd.write('PRAUTO$%s$%s$%s = "%s"\n' %
+                (base_ver, pkgarch, srcrev, str(value)))
+    bb.utils.unlockfile(flock)
 }
 
-addhandler migrate_localcount_handler
+addhandler migrate_localcount_handler bb.event.RecipeParsed
diff --git a/meta/classes/multilib.bbclass b/meta/classes/multilib.bbclass
index 4dbec73..bbfe082 100644
--- a/meta/classes/multilib.bbclass
+++ b/meta/classes/multilib.bbclass
@@ -1,7 +1,4 @@
 python multilib_virtclass_handler () {
-    if not isinstance(e, bb.event.RecipePreFinalise):
-        return
-
     cls = e.data.getVar("BBEXTENDCURR", True)
     variant = e.data.getVar("BBEXTENDVARIANT", True)
     if cls != "multilib" or not variant:
@@ -59,7 +56,7 @@ python multilib_virtclass_handler () {
         e.data.setVar("DEFAULTTUNE", newtune)
 }
 
-addhandler multilib_virtclass_handler
+addhandler multilib_virtclass_handler bb.event.RecipePreFinalise
 
 STAGINGCC_prepend = "${BBEXTENDVARIANT}-"
 
diff --git a/meta/classes/multilib_global.bbclass b/meta/classes/multilib_global.bbclass
index 85f2d8d..aaf0a7d 100644
--- a/meta/classes/multilib_global.bbclass
+++ b/meta/classes/multilib_global.bbclass
@@ -42,5 +42,5 @@ python multilib_virtclass_handler_global () {
                 e.data.setVar("RPROVIDES_%s" % pkg, rprovs)
 }
 
-addhandler multilib_virtclass_handler_global
+addhandler multilib_virtclass_handler_global bb.event.RecipePreFinalise bb.event.RecipeParsed
 
diff --git a/meta/classes/native.bbclass b/meta/classes/native.bbclass
index cd930f0..b4b3e0e 100644
--- a/meta/classes/native.bbclass
+++ b/meta/classes/native.bbclass
@@ -104,9 +104,6 @@ CLASSOVERRIDE = "class-native"
 PATH_prepend = "${COREBASE}/scripts/native-intercept:"
 
 python native_virtclass_handler () {
-    if not isinstance(e, bb.event.RecipePreFinalise):
-        return
-
     classextend = e.data.getVar('BBCLASSEXTEND', True) or ""
     if "native" not in classextend:
         return
@@ -151,7 +148,7 @@ python native_virtclass_handler () {
     e.data.setVar("OVERRIDES", e.data.getVar("OVERRIDES", False) + ":virtclass-native")
 }
 
-addhandler native_virtclass_handler
+addhandler native_virtclass_handler bb.event.RecipePreFinalise
 
 do_package[noexec] = "1"
 do_packagedata[noexec] = "1"
diff --git a/meta/classes/nativesdk.bbclass b/meta/classes/nativesdk.bbclass
index 8b689e7..3c1b71f 100644
--- a/meta/classes/nativesdk.bbclass
+++ b/meta/classes/nativesdk.bbclass
@@ -60,9 +60,6 @@ export PKG_CONFIG_DIR = "${STAGING_DIR_HOST}${libdir}/pkgconfig"
 export PKG_CONFIG_SYSROOT_DIR = "${STAGING_DIR_HOST}"
 
 python nativesdk_virtclass_handler () {
-    if not isinstance(e, bb.event.RecipePreFinalise):
-        return
-
     pn = e.data.getVar("PN", True)
     if not pn.endswith("-nativesdk") or pn.startswith("nativesdk-"):
         return
@@ -88,6 +85,6 @@ python () {
     clsextend.map_variable("PROVIDES")
 }
 
-addhandler nativesdk_virtclass_handler
+addhandler nativesdk_virtclass_handler bb.event.RecipePreFinalise
 
 do_populate_sysroot[stamp-extra-info] = ""
diff --git a/meta/classes/packageinfo.bbclass b/meta/classes/packageinfo.bbclass
index 4709bea..4711c44 100644
--- a/meta/classes/packageinfo.bbclass
+++ b/meta/classes/packageinfo.bbclass
@@ -1,29 +1,28 @@
 python packageinfo_handler () {
-    if isinstance(e, bb.event.RequestPackageInfo):
-        import oe.packagedata
-        pkginfolist = []
-        tmpdir = e.data.getVar('TMPDIR', True)
-        target_vendor = e.data.getVar('TARGET_VENDOR', True)
-        target_os = e.data.getVar('TARGET_OS', True)
-        package_archs = e.data.getVar('PACKAGE_ARCHS', True)
-        packaging = e.data.getVar('PACKAGE_CLASSES', True).split()[0].split('_')[1]
-        deploy_dir = e.data.getVar('DEPLOY_DIR', True) + '/' + packaging
-                                           
-        for arch in package_archs.split():
-            pkgdata_dir = tmpdir + '/pkgdata/' + arch + target_vendor + '-' + target_os + '/runtime/'
-            if os.path.exists(pkgdata_dir):
-                for root, dirs, files in os.walk(pkgdata_dir):
-                    for pkgname in files:
-                        if pkgname.endswith('.packaged'):
-                            pkgname = pkgname[:-9]
-                            pkgdatafile = root + pkgname
-                            try:
-                                sdata = oe.packagedata.read_pkgdatafile(pkgdatafile)
-                                sdata['PKG'] = pkgname
-                                pkginfolist.append(sdata)
-                            except Exception as e:
-                                bb.warn("Failed to read pkgdata file %s: %s: %s" % (pkgdatafile, e.__class__, str(e)))
-        bb.event.fire(bb.event.PackageInfo(pkginfolist), e.data)
+    import oe.packagedata
+    pkginfolist = []
+    tmpdir = e.data.getVar('TMPDIR', True)
+    target_vendor = e.data.getVar('TARGET_VENDOR', True)
+    target_os = e.data.getVar('TARGET_OS', True)
+    package_archs = e.data.getVar('PACKAGE_ARCHS', True)
+    packaging = e.data.getVar('PACKAGE_CLASSES', True).split()[0].split('_')[1]
+    deploy_dir = e.data.getVar('DEPLOY_DIR', True) + '/' + packaging
+                                       
+    for arch in package_archs.split():
+        pkgdata_dir = tmpdir + '/pkgdata/' + arch + target_vendor + '-' + target_os + '/runtime/'
+        if os.path.exists(pkgdata_dir):
+            for root, dirs, files in os.walk(pkgdata_dir):
+                for pkgname in files:
+                    if pkgname.endswith('.packaged'):
+                        pkgname = pkgname[:-9]
+                        pkgdatafile = root + pkgname
+                        try:
+                            sdata = oe.packagedata.read_pkgdatafile(pkgdatafile)
+                            sdata['PKG'] = pkgname
+                            pkginfolist.append(sdata)
+                        except Exception as e:
+                            bb.warn("Failed to read pkgdata file %s: %s: %s" % (pkgdatafile, e.__class__, str(e)))
+    bb.event.fire(bb.event.PackageInfo(pkginfolist), e.data)
 }
 
-addhandler packageinfo_handler
+addhandler packageinfo_handler bb.event.RequestPackageInfo
diff --git a/meta/classes/prexport.bbclass b/meta/classes/prexport.bbclass
index 6b9d540..6949b6e 100644
--- a/meta/classes/prexport.bbclass
+++ b/meta/classes/prexport.bbclass
@@ -54,4 +54,4 @@ python prexport_handler () {
 
 }
 
-addhandler prexport_handler
+addhandler prexport_handler bb.event.RecipeParsed bb.event.ParseStarted bb.event.ParseCompleted
diff --git a/meta/classes/primport.bbclass b/meta/classes/primport.bbclass
index 37b0d6b..685b461 100644
--- a/meta/classes/primport.bbclass
+++ b/meta/classes/primport.bbclass
@@ -17,4 +17,4 @@ python primport_handler () {
         oe.prservice.prserv_check_avail(e.data)
 }
 
-addhandler primport_handler
+addhandler primport_handler bb.event.ParseCompleted bb.event.ParseStarted
diff --git a/meta/classes/recipe_sanity.bbclass b/meta/classes/recipe_sanity.bbclass
index bf378ea..21f7505 100644
--- a/meta/classes/recipe_sanity.bbclass
+++ b/meta/classes/recipe_sanity.bbclass
@@ -140,9 +140,6 @@ do_recipe_sanity_all () {
 addtask recipe_sanity_all after do_recipe_sanity
 
 python recipe_sanity_eh () {
-    if bb.event.getName(e) != "ConfigParsed":
-        return
-
     d = e.data
 
     cfgdata = {}
@@ -167,4 +164,4 @@ python recipe_sanity_eh () {
             self.setVar("__recipe_sanity_renames", renames)
     DataSmart.renameVar = myrename
 }
-addhandler recipe_sanity_eh
+addhandler recipe_sanity_eh bb.event.ConfigParsed
diff --git a/meta/classes/sanity.bbclass b/meta/classes/sanity.bbclass
index 3b01acf..8648a7e 100644
--- a/meta/classes/sanity.bbclass
+++ b/meta/classes/sanity.bbclass
@@ -662,7 +662,7 @@ def copy_data(e):
     sanity_data.finalize()
     return sanity_data
 
-addhandler check_sanity_eventhandler
+addhandler check_sanity_eventhandler bb.event.ConfigParsed bb.event.SanityCheck bb.event.NetworkTest
 python check_sanity_eventhandler() {
     if bb.event.getName(e) == "ConfigParsed" and e.data.getVar("BB_WORKERCONTEXT", True) != "1" and e.data.getVar("DISABLE_SANITY_CHECKS", True) != "1":
         sanity_data = copy_data(e)
diff --git a/meta/classes/tinderclient.bbclass b/meta/classes/tinderclient.bbclass
index 6984efd..c186f96 100644
--- a/meta/classes/tinderclient.bbclass
+++ b/meta/classes/tinderclient.bbclass
@@ -355,7 +355,7 @@ def tinder_do_tinder_report(event):
 
 
 # we want to be an event handler
-addhandler tinderclient_eventhandler
+addhandler tinderclient_eventhandler *
 python tinderclient_eventhandler() {
     if e.data is None or bb.event.getName(e) == "MsgNote":
         return
diff --git a/meta/classes/typecheck.bbclass b/meta/classes/typecheck.bbclass
index 353532d..196384c 100644
--- a/meta/classes/typecheck.bbclass
+++ b/meta/classes/typecheck.bbclass
@@ -4,9 +4,8 @@
 
 python check_types() {
     import oe.types
-    if isinstance(e, bb.event.ConfigParsed):
-        for key in e.data.keys():
-            if e.data.getVarFlag(key, "type"):
-                oe.data.typed_value(key, e.data)
+    for key in e.data.keys():
+        if e.data.getVarFlag(key, "type"):
+            oe.data.typed_value(key, e.data)
 }
-addhandler check_types
+addhandler check_types bb.event.ConfigParsed
diff --git a/meta/conf/distro/include/csl-versions.inc b/meta/conf/distro/include/csl-versions.inc
index e8f52d2..e1d812d 100644
--- a/meta/conf/distro/include/csl-versions.inc
+++ b/meta/conf/distro/include/csl-versions.inc
@@ -88,8 +88,6 @@ def csl_get_gdb_version(d):
 		return first_line.split()[-1]
 
 python csl_version_handler () {
-    if not isinstance(e, bb.event.ConfigParsed):
-        return
     d = e.data
     ld = d.createCopy()
     ld.finalize()
@@ -100,7 +98,7 @@ python csl_version_handler () {
     d.setVar('CSL_VER_KERNEL', csl_get_kernel_version(ld))
     d.setVar('CSL_VER_GDB', csl_get_gdb_version(ld))
 }
-addhandler csl_version_handler
+addhandler csl_version_handler bb.event.ConfigParsed
 
 # Ensure that any variable which includes the --sysroot (CC, CXX, etc) also
 # depends on the toolchain version
diff --git a/meta/conf/distro/include/tcmode-external-sourcery.inc b/meta/conf/distro/include/tcmode-external-sourcery.inc
index 098c724..a42c78d 100644
--- a/meta/conf/distro/include/tcmode-external-sourcery.inc
+++ b/meta/conf/distro/include/tcmode-external-sourcery.inc
@@ -79,9 +79,6 @@ EXTERNAL_TOOLCHAIN_SYSROOT_CMD += "${@csl_multilib_arg(d)}"
 # to our staging toolchain bindir.
 
 python toolchain_metadata_setup () {
-    if not isinstance(e, bb.event.ConfigParsed):
-        return
-
     d = e.data
 
     l = d.createCopy()
@@ -89,18 +86,15 @@ python toolchain_metadata_setup () {
     if os.path.exists(bb.data.expand('${EXTERNAL_TOOLCHAIN}/bin/gcc', l)):
         d.setVar('TOOLCHAIN_PATH_ADD', '')
 }
-addhandler toolchain_metadata_setup
+addhandler toolchain_metadata_setup bb.event.ConfigParsed
 
 python toolchain_setup () {
-    if not isinstance(e, bb.event.BuildStarted):
-        return
-
     d = e.data
 
     if not d.getVar('TOOLCHAIN_PATH_ADD', True):
         populate_toolchain_links(d)
 }
-addhandler toolchain_setup
+addhandler toolchain_setup bb.event.BuildStarted
 
 def populate_toolchain_links(d):
     import errno
-- 
1.7.10.4


