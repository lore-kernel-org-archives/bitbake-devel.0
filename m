Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 69AB176A5D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:15 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so113361597wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=AuqTQgMb3YuAxM5t1gEA5f02rwB9xJFXT4hA/p72DRA=;
	b=M05PUnpKafwKw5lfbUDEiOKOseM+ynkD5ocNjV8NcjVZv92XM3I9I8E7v18pQk9Qln
	VF63AMtyONDNqv2IfFQJYyBCUYL3uLDmD5WenhKRoujUErHCOdO38/LsLE4JWidKIA4M
	nB2HbYK8VXw2ukzevXxmueopYy9nYLufLMdLAKFtBgxKFAryeGHNiA3oYcqiJbrTNQn8
	WGEIaSd6nTY0O4Qv45mNheQ50tX6MKf2JAE831lxpLl1hs5NCgb4TFqK8k6u2W5awgf3
	2ueBqJwzgflHbQqt7t02b4VojZQn2ZJ+MwDgj0LmZAFQoclQICU6wVqPIxVIxWcM5dQs
	lclg==
X-Gm-Message-State: ALoCoQmFdiwvGdgxMiUPtKO8yfZaM5DysERfgGoUERRArJVnTEm/QbIv0ZxoM/i+lCfsZk8Rleod
X-Received: by 10.180.103.34 with SMTP id ft2mr44961558wib.62.1439915355547;
	Tue, 18 Aug 2015 09:29:15 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:14 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:57 +0100
Message-Id: <04942f5e6fdcbc24a66f7481ac7d8ae33b70fb80.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 11/14] bitbake: toaster: fix pylint errors
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:15 -0000

From: Alexandru Damian <alexandru.damian@intel.com>

Prompted by issues discovered during running pylint on
the toaster sources, this patch fixes:

* missing import in toaster ui
* improper call of function in toaster ui (logger.debug)
* improper function definitions in bbcontroller
* invalid references to objects in bldcontrol.models
* proper initialization of object fields in ToasterTables

Also inhibiting specific pylint errors in files where
the problems are mis-identified.

Signed-off-by: Alexandru Damian <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/toasterui.py                              | 5 +++--
 lib/toaster/bldcontrol/bbcontroller.py              | 2 +-
 lib/toaster/orm/models.py                           | 2 +-
 lib/toaster/toastergui/views.py                     | 4 ++++
 lib/toaster/toastergui/widgets.py                   | 3 +++
 lib/toaster/toastermain/management/commands/perf.py | 7 ++++++-
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index f30f89e..767bfab 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -21,6 +21,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from __future__ import division
+import sys
 try:
     import bb
 except RuntimeError as exc:
@@ -255,10 +256,10 @@ def main(server, eventHandler, params ):
                 # we start a new build info
                 if buildinfohelper.brbe is not None:
 
-                    logger.debug(1, "ToasterUI under BuildEnvironment management - exiting after the build")
+                    logger.debug("ToasterUI under BuildEnvironment management - exiting after the build")
                     server.terminateServer()
                 else:
-                    logger.debug(1, "ToasterUI prepared for new build")
+                    logger.debug("ToasterUI prepared for new build")
                     errors = 0
                     warnings = 0
                     taskfailures = []
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 9dd01e0..ad70ac8 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -177,7 +177,7 @@ class BuildEnvironmentController(object):
 
         return BitbakeController(self.connection)
 
-    def getArtifact(path):
+    def getArtifact(self, path):
         """ This call returns an artifact identified by the 'path'. How 'path' is interpreted as
             up to the implementing BEC. The return MUST be a REST URL where a GET will actually return
             the content of the artifact, e.g. for use as a "download link" in a web UI.
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index de00702..92fcaa7 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -81,7 +81,7 @@ class ProjectManager(models.Manager):
 
         for rdl in release.releasedefaultlayer_set.all():
             try:
-                lv =Layer_Version.objects.filter(layer__name = rdl.layer_name, up_branch__name = release.branch_name)[0].get_equivalents_wpriority(prj)[0]
+                lv = Layer_Version.objects.filter(layer__name = rdl.layer_name, up_branch__name = release.branch_name)[0].get_equivalents_wpriority(prj)[0]
                 ProjectLayer.objects.create( project = prj,
                         layercommit = lv,
                         optional = False )
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e9c246f..20f7cb3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -19,6 +19,10 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+# pylint: disable=method-hidden
+# Gives E:848, 4: An attribute defined in json.encoder line 162 hides this method (method-hidden)
+# which is an invalid warning
+
 import operator,re
 
 from django.db.models import F, Q, Sum, Count, Max
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 2adf574..eb2914d 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -334,6 +334,9 @@ class ToasterTemplateView(TemplateView):
     # renders a instance in a template, or returns the context as json
     # the class-equivalent of the _template_renderer decorator for views
 
+    def __init__(self, *args, **kwargs):
+        super(ToasterTemplateView, self).__init__(*args, **kwargs)
+        self.context_entries = []
 
     def get(self, *args, **kwargs):
         if self.request.GET.get('format', None) == 'json':
diff --git a/lib/toaster/toastermain/management/commands/perf.py b/lib/toaster/toastermain/management/commands/perf.py
index d28f26a..71a48e9 100644
--- a/lib/toaster/toastermain/management/commands/perf.py
+++ b/lib/toaster/toastermain/management/commands/perf.py
@@ -2,7 +2,12 @@ from django.core.management.base import BaseCommand
 from django.test.client import Client
 import os, sys, re
 import requests
-import toastermain.settings as settings
+from django.conf import settings
+
+# pylint: disable=E1103
+# Instance of 'WSGIRequest' has no 'status_code' member
+# (but some types could not be inferred) (maybe-no-member)
+
 
 class Command(BaseCommand):
     help    = "Test the response time for all toaster urls"
-- 
2.1.4


