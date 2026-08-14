Return-Path: <paolo.wattebled@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5ECC5CFCF
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15786.1786721773491087293
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Aug 2026 08:36:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=EgvLfwKD;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: paolo.wattebled@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A15563D8189E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 11:36:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id yCWV2-FWbcsO; Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3A58D3D818A9;
	Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3A58D3D818A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1786721768; bh=uMhOOIMdte8VwwUUE2ApI9jIkbzzw5NZjzwMrOoG/gM=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=EgvLfwKDuIKMRB1qiO5AVc9ShxZfU0WvOP2dUAdKCufGS6/uqFPXpL/+LJgu0scI3
	 NVMWz52POXHMcGDsyZNBo+dFaGtiC/c2Nl1gsrGIRA4IFBknZzzNO9MMiEkZFcOuf5
	 C1LVLRj1wZ4OumUdC8sXFBdFGQW5/mfkNkCLpgXFcnYi8DdHg8GGFBWCu8Estdbmy+
	 I1fypPQvy9u02Cbory3j7KGpupmyYDPh+1hqekGVXeO/BnC8bSvRNMqxcwk1DFPxww
	 cRSO18w9nHRedMdZvlWP/sP6nCTyNjAF91U7ftPbgqBTu4G0apmw09E7iVWkvsfbOe
	 iHm1x1NThbnhQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id n24ilhdkweI9; Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
Received: from pwattebled.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 09CE83D818FA;
	Fri, 14 Aug 2026 11:36:08 -0400 (EDT)
From: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Subject: [PATCH v2 5/5] toaster: Add recipe variables view on UI
Date: Fri, 14 Aug 2026 11:35:58 -0400
Message-ID: <20260814153602.2107764-6-paolo.wattebled@savoirfairelinux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
References: <20260814153602.2107764-1-paolo.wattebled@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Aug 2026 15:36:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19943

Expose build-specific recipe variable snapshots through a searchable and
paginated Variables tab. Show snapshot counts in the built recipes table
and recipe package navigation.

Cover build and recipe scoping, pagination, ordering, escaping, empty
states and query parameter validation with view tests.

AI-Generated: Uses GitHub Copilot and OpenCode with GPT-5.6 Sol
Signed-off-by: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
---
 lib/toaster/tests/views/test_views.py         | 155 +++++++++++++++++-
 lib/toaster/toastergui/buildtables.py         |  11 +-
 lib/toaster/toastergui/templates/recipe.html  |  32 ++++
 .../toastergui/templates/recipe_packages.html |   7 +
 lib/toaster/toastergui/views.py               |  68 +++++++-
 5 files changed, 269 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/vi=
ews/test_views.py
index e1adfcf86..bed572c76 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -10,14 +10,16 @@
 """Test cases for Toaster GUI and ReST."""
=20
 import os
+import zlib
 import pytest
 from django.test import TestCase
 from django.test.client import RequestFactory
 from django.urls import reverse
 from django.db.models import Q
=20
-from orm.models import Project, Package
+from orm.models import Build, Project, Package
 from orm.models import Layer_Version, Recipe
+from orm.models import RecipeVariable
 from orm.models import CustomImageRecipe
 from orm.models import CustomImagePackage
=20
@@ -61,6 +63,14 @@ class ViewTests(TestCase):
         if BuildEnvironment.objects.count() =3D=3D 0:
             BuildEnvironment.objects.create(betype=3DBuildEnvironment.TY=
PE_LOCAL)
=20
+    @staticmethod
+    def _recipe_variables(build, recipe, values):
+        return RecipeVariable(
+            build=3Dbuild, recipe=3Drecipe,
+            variable_count=3Dlen(values),
+            variables=3Dzlib.compress(json.dumps(
+                values, separators=3D(',', ':')).encode('utf-8')))
+
=20
     def test_get_base_call_returns_html(self):
         """Basic test for all-projects view"""
@@ -90,6 +100,149 @@ class ViewTests(TestCase):
         self.assertTrue(name_found,
                         "project name not found in projects table")
