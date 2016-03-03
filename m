Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id 099CA731E7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 05:20:42 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id w128so707868pfb.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 21:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=Yc4CzuHh4AbFxHcQrCos//4hxMKPY9+1IWf93Kt6gzs=;
	b=TvDOIx/psbtJ6D4DQfOdtQU4nGJoRJsx48X4U6Ptg1jGH+jVu5XbjrWqSx/Ds08EVf
	s3/Yi1Tdr305+1q6EKszLZI0DqqaHVmkEG5dmiZ+VNfqvLbSoSdkb5x0DPpxSZFkk72K
	CwKCSbdJMjM/3MyaLi9Rt6n7XorwfOIFiEtynQxn29Oy7OZtmlzkvQZg2JbdztNnykjE
	n/GlBPmZBu07p6MSjB/BEirWs8bcH11EWQ0en/4FNU3Zb0LvJNG5DpVsi8DicT6pdt/f
	f44Wq35ZbaTDYOOZVIQ1iVO11dUQWbVlR+12DNnNLGHlLjN2uf2Mnvwt9ySKqr9N/Q8p
	7+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Yc4CzuHh4AbFxHcQrCos//4hxMKPY9+1IWf93Kt6gzs=;
	b=MhaJqRaHBzBh6LLgaNyqj2N1dFSGUDV2bO5x2k0HmkQ1ha+Hep9Yk7cMj432F9e6QU
	vNVQjrIv1CQXeKr+A0al0+GfoGdudy8RqopwB/+TBUu1JwwlH3PRdg4qGVxkUWB/ix6V
	V3xWQ/iSTxiq/RrHCp8BD+OuFF6kH4Ox1McTHGDGHLMJF76ynaGcsynPa/mAzQ4X2YQb
	cCq9VyUU8aeSi9g73DB8taauMbQHT0ISJni7iczQaYu9+jBkY8yXS4ysXblTUh7c11DM
	FYeCRM9LyBgqZWdYauralpDr1Vnh2vqnCqWAKDesE3b5B1t4UPkMam5gGqcLUHbdsUUm
	YOPA==
X-Gm-Message-State: AD7BkJI4NqczQqoDcNkrbOCez4QiN5OAdCJ+94ZSkSLiECcogLlQ351trR+VeEiugpeEAQ==
X-Received: by 10.98.72.8 with SMTP id v8mr1070720pfa.62.1456982443572;
	Wed, 02 Mar 2016 21:20:43 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	z5sm25544986par.21.2016.03.02.21.20.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 21:20:42 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 21:26:56 -0800
Message-Id: <ffce6a18876c3a0c949eb75f0ce2f9dc36054c83.1456982682.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <df618a1a82ca72c39f9334c7b6ce1104553cf7da.1456982682.git.avery.brian@gmail.com>
References: <df618a1a82ca72c39f9334c7b6ce1104553cf7da.1456982682.git.avery.brian@gmail.com>
In-Reply-To: <cover.1456982682.git.avery.brian@gmail.com>
References: <cover.1456982682.git.avery.brian@gmail.com>
Subject: [PATCH 3/3] toaster: remove sshbecontroller module
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
X-List-Received-Date: Thu, 03 Mar 2016 05:20:43 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

The code of this module is broken for a long time.
The functionality of it can be easily achieved by running
'manage.py runbuilds.py' on remote machine.

