Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 39192773B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48M007485; Wed, 1 Jun 2016 13:37:06 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Yfn8mELpG5Br; Wed,  1 Jun 2016 13:37:06 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxWT007453
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000o7-BJ; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:30 +0100
Message-Id: <1464784607-2985-11-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 11/28] toaster: get rid of using reduce
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:11 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Replaced compicated calls of reduce with more clear code.
As reduce was removed from python 3 this change is mandatory
for the code to work on both pythons.

Here is an example change for illustration purposes:

original code:

  querydict = dict(zip(or_keys, or_values))
  query = reduce(operator.or_, map(lambda x: __get_q_for_val(x, querydict[x]), [k for k in querydict])))

replaced with:

  query = None
  for key, val in zip(or_keys, or_values):
      x = __get_q_for_val(k, val)
      query = query | x if query else x

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/toastergui/views.py   | 64 +++++++++++++++++++++++++++------------
 lib/toaster/toastergui/widgets.py | 20 +++++++-----
 2 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e78b0da..22d1a0c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -229,10 +229,18 @@ OR_VALUE_SEPARATOR = "|"
 DESCENDING = "-"
 
 def __get_q_for_val(name, value):
-    if "OR" in value:
-        return reduce(operator.or_, map(lambda x: __get_q_for_val(name, x), [ x for x in value.split("OR") ]))
+    if "OR" in value or "AND" in value:
+        result = None
+        for x in value.split("OR"):
+             x = __get_q_for_val(name, x)
+             result = result | x if result else x
+        return result
     if "AND" in value:
-        return reduce(operator.and_, map(lambda x: __get_q_for_val(name, x), [ x for x in value.split("AND") ]))
+        result = None
+        for x in value.split("AND"):
+            x = __get_q_for_val(name, x)
+            result = result & x if result else x
+        return result
     if value.startswith("NOT"):
         value = value[3:]
         if value == 'None':
@@ -251,14 +259,18 @@ def _get_filtering_query(filter_string):
     and_keys = search_terms[0].split(AND_VALUE_SEPARATOR)
     and_values = search_terms[1].split(AND_VALUE_SEPARATOR)
 
-    and_query = []
+    and_query = None
     for kv in zip(and_keys, and_values):
         or_keys = kv[0].split(OR_VALUE_SEPARATOR)
         or_values = kv[1].split(OR_VALUE_SEPARATOR)
-        querydict = dict(zip(or_keys, or_values))
-        and_query.append(reduce(operator.or_, map(lambda x: __get_q_for_val(x, querydict[x]), [k for k in querydict])))
+        query = None
+        for key, val in zip(or_keys, or_values):
+            x = __get_q_for_val(k, val)
+            query = query | x if query else x
 
-    return reduce(operator.and_, [k for k in and_query])
+        and_query = and_query & query if and_query else query
+
+    return and_query
 
 def _get_toggle_order(request, orderkey, toggle_reverse = False):
     if toggle_reverse:
@@ -295,21 +307,24 @@ def _validate_input(field_input, model):
         # Check we are looking for a valid field
         valid_fields = model._meta.get_all_field_names()
         for field in field_input_list[0].split(AND_VALUE_SEPARATOR):
-            if not reduce(lambda x, y: x or y, [ field.startswith(x) for x in valid_fields ]):
-                return None, (field, [ x for x in valid_fields ])
+            if True in [field.startswith(x) for x in valid_fields]:
+                break
+        else:
+           return None, (field, valid_fields)
 
     return field_input, invalid
 
 # uses search_allowed_fields in orm/models.py to create a search query
 # for these fields with the supplied input text
 def _get_search_results(search_term, queryset, model):
-    search_objects = []
+    search_object = None
     for st in search_term.split(" "):
-        q_map = map(lambda x: Q(**{x+'__icontains': st}),
-                model.search_allowed_fields)
+        queries = None
+        for field in model.search_allowed_fields:
+            query =  Q(**{x+'__icontains': st})
+            queries = queries | query if queries else query
 
