Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <scott.a.garman@intel.com>) id 1QWdMU-0006E1-7U
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 Jun 2011 01:49:34 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 14 Jun 2011 16:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,367,1304319600"; d="scan'208";a="13577579"
Received: from miles.jf.intel.com ([10.7.199.94])
	by orsmga002.jf.intel.com with ESMTP; 14 Jun 2011 16:45:02 -0700
From: Scott Garman <scott.a.garman@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jun 2011 16:44:58 -0700
Message-Id: <1308095098-8929-1-git-send-email-scott.a.garman@intel.com>
X-Mailer: git-send-email 1.7.1
Cc: Scott Garman <scott.a.garman@intel.com>
Subject: [PATCH] make exception handling syntax consistent
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
X-List-Received-Date: Tue, 14 Jun 2011 23:49:35 -0000

Update exception handling syntax to use the modern style:
except ExcType as localvar

Signed-off-by: Scott Garman <scott.a.garman@intel.com>
---
 bin/bitbake               |    2 +-
 lib/bb/cooker.py          |   10 +++++-----
 lib/bb/data.py            |    2 +-
 lib/bb/fetch2/__init__.py |    4 ++--
 lib/bb/process.py         |    2 +-
 lib/bb/pysh/builtin.py    |   10 +++++-----
 lib/bb/pysh/interp.py     |   14 +++++++-------
 lib/bb/runqueue.py        |    2 +-
 lib/bb/server/process.py  |    4 ++--
 lib/prserv/serv.py        |    6 +++---
 10 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 66bbb21..95820a2 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -32,7 +32,7 @@ import warnings
 from traceback import format_exception
 try:
     import bb
-except RuntimeError, exc:
+except RuntimeError as exc:
     sys.exit(str(exc))
 from bb import event
 import bb.msg
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index da22166..990d17b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -100,7 +100,7 @@ class BBCooker:
                 name_array = (getattr(module, configuration.ui)).extraCaches
                 for recipeInfoName in name_array:
                     caches_name_array.append(recipeInfoName)
-            except ImportError, exc:
+            except ImportError as exc:
                 # bb.ui.XXX is not defined and imported. It's an error!
                 logger.critical("Unable to import '%s' interface from bb.ui: %s" % (configuration.ui, exc))
                 sys.exit("FATAL: Failed to import '%s' interface." % configuration.ui)
@@ -117,7 +117,7 @@ class BBCooker:
                 module_name, cache_name = var.split(':')
                 module = __import__(module_name, fromlist=(cache_name,))
                 self.caches_array.append(getattr(module, cache_name)) 
-            except ImportError, exc:
+            except ImportError as exc:
                 logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
                 sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
 
@@ -277,7 +277,7 @@ class BBCooker:
         if fn:
             try:
                 envdata = bb.cache.Cache.loadDataFull(fn, self.get_file_appends(fn), self.configuration.data)
-            except Exception, e:
+            except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
 
@@ -1155,7 +1155,7 @@ def parse_file(task):
     filename, appends, caches_array = task
     try:
         return True, bb.cache.Cache.parse(filename, appends, parse_file.cfg, caches_array)
-    except Exception, exc:
+    except Exception as exc:
         tb = sys.exc_info()[2]
         exc.recipe = filename
         exc.traceback = list(bb.exceptions.extract_traceback(tb, context=3))
@@ -1163,7 +1163,7 @@ def parse_file(task):
     # Need to turn BaseExceptions into Exceptions here so we gracefully shutdown
     # and for example a worker thread doesn't just exit on its own in response to
     # a SystemExit event for example.
-    except BaseException, exc:
+    except BaseException as exc:
         raise ParsingFailure(exc, filename)
 
 class CookerParser(object):
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 720dd76..2269f9d 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -187,7 +187,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         val = getVar(var, d, 1)
     except (KeyboardInterrupt, bb.build.FuncFailed):
         raise
