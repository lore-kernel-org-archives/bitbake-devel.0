Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BE75C773C8
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3BB007479; Wed, 1 Jun 2016 13:37:07 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MwUc9Whh8ORp; Wed,  1 Jun 2016 13:37:07 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Caxkp007445
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000nP-6p; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:22 +0100
Message-Id: <1464784607-2985-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 03/28] bitbake: Drop futures usage since we're python 3
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:13 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py                   | 2 +-
 lib/bb/exceptions.py               | 2 +-
 lib/bb/fetch2/__init__.py          | 2 --
 lib/bb/fetch2/perforce.py          | 1 -
 lib/bb/parse/ast.py                | 3 +--
 lib/bb/parse/parse_py/BBHandler.py | 2 +-
 6 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fb86446..11f17ef 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -22,7 +22,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from __future__ import print_function
+
 import sys, os, glob, os.path, re, time
 import atexit
 import itertools
diff --git a/lib/bb/exceptions.py b/lib/bb/exceptions.py
index f182c8f..eadfc57 100644
--- a/lib/bb/exceptions.py
+++ b/lib/bb/exceptions.py
@@ -1,4 +1,4 @@
-from __future__ import absolute_import
+
 import inspect
 import traceback
 import bb.namedtuple_with_abc
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7d2f350..14fe3c7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -25,8 +25,6 @@ BitBake build tools.
 #
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
-from __future__ import absolute_import
-from __future__ import print_function
 import os, re
 import signal
 import logging
diff --git a/lib/bb/fetch2/perforce.py b/lib/bb/fetch2/perforce.py
index 3a10c7c..1aef246 100644
--- a/lib/bb/fetch2/perforce.py
+++ b/lib/bb/fetch2/perforce.py
@@ -25,7 +25,6 @@ BitBake build tools.
 #
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
-from future_builtins import zip
 import os
 import subprocess
 import logging
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 5f55af5..bc3a2f8 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -21,8 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from __future__ import absolute_import
-from future_builtins import filter
+
 import re
 import string
 import logging
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index ef72c37..c54a079 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -25,7 +25,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from __future__ import absolute_import
+
 import re, bb, os
 import logging
 import bb.build, bb.utils
-- 
2.5.0


