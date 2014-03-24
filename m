Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 43D986FB48
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:36 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id n12so3798221wgh.24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=iHlVbUmdLbyG18jBAm+RE6GSb0GBiFH3RO2NzF1FiE8=;
	b=LijdWpCCQvR3AzbtJxbY8hD0RrOFBL34+7ZHHI2gXbypgRQGna0Pbbwq/ve5HJBguJ
	fIxo7p9mTJ3diI3e/H56x1mW5PoqM9Pj4aXA9M1dIeAjKlUGfXtX7tiyqTqimgwgIqAy
	9jww1VpxTJG9AfdpJ50c1prC1AEQ/3r+WL7X5xgzTsGNSibmwQsTK2jtk35a+k7n89PU
	TW/jNO/9yOCNLm04+gL0MQMzOe09zg7TevlEfxDdEo4IIuzun4aI0P1kvoKjaIpXvngh
	AyGkFNteP0oM9q4GEmnA7BHTPkfmyPj7612oLP0h7rIESdXnXjUUeH+AmwFwfjMAlN8B
	M/Pg==
X-Gm-Message-State: ALoCoQn+/MRKFbFr3iA/F/iZ21cSQ0dUaaO+QEOmsWtkEMc6m+TdKEeDDGMWj125disML33LzR9o
X-Received: by 10.180.89.136 with SMTP id bo8mr16888699wib.52.1395686257703;
	Mon, 24 Mar 2014 11:37:37 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	qg3sm41447341wic.10.2014.03.24.11.37.34 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:35 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id CACB45622C7; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:26 +0000
Message-Id: <6f22e02614adcc642fe011e5e31ca4936d1cb19d.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 16/18] toasterui: save missed sstate tasks
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:37 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We save the missed sstate tasks as tasks that executed
but have the sstate_result set to "SSTATE_MISSED", signaling
that the attempt to find an sstate file failed.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 21 +++++++++++++++++++++
 lib/bb/ui/toasterui.py       |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 71b2ff5..d1d92c8 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -749,6 +749,27 @@ class BuildInfoHelper(object):
         self.orm_wrapper.get_update_task_object(task_information, True) # must exist
 
 
+    def store_missed_state_tasks(self, event):
+        for (fn, taskname, taskhash, sstatefile) in event.data:
+
+            identifier = fn + taskname + "_setscene"
+            recipe_information = self._get_recipe_information_from_taskfile(fn)
+            recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
+            class MockEvent: pass
+            event = MockEvent()
+            event.taskname = taskname
+            event.taskhash = taskhash
+            task_information = self._get_task_information(event,recipe)
+
+            task_information['start_time'] = datetime.datetime.now()
+            task_information['outcome'] = Task.OUTCOME_NA
+            task_information['sstate_checksum'] = taskhash
+            task_information['sstate_result'] = Task.SSTATE_MISS
+            task_information['path_to_sstate_obj'] = sstatefile
+
+            self.orm_wrapper.get_update_task_object(task_information)
+
+
     def store_target_package_data(self, event):
         assert 'data' in vars(event)
         # for all image targets
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index b2c084c..453eaf9 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -241,6 +241,8 @@ def main(server, eventHandler, params ):
                     buildinfohelper.store_tasks_stats(event)
                 elif event.type == "ImagePkgList":
                     buildinfohelper.store_target_package_data(event)
+                elif event.type == "MissedSstate":
+                    buildinfohelper.store_missed_state_tasks(event)
                 elif event.type == "ImageFileSize":
                     buildinfohelper.update_target_image_file(event)
                 elif event.type == "LicenseManifestPath":
-- 
1.8.3.2