-        search_objects.append(reduce(operator.or_, q_map))
-    search_object = reduce(operator.and_, search_objects)
+        search_object = search_object & queries if search_object else queries
     queryset = queryset.filter(search_object)
 
     return queryset
@@ -1938,10 +1953,10 @@ if True:
                 if ptype == "build":
                     mandatory_fields.append('projectversion')
                 # make sure we have values for all mandatory_fields
-                if reduce( lambda x, y: x or y, map(lambda x: len(request.POST.get(x, '')) == 0, mandatory_fields)):
-                # set alert for missing fields
-                    raise BadParameterException("Fields missing: " +
-            ", ".join([x for x in mandatory_fields if len(request.POST.get(x, '')) == 0 ]))
+                missing = [field for field in mandatory_fields if len(request.POST.get(field, '')) == 0]
+                if missing:
+                    # set alert for missing fields
+                    raise BadParameterException("Fields missing: %s" % ", ".join(missing))
 
                 if not request.user.is_authenticated():
                     user = authenticate(username = request.POST.get('username', '_anonuser'), password = 'nopass')
@@ -2035,13 +2050,22 @@ if True:
         from collections import Counter
         freqtargets = []
         try:
-            freqtargets += map(lambda x: x.target, reduce(lambda x, y: x + y,   map(lambda x: list(x.target_set.all()), Build.objects.filter(project = prj, outcome__lt = Build.IN_PROGRESS))))
-            freqtargets += map(lambda x: x.target, reduce(lambda x, y: x + y,   map(lambda x: list(x.brtarget_set.all()), BuildRequest.objects.filter(project = prj, state = BuildRequest.REQ_FAILED))))
+            btargets = sum(build.target_set.all() for build in Build.objects.filter(project=prj, outcome__lt=Build.IN_PROGRESS))
+            brtargets = sum(br.brtarget_set.all() for br in BuildRequest.objects.filter(project = prj, state = BuildRequest.REQ_FAILED))
+            freqtargets = [x.target for x in btargets] + [x.target for x in brtargets]
         except TypeError:
             pass
         freqtargets = Counter(freqtargets)
         freqtargets = sorted(freqtargets, key = lambda x: freqtargets[x], reverse=True)
 
+        layers = [{"id": x.layercommit.pk, "orderid": x.pk, "name" : x.layercommit.layer.name,
+                   "vcs_url": x.layercommit.layer.vcs_url, "vcs_reference" : x.layercommit.get_vcs_reference(),
+                   "url": x.layercommit.layer.layer_index_url, "layerdetailurl": x.layercommit.get_detailspage_url(prj.pk),
+                   # This branch name is actually the release
+                   "branch" : {"name" : x.layercommit.get_vcs_reference(),
+                               "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}
+                   } for x in prj.projectlayer_set.all().order_by("id")]
+
         context = {
             "project" : prj,
             "lvs_nos" : Layer_Version.objects.all().count(),
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 4117031..0f972d9 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -239,14 +239,20 @@ class ToasterTable(TemplateView):
             raise Exception("Search fields aren't defined in the model %s"
                             % self.queryset.model)
 
-        search_queries = []
+        search_queries = None
         for st in search_term.split(" "):
-            q_map = [Q(**{field + '__icontains': st})
-                     for field in self.queryset.model.search_allowed_fields]
-
-            search_queries.append(reduce(operator.or_, q_map))
-
-        search_queries = reduce(operator.and_, search_queries)
+            queries = None
+            for field in self.queryset.model.search_allowed_fields:
+                query = Q(**{field + '__icontains': st})
+                if queries:
+                    queries |= query
+                else:
+                    queries = query
+
+            if search_queries:
+               search_queries &= queries
+            else:
+               search_queries = queries
 
         self.queryset = self.queryset.filter(search_queries)
 
-- 
2.5.0


