Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5E1C6763F0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:29 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 30 Jul 2015 09:25:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="773367897"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2015 09:25:29 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id F13E76A4005;
	Thu, 30 Jul 2015 09:24:43 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:09 +0300
Message-Id: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 01/11] toaster: tts: fix pylint warnings
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:31 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings TTS to the pylint coding standards.
Pylint was run with some disables:

disable=logging-too-many-args,line-too-long,missing-docstring

and achieved

Your code has been rated at 10.00/10

There are no functional changes.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/config.py     | 37 ++++++++------
 lib/toaster/contrib/tts/launcher.py   | 35 +++++++-------
 lib/toaster/contrib/tts/recv.py       | 13 +++--
 lib/toaster/contrib/tts/runner.py     | 87 +++++++++++++++++----------------
 lib/toaster/contrib/tts/scratchpad.py | 20 --------
 lib/toaster/contrib/tts/shellutils.py | 64 +++++++++++++------------
 lib/toaster/contrib/tts/tests.py      | 43 ++++++++---------
 lib/toaster/contrib/tts/urlcheck.py   | 29 ++++++-----
 lib/toaster/contrib/tts/urllist.py    | 90 +++++++++++++++++------------------
 9 files changed, 208 insertions(+), 210 deletions(-)
 delete mode 100644 lib/toaster/contrib/tts/scratchpad.py

diff --git a/lib/toaster/contrib/tts/config.py b/lib/toaster/contrib/tts/config.py
index c0e0536..40d45f3 100644
--- a/lib/toaster/contrib/tts/config.py
+++ b/lib/toaster/contrib/tts/config.py
@@ -28,42 +28,48 @@ LOGDIR = "log"
 SETTINGS_FILE = os.path.join(os.path.dirname(__file__), "settings.json")
 TEST_DIR_NAME = "tts_testdir"
 
+DEBUG = True
+
 OWN_PID = os.getpid()
 
 W3C_VALIDATOR = "http://icarus.local/w3c-validator/check?doctype=HTML5&uri="
 
-#TODO assign port dynamically
-TOASTER_PORT=56789
+TOASTER_PORT = 56789
+
+TESTDIR = None
 
 #we parse the w3c URL to know where to connect
 
 import urlparse
 
 def get_public_ip():
-    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
-    p = urlparse.urlparse("http://icarus.local/w3c-validator/check?doctype=HTML5&uri=")
-    s.connect(( p.netloc, 80 if p.port is None else p.port))
-    hn = s.getsockname()[0]
-    s.close()
-    return hn
+    temp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+    parsed_url = urlparse.urlparse("http://icarus.local/w3c-validator/check?doctype=HTML5&uri=")
+    temp_socket.connect((parsed_url.netloc, 80 if parsed_url.port is None else parsed_url.port))
+    public_ip = temp_socket.getsockname()[0]
+    temp_socket.close()
+    return public_ip
 
-TOASTER_BASEURL="http://%s:%d/" % (get_public_ip(), TOASTER_PORT)
+TOASTER_BASEURL = "http://%s:%d/" % (get_public_ip(), TOASTER_PORT)
 
 
 OWN_EMAIL_ADDRESS = "Toaster Testing Framework <alexandru.damian@intel.com>"
 REPORT_EMAIL_ADDRESS = "alexandru.damian@intel.com"
 
 # make sure we have the basic logging infrastructure
+
+#pylint: disable=invalid-name
+# we disable the invalid name because the module-level "logger" is used througout bitbake
 logger = logging.getLogger("toastertest")
-__console = logging.StreamHandler(sys.stdout)
-__console.setFormatter(logging.Formatter("%(asctime)s %(levelname)s: %(message)s"))
-logger.addHandler(__console)
+__console__ = logging.StreamHandler(sys.stdout)
+__console__.setFormatter(logging.Formatter("%(asctime)s %(levelname)s: %(message)s"))
+logger.addHandler(__console__)
 logger.setLevel(logging.DEBUG)
 
 
 # singleton file names
-LOCKFILE="/tmp/ttf.lock"
-BACKLOGFILE=os.path.join(os.path.dirname(__file__), "backlog.txt")
+LOCKFILE = "/tmp/ttf.lock"
+BACKLOGFILE = os.path.join(os.path.dirname(__file__), "backlog.txt")
 
 # task states
 def enum(*sequential, **named):
@@ -73,7 +79,8 @@ def enum(*sequential, **named):
     return type('Enum', (), enums)
 
 
-class TASKS:
+class TASKS(object):
+    #pylint: disable=too-few-public-methods
     PENDING = "PENDING"
     INPROGRESS = "INPROGRESS"
     DONE = "DONE"
diff --git a/lib/toaster/contrib/tts/launcher.py b/lib/toaster/contrib/tts/launcher.py
index 90c6d95..e5794c1 100755
--- a/lib/toaster/contrib/tts/launcher.py
+++ b/lib/toaster/contrib/tts/launcher.py
@@ -31,13 +31,11 @@ import smtplib
 # Import the email modules we'll need
 from email.mime.text import MIMEText
 
-DEBUG=True
-
 def _take_lockfile():
     return shellutils.lockfile(shellutils.mk_lock_filename())
 
 
-def read_next_task_by_state(task_state, task_name = None):
+def read_next_task_by_state(task_state, task_name=None):
     if not os.path.exists(os.path.join(os.path.dirname(__file__), config.BACKLOGFILE)):
         return None
     os.rename(config.BACKLOGFILE, config.BACKLOGFILE + ".tmp")
@@ -56,28 +54,28 @@ def read_next_task_by_state(task_state, task_name = None):
     os.remove(config.BACKLOGFILE + ".tmp")
     return task
 
-def send_report(task_name, plaintext, errtext = None):
+def send_report(task_name, plaintext, errtext=None):
     if errtext is None:
         msg = MIMEText(plaintext)
     else:
         if plaintext is None:
-            plaintext=""
+            plaintext = ""
         msg = MIMEText("--STDOUT dump--\n\n%s\n\n--STDERR dump--\n\n%s" % (plaintext, errtext))
 
     msg['Subject'] = "[review-request] %s - smoke test results" % task_name
     msg['From'] = config.OWN_EMAIL_ADDRESS
     msg['To'] = config.REPORT_EMAIL_ADDRESS
 
-    s = smtplib.SMTP("localhost")
-    s.sendmail(config.OWN_EMAIL_ADDRESS, [config.REPORT_EMAIL_ADDRESS], msg.as_string())
-    s.quit()
+    smtp_connection = smtplib.SMTP("localhost")
+    smtp_connection.sendmail(config.OWN_EMAIL_ADDRESS, [config.REPORT_EMAIL_ADDRESS], msg.as_string())
+    smtp_connection.quit()
 
-if __name__ == "__main__":
+def main():
     # we don't do anything if we have another instance of us running
-    lf = _take_lockfile()
+    lock_file = _take_lockfile()
 
-    if lf is None:
-        if DEBUG:
+    if lock_file is None:
+        if config.DEBUG:
             print("Concurrent script in progress, exiting")
         sys.exit(1)
 
@@ -88,13 +86,16 @@ if __name__ == "__main__":
         out = None
         try:
             out = shellutils.run_shell_cmd("%s %s" % (os.path.join(os.path.dirname(__file__), "runner.py"), next_task))
-            pass
-        except ShellCmdException as e:
-            print("Failed while running the test runner: %s", e)
-            errtext = e.__str__()
+        except ShellCmdException as exc:
+            print("Failed while running the test runner: %s", exc)
+            errtext = exc.__str__()
         send_report(next_task, out, errtext)
         read_next_task_by_state(config.TASKS.INPROGRESS, next_task)
     else:
         print("No task")
 
-    shellutils.unlockfile(lf)
+    shellutils.unlockfile(lock_file)
+
+
+if __name__ == "__main__":
+    main()
diff --git a/lib/toaster/contrib/tts/recv.py b/lib/toaster/contrib/tts/recv.py
index 168294a..2faf8d0 100755
--- a/lib/toaster/contrib/tts/recv.py
+++ b/lib/toaster/contrib/tts/recv.py
@@ -26,7 +26,6 @@
 
 from __future__ import print_function
 import sys, os, config, shellutils
-from shellutils import ShellCmdException
 
 from email.parser import Parser
 
@@ -34,9 +33,13 @@ def recv_mail(datastring):
     headers = Parser().parsestr(datastring)
     return headers['subject']
 
+def main():
+    lock_file = shellutils.lockfile(shellutils.mk_lock_filename(), retry=True)
 
-if __name__ == "__main__":
-    lf = shellutils.lockfile(shellutils.mk_lock_filename(), retry = True)
+    if lock_file is None:
+        if config.DEBUG:
+            print("Concurrent script in progress, exiting")
+        sys.exit(1)
 
     subject = recv_mail(sys.stdin.read())
 
@@ -47,5 +50,7 @@ if __name__ == "__main__":
             line = "%s|%s\n" % (task_name, config.TASKS.PENDING)
             fout.write(line)
 
-    shellutils.unlockfile(lf)
+    shellutils.unlockfile(lock_file)
 
