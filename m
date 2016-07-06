Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id ACDC56013D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 11:00:42 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D3A54E1A9F;
	Wed,  6 Jul 2016 11:00:41 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-11-165.us-west-2.compute.internal [10.229.11.165])
	by relay.mailchannels.net (Postfix) with ESMTPA id 5EFAEE2606;
	Wed,  6 Jul 2016 11:00:41 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.132.194.146])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 11:00:41 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467802841694:3400427938
X-MC-Ingress-Time: 1467802841694
Received: from [176.251.41.101] (port=50296 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKkc1-00073u-W0; Wed, 06 Jul 2016 07:03:26 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 12:00:30 +0100
Message-Id: <c6a2625d57a2eeb2b90ad4c1c29d1294db2be125.1467802608.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
References: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467802608.git.elliot.smith@intel.com>
References: <cover.1467802608.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 2/7] eventprelay: implement setEventMask command
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
X-List-Received-Date: Wed, 06 Jul 2016 11:00:42 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Stored event mask list as self.eventmask for future use.
Fixed Exception: Command setEventMask not implemented.

[YOCTO #9585]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster-eventreplay | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index 14f4f00..03b5dde 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -53,6 +53,7 @@ class FileReadEventsServerConnection():
         """
         def __init__(self, sc):
             self._sc = sc
+            self.eventmask = []
 
         def runCommand(self, commandArray):
             """ emulates running a command on the server; only read-only commands are accepted """
@@ -79,6 +80,11 @@ class FileReadEventsServerConnection():
                     except Exception as e:
                         print(e)
                 return (dump, None)
+
+            elif command_name == 'setEventMask':
+                self.eventmask = commandArray[-1]
+                return True, None
+
             else:
                 raise Exception("Command %s not implemented" % commandArray[0])
 
-- 
2.7.4


