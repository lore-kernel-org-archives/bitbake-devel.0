Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Ua8En-0001Rg-C0 for bitbake-devel@lists.openembedded.org;
	Wed, 08 May 2013 19:33:10 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r48HHSSs009892 for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 May 2013 18:17:28 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NFNGfvJiaWgc for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 May 2013 18:17:28 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r48HHNnd009885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 May 2013 18:17:25 +0100
Message-ID: <1368033293.27116.92.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 08 May 2013 18:14:53 +0100
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: [PATCH] utils: Improve better_exec traceback handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 08 May 2013 17:33:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



The current bitbake tracebacks are hard to read/confusing and sometimes
incomplete. This patch attempts to do better by:

* Moving the note about the exact exception to the end to make things
  read in sequence
* Merged the initial stack trace to become part of the code dump
* Added handling for "/xxxx" file paths since we can load these files
  and include the data as part of the trace
* Dropped the ERROR: prefix to every line, allowing the error messages to
  be spacially accosicated in the UIs
* Moved the "From:" line to the top of each code block and ensured its present
  consistently

With the complexity now in this funciton, I've added try/except wrapping around
it to ensure we catch exceptions in the exception handler too.

Example before:

"""
ERROR: Error executing a python function in /media/build1/poky/meta/recipes-core/eglibc/eglibc-initial_2.17.bb:
TypeError: 'filter' object is not subscriptable

ERROR: The stack trace of python calls that resulted in this exception/failure was:
ERROR:   File "do_populate_lic", line 13, in <module>
ERROR:
ERROR:   File "do_populate_lic", line 6, in do_populate_lic
ERROR:
ERROR:   File "license.bbclass", line 99, in find_license_files
ERROR:
ERROR:   File "/media/build1/poky/meta/lib/oe/license.py", line 38, in visit_string
ERROR:     if pos > 0 and license_pattern.match(elements[pos-1]):
ERROR:
ERROR: The code that was being executed was:
ERROR:      0009:    destdir = os.path.join(d.getVar('LICSSTATEDIR', True), d.getVar('PN', True))
ERROR:      0010:    copy_license_files(lic_files_paths, destdir)
ERROR:      0011:
ERROR:      0012:
ERROR:  *** 0013:do_populate_lic(d)
ERROR:      0014:
ERROR: [From file: 'do_populate_lic', lineno: 13, function: <module>]
ERROR:      0002:def do_populate_lic(d):
ERROR:      0003:    """
ERROR:      0004:    Populate LICENSE_DIRECTORY with licenses.
ERROR:      0005:    """
ERROR:  *** 0006:    lic_files_paths = find_license_files(d)
ERROR:      0007:
ERROR:      0008:    # The base directory we wrangle licenses to
ERROR:      0009:    destdir = os.path.join(d.getVar('LICSSTATEDIR', True), d.getVar('PN', True))
ERROR:      0010:    copy_license_files(lic_files_paths, destdir)
ERROR: [From file: 'do_populate_lic', lineno: 6, function: do_populate_lic]
ERROR:      0095:        lic_files_paths.append((os.path.basename(path), srclicfile))
ERROR:      0096:
ERROR:      0097:    v = FindVisitor()
ERROR:      0098:    try:
ERROR:  *** 0099:        v.visit_string(license_types)
ERROR:      0100:    except oe.license.InvalidLicense as exc:
ERROR:      0101:        bb.fatal('%s: %s' % (d.getVar('PF', True), exc))
ERROR:      0102:    except SyntaxError:
ERROR:      0103:        bb.warn("%s: Failed to parse it's LICENSE field." % (d.getVar('PF', True)))
ERROR: [From file: 'license.bbclass', lineno: 99, function: find_license_files]
ERROR: Function failed: do_populate_lic
ERROR: Logfile of failure stored in: /media/build1/poky/build/tmp/work/i586-poky-linux/eglibc-initial/2.17-r3/temp/log.do_populate_lic.17442
"""

Example after:

"""
ERROR: Error executing a python function in /media/build1/poky/meta/recipes-core/eglibc/eglibc-initial_2.17.bb:

The stack trace of python calls that resulted in this exception/failure was:
File: 'do_populate_lic', lineno: 13, function: <module>
     0009:    destdir = os.path.join(d.getVar('LICSSTATEDIR', True), d.getVar('PN', True))
     0010:    copy_license_files(lic_files_paths, destdir)
     0011:
     0012:
 *** 0013:do_populate_lic(d)
     0014:
File: 'do_populate_lic', lineno: 6, function: do_populate_lic
     0002:def do_populate_lic(d):
     0003:    """
     0004:    Populate LICENSE_DIRECTORY with licenses.
     0005:    """
 *** 0006:    lic_files_paths = find_license_files(d)
     0007:
     0008:    # The base directory we wrangle licenses to
     0009:    destdir = os.path.join(d.getVar('LICSSTATEDIR', True), d.getVar('PN', True))
     0010:    copy_license_files(lic_files_paths, destdir)
File: 'license.bbclass', lineno: 99, function: find_license_files
     0095:        lic_files_paths.append((os.path.basename(path), srclicfile))
     0096:
     0097:    v = FindVisitor()
     0098:    try:
 *** 0099:        v.visit_string(license_types)
     0100:    except oe.license.InvalidLicense as exc:
     0101:        bb.fatal('%s: %s' % (d.getVar('PF', True), exc))
     0102:    except SyntaxError:
     0103:        bb.warn("%s: Failed to parse it's LICENSE field." % (d.getVar('PF', True)))
File: '/media/build1/poky/meta/lib/oe/license.py', lineno: 38, function: visit_string
     0034:        new_elements = []
     0035:        elements = filter(lambda x: x.strip(), license_operator.split(licensestr))
     0036:        for pos, element in enumerate(elements):
     0037:            if license_pattern.match(element):
 *** 0038:                if pos > 0 and license_pattern.match(elements[pos-1]):
     0039:                    new_elements.append('&')
     0040:                element = '"' + element + '"'
     0041:            elif not license_operator.match(element):
     0042:                raise InvalidLicense(element)
Exception: TypeError: 'filter' object is not subscriptable

ERROR: Function failed: do_populate_lic
ERROR: Logfile of failure stored in: /media/build1/poky/build/tmp/work/i586-poky-linux/eglibc-initial/2.17-r3/temp/log.do_populate_lic.3275
ERROR: Task 9 (/media/build1/poky/meta/recipes-core/eglibc/eglibc-initial_2.17.bb, do_populate_lic) failed with exit code '1
"""

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index d671f56..9d7a32f 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -236,14 +236,16 @@ def _print_trace(body, line):
     """
     Print the Environment of a Text Body
     """
+    error = []
     # print the environment of the method
     min_line = max(1, line-4)
     max_line = min(line + 4, len(body))
-    for i in xrange(min_line, max_line + 1):
+    for i in range(min_line, max_line + 1):
         if line == i:
-            logger.error(' *** %.4d:%s', i, body[i-1])
+            error.append(' *** %.4d:%s' % (i, body[i-1].rstrip()))
         else:
-            logger.error('     %.4d:%s', i, body[i-1])
+            error.append('     %.4d:%s' % (i, body[i-1].rstrip()))
+    return error
 
 def better_compile(text, file, realfile, mode = "exec"):
     """
@@ -260,7 +262,7 @@ def better_compile(text, file, realfile, mode = "exec"):
         if e.lineno:
             logger.error("The lines leading to this error were:")
             logger.error("\t%d:%s:'%s'", e.lineno, e.__class__.__name__, body[e.lineno-1])
-            _print_trace(body, e.lineno)
+            logger.error("\n".join(_print_trace(body, e.lineno)))
         else:
             logger.error("The function causing this error was:")
             for line in body:
@@ -269,68 +271,84 @@ def better_compile(text, file, realfile, mode = "exec"):
         e = bb.BBHandledException(e)
         raise e
 
-def better_exec(code, context, text = None, realfile = "<code>"):
-    """
-    Similiar to better_compile, better_exec will
-    print the lines that are responsible for the
-    error.
-    """
-    import bb.parse
-    if not text:
-        text = code
-    if not hasattr(code, "co_filename"):
-        code = better_compile(code, realfile, realfile)
+def _print_exception(t, value, tb, realfile, text, context):
+    error = []
     try:
-        exec(code, _context, context)
-    except Exception as e:
-        (t, value, tb) = sys.exc_info()
-
-        if t in [bb.parse.SkipPackage, bb.build.FuncFailed]:
-            raise
-
         import traceback
         exception = traceback.format_exception_only(t, value)
-        logger.error('Error executing a python function in %s:\n%s',
-                     realfile, ''.join(exception))
+        error.append('Error executing a python function in %s:\n' % realfile)
 
         # Strip 'us' from the stack (better_exec call)
         tb = tb.tb_next
 
         textarray = text.split('\n')
-        linefailed = traceback.tb_lineno(tb)
 
-        tbextract = traceback.extract_tb(tb)
-        tbformat = "\n".join(traceback.format_list(tbextract))
-        logger.error("The stack trace of python calls that resulted in this exception/failure was:")
-        for line in tbformat.split('\n'):
-            logger.error(line)
+        linefailed = tb.tb_lineno
 
-        logger.error("The code that was being executed was:")
-        _print_trace(textarray, linefailed)
-        logger.error("[From file: '%s', lineno: %s, function: %s]", tbextract[0][0], tbextract[0][1], tbextract[0][2])
+        tbextract = traceback.extract_tb(tb)
+        tbformat = traceback.format_list(tbextract)
+        error.append("The stack trace of python calls that resulted in this exception/failure was:")
+        error.append("File: '%s', lineno: %s, function: %s" % (tbextract[0][0], tbextract[0][1], tbextract[0][2]))
+        error.extend(_print_trace(textarray, linefailed))
 
         # See if this is a function we constructed and has calls back into other functions in
         # "text". If so, try and improve the context of the error by diving down the trace
         level = 0
         nexttb = tb.tb_next
         while nexttb is not None and (level+1) < len(tbextract):
+            error.append("File: '%s', lineno: %s, function: %s" % (tbextract[level+1][0], tbextract[level+1][1], tbextract[level+1][2]))
             if tbextract[level][0] == tbextract[level+1][0] and tbextract[level+1][2] == tbextract[level][0]:
-                _print_trace(textarray, tbextract[level+1][1])
-                logger.error("[From file: '%s', lineno: %s, function: %s]", tbextract[level+1][0], tbextract[level+1][1], tbextract[level+1][2])
+                # The code was possibly in the string we compiled ourselves
+                error.extend(_print_trace(textarray, tbextract[level+1][1]))
+            elif tbextract[level+1][0].startswith("/"):
+                # The code looks like it might be in a file, try and load it
+                try:
+                    with open(tbextract[level+1][0], "r") as f:
+                        text = f.readlines()
+                        error.extend(_print_trace(text, tbextract[level+1][1]))
+                except:
+                    error.append(tbformat[level+1])
             elif "d" in context and tbextract[level+1][2]:
+                # Try and find the code in the datastore based on the functionname
                 d = context["d"]
                 functionname = tbextract[level+1][2]
                 text = d.getVar(functionname, True)
                 if text:
-                    _print_trace(text.split('\n'), tbextract[level+1][1])
-                    logger.error("[From file: '%s', lineno: %s, function: %s]", tbextract[level+1][0], tbextract[level+1][1], tbextract[level+1][2])
+                    error.extend(_print_trace(text.split('\n'), tbextract[level+1][1]))
                 else:
-                    break
+                    error.append(tbformat[level+1])
             else:
-                 break
+                error.append(tbformat[level+1])
             nexttb = tb.tb_next
             level = level + 1
 
+        error.append("Exception: %s" % ''.join(exception))
+    finally:
+        logger.error("\n".join(error))
+
+def better_exec(code, context, text = None, realfile = "<code>"):
+    """
+    Similiar to better_compile, better_exec will
+    print the lines that are responsible for the
+    error.
+    """
+    import bb.parse
+    if not text:
+        text = code
+    if not hasattr(code, "co_filename"):
+        code = better_compile(code, realfile, realfile)
+    try:
+        exec(code, _context, context)
+    except Exception as e:
+        (t, value, tb) = sys.exc_info()
+
+        if t in [bb.parse.SkipPackage, bb.build.FuncFailed]:
+            raise
+        try:
+            _print_exception(t, value, tb, realfile, text, context)
+        except Exception as e:
+            logger.error("Exception handler error: %s" % str(e))
+
         e = bb.BBHandledException(e)
         raise e
 




