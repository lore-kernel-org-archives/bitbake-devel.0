Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 1E157732DF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:17 +0000 (UTC)
Received: by mail-pa0-f41.google.com with SMTP id kx10so10985791pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Qr9RZbjGHLvWk5EkNt/E4Lokc61D+KttOK/k1nUlqzc=;
	b=NTi3kEwKdq72fsz2Z/sJVAb0QCuayB1G0+99/lREA6HosyrA5sa+JnU+vivgKFqt2C
	8aBoeKIHlrE4Fs6fnvq4n/rJOS3hdHGGPwGwuo13R+CzVi5G4zXFpy94cLxrMdNlRKcO
	70tMZDKiwHDOVZgLa2xW4RD2Z2i8xTkx5w1P0dgFZ47+1Fv9U2PICRp4MW/mLOjH2RsP
	6C3vTN55rLmV53wiUrYNAx9cqwTFz87pnSo5lYZsmD2oSHQZAyE5x2fnVhGWCzRq59hi
	PCgQf9Vcu9iLzJ8MboJycKaGr8qwORJoR9caowZ4X0WxuUfljUB836P40WMzh+kX8h8P
	47VA==
X-Gm-Message-State: ALoCoQnIZfYNPMebyJSnZYtJzClceFVJ21XebOl24H3ixqmfLaM+pTqR+dTjDMVU5ySuaRSiglSx
X-Received: by 10.66.192.106 with SMTP id hf10mr30881964pac.90.1423504938955; 
	Mon, 09 Feb 2015 10:02:18 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id p2sm17004069pdm.57.2015.02.09.10.02.17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:17 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 20280566188; Mon,  9 Feb 2015 18:02:15 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:53 +0000
Message-Id: <ae52f478bbf693b85da21f64835e70825968a305.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 23/27] toaster: all Machines exclude de-prioritised layer source items
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:18 -0000

From: Michael Wood <michael.g.wood@intel.com>

If a duplicate layer exists from another layer source and provides a
machine we don't want to show it if that layer comes from a low priority
layer source.

Signed-off-by: Michael Wood <michael.g.wood@intel.com
---
 lib/toaster/toastergui/views.py | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7dc4bbd..88d59f4 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -203,7 +203,6 @@ def _get_search_results(search_term, queryset, model):
 
         search_objects.append(reduce(operator.or_, q_map))
     search_object = reduce(operator.and_, search_objects)
-    print "search objects", search_object
     queryset = queryset.filter(search_object)
 
     return queryset
@@ -2788,18 +2787,25 @@ if toastermain.settings.MANAGED:
         (filter_string, search_term, ordering_string) = _search_tuple(request, Machine)
 
         queryset_all = Machine.objects.all()
+        queryset_all = queryset_all.prefetch_related('layer_version')
+        queryset_all = queryset_all.prefetch_related('layer_source')
 
         prj = Project.objects.get(pk = request.session['project_id'])
         compatible_layers = prj.compatible_layerversions()
-        # Make sure we only show machines / layers which are compatible with the current project
+
+        # FILTERS SECTION
+
+        # Make sure we only show machines / layers which are compatible
+        # with the current project
         queryset_all = queryset_all.filter(layer_version__in=compatible_layers)
 
         project_layers = ProjectLayer.objects.filter(project_id=request.session['project_id']).values_list('layercommit',flat=True)
 
         by_pass_filter_string = False
-        #  "special" filters identified by these valid filter strings we
+        # "special" filters identified by these valid filter strings we
         # by pass the usual filter applying method because we're filtering using
         # a subquery done by project_layers
+
         if "name:inprj" in filter_string:
           queryset_all = queryset_all.filter(layer_version__in=project_layers)
           by_pass_filter_string = True
@@ -2808,20 +2814,25 @@ if toastermain.settings.MANAGED:
           queryset_all = queryset_all.exclude(layer_version__in=project_layers)
           by_pass_filter_string = True
 
-        queryset_with_search = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
+        selected_filter_count = {
+          'inprj' : queryset_all.filter(layer_version__in=project_layers).count(),
+          'notinprj' : queryset_all.exclude(layer_version__in=project_layers).count()
+        }
+
+        # END FILTERS
 
         if by_pass_filter_string:
           queryset = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
         else:
           queryset = _get_queryset(Machine, queryset_all, filter_string, search_term, ordering_string, '-name')
 
-        selected_filter_count = {
-          'inprj' : queryset.filter(layer_version__in=project_layers).count(),
-          'notinprj' : queryset.exclude(layer_version__in=project_layers).count()
-        }
-
+        # Now we need to weed out the layers which will appear as duplicated
+        # because they're from a layer source which doesn't need to be used
+        for machine in queryset:
+           to_rm = machine.layer_version.get_equivalents_wpriority(prj)[1:]
+           if len(to_rm) > 0:
+             queryset = queryset.exclude(layer_version__in=to_rm)
 
-        # retrieve the objects that will be displayed in the table; machines a paginator and gets a page range to display
         machine_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
 
         context = {
@@ -2854,7 +2865,7 @@ if toastermain.settings.MANAGED:
                     'filter': {
                         'class': 'machine',
                         'label': 'Show:',
-                        'options': map(lambda x: (x.name, 'layer_source__pk:' + str(x.id), queryset_with_search.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
+                        'options': map(lambda x: (x.name, 'layer_source__pk:' + str(x.id), queryset.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
                     }
                 },
                 {   'name': 'Revision',
-- 
1.9.1


