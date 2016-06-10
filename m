Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id DCA6A6E688
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jun 2016 09:50:07 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 10 Jun 2016 02:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,449,1459839600"; d="scan'208";a="972883710"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 10 Jun 2016 02:50:08 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 249646A4006;
	Fri, 10 Jun 2016 03:37:32 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jun 2016 12:49:54 +0300
Message-Id: <1465552194-10841-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Cc: Ed Bartosh <eduard.bartosh@intel.com>
Subject: [PATCH] bitbake: fix wrong usage of format_exc
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
X-List-Received-Date: Fri, 10 Jun 2016 09:50:09 -0000

From: Ed Bartosh <eduard.bartosh@intel.com>

First parameter of traceback.format_exc APIs is a 'limit' - a
number of stracktraces to print.

Passing exception object to print_exc or format_exc is incorrect,
but it works in Python 2 and causes printing only one line of traceback
as exception object is compared with the integer counter in the
traceback module code.

In Python 3 comparison of integer and exception object throws
an exception:
    TypeError: unorderable types: int() < <Exception type>()

As format_exc is used in except block of handling another
exception this can cause hard to find and debug bugs.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/bb/ui/uievent.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index ca19166..9542b91 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -116,7 +116,7 @@ class BBUIEventQueue:
                 self.server.handle_request()
             except Exception as e:
                 import traceback
-                logger.error("BBUIEventQueue.startCallbackHandler: Exception while trying to handle request: %s\n%s" % (e, traceback.format_exc(e)))
+                logger.error("BBUIEventQueue.startCallbackHandler: Exception while trying to handle request: %s\n%s" % (e, traceback.format_exc()))
 
         self.server.server_close()
 
-- 
2.1.4


