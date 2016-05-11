Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9DA00606D0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BM6tU8000453 for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:07:01 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SaGkLkJZWyNZ for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:07:01 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BM0FAs000312
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:00:16 +0100
Message-ID: <1463004015.21831.299.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 May 2016 23:00:15 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] utils: Force bitbake to en_US.UTF-8 locale setting everywhere
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
X-List-Received-Date: Wed, 11 May 2016 22:07:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Under python 3, if we spawn python processes, we need to have a UTF-8
locale, else python's file access methods will use ascii. You can't
change that mode once the interpreter is started so we have to ensure
a locale is set. Ideally we'd use C.UTF-8 since OE already forces the 
C locale but not all distros support that and we need to set something. 
Was tempted to choose en_GB so colour gets spelt correctly :).

This is in some ways pretty nasty, forcing it into the environment
everywhere however we only have a limited number of ways of making
everything work correctly and this beats having to add utf-8 encoding
to every file access command.

A similar change will be needed to bitbake.conf in OE.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 0c553dd..588c192 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -568,6 +568,7 @@ def preserved_envvars_exported():
         'SHELL',
         'TERM',
         'USER',
+        'LC_ALL',
     ]
 
 def preserved_envvars():
@@ -595,6 +596,12 @@ def filter_environment(good_vars):
         os.unsetenv(key)
         del os.environ[key]
 
+    # If we spawn a python process, we need to have a UTF-8 locale, else python's file
+    # access methods will use ascii. You can't change that mode once the interpreter is
+    # started so we have to ensure a locale is set. Ideally we'd use C.UTF-8 but not all
+    # distros support that and we need to set something.
+    os.environ["LC_ALL"] = "en_US.UTF-8"
+
     if removed_vars:
         logger.debug(1, "Removed the following variables from the environment: %s", ", ".join(removed_vars.keys()))
 



