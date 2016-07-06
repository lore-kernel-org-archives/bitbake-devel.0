Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id B82FF60119
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2016 17:22:50 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E29B0123109;
	Wed,  6 Jul 2016 17:22:50 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-42-131-234.us-west-2.compute.internal [10.42.131.234])
	by relay.mailchannels.net (Postfix) with ESMTPA id 5617E123E0D;
	Wed,  6 Jul 2016 17:22:50 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com ([TEMPUNAVAIL].
	[10.135.9.54]) (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.15); Wed, 06 Jul 2016 17:22:50 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1467825770644:794919761
X-MC-Ingress-Time: 1467825770644
Received: from [176.251.41.101] (port=34404 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bKqZm-0000gg-Ca; Wed, 06 Jul 2016 13:25:30 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Jul 2016 18:22:37 +0100
Message-Id: <527df42c089f4e0154e65beac2d3b4e6032356e1.1467825407.git.elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2554ed0be16cfdf0f1cdbe2911c21cf4396cb156.1467825407.git.elliot.smith@intel.com>
References: <2554ed0be16cfdf0f1cdbe2911c21cf4396cb156.1467825407.git.elliot.smith@intel.com>
In-Reply-To: <cover.1467825407.git.elliot.smith@intel.com>
References: <cover.1467825407.git.elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 2/4] toaster: api Add util function for returning the error response
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
X-List-Received-Date: Wed, 06 Jul 2016 17:22:51 -0000

From: Michael Wood <michael.g.wood@intel.com>

Also clean up flake8 warnings in XhrBuildRequest

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/api.py | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index a024748..112ce58 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -29,6 +29,9 @@ from django.views.generic import View
 from django.core.urlresolvers import reverse
 
 
+def error_response(error):
+    return JsonResponse({"error": error})
+
 
 class XhrBuildRequest(View):
 
@@ -81,20 +84,24 @@ class XhrBuildRequest(View):
                     br.save()
 
                 except BuildRequest.DoesNotExist:
-                    return JsonResponse({'error':'No such build id %s' % i})
+                    return error_response('No such build id %s' % i)
 
-            return JsonResponse({'error': 'ok'})
+            return error_response('ok')
 
         if 'buildDelete' in request.POST:
             for i in request.POST['buildDelete'].strip().split(" "):
                 try:
-                    BuildRequest.objects.select_for_update().get(project = project, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
+                    BuildRequest.objects.select_for_update().get(
+                        project=project,
+                        pk=i,
+                        state__lte=BuildRequest.REQ_DELETED).delete()
+
                 except BuildRequest.DoesNotExist:
                     pass
-            return JsonResponse({'error': 'ok' })
+            return error_response("ok")
 
         if 'targets' in request.POST:
-            ProjectTarget.objects.filter(project = project).delete()
+            ProjectTarget.objects.filter(project=project).delete()
             s = str(request.POST['targets'])
             for t in re.sub(r'[;%|"]', '', s).split(" "):
                 if ":" in t:
@@ -102,12 +109,12 @@ class XhrBuildRequest(View):
                 else:
                     target = t
                     task = ""
-                ProjectTarget.objects.create(project = project,
-                                             target = target,
-                                             task = task)
+                ProjectTarget.objects.create(project=project,
+                                             target=target,
+                                             task=task)
             project.schedule_build()
 
-            return JsonResponse({'error': 'ok' })
+            return error_response('ok')
 
         response = HttpResponse()
         response.status_code = 500
@@ -135,9 +142,6 @@ class XhrLayer(View):
               {"error": <error message>}
         """
 
-        def error_response(error):
-            return JsonResponse({"error": error})
-
         try:
             # We currently only allow Imported layers to be edited
             layer_version = Layer_Version.objects.get(
-- 
2.7.4


