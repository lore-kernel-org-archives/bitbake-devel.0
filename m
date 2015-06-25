Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 304BA756C7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:08 +0000 (UTC)
Received: by wicgi11 with SMTP id gi11so71398556wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=eU8Ofl/m7lQNJeMflukRibVEyXoDehYe9eUuYv+V32k=;
	b=IdW3909CWZNP8XUnO5V6CB0GE4cINPQVUbQKR3bWjl4/LV5gB28iXKxJsI4wYt0ZEH
	/yxildNm4cMlzBiVMp6BdgDl76vBJ0nK11kj5a8ShEmr5x1pFdYNAh+fz6Di4boBT1CB
	zKQgjwN8uwSfiHmYMPrLkiw3UFkri64duyRERT59qnH8aKrd795DzyY7eATdYcw5FeRy
	lhPcUbMlFv52opE7zoj9uSM6m0ygjRdMTUuv+abDbRbVX1YAMhGnMtiVtjgsHAvyVf0/
	fWm1iNAs1c63im5sJmt7Wdy9iaxluKhShJy5v/eCxUguWjefuqHSuLFA7kTSrmwvnCsI
	izEQ==
X-Gm-Message-State: ALoCoQl6fSAlas3BAiokn/6B5L2aL1FT1IXNLh8QBS6vIW7fwmPCZbbo3QxlPTyes7S2W8vaVq6K
X-Received: by 10.194.109.167 with SMTP id ht7mr77704129wjb.60.1435228448686; 
	Thu, 25 Jun 2015 03:34:08 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id n8sm6906983wiy.19.2015.06.25.03.34.07
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:07 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BDFB8561F21; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:41 +0100
Message-Id: <a9e889af41e1e59c3b426c78ba80e4d49c6c122b.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 04/23] toaster: fixing undefined variables
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:10 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patchset fixes usage of undefined variables in
the base page.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/base.html          | 11 +++++++----
 lib/toaster/toastergui/templates/basetable_top.html | 11 ++++++++---
 lib/toaster/toastergui/templates/filtersnippet.html |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 9f19c03..3f3253d 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -29,17 +29,18 @@
 {% endif %}
 <script>
   libtoaster.ctx = {
-    projectId : {{project.id|default:'undefined'}},
     jsUrl : "{% static 'js/' %}",
     htmlUrl : "{% static 'html/' %}",
     projectsUrl : "{% url 'all-projects' %}",
     {% if project.id %}
+      projectId : {{project.id}},
       projectPageUrl : {% url 'project' project.id as purl%}{{purl|json}},
       projectName : {{project.name|json}},
       projectTargetsUrl: {% url 'projectavailabletargets' project.id as paturl%}{{paturl|json}},
       projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
       projectId : {{project.id}},
     {% else %}
+      projectId : undefined,
       projectPageUrl : undefined,
       projectName : undefined,
       projectId : undefined,
@@ -101,8 +102,10 @@
                   <h3>New build</h3>
                   <h6>Project:</h6>
                   <span id="project">
-                    <a class="lead" href="{% if project.id %}{% url 'project' project.id %}{% endif %}">{{project.name}}</a>
-                    <i class="icon-pencil"></i>
+                    {% if project.id %}
+                      <a class="lead" href="{% url 'project' project.id %}">{{project.name}}</a>
+                      <i class="icon-pencil"></i>
+                    {% endif %}
                   </span>
                   <form id="change-project-form" style="display:none;">
                     <div class="input-append">
@@ -122,7 +125,7 @@
                     <form>
                       <input type="text" class="input-xlarge" id="build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
                       <div>
-                        <button class="btn btn-primary" id="build-button" data-project-id="{{project.id}}" disabled>Build</button>
+                        <button class="btn btn-primary" id="build-button" disabled>Build</button>
                       </div>
                     </form>
                   </li>
diff --git a/lib/toaster/toastergui/templates/basetable_top.html b/lib/toaster/toastergui/templates/basetable_top.html
index fcd2f03..8dd56ed 100644
--- a/lib/toaster/toastergui/templates/basetable_top.html
+++ b/lib/toaster/toastergui/templates/basetable_top.html
@@ -162,7 +162,7 @@
 <div class="navbar">
     <div class="navbar-inner">
         <form class="navbar-search input-append pull-left" id="searchform">
-            <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{%endif%}
+            <input class="input-xxlarge" id="search" name="search" type="text" placeholder="Search {%if object_search_display %}{{object_search_display}}{%else%}{{objectname}}{%endif%}" value="{%if request.GET.search %}{{request.GET.search}}{% endif %}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{%endif%}
             <input type="hidden" name="orderby" value="{{request.GET.orderby}}">
             <input type="hidden" name="page" value="1">
             <button class="btn" type="submit" value="Search">Search</button>
@@ -191,7 +191,12 @@
                                        onclick="showhideTableColumn(
                                            $(this).attr('id'),
                                            $(this).is(':checked'),
-                                           '{{i.orderkey}}' )"
+                                           {% if i.ordericon %}
+                                              '{{i.orderkey}}'
+                                           {% else %}
+                                              undefined
+                                           {% endif %}
+                                       )"
                                    {%else%}
                                        checked disabled
                                    {% endif %}/>   {{i.name}}
@@ -221,7 +226,7 @@
     <thead>
         <!-- Table header row; generated from "tablecols" entry in the context dict -->
         <tr>
-            {% for tc in tablecols %}<th class="{{tc.dclass}} {{tc.clclass}}">
+            {% for tc in tablecols %}<th class="{%if tc.dclass%}{{tc.dclass}}{%endif%} {% if tc.clclass %}{{tc.clclass}}{% endif %}">
                 {%if tc.qhelp%}<i class="icon-question-sign get-help" title="{{tc.qhelp}}"></i>{%endif%}
                 {%if tc.orderfield%}<a {%if tc.ordericon%} class="sorted" {%endif%}href="javascript:reload_params({'page': 1, 'orderby' : '{{tc.orderfield}}' })">{{tc.name}}</a>{%else%}<span class="muted">{{tc.name}}</span>{%endif%}
                 {%if tc.ordericon%} <i class="icon-caret-{{tc.ordericon}}"></i>{%endif%}
diff --git a/lib/toaster/toastergui/templates/filtersnippet.html b/lib/toaster/toastergui/templates/filtersnippet.html
index f624d88..56e2b21 100644
--- a/lib/toaster/toastergui/templates/filtersnippet.html
+++ b/lib/toaster/toastergui/templates/filtersnippet.html
@@ -2,7 +2,7 @@
 <!-- '{{f.class}}' filter -->
 {% with f.class as  key %}
 <form id="filter_{{f.class}}" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
-        <input type="hidden" name="search" value="{{request.GET.search}}"/>
+        <input type="hidden" name="search" value="{%if request.GET.search %}{{request.GET.search}}{%endif%}"/>
         <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
             {% if search_term %}
-- 
1.9.1


