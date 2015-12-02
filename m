Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 4E60F612E5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:47 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48541512pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Dn6jm5oGDglYUj7ST1xKgtKucrE3Ay7ri9HiGBseIuQ=;
	b=Vci2zjnxBSBdZDlb8v/R+pZO7+yt6fhjHr1XSUbNLv92PofTHaHClnV7vWu79YfiAo
	op6LtTIr6nFV3JdGYXU5acyg+vyMsCW4cXUVH9PqvN9ewcwVUM7IYWczx/7BJ7LiYBft
	gheVgsirVjeEBHa7u/F+jJyubgnYIWGz5vw3aaf4zIgcj9wIsq+TDi6F9KRC9H7Am9tB
	dxIgqH7QTwzsnLq1vbrRU8VxxU/FftzPQqhAaa6D8SnzHx3taYSzpj51zffGXTCbk7qk
	RujfUgLY42HrGvgBmFN+RcXzhsMJ0G2XAv+pacTZ9mIIH84t5bTDAbcnQLphGOzPPI9P
	PXng==
X-Received: by 10.98.72.133 with SMTP id q5mr6440898pfi.157.1449079188330;
	Wed, 02 Dec 2015 09:59:48 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:47 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:47 -0800
Message-Id: <fe1866ef46ab95d71a4c0c25d64c71c92a2e0072.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 15/30] toaster: reimplemented startBBServer method
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:47 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Rewritten LocalhostBEController.startBBServer to use
'toaster restart-bitbake' and read bitbake port number from
bitbake.lock.

Removed complicated logic of running oe-init-memres and looking for
bitbake port number in the logs.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 90 +++++--------------------
 1 file changed, 18 insertions(+), 72 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 15c0ff9..44a9136 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -88,82 +88,28 @@ class LocalhostBEController(BuildEnvironmentController):
         # find our own toasterui listener/bitbake
         from toaster.bldcontrol.management.commands.loadconf import _reduce_canon_path
 
-        own_bitbake = _reduce_canon_path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../../bin/bitbake"))
-
-        assert os.path.exists(own_bitbake) and os.path.isfile(own_bitbake)
-
-        logger.debug("localhostbecontroller: running the listener at %s" % own_bitbake)
-
-        toaster_ui_log_filepath = os.path.join(self.be.builddir, "toaster_ui.log")
-        # get the file length; we need to detect the _last_ start of the toaster UI, not the first
-        toaster_ui_log_filelength = 0
-        if os.path.exists(toaster_ui_log_filepath):
-            with open(toaster_ui_log_filepath, "w") as f:
-                f.seek(0, 2)    # jump to the end
-                toaster_ui_log_filelength = f.tell()
-
-        cmd = "bash -c \"source %s/oe-init-build-env %s 2>&1 >toaster_server.log && bitbake --read %s/conf/toaster-pre.conf --postread %s/conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0 2>&1 >>toaster_server.log \"" % (self.pokydirname, self.be.builddir, self.be.builddir, self.be.builddir)
-
-        port = "-1"
-        logger.debug("localhostbecontroller: starting builder \n%s\n" % cmd)
-
-        cmdoutput = self._shellcmd(cmd)
-        with open(self.be.builddir + "/toaster_server.log", "r") as f:
-            for i in f.readlines():
-                if i.startswith("Bitbake server address"):
-                    port = i.split(" ")[-1]
-                    logger.debug("localhostbecontroller: Found bitbake server port %s" % port)
-
-        cmd = "bash -c \"source %s/oe-init-build-env-memres -1 %s && %s --observe-only -u toasterui --remote-server=0.0.0.0:-1 -t xmlrpc\"" % \
-                (self.pokydirname, self.be.builddir, own_bitbake)
-
-        # Use a copy of the current environment and add the DATABASE_URL
-        # for the bitbake observer process.
-        env = os.environ.copy()
-        env['DATABASE_URL'] = settings.getDATABASE_URL()
-
-        with open(toaster_ui_log_filepath, "a+") as f:
-            p = subprocess.Popen(cmd, cwd = self.be.builddir, shell=True,
-                                 stdout=f, stderr=f, env=env)
-
-        def _toaster_ui_started(filepath, filepos = 0):
-            if not os.path.exists(filepath):
-                return False
-            with open(filepath, "r") as f:
-                f.seek(filepos)
-                for line in f:
-                    if line.startswith("NOTE: ToasterUI waiting for events"):
-                        return True
-            return False
-
-        retries = 0
-        started = False
-        while not started and retries < 50:
-            started = _toaster_ui_started(toaster_ui_log_filepath, toaster_ui_log_filelength)
-            import time
-            logger.debug("localhostbecontroller: Waiting bitbake server to start")
-            time.sleep(0.5)
-            retries += 1
-
-        if not started:
-            toaster_ui_log = open(os.path.join(self.be.builddir, "toaster_ui.log"), "r").read()
-            toaster_server_log = open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
-            raise BuildSetupException("localhostbecontroller: Bitbake server did not start in 25 seconds, aborting (Error: '%s' '%s')" % (toaster_ui_log, toaster_server_log))
-
-        logger.debug("localhostbecontroller: Started bitbake server")
-
-        while port == "-1":
-            # the port specification is "autodetect"; read the bitbake.lock file
-            with open("%s/bitbake.lock" % self.be.builddir, "r") as f:
-                for line in f.readlines():
+        toaster = _reduce_canon_path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../../bin/toaster"))
+        assert os.path.exists(toaster) and os.path.isfile(toaster)
+
+        # restart bitbake server and toastergui observer
+        self._shellcmd("bash -c 'source %s restart-bitbake'" % toaster, self.be.builddir)
+        logger.debug("localhostbecontroller: restarted bitbake server")
+
+        # read port number from bitbake.lock
+        self.be.bbport = ""
+        bblock = os.path.join(self.be.builddir, 'bitbake.lock')
+        if os.path.exists(bblock):
+            with open(bblock) as fplock:
+                for line in fplock:
                     if ":" in line:
-                        port = line.split(":")[1].strip()
-                        logger.debug("localhostbecontroller: Autodetected bitbake port %s", port)
+                        self.be.bbport = line.split(":")[-1].strip()
+                        logger.debug("localhostbecontroller: bitbake port %s", self.be.bbport)
                         break
 
-        assert self.be.sourcedir and os.path.exists(self.be.builddir)
+        if not self.be.bbport:
+            raise BuildSetupException("localhostbecontroller: can't read bitbake port from %s" % bblock)
+
         self.be.bbaddress = "localhost"
-        self.be.bbport = port
         self.be.bbstate = BuildEnvironment.SERVER_STARTED
         self.be.save()
 
-- 
1.9.1


