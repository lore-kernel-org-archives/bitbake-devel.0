Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id D130D73573
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:29 +0000 (UTC)
Received: by mail-wi0-f171.google.com with SMTP id hi2so27654630wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=oG2gg8wKIwHGGDpatkDjHXInZfwFPmf03KVP0P/s1yw=;
	b=jlLPqO2u5rYTj3c/8lo8oR3tdkav0tukdwDyv1LUSfMV6U8usWwLzGrKOO8Itdpuli
	HVV/HPCovhJm0EZxNtVtsnj5zHjyoDt6op/dX4dKIIKPOHTJJ/CMjY6NOSAviUM9iK4O
	9VwV8yPZCsikM9WWmh/+ISGdE+xq/uAka5KdjZDm1Y1k5t48S1Sw3tAXj4fkNwctYKfi
	sdUb7TuLAMzVW3Q73B6PzFN7tkYEaGJVS/Ah5AvQOm2QE20cwCFC83izyQ+rdE55w4uY
	oD0/4fFsMhYbSN5bgIo8fvFJrAq6G8wi89nWaJFMHjWvI0wojRKjoQMrNNMQyRM7s1gG
	WWzw==
X-Gm-Message-State: ALoCoQljDTFSLCC8k70DEtPeNYajuPMs9WIS7GdUCcd/t7xUoXJTxIpLGjowtR4LyM0arSoCRQ3i
X-Received: by 10.180.171.35 with SMTP id ar3mr38034370wic.24.1424109210557;
	Mon, 16 Feb 2015 09:53:30 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k1sm23850465wjn.9.2015.02.16.09.53.28
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:29 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D3740560962; Mon, 16 Feb 2015 17:53:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:23 +0000
Message-Id: <7fee378849c9518a4560aa5be65fca9644c03048.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
References: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Subject: [PATCH 07/10] toaster: Remove Layer source from machines, layers and targets
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:30 -0000

From: Michael Wood <michael.g.wood@intel.com>

From the bug: The layer source reveals too much of the implementation model,
without explaining what is going on behind the scenes. It will confuse more
than inform, so let's get rid of it.

[YOCTO #7302]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/layers.html   |  1 -
 lib/toaster/toastergui/templates/machines.html |  1 -
 lib/toaster/toastergui/templates/targets.html  |  1 -
 lib/toaster/toastergui/views.py                | 37 --------------------------
 4 files changed, 40 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index 0943c39..5cfda5b 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -41,7 +41,6 @@
     <tr class="data">
             <td class="layer"><a href="{% url 'layerdetails' o.id %}">{{o.layer.name}}</a></td>
             <td class="description">{% if o.layer.summary %}{{o.layer.summary}}{%endif%}</td>
-            <td class="source"><a href="{% url 'layerdetails' o.pk %}">{{o.layer_source.name}}</a></td>
             <td class="git-repo"><a href="{% url 'layerdetails' o.pk %}"><code>{{o.layer.vcs_url}}</code></a>
             {% if o.get_vcs_link_url %}
             <a target="_blank" href="{{ o.get_vcs_link_url }}"><i class="icon-share get-info"></i></a>
diff --git a/lib/toaster/toastergui/templates/machines.html b/lib/toaster/toastergui/templates/machines.html
index 2089c26..9b2a540 100644
--- a/lib/toaster/toastergui/templates/machines.html
+++ b/lib/toaster/toastergui/templates/machines.html
@@ -64,7 +64,6 @@
     <td class="machine">{{o.name}}</td>
     <td class="description">{{o.description}}</td>
     <td class="layer"><a href="{%url "layerdetails" o.layer_version.id %}">{{o.layer_version.layer.name}}</a></td>
-    <td class="source">{{o.layer_source.name}}</td>
     <td class="branch">{{o.layer_version.get_vcs_reference}}</td>
     <td class="machinefile"><code>/machine/conf/{{o.name}}.conf</code><a href="{{o.get_vcs_machine_file_link_url}}" target="_blank"><i class="icon-share get-info"></i></a></td>
     <td class="select-or-add">
diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index 32c67ea..6cd9391 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -53,7 +53,6 @@
         <td class="target-section">{{o.section}}</td>
         <td class="license">{{o.license}}</td>
         <td class="layer"><a href="{% url 'layerdetails' o.preffered_layerversion.id%}">{{o.preffered_layerversion.layer.name}}</a></td>
-        <td class="source">{{o.preffered_layerversion.layer_source.name}}</td>
         <td class="branch">
         {% if o.preffered_layerversion.up_branch %}
             {{o.preffered_layerversion.up_branch.name}}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 4a1cdec..7bfedb4 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2565,18 +2565,6 @@ if toastermain.settings.MANAGED:
                     'dclass': 'span4',
                     'clclass': 'description',
                 },
