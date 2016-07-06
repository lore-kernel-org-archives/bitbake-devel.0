Return-Path: <elliot.smith@intel.com>
Received: from gainsboro.cherry.relay.mailchannels.net
	(gainsboro.cherry.relay.mailchannels.net [23.83.223.65])
	by mail.openembedded.org (Postfix) with ESMTP id 2CDB36013D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 11:07:46 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D99FE127B7A;
	Wed,  6 Jul 2016 11:00:40 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-220-9-73.us-west-2.compute.internal [10.220.9.73])
	by relay.mailchannels.net (Postfix) with ESMTPA id 54A99127AF4;
	Wed,  6 Jul 2016 11:00:40 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.135.9.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 11:00:40 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467802840665:3665043917
X-MC-Ingress-Time: 1467802840665
Received: from [176.251.41.101] (port=50296 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKkc0-00073u-Vc; Wed, 06 Jul 2016 07:03:25 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 12:00:29 +0100
Message-Id: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1467802608.git.elliot.smith@intel.com>
References: <cover.1467802608.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 1/7] eventreplay: add MockConnection.getEventHandle method
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
X-List-Received-Date: Wed, 06 Jul 2016 11:07:51 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed AttributeError: 'MockConnection' object has no attribute
'getEventHandle'

[YOCTO #9585]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster-eventreplay | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bin/toaster-eventreplay b/bin/toaster-eventreplay
index bdddb90..14f4f00 100755
--- a/bin/toaster-eventreplay
+++ b/bin/toaster-eventreplay
@@ -86,6 +86,8 @@ class FileReadEventsServerConnection():
             """ do not do anything """
             pass
 
+        def getEventHandle(self):
+            pass
 
 
     class EventReader():
-- 
2.7.4


