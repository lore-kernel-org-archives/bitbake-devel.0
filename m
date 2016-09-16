Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 4AAFC73285
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:49 +0000 (UTC)
Received: by mail-pa0-f49.google.com with SMTP id wk8so27410276pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=PD1Is5wFTvq30yhdkinmZLK+Dz+Z3ZXhk89iIi4Z9M0=;
	b=fol3d73GoOldy+TGdIoTaMXvTJnxbYprsSUTQdIB6boENPNQfzS4w0XojW4/1BfzZp
	Wmwm/jL7/uy+RcuhOdJuKwS950q22UKObRvu2odEWlBr7T5kWf3UYW7Fu0dOPqoI0c0V
	FUOJuToJiMpfCs8rL5j/JhvUsD1mLJC3zksw4vPnElz8UlT3wjZCaenQmPbGmaf9ZDWz
	0QRUbDC882Szz0rVCEP4ODBVwqejt7tmbJPQTNlylJuCcQdYTOOlxIZBCoZYYADN7duH
	vYoEifiGzggpKrKScyzOSPtrerJwMWFrxf6l6MZ1iKxDBi8MTFwvt00DxfO4udB9TKLJ
	r24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=PD1Is5wFTvq30yhdkinmZLK+Dz+Z3ZXhk89iIi4Z9M0=;
	b=RJ5eGm3BQllQ68PvD1XkdqX2q7HWfXBRZhudP8APxZUF4lmK9F3DoqyFPH3m8Hwteq
	UuSabiZutNcd0xM4Q3dMgFvIEOtK3votxDUbEpg8aW34ktqQle9RhWFPFt51RzUGq2dd
	fLprvn5JRn4UHKbhY6Q8SEiASUirCKJP1AYukZ4J6ZDNov4d/BR/G2p+Vwue9Keqh71G
	enUtm137TrSENc2ki5RtgfaEAKccJw1p4D2a/ENuxyVL/3aa2grQuq8AqxakuXAhgqH2
	zyVAPYn+DNbhEKUEyp64JVXu8Rs0jVRyZlsDBgcJuMpLvXmwAMjNbAUn9ejSWd2nz8iy
	kmuw==
X-Gm-Message-State: AE9vXwMJcZYIAR/h3J1nChR94aCxdfXa8+N2Qy1B2mMSBKRKu4c+lJroQi1JEeIKmN3mMrmG
X-Received: by 10.66.224.101 with SMTP id rb5mr24614695pac.45.1474042970518;
	Fri, 16 Sep 2016 09:22:50 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:49 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:30 +0100
Message-Id: <1474042955-12618-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
References: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/8] toaster: notify runbuilds when build status changes
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
X-List-Received-Date: Fri, 16 Sep 2016 16:22:50 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Called signal_runbuilds API when build is scheduled, cancelled or
finished to notify runbuilds process about builds status change.

[YOCTO #8918]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 4 ++++
 lib/toaster/orm/models.py    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 96166dc..c93ee94 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -43,6 +43,7 @@ from orm.models import Package, Package_File, Target_Installed_Package, Target_F
 from orm.models import Task_Dependency, Package_Dependency
 from orm.models import Recipe_Dependency, Provides
 from orm.models import Project, CustomImagePackage, CustomImageRecipe
+from orm.models import signal_runbuilds
 
 from bldcontrol.models import BuildEnvironment, BuildRequest
 
@@ -234,6 +235,7 @@ class ORMWrapper(object):
         build.completed_on = timezone.now()
         build.outcome = outcome
         build.save()
+        signal_runbuilds()
 
     def update_target_set_license_manifest(self, target, license_manifest_path):
         target.license_manifest_path = license_manifest_path
@@ -1354,6 +1356,7 @@ class BuildInfoHelper(object):
         self._ensure_build()
         self.internal_state['build'].outcome = Build.CANCELLED
         self.internal_state['build'].save()
+        signal_runbuilds()
 
     def store_dependency_information(self, event):
         assert '_depgraph' in vars(event)
@@ -1540,6 +1543,7 @@ class BuildInfoHelper(object):
         else:
             br.state = BuildRequest.REQ_FAILED
         br.save()
+        signal_runbuilds()
 
     def store_log_error(self, text):
         mockevent = MockEvent()
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 38d014a..a7de57c 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -377,6 +377,8 @@ class Project(models.Model):
             except ProjectVariable.DoesNotExist:
                 pass
             br.save()
+            signal_runbuilds()
+
         except Exception:
             # revert the build request creation since we're not done cleanly
             br.delete()
-- 
2.7.4


