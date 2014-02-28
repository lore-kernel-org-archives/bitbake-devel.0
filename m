Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5CA3760B9B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:44:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1SHi1Bw005596 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:44:01 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HMAFst15Lqvf for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:44:00 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1SHhugY005591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:43:58 GMT
Message-ID: <1393609429.31769.205.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Feb 2014 17:43:49 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Drop svk fetcher
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
X-List-Received-Date: Fri, 28 Feb 2014 17:44:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The svk fetcher never appears to be used by anyone and the development
on svk appears to have stopped in 2010. We might as well drop support
for it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 2d8d9d4..67074cd 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1537,7 +1537,6 @@ from . import gitannex
 from . import local
 from . import svn
 from . import wget
-from . import svk
 from . import ssh
 from . import sftp
 from . import perforce
@@ -1553,7 +1552,6 @@ methods.append(git.Git())
 methods.append(gitsm.GitSM())
 methods.append(gitannex.GitANNEX())
 methods.append(cvs.Cvs())
-methods.append(svk.Svk())
 methods.append(ssh.SSH())
 methods.append(sftp.SFTP())
 methods.append(perforce.Perforce())
diff --git a/bitbake/lib/bb/fetch2/svk.py b/bitbake/lib/bb/fetch2/svk.py
deleted file mode 100644
index 6f70a3b..0000000
--- a/bitbake/lib/bb/fetch2/svk.py
+++ /dev/null
@@ -1,95 +0,0 @@
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-"""
-BitBake 'Fetch' implementations
-
-This implementation is for svk. It is based on the svn implementation
-
-"""
-
-# Copyright (C) 2006 Holger Hans Peter Freyther
-# Copyright (C) 2003, 2004  Chris Larson
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
-#
-# Based on functions from the base bb module, Copyright 2003 Holger Schurig
-
-import os
-import logging
-import bb
-from   bb import data
-from   bb.fetch2 import FetchMethod
-from   bb.fetch2 import FetchError
-from   bb.fetch2 import MissingParameterError
-from   bb.fetch2 import logger
-from   bb.fetch2 import runfetchcmd
-
-class Svk(FetchMethod):
-    """Class to fetch a module or modules from svk repositories"""
-    def supports(self, ud, d):
-        """
-        Check to see if a given url can be fetched with svk.
-        """
-        return ud.type in ['svk']
-
-    def urldata_init(self, ud, d):
-
-        if not "module" in ud.parm:
-            raise MissingParameterError('module', ud.url)
-        else:
-            ud.module = ud.parm["module"]
-
-        ud.revision = ud.parm.get('rev', "")
-
-        ud.localfile = data.expand('%s_%s_%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.host, ud.path.replace('/', '.'), ud.revision, ud.date), d)
-
-    def need_update(self, ud, d):
-        if ud.date == "now":
-            return True
-        if not os.path.exists(ud.localpath):
-            return True
-        return False
-
-    def download(self, ud, d):
-        """Fetch urls"""
-
-        svkroot = ud.host + ud.path
-
-        svkcmd = "svk co -r {%s} %s/%s" % (ud.date, svkroot, ud.module)
-
-        if ud.revision:
-            svkcmd = "svk co -r %s %s/%s" % (ud.revision, svkroot, ud.module)
-
-        # create temp directory
-        logger.debug(2, "Fetch: creating temporary directory")
-        bb.utils.mkdirhier(d.expand('${WORKDIR}'))
-        mktemp = d.getVar("FETCHCMD_svkmktemp", True) or d.expand("mktemp -d -q '${WORKDIR}/oesvk.XXXXXX'")
-        tmpfile, errors = bb.process.run(mktemp)
-        tmpfile = tmpfile.strip()
-        if not tmpfile:
-            logger.error()
-            raise FetchError("Fetch: unable to create temporary directory.. make sure 'mktemp' is in the PATH.", ud.url)
-
-        # check out sources there
-        os.chdir(tmpfile)
-        logger.info("Fetch " + ud.url)
-        logger.debug(1, "Running %s", svkcmd)
-        runfetchcmd(svkcmd, d, cleanup = [tmpfile])
-
-        os.chdir(os.path.join(tmpfile, os.path.dirname(ud.module)))
-        # tar them up to a defined filename
-        runfetchcmd("tar -czf %s %s" % (ud.localpath, os.path.basename(ud.module)), d, cleanup = [ud.localpath])
-
-        # cleanup
-        bb.utils.prunedir(tmpfile)



