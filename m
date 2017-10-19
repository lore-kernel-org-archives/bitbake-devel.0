Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 06BA478312
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Oct 2017 03:32:53 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP; 18 Oct 2017 20:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.43,399,1503385200"; d="scan'208";a="164336123"
Received: from klee4-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.148.108])
	by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2017 20:32:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Oct 2017 16:32:21 +1300
Message-Id: <0ee582a4068cf1d54d247d8da274f933055bc700.1508383917.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1508383917.git.paul.eggleton@linux.intel.com>
References: <cover.1508383917.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] cooker: fix watching directories with Python 3.6+
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
X-List-Received-Date: Thu, 19 Oct 2017 03:32:54 -0000

In Python 3.6, glob.glob() was reimplemented to use os.scandir() (which
itself appeared in Python 3.5), thus our monkey patching of os.listdir()
here was no longer effective. The end result was not only that bitbake
wouldn't notice added recipes or bbappends with BB_SERVER_TIMEOUT set
when being run with Python 3.6 (the shipped Python version on Fedora 26
and some other distribution versions), it also broke devtool modify,
devtool upgrade and devtool extract since they rely on the ability to
create a bbappend on the fly and have bitbake pick it up.

To fix it, do the same monkey patching for os.scandir(), which needs to
be conditional upon that actually existing since we have to support
Python 3.4 that doesn't have it. Long term we should probably look for a
better way to handle this that doesn't involve monkey patching Python
library code.

Fixes [YOCTO #12185].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 73a2fef..c7fdd72 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1686,15 +1686,23 @@ class CookerCollectFiles(object):
 
         # We need to track where we look so that we can add inotify watches. There
         # is no nice way to do this, this is horrid. We intercept the os.listdir()
-        # calls while we run glob().
+        # (or os.scandir() for python 3.6+) calls while we run glob().
         origlistdir = os.listdir
+        if hasattr(os, 'scandir'):
+            origscandir = os.scandir
         searchdirs = []
 
         def ourlistdir(d):
             searchdirs.append(d)
             return origlistdir(d)
 
+        def ourscandir(d):
+            searchdirs.append(d)
+            return origscandir(d)
+
         os.listdir = ourlistdir
+        if hasattr(os, 'scandir'):
+            os.scandir = ourscandir
         try:
             # Can't use set here as order is important
             newfiles = []
@@ -1714,6 +1722,8 @@ class CookerCollectFiles(object):
                             newfiles.append(g)
         finally:
             os.listdir = origlistdir
+            if hasattr(os, 'scandir'):
+                os.scandir = origscandir
 
         bbmask = config.getVar('BBMASK')
 
-- 
2.9.5


