Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id 50B506013D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 11:07:03 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 48225224B8;
	Wed,  6 Jul 2016 11:00:49 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-11-165.us-west-2.compute.internal [10.229.11.165])
	by relay.mailchannels.net (Postfix) with ESMTPA id DD17121B45;
	Wed,  6 Jul 2016 11:00:48 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.132.194.146])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 11:00:49 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467802849205:2288843313
X-MC-Ingress-Time: 1467802849205
Received: from [176.251.41.101] (port=50296 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKkc4-00073u-U2; Wed, 06 Jul 2016 07:03:29 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 12:00:33 +0100
Message-Id: <c2d4769d6b8c37ec2e5e76fd199f60e6bc813be0.1467802608.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
References: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467802608.git.elliot.smith@intel.com>
References: <cover.1467802608.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 5/7] eventreplay: reorganize imports
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
X-List-Received-Date: Wed, 06 Jul 2016 11:07:05 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Cleaned up module imports:
- Removed unused imports
- Removed import of print_function
- Removed duplicated imports
- Splitted importing bb.lib to 2 lines

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster-eventreplay | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index b9ab79e..7de3967 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -26,24 +26,19 @@
 # as a build eventlog, and the ToasterUI is used to process events in the file
 # and log data in the database
 
-from __future__ import print_function
-import os
-import sys, logging
+import sys
+import json
+import pickle
 import codecs
+
 from collections import namedtuple
 
 # mangle syspath to allow easy import of modules
-sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
-                                'lib'))
-
+from os.path import join, dirname, abspath
+sys.path.insert(0, join(dirname(dirname(abspath(__file__))), 'lib'))
 
 import bb.cooker
 from bb.ui import toasterui
-import sys
-import logging
-
-import json, pickle
-
 
 class FileReadEventsServerConnection():
     """  Emulates a connection to a bitbake server that feeds
-- 
2.7.4


