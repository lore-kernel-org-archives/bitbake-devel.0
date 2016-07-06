Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id 1B8AA6013D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 11:08:06 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B6B9E122744;
	Wed,  6 Jul 2016 11:00:43 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-123-105-117.us-west-2.compute.internal [10.123.105.117])
	by relay.mailchannels.net (Postfix) with ESMTPA id 4EAF4122544;
	Wed,  6 Jul 2016 11:00:43 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 11:00:43 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467802843633:62093945
X-MC-Ingress-Time: 1467802843632
Received: from [176.251.41.101] (port=50296 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKkc3-00073u-UL; Wed, 06 Jul 2016 07:03:28 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 12:00:32 +0100
Message-Id: <49fc9b73ef79d1ed7fdf61361c0bcdf247765fe9.1467802608.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
References: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467802608.git.elliot.smith@intel.com>
References: <cover.1467802608.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 4/7] eventreplay: replace MockConfigParameters with namedtuple
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
X-List-Received-Date: Wed, 06 Jul 2016 11:08:07 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

class MockConfigParameters has only one attribute and only __init__
method. Replacing it with namedtuple makes code less nested and more
readable.

[YOCTO #9585]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster-eventreplay | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index a107298..b9ab79e 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -30,6 +30,7 @@ from __future__ import print_function
 import os
 import sys, logging
 import codecs
+from collections import namedtuple
 
 # mangle syspath to allow easy import of modules
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
@@ -159,17 +160,6 @@ class FileReadEventsServerConnection():
 
         self.events = FileReadEventsServerConnection.EventReader(self)
 
-
-
-
-
-class MockConfigParameters():
-    """ stand-in for cookerdata.ConfigParameters; as we don't really config a cooker, this
-        serves just to supply needed interfaces for the toaster ui to work """
-    def __init__(self):
-        self.observe_only = True            # we can only read files
-
-
 # run toaster ui on our mock bitbake class
 if __name__ == "__main__":
     if len(sys.argv) < 2:
@@ -178,7 +168,7 @@ if __name__ == "__main__":
 
     file_name = sys.argv[-1]
     mock_connection = FileReadEventsServerConnection(file_name)
-    configParams = MockConfigParameters()
+    configParams = namedtuple('ConfigParams', ['observe_only'])(True)
 
     # run the main program and set exit code to the returned value
     sys.exit(toasterui.main(mock_connection.connection, mock_connection.events, configParams))
-- 
2.7.4


