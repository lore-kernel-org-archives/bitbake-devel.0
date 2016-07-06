Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id A330A6E65F
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 11:00:45 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 73EBAA2550;
	Wed,  6 Jul 2016 11:00:46 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-37-2-55.us-west-2.compute.internal [10.37.2.55])
	by relay.mailchannels.net (Postfix) with ESMTPA id 1CAEDA25F3;
	Wed,  6 Jul 2016 11:00:46 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.107.128.240])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 11:00:46 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467802846356:1168516532
X-MC-Ingress-Time: 1467802846356
Received: from [176.251.41.101] (port=50296 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKkc6-00073u-OS; Wed, 06 Jul 2016 07:03:31 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 12:00:35 +0100
Message-Id: <7fad9160ca998496af82747fc7fe69d0f5886e94.1467802608.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
References: <a7d2770e95b9c7987a55cdf0b88effc7ffcecd3a.1467802608.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467802608.git.elliot.smith@intel.com>
References: <cover.1467802608.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 7/7] buildinfohelper: ensure task datetimes are timezone-aware
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
X-List-Received-Date: Wed, 06 Jul 2016 11:00:46 -0000

When using toaster-eventreplay to run a bitbake event file
through toasterui/buildinfohelper, errors occur when the
tasks are updated with buildstats info:

  RuntimeWarning: DateTimeField Task.started received a naive
  datetime (2016-07-06 09:15:22.070000) while time zone support
  is active.

This is because a method in buildinfohelper returns a naive
datetime, but Django is expecting timezone-aware datetimes.

Ensure that datetimes used to set the started/ended times on
tasks are converted to timezone-aware datetimes.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index d5ba629..447670c 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -125,7 +125,7 @@ class ORMWrapper(object):
         """
         Convert timestamp in seconds to Python datetime
         """
-        return datetime(1970, 1, 1) + timedelta(seconds=secs)
+        return timezone.make_aware(datetime(1970, 1, 1) + timedelta(seconds=secs))
 
     # pylint: disable=no-self-use
     # we disable detection of no self use in functions because the methods actually work on the object
-- 
2.7.4


