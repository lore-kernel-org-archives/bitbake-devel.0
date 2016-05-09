Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C569A731B8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 13:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49D1Egw015458 for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 May 2016 14:01:14 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mstvWlnjvEqP for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 14:01:14 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49D1CEh015439
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 May 2016 14:01:14 +0100
Message-ID: <1462798872.21831.128.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 09 May 2016 14:01:12 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: Update logger.warn() -> logger.warning()
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
X-List-Received-Date: Mon, 09 May 2016 13:01:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

python deprecated logger.warn() in favour of logger.warning(). This is only 
used in bitbake code so we may as well just translate everything to avoid
warnings under python 3. Its safe for python 2.7.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index d47a669..18f379b 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -654,7 +654,7 @@ build results (as the layer priority order has effectively changed).
                                     logger.plain('  Skipping layer config file %s' % f1full )
                                     continue
                                 else:
-                                    logger.warn('Overwriting file %s', fdest)
+                                    logger.warning('Overwriting file %s', fdest)
                             bb.utils.copyfile(f1full, fdest)
                             if ext == '.bb':
                                 for append in self.bbhandler.cooker.collection.get_file_appends(f1full):
@@ -790,7 +790,7 @@ Lists recipes with the bbappends that apply to them as subitems.
 
             if best_filename:
                 if best_filename in missing:
-                    logger.warn('%s: missing append for preferred version',
+                    logger.warning('%s: missing append for preferred version',
                                 best_filename)
             return True
         else:
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 0a5ec46..5f73b75 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -377,7 +377,7 @@ class BitbakeWorker(object):
     def handle_ping(self, _):
         workerlog_write("Handling ping\n")
 
-        logger.warn("Pong from bitbake-worker!")
+        logger.warning("Pong from bitbake-worker!")
 
     def handle_quit(self, data):
         workerlog_write("Handling quit\n")
diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index 502ad83..a9ce268 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -85,7 +85,7 @@ def plain(*args):
 
 def debug(lvl, *args):
     if isinstance(lvl, basestring):
-        mainlogger.warn("Passed invalid debug level '%s' to bb.debug", lvl)
+        mainlogger.warning("Passed invalid debug level '%s' to bb.debug", lvl)
         args = (lvl,) + args
         lvl = 1
     mainlogger.debug(lvl, ''.join(args))
@@ -94,7 +94,7 @@ def note(*args):
     mainlogger.info(''.join(args))
 
 def warn(*args):
-    mainlogger.warn(''.join(args))
+    mainlogger.warning(''.join(args))
 
 def error(*args, **kwargs):
     mainlogger.error(''.join(args), extra=kwargs)
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 1d0dcde..e78d04d 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -167,7 +167,7 @@ def exec_func(func, d, dirs = None, pythonexception=False):
     body = d.getVar(func, False)
     if not body:
         if body is None:
-            logger.warn("Function %s doesn't exist", func)
+            logger.warning("Function %s doesn't exist", func)
         return
 
     flags = d.getVarFlags(func)
diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index dbc6dea..d807204 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -364,7 +364,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             if varflags.get("python"):
                 parser = bb.codeparser.PythonParser(key, logger)
                 if value and "\t" in value:
-                    logger.warn("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE", True)))
+                    logger.warning("Variable %s contains tabs, please remove these (%s)" % (key, d.getVar("FILE", True)))
                 parser.parse_python(value, filename=varflags.get("filename"), lineno=varflags.get("lineno"))
                 deps = deps | parser.references
                 deps = deps | (keys & parser.execs)
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 1fa6702..b92ec0e 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -586,10 +586,10 @@ def verify_checksum(ud, d, precomputed={}):
             raise NoChecksumError('Missing SRC_URI checksum', ud.url)
 
         # Log missing sums so user can more easily add them
