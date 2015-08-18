Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 39CB876A33
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:09 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so113359475wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=02xiqPkW68/5l2q56zmcS2PUWIRoN5opfHEi93GH0nU=;
	b=KaxciAg7MBkupouiYPos2oSS8AJjVX7mrKkzZMjLHJL9fMrO20mT9YozZV4CiC5Jj+
	AzSP8w3noHqmV4JRJvlb4XCBEA4p2NMlq+Ff45T6qvdxGq2cIcMQBRbg+yDyaus1snlR
	N635lGyQeIEIw4Ds5C2qFVdwkAbJmsC8HBRn5zqynnr8EeuqadLWcc2Rg39kHJNMmYmJ
	zXkDoXlHnDNJwOEb7jpBGsTDCdjEYXRQSEWJbweymIChTWvLssgFWvqYVvU+sbYehIDQ
	XwJfBAHNW9rkOdfRotIhFx3u/ODFCUVPB8jAnlex6lKXLYdq9Dxr+UEAz2t+lA0SrxzC
	MFuQ==
X-Gm-Message-State: ALoCoQnejWkvq1vJPFbaKity0b+jwrfPhegLuSGzXn9Rw4B5HruX+YQTur2FWs/gwxQif6zMfPfA
X-Received: by 10.180.83.137 with SMTP id q9mr47123987wiy.68.1439915349968;
	Tue, 18 Aug 2015 09:29:09 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:09 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:52 +0100
Message-Id: <059e6f0861f192ab0c2855829f79f18db360ac8b.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 06/14] bitbake: toaster: use loggers instead of prints
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:11 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Switching debugging from using print statement to using
loggers, as it uses the logging infrastructure to process
the messages.

The messages are logged with the "toaster" logger which
is defined in the toastermain/settings.py.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py       | 22 +++++++++++++---------
 lib/toaster/toastergui/views.py |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 26abf37..c3fb766 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -29,6 +29,11 @@ from django.core import validators
 from django.conf import settings
 import django.db.models.signals
 
+
+import logging
+logger = logging.getLogger("toaster")
+
+
 class GitURLValidator(validators.URLValidator):
     import re
     regex = re.compile(
@@ -855,8 +860,8 @@ class LayerIndexLayerSource(LayerSource):
         except Exception as e:
             import traceback
             if proxy_settings is not None:
-                print "EE: Using proxy ", proxy_settings
-            print "EE: could not connect to %s, skipping update: %s\n%s" % (self.apiurl, e, traceback.format_exc(e))
+                logger.info("EE: Using proxy %s" % proxy_settings)
+            logger.warning("EE: could not connect to %s, skipping update: %s\n%s" % (self.apiurl, e, traceback.format_exc(e)))
             return
 
         # update branches; only those that we already have names listed in the
@@ -865,7 +870,7 @@ class LayerIndexLayerSource(LayerSource):
         if len(whitelist_branch_names) == 0:
             raise Exception("Failed to make list of branches to fetch")
 
-        print "Fetching branches"
+        logger.debug("Fetching branches")
         branches_info = _get_json_response(apilinks['branches']
             + "?filter=name:%s" % "OR".join(whitelist_branch_names))
         for bi in branches_info:
@@ -895,7 +900,7 @@ class LayerIndexLayerSource(LayerSource):
             transaction.set_autocommit(True)
 
         # update layerbranches/layer_versions
-        print "Fetching layer information"
+        logger.debug("Fetching layer information")
         layerbranches_info = _get_json_response(apilinks['layerBranches']
                 + "?filter=branch:%s" % "OR".join(map(lambda x: str(x.up_id), [i for i in Branch.objects.filter(layer_source = self) if i.up_id is not None] ))
             )
@@ -933,7 +938,7 @@ class LayerIndexLayerSource(LayerSource):
             try:
                 dependlist[lv].append(Layer_Version.objects.get(layer_source = self, layer__up_id = ldi['dependency'], up_branch = lv.up_branch))
             except Layer_Version.DoesNotExist:
-                print "Cannot find layer version ", self, ldi['dependency'], lv.up_branch
+                logger.warning("Cannot find layer version %s dep:%s up_brach:%s" % (self, ldi['dependency'], lv.up_branch))
 
         for lv in dependlist:
             LayerVersionDependency.objects.filter(layer_version = lv).delete()
@@ -944,7 +949,7 @@ class LayerIndexLayerSource(LayerSource):
 
 
         # update machines
-        print "Fetching machine information"
+        logger.debug("Fetching machine information")
         machines_info = _get_json_response(apilinks['machines']
                 + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
             )
@@ -962,7 +967,7 @@ class LayerIndexLayerSource(LayerSource):
             transaction.set_autocommit(True)
 
         # update recipes; paginate by layer version / layer branch
-        print "Fetching target information"
+        logger.debug("Fetching target information")
         recipes_info = _get_json_response(apilinks['recipes']
                 + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
             )
@@ -1236,8 +1241,7 @@ def invalidate_cache(**kwargs):
     try:
       cache.clear()
     except Exception as e:
-      print "Problem with cache backend: Failed to clear cache"
-      pass
+      logger.warning("Problem with cache backend: Failed to clear cache: %s" % e)
 
 django.db.models.signals.post_save.connect(invalidate_cache)
 django.db.models.signals.post_delete.connect(invalidate_cache)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5cee068..ddc7703 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -42,6 +42,10 @@ import json
 from os.path import dirname
 import itertools
 
+import logging
+
+logger = logging.getLogger("toaster")
+
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
 def landing(request):
-- 
2.1.4


