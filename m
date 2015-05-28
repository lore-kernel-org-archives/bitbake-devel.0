Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id F1A4075692
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:16:14 +0000 (UTC)
Received: by wicmx19 with SMTP id mx19so148307548wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=PfHkQvL5L4vtPbYFKEV/9wn67StRpIujGx9u9bFKGpw=;
	b=LPr7chvnKgfnvIgZZkFV6wIAyByG9Geg4b0TRh39IMPeqUAq9zo1K1FA37zBDzwdeH
	/eGpkUz40blKySWdP2SzuikpsWLKTqv0Xlmj/eVejcWCSXdW/LN6swGcrRKbRx4fQ2Uu
	IH+42rLEhu6KzUx4UxPUQjUiQpdq21J45Xnx5qPDkSQC+7j3/nTznez+E/ioD7skjvoF
	UKBvKWQPbiaRfDqpdq+ehmPm/OpFpBWSEanTlCR4Csyu77VxHBGQqh4gOhobLvZ5AHP2
	GqyKcV32DPaJIYQXOVv2Mj2zROh3CueToFZ7+g82YjlOQRSnK0X59eab8Br5ALsTQdlG
	WYXg==
X-Gm-Message-State: ALoCoQnNexrvsF6Si26QJXM1d+wBGsdsfzwC6A9H39VQRh+hBuVNCNGjdKGheQBEI3A8NafvDnbG
X-Received: by 10.180.208.7 with SMTP id ma7mr53711830wic.0.1432822575813;
	Thu, 28 May 2015 07:16:15 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id w11sm3538358wjr.48.2015.05.28.07.16.14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:16:15 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C7154561258; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:04 +0100
Message-Id: <6ed48473526791b225e5285b08e7854b32a903c9.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 10/22] toaster: Add an invalidate cache method on data update signal
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
X-List-Received-Date: Thu, 28 May 2015 14:16:15 -0000

From: Michael Wood <michael.g.wood@intel.com>

Instead of relying on the cache expiring over an amount of time we can
listen to the changed notification on the models to invalidate the
cache. Also fixes overlapping cache names.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py         | 12 ++++++++++++
 lib/toaster/toastergui/tables.py  |  5 -----
 lib/toaster/toastergui/widgets.py |  6 ++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0f72576..fb62a55 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -26,6 +26,7 @@ from django.utils import timezone
 
 from django.core import validators
 from django.conf import settings
+import django.db.models.signals
 
 class GitURLValidator(validators.URLValidator):
     import re
@@ -1176,3 +1177,14 @@ class LogMessage(models.Model):
     message=models.CharField(max_length=240)
     pathname = models.FilePathField(max_length=255, blank=True)
     lineno = models.IntegerField(null=True)
+
+def invalidate_cache(**kwargs):
+    from django.core.cache import cache
+    try:
+      cache.clear()
+    except Exception as e:
+      print "Problem with cache backend: Failed to clear cache"
+      pass
+
+django.db.models.signals.post_save.connect(invalidate_cache)
+django.db.models.signals.post_delete.connect(invalidate_cache)
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 78a7cb0..9a93ff9 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -323,11 +323,6 @@ class LayerRecipesTable(RecipesTable):
 
 
 
-
-
-
-
-
 # This needs to be staticaly defined here as django reads the url patterns
 # on start up
 urlpatterns = (
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index b5dfbbc..8cf6e1b 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -245,6 +245,9 @@ class ToasterTable(View):
         for key, val in request.GET.iteritems():
             cache_name = cache_name + str(key) + str(val)
 
+        for key, val in kwargs.iteritems():
+            cache_name = cache_name + str(key) + str(val)
+
         data = cache.get(cache_name)
 
         if data:
@@ -306,8 +309,7 @@ class ToasterTable(View):
         except FieldError:
             print "Error: Requested field does not exist"
 
-
         data = json.dumps(data, indent=2, cls=DjangoJSONEncoder)
-        cache.set(cache_name, data, 10)
+        cache.set(cache_name, data, 60*30)
 
         return data
-- 
1.9.1


