Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7E7117317F
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Dec 2015 13:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBKDLawY025226; Sun, 20 Dec 2015 13:21:36 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id a0QdOX0WTGA9; Sun, 20 Dec 2015 13:21:36 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	tBKDLEfM025213
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 20 Dec 2015 13:21:31 GMT
Message-ID: <1450617674.8461.91.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 Dec 2015 13:21:14 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: Holger Freyther <holger@freyther.de>
Subject: [PATCH] BBHandler: Improve IN_PYTHON_EOF handling
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
X-List-Received-Date: Sun, 20 Dec 2015 13:21:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Now we're actively using the line numbers for other thins, having
magic values like IN_PYTHON_EOF causes problems, in particular, 32
bit overflow on 32 bit machines.

There is a neater way to signal eof to feeder(), just using an extra
parameter so use this instead and drop the IN_PYTHON_EOF magic values.

This has the added bonus that line numbers are then correct for
python functions at the end of files.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index ec097ba..97a9ee8 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -47,7 +47,6 @@ __addhandler_regexp__    = re.compile( r"addhandler\s+(.+)" )
 __def_regexp__           = re.compile( r"def\s+(\w+).*:" )
 __python_func_regexp__   = re.compile( r"(\s+.*)|(^$)" )
 
-
 __infunc__ = []
 __inpython__ = False
 __body__   = []
@@ -55,15 +54,6 @@ __classname__ = ""
 
 cached_statements = {}
 
-# We need to indicate EOF to the feeder. This code is so messy that
-# factoring it out to a close_parse_file method is out of question.
-# We will use the IN_PYTHON_EOF as an indicator to just close the method
-#
-# The two parts using it are tightly integrated anyway
-IN_PYTHON_EOF = -9999999999999
-
-
-
 def supports(fn, d):
     """Return True if fn has a supported extension"""
     return os.path.splitext(fn)[-1] in [".bb", ".bbclass", ".inc"]
@@ -110,7 +100,7 @@ def get_statements(filename, absolute_filename, base_name):
         file.close()
         if __inpython__:
             # add a blank line to close out any python definition
-            feeder(IN_PYTHON_EOF, "", filename, base_name, statements)
+            feeder(lineno, "", filename, base_name, statements, eof=True)
 
         if filename.endswith(".bbclass") or filename.endswith(".inc"):
             cached_statements[absolute_filename] = statements
@@ -171,7 +161,7 @@ def handle(fn, d, include):
 
     return d
 
-def feeder(lineno, s, fn, root, statements):
+def feeder(lineno, s, fn, root, statements, eof=False):
     global __func_start_regexp__, __inherit_regexp__, __export_func_regexp__, __addtask_regexp__, __addhandler_regexp__, __def_regexp__, __python_func_regexp__, __inpython__, __infunc__, __body__, bb, __residue__, __classname__
     if __infunc__:
         if s == '}':
@@ -185,7 +175,7 @@ def feeder(lineno, s, fn, root, statements):
 
     if __inpython__:
         m = __python_func_regexp__.match(s)
-        if m and lineno != IN_PYTHON_EOF:
+        if m and not eof:
             __body__.append(s)
             return
         else:
@@ -194,7 +184,7 @@ def feeder(lineno, s, fn, root, statements):
             __body__ = []
             __inpython__ = False
 
-            if lineno == IN_PYTHON_EOF:
+            if eof:
                 return
 
     if s and s[0] == '#':



