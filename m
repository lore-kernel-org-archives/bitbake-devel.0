Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 111326E614
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:39 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id em10so26744301wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ng1RvDiYjedruD1tNkcoEk+goz8o8oisHE8HijYMjZw=;
	b=mBhI5zrEYGRK7639eOIB3et9TKD+fkbrRJhyADOiGBdi+MYd1ZIYRWLTw0GeQ79c2w
	/IfF4GupHD2+UsYNF7wlSp0iCtNFplLwjJdaVNne3+WE03/3ybQcMH4vclT3DmS+UHEu
	QfGXJJtDV9N/0Uu0DMCWVpTllWsJKiJC65XYsAnTTnQ0JFH3Ulqrv3L/dIvFCnlVSrt0
	9Z1O9INBx2qi/MGKV2B+ij0BDmv6nzZnKgaWRzC214uiskkZnUY7M9ti2swdYSRyhimJ
	4e7/gt/dG6Rd3usx1jd2RIiLCudX2cQmagHFa2NcHJSfj3X8/JMEL+sbATwUPYUlE8d4
	drJQ==
X-Gm-Message-State: ALoCoQnRR5vBNkPdwiFPIeUpbF97VIuGDssddd56xjC1FrFZSKK2xw87sROTu9WgaOkSUNkl/l3U
X-Received: by 10.194.24.103 with SMTP id t7mr51820509wjf.15.1424109221075;
	Mon, 16 Feb 2015 09:53:41 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k1sm23851134wjn.9.2015.02.16.09.53.39
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:40 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D58EF5609E0; Mon, 16 Feb 2015 17:53:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:24 +0000
Message-Id: <ca5124d48d306921ac0f0499762ea5867644b0ef.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
References: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Subject: [PATCH 08/10] toaster: Remove filtering from layers, machines and targets
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:40 -0000

From: Michael Wood <michael.g.wood@intel.com>

The filter counts are unreliable so for consistency the filter feature
here is removed.

[YOCTO #7060]
[YOCTO #7052]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 61 ++---------------------------------------
 1 file changed, 2 insertions(+), 59 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7bfedb4..1553c74 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2554,7 +2554,6 @@ if toastermain.settings.MANAGED:
             'objects' : layer_info,
             'objectname' : "layers",
             'default_orderby' : 'layer__name:+',
-            'total_count': len(object_list),
 
             'tablecols' : [
                 {   'name': 'Layer',
@@ -2586,15 +2585,6 @@ if toastermain.settings.MANAGED:
                 {   'name': 'Add | Delete',
                     'dclass': 'span2',
                     'qhelp': "Add or delete layers to / from your project ",
-                    'filter': {
-                        'class': 'add-del-layers',
-                        'label': 'Show:',
-                        'options': [
-              ('Layers added to this project', "projectlayer__project:" + str(prj.id), queryset_all.filter(projectlayer__project = prj.id).count()),
-              ('Layers not added to this project', "projectlayer__project:NOT" + str(prj.id), queryset_all.exclude(projectlayer__project = prj.id).count()),
-                                   ]
-
-                    }
                 },
             ]
         }
@@ -2690,7 +2680,6 @@ if toastermain.settings.MANAGED:
             'objects' : target_info,
             'objectname' : "targets",
             'default_orderby' : 'name:+',
-            'total_count': queryset_with_search.count(),
 
             'tablecols' : [
                 {   'name': 'Target',
@@ -2742,15 +2731,6 @@ if toastermain.settings.MANAGED:
                 {   'name': 'Build',
                     'dclass': 'span2',
                     'qhelp': "Add or delete targets to / from your project ",
-                    'filter': {
-                        'class': 'add-layer',
-                        'label': 'Show:',
-                        'options': [
-              ('Targets provided by layers added to this project', "layer_version__projectlayer__project:" + str(prj.id), queryset_with_search.filter(layer_version__projectlayer__project = prj.id).count()),
-              ('Targets provided by layers not added to this project', "layer_version__projectlayer__project:NOT" + str(prj.id), queryset_with_search.exclude(layer_version__projectlayer__project = prj.id).count()),
-                                   ]
-
-                    }
                 }, ]
 
         response = render(request, template, context)
@@ -2782,52 +2762,25 @@ if toastermain.settings.MANAGED:
         prj = Project.objects.get(pk = request.session['project_id'])
         compatible_layers = prj.compatible_layerversions()
 
-        # FILTERS SECTION
-
         # Make sure we only show machines / layers which are compatible
         # with the current project
         queryset_all = queryset_all.filter(layer_version__in=compatible_layers)
 
         project_layers = ProjectLayer.objects.filter(project_id=request.session['project_id']).values_list('layercommit',flat=True)
 
-        by_pass_filter_string = False
-        # "special" filters identified by these valid filter strings we
-        # by pass the usual filter applying method because we're filtering using
-        # a subquery done by project_layers
-
-        if "name:inprj" in filter_string:
-          queryset_all = queryset_all.filter(layer_version__in=project_layers)
-          by_pass_filter_string = True
-
-        if "name:notinprj" in filter_string:
-          queryset_all = queryset_all.exclude(layer_version__in=project_layers)
-          by_pass_filter_string = True
-
-        # END FILTERS
-
-        if by_pass_filter_string:
-          queryset = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
-        else:
-          queryset = _get_queryset(Machine, queryset_all, filter_string, search_term, ordering_string, '-name')
-
         # Now we need to weed out the layers which will appear as duplicated
         # because they're from a layer source which doesn't need to be used
-        for machine in queryset:
+        for machine in queryset_all:
            to_rm = machine.layer_version.get_equivalents_wpriority(prj)[1:]
            if len(to_rm) > 0:
-             queryset = queryset.exclude(layer_version__in=to_rm)
+             queryset_all = queryset_all.exclude(layer_version__in=to_rm)
 
-        machine_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
-        selected_filter_count = {}
-        selected_filter_count['inprj'] = queryset.filter(layer_version__in=project_layers).count()
-        selected_filter_count['notinprj'] = queryset.count() - selected_filter_count['inprj']
 
         context = {
             'objects' : machine_info,
             'project_layers' : project_layers,
             'objectname' : "machines",
             'default_orderby' : 'name:+',
-            'total_count': queryset.count(),
 
             'tablecols' : [
                 {   'name': 'Machine',
@@ -2857,16 +2810,6 @@ if toastermain.settings.MANAGED:
                 {   'name': 'Select',
                     'dclass': 'select span2',
                     'qhelp': "Sets the selected machine as the project machine. You can only have one machine per project",
-                    'filter': {
-                        'class': 'select',
-                        'label': 'Show:',
-                        'options': [
-                          (u'Machines provided by layers added to this project', 'name:inprj', selected_filter_count['inprj']),
-                          (u'Machines provided by layers not added to this project', 'name:notinprj', selected_filter_count['notinprj']),
-
-                        ],
-                    }
-
                 },
 
             ]
-- 
1.9.1