-    except Exception, exc:
+    except Exception as exc:
         o.write('# expansion of %s threw %s: %s\n' % (var, exc.__class__.__name__, str(exc)))
         return 0
 
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 02a36b5..e9a64c5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -663,7 +663,7 @@ class FetchMethod(object):
 
         try:
             unpack = bb.utils.to_boolean(urldata.parm.get('unpack'), True)
-        except ValueError, exc:
+        except ValueError as exc:
             bb.fatal("Invalid value for 'unpack' parameter for %s: %s" %
                      (file, urldata.parm.get('unpack')))
 
@@ -692,7 +692,7 @@ class FetchMethod(object):
             elif file.endswith('.zip') or file.endswith('.jar'):
                 try:
                     dos = bb.utils.to_boolean(urldata.parm.get('dos'), False)
-                except ValueError, exc:
+                except ValueError as exc:
                     bb.fatal("Invalid value for 'dos' parameter for %s: %s" %
                              (file, urldata.parm.get('dos')))
                 cmd = 'unzip -q -o'
diff --git a/lib/bb/process.py b/lib/bb/process.py
index 4150d80..b74cb18 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -93,7 +93,7 @@ def run(cmd, input=None, log=None, **options):
 
     try:
         pipe = Popen(cmd, **options)
-    except OSError, exc:
+    except OSError as exc:
         if exc.errno == 2:
             raise NotFoundError(cmd)
         else:
diff --git a/lib/bb/pysh/builtin.py b/lib/bb/pysh/builtin.py
index 25ad22e..b748e4a 100644
--- a/lib/bb/pysh/builtin.py
+++ b/lib/bb/pysh/builtin.py
@@ -151,7 +151,7 @@ def builtin_trap(name, args, interp, env, stdin, stdout, stderr, debugflags):
     for sig in args[1:]:
         try:
             env.traps[sig] = action
-        except Exception, e:
+        except Exception as e:
             stderr.write('trap: %s\n' % str(e))
     return 0
 
@@ -214,7 +214,7 @@ def utility_cat(name, args, interp, env, stdin, stdout, stderr, debugflags):
                     data = f.read()
                 finally:
                     f.close()
-            except IOError, e:
+            except IOError as e:
                 if e.errno != errno.ENOENT:
                     raise
                 status = 1
@@ -433,7 +433,7 @@ def utility_mkdir(name, args, interp, env, stdin, stdout, stderr, debugflags):
         if option.has_p:
             try:
                 os.makedirs(path)
-            except IOError, e:
+            except IOError as e:
                 if e.errno != errno.EEXIST:
                     raise
         else:               
@@ -561,7 +561,7 @@ def utility_sort(name, args, interp, env, stdin, stdout, stderr, debugflags):
                     lines = f.readlines()
                 finally:
                     f.close()
-            except IOError, e:
+            except IOError as e:
                 stderr.write(str(e) + '\n')
                 return 1
         
