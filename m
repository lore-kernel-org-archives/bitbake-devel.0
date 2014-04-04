Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 4CA3E6B72B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:55 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id hi2so1350057wib.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=BLfdfnOnG5KnIJPFW86X8AIQzMnqlWIT456CNgLr+tM=;
	b=PPAaCJBwRYNOGDpvabF0X4DgtKjcF1tbRW9bvYSGWbLCV5KiqI4ZlIEUdBBwvc0bmw
	i7y1eQPM5S0zJYM48F4ArcLnWQJavvClHzHbc01JbMduJYejAcw7b7VHRwR+QpROLgTI
	G0p0lLyILvOpjnWy/Os0i/Y30rxtZikX9GYF4ScMFffrolOwbYzt3i+JZI3VdnHITiF0
	rPO7Oj/H4Sj1ZJLdjcr/9C2XK3cJTVHWC8ycwRJXkVcpio8BBByoYAR+eebDCn7vSp4A
	7C9HciKLyqe03B55p8FMyq/AR/tQshiNNFox67UbvrR+XKTXIh/3n/VIfO1AXh006sCI
	k5ow==
X-Gm-Message-State: ALoCoQkoJNYNXC6QqZGJyK2L7eq8Z5aZOHG5MXzUjOJsPPcl/r/6w9UoCQwqoSEhfV5cubarF+0F
X-Received: by 10.180.12.14 with SMTP id u14mr5061109wib.0.1396620656069;
	Fri, 04 Apr 2014 07:10:56 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h19sm4902215wiw.17.2014.04.04.07.10.54
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:54 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 85E17560418; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:43 +0100
Message-Id: <6ed7db6e74062825f8537ee5482fff8846126b9f.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 04/14] toasterui: avoid variable name conflict
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
X-List-Received-Date: Fri, 04 Apr 2014 14:10:56 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We rename a local variable in as to prevent a conflict with
a similary named function parameter.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e4d2f1f..dd93d0b 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -761,10 +761,10 @@ class BuildInfoHelper(object):
             recipe_information = self._get_recipe_information_from_taskfile(fn)
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
             class MockEvent: pass
-            event = MockEvent()
-            event.taskname = taskname
-            event.taskhash = taskhash
-            task_information = self._get_task_information(event,recipe)
+            mevent = MockEvent()
+            mevent.taskname = taskname
+            mevent.taskhash = taskhash
+            task_information = self._get_task_information(mevent,recipe)
 
             task_information['start_time'] = datetime.datetime.now()
             task_information['outcome'] = Task.OUTCOME_NA
@@ -780,10 +780,10 @@ class BuildInfoHelper(object):
             recipe_information = self._get_recipe_information_from_taskfile(fn)
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
             class MockEvent: pass
-            event = MockEvent()
-            event.taskname = taskname
-            event.taskhash = taskhash
-            task_information = self._get_task_information(event,recipe)
+            mevent = MockEvent()
+            mevent.taskname = taskname
+            mevent.taskhash = taskhash
+            task_information = self._get_task_information(mevent,recipe)
 
             task_information['path_to_sstate_obj'] = sstatefile
 
-- 
1.9.1


