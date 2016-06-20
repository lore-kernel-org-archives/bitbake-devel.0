Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id AB2D06014F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 11:01:48 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 20 Jun 2016 04:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="722189806"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2016 04:01:48 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id BDBB06A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 04:01:46 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2016 14:00:49 +0300
Message-Id: <78946dfaf3e339a45e4022f64d8923996831e97b.1466419987.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1466419987.git.ed.bartosh@linux.intel.com>
References: <cover.1466419987.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/5] cooker: encode event objects to base64
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
X-List-Received-Date: Mon, 20 Jun 2016 11:01:49 -0000

pickle converts python objects into the binary form that can't be
decoded to text and therefore can't be converted to JSON format.

Attempt to convert event objects raises this error:
TypeError:
    b'\x80\x03cbb.runqueue\nrunQueueTaskSkipped\nq\x00)...
    is not JSON serializable

Encoded pickled event objects to base64 to be able to convert data
structure to JSON.

[YOCTO #9803]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index b2cf0cd..2de6b3e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -44,6 +44,7 @@ import prserv.serv
 import pyinotify
 import json
 import pickle
+import codecs
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")
@@ -143,7 +144,9 @@ class EventLogWriteHandler:
         def write_event(self, event):
             with open(self.eventfile, "a") as f:
                 try:
-                    f.write("%s\n" % json.dumps({"class":event.__module__ + "." + event.__class__.__name__, "vars":json.dumps(pickle.dumps(event)) }))
+                    str_event = codecs.encode(pickle.dumps(event), 'base64').decode('utf-8')
+                    f.write("%s\n" % json.dumps({"class": event.__module__ + "." + event.__class__.__name__,
+                                                 "vars": str_event}))
                 except Exception as e:
                     import traceback
                     print(e, traceback.format_exc())
-- 
2.1.4