-                {   'name': 'Layer source',
-                    'clclass': 'source',
-                    'qhelp': "Where the layer is coming from, for example, if it's part of the OpenEmbedded collection of layers or if it's a layer you have imported",
-                    'orderfield': _get_toggle_order(request, "layer_source__name"),
-                    'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
-                    'orderkey' : "layer_source__name",
-                    'filter': {
-                        'class': 'layer',
-                        'label': 'Show:',
-                        'options': map(lambda x: (x.name + " layers", 'layer_source__pk:' + str(x.id), queryset_all.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
-                    }
-                },
                 {   'name': 'Git repository URL',
                     'dclass': 'span6',
                     'clclass': 'git-repo', 'hidden': 1,
@@ -2741,18 +2729,6 @@ if toastermain.settings.MANAGED:
                     'ordericon': _get_toggle_order_icon(request, "layer_version__layer__name"),
                     'orderkey': "layer_version__layer__name",
                 },
-                {   'name': 'Layer source',
-                    'clclass': 'source',
-                    'qhelp': "Where the target is coming from, for example, if it's part of the OpenEmbedded collection of targets or if it's a target you have imported",
-                    'orderfield': _get_toggle_order(request, "layer_source__name"),
-                    'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
-                    'orderkey': "layer_source__name",
-                    'filter': {
-                        'class': 'target',
-                        'label': 'Show:',
-                        'options': map(lambda x: ("Targets provided by " + x.name + " layers", 'layer_source__pk:' + str(x.id), queryset_with_search.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
-                    }
-                },
                 {   'name': 'Revision',
                     'clclass': 'branch',
                     'qhelp': "The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project.",
@@ -2802,7 +2778,6 @@ if toastermain.settings.MANAGED:
 
         queryset_all = Machine.objects.all()
         queryset_all = queryset_all.prefetch_related('layer_version')
-        queryset_all = queryset_all.prefetch_related('layer_source')
 
         prj = Project.objects.get(pk = request.session['project_id'])
         compatible_layers = prj.compatible_layerversions()
@@ -2870,18 +2845,6 @@ if toastermain.settings.MANAGED:
                     'ordericon' : _get_toggle_order_icon(request, "layer_version__layer__name"),
                     'orderkey' : "layer_version__layer__name",
                 },
-                {   'name': 'Layer source',
-                    'clclass': 'source',
-                    'qhelp': "Where the machine is coming from, for example, if it's part of the OpenEmbedded collection of machines or if it's a machine you have imported",
-                    'orderfield': _get_toggle_order(request, "layer_source__name"),
-                    'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
-                    'orderkey': "layer_source__name",
-                    'filter': {
-                        'class': 'machine',
-                        'label': 'Show:',
-                        'options': map(lambda x: (x.name, 'layer_source__pk:' + str(x.id), queryset.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
-                    }
-                },
                 {   'name': 'Revision',
                     'clclass': 'branch',
                     'qhelp' : "The Git branch, tag or commit. For the layers from the OpenEmbedded layer source, the revision is always the branch compatible with the Yocto Project version you selected for this project",
-- 
1.9.1


