Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C223270031
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 13:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49D7KkI015780 for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 May 2016 14:07:20 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1lsbDEdFcIks for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 14:07:20 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49D7H4r015777
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 May 2016 14:07:18 +0100
Message-ID: <1462799237.21831.134.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 09 May 2016 14:07:17 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] lib/bb/utils.py: Fix explode_dep_versions2() determinism issue
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
X-List-Received-Date: Mon, 09 May 2016 13:07:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When we pass data into explode_dep_versions2(), we need to result to be
able to be processed in a deterministic way so that we end up with 
consistent hash values. This means we need an ordered structure rather
than an unordered one.

To do this, return an OrderedDict() rather than a dict(). 

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 3544bbe..bf4ac40 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -34,6 +34,7 @@ import traceback
 import errno
 import signal
 import ast
+import collections
 from commands import getstatusoutput
 from contextlib import contextmanager
 from ctypes import cdll
@@ -188,7 +189,7 @@ def explode_dep_versions2(s):
     "DEPEND1 (optional version) DEPEND2 (optional version) ..."
     and return a dictionary of dependencies and versions.
     """
-    r = {}
+    r = collections.OrderedDict()
     l = s.replace(",", "").split()
     lastdep = None
     lastcmp = ""



