Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id 365136E614
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:46 +0000 (UTC)
Received: by mail-we0-f169.google.com with SMTP id k48so30620478wev.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=PF4JX+kpSzvER06ay6r9kCTTsEYdYqMBVnUOYJyxnSc=;
	b=P17sYpVvvIBBU1dQUKsRB6Dk4BOH8ffpg+oA7MtabfGFYlQIk2jcu7NBlx5P4lSuYF
	esZVkThdhFzNHQLvjhnN4eeb/tgG7VuZ7V0Rr/xG5X+fx7eq0HZ/ytaTvjH4XLrvQr9x
	dP0yKH37UVVk2tOI4D72M559NkMne0WxDN7omDEKvSgSUba3Xec+yHThUwVekotmSTux
	HUUSOJ3aoa9tRM43ni3L2XIGQtXvjRrBI3YA+t+pzt5jXnNHYokHce0oG+ugUGRg1fy7
	MItDSNmW9YHjuypVVqMArWx6WBQuNbriPh0/zz463r8Pqxr9kpD5tLVz6dWjs6mUT0hG
	QQow==
X-Gm-Message-State: ALoCoQnOkqNZQul2R9ztJVgxU1AdLslRIQ9YK0jZ4aryJq0fPNg17qgKoXoQ5vDJI8fbQgVT9e87
X-Received: by 10.180.85.70 with SMTP id f6mr360824wiz.22.1424109227992;
	Mon, 16 Feb 2015 09:53:47 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	mb20sm15980619wic.18.2015.02.16.09.53.46
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:47 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CC0EF56084E; Mon, 16 Feb 2015 17:53:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:20 +0000
Message-Id: <fa6e6d5b18c8c6231ae8ac499d332298f551fd7d.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
References: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Subject: [PATCH 04/10] toaster: layerdetails use new vcs reference api
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:47 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use the new layer_version api so that we return the vcs reference whether
that be the commit hash, branch name or the upstream branch to which the
layer is associated with.

[YOCTO #7192]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 6d00da3..465d633 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -5,7 +5,7 @@
 {% block localbreadcrumb %}
 <li><a href="{% url 'layers' %}">All compatible layers</a></li>
 <li>
-  {{layerversion.layer.name}} ({{layerversion.commit|truncatechars:13}})
+  {{layerversion.layer.name}} ({{layerversion.get_vcs_reference|truncatechars:13}})
 </li>
 {% endblock %}
 {% block projectinfomain %}
@@ -29,7 +29,7 @@
       layerVersion : {
         name : "{{layerversion.layer.name}}",
         id : {{layerversion.id}},
-        commit: "{{layerversion.commit}}",
+        commit: "{{layerversion.get_vcs_reference}}",
         inCurrentPrj : {{layer_in_project}},
         url : "{% url 'layerdetails' layerversion.id  %}",
         sourceId: {{layerversion.layer_source_id}},
@@ -66,7 +66,7 @@
 {% include "layers_dep_modal.html" %}
   <div class="row-fluid span11">
       <div class="page-header">
-        <h1>{{layerversion.layer.name}} <small class="commit" data-toggle="tooltip" title="{{layerversion.commit}}">({{layerversion.commit|truncatechars:13}})</small></h1>
+        <h1>{{layerversion.layer.name}} <small class="commit" data-toggle="tooltip" title="{{layerversion.get_vcs_reference}}">({{layerversion.get_vcs_reference|truncatechars:13}})</small></h1>
       </div>
   </div>
 
@@ -147,10 +147,10 @@
                   Revision
                 </dt>
                 <dd>
-                  <span class="current-value">{{layerversion.commit}}</span>
+                  <span class="current-value">{{layerversion.get_vcs_reference}}</span>
                   <form style="display:none;">
                     <div class="input-append">
-                      <input type="text" value="{{layerversion.commit}}">
+                      <input type="text" value="{{layerversion.get_vcs_reference}}">
                         <button  data-layer-prop="commit" class="btn change-btn" type="button">Save</button>
                         <a href="#" style="display:none" class="btn btn-link cancel">Cancel</a>
                       </div>
@@ -166,8 +166,7 @@
                       {% for ld in layerversion.dependencies.all %}
                       <span class="current-value">
                       <li data-layer-id="{{ld.depends_on.id}}">
-                        <!-- TODO use ld.depends_on.get_vcs_reference instead of commit -->
-                        <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.commit}}" href="{% url 'layerdetails' ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
+                        <a data-toggle="tooltip" title="{{ld.depends_on.layer.vcs_url}} | {{ld.depends_on.get_vcs_reference}}" href="{% url 'layerdetails' ld.depends_on.id %}">{{ld.depends_on.layer.name}}</a>
                         <span class="icon-trash " data-toggle="tooltip" title="Delete"></span>
                       </li>
                       </span>
-- 
1.9.1


