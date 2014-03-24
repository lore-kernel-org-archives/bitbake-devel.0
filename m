Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f180.google.com (mail-we0-f180.google.com
	[74.125.82.180])
	by mail.openembedded.org (Postfix) with ESMTP id 2032D6FB4D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:36 +0000 (UTC)
Received: by mail-we0-f180.google.com with SMTP id p61so3631055wes.39
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ecuCWidoec+Yot1bYiWDtVvQ8I2QIOhRF2MRpGWGvaY=;
	b=PzB9S7H7ahCW6QObF5FMihtDYYur149iwB+6Ig4YvIzrL98GFtCi/9EXkRdyi04sFE
	ECpnCCUyn/1fyK/AA8f9CXqvi5fpfBOM+aov6O7a5Cblt2cHFEs2w2lDnAr5KfKQlKoS
	+iXlRbTpmFYcYCX1yNqG3v2pYUtg03PwuGuKKqZWyz6HD4VTAo9seCjXbi9OtOU8g8Ea
	TbY37RPQZx17dcKknGac/u61Lw6Cy4GKVXp7R+8Yef30lDUpXkgaxLoEmiNIHkq04/wI
	B10NsWwMOdNeAFdMD1e80/cqY6YtnU3UNHA22g9OEV7S9Up2aUDP3Y1Uyz/gDL5ww3Ap
	1j4w==
X-Gm-Message-State: ALoCoQnBUMO+65CoweM3azRXq+ggjpS6HFqddskK339d/nvvmYEUt9ML8fUwcR3eCvAti6Co9Wyj
X-Received: by 10.180.77.200 with SMTP id u8mr16916396wiw.48.1395686256748;
	Mon, 24 Mar 2014 11:37:36 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id em1sm41551090wid.5.2014.03.24.11.37.34
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C9142561B15; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:25 +0000
Message-Id: <e855031410daf2b99a6ca40b70956fe67c96f71c.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 15/18] toaster: select recipe based on PN name
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

When saving task stats, if there were multiple tasks executed
based on the same recipe file, we might have saved the stats
to the wrong task by selecting another recipe.

This patch takes the PN into account to properly select
the file stats.

A check is also made to make sure we don't fail saving
data due to interrupted builds.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 30c9b92..71b2ff5 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -678,20 +678,18 @@ class BuildInfoHelper(object):
 
 
     def store_tasks_stats(self, event):
-        for (taskfile, taskname, taskstats) in event.data:
+        for (taskfile, taskname, taskstats, recipename) in event.data:
             localfilepath = taskfile.split(":")[-1]
             assert localfilepath.startswith("/")
 
             recipe_information = self._get_recipe_information_from_taskfile(taskfile)
-            try:
-                recipe = self.orm_wrapper.get_update_recipe_object(recipe_information, True)
-            except NotExisting:
-                recipe = Recipe.objects.get(layer_version = recipe_information['layer_version'],
-                            file_path__endswith = recipe_information['file_path'])
+            recipe_object = Recipe.objects.get(layer_version = recipe_information['layer_version'],
+                            file_path__endswith = recipe_information['file_path'],
+                            name = recipename)
 
             task_information = {}
             task_information['build'] = self.internal_state['build']
-            task_information['recipe'] = recipe
+            task_information['recipe'] = recipe_object
             task_information['task_name'] = taskname
             task_information['cpu_usage'] = taskstats['cpu_usage']
             task_information['disk_io'] = taskstats['disk_io']
@@ -756,11 +754,15 @@ class BuildInfoHelper(object):
         # for all image targets
         for target in self.internal_state['targets']:
             if target.is_image:
-                pkgdata = event.data['pkgdata']
-                imgdata = event.data['imgdata'][target.target]
-                self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'])
-                filedata = event.data['filedata'][target.target]
-                self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
+                try:
+                    pkgdata = event.data['pkgdata']
+                    imgdata = event.data['imgdata'][target.target]
+                    self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'])
+                    filedata = event.data['filedata'][target.target]
+                    self.orm_wrapper.save_target_file_information(self.internal_state['build'], target, filedata)
+                except KeyError:
+                    # we must have not got the data for this image, nothing to save
+                    pass
 
 
 
-- 
1.8.3.2


