Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 527F66013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:11 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id g23so32318607wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WDQ1pulobGxXH+LylW+WmhzaItUk1a39I4+Z/TvgJoA=;
	b=KWfo5y3ummON+gVwbiyKB4LIH8s724nPioRAUL0W3BvFMvLYHTihaTF+2qBjnU4zee
	GJxvv6cx/hSAkbAJpbYtZmz4u2E6e3w1BAduyIfkX96f+Z/Dnm7wXjpcjXtCSVD6nZu5
	Bu+OCHTqLDV2TosYdPe9DpccbMdUcmw06E5Gu+Xvrev2lGXEyp6j+x7g+B0iwssq2iqL
	XzC52sXZTE6V4WvvlRwNwMTA0qyXSizAe3F5QeUbUTwnWDqttGbRPILxBMk9IzLIY5ZS
	fgNsnAExCUfNqL5ijJXLU2Iz4MKmf8b3ZM2YDAI6N3OX3QtfwXcFyA2E8BQqjAmXPy/S
	x7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=WDQ1pulobGxXH+LylW+WmhzaItUk1a39I4+Z/TvgJoA=;
	b=dZ9E5m3YwbOa7e3zG0NjQxPWVhL/woe8efQlK9jd2u8jgPgnGj7B4kmQhnFPzQK9wH
	jTAyEmzCZms8uREKJIk8kULWwu3XzXZxvImeES7tbVwczF+svjqepK7mbyqhjYR4pVBC
	gUBdMPhYCigqj+rF8qfKp0jYkmijVyeVQ3AF6UK0leqwNt2HfBXfU//7MLQtUJlQHFyj
	ex2h58aTHdLlOg7JPJhT1MIaRM7kGaZ6gP19eKnSwuPmJ6auZo4MfCFzlFOAJu+H6qSA
	ONUjZt8tw3ZcpUr4H9PvrWB1UfwEOWsoGyNYEvZ8LQd4HfIo/w8VwF7i3WhQ9BtvY4Mf
	oWNw==
X-Gm-Message-State: AKaTC010eHjcsRQdWtrRzRRPwDR/YYWJFbPrf5AcPJhZ55Xb07rA2e9eCppEV6dsQ3DJy7aV
X-Received: by 10.28.138.137 with SMTP id m131mr7430490wmd.118.1481302392841; 
	Fri, 09 Dec 2016 08:53:12 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:12 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:51 +0000
Message-Id: <1481302375-7985-11-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 10/14] toaster: api Add GET REST API for Layer information
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:12 -0000

Add a get API for returning information about layers.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/api.py | 55 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 5be633e..5b03550 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -139,9 +139,55 @@ class XhrBuildRequest(View):
 class XhrLayer(View):
     """ Delete, Get, Add and Update Layer information
 
-        Methods: POST DELETE PUT
+        Methods: GET POST DELETE PUT
     """
 
+    def get(self, request, *args, **kwargs):
+        """
+        Get layer information
+
+        Method: GET
+        Entry point: /xhr_layer/<project id>/<layerversion_id>
+        """
+
+        try:
+            layer_version = Layer_Version.objects.get(
+                pk=kwargs['layerversion_id'])
+
+            project = Project.objects.get(pk=kwargs['pid'])
+
+            project_layers = ProjectLayer.objects.filter(
+                project=project).values_list("layercommit_id",
+                                             flat=True)
+
+            ret = {
+                'error': 'ok',
+                'id': layer_version.pk,
+                'name': layer_version.layer.name,
+                'layerdetailurl':
+                layer_version.get_detailspage_url(project.pk),
+                'vcs_ref': layer_version.get_vcs_reference(),
+                'vcs_url': layer_version.layer.vcs_url,
+                'local_source_dir': layer_version.layer.local_source_dir,
+                'layerdeps': {
+                    "list": [
+                        {
+                            "id": dep.id,
+                            "name": dep.layer.name,
+                            "layerdetailurl":
+                            dep.get_detailspage_url(project.pk),
+                            "vcs_url": dep.layer.vcs_url,
+                            "vcs_reference": dep.get_vcs_reference()
+                        }
+                        for dep in layer_version.get_alldeps(project.id)]
+                },
+                'projectlayers': list(project_layers)
+            }
+
+            return JsonResponse(ret)
+        except Layer_Version.DoesNotExist:
+            error_response("No such layer")
+
     def post(self, request, *args, **kwargs):
         """
           Update a layer
@@ -211,7 +257,7 @@ class XhrLayer(View):
         """ Add a new layer
 
         Method: PUT
-        Entry point: /xhr_layer/
+        Entry point: /xhr_layer/<project id>/
         Args:
             project_id, name,
             [vcs_url, dir_path, git_ref], [local_source_dir], [layer_deps
@@ -296,7 +342,7 @@ class XhrLayer(View):
         """ Delete an imported layer
 
         Method: DELETE
-        Entry point: /xhr_layer/<layerversion_id>
+        Entry point: /xhr_layer/<projed id>/<layerversion_id>
 
         """
         try:
@@ -888,6 +934,9 @@ class XhrProject(View):
                 "url": layer.layercommit.layer.layer_index_url,
                 "layerdetailurl": layer.layercommit.get_detailspage_url(
                     project.pk),
+                "xhrLayerUrl": reverse("xhr_layer",
+                                       args=(project.pk,
+                                             layer.layercommit.pk)),
                 "layersource": layer.layercommit.layer_source
             })
 
-- 
2.7.4