@@ -679,7 +679,7 @@ def run_command(name, args, interp, env, stdin, stdout,
             p = subprocess.Popen([name] + args, cwd=env['PWD'], env=exec_env, 
                     stdin=stdin, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
         out, err = p.communicate()
-    except WindowsError, e:
+    except WindowsError as e:
         raise UtilityError(str(e))
 
     if not unixoutput:
diff --git a/lib/bb/pysh/interp.py b/lib/bb/pysh/interp.py
index efe5181..25d8c92 100644
--- a/lib/bb/pysh/interp.py
+++ b/lib/bb/pysh/interp.py
@@ -248,7 +248,7 @@ class Redirections:
                     raise NotImplementedError('cannot open absolute path %s' % repr(filename))
             else:
                 f = file(filename, mode+'b')
-        except IOError, e:
+        except IOError as e:
             raise RedirectionError(str(e))
             
         wrapper = None
@@ -368,7 +368,7 @@ def resolve_shebang(path, ignoreshell=False):
         if arg is None:
             return [cmd, win32_to_unix_path(path)]
         return [cmd, arg, win32_to_unix_path(path)]
-    except IOError, e:
+    except IOError as e:
         if  e.errno!=errno.ENOENT and \
             (e.errno!=errno.EPERM and not os.path.isdir(path)): # Opening a directory raises EPERM
             raise
@@ -747,7 +747,7 @@ class Interpreter:
             for cmd in cmds:
                 try:
                     status = self.execute(cmd)
-                except ExitSignal, e:
+                except ExitSignal as e:
                     if sourced:
                         raise
                     status = int(e.args[0])
@@ -758,13 +758,13 @@ class Interpreter:
                 if 'debug-utility' in self._debugflags or 'debug-cmd' in self._debugflags:
                     self.log('returncode ' + str(status)+ '\n')
             return status
-        except CommandNotFound, e:
+        except CommandNotFound as e:
             print >>self._redirs.stderr, str(e)
             self._redirs.stderr.flush()
             # Command not found by non-interactive shell
             # return 127
             raise
-        except RedirectionError, e:
+        except RedirectionError as e:
             # TODO: should be handled depending on the utility status
             print >>self._redirs.stderr, str(e)
             self._redirs.stderr.flush()
@@ -948,7 +948,7 @@ class Interpreter:
                     status = self.execute(func, redirs)
                 finally:
                     redirs.close()
-            except ReturnSignal, e:
+            except ReturnSignal as e:
                 status = int(e.args[0])
                 env['?'] = status
             return status
@@ -1044,7 +1044,7 @@ class Interpreter:
                 
         except ReturnSignal:
             raise
-        except ShellError, e:
+        except ShellError as e:
             if is_special or isinstance(e, (ExitSignal,
                                             ShellSyntaxError, ExpansionError)):
                 raise e
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index db1d36d..1f3b54c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1227,7 +1227,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 modname, name = sched.rsplit(".", 1)
                 try:
                     module = __import__(modname, fromlist=(name,))
-                except ImportError, exc:
+                except ImportError as exc:
                     logger.critical("Unable to import scheduler '%s' from '%s': %s" % (name, modname, exc))
                     raise SystemExit(1)
                 else:
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 44b8e4d..5c1044d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -64,7 +64,7 @@ class EventAdapter():
     def send(self, event):
         try:
             self.queue.put(event)
-        except Exception, err:
+        except Exception as err:
             print("EventAdapter puked: %s" % str(err))
 
 
@@ -168,7 +168,7 @@ class ProcessServer(Process):
                 exitcode = 0
             finally:
                 util._exit_function()
-        except SystemExit, e:
+        except SystemExit as e:
             if not e.args:
                 exitcode = 1
             elif type(e.args[0]) is int:
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index ecafe4f..2f488f4 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -88,7 +88,7 @@ class PRServer(SimpleXMLRPCServer):
             pid = os.fork()
             if pid > 0: 
                 sys.exit(0)
-        except OSError,e:
+        except OSError as e:
             sys.stderr.write("1st fork failed: %d %s\n" % (e.errno, e.strerror))
             sys.exit(1)
 
@@ -101,7 +101,7 @@ class PRServer(SimpleXMLRPCServer):
             pid = os.fork()
             if pid > 0: #parent
                 sys.exit(0)
-        except OSError,e:
+        except OSError as e:
             sys.stderr.write("2nd fork failed: %d %s\n" % (e.errno, e.strerror))
             sys.exit(1)
 
@@ -187,7 +187,7 @@ def stop_daemon():
         while 1:
             os.kill(pid,signal.SIGTERM)
             time.sleep(0.1)
-    except OSError, err:
+    except OSError as err:
         err = str(err)
         if err.find("No such process") > 0:
             if os.path.exists(PRServer.pidfile):
-- 
1.7.1



