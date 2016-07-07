Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 31514606D0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jul 2016 13:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u67DRjZf000375; Thu, 7 Jul 2016 14:27:45 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ljwSMXzpbRDR; Thu,  7 Jul 2016 14:27:45 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u67DRhn5000371
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Jul 2016 14:27:45 +0100
Message-ID: <1467898063.8590.225.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 07 Jul 2016 14:27:43 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "Eggleton, Paul" <paul.eggleton@intel.com>
Subject: [PATCH] progress: Ensure missing start event is fired
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
X-List-Received-Date: Thu, 07 Jul 2016 13:27:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The init function of the parent class fires a progress event for 0
progress rather than a start event. UI code was assuming that progress
events should always have a start event first. This change ensures that
the start event is correctly generated.

This fixes crashes that were seen in knotty in some configurations.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/progress.py b/bitbake/lib/bb/progress.py
index 4941776..ee6b953 100644
--- a/bitbake/lib/bb/progress.py
+++ b/bitbake/lib/bb/progress.py
@@ -209,6 +209,9 @@ class MultiStageProcessProgressReporter(MultiStageProgressReporter):
         bb.event.fire(bb.event.ProcessStarted(self._processname, 100), self._data)
 
     def _fire_progress(self, taskprogress):
+        if taskprogress == 0:
+            self.start()
+            return
         bb.event.fire(bb.event.ProcessProgress(self._processname, taskprogress), self._data)
 
     def finish(self):




