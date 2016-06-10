Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A35A960851
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jun 2016 11:58:28 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 10 Jun 2016 04:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,449,1459839600"; d="scan'208";a="999246423"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2016 04:58:28 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id C29196A4006;
	Fri, 10 Jun 2016 05:45:53 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jun 2016 14:58:17 +0300
Message-Id: <1465559897-15922-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1465552194-10841-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1465552194-10841-1-git-send-email-ed.bartosh@linux.intel.com>
Cc: Ed Bartosh <eduard.bartosh@intel.com>
Subject: [PATCH v2] bitbake: fix wrong usage of format_exc
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
X-List-Received-Date: Fri, 10 Jun 2016 11:58:28 -0000

From: Ed Bartosh <eduard.bartosh@intel.com>

First parameter of traceback.format_exc is a 'limit' - a number
of stracktraces to format.

Passing exception object to format_exc is incorrect, but it works in
Python 2 as this code from traceback module works:
    while tb is not None and (limit is None or n < limit):
Comparing integer counter n with the exception object in Python 2
always results in True. However, in Python 3 it throws exception:
    TypeError: unorderable types: int() < <Exception type>()

As format_exc is used in except block of handling another
exception this can cause hard to find and debug bugs.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/bb/cooker.py     | 2 +-
 lib/bb/ui/uievent.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2154ef4..08dc1fb 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -330,7 +330,7 @@ class BBCooker:
                                 f.write("%s\n" % json.dumps({"class":event.__module__ + "." + event.__class__.__name__, "vars":json.dumps(pickle.dumps(event)) }))
                             except Exception as e:
                                 import traceback
-                                print(e, traceback.format_exc(e))
+                                print(e, traceback.format_exc())
 
 
                     def send(self, event):
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


