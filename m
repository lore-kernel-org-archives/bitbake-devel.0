Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SXYB2-0004a4-WE for bitbake-devel@lists.openembedded.org;
	Thu, 24 May 2012 15:34:05 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4ODNssi023989
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 14:23:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 23145-04 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 14:23:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4ODNiRK023983
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 14:23:45 +0100
Message-ID: <1337865824.8248.112.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 May 2012 14:23:44 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/exceptions: Handle reports from the field of exception code failures
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
X-List-Received-Date: Thu, 24 May 2012 13:34:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Despite using python 2.6, there have been reports of issues where
bitbake is printing tracebacks with errors in the exception handling
code. This was masking the real error.

Since we need to do whatever we can to give the user good feedback about
errors, detect the tuple instead of namedtuple case and don't fault
in the exception handler but just give up trying to traceback any further.

In the reported cases, this gives a message the user can then understand.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/exceptions.py b/bitbake/lib/bb/exceptions.py
index 4dd3e2c..f182c8f 100644
--- a/bitbake/lib/bb/exceptions.py
+++ b/bitbake/lib/bb/exceptions.py
@@ -32,7 +32,14 @@ class TracebackEntry(namedtuple.abc):
 def _get_frame_args(frame):
     """Get the formatted arguments and class (if available) for a frame"""
     arginfo = inspect.getargvalues(frame)
-    if not arginfo.args:
+
+    try:
+        if not arginfo.args:
+            return '', None
+    # There have been reports from the field of python 2.6 which doesn't 
+    # return a namedtuple here but simply a tuple so fallback gracefully if
+    # args isn't present.
+    except AttributeError:
         return '', None
 
     firstarg = arginfo.args[0]




