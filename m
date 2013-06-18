Return-Path: <calinx.l.dragomir@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8BEA66A961
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2013 11:49:03 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 18 Jun 2013 04:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,888,1363158000"; d="scan'208";a="355360926"
Received: from calin-desktop.rb.intel.com ([10.237.105.64])
	by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2013 04:49:02 -0700
From: Calin Dragomir <calinx.l.dragomir@intel.com>
To: webhob@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jun 2013 14:51:07 +0300
Message-Id: <1371556267-19628-3-git-send-email-calinx.l.dragomir@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371556267-19628-1-git-send-email-calinx.l.dragomir@intel.com>
References: <1371556267-19628-1-git-send-email-calinx.l.dragomir@intel.com>
Subject: [PATCH v2 3/3] bitbake: create Data Store Interface (DSI) file
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
X-List-Received-Date: Tue, 18 Jun 2013 11:49:03 -0000

The patch adds the first version of the DSI file. It uses the Knotty
code for now and inserts task related information into the database
using the Django ORM.
It makes use of some test objects needed to create a valid record into
the database based on the definition of the Django models.
---
 lib/bb/ui/dsi.py | 667 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 667 insertions(+)
 create mode 100644 lib/bb/ui/dsi.py

diff --git a/lib/bb/ui/dsi.py b/lib/bb/ui/dsi.py
new file mode 100644
index 0000000..f832806
--- /dev/null
+++ b/lib/bb/ui/dsi.py
@@ -0,0 +1,667 @@
+#
+# BitBake DSI Implementation
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+from __future__ import division
+
+import os
+import sys
+import xmlrpclib
+import logging
+import progressbar
+import signal
+import bb.msg
+import time
+import fcntl
+import struct
+import copy
+import datetime
+
+from bb.ui import uihelper
+
+logger = logging.getLogger("BitBake")
+interactive = sys.stdout.isatty()
+
+class WebHOBHelper(object):
+    
+    def __init__(self):
+        self.configure_django()
+        self.task_order = 0
+        self.tasks_information = {}
+
+    def configure_django(self):
+        import webhob.whbmain.settings as whb_django_settings
+        from django.core.management import setup_environ
+        setup_environ(whb_django_settings)
+        # Add webhob to sys path for importing modules
+        sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
+    
+    def store_build(self, uuid):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Builds, Machines, Layers
+        machine_obj = Machines.objects.create(
+                                name='Test Machine',
+                                description='This is our great test machine'
+                                )
+        machine_obj.save()
+
+        layer_obj = Layers.objects.create(
+                                name='Test Layer',
+                                branch='master_test',
+                                commit='2148u323nsau83smdmbnca3312f',
+                                priority=2,
+                                link_to_oe_core='http://test.oecore.com'
+                                )
+        layer_obj.save()
+
+        build_obj = Builds.objects.create(
+                                uuid=uuid,
+                                target='test target',
+                                host_machine='Host machine',
+                                distro='1.234',
+                                distro_version='v2',
+                                host_system='Test hosting system',
+                                host_distribution='Test host distrib',
+                                target_system=machine_obj,
+                                started_on=datetime.datetime.now(),
+                                completed_on=datetime.datetime.now(),
+                                outcome=3,
+                                errors_no=0,
+                                warnings_no=0,
+                                cpu_usage=54,
+                                disk_io=23.3232,
+                                cooker_log_path='/home/test/cooker_test',
+                                build_name='tester_build',
+                                bitbake_version='1.0.5')
+        build_obj.layers.add(layer_obj)
+        build_obj.save()
+
+        return build_obj, layer_obj
+
+    def store_started_task(self, event, build_object):
+        self.task_order += 1
+        identifier = event._package + event._task
+        self.tasks_information[identifier] = {
+                'uuid': build_object,
+                'task_executed': True,
+                'order': self.task_order,
+                'recipe': event._package,
+                'task_name': event._task,
+                'start_time': time.time(),
+                }
+
+    def write_stored_tasks(self, event, build_object, layer_object):
+        identifier = event._package + event._task
+
+        # fix this
+        if event.getDisplayName().lower() == 'succeded':
+            outcome = 0
+        else:
+            outcome = 1
+
+        self.tasks_information[identifier].update({
+                'outcome': outcome,
+                'end_time': time.time(),
+                })
+
+        task = self.tasks_information[identifier]
+
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Tasks, Recipes
+
+        recipe_obj = Recipes.objects.create(
+                                    name=task['recipe'],
+                                    version='1.0',
+                                    layer=layer_object,
+                                    summary='Short summary',
+                                    description='Longer description',
+                                    section='24',
+                                    license='license title',
+                                    licensing_info='longer license information',
+                                    homepage='http://homepage.com',
+                                    bugtracker='2456',
+                                    author='Mr.Test',
+                                    file_path='home/test/testproject/',
+                                    )
+
+        # Store finished task
+        task_obj = Tasks.objects.create(uuid=task['uuid'],
+                                        order=task['order'],
+                                        outcome=task['outcome'],
+                                        recipe=recipe_obj,
+                                        task_name=task['task_name'],
+                                        elapsed_time=task['end_time'] - task['start_time'],
+                                        # The next lines are just for testing reasons
+                                        sstate_checksum = '2134123sdscsdf232342tgfdv',
+                                        task_executed=True,
+                                        path_to_sstate_obj='/home/calin',
+                                        source_url='/',
+                                        log_file='/',
+                                        work_directory='/',
+                                        script_type=0,
+                                        file_path='/',
+                                        line_number=55,
+                                        py_stack_trace='Testing traceback',
+                                        disk_io = 23.55633,
+                                        cpu_usage=43,
+                                        errors_no=0,
+                                        warnings_no=0,
+                                        error='None',
+                                        warning='None',
+                                        sstate_result=0,
+                                        diffsigs="Testing diffsigs")
+        task_obj.save()
+        # Clean memory
+        del self.tasks_information[identifier]
+
+
+class BBProgress(progressbar.ProgressBar):
+    def __init__(self, msg, maxval):
+        self.msg = msg
+        widgets = [progressbar.Percentage(), ' ', progressbar.Bar(), ' ',
+           progressbar.ETA()]
+
+        try:
+            self._resize_default = signal.getsignal(signal.SIGWINCH)
+        except:
+            self._resize_default = None
+        progressbar.ProgressBar.__init__(self, maxval, [self.msg + ": "] + widgets)
+
+    def _handle_resize(self, signum, frame):
+        progressbar.ProgressBar._handle_resize(self, signum, frame)
+        if self._resize_default:
+            self._resize_default(signum, frame)
+    def finish(self):
+        progressbar.ProgressBar.finish(self)
+        if self._resize_default:
+            signal.signal(signal.SIGWINCH, self._resize_default)
+
+class NonInteractiveProgress(object):
+    fobj = sys.stdout
+
+    def __init__(self, msg, maxval):
+        self.msg = msg
+        self.maxval = maxval
+
+    def start(self):
+        self.fobj.write("%s..." % self.msg)
+        self.fobj.flush()
+        return self
+
+    def update(self, value):
+        pass
+
+    def finish(self):
+        self.fobj.write("done.\n")
+        self.fobj.flush()
+
+def new_progress(msg, maxval):
+    if interactive:
+        return BBProgress(msg, maxval)
+    else:
+        return NonInteractiveProgress(msg, maxval)
+
+def pluralise(singular, plural, qty):
+    if(qty == 1):
+        return singular % qty
+    else:
+        return plural % qty
+
+
+class InteractConsoleLogFilter(logging.Filter):
+    def __init__(self, tf, format):
+        self.tf = tf
+        self.format = format
+
+    def filter(self, record):
+        if record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ")):
+            return False
+        self.tf.clearFooter()
+        return True
+
+class TerminalFilter(object):
+    columns = 80
+
+    def sigwinch_handle(self, signum, frame):
+        self.columns = self.getTerminalColumns()
+        if self._sigwinch_default:
+            self._sigwinch_default(signum, frame)
+
+    def getTerminalColumns(self):
+        def ioctl_GWINSZ(fd):
+            try:
+                cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))
+            except:
+                return None
+            return cr
+        cr = ioctl_GWINSZ(sys.stdout.fileno())
+        if not cr:
+            try:
+                fd = os.open(os.ctermid(), os.O_RDONLY)
+                cr = ioctl_GWINSZ(fd)
+                os.close(fd)
+            except:
+                pass
+        if not cr:
+            try:
+                cr = (env['LINES'], env['COLUMNS'])
+            except:
+                cr = (25, 80)
+        return cr[1]
+
+    def __init__(self, main, helper, console, format):
+        self.main = main
+        self.helper = helper
+        self.cuu = None
+        self.stdinbackup = None
+        self.interactive = sys.stdout.isatty()
+        self.footer_present = False
+        self.lastpids = []
+
+        if not self.interactive:
+            return
+
+        try:
+            import curses
+        except ImportError:
+            sys.exit("FATAL: The knotty ui could not load the required curses python module.")
+
+        import termios
+        self.curses = curses
+        self.termios = termios
+        try:
+            fd = sys.stdin.fileno()
+            self.stdinbackup = termios.tcgetattr(fd)
+            new = copy.deepcopy(self.stdinbackup)
+            new[3] = new[3] & ~termios.ECHO
+            termios.tcsetattr(fd, termios.TCSADRAIN, new)
+            curses.setupterm()
+            if curses.tigetnum("colors") > 2:
+                format.enable_color()
+            self.ed = curses.tigetstr("ed")
+            if self.ed:
+                self.cuu = curses.tigetstr("cuu")
+            try:
+                self._sigwinch_default = signal.getsignal(signal.SIGWINCH)
+                signal.signal(signal.SIGWINCH, self.sigwinch_handle)
+            except:
+                pass
+            self.columns = self.getTerminalColumns()
+        except:
+            self.cuu = None
+        console.addFilter(InteractConsoleLogFilter(self, format))
+
+    def clearFooter(self):
+        if self.footer_present:
+            lines = self.footer_present
+            sys.stdout.write(self.curses.tparm(self.cuu, lines))
+            sys.stdout.write(self.curses.tparm(self.ed))
+        self.footer_present = False
+
+    def updateFooter(self):
+        if not self.cuu:
+            return
+        activetasks = self.helper.running_tasks
+        failedtasks = self.helper.failed_tasks
+        runningpids = self.helper.running_pids
+        if self.footer_present and (self.lastcount == self.helper.tasknumber_current) and (self.lastpids == runningpids):
+            return
+        if self.footer_present:
+            self.clearFooter()
+        if (not self.helper.tasknumber_total or self.helper.tasknumber_current == self.helper.tasknumber_total) and not len(activetasks):
+            return
+        tasks = []
+        for t in runningpids:
+            tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
+
+        if self.main.shutdown:
+            content = "Waiting for %s running tasks to finish:" % len(activetasks)
+        elif not len(activetasks):
+            content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
+        else:
+            content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
+        print(content)
+        lines = 1 + int(len(content) / (self.columns + 1))
+        for tasknum, task in enumerate(tasks):
+            content = "%s: %s" % (tasknum, task)
+            print(content)
+            lines = lines + 1 + int(len(content) / (self.columns + 1))
+        self.footer_present = lines
+        self.lastpids = runningpids[:]
+        self.lastcount = self.helper.tasknumber_current
+
+    def finish(self):
+        if self.stdinbackup:
+            fd = sys.stdin.fileno()
+            self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
+
+def main(server, eventHandler, params, tf = TerminalFilter):
+    print "This is running in DSI mode"
+
+    # Generate an unique ID for this build
+    # TODO: for multiple build commands this might not work as expected
+    import uuid
+    uuid = sessionid = str(uuid.uuid4())
+
+    # Get values of variables which control our output
+    includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
+    if error:
+        logger.error("Unable to get the value of BBINCLUDELOGS variable: %s" % error)
+        return 1
+    loglines, error = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
+    if error:
+        logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
+        return 1
+    consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    if error:
+        logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
+        return 1
+
+    if sys.stdin.isatty() and sys.stdout.isatty():
+        log_exec_tty = True
+    else:
+        log_exec_tty = False
+
+    helper = uihelper.BBUIHelper()
+
+    console = logging.StreamHandler(sys.stdout)
+    format_str = "%(levelname)s: %(message)s"
+    format = bb.msg.BBLogFormatter(format_str)
+    bb.msg.addDefaultlogFilter(console)
+    console.setFormatter(format)
+    logger.addHandler(console)
+
+    if consolelogfile and not params.options.show_environment:
+        bb.utils.mkdirhier(os.path.dirname(consolelogfile))
+        conlogformat = bb.msg.BBLogFormatter(format_str)
+        consolelog = logging.FileHandler(consolelogfile)
+        bb.msg.addDefaultlogFilter(consolelog)
+        consolelog.setFormatter(conlogformat)
+        logger.addHandler(consolelog)
+
+    try:
+        params.updateFromServer(server)
+        cmdline = params.parseActions()
+        if not cmdline:
+            print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
+            return 1
+        if 'msg' in cmdline and cmdline['msg']:
+            logger.error(cmdline['msg'])
+            return 1
+
+        ret, error = server.runCommand(cmdline['action'])
+        if error:
+            logger.error("Command '%s' failed: %s" % (cmdline, error))
+            return 1
+        elif ret != True:
+            logger.error("Command '%s' failed: returned %s" % (cmdline, ret))
+            return 1
+    except xmlrpclib.Fault as x:
+        logger.error("XMLRPC Fault getting commandline:\n %s" % x)
+        return 1
+
+    parseprogress = None
+    cacheprogress = None
+    main.shutdown = 0
+    interrupted = False
+    return_value = 0
+    errors = 0
+    warnings = 0
+    taskfailures = []
+    wbhbhelper = WebHOBHelper()
+    build_object, layer_object = wbhbhelper.store_build(uuid)
+
+    termfilter = tf(main, helper, console, format)
+
+    while True:
+        try:
+            termfilter.updateFooter()
+            event = eventHandler.waitEvent(0.25)
+
+            if event is None:
+                if main.shutdown > 1:
+                    break
+                continue
+
+            helper.eventHandler(event)
+
+            if isinstance(event, bb.runqueue.runQueueExitWait):
+                if not main.shutdown:
+                    main.shutdown = 1
+
+            if isinstance(event, bb.build.TaskStarted):
+                wbhbhelper.store_started_task(event, build_object)
+
+            if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent, bb.build.TaskFailed)):
+                wbhbhelper.write_stored_tasks(event, build_object, layer_object)
+
+            if isinstance(event, bb.event.LogExecTTY):
+                if log_exec_tty:
+                    tries = event.retries
+                    while tries:
+                        print("Trying to run: %s" % event.prog)
+                        if os.system(event.prog) == 0:
+                            break
+                        time.sleep(event.sleep_delay)
+                        tries -= 1
+                    if tries:
+                        continue
+                logger.warn(event.msg)
+                continue
+
+            if isinstance(event, logging.LogRecord):
+                if event.levelno >= format.ERROR:
+                    errors = errors + 1
+                    return_value = 1
+                elif event.levelno == format.WARNING:
+                    warnings = warnings + 1
+                # For "normal" logging conditions, don't show note logs from tasks
+                # but do show them if the user has changed the default log level to 
+                # include verbose/debug messages
+                if event.taskpid != 0 and event.levelno <= format.NOTE:
+                    continue
+                logger.handle(event)
+                continue
+
+            if isinstance(event, bb.build.TaskFailed):
+                return_value = 1
+                logfile = event.logfile
+                if logfile and os.path.exists(logfile):
+                    termfilter.clearFooter()
+                    bb.error("Logfile of failure stored in: %s" % logfile)
+                    if includelogs and not event.errprinted:
+                        print("Log data follows:")
+                        f = open(logfile, "r")
+                        lines = []
+                        while True:
+                            l = f.readline()
+                            if l == '':
+                                break
+                            l = l.rstrip()
+                            if loglines:
+                                lines.append(' | %s' % l)
+                                if len(lines) > int(loglines):
+                                    lines.pop(0)
+                            else:
+                                print('| %s' % l)
+                        f.close()
+                        if lines:
+                            for line in lines:
+                                print(line)
+            if isinstance(event, bb.build.TaskBase):
+                logger.info(event._message)
+                continue
+            if isinstance(event, bb.event.ParseStarted):
+                if event.total == 0:
+                    continue
+                parseprogress = new_progress("Parsing recipes", event.total).start()
+                continue
+            if isinstance(event, bb.event.ParseProgress):
+                parseprogress.update(event.current)
+                continue
+            if isinstance(event, bb.event.ParseCompleted):
+                if not parseprogress:
+                    continue
+
+                parseprogress.finish()
+                print(("Parsing of %d .bb files complete (%d cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
+                    % ( event.total, event.cached, event.parsed, event.virtuals, event.skipped, event.masked, event.errors)))
+                continue
+
+            if isinstance(event, bb.event.CacheLoadStarted):
+                cacheprogress = new_progress("Loading cache", event.total).start()
+                continue
+            if isinstance(event, bb.event.CacheLoadProgress):
+                cacheprogress.update(event.current)
+                continue
+            if isinstance(event, bb.event.CacheLoadCompleted):
+                cacheprogress.finish()
+                print("Loaded %d entries from dependency cache." % event.num_entries)
+                continue
+
+            if isinstance(event, bb.event.MultipleProviders):
+                logger.info("multiple providers are available for %s%s (%s)", event._is_runtime and "runtime " or "",
+                            event._item,
+                            ", ".join(event._candidates))
+                logger.info("consider defining a PREFERRED_PROVIDER entry to match %s", event._item)
+                continue
+            if isinstance(event, bb.event.NoProvider):
+                return_value = 1
+                errors = errors + 1
+                if event._runtime:
+                    r = "R"
+                else:
+                    r = ""
+
+                if event._dependees:
+                    logger.error("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)", r, event._item, ", ".join(event._dependees), r)
+                else:
+                    logger.error("Nothing %sPROVIDES '%s'", r, event._item)
+                if event._reasons:
+                    for reason in event._reasons:
+                        logger.error("%s", reason)
+                continue
+
+            if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+                logger.info("Running setscene task %d of %d (%s)" % (event.stats.completed + event.stats.active + event.stats.failed + 1, event.stats.total, event.taskstring))
+                continue
+
+            if isinstance(event, bb.runqueue.runQueueTaskStarted):
+                if event.noexec:
+                    tasktype = 'noexec task'
+                else:
+                    tasktype = 'task'
+                logger.info("Running %s %s of %s (ID: %s, %s)",
+                            tasktype,
+                            event.stats.completed + event.stats.active +
+                                event.stats.failed + 1,
+                            event.stats.total, event.taskid, event.taskstring)
+                continue
+
+            if isinstance(event, bb.runqueue.runQueueTaskFailed):
+                taskfailures.append(event.taskstring)
+                logger.error("Task %s (%s) failed with exit code '%s'",
+                             event.taskid, event.taskstring, event.exitcode)
+                continue
+ 
+            if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
+                logger.warn("Setscene task %s (%s) failed with exit code '%s' - real task will be run instead",
+                             event.taskid, event.taskstring, event.exitcode)
+                continue
+
+            if isinstance(event, bb.event.ConfigParsed):
+                # timestamp should be added for this
+                continue
+            
+            if isinstance(event, bb.event.RecipeParsed):
+                # timestamp should be added for this
+                continue
+                
+            if isinstance(event, bb.event.OperationStarted):
+                # timestamp should be added for this
+                continue
+
+            if isinstance(event, bb.event.OperationCompleted):
+                # timestamp should be added for this
+                # signal a complete operation
+                # calculate timing
+                continue
+
+            if isinstance(event, bb.event.DiskFull):
+                # trigger an error
+                continue
+
+            # ignore
+            if isinstance(event, (bb.event.BuildBase,
+                                  bb.event.StampUpdate,
+                                  bb.event.RecipePreFinalise,
+                                  bb.runqueue.runQueueEvent,
+                                  bb.runqueue.runQueueExitWait,
+                                  bb.event.OperationProgress,
+                                  bb.command.CommandFailed,
+                                  bb.command.CommandExit,
+                                  bb.command.CommandCompleted,
+                                  bb.cooker.CookerExit)):
+                continue
+
+            logger.error("Unknown event: %s", event)
+
+        except EnvironmentError as ioerror:
+            termfilter.clearFooter()
+            # ignore interrupted io
+            if ioerror.args[0] == 4:
+                pass
+        except KeyboardInterrupt:
+            termfilter.clearFooter()
+            if main.shutdown == 1:
+                print("\nSecond Keyboard Interrupt, stopping...\n")
+                _, error = server.runCommand(["stateStop"])
+                if error:
+                    logger.error("Unable to cleanly stop: %s" % error)
+            if main.shutdown == 0:
+                print("\nKeyboard Interrupt, closing down...\n")
+                interrupted = True
+                _, error = server.runCommand(["stateShutdown"])
+                if error:
+                    logger.error("Unable to cleanly shutdown: %s" % error)
+            main.shutdown = main.shutdown + 1
+            pass
+
+    summary = ""
+    if taskfailures:
+        summary += pluralise("\nSummary: %s task failed:",
+                             "\nSummary: %s tasks failed:", len(taskfailures))
+        for failure in taskfailures:
+            summary += "\n  %s" % failure
+    if warnings:
+        summary += pluralise("\nSummary: There was %s WARNING message shown.",
+                             "\nSummary: There were %s WARNING messages shown.", warnings)
+    if return_value:
+        summary += pluralise("\nSummary: There was %s ERROR message shown, returning a non-zero exit code.",
+                             "\nSummary: There were %s ERROR messages shown, returning a non-zero exit code.", errors)
+    if summary:
+        print(summary)
+
+    if interrupted:
+        print("Execution was interrupted, returning a non-zero exit code.")
+        if return_value == 0:
+            return_value = 1
+
+    termfilter.finish()
+
+    return return_value
+
-- 
1.8.1.2


