Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4B79D70EE1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 20:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7LKlSCf021702 for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:47:28 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3q7JFvOzB_aP for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:47:28 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7LKlO6A021698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 21:47:26 +0100
Message-ID: <1408654045.1669.118.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Aug 2014 21:47:25 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] utils: Add workaround for multiprocessing bug
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
X-List-Received-Date: Thu, 21 Aug 2014 20:47:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Our usage of multitprocessing is problematic. In particular, there is a bug
in python 2.7 multiprocessing where signals are not handled until command
completion instead of immediately.

This adds a workaround into our wrapper function to deal with the issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 781af3a..11f046a 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -883,5 +883,17 @@ def process_profilelog(fn):
 # Was present to work around multiprocessing pool bugs in python < 2.7.3
 #
 def multiprocessingpool(*args, **kwargs):
+
+    import multiprocessing.pool
+    #import multiprocessing.util
+    #multiprocessing.util.log_to_stderr(10)
+    # Deal with a multiprocessing bug where signals to the processes would be delayed until the work
+    # completes. Putting in a timeout means the signals (like SIGINT/SIGTERM) get processed.
+    def wrapper(func):
+        def wrap(self, timeout=None):
+            return func(self, timeout=timeout if timeout is not None else 1e100)
+        return wrap
+    multiprocessing.pool.IMapIterator.next = wrapper(multiprocessing.pool.IMapIterator.next)
+
     return multiprocessing.Pool(*args, **kwargs)
 