[YOCTO #8806]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/bldcontrol/sshbecontroller.py | 169 ------------------------------
 1 file changed, 169 deletions(-)
 delete mode 100644 bitbake/lib/toaster/bldcontrol/sshbecontroller.py

diff --git a/lib/toaster/bldcontrol/sshbecontroller.py b/lib/toaster/bldcontrol/sshbecontroller.py
deleted file mode 100644
index 17dd66c..0000000
--- a/lib/toaster/bldcontrol/sshbecontroller.py
+++ /dev/null
@@ -1,169 +0,0 @@
-#
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
-# BitBake Toaster Implementation
-#
-# Copyright (C) 2014        Intel Corporation
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-
-import sys
-import re
-from django.db import transaction
-from django.db.models import Q
-from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
-import subprocess
-
-from toastermain import settings
-
-from bbcontroller import BuildEnvironmentController, ShellCmdException, BuildSetupException
-
-class NotImplementedException(Exception):
-    pass
-
-def DN(path):
-    return "/".join(path.split("/")[0:-1])
-
-class SSHBEController(BuildEnvironmentController):
-    """ Implementation of the BuildEnvironmentController for the localhost;
-        this controller manages the default build directory,
-        the server setup and system start and stop for the localhost-type build environment
-
-    """
-
-    def __init__(self, be):
-        super(SSHBEController, self).__init__(be)
-        self.dburl = settings.getDATABASE_URL()
-        self.pokydirname = None
-        self.islayerset = False
-
-    def _shellcmd(self, command, cwd = None):
-        if cwd is None:
-            cwd = self.be.sourcedir
-
-        p = subprocess.Popen("ssh %s 'cd %s && %s'" % (self.be.address, cwd, command), stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
-        (out,err) = p.communicate()
-        if p.returncode:
-            if len(err) == 0:
-                err = "command: %s \n%s" % (command, out)
-            else:
-                err = "command: %s \n%s" % (command, err)
-            raise ShellCmdException(err)
-        else:
-            return out.strip()
-
-    def _pathexists(self, path):
-        try:
-            self._shellcmd("test -e \"%s\"" % path)
-            return True
-        except ShellCmdException as e:
-            return False
-
-    def _pathcreate(self, path):
-        self._shellcmd("mkdir -p \"%s\"" % path)
-
-    def _setupBE(self):
-        assert self.pokydirname and self._pathexists(self.pokydirname)
-        self._pathcreate(self.be.builddir)
-        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
-
-    def startBBServer(self, brbe):
-        assert self.pokydirname and self._pathexists(self.pokydirname)
-        assert self.islayerset
-        cmd = self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb brbe=%s\"" % (self.pokydirname, self.be.builddir, self.dburl, brbe))
-
-        port = "-1"
-        for i in cmd.split("\n"):
-            if i.startswith("Bitbake server address"):
-                port = i.split(" ")[-1]
-                print "Found bitbake server port ", port
-
-
-        assert self.be.sourcedir and self._pathexists(self.be.builddir)
-        self.be.bbaddress = self.be.address.split("@")[-1]
-        self.be.bbport = port
-        self.be.bbstate = BuildEnvironment.SERVER_STARTED
-        self.be.save()
-
-    def _copyFile(self, filepath1, filepath2):
-        p = subprocess.Popen("scp '%s' '%s'" % (filepath1, filepath2), stdout=subprocess.PIPE, stderr = subprocess.PIPE, shell=True)
-        (out, err) = p.communicate()
-        if p.returncode:
-            raise ShellCmdException(err)
-
-    def pullFile(self, local_filename, remote_filename):
-        _copyFile(local_filename, "%s:%s" % (self.be.address, remote_filename))
-
-    def pushFile(self, local_filename, remote_filename):
-        _copyFile("%s:%s" % (self.be.address, remote_filename), local_filename)
-
-    def setLayers(self, bitbakes, layers):
-        """ a word of attention: by convention, the first layer for any build will be poky! """
-
-        assert self.be.sourcedir is not None
-        assert len(bitbakes) == 1
-        # set layers in the layersource
-
-
-        raise NotImplementedException("Not implemented: SSH setLayers")
-        # 3. configure the build environment, so we have a conf/bblayers.conf
-        assert self.pokydirname is not None
-        self._setupBE()
-
-        # 4. update the bblayers.conf
-        bblayerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
-        if not self._pathexists(bblayerconf):
-            raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
-
-        import uuid
-        local_bblayerconf = "/tmp/" + uuid.uuid4() + "-bblayer.conf"
-
-        self.pullFile(bblayerconf, local_bblayerconf)
-
-        BuildEnvironmentController._updateBBLayers(local_bblayerconf, layerlist)
-        self.pushFile(local_bblayerconf, bblayerconf)
-
-        os.unlink(local_bblayerconf)
-
-        self.islayerset = True
-        return True
-
-    def release(self):
-        assert self.be.sourcedir and self._pathexists(self.be.builddir)
-        import shutil
-        shutil.rmtree(os.path.join(self.be.sourcedir, "build"))
-        assert not self._pathexists(self.be.builddir)
-
-    def triggerBuild(self, bitbake, layers, variables, targets):
-        # set up the buid environment with the needed layers
-        self.setLayers(bitbake, layers)
-        self.writeConfFile("conf/toaster-pre.conf", )
-        self.writeConfFile("conf/toaster.conf", raw = "INHERIT+=\"toaster buildhistory\"")
-
-        # get the bb server running with the build req id and build env id
-        bbctrl = self.getBBController()
-
-        # trigger the build command
-        task = reduce(lambda x, y: x if len(y)== 0 else y, map(lambda y: y.task, targets))
-        if len(task) == 0:
-            task = None
-
-        bbctrl.build(list(map(lambda x:x.target, targets)), task)
-
-        logger.debug("localhostbecontroller: Build launched, exiting. Follow build logs at %s/toaster_ui.log" % self.be.builddir)
-
-        # disconnect from the server
-        bbctrl.disconnect()
-- 
1.9.1


