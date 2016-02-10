Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 4BA9F7316B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 18:34:14 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id g62so39083154wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 10:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=jXCZTGWXExrgRihyRKPoJq9roTZ9qJrn5L/g8l17274=;
	b=M9dYvwJDgkScyO+n0Ni4TErYAFfv2xKAT0tXbyNLUSl2wkgDKuSLyIZ8SJTA1KMedz
	uP6DvlA11vaifordbf4b8KhiRmd2DvSvRGlUDmvwQ/d3H8zaT93q6h+7Jt42ni1z6vrT
	jzHlwl6Jr4VSZIdK3RHrYGfMnlZGWY580Kz12/8zMcjMNsUOSofEKDLBKRfv0K1d57t1
	lteXpWakHMGBBXKWA8VnqPbaWhrT1r6UrJp0ritZRf8uDQKm7l8tDX0a1qYqiBzZulQJ
	K5wekjQ/8OohVWxp0oCEo5Ho2/QBeIcSV8WhoJ1Sw8ZRln27yHZ4XHht3GwBv1TbCA7/
	oChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=jXCZTGWXExrgRihyRKPoJq9roTZ9qJrn5L/g8l17274=;
	b=k3cf0cuB8eDf1t0YNE1lOvkssQ0dfZv93yqdG+khBHCKklXZcSsufJGLTv+moRpLVY
	wwc6vpjWQGyYqAb3sF0l00g0f+GoP5bA7ZKT1Xd0kNw+e3n4ZGHmLFp5fpiGbyKIFI/+
	9pG4HlsFo8J5Zz36UGB/qyMb0+dwQ3mscvXVia7L5sqXJoeCChW4VQEw3eC6oYILwKLy
	j3FWXe2vI2XUO5CL4Alw1V+zhYUupBRZylskvkC17o1wMh4794JjlnaHgwaThHew6Hpp
	nvftKizCzY+wsKOv/a8Yg+D07uyy22eVwyuho6rFXNL0OeexzF7GbZKA5uxdwpaAKpGg
	fX+A==
X-Gm-Message-State: AG10YOQUYSFMJruwkEgsclNqfXhMwKYLoAnJYC/W7HSz7vEOZPS31G2m86S/TeoYLcGyU8JD
X-Received: by 10.28.182.139 with SMTP id g133mr12325195wmf.70.1455129255234; 
	Wed, 10 Feb 2016 10:34:15 -0800 (PST)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	k4sm23492437wmc.12.2016.02.10.10.34.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 10 Feb 2016 10:34:14 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Feb 2016 18:34:10 +0000
Message-Id: <1455129250-10998-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] buildinfohelper: unset brbe variable when build finishes
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
X-List-Received-Date: Wed, 10 Feb 2016 18:34:15 -0000

From: Elliot Smith <elliot.smith@intel.com>

The brbe variable is set on the bitbake server when the Toaster
UI starts. This enables Toaster to associate events with the
correct build and build environment.

However, the brbe variable is also used when a build starts to
identify whether a new build needs to be created, or an existing
one looked up. This causes a bug for command-line builds which
happen after a Toaster-triggered build: because the brbe variable
is never unset on the server or the buildinfohelper, the new
command-line build events are treated as originating from the
previous build.

Ensure the brbe variable is reset when the buildinfohelper "closes"
a build, so that each build then either sets the brbe variable
(Toaster-triggered builds) or leaves it blank (command-line builds).

Also modify the localhostbecontroller so that the brbe variable
is not set on the server and not looked up from the server. This
ensures that it is only set when the triggerBuild() method is
called, and that it remains as None for command-line builds.

[YOCTO #9021]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py                    | 19 ++++++++++++-------
 lib/toaster/bldcontrol/localhostbecontroller.py |  9 +++++++--
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c049b4a..81abede 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -832,8 +832,13 @@ class BuildInfoHelper(object):
         self.orm_wrapper = ORMWrapper()
         self.has_build_history = has_build_history
         self.tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
-        self.brbe    = self.server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
-        self.project = self.server.runCommand(["getVariable", "TOASTER_PROJECT"])[0]
+
+        # this is set for Toaster-triggered builds by localhostbecontroller
+        # via toasterui
+        self.brbe = None
+
+        self.project = None
+
         logger.debug(1, "buildinfohelper: Build info helper inited %s" % vars(self))
 
 
@@ -843,8 +848,6 @@ class BuildInfoHelper(object):
 
     def _get_build_information(self, build_log_path):
         build_info = {}
-        # Generate an identifier for each new build
-
         build_info['machine'] = self.server.runCommand(["getVariable", "MACHINE"])[0]
         build_info['distro'] = self.server.runCommand(["getVariable", "DISTRO"])[0]
         build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
@@ -853,9 +856,7 @@ class BuildInfoHelper(object):
         build_info['cooker_log_path'] = build_log_path
         build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
         build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
-        build_info['brbe'] = self.server.runCommand(["getVariable", "TOASTER_BRBE"])[0]
         build_info['project'] = self.project = self.server.runCommand(["getVariable", "TOASTER_PROJECT"])[0]
-
         return build_info
 
     def _get_task_information(self, event, recipe):
@@ -967,7 +968,6 @@ class BuildInfoHelper(object):
         build_information = self._get_build_information(build_log_path)
 
         # Update brbe and project as they can be changed for every build
-        self.brbe = build_information['brbe']
         self.project = build_information['project']
 
         build_obj = self.orm_wrapper.create_build_object(build_information, self.brbe, self.project)
@@ -1487,3 +1487,8 @@ class BuildInfoHelper(object):
 
         if not connection.features.autocommits_when_autocommit_is_off:
             transaction.set_autocommit(True)
+
+        # unset the brbe; this is to prevent subsequent command-line builds
+        # being incorrectly attached to the previous Toaster-triggered build;
+        # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=9021
+        self.brbe = None
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index a7db1ef..efd82c3 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -308,12 +308,17 @@ class LocalhostBEController(BuildEnvironmentController):
         # get the bb server running with the build req id and build env id
         bbctrl = self.getBBController()
 
-        # set variables
+        # set variables; TOASTER_BRBE is not set on the server, as this
+        # causes events from command-line builds to be attached to the last
+        # Toaster-triggered build; instead, TOASTER_BRBE is fired as an event so
+        # that toasterui can set it on the buildinfohelper;
+        # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=9021
         for var in variables:
-            bbctrl.setVariable(var.name, var.value)
             if var.name == 'TOASTER_BRBE':
                 bbctrl.triggerEvent('bb.event.MetadataEvent("SetBRBE", "%s")' \
                                      % var.value)
+            else:
+                bbctrl.setVariable(var.name, var.value)
 
         # Add 'toaster' and 'buildhistory' to INHERIT variable
         inherit = {item.strip() for item in bbctrl.getVariable('INHERIT').split()}
-- 
2.1.4


