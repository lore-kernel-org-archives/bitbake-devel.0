Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id C8F97758EC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:26 +0000 (UTC)
Received: by wibut5 with SMTP id ut5so50718101wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ZpsfKfXIpBtB5/MH7X/JyXmSxU7UHU1DpzG9m0B91Vc=;
	b=IMhXAe8FKOeRapk3Ll51AyMH1Jex0eGHdp/qP4ogqVjbJlsLYnfTu35KODuSYddrQc
	9xyXpNAJ8/c+ZPM1lJGAuVB6ytIW5ShgjQedkfRcFG6SInBbFBeIs1W9bAcq8ug3Jr7y
	YMwT+euPQ5ApCKRwPOSHEiRfDNq8UvXNdFs2ki/NYP3r8mDeI3dayMfjKvUJaYArJ2GB
	RDP+1hz6pDhOnyVDIn4dZ2cOHpoT4yQh0mEQ0agzfYjSsHzTVdenPVEdtxsu+oz+KusL
	o+Y3tlqc4tN4BpXKZ9h9ANlqF3Us9OOFdXdjsF297XIEWITCrXmefXbEey/FWqgNBbkm
	GY/Q==
X-Gm-Message-State: ALoCoQlpy3dWAdeIYUk3EWUhayKuNivksrzH7XW/2sGv2SxuH0AKphsxwII9SAP/5nO/+prbQKnV
X-Received: by 10.194.188.107 with SMTP id fz11mr6667900wjc.98.1433947167390; 
	Wed, 10 Jun 2015 07:39:27 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	wi1sm14881147wjb.41.2015.06.10.07.39.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:26 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 11CC1561128; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:54 +0100
Message-Id: <928ee3fd4b52ea14b7eb704f1f27351362a9d27a.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 06/19] toaster: toaster table add raw data
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:27 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add in a JSON response both the raw data and the rendered
version for display. The rendered fields start with "static:"
to mark a different "namespace".

The toaster.js is updated to always display the "static:" version
of a field, if it exists (and ignore the raw data unless the
static rendering is missing).

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/table.js | 14 +++++++++++++-
 lib/toaster/toastergui/views.py           | 31 ++++++++++++++++++++++++++++++-
 lib/toaster/toastergui/widgets.py         | 16 +++++++++++-----
 3 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 7588a4a..80e9ec2 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -113,8 +113,20 @@ function tableInit(ctx){
     for (var i in tableData.rows){
       var row = $("<tr></tr>");
       for (var key_j in tableData.rows[i]){
+        /* if we have a static: version of a key, prefer the static: version for rendering */
+        var orig_key_j = key_j;
+
+        if (key_j.indexOf("static:") === 0) {
+          if (key_j.substr("static:".length) in tableData.rows[i]) {
+            continue;
+          }
+          orig_key_j = key_j.substr("static:".length)
+        } else if (("static:" + key_j) in tableData.rows[i]) {
+          key_j = "static:" + key_j;
+        }
+
         var td = $("<td></td>");
-        td.prop("class", key_j);
+        td.prop("class", orig_key_j);
         if (tableData.rows[i][key_j]){
           td.html(tableData.rows[i][key_j]);
         }
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 91c4fa2..280159a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -87,6 +87,35 @@ def _project_recent_build_list(prj):
             list(prj.buildrequest_set.filter(state__in=[BuildRequest.REQ_COMPLETED, BuildRequest.REQ_FAILED]).order_by("-pk")[:3]))
 
 
+
+def objtojson(obj):
+    from django.db.models.query import QuerySet
+    from django.db.models import Model, IntegerField
+    from django.db.models.fields.related import ForeignKey
+
+    if isinstance(obj, datetime):
+        return obj.isoformat()
+    elif isinstance(obj, timedelta):
+        return obj.total_seconds()
+    elif isinstance(obj, QuerySet) or isinstance(obj, set):
+        return list(obj)
+    elif type(obj).__name__ == "RelatedManager":
+        return [x.pk for x in obj.all()]
+    elif hasattr( obj, '__dict__') and isinstance(obj, Model):
+        d = obj.__dict__
+        nd = dict(d)
+        for di in d.keys():
+            if di.startswith("_"):
+                del nd[di]
+            elif isinstance(d[di], Model):
+                nd[di] = d[di].pk
+            elif isinstance(d[di], int) and hasattr(obj, "get_%s_display" % di):
+                nd[di] = getattr(obj, "get_%s_display" % di)()
+        return nd
+    else:
+        raise TypeError("Unserializable object %s (%s) of type %s" % ( obj, dir(obj), type(obj)))
+
+
 def _template_renderer(template):
     def func_wrapper(view):
         def returned_wrapper(request, *args, **kwargs):
@@ -127,7 +156,7 @@ def _template_renderer(template):
                     else:
                         raise TypeError("Unserializable object %s of type %s" % ( obj, type(obj)))
 
-                return HttpResponse(jsonfilter(context, default=_objtojson ),
+                return HttpResponse(jsonfilter(context, default=objtojson ),
                             content_type = "application/json; charset=utf-8")
             else:
                 return render(request, template, context)
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 4347a3f..82b7514 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -37,6 +37,7 @@ import json
 import collections
 import operator
 
+from toastergui.views import objtojson
 
 class ToasterTable(TemplateView):
     def __init__(self, *args, **kwargs):
@@ -275,19 +276,25 @@ class ToasterTable(TemplateView):
 
                 for col in self.columns:
                     field = col['field_name']
+                    if not field:
+                        field = col['static_data_name']
+                    if not field:
+                        raise Exception("Must supply a field_name or static_data_name for column %s.%s" % (self.__class__.__name__,col))
                     # Check if we need to process some static data
                     if "static_data_name" in col and col['static_data_name']:
-                        required_data[col['static_data_name']] = self.render_static_data(col['static_data_template'], row)
+                        required_data["static:%s" % col['static_data_name']] = self.render_static_data(col['static_data_template'], row)
 
                         # Overwrite the field_name with static_data_name
                         # so that this can be used as the html class name
 
                         col['field_name'] = col['static_data_name']
-                    else:
+
+                    if True:        # we add the raw model data at all times
                         model_data = row
                         # Traverse to any foriegn key in the object hierachy
                         for subfield in field.split("__"):
-                            model_data = getattr(model_data, subfield)
+                            if hasattr(model_data, subfield):
+                                model_data = getattr(model_data, subfield)
                         # The field could be a function on the model so check
                         # If it is then call it
                         if isinstance(model_data, types.MethodType):
@@ -299,8 +306,7 @@ class ToasterTable(TemplateView):
 
         except FieldError:
             print "Error: Requested field does not exist"
-
-        data = json.dumps(data, indent=2, cls=DjangoJSONEncoder)
+        data = json.dumps(data, indent=2, default=objtojson)
         cache.set(cache_name, data, 60*30)
 
         return data
-- 
1.9.1


