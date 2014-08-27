Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 28D6A71183
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:51 +0000 (UTC)
Received: by mail-wi0-f179.google.com with SMTP id f8so800604wiw.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=2Kq0z8MwWDmwoT4G4uBp/KbYAM8BsR3UpDwlW9sUdlo=;
	b=RqlP0ByFlkBooGNhhv/sUoB/kkamlFkBryF64kCK7wyLLWOqxcsIOuVI18mjBf7dvQ
	Jhtm/kwYoCzWgynO/kUxTQ0Zz8k0Yg+yy2m3TCx7s1iadqK/9uGqg4o+Jc7kzJcQY4d2
	aaIzmdXY5e/dPASr2UYpj0/SgMlcMDCWg1CI4dJTftgDAJj4nk9l915EaP20t4uXdCkq
	A9onw1F4cZmPqkUDm8JwNG943fSZrLwk4TX7/O6AXcW5UHRAvwnmlwvq/17lsRh6ifYi
	c2ZJulUg1pB1C1AxlJfWHu0Xb7limKJgf6ppJ+y7Gaob+hARVfJ8PXMVCV8LwjQr9PBO
	Dvmg==
X-Gm-Message-State: ALoCoQkhXtzNR0oqxw9vkVW+FRnZrzdaammiUxoBuY4NEHVCbUh5GUIPcbB5/3tmjYjYUEdZsmtM
X-Received: by 10.180.10.166 with SMTP id j6mr30849684wib.73.1409160230780;
	Wed, 27 Aug 2014 10:23:50 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id kr8sm2660849wjb.20.2014.08.27.10.23.48
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:49 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D966656120C; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:43 +0100
Message-Id: <401010068b591071af980fe6cf42ae36af118097.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 11/11] toaster: create Build methods for calculating progress and ETA
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:52 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We move the code to calculate build progress as percent
and the ETA of the build to the model, so that they can be
reused across different pages.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py       | 18 ++++++++++++++++++
 lib/toaster/toastergui/views.py | 13 +------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 5a6dcd7..bb921fc 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -120,6 +120,24 @@ class Build(models.Model):
     build_name = models.CharField(max_length=100)
     bitbake_version = models.CharField(max_length=50)
 
+    def completeper(self):
+        tf = Task.objects.filter(build = self)
+        tfc = tf.count()
+        if tfc > 0:
+            completeper = tf.exclude(order__isnull=True).count()*100/tf.count()
+        else:
+            completeper = 0
+        return completeper
+
+    def eta(self):
+        from django.utils import timezone
+        eta = 0
+        completeper = self.completeper()
+        if self.completeper() > 0:
+            eta = timezone.now() + ((timezone.now() - self.started_on)*(100-completeper)/completeper)
+        return eta
+
+
     def get_sorted_target_list(self):
         tgts = Target.objects.filter(build_id = self.id).order_by( 'target' );
         return( tgts );
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e68f8b0..86a34ad 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -224,17 +224,6 @@ def builds(request):
 
     # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
     build_mru = Build.objects.filter(completed_on__gte=(timezone.now()-timedelta(hours=24))).order_by("-started_on")[:3]
-    for b in [ x for x in build_mru if x.outcome == Build.IN_PROGRESS ]:
-        tf = Task.objects.filter(build = b)
-        tfc = tf.count()
-        if tfc > 0:
-            b.completeper = tf.exclude(order__isnull=True).count()*100/tf.count()
-        else:
-            b.completeper = 0
-
-        b.eta = 0
-        if b.completeper > 0:
-            b.eta = timezone.now() + ((timezone.now() - b.started_on)*(100-b.completeper)/b.completeper)
 
     # set up list of fstypes for each build
     fstypes_map = {};
@@ -1854,7 +1843,7 @@ if toastermain.settings.MANAGED:
         context = {
             "project" : prj,
             #"buildrequests" : prj.buildrequest_set.filter(state=BuildRequest.REQ_QUEUED),
-            "buildrequests" : map(lambda x: (x, {"machine" : x.brvariable_set.filter(name="MACHINE")[0]}), prj.buildrequest_set.order_by("-pk")),
+            "buildrequests" : map(lambda x: (x, {"machine" : x.brvariable_set.filter(name="MACHINE")[0]}), prj.buildrequest_set.filter(state__lt = BuildRequest.REQ_INPROGRESS).order_by("-pk")),
             "builds" : prj.build_set.all(),
             "puser": puser,
         }
-- 
1.9.1


