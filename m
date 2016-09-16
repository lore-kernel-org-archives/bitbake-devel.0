Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id A71A073D27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:51 +0000 (UTC)
Received: by mail-pa0-f44.google.com with SMTP id id6so27412717pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=b2VzoFSszCEXJJ8tqfWRiGa0Ya/6xdB6N4C1ewvtRlU=;
	b=1SuZO8wz6ss0e/+X94uc5zXiV09FoHAVQ1pS/ZQXbqRxDxoUpyoJviPW5vk2r/Z4Ja
	FuZYc4/Kq9wKW6IenIkhhbtszhmKO7RMOQmrO5E70wDnsyAIz6QtzCRYC532Roaxy7q8
	QeLA4ZKFHplg7WwhQxFwEJkGYSeb4/YMTwrjdp7tVbFoyzIWOKC3V73SHvcVsWc6/lj5
	z2oQl5mtBlOBeHpdDXiy7MAxSPPfDoE5ta+UqJ0VWRy8Jh5J1Pb9bQWGNIE8FGCeeDsf
	apPEjEmwdeC2KjUvoChWYHePGwOlzGSZZZvbpNzGfquf+f5Gv//PnOcqMFN2vj2XMVGQ
	gzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=b2VzoFSszCEXJJ8tqfWRiGa0Ya/6xdB6N4C1ewvtRlU=;
	b=Gx2Cu1pQ6SXA1R7URdilpJhMoSTMu6C+EhPVrvHNc0nzhVpBDtO7sn/YoOUCdtvqaP
	OuVp0WP5JgB3WZyP2rtNu9KY6DtI1nRdpp2B6wN4KlfKpsLy7+3uOKlPmPH8Oq6SIVnt
	Bg+awvekX375rKAY1wj2Qg5O0cTOfKgWCQu6J7s8PWmzssPOGIAlMPgjCsOHZGG8y5iY
	JMqsymbO1bdH39Er63TbDku9WmGH7L9UQLxVroTgIdj0BtgB8BtXzWQuXmeonk5JanQm
	rFP4W4+aL97ywxn2FASgI+MzQuRquaxIzSwDa0SNX2E0gfigoB6ap4xSy+EVAtdvIerD
	wKRw==
X-Gm-Message-State: AE9vXwMs9CsCxLXH8ALMCUne9GjPT1BGBlPipB9qhIKFeU/vEcL2U9rgWh67K2c5fcejgAcs
X-Received: by 10.66.127.14 with SMTP id nc14mr24276865pab.18.1474042972413;
	Fri, 16 Sep 2016 09:22:52 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:51 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:31 +0100
Message-Id: <1474042955-12618-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
References: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 4/8] runbuilds: process builds on SIGUSR1
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
X-List-Received-Date: Fri, 16 Sep 2016 16:22:51 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Run main processing function 'runbuild' only if SIGUSR1 is
received. This signal is sent by Toaster when build status
is changed (either started, cancelled or finished).

This should stop continuous database polling as run_builds function
will be called only when needed, i.e. after build status is changed.

[YOCTO #8918]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/management/commands/runbuilds.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index a703770..61a520c 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -11,9 +11,9 @@ from orm.models import Build, ToasterSetting, LogMessage, Target
 
 import os
 import logging
-import time
 import sys
 import traceback
+import signal
 
 logger = logging.getLogger("toaster")
 
@@ -175,6 +175,8 @@ class Command(NoArgsCommand):
             logger.warn("runbuilds: schedule exception %s" % str(e))
 
     def handle_noargs(self, **options):
+        signal.signal(signal.SIGUSR1, lambda sig, frame: None)
+
         while True:
+            signal.pause()
             self.runbuild()
-            time.sleep(1)
-- 
2.7.4


