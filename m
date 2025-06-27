Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9554AC77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 13:48:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.14123.1751032124653785191
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Jun 2025 06:48:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B30141A00
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 Jun 2025 06:48:26 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9273E3F66E
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 Jun 2025 06:48:43 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] tinfoil: add wait_for decorator and build_file_sync() helper
Date: Fri, 27 Jun 2025 14:48:37 +0100
Message-ID: <20250627134837.151783-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Jun 2025 13:48:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17720

The bitbake worker/server IPC is asynchronous, but tinfoil only has
functionality to wait for a response on the build_targets() call.

Extract the bulk of the "wait for events and handle errors" logic to a
standalone wait_for wrapper, which is the build_targets code without the
extra_events or event_callback arguments (for now).

Then use this to create a build_file_sync() helper that just wraps the
existing build_file() with @wait_for.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tinfoil.py | 135 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index f48baeb3342..e7fbcbca0a6 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -14,7 +14,7 @@ import time
 import atexit
 import re
 from collections import OrderedDict, defaultdict
-from functools import partial
+from functools import partial, wraps
 from contextlib import contextmanager
=20
 import bb.cache
@@ -27,6 +27,135 @@ import bb.remotedata
 from bb.main import setup_bitbake, BitBakeConfigParameters
 import bb.fetch2
=20
+def wait_for(f):
+    """
+    Wrap a function that makes an asynchronous tinfoil call using
+    self.run_command() and wait for events to say that the call has been
+    successful, or an error has occurred.
+    """
+    @wraps(f)
+    def wrapper(self, *args, handle_events=3DTrue, extra_events=3DNone, =
event_callback=3DNone, **kwargs):
+        if handle_events:
+            # A reasonable set of default events matching up with those =
we handle below
+            eventmask =3D [
+                        'bb.event.BuildStarted',
+                        'bb.event.BuildCompleted',
+                        'logging.LogRecord',
+                        'bb.event.NoProvider',
+                        'bb.command.CommandCompleted',
+                        'bb.command.CommandFailed',
+                        'bb.build.TaskStarted',
+                        'bb.build.TaskFailed',
+                        'bb.build.TaskSucceeded',
+                        'bb.build.TaskFailedSilent',
+                        'bb.build.TaskProgress',
+                        'bb.runqueue.runQueueTaskStarted',
+                        'bb.runqueue.sceneQueueTaskStarted',
+                        'bb.event.ProcessStarted',
+                        'bb.event.ProcessProgress',
+                        'bb.event.ProcessFinished',
+                        ]
+            if extra_events:
+                eventmask.extend(extra_events)
+            ret =3D self.set_event_mask(eventmask)
+
+        includelogs =3D self.config_data.getVar('BBINCLUDELOGS')
+        loglines =3D self.config_data.getVar('BBINCLUDELOGS_LINES')
+
+        # Call actual function
+        ret =3D f(self, *args, **kwargs)
+
+        if handle_events:
+            lastevent =3D time.time()
+            result =3D False
+            # Borrowed from knotty, instead somewhat hackily we use the =
helper
+            # as the object to store "shutdown" on
+            helper =3D bb.ui.uihelper.BBUIHelper()
+            helper.shutdown =3D 0
+            parseprogress =3D None
+            termfilter =3D bb.ui.knotty.TerminalFilter(helper, helper, s=
elf.logger.handlers, quiet=3Dself.quiet)
+            try:
+                while True:
+                    try:
+                        event =3D self.wait_event(0.25)
+                        if event:
+                            lastevent =3D time.time()
+                            if event_callback and event_callback(event):
+                                continue
+                            if helper.eventHandler(event):
+                                if isinstance(event, bb.build.TaskFailed=
Silent):
+                                    self.logger.warning("Logfile for fai=
led setscene task is %s" % event.logfile)
+                                elif isinstance(event, bb.build.TaskFail=
ed):
+                                    bb.ui.knotty.print_event_log(event, =
includelogs, loglines, termfilter)
+                                continue
+                            if isinstance(event, bb.event.ProcessStarted=
):
+                                if self.quiet > 1:
+                                    continue
+                                parseprogress =3D bb.ui.knotty.new_progr=
ess(event.processname, event.total)
+                                parseprogress.start(False)
+                                continue
+                            if isinstance(event, bb.event.ProcessProgres=
s):
+                                if self.quiet > 1:
+                                    continue
+                                if parseprogress:
+                                    parseprogress.update(event.progress)
+                                else:
+                                    bb.warn("Got ProcessProgress event f=
or something that never started?")
+                                continue
+                            if isinstance(event, bb.event.ProcessFinishe=
d):
+                                if self.quiet > 1:
+                                    continue
+                                if parseprogress:
+                                    parseprogress.finish()
+                                parseprogress =3D None
+                                continue
+                            if isinstance(event, bb.command.CommandCompl=
eted):
+                                result =3D True
+                                break
+                            if isinstance(event, (bb.command.CommandFail=
ed, bb.command.CommandExit)):
+                                self.logger.error(str(event))
+                                result =3D False
+                                break
+                            if isinstance(event, logging.LogRecord):
+                                if event.taskpid =3D=3D 0 or event.level=
no > logging.INFO:
+                                    self.logger.handle(event)
+                                continue
+                            if isinstance(event, bb.event.NoProvider):
+                                self.logger.error(str(event))
+                                result =3D False
+                                break
+                        elif helper.shutdown > 1:
+                            break
+                        termfilter.updateFooter()
+                        if time.time() > (lastevent + (3*60)):
+                            if not self.run_command('ping', handle_event=
s=3DFalse):
+                                print("\nUnable to ping server and no ev=
ents, closing down...\n")
+                                return False
+                    except KeyboardInterrupt:
+                        termfilter.clearFooter()
+                        if helper.shutdown =3D=3D 1:
+                            print("\nSecond Keyboard Interrupt, stopping=
...\n")
+                            ret =3D self.run_command("stateForceShutdown=
")
+                            if ret and ret[2]:
+                                self.logger.error("Unable to cleanly sto=
p: %s" % ret[2])
+                        elif helper.shutdown =3D=3D 0:
+                            print("\nKeyboard Interrupt, closing down...=
\n")
+                            interrupted =3D True
+                            ret =3D self.run_command("stateShutdown")
+                            if ret and ret[2]:
+                                self.logger.error("Unable to cleanly shu=
tdown: %s" % ret[2])
+                        helper.shutdown =3D helper.shutdown + 1
+                termfilter.clearFooter()
+            finally:
+                termfilter.finish()
+            if helper.failed_tasks:
+                result =3D False
+            return result
+        else:
+            return ret
+
+    return wrapper
+
=20
 # We need this in order to shut down the connection to the bitbake serve=
r,
 # otherwise the process will never properly exit
@@ -700,6 +829,10 @@ class Tinfoil:
         """
         return self.run_command('buildFile', buildfile, task, internal)
=20
+    @wait_for
+    def build_file_sync(self, *args):
+        self.build_file(*args)
+
     def build_targets(self, targets, task=3DNone, handle_events=3DTrue, =
extra_events=3DNone, event_callback=3DNone):
         """
         Builds the specified targets. This is equivalent to a normal inv=
ocation
--=20
2.43.0


