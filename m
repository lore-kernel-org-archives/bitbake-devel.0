Return-Path: <elliot.smith@intel.com>
Received: from gainsboro.cherry.relay.mailchannels.net
	(gainsboro.cherry.relay.mailchannels.net [23.83.223.65])
	by mail.openembedded.org (Postfix) with ESMTP id 04FDC73167
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 11:00:44 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C1C871276AB;
	Wed,  6 Jul 2016 11:00:42 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-220-9-73.us-west-2.compute.internal [10.220.9.73])
	by relay.mailchannels.net (Postfix) with ESMTPA id 515C0127B1E;
	Wed,  6 Jul 2016 11:00:42 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.135.9.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 11:00:42 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467802842657:3732390302
X-MC-Ingress-Time: 1467802842657
Received: from [176.251.41.101] (port=50296 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKkc2-00073u-Vp; Wed, 06 Jul 2016 07:03:27 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 12:00:31 +0100
Message-Id: <72320922623388f4e478002202d4e7c90a59311f.1467802608.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
References: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467802608.git.elliot.smith@intel.com>
References: <cover.1467802608.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 3/7] eventreplay: fix event loading code
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
X-List-Received-Date: Wed, 06 Jul 2016 11:00:47 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Event objects are represented by base64-encoded strings in
the event file and can't be loaded by existing eventreplay code.

Fixed the code of loading events from file by decoding base64 strings
into the binary form and loading them with pickle.load.

[YOCTO #9585]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster-eventreplay | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index 03b5dde..a107298 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -29,6 +29,7 @@
 from __future__ import print_function
 import os
 import sys, logging
+import codecs
 
 # mangle syspath to allow easy import of modules
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
@@ -117,7 +118,8 @@ class FileReadEventsServerConnection():
             try:
                 event_data = json.loads(line.strip())
                 event_class = _import_class(event_data['class'])
-                event_object = pickle.loads(json.loads(event_data['vars']))
+                event_str = event_data['vars'].encode('utf-8')
+                event_object = pickle.loads(codecs.decode(event_str, 'base64'))
             except ValueError as e:
                 print("Failed loading ", line)
                 raise e
-- 
2.7.4