+if __name__ == "__main__":
+    main()
diff --git a/lib/toaster/contrib/tts/runner.py b/lib/toaster/contrib/tts/runner.py
index e7e4dd2..809fb35 100755
--- a/lib/toaster/contrib/tts/runner.py
+++ b/lib/toaster/contrib/tts/runner.py
@@ -28,24 +28,22 @@
 
 
 from __future__ import print_function
-import optparse
 import sys, os
-import unittest, inspect, importlib
+import unittest, importlib
 import logging, pprint, json
 
-from shellutils import *
+from shellutils import ShellCmdException, mkdirhier, run_shell_cmd
 
 import config
 
 # we also log to a file, in addition to console, because our output is important
-__log_file_name =os.path.join(os.path.dirname(__file__),"log/tts_%d.log" % config.OWN_PID)
-mkdirhier(os.path.dirname(__log_file_name))
-__log_file = open(__log_file_name, "w")
-__file_handler = logging.StreamHandler(__log_file)
-__file_handler.setFormatter(logging.Formatter("%(asctime)s %(levelname)s: %(message)s"))
-
-config.logger.addHandler(__file_handler)
+__log_file_name__ = os.path.join(os.path.dirname(__file__), "log/tts_%d.log" % config.OWN_PID)
+mkdirhier(os.path.dirname(__log_file_name__))
+__log_file__ = open(__log_file_name__, "w")
+__file_handler__ = logging.StreamHandler(__log_file__)
+__file_handler__.setFormatter(logging.Formatter("%(asctime)s %(levelname)s: %(message)s"))
 
+config.logger.addHandler(__file_handler__)
 
 # set up log directory
 try:
@@ -54,12 +52,12 @@ try:
     else:
         if not os.path.isdir(config.LOGDIR):
             raise Exception("Expected log dir '%s' is not actually a directory." % config.LOGDIR)
-except OSError as e:
-    raise e
+except OSError as exc:
+    raise exc
 
 # creates the under-test-branch as a separate directory
 def set_up_test_branch(settings, branch_name):
-    testdir = "%s/%s.%d" % (settings['workdir'], config.TEST_DIR_NAME,  config.OWN_PID)
+    testdir = "%s/%s.%d" % (settings['workdir'], config.TEST_DIR_NAME, config.OWN_PID)
 
     # creates the host dir
     if os.path.exists(testdir):
@@ -70,11 +68,11 @@ def set_up_test_branch(settings, branch_name):
     run_shell_cmd("cp -a '%s'/.git '%s'" % (settings['localclone'], testdir))
 
     # add the remote if it doesn't exist
-    crt_remotes = run_shell_cmd("git remote -v", cwd = testdir)
+    crt_remotes = run_shell_cmd("git remote -v", cwd=testdir)
     remotes = [word for line in crt_remotes.split("\n") for word in line.split()]
     if not config.CONTRIB_REPO in remotes:
         remote_name = "tts_contrib"
-        run_shell_cmd("git remote add %s %s" % (remote_name, config.CONTRIB_REPO), cwd = testdir)
+        run_shell_cmd("git remote add %s %s" % (remote_name, config.CONTRIB_REPO), cwd=testdir)
     else:
         remote_name = remotes[remotes.index(config.CONTRIB_REPO) - 1]
 
@@ -82,7 +80,7 @@ def set_up_test_branch(settings, branch_name):
     run_shell_cmd("git fetch %s -p" % remote_name, cwd=testdir)
 
     # do the checkout
-    run_shell_cmd("git checkout origin/master && git branch -D %s; git checkout %s/%s -b %s && git reset --hard" % (branch_name,remote_name,branch_name,branch_name), cwd=testdir)
+    run_shell_cmd("git checkout origin/master && git branch -D %s; git checkout %s/%s -b %s && git reset --hard" % (branch_name, remote_name, branch_name, branch_name), cwd=testdir)
 
     return testdir
 
@@ -90,15 +88,15 @@ def set_up_test_branch(settings, branch_name):
 def __search_for_tests():
     # we find all classes that can run, and run them
     tests = []
-    for dir_name, dirs_list, files_list in os.walk(os.path.dirname(os.path.abspath(__file__))):
-        for f in [f[:-3] for f in files_list if f.endswith(".py") and not f.startswith("__init__")]:
-            config.logger.debug("Inspecting module %s", f)
-            current_module = importlib.import_module(f)
+    for _, _, files_list in os.walk(os.path.dirname(os.path.abspath(__file__))):
+        for module_file in [f[:-3] for f in files_list if f.endswith(".py") and not f.startswith("__init__")]:
+            config.logger.debug("Inspecting module %s", module_file)
+            current_module = importlib.import_module(module_file)
             crtclass_names = vars(current_module)
