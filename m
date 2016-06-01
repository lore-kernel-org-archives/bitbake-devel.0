Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1DF0077399
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3B8007479; Wed, 1 Jun 2016 13:37:05 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sFxYTnGDVq06; Wed,  1 Jun 2016 13:37:05 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Caxrj007470
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000pZ-KW; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:47 +0100
Message-Id: <1464784607-2985-28-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 28/28] toaster: use python3 explicitly
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:09 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Explicitly used python3 as default python for oe builds
will continue to be python2.

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/toaster | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 05b7935..be1bb9c 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -111,7 +111,7 @@ stop_system()
 
 verify_prereq() {
     # Verify Django version
-    reqfile=$(python -c "import os; print(os.path.realpath('$BBBASEDIR/toaster-requirements.txt'))")
+    reqfile=$(python3 -c "import os; print(os.path.realpath('$BBBASEDIR/toaster-requirements.txt'))")
     exp='s/Django\([><=]\+\)\([^,]\+\),\([><=]\+\)\(.\+\)/'
     exp=$exp'import sys,django;version=django.get_version().split(".");'
     exp=$exp'sys.exit(not (version \1 "\2".split(".") and version \3 "\4".split(".")))/p'
@@ -135,7 +135,7 @@ else
 fi
 
 export BBBASEDIR=`dirname $TOASTER`/..
-MANAGE=$BBBASEDIR/lib/toaster/manage.py
+MANAGE="python3 $BBBASEDIR/lib/toaster/manage.py"
 OEROOT=`dirname $TOASTER`/../..
 
 # this is the configuraton file we are using for toaster
@@ -162,7 +162,7 @@ fi
 
 if [ "$TOASTER_CONF" = "" ]; then
     TOASTER_CONF="$TEMPLATECONF/toasterconf.json"
-    export TOASTER_CONF=$(python -c "import os; print(os.path.realpath('$TOASTER_CONF'))")
+    export TOASTER_CONF=$(python3 -c "import os; print(os.path.realpath('$TOASTER_CONF'))")
 fi
 
 if [ ! -f $TOASTER_CONF ]; then
-- 
2.5.0


