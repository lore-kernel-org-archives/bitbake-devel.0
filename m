Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CC8456FA94
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:58:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4UEw1H5012442 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:58:01 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wA1V-Nd3Vtsq for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:58:01 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4UEvw1W012419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 15:57:59 +0100
Message-ID: <1401461870.31309.54.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 May 2014 15:57:50 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: bb.fatal: Raise a BBHandledException instead of exiting
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
X-List-Received-Date: Fri, 30 May 2014 14:58:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

With new bitbake UIs having the cooker exit at 'random' points
in the codebase is problematic. This patch raises an exception
which matches the situation instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index 1478dd2..84f6ec3 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -99,8 +99,7 @@ def error(*args):
 
 def fatal(*args):
     logger.critical(''.join(args))
-    sys.exit(1)
-
+    raise BBHandledException()
 
 def deprecated(func, name=None, advice=""):
     """This is a decorator which can be used to mark functions