-            for v in crtclass_names:
-                t = crtclass_names[v]
-                if isinstance(t, type(unittest.TestCase)) and issubclass(t, unittest.TestCase):
-                    tests.append((f,v))
+            for name in crtclass_names:
+                tested_value = crtclass_names[name]
+                if isinstance(tested_value, type(unittest.TestCase)) and issubclass(tested_value, unittest.TestCase):
+                    tests.append((module_file, name))
         break
     return tests
 
@@ -117,27 +115,31 @@ def execute_tests(dir_under_test, testname):
     os.chdir(dir_under_test)
 
     # execute each module
+    # pylint: disable=broad-except
+    # we disable the broad-except because we want to actually catch all possible exceptions
     try:
-        config.logger.debug("Discovered test clases: %s" % pprint.pformat(tests))
+        config.logger.debug("Discovered test clases: %s", pprint.pformat(tests))
         suite = unittest.TestSuite()
         loader = unittest.TestLoader()
         result = unittest.TestResult()
-        for m,t in tests:
-            suite.addTest(loader.loadTestsFromName("%s.%s" % (m,t)))
+        for module_file, name in tests:
+            suite.addTest(loader.loadTestsFromName("%s.%s" % (module_file, name)))
         config.logger.info("Running %d test(s)", suite.countTestCases())
         suite.run(result)
 
-        if len(result.errors) > 0:
-            map(lambda x: config.logger.error("Exception on test: %s" % pprint.pformat(x)), result.errors)
+        for error in result.errors:
+            config.logger.error("Exception on test: %s\n%s", error[0],
+                                "\n".join(["-- %s" % x for x in error[1].split("\n")]))
 
-        if len(result.failures) > 0:
-            map(lambda x: config.logger.error("Failed test: %s:\n%s\n" % (pprint.pformat(x[0]), "\n".join(["--  %s" % x for x in eval(pprint.pformat(x[1])).split("\n")]))), result.failures)
+        for failure in result.failures:
+            config.logger.error("Failed test: %s:\n%s\n", failure[0],
+                                "\n".join(["--  %s" % x for x in failure[1].split("\n")]))
 
-        config.logger.info("Test results: %d ran, %d errors, %d failures"  % (result.testsRun, len(result.errors), len(result.failures)))
+        config.logger.info("Test results: %d ran, %d errors, %d failures", result.testsRun, len(result.errors), len(result.failures))
 
-    except Exception as e:
+    except Exception as exc:
         import traceback
-        config.logger.error("Exception while running test. Tracedump: \n%s", traceback.format_exc(e))
+        config.logger.error("Exception while running test. Tracedump: \n%s", traceback.format_exc(exc))
     finally:
         os.chdir(crt_dir)
     return len(result.failures)
@@ -161,17 +163,15 @@ def validate_args():
 # load the configuration options
 def read_settings():
     if not os.path.exists(config.SETTINGS_FILE) or not os.path.isfile(config.SETTINGS_FILE):
-        raise Exception("Config file '%s' cannot be openend" % config.SETTINGS_FILE);
+        raise Exception("Config file '%s' cannot be openend" % config.SETTINGS_FILE)
     return json.loads(open(config.SETTINGS_FILE, "r").read())
 
 
 # cleanup !
 def clean_up(testdir):
-    # TODO: delete the test dir
     run_shell_cmd("rm -rf -- '%s'" % testdir)
-    pass
 
-if __name__ == "__main__":
+def main():
     (options, args) = validate_args()
 
     settings = read_settings()
@@ -182,19 +182,22 @@ if __name__ == "__main__":
     try:
         if options.testdir is not None and os.path.exists(options.testdir):
             testdir = os.path.abspath(options.testdir)
-            config.logger.info("No checkout, using %s" % testdir)
+            config.logger.info("No checkout, using %s", testdir)
         else:
             need_cleanup = True
             testdir = set_up_test_branch(settings, args[0]) # we expect a branch name as first argument
 
-        config.testdir = testdir    # we let tests know where to run
+        config.TESTDIR = testdir    # we let tests know where to run
         no_failures = execute_tests(testdir, options.singletest)
 
-    except ShellCmdException as e :
+    except ShellCmdException as exc:
         import traceback
-        config.logger.error("Error while setting up testing. Traceback: \n%s" % traceback.format_exc(e))
+        config.logger.error("Error while setting up testing. Traceback: \n%s", traceback.format_exc(exc))
     finally:
         if need_cleanup and testdir is not None:
             clean_up(testdir)
 
     sys.exit(no_failures)
+
+if __name__ == "__main__":
+    main()
diff --git a/lib/toaster/contrib/tts/scratchpad.py b/lib/toaster/contrib/tts/scratchpad.py
deleted file mode 100644
index b276fb5..0000000
--- a/lib/toaster/contrib/tts/scratchpad.py
+++ /dev/null
@@ -1,20 +0,0 @@
-import config
-
-# Code testing section
-def _code_test():
-    def callback_writeeventlog(opt, opt_str, value, parser):
-        if len(parser.rargs) < 1 or parser.rargs[0].startswith("-"):
-            value = ""
-        else:
-            value = parser.rargs[0]
-            del parser.rargs[0]
-
-        setattr(parser.values, opt.dest, value)
-
-    parser = optparse.OptionParser()
-    parser.add_option("-w", "--write-log", help = "Writes the event log of the build to a bitbake event json file.",
-                       action = "callback", callback=callback_writeeventlog, dest = "writeeventlog")
-
-    options, targets = parser.parse_args(sys.argv)
-
-    print (options, targets)
diff --git a/lib/toaster/contrib/tts/shellutils.py b/lib/toaster/contrib/tts/shellutils.py
index 2b7f0f1..c2012ed 100644
--- a/lib/toaster/contrib/tts/shellutils.py
+++ b/lib/toaster/contrib/tts/shellutils.py
@@ -37,16 +37,16 @@ def mkdirhier(directory):
 
     try:
         os.makedirs(directory)
-    except OSError as e:
-        if e.errno != errno.EEXIST:
-            raise e
+    except OSError as exc:
+        if exc.errno != errno.EEXIST:
+            raise exc
 
 def lockfile(name, shared=False, retry=True):
     """
     Use the file fn as a lock file, return when the lock has been acquired.
     Returns a variable to pass to unlockfile().
     """
-    config.logger.debug("take lockfile %s" % name)
+    config.logger.debug("take lockfile %s", name)
     dirname = os.path.dirname(name)
     mkdirhier(dirname)
 
@@ -55,11 +55,11 @@ def lockfile(name, shared=False, retry=True):
                      name)
         sys.exit(1)
 
-    op = fcntl.LOCK_EX
+    operation = fcntl.LOCK_EX
     if shared:
-        op = fcntl.LOCK_SH
+        operation = fcntl.LOCK_SH
     if not retry:
-        op = op | fcntl.LOCK_NB
+        operation = operation | fcntl.LOCK_NB
 
     while True:
         # If we leave the lockfiles lying around there is no problem
@@ -72,38 +72,40 @@ def lockfile(name, shared=False, retry=True):
         # This implementation is unfair since the last person to request the
         # lock is the most likely to win it.
 
+        # pylint: disable=broad-except
+        # we disable the broad-except because we want to actually catch all possible exceptions
         try:
-            lf = open(name, 'a+')
-            fileno = lf.fileno()
-            fcntl.flock(fileno, op)
+            lock_file = open(name, 'a+')
+            fileno = lock_file.fileno()
+            fcntl.flock(fileno, operation)
             statinfo = os.fstat(fileno)
-            if os.path.exists(lf.name):
-                statinfo2 = os.stat(lf.name)
+            if os.path.exists(lock_file.name):
+                statinfo2 = os.stat(lock_file.name)
                 if statinfo.st_ino == statinfo2.st_ino:
-                    return lf
-            lf.close()
-        except Exception:
+                    return lock_file
+            lock_file.close()
+        except Exception as exc:
             try:
-                lf.close()
-            except Exception:
-                pass
-            pass
+                lock_file.close()
+            except Exception as exc2:
+                config.logger.error("Failed to close the lockfile: %s", exc2)
+            config.logger.error("Failed to acquire the lockfile: %s", exc)
         if not retry:
             return None
 
-def unlockfile(lf):
+def unlockfile(lock_file):
     """
     Unlock a file locked using lockfile()
     """
     try:
         # If we had a shared lock, we need to promote to exclusive before
         # removing the lockfile. Attempt this, ignore failures.
-        fcntl.flock(lf.fileno(), fcntl.LOCK_EX|fcntl.LOCK_NB)
-        os.unlink(lf.name)
+        fcntl.flock(lock_file.fileno(), fcntl.LOCK_EX|fcntl.LOCK_NB)
+        os.unlink(lock_file.name)
     except (IOError, OSError):
         pass
-    fcntl.flock(lf.fileno(), fcntl.LOCK_UN)
-    lf.close()
+    fcntl.flock(lock_file.fileno(), fcntl.LOCK_UN)
+    lock_file.close()
 
 #ENDOFCOPY
 
@@ -118,20 +120,20 @@ def mk_lock_filename():
 class ShellCmdException(Exception):
     pass
 
-def run_shell_cmd(command, cwd = None):
+def run_shell_cmd(command, cwd=None):
     if cwd is None:
         cwd = os.getcwd()
 
-    config.logger.debug("_shellcmd: (%s) %s" % (cwd, command))
-    p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
-    (out,err) = p.communicate()
-    p.wait()
-    if p.returncode:
+    config.logger.debug("_shellcmd: (%s) %s", cwd, command)
+    process = subprocess.Popen(command, cwd=cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+    (out, err) = process.communicate()
+    process.wait()
+    if process.returncode:
         if len(err) == 0:
             err = "command: %s \n%s" % (command, out)
         else:
             err = "command: %s \n%s" % (command, err)
-        config.logger.warn("_shellcmd: error \n%s\n%s" % (out, err))
+        config.logger.warn("_shellcmd: error \n%s\n%s", out, err)
         raise ShellCmdException(err)
     else:
         #config.logger.debug("localhostbecontroller: shellcmd success\n%s" % out)
diff --git a/lib/toaster/contrib/tts/tests.py b/lib/toaster/contrib/tts/tests.py
index 15a9a87..eb91947 100644
--- a/lib/toaster/contrib/tts/tests.py
+++ b/lib/toaster/contrib/tts/tests.py
@@ -24,7 +24,8 @@
 # as this file.
 
 import unittest
-from shellutils import *
+from shellutils import run_shell_cmd, ShellCmdException
+import config
 
 import pexpect
 import sys, os, signal, time
@@ -33,12 +34,9 @@ class TestPyCompilable(unittest.TestCase):
     ''' Verifies that all Python files are syntactically correct '''
     def test_compile_file(self):
         try:
-            out = run_shell_cmd("find . -name *py -type f -print0 | xargs -0 -n1 -P20 python -m py_compile", config.testdir)
-        except ShellCmdException as e:
-            self.fail("Error compiling python files: %s" % (e))
-        except Exception as e:
-            self.fail("Unknown error: %s" % e)
-
+            run_shell_cmd("find . -name *py -type f -print0 | xargs -0 -n1 -P20 python -m py_compile", config.TESTDIR)
+        except ShellCmdException as exc:
+            self.fail("Error compiling python files: %s" % (exc))
 
 class TestPySystemStart(unittest.TestCase):
     ''' Attempts to start Toaster, verify that it is succesfull, and stop it '''
@@ -47,29 +45,28 @@ class TestPySystemStart(unittest.TestCase):
 
     def test_start_interactive_mode(self):
         try:
-            run_shell_cmd("bash -c 'source %s/oe-init-build-env && source toaster start webport=%d && source toaster stop'" % (config.testdir, config.TOASTER_PORT), config.testdir)
-        except ShellCmdException as e:
-            self.fail("Failed starting interactive mode: %s" % (e))
+            run_shell_cmd("bash -c 'source %s/oe-init-build-env && source toaster start webport=%d && source toaster stop'" % (config.TESTDIR, config.TOASTER_PORT), config.TESTDIR)
+        except ShellCmdException as exc:
+            self.fail("Failed starting interactive mode: %s" % (exc))
 
     def test_start_managed_mode(self):
         try:
-            run_shell_cmd("%s/bitbake/bin/toaster webport=%d nobrowser & sleep 10 && curl http://localhost:%d/ && kill -2 %1" % (config.testdir, config.TOASTER_PORT, config.TOASTER_PORT), config.testdir)
-            pass
-        except ShellCmdException as e:
-            self.fail("Failed starting managed mode: %s" % (e))
+            run_shell_cmd("%s/bitbake/bin/toaster webport=%d nobrowser & sleep 10 && curl http://localhost:%d/ && kill -2 %%1" % (config.TESTDIR, config.TOASTER_PORT, config.TOASTER_PORT), config.TESTDIR)
+        except ShellCmdException as exc:
+            self.fail("Failed starting managed mode: %s" % (exc))
 
 class TestHTML5Compliance(unittest.TestCase):
     def setUp(self):
         self.origdir = os.getcwd()
-        self.crtdir = os.path.dirname(config.testdir)
+        self.crtdir = os.path.dirname(config.TESTDIR)
         os.chdir(self.crtdir)
         if not os.path.exists(os.path.join(self.crtdir, "toaster.sqlite")):
-            run_shell_cmd("%s/bitbake/lib/toaster/manage.py syncdb --noinput" % config.testdir)
-            run_shell_cmd("%s/bitbake/lib/toaster/manage.py migrate orm" % config.testdir)
-            run_shell_cmd("%s/bitbake/lib/toaster/manage.py migrate bldcontrol" % config.testdir)
-            run_shell_cmd("%s/bitbake/lib/toaster/manage.py loadconf %s/meta-yocto/conf/toasterconf.json" % (config.testdir, config.testdir))
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py syncdb --noinput" % config.TESTDIR)
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py migrate orm" % config.TESTDIR)
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py migrate bldcontrol" % config.TESTDIR)
+            run_shell_cmd("%s/bitbake/lib/toaster/manage.py loadconf %s/meta-yocto/conf/toasterconf.json" % (config.TESTDIR, config.TESTDIR))
 
-            setup = pexpect.spawn("%s/bitbake/lib/toaster/manage.py checksettings" % config.testdir)
+            setup = pexpect.spawn("%s/bitbake/lib/toaster/manage.py checksettings" % config.TESTDIR)
             setup.logfile = sys.stdout
             setup.expect(r".*or type the full path to a different directory: ")
             setup.sendline('')
@@ -79,8 +76,8 @@ class TestHTML5Compliance(unittest.TestCase):
             setup.expect(r"Enter your option: ")
             setup.sendline('0')
 
-        self.child = pexpect.spawn("%s/bitbake/bin/toaster webport=%d nobrowser" % (config.testdir, config.TOASTER_PORT))
-        self.child.logfile=sys.stdout
+        self.child = pexpect.spawn("%s/bitbake/bin/toaster webport=%d nobrowser" % (config.TESTDIR, config.TOASTER_PORT))
+        self.child.logfile = sys.stdout
         self.child.expect("Toaster is now running. You can stop it with Ctrl-C")
 
     def test_html5_compliance(self):
@@ -95,7 +92,7 @@ class TestHTML5Compliance(unittest.TestCase):
                 failed.append((url, results[url]))
 
 
-        self.assertTrue(len(failed)== 0, "Not all URLs validate: \n%s " % "\n".join(map(lambda x: "".join(str(x)),failed)))
+        self.assertTrue(len(failed) == 0, "Not all URLs validate: \n%s " % "\n".join(["".join(str(x)) for x in failed]))
 
         #(config.TOASTER_BASEURL + url, status, errors, warnings))
 
diff --git a/lib/toaster/contrib/tts/urlcheck.py b/lib/toaster/contrib/tts/urlcheck.py
index 86d7caa..8514de8 100644
--- a/lib/toaster/contrib/tts/urlcheck.py
+++ b/lib/toaster/contrib/tts/urlcheck.py
@@ -2,40 +2,45 @@ from __future__ import print_function
 import sys
 
 import httplib2
-import time
 
 import config
 import urllist
 
 
-# TODO: turn to a test
 def validate_html5(url):
-    h = httplib2.Http(".cache")
+    http_client = httplib2.Http(None)
     status = "Failed"
     errors = -1
     warnings = -1
 
-    # TODO: the w3c-validator must be a configurable setting
     urlrequest = config.W3C_VALIDATOR+url
+
+    # pylint: disable=broad-except
+    # we disable the broad-except because we want to actually catch all possible exceptions
     try:
-        resp, content = h.request(urlrequest, "HEAD")
+        resp, _ = http_client.request(urlrequest, "HEAD")
         if resp['x-w3c-validator-status'] != "Abort":
             status = resp['x-w3c-validator-status']
             errors = int(resp['x-w3c-validator-errors'])
             warnings = int(resp['x-w3c-validator-warnings'])
-    except Exception as e:
-        config.logger.warn("Failed validation call: %s" % e.__str__())
+    except Exception as exc:
+        config.logger.warn("Failed validation call: %s", exc)
     return (status, errors, warnings)
 
-if __name__ == "__main__":
-    print("Testing %s with %s" % (config.TOASTER_BASEURL, config.W3C_VALIDATOR))
 
-    def print_validation(url):
-        status, errors, warnings = validate_html5(url)
-        config.logger.error("url %s is %s\terrors %s warnings %s (check at %s)" % (url, status, errors, warnings, config.W3C_VALIDATOR+url))
+def print_validation(url):
+    status, errors, warnings = validate_html5(url)
+    config.logger.error("url %s is %s\terrors %s warnings %s (check at %s)", url, status, errors, warnings, config.W3C_VALIDATOR+url)
+
+
+def main():
+    print("Testing %s with %s" % (config.TOASTER_BASEURL, config.W3C_VALIDATOR))
 
     if len(sys.argv) > 1:
         print_validation(sys.argv[1])
     else:
         for url in urllist.URLS:
             print_validation(config.TOASTER_BASEURL+url)
+
+if __name__ == "__main__":
+    main()
diff --git a/lib/toaster/contrib/tts/urllist.py b/lib/toaster/contrib/tts/urllist.py
index 0226334..3f3a7c2 100644
--- a/lib/toaster/contrib/tts/urllist.py
+++ b/lib/toaster/contrib/tts/urllist.py
@@ -1,48 +1,46 @@
-import config
-
 URLS = [
-'toastergui/landing/',
-'toastergui/builds/',
-'toastergui/build/1',
-'toastergui/build/1/tasks/',
-'toastergui/build/1/tasks/1/',
-'toastergui/build/1/task/1',
-'toastergui/build/1/recipes/',
-'toastergui/build/1/recipe/1/active_tab/1',
-'toastergui/build/1/recipe/1',
-'toastergui/build/1/recipe_packages/1',
-'toastergui/build/1/packages/',
-'toastergui/build/1/package/1',
-'toastergui/build/1/package_built_dependencies/1',
-'toastergui/build/1/package_included_detail/1/1',
-'toastergui/build/1/package_included_dependencies/1/1',
-'toastergui/build/1/package_included_reverse_dependencies/1/1',
-'toastergui/build/1/target/1',
-'toastergui/build/1/target/1/targetpkg',
-'toastergui/dentries/build/1/target/1',
-'toastergui/build/1/target/1/dirinfo',
-'toastergui/build/1/target/1/dirinfo_filepath/_/bin/bash',
-'toastergui/build/1/configuration',
-'toastergui/build/1/configvars',
-'toastergui/build/1/buildtime',
-'toastergui/build/1/cpuusage',
-'toastergui/build/1/diskio',
-'toastergui/build/1/target/1/packagefile/1',
-'toastergui/newproject/',
-'toastergui/projects/',
-'toastergui/project/',
-'toastergui/project/1',
-'toastergui/project/1/configuration',
-'toastergui/project/1/builds/',
-'toastergui/project/1/layers/',
-'toastergui/project/1/layer/1',
-'toastergui/project/1/layer/',
-'toastergui/project/1/importlayer',
-'toastergui/project/1/targets/',
-'toastergui/project/1/machines/',
-'toastergui/xhr_configvaredit/1',
-'toastergui/xhr_importlayer/',
-'toastergui/xhr_updatelayer/',
-'toastergui/project/1/buildrequest/1',
-'toastergui/',
+    'toastergui/landing/',
+    'toastergui/builds/',
+    'toastergui/build/1',
+    'toastergui/build/1/tasks/',
+    'toastergui/build/1/tasks/1/',
+    'toastergui/build/1/task/1',
+    'toastergui/build/1/recipes/',
+    'toastergui/build/1/recipe/1/active_tab/1',
+    'toastergui/build/1/recipe/1',
+    'toastergui/build/1/recipe_packages/1',
+    'toastergui/build/1/packages/',
+    'toastergui/build/1/package/1',
+    'toastergui/build/1/package_built_dependencies/1',
+    'toastergui/build/1/package_included_detail/1/1',
+    'toastergui/build/1/package_included_dependencies/1/1',
+    'toastergui/build/1/package_included_reverse_dependencies/1/1',
+    'toastergui/build/1/target/1',
+    'toastergui/build/1/target/1/targetpkg',
+    'toastergui/dentries/build/1/target/1',
+    'toastergui/build/1/target/1/dirinfo',
+    'toastergui/build/1/target/1/dirinfo_filepath/_/bin/bash',
+    'toastergui/build/1/configuration',
+    'toastergui/build/1/configvars',
+    'toastergui/build/1/buildtime',
+    'toastergui/build/1/cpuusage',
+    'toastergui/build/1/diskio',
+    'toastergui/build/1/target/1/packagefile/1',
+    'toastergui/newproject/',
+    'toastergui/projects/',
+    'toastergui/project/',
+    'toastergui/project/1',
+    'toastergui/project/1/configuration',
+    'toastergui/project/1/builds/',
+    'toastergui/project/1/layers/',
+    'toastergui/project/1/layer/1',
+    'toastergui/project/1/layer/',
+    'toastergui/project/1/importlayer',
+    'toastergui/project/1/targets/',
+    'toastergui/project/1/machines/',
+    'toastergui/xhr_configvaredit/1',
+    'toastergui/xhr_importlayer/',
+    'toastergui/xhr_updatelayer/',
+    'toastergui/project/1/buildrequest/1',
+    'toastergui/',
 ]
-- 
2.1.4


