Return-Path: <ross.burton@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 74B9272A2D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 May 2015 15:19:48 +0000 (UTC)
Received: by widdi4 with SMTP id di4so246751901wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 May 2015 08:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=CNTcpalIPYolK5KP93X0JLZkU9uv5OfP5nYuhI7iYQ0=;
	b=VCUIws9/57au0K4mqDkKMpgDH8Vy+gjpO649Y9s9DnqTIWBLlgRvLs54G7UnQj0938
	5FINzhyN+xglxqA6fVSzrnE0O0o4+sxHSjGK8l+vSzbrS8CLj/Kiy2L1uaXdgfTWUg4B
	FyGZTHMpdwbwnO8QkU4GcDVK4ppxgatuNdr3Ir6/vGlB2Awp98zT+5yIB090dCM4dsf+
	DX70vVJJ0+i2kPFv+25VITXSV3nHnNfWOzuWZrs/grzdyU30id6CySkMl9WSEj1/Lc/E
	luB/k36nDfB4OR07WTFFceafD9vjRdjesiXNP+h6xy/mfK/aJ0tN+UuweTckeTNgrckB
	5eLQ==
X-Gm-Message-State: ALoCoQlL7hsmEXkluLikUArUFnZfMSQyXd5S/Ey75BLZN9S8XIn1+DNPjUiXr6308OCOcRUN9sgf
X-Received: by 10.194.192.226 with SMTP id hj2mr204551wjc.51.1431011989733;
	Thu, 07 May 2015 08:19:49 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by mx.google.com with ESMTPSA id 9sm3940087wjr.11.2015.05.07.08.19.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 07 May 2015 08:19:48 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 May 2015 16:15:49 +0100
Message-Id: <1431011749-6036-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.1.4
Cc: clarson@kergoth.com
Subject: [PATCH] setup.py: remove
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
X-List-Received-Date: Thu, 07 May 2015 15:19:50 -0000

This setup.py doesn't actually work and due to the lack of versioning or
stability guarantees we don't endorse system-wide installation.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 setup.py | 73 ----------------------------------------------------------------
 1 file changed, 73 deletions(-)
 delete mode 100755 setup.py

diff --git a/setup.py b/setup.py
deleted file mode 100755
index 02de77b..0000000
--- a/setup.py
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/usr/bin/env python
-# ex:ts=4:sw=4:sts=4:et
-# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
-#
-# Copyright (C) 2003  Chris Larson
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
-import os, sys
-sys.path.append(os.path.join(os.path.dirname(__file__), "lib"))
-from bb import __version__
-
-from glob import glob
-from distutils.command.clean import clean
-from distutils.command.build import build
-from distutils.core import setup
-
-
-doctype = "html"
-
-class Clean(clean):
-    def run(self):
-        clean.run(self)
-        origpath = os.path.abspath(os.curdir)
-        os.chdir(os.path.join(origpath, 'doc'))
-        make = os.environ.get('MAKE') or 'make'
-        os.system('%s clean-%s DOC=bitbake-user-manual' % (make, doctype))
-
-class Build(build):
-    def run(self):
-        build.run(self)
-        origpath = os.path.abspath(os.curdir)
-        os.chdir(os.path.join(origpath, 'doc'))
-        make = os.environ.get('MAKE') or 'make'
-        ret = os.system('%s %s DOC=bitbake-user-manual' % (make, doctype))
-        if ret != 0:
-            print("ERROR: Unable to generate html documentation.")
-            sys.exit(ret)
-        os.chdir(origpath)
-
-setup(name='bitbake',
-      version = __version__,
-      requires = ["ply", "progressbar"],
-      package_dir = {"": "lib"},
-      packages = ["bb.server", "bb.parse.parse_py", "bb.parse", 
-                  "bb.fetch2", "bb.ui.crumbs", "bb.ui", "bb.pysh", "bb", "prserv", "bb.tests"],
-      py_modules = ["codegen"],
-      scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs", "bin/bitbake-prserv", "bin/bitbake-selftest", "bin/image-writer"],
-      data_files = [("share/bitbake", glob("conf/*") + glob("classes/*")),
-                  ("share/doc/bitbake-%s/bitbake-user-manual" % __version__, glob("doc/bitbake-user-manual/html/*"))],
-      cmdclass = {
-          "build": Build,
-          "clean": Clean,
-      },
-
-      license = 'GPLv2',
-      url = 'http://www.openembedded.org/wiki/BitBake',
-      description = 'BitBake build tool',
-      long_description = 'BitBake is a simple tool for the execution of tasks. It is derived from Portage, which is the package management system used by the Gentoo Linux distribution. It is most commonly used to build packages, as it can easily use its rudimentary inheritance to abstract common operations, such as fetching sources, unpacking them, patching them, compiling them, and so on.  It is the basis of the OpenEmbedded project, which is being used for OpenZaurus, Familiar, and a number of other Linux distributions.',
-      author = 'BitBake Development Team',
-      author_email = 'bitbake-dev@lists.berlios.de',
-)
-- 
2.1.4