=20
+    def test_recipe_variables_tab_scopes_searches_and_escapes(self):
+        build =3D Build.objects.get(pk=3D1)
+        other_build =3D Build.objects.get(pk=3D2)
+        other_recipe =3D Recipe.objects.exclude(pk=3Dself.recipe1.pk).fi=
rst()
+        RecipeVariable.objects.bulk_create([
+            self._recipe_variables(build, self.recipe1, {
+                'SRC_URI': 'git://example.invalid/src',
+                'SPECIAL': '<script>alert(1)</script>',
+            }),
+            self._recipe_variables(other_build, self.recipe1, {
+                'OTHER_BUILD': 'hidden',
+            }),
+            self._recipe_variables(build, other_recipe, {
+                'OTHER_RECIPE': 'hidden',
+            }),
+        ])
+        url =3D reverse('recipe', args=3D(build.pk, self.recipe1.pk, '5'=
))
+
+        response =3D self.client.get(url, {
+            'count': 100,
+            'page': 1,
+            'orderby': 'variable_name:+',
+            'search': 'SRC_URI',
+        })
+
+        self.assertEqual(response.status_code, 200)
+        self.assertTemplateUsed(response, 'recipe.html')
+        self.assertContains(response, 'SRC_URI')
+        self.assertContains(response, 'git://example.invalid/src')
+        self.assertNotContains(response, 'OTHER_BUILD')
+        self.assertNotContains(response, 'OTHER_RECIPE')
+
+        response =3D self.client.get(url, {
+            'count': 100,
+            'page': 1,
+            'orderby': 'variable_name:+',
+        })
+        self.assertContains(response, 'Variables (2)')
+        self.assertContains(response, '&lt;script&gt;alert(1)&lt;/script=
&gt;')
+        self.assertNotContains(response, '<script>alert(1)</script>')
+
+    def test_recipe_variables_tab_redirects_paginates_and_handles_empty(=
self):
+        build =3D Build.objects.get(pk=3D1)
+        url =3D reverse('recipe', args=3D(build.pk, self.recipe1.pk, '5'=
))
+
+        response =3D self.client.get(url)
+        self.assertEqual(response.status_code, 302)
+        self.assertIn('count=3D100', response.url)
+        self.assertIn('orderby=3Dvariable_name%3A%2B', response.url)
+
+        RecipeVariable.objects.bulk_create([
+            self._recipe_variables(build, self.recipe1, {
+                'VAR_%02d' % index: str(index) for index in range(12)
+            })
+        ])
+        response =3D self.client.get(url, {
+            'count': 10,
+            'page': 2,
+            'orderby': 'variable_name:+',
+        })
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual(response.context['objects'].paginator.count, 12=
)
+        self.assertEqual(response.context['objects'].number, 2)
+        self.assertContains(response, 'VAR_10')
+        self.assertContains(response, 'VAR_11')
+        self.assertNotContains(response, 'VAR_00')
+
+        RecipeVariable.objects.filter(build=3Dbuild, recipe=3Dself.recip=
e1).delete()
+        response =3D self.client.get(url, {
+            'count': 100,
+            'page': 1,
+            'orderby': 'variable_name:+',
+        })
+        self.assertContains(response, 'No resolved recipe datastore vari=
ables are available.')
+
+    def test_recipe_variables_tab_bounds_query_parameters(self):
+        build =3D Build.objects.get(pk=3D1)
+        RecipeVariable.objects.bulk_create([
+            self._recipe_variables(build, self.recipe1, {'SRC_URI': 'val=
ue'})
+        ])
+        url =3D reverse('recipe', args=3D(build.pk, self.recipe1.pk, '5'=
))
+
+        response =3D self.client.get(url, {
+            'count': 'alert(document.domain)',
+            'page': 1,
+            'orderby': 'variable_value:+',
+            'filter': 'variable_value__regex:(a+)+$',
+        })
+
+        self.assertEqual(response.status_code, 200)
+        self.assertEqual(response.context['objects'].paginator.per_page,=
 100)
+        self.assertNotContains(response, 'alert(document.domain)')
+        self.assertEqual(
+            [variable['variable_name']
+             for variable in response.context['objects'].object_list],
+            ['SRC_URI'])
+
+        response =3D self.client.get(url, {
+            'count': 100,
+            'page': 1,
+            'orderby': 'variable_name:+',
+            'search': ('SRC_URI ' * 20) + ('x' * 300),
+        })
+        self.assertLessEqual(len(response.context['search_term']), 256)
+        self.assertLessEqual(len(response.context['search_term'].split()=
), 16)
+
+    def test_built_recipes_table_shows_variable_count(self):
+        build =3D Build.objects.get(pk=3D1)
+        self._recipe_variables(build, self.recipe1, {
+            'FOO': 'one',
+            'BAR': 'two',
+        }).save()
+        url =3D reverse('recipes', args=3D(build.pk,))
+
+        response =3D self.client.get(url, {
+            'format': 'json',
+            'limit': 25,
+            'page': 1,
+        })
+        data =3D json.loads(response.content)
+        row =3D next(row for row in data['rows']
+                   if self.recipe1.name in row['name'])
+
+        self.assertIn('Variables', [column['title'] for column in data['=
columns']])
+        self.assertIn('>2</a>', row['variable_count'])
+
+    def test_recipe_packages_tab_shows_variable_count(self):
+        build =3D Build.objects.get(pk=3D1)
+        self._recipe_variables(build, self.recipe1, {
+            'FOO': 'one',
+            'BAR': 'two',
+        }).save()
+
+        response =3D self.client.get(reverse(
+            'recipe_packages', args=3D(build.pk, self.recipe1.pk)), {
+                'count': 10,
+                'page': 1,
+                'orderby': 'name:+',
+            })
+
+        self.assertEqual(response.status_code, 200)
+        self.assertContains(response, 'Variables (2)')
+
     def test_typeaheads(self):
         """Test typeahead ReST API"""
         layers_url =3D reverse('xhr_layerstypeahead', args=3D(self.proje=
ct.id,))
diff --git a/lib/toaster/toastergui/buildtables.py b/lib/toaster/toasterg=
ui/buildtables.py
index 327059d00..52c3dd779 100644
--- a/lib/toaster/toastergui/buildtables.py
+++ b/lib/toaster/toastergui/buildtables.py
@@ -239,7 +239,10 @@ class BuiltRecipesTable(BuildTablesMixin):
     def setup_queryset(self, *args, **kwargs):
         build =3D Build.objects.get(pk=3Dkwargs['build_id'])
         self.static_context_extra['build'] =3D build
-        self.queryset =3D build.get_recipes()
+        self.queryset =3D build.get_recipes().annotate(
+            variable_count=3DSum(
+                'recipevariable__variable_count',
+                filter=3DQ(recipevariable__build=3Dbuild), default=3D0))
         self.queryset =3D self.queryset.order_by(self.default_orderby)
=20
     def setup_columns(self, *args, **kwargs):
@@ -323,6 +326,12 @@ class BuiltRecipesTable(BuildTablesMixin):
                         hideable=3DFalse,
                         field_name=3D"version")
=20
+        self.add_column(
+            title=3D"Variables",
+            field_name=3D"variable_count",
+            static_data_name=3D"variable_count",
+            static_data_template=3D'<a href=3D"{% url "recipe" extra.bui=
ld.pk data.pk "5" %}">{{data.variable_count|default:0}}</a>')
+
         self.add_column(title=3D"Dependencies",
                         static_data_name=3D"dependencies",
                         static_data_template=3Ddepends_on_tmpl)
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/t=
oastergui/templates/recipe.html
index 4b5301b54..be99ebc54 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -52,6 +52,13 @@
                 Reverse build dependencies ({{object.r_dependencies_depe=
nds.all.count}})
             </a>
         </li>
+        <li class=3D"{{tab_states.5}}">
+            <a href=3D"{% url "recipe" build.pk object.id "5" %}">
+                <span class=3D"glyphicon glyphicon-question-sign get-hel=
p" title=3D"Final values
+                    from BitBake's resolved recipe datastore"></span>
+                Variables ({{recipe_variable_count}})
+            </a>
+        </li>
     </ul>
     <div class=3D"tab-content">
         <div class=3D"tab-pane {{tab_states.1}}" id=3D"information">
@@ -277,6 +284,31 @@
             {% endif %}
=20
         </div>
+        <div class=3D"tab-pane {{tab_states.5}}" id=3D"variables">
+            {% if not objects and not request.GET.search %}
+            <div class=3D"alert alert-info">
+                No resolved recipe datastore variables are available.
+            </div>
+            {% else %}
+                {% with "variables" as search_what %}
+                {% include "detail_search_header.html" %}
+                {% endwith %}
+                {% if objects %}
+                <table class=3D"table table-bordered table-hover tableso=
rter" id=3D"otable">
+                    {% include "detail_sorted_header.html" %}
+                    <tbody>
+                    {% for variable in objects %}
+                        <tr>
+                            <td>{{variable.variable_name}}</td>
+                            <td>{{variable.variable_value}}</td>
+                        </tr>
+                    {% endfor %}
+                    </tbody>
+                </table>
+                {% include "detail_pagination_bottom.html" %}
+                {% endif %}
+            {% endif %}
+        </div>
     </div>
 </div>
=20
diff --git a/lib/toaster/toastergui/templates/recipe_packages.html b/lib/=
toaster/toastergui/templates/recipe_packages.html
index 37a586f38..abd64ca7e 100644
--- a/lib/toaster/toastergui/templates/recipe_packages.html
+++ b/lib/toaster/toastergui/templates/recipe_packages.html
@@ -51,6 +51,13 @@
                 Reverse build dependencies ({{recipe.r_dependencies_depe=
nds.all.count}})
             </a>
         </li>
+        <li>
+            <a href=3D"{% url "recipe" build.pk recipe.id "5" %}">
+                <span class=3D"glyphicon glyphicon-question-sign get-hel=
p" title=3D"Final values
+                    from BitBake's resolved recipe datastore"></span>
+                Variables ({{variable_count}})
+            </a>
+        </li>
     </ul>
     <div class=3D"tab-content">
 {#        <div class=3D"tab-pane active" id=3D"packages-built" name=3D"p=
ackages-built">#}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/vie=
ws.py
index 061e6436c..26cf5ca26 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -10,6 +10,7 @@ import ast
 import re
 import subprocess
 import sys
+import zlib
=20
 import bb.cooker
 from bb.ui import toasterui
@@ -20,6 +21,7 @@ from django.db import IntegrityError
 from django.shortcuts import render, redirect, get_object_or_404, HttpRe=
sponseRedirect
 from django.utils.http import urlencode
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe
+from orm.models import RecipeVariable
 from orm.models import LogMessage, Variable, Package_Dependency, Package
 from orm.models import Task_Dependency, Package_File
 from orm.models import Target_Installed_Package, Target_File
@@ -619,10 +621,13 @@ def recipe(request, build_id, recipe_id, active_tab=
=3D"1"):
     layer  =3D Layer.objects.get(pk=3Dlayer_version.layer_id)
     tasks_list  =3D Task.objects.filter(recipe_id =3D recipe_id, build_i=
d =3D build_id).exclude(order__isnull=3DTrue).exclude(task_name__endswith=
=3D'_setscene').exclude(outcome=3DTask.OUTCOME_NA)
     package_count =3D Package.objects.filter(recipe_id =3D recipe_id).fi=
lter(build_id =3D build_id).filter(size__gte=3D0).count()
+    recipe_variable_count =3D RecipeVariable.objects.filter(
+        build_id=3Dbuild_id, recipe_id=3Drecipe_id).values_list(
+            'variable_count', flat=3DTrue).first() or 0
=20
-    if active_tab !=3D '1' and active_tab !=3D '3' and active_tab !=3D '=
4' :
+    if active_tab not in ('1', '3', '4', '5'):
         active_tab =3D '1'
-    tab_states =3D {'1': '', '3': '', '4': ''}
+    tab_states =3D {'1': '', '3': '', '4': '', '5': ''}
     tab_states[active_tab] =3D 'active'
=20
     context =3D {
@@ -632,8 +637,63 @@ def recipe(request, build_id, recipe_id, active_tab=3D=
"1"):
             'layer'   : layer,
             'tasks'   : tasks_list,
             'package_count' : package_count,
+            'recipe_variable_count' : recipe_variable_count,
             'tab_states' : tab_states,
     }
+
+    if active_tab =3D=3D '5':
+        (requested_pagesize, requested_orderby) =3D _get_parameters_valu=
es(
+            request, 100, 'variable_name:+')
+        pagesize =3D requested_pagesize \
+            if str(requested_pagesize) in ('10', '25', '50', '100', '150=
') \
+            else 100
+        orderby =3D requested_orderby \
+            if requested_orderby in ('variable_name:+', 'variable_name:-=
') \
+            else 'variable_name:+'
+        mandatory_parameters =3D {
+            'count': pagesize,
+            'page': 1,
+            'orderby': orderby,
+        }
+        if _verify_parameters(request.GET, mandatory_parameters):
+            return _redirect_parameters(
+                'recipe', request.GET, mandatory_parameters,
+                build_id=3Dbuild_id, recipe_id=3Drecipe_id, active_tab=3D=
'5')
+
+        search_term =3D request.GET.get('search', '')[:256]
+        search_term =3D ' '.join(search_term.split()[:16])
+        snapshot =3D RecipeVariable.objects.filter(
+            build_id=3Dbuild_id, recipe_id=3Drecipe_id).first()
+        variables =3D []
+        if snapshot:
+            values =3D json.loads(zlib.decompress(snapshot.variables).de=
code('utf-8'))
+            variables =3D [
+                {'variable_name': name, 'variable_value': value}
+                for name, value in values.items()
+                if not search_term or search_term.lower() in name.lower(=
)
+                or search_term.lower() in value.lower()
+            ]
+        variables.sort(
+            key=3Dlambda variable: variable['variable_name'],
+            reverse=3Dorderby.endswith(':-'))
+        context['variable_count'] =3D len(variables)
+        context['objects'] =3D _build_page_range(
+            Paginator(variables, pagesize), request.GET.get('page', 1))
+        context['object_count'] =3D context['variable_count']
+        context['validated_pagesize'] =3D pagesize
+        context['search_term'] =3D search_term
+        context['search_orderby'] =3D 'variable_name:+'
+        context['tablecols'] =3D [
+            {
+                'name': 'Variable',
+                'orderfield': _get_toggle_order(request, 'variable_name'=
),
+                'ordericon': _get_toggle_order_icon(request, 'variable_n=
ame'),
+                'orderkey': 'variable_name',
+            },
+            {'name': 'Value'},
+        ]
+        _set_parameters_values(pagesize, orderby, request)
+
     return toaster_render(request, template, context)
=20
 def recipe_packages(request, build_id, recipe_id):
@@ -651,6 +711,9 @@ def recipe_packages(request, build_id, recipe_id):
     recipe_object =3D Recipe.objects.get(pk=3Drecipe_id)
     queryset =3D Package.objects.filter(recipe_id =3D recipe_id).filter(=
build_id =3D build_id).filter(size__gte=3D0)
     package_count =3D queryset.count()
+    variable_count =3D RecipeVariable.objects.filter(
+        build_id=3Dbuild_id, recipe_id=3Drecipe_id).values_list(
+            'variable_count', flat=3DTrue).first() or 0
     queryset =3D _get_queryset(Package, queryset, filter_string, search_=
term, ordering_string, 'name')
=20
     packages =3D _build_page_range(Paginator(queryset, pagesize),request=
.GET.get('page', 1))
@@ -660,6 +723,7 @@ def recipe_packages(request, build_id, recipe_id):
             'recipe'  : recipe_object,
             'objects'  : packages,
             'object_count' : package_count,
+            'variable_count' : variable_count,
             'tablecols':[
                 {
                     'name':'Package',
--=20
2.55.0


