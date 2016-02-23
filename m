Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 11F5F731F8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:49:50 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2016 16:49:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; d="scan'208";a="751272763"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:49:50 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 18:51:55 -0600
Message-Id: <1456188718-13755-6-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
Subject: [[RFC][PATCH] 5/8] toaster/tests: Add helpers.py module.
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
X-List-Received-Date: Tue, 23 Feb 2016 00:49:50 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The helpers.py module is a utility for clone/setup_venv/start/stop
a toaster instance.

It can be executed in a standalone way or use as utility class.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/toaster/tests/helpers.py | 178 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100755 lib/toaster/tests/helpers.py

diff --git a/lib/toaster/tests/helpers.py b/lib/toaster/tests/helpers.py
new file mode 100755
index 0000000..549358b
--- /dev/null
+++ b/lib/toaster/tests/helpers.py
@@ -0,0 +1,178 @@
+#!/usr/bin/env python
+
+# Copyright (C) 2016 Intel Corporation
+#
+
+import subprocess
+import os
+import shutil
+import signal
+import tempfile
+
+from proc.core import find_processes
+
+TOASTER_TEST_BRANCH = 'toaster_tests'
+VENV_NAME = 'venv'
+SHELL_CMD = os.environ['SHELL'] if 'SHELL' in os.environ else "/bin/bash"
+TOASTER_BUILD_DIR_NAME = 'build'
+
+def _check_output1(*popenargs, **kwargs):
+    """
+        Almost the same as subprocess.check_output but change the stdout from
+        PIPE to tempfile to avoid deadlocks when trying to read the PIPE using
+        communicate(). This scenario can be seen calling toaster_start on failure
+        scenarios.
+
+        This causes a little overhead by the tempfile.
+    """
+
+    f = tempfile.TemporaryFile(mode='rw+')
+    if 'stdout' in kwargs:
+        raise ValueError('stdout argument not allowed, it will be overridden.')
+    process = subprocess.Popen(stdout=f, *popenargs, **kwargs)
+    retcode = process.wait()
+
+    f.flush()
+    os.fsync(f.fileno())
+    f.seek(0, 0)
+    output = f.read()
+    f.close()
+
+    if retcode:
+        cmd = kwargs.get("args")
+        if cmd is None:
+            cmd = popenargs[0]
+        raise subprocess.CalledProcessError(retcode, cmd, output=output)
+    return output
+
+class ToasterHelper(object):
+    def __init__(self, directory, repo, repo_ref='master', port='8000',
+            build_dir=TOASTER_BUILD_DIR_NAME):
+        self.directory = directory
+        self.repo = repo
+        self.repo_ref = repo_ref
+        self.port = port
+        self.build_dir = build_dir
+
+    def _execute_command(self, cmd):
+        return _check_output1([SHELL_CMD, "-c", "cd %s; %s" % \
+            (self.directory, cmd)], stderr=subprocess.STDOUT)
+
+    def _execute_command_oe(self, cmd):
+        return self._execute_command("source oe-init-build-env %s; %s"\
+            % (self.build_dir, cmd))
+
+    def _execute_command_oe_venv(self, cmd):
+        return self._execute_command_oe("source %s/bin/activate; %s"\
+                % (VENV_NAME, cmd))
+
+    def clone(self, rm=False):
+        if os.path.exists(self.directory):
+            if rm:
+                shutil.rmtree(self.directory)
+            else:
+                raise IOError
+
+        subprocess.check_output([SHELL_CMD, "-c", "git clone %s %s" %\
+            (self.repo, self.directory)], stderr=subprocess.STDOUT)
+        self._execute_command("git checkout %s; git branch %s; git checkout %s;"\
+            % (self.repo_ref, TOASTER_TEST_BRANCH, TOASTER_TEST_BRANCH))
+
+    def setup(self):
+        self._execute_command_oe("virtualenv %s" % VENV_NAME)
+        self._execute_command_oe_venv("pip install -r" \
+            " ../bitbake/toaster-requirements.txt")
+        self._execute_command_oe_venv("pip install -r" \
+            " ../bitbake/toaster-tests-requirements.txt")
+
+    def start(self):
+        return self._execute_command_oe_venv("source %s/bitbake/bin/toaster"\
+            " start webport=%s" % (self.directory, self.port))
+
+    def _stop_force(self):
+        """
+            The _stop_force method iterates over the /proc and search for toaster path
+            in the process cmdline then send SIGKILL for every matched process.
+        """
+
+        pids = []
+        for p in find_processes():
+            if len(p.cmdline) > 1 and \
+                os.path.basename(p.cmdline[0]) == 'python' and \
+                p.cmdline[1].startswith(self.directory):
+                    pids.append(p.pid)
+
+        for pid in pids:
+            try:
+                os.kill(pid, signal.SIGKILL)
+            except:
+                pass
+
+        return ''
+
+    def stop(self, force=False):
+        """
+            The stop method have force mode because toaster without production 
+            setup have known issues when is on load, the server response 503
+            service unavailable.
+        """
+        if force:
+            return self._stop_force()
+        else:
+            return self._execute_command_oe_venv("source %s/bitbake/bin/toaster"\
+                " stop webport=%s" % (self.directory, self.port))
+
+    def get_sqlite_path(self):
+        return os.path.join(self.directory, self.build_dir, 'toaster.sqlite')
+
+    def get_conf_path(self):
+        output = self._execute_command_oe_venv("source %s/bitbake/bin/toaster"\
+            " start webport=%s; echo $TOASTER_CONF;" % \
+            (self.directory, self.port))
+
+        return output.split()[-1]
+
+DEFAULT_WORK_DIRECTORY = '/tmp/toaster'
+DEFAULT_POKY_URL = 'http://git.yoctoproject.org/git/poky.git'
+DEFAULT_POKY_BRANCH = 'master'
+DEFAULT_WEB_PORT = '8000'
+
+if __name__ == "__main__":
+    import argparse
+    import sys
+
+    parser = argparse.ArgumentParser(description='Toaster helper',
+        formatter_class=argparse.RawTextHelpFormatter)
+    parser.add_argument("-a", "--action", choices=['clone', 'setup', 'start', 'stop'],
+        required=True,
+        help="Action to execute can be clone/setup/start/stop")
+    parser.add_argument("-d", "--work-directory", default=DEFAULT_WORK_DIRECTORY,
+        help="Directory for setup toaster, default: %s" % DEFAULT_WORK_DIRECTORY)
+    parser.add_argument("-u", "--url-repository", default=DEFAULT_POKY_URL,
+        help="GIT repository for setup toaster, default %s" % DEFAULT_POKY_URL)
+    parser.add_argument("-r", "--revision", default=DEFAULT_POKY_BRANCH,
+        help="GIT repository revision (branch, tag, hash) for setup toaster" \
+        ", default: %s" % DEFAULT_POKY_BRANCH)
+    parser.add_argument("-p", "--web-port", default=DEFAULT_WEB_PORT,
+        help="Web port for start toaster server, default: %s" % DEFAULT_WEB_PORT)
+    parser.add_argument("-b", "--build-dir", default=TOASTER_BUILD_DIR_NAME,
+        help="Toaster build directory name, default: %s" % TOASTER_BUILD_DIR_NAME)
+
+    args = parser.parse_args()
+
+    try:
+        th = ToasterHelper(args.work_directory, args.url_repository,
+            args.revision, args.web_port, args.build_dir)
+        if args.action == 'stop':
+            th.stop(force=True)
+        else:
+            getattr(th, args.action)()
+    except subprocess.CalledProcessError as e:
+        print e.output
+        raise
+    except IOError as e:
+        if args.action == 'clone':
+            print "ERROR: Directory exists: %s" % args.work_directory
+        raise 
+
+    sys.exit(0)
-- 
2.1.4


