Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 71E5160053
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Sep 2015 20:56:23 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so85955566pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Sep 2015 13:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=03ZoFdn5X0dc7bvrPpZwr25MhA9MqVukqWrZ2T5RDeo=;
	b=Yo8mvufm9IE7PUzHNhoYa05cdAEXQxF56lfpeWubV0lK4kIdMITU/Ll1CnFXBe1zTf
	X8sP4bnVtcAG+hUNxsiXPhCckBNCX11tPtIWLrTBcPZXe/WUoAY0FZozklHyuV/hZ2cI
	9SF/XGAuHsW9r5GKWKqQqUNUQZOUchQMHOIjxzGUY9NbzncX++B3EKuY29HUechSePy6
	BweTF1KzQFjFjnYmz4lin0Fmtwp9GVjTDdMhC97s/aOR/xDgvJriRHFIVwl3WEu7yIBA
	S6ngmbQBuh6GFXzWTj1q9hj/gHaf+bugTbuybV5cxVe4+F0eP14J0AH6H2jyapt81y87
	a0yQ==
X-Received: by 10.66.255.67 with SMTP id ao3mr1691645pad.60.1442004984035;
	Fri, 11 Sep 2015 13:56:24 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ql5sm1997168pac.46.2015.09.11.13.56.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 11 Sep 2015 13:56:23 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Sep 2015 13:57:28 -0700
Message-Id: <838c8c98c5edfd801c02aa06a5e3393d35649e0d.1442004911.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1442004911.git.avery.brian@gmail.com>
References: <cover.1442004911.git.avery.brian@gmail.com>
Subject: [PATCH 1/3] toaster: Read correct cooker log path from toasterui
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
X-List-Received-Date: Fri, 11 Sep 2015 20:56:26 -0000

From: Elliot Smith <elliot.smith@intel.com>

The BB_CONSOLELOG variable changes by the time we read it in
BuildInfoHelper. This means that the log file location we
are using is incorrect, so the links to the cooker logs don't
work.

Instead, read it at the point when the BuildStarted event occurs
in toasterui. The BB_CONSOLELOG variable has the correct value
here, so pass that to BuildInfoHelper.

[YOCTO #8209]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 8 ++++----
 lib/bb/ui/toasterui.py       | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 2d1ed51..6e313fe 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -704,7 +704,7 @@ class BuildInfoHelper(object):
     ## methods to convert event/external info into objects that the ORM layer uses
 
 
-    def _get_build_information(self):
+    def _get_build_information(self, consolelogfile):
         build_info = {}
         # Generate an identifier for each new build
 
@@ -713,7 +713,7 @@ class BuildInfoHelper(object):
         build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
         build_info['started_on'] = timezone.now()
         build_info['completed_on'] = timezone.now()
-        build_info['cooker_log_path'] = self.server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
+        build_info['cooker_log_path'] = consolelogfile
         build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
         build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
 
@@ -847,9 +847,9 @@ class BuildInfoHelper(object):
                 logger.warn("buildinfohelper: cannot identify layer exception:%s ", nee)
 
 
-    def store_started_build(self, event):
+    def store_started_build(self, event, consolelogfile):
         assert '_pkgs' in vars(event)
-        build_information = self._get_build_information()
+        build_information = self._get_build_information(consolelogfile)
 
         build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe, self.project)
 
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 9c7e87d..e0c278b 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -126,7 +126,7 @@ def main(server, eventHandler, params ):
             # the code will look into the protected variables of the event; no easy way around this
 
             if isinstance(event, bb.event.BuildStarted):
-                buildinfohelper.store_started_build(event)
+                buildinfohelper.store_started_build(event, consolelogfile)
 
             if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
-- 
1.9.1