-        logger.warn('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
+        logger.warning('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
                     'SRC_URI[%s] = "%s"',
                     ud.localpath, ud.md5_name, md5data)
-        logger.warn('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
+        logger.warning('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
                     'SRC_URI[%s] = "%s"',
                     ud.localpath, ud.sha256_name, sha256data)
 
@@ -659,7 +659,7 @@ def verify_donestamp(ud, d, origud=None):
             # files to those containing the checksums.
             if not isinstance(e, EOFError):
                 # Ignore errors, they aren't fatal
-                logger.warn("Couldn't load checksums from donestamp %s: %s "
+                logger.warning("Couldn't load checksums from donestamp %s: %s "
                             "(msg: %s)" % (ud.donestamp, type(e).__name__,
                                            str(e)))
 
@@ -675,7 +675,7 @@ def verify_donestamp(ud, d, origud=None):
     except ChecksumError as e:
         # Checksums failed to verify, trigger re-download and remove the
         # incorrect stamp file.
-        logger.warn("Checksum mismatch for local file %s\n"
+        logger.warning("Checksum mismatch for local file %s\n"
                     "Cleaning and trying again." % ud.localpath)
         if os.path.exists(ud.localpath):
             rename_bad_checksum(ud, e.checksum)
@@ -708,7 +708,7 @@ def update_stamp(ud, d):
         except ChecksumError as e:
             # Checksums failed to verify, trigger re-download and remove the
             # incorrect stamp file.
-            logger.warn("Checksum mismatch for local file %s\n"
+            logger.warning("Checksum mismatch for local file %s\n"
                         "Cleaning and trying again." % ud.localpath)
             if os.path.exists(ud.localpath):
                 rename_bad_checksum(ud, e.checksum)
@@ -982,8 +982,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
 
     except bb.fetch2.BBFetchException as e:
         if isinstance(e, ChecksumError):
-            logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
-            logger.warn(str(e))
+            logger.warning("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
+            logger.warning(str(e))
             if os.path.exists(ud.localpath):
                 rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
@@ -1198,7 +1198,7 @@ class FetchData(object):
             raise NonLocalMethod()
 
         if self.parm.get("proto", None) and "protocol" not in self.parm:
-            logger.warn('Consider updating %s recipe to use "protocol" not "proto" in SRC_URI.', d.getVar('PN', True))
+            logger.warning('Consider updating %s recipe to use "protocol" not "proto" in SRC_URI.', d.getVar('PN', True))
             self.parm["protocol"] = self.parm.get("proto", None)
 
         if hasattr(self.method, "urldata_init"):
@@ -1594,14 +1594,14 @@ class Fetch(object):
 
                     except BBFetchException as e:
                         if isinstance(e, ChecksumError):
-                            logger.warn("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
+                            logger.warning("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
                             logger.debug(1, str(e))
                             if os.path.exists(ud.localpath):
                                 rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
-                            logger.warn('Failed to fetch URL %s, attempting MIRRORS if available' % u)
+                            logger.warning('Failed to fetch URL %s, attempting MIRRORS if available' % u)
                             logger.debug(1, str(e))
                         firsterr = e
                         # Remove any incomplete fetch
diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
index e8d9b11..d9e46b2 100644
--- a/bitbake/lib/bb/fetch2/npm.py
+++ b/bitbake/lib/bb/fetch2/npm.py
@@ -251,14 +251,14 @@ class Npm(FetchMethod):
             with open(shwrf) as datafile:
                 shrinkobj = json.load(datafile)
         except:
-            logger.warn('Missing shrinkwrap file in NPM_SHRINKWRAP for %s, this will lead to unreliable builds!' % ud.pkgname)
+            logger.warning('Missing shrinkwrap file in NPM_SHRINKWRAP for %s, this will lead to unreliable builds!' % ud.pkgname)
         lckdf = d.getVar('NPM_LOCKDOWN', True)
         logger.debug(2, "NPM lockdown file is %s" % lckdf)
         try:
             with open(lckdf) as datafile:
                 lockdown = json.load(datafile)
         except:
-            logger.warn('Missing lockdown file in NPM_LOCKDOWN for %s, this will lead to unreproducible builds!' % ud.pkgname)
+            logger.warning('Missing lockdown file in NPM_LOCKDOWN for %s, this will lead to unreproducible builds!' % ud.pkgname)
 
         if ('name' not in shrinkobj):
             self._getdependencies(ud.pkgname, jsondepobj, ud.version, d, ud)
diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index 466523c..203c405 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -220,7 +220,7 @@ class diskMonitor:
                 if minSpace and freeSpace < minSpace:
                     # Always show warning, the self.checked would always be False if the action is WARN
                     if self.preFreeS[k] == 0 or self.preFreeS[k] - freeSpace > self.spaceInterval and not self.checked[k]:
-                        logger.warn("The free space of %s (%s) is running low (%.3fGB left)" % \
+                        logger.warning("The free space of %s (%s) is running low (%.3fGB left)" % \
                                 (path, dev, freeSpace / 1024 / 1024 / 1024.0))
                         self.preFreeS[k] = freeSpace
 
@@ -246,7 +246,7 @@ class diskMonitor:
                         continue
                     # Always show warning, the self.checked would always be False if the action is WARN
                     if self.preFreeI[k] == 0 or self.preFreeI[k] - freeInode > self.inodeInterval and not self.checked[k]:
-                        logger.warn("The free inode of %s (%s) is running low (%.3fK left)" % \
+                        logger.warning("The free inode of %s (%s) is running low (%.3fK left)" % \
                                 (path, dev, freeInode / 1024.0))
                         self.preFreeI[k] = freeInode
 
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index fbd75b1..b971292 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -84,13 +84,13 @@ def include(parentfn, fn, lineno, data, error_out):
         bbpath = "%s:%s" % (dname, data.getVar("BBPATH", True))
         abs_fn, attempts = bb.utils.which(bbpath, fn, history=True)
         if abs_fn and bb.parse.check_dependency(data, abs_fn):
-            logger.warn("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE', True)))
+            logger.warning("Duplicate inclusion for %s in %s" % (abs_fn, data.getVar('FILE', True)))
         for af in attempts:
             bb.parse.mark_dependency(data, af)
         if abs_fn:
             fn = abs_fn
     elif bb.parse.check_dependency(data, fn):
-        logger.warn("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE', True)))
+        logger.warning("Duplicate inclusion for %s in %s" % (fn, data.getVar('FILE', True)))
 
     try:
         bb.parse.handle(fn, data, True)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 8d2aa7b..88701a0 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -824,7 +824,7 @@ class RunQueueData:
                     msg += "\n%s has unique rprovides:\n  %s" % (provfn, "\n  ".join(rprovide_results[provfn] - commonrprovs))
 
                 if self.warn_multi_bb:
-                    logger.warn(msg)
+                    logger.warning(msg)
                 else:
                     logger.error(msg)
 
@@ -852,7 +852,7 @@ class RunQueueData:
             taskdep = self.dataCache.task_deps[fn]
             fnid = self.taskData.getfn_id(fn)
             if taskname not in taskData.tasks_lookup[fnid]:
-                logger.warn("Task %s does not exist, invalidating this task will have no effect" % taskname)
+                logger.warning("Task %s does not exist, invalidating this task will have no effect" % taskname)
             if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
                 if error_nostamp:
                     bb.fatal("Task %s is marked nostamp, cannot invalidate this task" % taskname)
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 88fc0f1..21ecd8f 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -221,7 +221,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if taint:
             data = data + taint
             self.taints[k] = taint
-            logger.warn("%s is tainted from a forced run" % k)
+            logger.warning("%s is tainted from a forced run" % k)
 
         h = hashlib.md5(data).hexdigest()
         self.taskhash[k] = h
diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 9397905..2542e1f 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -664,7 +664,7 @@ class ORMWrapper(object):
                         dep_type = tdeptype,
                         target = target_obj))
                 except KeyError as e:
-                    logger.warn("Could not add dependency to the package %s "
+                    logger.warning("Could not add dependency to the package %s "
                                 "because %s is an unknown package", p, px)
 
         if len(packagedeps_objs) > 0:
@@ -673,7 +673,7 @@ class ORMWrapper(object):
             logger.info("No package dependencies created")
 
         if len(errormsg) > 0:
-            logger.warn("buildinfohelper: target_package_info could not identify recipes: \n%s", errormsg)
+            logger.warning("buildinfohelper: target_package_info could not identify recipes: \n%s", errormsg)
 
     def save_target_image_file_information(self, target_obj, file_name, file_size):
         Target_Image_File.objects.create( target = target_obj,
@@ -932,7 +932,7 @@ class BuildInfoHelper(object):
                 return lvo
 
         #if we get here, we didn't read layers correctly; dump whatever information we have on the error log
-        logger.warn("Could not match layer version for recipe path %s : %s", path, self.orm_wrapper.layer_version_objects)
+        logger.warning("Could not match layer version for recipe path %s : %s", path, self.orm_wrapper.layer_version_objects)
 
         #mockup the new layer
         unknown_layer, _ = Layer.objects.get_or_create(name="Unidentified layer", layer_index_url="")
@@ -1003,7 +1003,7 @@ class BuildInfoHelper(object):
                 self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)] = layerinfos[layer]['version']
                 self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer], self.brbe)]['local_path'] = layerinfos[layer]['local_path']
             except NotExisting as nee:
-                logger.warn("buildinfohelper: cannot identify layer exception:%s ", nee)
+                logger.warning("buildinfohelper: cannot identify layer exception:%s ", nee)
 
 
     def store_started_build(self, event, build_log_path):
@@ -1240,13 +1240,13 @@ class BuildInfoHelper(object):
                     self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'], built_package=True)
                     self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata.copy(), pkgdata, self.internal_state['recipes'], built_package=False)
                 except KeyError as e:
-                    logger.warn("KeyError in save_target_package_information"
+                    logger.warning("KeyError in save_target_package_information"
                                 "%s ", e)
 
                 try:
                     self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
                 except KeyError as e:
-                    logger.warn("KeyError in save_target_file_information"
+                    logger.warning("KeyError in save_target_file_information"
                                 "%s ", e)
 
 
@@ -1392,7 +1392,7 @@ class BuildInfoHelper(object):
         Task_Dependency.objects.bulk_create(taskdeps_objects)
 
         if len(errormsg) > 0:
-            logger.warn("buildinfohelper: dependency info not identify recipes: \n%s", errormsg)
+            logger.warning("buildinfohelper: dependency info not identify recipes: \n%s", errormsg)
 
 
     def store_build_package_information(self, event):
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 2685627..54c5704 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -350,7 +350,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         tries -= 1
                     if tries:
                         continue
-                logger.warn(event.msg)
+                logger.warning(event.msg)
                 continue
 
             if isinstance(event, logging.LogRecord):
@@ -377,7 +377,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, bb.build.TaskFailedSilent):
-                logger.warn("Logfile for failed setscene task is %s" % event.logfile)
+                logger.warning("Logfile for failed setscene task is %s" % event.logfile)
                 continue
             if isinstance(event, bb.build.TaskFailed):
                 return_value = 1
@@ -509,7 +509,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
-                logger.warn("Setscene task %s (%s) failed with exit code '%s' - real task will be run instead",
+                logger.warning("Setscene task %s (%s) failed with exit code '%s' - real task will be run instead",
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index 6bf4c1f..addd5cc 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -163,7 +163,7 @@ def main(server, eventHandler, params):
     inheritlist, _ = server.runCommand(["getVariable", "INHERIT"])
 
     if not "buildhistory" in inheritlist.split(" "):
-        logger.warn("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
+        logger.warning("buildhistory is not enabled. Please enable INHERIT += \"buildhistory\" to see image details.")
         build_history_enabled = False
 
     if not params.observe_only:
@@ -433,7 +433,7 @@ def main(server, eventHandler, params):
                 buildinfohelper.store_dependency_information(event)
                 continue
 
-            logger.warn("Unknown event: %s", event)
+            logger.warning("Unknown event: %s", event)
             return_value += 1
 
         except EnvironmentError as ioerror:
@@ -461,5 +461,5 @@ def main(server, eventHandler, params):
     if interrupted and return_value == 0:
         return_value += 1
 
-    logger.warn("Return value is %d", return_value)
+    logger.warning("Return value is %d", return_value)
     return return_value
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index bf4ac40..9c5bf4e 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -819,7 +819,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         if not sstat:
             sstat = os.lstat(src)
     except Exception as e:
-        logger.warn("copyfile: stat of %s failed (%s)" % (src, e))
+        logger.warning("copyfile: stat of %s failed (%s)" % (src, e))
         return False
 
     destexists = 1
@@ -846,7 +846,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
             #os.lchown(dest,sstat[stat.ST_UID],sstat[stat.ST_GID])
             return os.lstat(dest)
         except Exception as e:
-            logger.warn("copyfile: failed to create symlink %s to %s (%s)" % (dest, target, e))
+            logger.warning("copyfile: failed to create symlink %s to %s (%s)" % (dest, target, e))
             return False
 
     if stat.S_ISREG(sstat[stat.ST_MODE]):
@@ -861,7 +861,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
             shutil.copyfile(src, dest + "#new")
             os.rename(dest + "#new", dest)
         except Exception as e:
-            logger.warn("copyfile: copy %s to %s failed (%s)" % (src, dest, e))
+            logger.warning("copyfile: copy %s to %s failed (%s)" % (src, dest, e))
             return False
         finally:
             if srcchown:
@@ -872,13 +872,13 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         #we don't yet handle special, so we need to fall back to /bin/mv
         a = getstatusoutput("/bin/cp -f " + "'" + src + "' '" + dest + "'")
         if a[0] != 0:
-            logger.warn("copyfile: failed to copy special file %s to %s (%s)" % (src, dest, a))
+            logger.warning("copyfile: failed to copy special file %s to %s (%s)" % (src, dest, a))
             return False # failure
     try:
         os.lchown(dest, sstat[stat.ST_UID], sstat[stat.ST_GID])
         os.chmod(dest, stat.S_IMODE(sstat[stat.ST_MODE])) # Sticky is reset on chown
     except Exception as e:
-        logger.warn("copyfile: failed to chown/chmod %s (%s)" % (dest, e))
+        logger.warning("copyfile: failed to chown/chmod %s (%s)" % (dest, e))
         return False
 
     if newmtime:
diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index 7def1f3..7b2f126 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -66,7 +66,7 @@ class LocalhostBEController(BuildEnvironmentController):
                 err = "command: %s \n%s" % (command, out)
             else:
                 err = "command: %s \n%s" % (command, err)
-            logger.warn("localhostbecontroller: shellcmd error %s" % err)
+            logger.warning("localhostbecontroller: shellcmd error %s" % err)
             raise ShellCmdException(err)
         else:
             logger.debug("localhostbecontroller: shellcmd success")
diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 27289be..5532b9d 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -164,16 +164,16 @@ class Command(NoArgsCommand):
             try:
                 self.cleanup()
             except Exception as e:
-                logger.warn("runbuilds: cleanup exception %s" % str(e))
+                logger.warning("runbuilds: cleanup exception %s" % str(e))
 
             try:
                 self.archive()
             except Exception as e:
-                logger.warn("runbuilds: archive exception %s" % str(e))
+                logger.warning("runbuilds: archive exception %s" % str(e))
 
             try:
                 self.schedule()
             except Exception as e:
-                logger.warn("runbuilds: schedule exception %s" % str(e))
+                logger.warning("runbuilds: schedule exception %s" % str(e))
 
             time.sleep(1)
diff --git a/bitbake/lib/toaster/bldcontrol/models.py b/bitbake/lib/toaster/bldcontrol/models.py
index cb49a58..9da40a0 100644
--- a/bitbake/lib/toaster/bldcontrol/models.py
+++ b/bitbake/lib/toaster/bldcontrol/models.py
@@ -98,7 +98,7 @@ class BuildRequest(models.Model):
         # Check that the state we're trying to set is not going backwards
         # e.g. from REQ_FAILED to REQ_INPROGRESS
         if self.old_state != self.state and self.old_state > self.state:
-            logger.warn("Invalid state change requested: "
+            logger.warning("Invalid state change requested: "
                         "Cannot go from %s to %s - ignoring request" %
                         (BuildRequest.REQUEST_STATE[self.old_state][1],
                          BuildRequest.REQUEST_STATE[self.state][1])
diff --git a/bitbake/lib/toaster/contrib/tts/shellutils.py b/bitbake/lib/toaster/contrib/tts/shellutils.py
index c2012ed..ce64c06 100644
--- a/bitbake/lib/toaster/contrib/tts/shellutils.py
+++ b/bitbake/lib/toaster/contrib/tts/shellutils.py
@@ -133,7 +133,7 @@ def run_shell_cmd(command, cwd=None):
             err = "command: %s \n%s" % (command, out)
         else:
             err = "command: %s \n%s" % (command, err)
-        config.logger.warn("_shellcmd: error \n%s\n%s", out, err)
+        config.logger.warning("_shellcmd: error \n%s\n%s", out, err)
         raise ShellCmdException(err)
     else:
         #config.logger.debug("localhostbecontroller: shellcmd success\n%s" % out)
diff --git a/bitbake/lib/toaster/contrib/tts/urlcheck.py b/bitbake/lib/toaster/contrib/tts/urlcheck.py
index 0820f82..001fcee 100644
--- a/bitbake/lib/toaster/contrib/tts/urlcheck.py
+++ b/bitbake/lib/toaster/contrib/tts/urlcheck.py
@@ -26,12 +26,12 @@ def validate_html5(url):
             warnings = int(resp['x-w3c-validator-warnings'])
 
             if status == 'Invalid':
-                config.logger.warn("Failed %s is %s\terrors %s warnings %s (check at %s)", url, status, errors, warnings, urlrequest)
+                config.logger.warning("Failed %s is %s\terrors %s warnings %s (check at %s)", url, status, errors, warnings, urlrequest)
             else:
                 config.logger.debug("OK! %s", url)
 
     except Exception as exc:
-        config.logger.warn("Failed validation call: %s", exc)
+        config.logger.warning("Failed validation call: %s", exc)
     return (status, errors, warnings)
 
 
diff --git a/bitbake/lib/toaster/toastermain/urls.py b/bitbake/lib/toaster/toastermain/urls.py
index 534679d..530a42f 100644
--- a/bitbake/lib/toaster/toastermain/urls.py
+++ b/bitbake/lib/toaster/toastermain/urls.py
@@ -84,7 +84,7 @@ for t in os.walk(os.path.dirname(currentdir)):
         if not conflict:
             urlpatterns.insert(0, url(r'^' + modulename + '/', include ( modulename + '.urls')))
         else:
-            logger.warn("Module \'%s\' has a regexp conflict, was not added to the urlpatterns" % modulename)
+            logger.warning("Module \'%s\' has a regexp conflict, was not added to the urlpatterns" % modulename)
 
 from pprint import pformat
 #logger.debug("urlpatterns list %s", pformat(urlpatterns))



