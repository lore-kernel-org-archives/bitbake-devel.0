Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 27B5C6F87D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:14 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id bs8so3484250wib.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=XsZecUhI/o4I9N1VIfucWL5gFWuf9nob4dMPVH1guYk=;
	b=ZeEwZmiV2/SkRNKjl7qdMU6PFUSk5OVM4kzgJp6/f834P3sNCRlReP8X/KKKJwVBRg
	vYvffm9WkLGtINi6YCkhE/0boPaHTJXjVE2CFlISTr6jPCHcmh8H4CtFQaHYIh2jCaQ4
	qR+P6smf3HvGJVJV3n38NPLjSOl9WTo4y5GiCLpEUuz+n3EqZUggBM/WGBMqrCVluryN
	VUvLh8oMvT4Le6T9/v4bLDK2ADUG0+qZGdKOEDbSIeKcG+Qa7f8wLBaaC+WywTCNpP6/
	5zfP3E2YoT+doKf7Gf2lPrEoMdSnmK0fc0yYdQ3hi8ukVP8qZGx+CO/OeSTXKnjMNGwh
	pVvQ==
X-Gm-Message-State: ALoCoQmla9XDCaZEaFWAfbTEgtJqJwMzPu2mCRH76rg4wq9X+hNjfDOsdP+fMPm2ptWsaxifB4Rj
X-Received: by 10.194.192.132 with SMTP id hg4mr15827545wjc.28.1396284435581; 
	Mon, 31 Mar 2014 09:47:15 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id n15sm27696877wij.3.2014.03.31.09.47.13
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:14 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 07AD55601AD; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:01 +0100
Message-Id: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 01/14] toaster: update saving sstate task data
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is an update on the sstate file saving data.
It saves both found and missed sstate tasks.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index d1d92c8..0a15579 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -750,7 +750,7 @@ class BuildInfoHelper(object):
 
 
     def store_missed_state_tasks(self, event):
-        for (fn, taskname, taskhash, sstatefile) in event.data:
+        for (fn, taskname, taskhash, sstatefile) in event.data['missed']:
 
             identifier = fn + taskname + "_setscene"
             recipe_information = self._get_recipe_information_from_taskfile(fn)
@@ -769,6 +769,21 @@ class BuildInfoHelper(object):
 
             self.orm_wrapper.get_update_task_object(task_information)
 
+        for (fn, taskname, taskhash, sstatefile) in event.data['found']:
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
+            task_information['path_to_sstate_obj'] = sstatefile
+
+            self.orm_wrapper.get_update_task_object(task_information)
+
 
     def store_target_package_data(self, event):
         assert 'data' in vars(event)
-- 
1.9.1


