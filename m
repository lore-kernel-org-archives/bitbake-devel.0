Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 0E82D60043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:04 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so99772380wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=8lOVgEM8OEKQ/eMP/xoafP1u4WemOQERAB5gmGtpCl8=;
	b=LQ7CuUBev2og7u5qsdcoZhO17a1nnTUonrpiHwevc1cZHGKS+KhgqdBjOSqCQzWn8z
	ob9vJb+uUqKQfXmaWE8Vu/C2EasxxQmCDzjQ0wCpKPtc1M0R9vZ/4+SH8PE9ZOC5AsD1
	l2KMEZEsefYF4YAsx07zIUrMTS/Z3CdjRi7OEcIU0m3Sar51QVuQPQDRNtw4yhMSNDcM
	Xh6puJw1ttBT03mSW8H5ELDd5M/Rq5z1MzpMBpqkr4nE23PmfopGZZ8QLlCakwjOqL2N
	X23zh9E5V3BOryN4qHryMz0nh2q1vhN2BqIogwijbqQ83/F6TQJYn6oQ/SXsNhu+GunR
	60xQ==
X-Gm-Message-State: ALoCoQkU8yNA8Fp8O19DfbmavOV6lZjrewcsbBUtFmyjGX2caSjjAuifSmrRX5t68zxYS1Yx2krB
X-Received: by 10.194.192.72 with SMTP id he8mr14988591wjc.11.1439915344462;
	Tue, 18 Aug 2015 09:29:04 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.03
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:03 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:47 +0100
Message-Id: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 01/14] bitbake: toaster: pylint fixes
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes imports, default parameters to functions,
incorrect overloading and exception handling issues
highlighted by pylint. There are no functional changes.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../management/commands/checksettings.py           |  3 +-
 lib/toaster/orm/models.py                          |  1 -
 lib/toaster/toastergui/views.py                    | 32 +++++++++-------------
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 9a508b4..508335f 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -4,6 +4,7 @@ from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdExcep
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError
 from orm.models import ToasterSetting, Build
 import os
+import sys, traceback
 
 def DN(path):
     if path is None:
@@ -228,7 +229,7 @@ class Command(NoArgsCommand):
 
 
 
-    def handle(self, **options):
+    def handle_noargs(self, **options):
         retval = 0
         retval += self._verify_artifact_storage_dir()
         retval += self._verify_build_environment()
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4f07e37..b3f8db9 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -807,7 +807,6 @@ class LayerIndexLayerSource(LayerSource):
             Fetches layer, recipe and machine information from remote repository
         """
         assert self.apiurl is not None
-        from django.db import IntegrityError
         from django.db import transaction, connection
 
         import httplib, urlparse, json
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 889b6c6..7be7f71 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -102,8 +102,7 @@ def _project_recent_build_list(prj):
 
 def objtojson(obj):
     from django.db.models.query import QuerySet
-    from django.db.models import Model, IntegerField
-    from django.db.models.fields.related import ForeignKey
+    from django.db.models import Model
 
     if isinstance(obj, datetime):
         return obj.isoformat()
@@ -266,8 +265,8 @@ def _get_filtering_query(filter_string):
 
     return reduce(operator.and_, [k for k in and_query])
 
-def _get_toggle_order(request, orderkey, reverse = False):
-    if reverse:
+def _get_toggle_order(request, orderkey, toggle_reverse = False):
+    if toggle_reverse:
         return "%s:+" % orderkey if request.GET.get('orderby', "") == "%s:-" % orderkey else "%s:-" % orderkey
     else:
         return "%s:-" % orderkey if request.GET.get('orderby', "") == "%s:+" % orderkey else "%s:+" % orderkey
@@ -522,7 +521,9 @@ def builddashboard( request, build_id ):
 
 
 
-def generateCoveredList2( revlist = [] ):
+def generateCoveredList2( revlist = None ):
+    if revlist is None:
+        revlist = []
     covered_list =  [ x for x in revlist if x.outcome == Task.OUTCOME_COVERED ]
     while len(covered_list):
         revlist =  [ x for x in revlist if x.outcome != Task.OUTCOME_COVERED ]
@@ -910,9 +911,7 @@ def _get_dir_entries(build_id, target_id, start):
 
         except Exception as e:
             print "Exception ", e
-            import traceback
             traceback.print_exc(e)
-            pass
 
     # sort by directories first, then by name
     rsorted = sorted(response, key=lambda entry :  entry['name'])
@@ -936,7 +935,7 @@ def dirinfo(request, build_id, target_id, file_path=None):
         dir_list = []
         head = file_path
         while head != sep:
-            (head,tail) = os.path.split(head)
+            (head, tail) = os.path.split(head)
             if head != sep:
                 dir_list.insert(0, head)
 
@@ -1837,7 +1836,6 @@ def image_information_dir(request, build_id, target_id, packagefile_id):
 
 
 def managedcontextprocessor(request):
-    import subprocess
     ret = {
         "projects": Project.objects.all(),
         "DEBUG" : toastermain.settings.DEBUG,
@@ -1865,13 +1863,9 @@ if True:
 
     import traceback
 
-    class BadParameterException(Exception): pass        # error thrown on invalid POST requests
-
-
-    class InvalidRequestException(Exception):
-        def __init__(self, response):
-            self.response = response
-
+    class BadParameterException(Exception):
+        ''' The exception raised on invalid POST requests '''
+        pass
 
     # shows the "all builds" page for managed mode; it displays build requests (at least started!) instead of actual builds
     @_template_renderer("builds.html")
@@ -2474,7 +2468,7 @@ if True:
         try:
             layer_version_id = request.POST["layer_version_id"]
             layer_version = Layer_Version.objects.get(id=layer_version_id)
-        except:
+        except Layer_Version.DoesNotExist:
             return error_response("Cannot find layer to update")
 
 
@@ -2503,8 +2497,8 @@ if True:
         try:
             layer_version.layer.save()
             layer_version.save()
-        except:
-            return error_response("Could not update layer version entry")
+        except Exception as e:
+            return error_response("Could not update layer version entry: %s" % e)
 
         return HttpResponse(jsonfilter({"error": "ok",}), content_type = "application/json")
 
-- 
2.1.4


