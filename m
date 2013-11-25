Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 207606DD25
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 21:21:36 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rAPLLZ9j015173
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 13:21:36 -0800 (PST)
Received: from ord-jrw.corp.ad.wrs.com (172.25.32.36) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.2.347.0; Mon, 25 Nov 2013 13:21:35 -0800
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 15:21:29 -0600
Message-ID: <1385414489-2901-6-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
References: <1385414489-2901-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 5/5] oe-init-build-env-memres: Add auto port functionality
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
X-List-Received-Date: Mon, 25 Nov 2013 21:21:36 -0000
Content-Type: text/plain

In order to run multiple bitbake memory resident servers on the same
machine they must each use different ports.

This patch works in conjuction with bitbake to make the auto port
selection and lazy server startup the default.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 oe-init-build-env-memres |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/oe-init-build-env-memres b/oe-init-build-env-memres
index 687d5e1..0007998 100755
--- a/oe-init-build-env-memres
+++ b/oe-init-build-env-memres
@@ -26,8 +26,8 @@
 # to sourcing this script.
 #
 if [ -z "$1" ]; then
-    echo "No port specified, using 12345"
-    port=12345
+    echo "No port specified, using dynamically selected port"
+    port=-1
 else
     port=$1
     shift
@@ -60,15 +60,20 @@ if [ -e bitbake.lock ] && grep : bitbake.lock > /dev/null ; then
     res=$?
 fi
 
-if [ $res != 0 ] ; then
-    bitbake --server-only -t xmlrpc -B localhost:$port
-fi
+if [ $port = -1 ] ; then
+    export BBSERVER=localhost:-1
+    echo "Bitbake server started on demand as needed, use bitbake -m to shut it down"
+else
+    if [ $res != 0 ] ; then
+	bitbake --server-only -t xmlrpc -B localhost:$port
+    fi
 
-export BBSERVER=`cat bitbake.lock`
+    export BBSERVER=`cat bitbake.lock`
 
-if [ $res = 0 ] ; then
-    echo "Using existing bitbake server at: $BBSERVER, use bitbake -m to shut it down"
-else
-    echo "Bitbake server started at: $BBSERVER, use bitbake -m to shut it down"
+    if [ $res = 0 ] ; then
+	echo "Using existing bitbake server at: $BBSERVER, use bitbake -m to shut it down"
+    else
+	echo "Bitbake server started at: $BBSERVER, use bitbake -m to shut it down"
+    fi
+    unset res
 fi
-unset res
-- 
1.7.9.5


