Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9762A75791
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 10:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6OAf9pU020898 for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:41:09 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aMsSEkT-fCj1 for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:41:09 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6OAetPR020891
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jul 2015 11:41:07 +0100
Message-ID: <1437734455.821.151.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 24 Jul 2015 11:40:55 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Improve performance of infer_caller_details()
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
X-List-Received-Date: Fri, 24 Jul 2015 10:41:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

As things stand now, bitbake -e (which turns on all the caller tracking)
of OE-Core generates around 9.5 million stat calls which is slow and the
largest single thing on the profile data.

This is because infer_caller_details() calls traceback.extract_stack()
which adds line contents to the traceback. This in turn calls python's
internal linecache code which calls stat on every file for every callback.
We don't even use that info. We only even want a single frame of the stack.

Instead, open code for the pieces of information we need. Also, only
obtain the stack once for both halves of the infer_caller_details()
code.

This reduces the number of stat calls to around 0.5 million and significantly
improves parsing with bitbake -e.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index a93f06c..da846fc 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -54,27 +54,36 @@ def infer_caller_details(loginfo, parent = False, varval = True):
         return
     # Infer caller's likely values for variable (var) and value (value), 
     # to reduce clutter in the rest of the code.
-    if varval and ('variable' not in loginfo or 'detail' not in loginfo):
+    above = None
+    def set_above():
         try:
             raise Exception
         except Exception:
             tb = sys.exc_info()[2]
             if parent:
-                above = tb.tb_frame.f_back.f_back
+                return tb.tb_frame.f_back.f_back.f_back
             else:
-                above = tb.tb_frame.f_back
-            lcls = above.f_locals.items()
+                return tb.tb_frame.f_back.f_back
+
+    if varval and ('variable' not in loginfo or 'detail' not in loginfo):
+        if not above:
+            above = set_above()
+        lcls = above.f_locals.items()
         for k, v in lcls:
             if k == 'value' and 'detail' not in loginfo:
                 loginfo['detail'] = v
             if k == 'var' and 'variable' not in loginfo:
                 loginfo['variable'] = v
     # Infer file/line/function from traceback
+    # Don't use traceback.extract_stack() since it fills the line contents which
+    # we don't need and that hits stat syscalls
     if 'file' not in loginfo:
-        depth = 3    
-        if parent:
-            depth = 4
-        file, line, func, text = traceback.extract_stack(limit = depth)[0]
+        if not above:
+            above = set_above()
+        f = above.f_back
+        line = f.f_lineno
+        file = f.f_code.co_filename
+        func = f.f_code.co_name
         loginfo['file'] = file
         loginfo['line'] = line
         if func not in loginfo:



