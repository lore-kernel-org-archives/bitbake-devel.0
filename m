Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id A8AB8758D3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:37 +0000 (UTC)
Received: by wifx6 with SMTP id x6so49707228wif.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=qpjonM4OUkjtkxt6EoT4Yu88OMtnLFQIYdKD4EUEt60=;
	b=T/g2rMOoNOze5ibtU4jYz7n0zXK7xKnJrC3ibiC6luWena+mtMCGVbLcqnDad8Ae2G
	SIycEJcedXz6PPPi+lqMAPWEsx5ERj5iELZi8i9yRVlyAtrqenjOnK3w3SsjOkBB6mx6
	2PqdO517Fy1l3NDVRTM9SfkmcwFAw3svmRw8C/GhOSA2FWl2UQYijAIHSqVKBLi7oRnv
	Re6db+Gec8x3cK2deG1JTCfDLaQs4xEhh8jF75yuNt5nAUIfdi80EB48pYn03Aly0kSJ
	d/sBKljoX32vrLDUVJQhlZgM4DyIi/ijM2nLJMCAZje8XZEG3zIwqiqCP+dhDWWwOjX4
	50dA==
X-Gm-Message-State: ALoCoQmMgWZxGUI42Sj0HnVvZetw34T7B031n2MehHwUfozB57hWouRMm78IB0GIxk6EkQbU1rXM
X-Received: by 10.195.13.1 with SMTP id eu1mr6881361wjd.131.1433947178808;
	Wed, 10 Jun 2015 07:39:38 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id u7sm8293140wif.3.2015.06.10.07.39.37
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:38 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 177195611AB; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:57 +0100
Message-Id: <d3edea773000a663f5883e04f477d853bff64cf6.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 09/19] toaster: add class template view for single-object pages
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:38 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding ToasterTemplateView as prototype for all class-based
views that display single objects; equivalent to ToasterTable
for object lists.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/tables.py  | 12 ++++++++++--
 lib/toaster/toastergui/widgets.py | 26 ++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index e540b91..e03aa76 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -19,7 +19,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-from toastergui.widgets import ToasterTable
+from toastergui.widgets import ToasterTable, ToasterTemplateView
 from orm.models import Recipe, ProjectLayer, Layer_Version, Machine, Project
 from django.db.models import Q, Max
 from django.conf.urls import url
@@ -142,16 +142,24 @@ class LayersTable(ToasterTable):
                         static_data_name="add-del-layers",
                         static_data_template='{% include "layer_btn.html" %}')
 
-class LayerDetails(TemplateView):
+
+
+class LayerDetails(ToasterTemplateView):
     def get_context_data(self, **kwargs):
         context = super(LayerDetails, self).get_context_data(**kwargs)
+        from toastergui.views import _lv_to_dict
 
         context['project'] = Project.objects.get(pk=kwargs['pid'])
         context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
+        context['layerdict'] = _lv_to_dict(context['project'], context['layerversion'])
+        context['layerdeps'] = {"list": [x.depends_on.get_equivalents_wpriority(context['project'])[0] for x in context['layerversion'].dependencies.all()]}
         context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
 
+        self.context_entries = ['project', 'layerversion', 'projectlayers', 'layerdict', 'layerdeps']
+
         return context
 
+
 class MachinesTable(ToasterTable):
     """Table of Machines in Toaster"""
 
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 3d3c1d1..8bc3d7f 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -325,3 +325,29 @@ class ToasterTable(TemplateView):
         cache.set(cache_name, data, 60*30)
 
         return data
+
+
+class ToasterTemplateView(TemplateView):
+    # renders a instance in a template, or returns the context as json
+    # the class-equivalent of the _template_renderer decorator for views
+
+
+    def get(self, *args, **kwargs):
+        if self.request.GET.get('format', None) == 'json':
+            from django.core.urlresolvers import reverse
+            from django.shortcuts import HttpResponse
+            from views import objtojson
+            from toastergui.templatetags.projecttags import json as jsonfilter
+
+            context = self.get_context_data(**kwargs)
+
+            for x in context.keys():
+                if x not in self.context_entries:
+                    del context[x]
+
+            context["error"] = "ok"
+
+            return HttpResponse(jsonfilter(context,  default=objtojson ),
+                            content_type = "application/json; charset=utf-8")
+
+        return super(ToasterTemplateView, self).get(*args, **kwargs)
-- 
1.9.1


