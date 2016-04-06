Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 156C2771AB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:27 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id f198so81804468wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=k2gP5pdWmhF9L+7sVT/LM5UOu0yRIz1sae/eyhBOIL8=;
	b=g5qUGq+BSmmET2fGn+V+EQT3Svx0hx1kZ8VYZFraCrNtv5XvKcmmZjWyNWLtAghQeM
	wbE0WVXT6+T4NuHA24KGAAgZ25klNgXAEljCv8VwhP2hb1uzaEs1C8Ic1Qr0EOEoa0G/
	KwA3f2wyYhCNCk1xWD8PkjzQs4FZX2k3LEthlWzw8CgfM5kX2yOSWsBBEcYFEmWWc8mD
	kC1xDWCndB0lU2XM/Fenl/I8wlGjuX3y+cVRUHYCouk9zTZ7XJKzhoFRN+9kwpmYkou7
	R1Q95zqm2yt8AniN2hFRD9aXH0DxnHa5XSH4v0NE+rD05pXS/xoFmUcGtTHYgPiGgejy
	s4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=k2gP5pdWmhF9L+7sVT/LM5UOu0yRIz1sae/eyhBOIL8=;
	b=Twyt3v0TfW0bRNeHdv0ZdPjv2k4iYeG4yAZl2O++idjtUHnouypK4wEfZ6fqpkZ0xl
	36BK1+BycnrcOql/tZ+QgGjgTIcymBXIjjY8jEewKPK+zS8znqxdotERuDIwXTkR88w0
	tt0VCPfhAy4fl3/8Wd1WAyvv1lk7diuo4Z1J2Wtj3IaH0UPESSDDzBgtMAJfBBcw65Bv
	BvWACTGfuC6npCb4Yjuh0qNarEBxCb0wxWRE9LrGZqxXTfKruKrWYgzgWQ7z3AeeaiXg
	nAGNNfs3pOAnvm1ybyJWaCWhhTl2zGGEvZCScdKkalZWDM+LBJhdlsV2KNR1AOsJcU6Y
	WZhg==
X-Gm-Message-State: AD7BkJINTYfxTmWqq4OP0L/59OqlLrslGTXA546QQ0GMuTd8cEThf3m8ieaQLwNVB8UhpL7y
X-Received: by 10.194.2.210 with SMTP id 18mr11512063wjw.55.1459961247585;
	Wed, 06 Apr 2016 09:47:27 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:26 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:31 +0100
Message-Id: <feebed7a0dc79d8769ec4aa45b5393b1d225767d.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 21/38] toaster: xhr Update the implementation of the build cancellation request
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:27 -0000

Update the implementation of the backend api for cancelling builds with
the new cancelling BuildRequest state and cancelled Build state.
Also added some docstring about general usage.

Co-Author: Sujith H <sujith.h@gmail.com>

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/api.py | 54 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 1b1f598..42901f75 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -19,7 +19,7 @@
 
 # Temporary home for the UI's misc API
 
-from orm.models import Project, ProjectTarget
+from orm.models import Project, ProjectTarget, Build
 from bldcontrol.models import BuildRequest
 from bldcontrol import bbcontroller
 from django.http import HttpResponse, JsonResponse
@@ -32,18 +32,54 @@ class XhrBuildRequest(View):
         return HttpResponse()
 
     def post(self, request, *args, **kwargs):
-        """ Process HTTP POSTs which make build requests """
+        """
+          Build control
+
+          Entry point: /xhr_buildrequest/<project_id>
+          Method: POST
+
+          Args:
+              id: id of build to change
+              buildCancel = build_request_id ...
+              buildDelete = id ...
+              targets = recipe_name ...
+
+          Returns:
+              {"error": "ok"}
+            or
+              {"error": <error message>}
+        """
 
         project = Project.objects.get(pk=kwargs['pid'])
 
         if 'buildCancel' in request.POST:
             for i in request.POST['buildCancel'].strip().split(" "):
                 try:
-                    br = BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_QUEUED)
-                    br.state = BuildRequest.REQ_DELETED
+                    br = BuildRequest.objects.get(project=project, pk=i)
+
+                    try:
+                        bbctrl = bbcontroller.BitbakeController(br.environment)
+                        bbctrl.forceShutDown()
+                    except:
+                        # We catch a bunch of exceptions here because
+                        # this is where the server has not had time to start up
+                        # and the build request or build is in transit between
+                        # processes.
+                        # We can safely just set the build as cancelled
+                        # already as it never got started
+                        build = br.build
+                        build.outcome = Build.CANCELLED
+                        build.save()
+
+                    # We now hand over to the buildinfohelper to update the
+                    # build state once we've finished cancelling
+                    br.state = BuildRequest.REQ_CANCELLING
                     br.save()
+
                 except BuildRequest.DoesNotExist:
-                    pass
+                    return JsonResponse({'error':'No such build id %s' % i})
+
+            return JsonResponse({'error': 'ok'})
 
         if 'buildDelete' in request.POST:
             for i in request.POST['buildDelete'].strip().split(" "):
@@ -51,6 +87,7 @@ class XhrBuildRequest(View):
                     BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
                 except BuildRequest.DoesNotExist:
                     pass
+            return JsonResponse({'error': 'ok' })
 
         if 'targets' in request.POST:
             ProjectTarget.objects.filter(project = project).delete()
@@ -66,9 +103,8 @@ class XhrBuildRequest(View):
                                              task = task)
             project.schedule_build()
 
-        # redirect back to builds page so any new builds in progress etc.
-        # are visible
+            return JsonResponse({'error': 'ok' })
+
         response = HttpResponse()
-        response.status_code = 302
-        response['Location'] = request.build_absolute_uri()
+        response.status_code = 500
         return response
-- 
2.1.4


