Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id E37D4710C5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 15:42:02 +0000 (UTC)
Received: by mail-wi0-f180.google.com with SMTP id ex7so2781220wid.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Aug 2014 08:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=YukzR56krxTdQzOla/xxXiWhWlvf2AF5JWdeYbpSskY=;
	b=Pxtf3SHOsa8NTIsRykchlkwAw4K8V/OyQvhjB8q4JQ6rdOJfF1zhRlc17oCoxcK09N
	d3L5kArHBhrToJ/WWH8eBmtiNKxTf72XY66QgGGlwlgTgvCwYlt4Ue1oN95qcEs/UXm0
	Cl9p9hSSGapF5zhIi/Iy3uQhdyz2ychxydrFkKbaDxNkKIbN65M5UmynjlyZriOopD0J
	Z9MfQ1S3zR/wjRIQKHJ5nxmrxPtXmvOqbTGXwftk/jKmRyoSAW4yCKS02CnDbHJhrYZB
	gdzywEFdOYO/oIQfF7lVXJPGWLHLk83Dy93eGBfg4aJDvxvlF1+hlcic0DMDXfodAQHL
	Zjrg==
X-Gm-Message-State: ALoCoQl1oblRphh6BL2WCJm2n5JQ76VCZepkko0DAyG/TkOJwt1zVYaxaizuU70Rikw74JkbG9vb
X-Received: by 10.194.119.41 with SMTP id kr9mr3379329wjb.114.1409326923861;
	Fri, 29 Aug 2014 08:42:03 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id l3sm48211919wib.11.2014.08.29.08.42.01
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 29 Aug 2014 08:42:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id EEE11560852; Fri, 29 Aug 2014 16:42:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 29 Aug 2014 16:42:00 +0100
Message-Id: <8fc8c69bd16b012ea6f0971e00579f751e5fa65c.1409326534.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8309e8e58c1d7d559160747b5ec617d6c980bd26.1409326534.git.alexandru.damian@intel.com>
References: <8309e8e58c1d7d559160747b5ec617d6c980bd26.1409326534.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409326534.git.alexandru.damian@intel.com>
References: <cover.1409326534.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/2] toastergui: added pages for project details
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
X-List-Received-Date: Fri, 29 Aug 2014 15:42:03 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add new pages for the layer importing, layer details,
showing project builds and project configuration.

The pages are  in read-only mode, but they're needed as
to be able to verify the quality of data in the system.

Write capabilities will be added in a subsequent patch.

[YOCTO #6595]
[YOCTO #6590]
[YOCTO #6591]
[YOCTO #6588]
[YOCTO #6589]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/importlayer.html  |  68 ++++++++
 lib/toaster/toastergui/templates/layerdetails.html | 159 +++++++++++++++++
 lib/toaster/toastergui/templates/layers.html       |   2 +-
 lib/toaster/toastergui/templates/project.html      |  58 ++++---
 .../toastergui/templates/projectbuilds.html        |  59 +++++++
 lib/toaster/toastergui/templates/projectconf.html  |  62 +++++++
 lib/toaster/toastergui/urls.py                     |   2 +-
 lib/toaster/toastergui/views.py                    | 192 +++++++++++++++++++--
 8 files changed, 564 insertions(+), 38 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/importlayer.html
 create mode 100644 lib/toaster/toastergui/templates/layerdetails.html
 create mode 100644 lib/toaster/toastergui/templates/projectbuilds.html
 create mode 100644 lib/toaster/toastergui/templates/projectconf.html

diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
new file mode 100644
index 0000000..7e48eac
--- /dev/null
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -0,0 +1,68 @@
+{% extends "baseprojectpage.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block localbreadcrumb %}
+<li>Layers</li>
+{% endblock %}
+
+{% block projectinfomain %}
+                <div class="page-header">
+                    <h1>Import layer</h1>
+                </div>
+                <form>
+        {% if project %}
+                    <span class="help-block" style="padding-left:19px;">The layer you are importing must be compatible with {{project.release.name}} ({{project.release.description}}), which is the release you are using in this project.</span>
+          {% endif %}
+                    <fieldset class="air">
+                        <legend>Layer repository information</legend>
+                        <label>
+                            Git repository URL
+                            <i class="icon-question-sign get-help" title="Fetch/clone URL of the repository. Currently, Toaster only supports Git repositories."></i>
+                        </label>
+                        <input id="repo" type="text" class="input-xxlarge" required>
+                        <label class="project-form">
+                            Repository subdirectory
+                            <span class="muted">(optional)</span>
+                            <i class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></i>
+                        </label>
+                        <input type="text"  id="subdir">
+                        <label class="project-form">Branch, tag or commit</label>
+                        <input type="text" class="span4" id="layer-version" required>
+                        <label class="project-form">
+                            Layer name
+                            <i class="icon-question-sign get-help" title="Something like 'meta-mylayer'. Your layer name must be unique and can only include letters, numbers and dashes"></i>
+                        </label>
+                        <input id="layer-name" type="text" required>
+                    </fieldset>
+                    <fieldset class="air">
+                        <legend>
+                            Layer dependencies
+                            <span class="muted">(optional)</span>
+                            <i class="icon-question-sign get-help heading-help" title="Other layers this layer depends upon"></i>
+                        </legend>
+                        <ul class="unstyled configuration-list">
+                            <li>
+                                <a href="" class="layer-info" title="OpenEmbedded | daisy">openembedded-core (meta)</a>
+                                <i class="icon-trash"></i>
+                            </li>
+                        </ul>
+                        <div class="input-append">
+                            <input type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"
+                            data-provide="typeahead"  data-source='
+                []
+                ' placeholder="Type a layer name" id="layer-dependency" class="input-xlarge">
+                            <a class="btn" type="button" id="add-layer-dependency" disabled>
+                                Add layer
+                            </a>
+                        </div>
+                        <span class="help-inline">You can only add layers Toaster knows about</span>
+                    </fieldset>
+                    <div class="form-actions">
+                        <a href="#dependencies-message" class="btn btn-primary btn-large" data-toggle="modal" data-target="#dependencies-message" disabled>Import and add to project</a>
+                        <a href="layer-details-just-imported.html" class="btn btn-large" disabled>Just import for the moment</a>
+                        <span class="help-inline" style="vertical-align: middle;">To import a layer, you need to enter a repository URL, a branch, tag or commit and a layer name</span>
+                    </div>
+                </form>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
new file mode 100644
index 0000000..78dc54b
--- /dev/null
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -0,0 +1,159 @@
+{% extends "baseprojectpage.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block localbreadcrumb %}
+<li>Layer Details</li>
+{% endblock %}
+
+{% block projectinfomain %}
+<div class="page-header">
+    <h1>Layer Details</h1>
+</div>
+
+ <div class="row-fluid span7 tabbable">
+       <ul class="nav nav-pills">
+       <li class="active">
+           <a data-toggle="tab" href="#information">Layer details</a>
+       </li>
+       <li>
+           <a data-toggle="tab" href="#targets">Targets (0)</a>
+       </li>
+       <li>
+           <a data-toggle="tab" href="#machines">Machines (0)</a>
+       </li>
+       <li>
+           <a data-toggle="tab" href="#classes">Classes (0)</a>
+       </li>
+       <li>
+           <a data-toggle="tab" href="#bbappends">bbappends (0)</a>
+       </li>
+       </ul>
+       <div class="tab-content">
+               <div name="information" id="information" class="tab-pane active">
+        <dl class="dl-horizontal">
+        <dt class="">
+            <i class="icon-question-sign get-help" title="Fetch/clone URL of the repository"></i>
+            Repository URL
+        </dt>
+        <dd>
+            <form id="change-repo-form" class="control-group">
+            <div class="input-append">
+            <input type="text" class="input-xlarge" id="type-repo" value="{{layerversion.layer.vcs_url}}">
+            <button id="apply-change-repo" class="btn" type="button">Change</button>
+            <!--a href="#" id="cancel-change-repo" class="btn btn-link">Cancel</a-->
+            </div>
+            <span class="help-block">Cloning this Git repository failed</span>
+            </form>
+        </dd>
+        <dt>
+            <i class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></i>
+            Repository subdirectory
+        </dt>
+        <dd>
+            <span id="subdir">{{layerversion.dirpath}}</span>
+            <i id="change-subdir" class="icon-pencil"></i>
+            <i id="delete-subdir" class="icon-trash"></i>
+            <form id="change-subdir-form" style="display:none;">
+            <div class="input-append">
+            <input type="text" id="type-subdir" value="meta-acer">
+            <button id="apply-change-subdir" class="btn" type="button">Change</button>
+            <a href="#" id="cancel-change-subdir" class="btn btn-link">Cancel</a>
+            </div>
+            </form>
+        </dd>
+        <dt>Brach, tag or commit</dt>
+        <dd>
+            {{layerversion.up_branch.name}}
+            <i class="icon-pencil"></i>
+        </dd>
+        <dt>
+            <i class="icon-question-sign get-help" title="The Yocto Project versions with which this layer is compatible. Currently Toaster supports Yocto Project 1.6 and 1.7"></i>
+            Yocto Project compatibility
+        </dt>
+        <dd>
+            <i class="icon-pencil"></i>
+        </dd>
+        <dt>
+            <i class="icon-question-sign get-help" title="Other layers this layer depends upon"></i>
+            Layer dependencies
+        </dt>
+        <dd>
+            <ul class="unstyled">
+            {% for ld in layer.dependencies.all %}
+            <li>
+                <a href="#">openembedded core (meta)</a>
+                <i class="icon-trash"></i>
+            </li>
+            {% endfor %}
+            </ul>
+            <div class="input-append">
+            <input type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"
+            data-provide="typeahead"  data-source='
+            '
+            placeholder="Type a layer name" id="layer-dependency">
+            <a class="btn" type="button" id="add-layer-dependency" disabled>
+            Add layer
+            </a>
+            </div>
+            <span class="help-block">You can only add layers Toaster knows about</span>
+        </dd>
+        </dl>
+        </div>
+        <div name="targets" id="targets" class="tab-pane">
+        <div class="alert alert-info">
+        <strong>There is no target data for {{layerversion.layer.name}} ... yet</strong> <br />
+        Toaster learns about layers as they are built. Once you have used {{layerversion.layer.name}} in a build, Toaster will show you
+        here the targets it provides.
+        </div>
+        </div>
+        <div name="machines" id="machines" class="tab-pane">
+        <div class="alert alert-info">
+        <strong>There is no machine data for {{layerversion.layer.name}} ... yet</strong> <br />
+        Toaster learns about layers as they are built. Once you have used {{layerversion.layer.name}} in a build, Toaster will show you
+        here the machines it provides.
+        </div>
+        </div>
+    </div>
+</div>
+<div class="row span4 well">
+<h2>About {{layerversion.layer.name}}</h2>
+<dl>
+
+    <dt>
+    Summary
+    <i class="icon-question-sign get-help" title="One-line description of the layer"></i>
+    </dt>
+    <dd>
+    <span >{{layerversion.layer.summary}}</span>
+    <i class="icon-pencil"></i>
+    </dd>
+    <!--form>
+    <textarea class="span12" rows="2"></textarea>
+    <button class="btn" type="button">Change</button>
+    <a href="#" class="btn btn-link">Cancel</a>
+    </form-->
+    <dt>
+    Description
+    </dt>
+    <dd>
+    <span >{{layerversion.layer.description}}</span>
+    <i class="icon-pencil"></i>
+    </dd>
+    <!--form>
+    <textarea class="span12" rows="6"></textarea>
+    <button class="btn" type="button">Change</button>
+    <a href="#" class="btn btn-link">Cancel</a>
+    </form-->
+    <dt>
+    Maintainer(s)
+    </dt>
+    <dd>
+    <span class="muted">Not set</span>
+    <i class="icon-pencil"></i>
+    </dd>
+</dl>
+</div>
+
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index bc6e5a3..281b72a 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -33,7 +33,7 @@
 {% include "basetable_top.html" %}
     {% for lv in objects %}
     <tr class="data">
-            <td class="layer">{{lv.layer.name}}</td>
+            <td class="layer"><a href="{% url 'layerdetails' lv.id %}">{{lv.layer.name}}</a></td>
             <td class="description">{{lv.layer.summary}}</td>
             <td class="source"><a href="{% url 'layerdetails' lv.pk %}">{{lv.layer_source.name}}</a></td>
             <td class="git-repo"><a href="{% url 'layerdetails' lv.pk %}"><code>{{lv.layer.layer_index_url}}</code></a></td>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index d7bfa2b..c3a470c 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -110,22 +110,34 @@ $(document).ready(function () {
 
 
             <div class="well">
-                <!--div class="control-group error"-->
-                    <button id="build-all-button" class="btn btn-primary btn-large">Build all added targets</button>
-                    <div class="input-append build-form controls">
-                        <input class="huge input-xxlarge" placeholder="Or enter the target you want to build" autocomplete="off" data-minlength="1" data-autocomplete="off" data-provide="typeahead" data-source="" type="text">
-                        <button id="build-button" class="btn btn-large" disabled="">Build</button>
+                <form class="build-form">
+                    <div class="input-append input-prepend controls">
+                        <input type="text" class="huge span7" placeholder="Type the target(s) you want to build" autocomplete="off" data-minLength="1" data-autocomplete="off"
+                        data-provide="typeahead"  data-source='["core-image-base [meta | daisy]",
+                        "core-image-clutter [meta | daisy]",
+                        "core-image-directfb [meta | daisy]",
+                        "core-image-myimage [meta-imported-layer | 3e1dbabbf3&hellip;]",
+                        "core-image-anotherimage [meta-imported-layer | master]",
+                        "core-image-full-cmdline [meta | daisy]",
+                        "core-image-lsb [meta | daisy]",
+                        "core-image-lsb-dev [meta | daisy]",
+                        "core-image-lsb-sdk [meta| daisy]",
+                        "core-image-minimal [meta| daisy]"
+                        ]'>
+                        <a href="#" id="build-button" class="btn btn-large btn-primary" disabled>
+                            Build
+                            <i class="icon-question-sign get-help heading-help" style="margin-left: 5px;" title="Type the name of one or more targets you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to a target name, like so: <code>core-image-minimal:do_build</code>"></i>
+                        </a>
                     </div>
-
-                    <!--span class="help-inline">This target is not provided <br />by any of your added layers
-                        <i class="icon-question-sign get-help get-help-red" title="Review your list of added layers to make sure one of them provides core-image-xyz. Clicking on a layer name will give you all the information Toaster has about the layer"></i>
-                    </span>
-                </div-->
-            </div>
-
-            <div id="meta-tizen-alert" class="alert alert-info lead air" style="display:none;">
-                 <button type="button" class="close" data-dismiss="alert">?</button>
-                You have added <strong>6</strong> layers: <a href="#">meta-tizen</a> and its dependencies (<a href="#">meta-efl</a>, <a href="#">meta-intel</a>, <a href="#">meta-multimedia</a>, <a href="#">meta-oe</a> and <a href="#">meta-ruby</a>).
+                    <p>
+                    <a href="all-targets.html" style="padding-right: 5px;">
+                        View all targets
+                    </a>
+                    |
+                    <a href="{% url 'projectbuilds' project.id%}" style="padding-left:5px;">
+                        View all project builds ({{project.build_set.count}})
+                    </a>
+                </form>
             </div>
 
 
@@ -145,11 +157,11 @@ $(document).ready(function () {
                 </span>
             </div>
             <div class="span2">
-	 {{br.0.get_state_display}}
+     {{br.0.get_state_display}}
             </div>
-	    <div class="span8">
+        <div class="span8">
 {% if br.state == br.REQ_FAILED%}
-	{% for bre in br.0.brerror_set.all %} {{bre.errmsg}} ({{bre.errtype}}) <br/><hr/><code>{{bre.traceback}}</code>{%endfor%}
+    {% for bre in br.0.brerror_set.all %} {{bre.errmsg}} ({{bre.errtype}}) <br/><hr/><code>{{bre.traceback}}</code>{%endfor%}
 {%endif%}
             </div>
 
@@ -224,14 +236,14 @@ $(document).ready(function () {
                         <div id="dependency-alert" class="alert alert-info" style="display:none;">
                             <p><strong>meta-tizen</strong> depends on the layers below. Check the ones you want to add: </p>
                             <ul class="unstyled">
-	{% for f in layer_dependency %}
+    {% for f in layer_dependency %}
                                 <li>
                                     <label class="checkbox">
                                         <input checked="checked" type="checkbox">
                                         meta-ruby
                                     </label>
                                 </li>
-	{% endfor %}
+    {% endfor %}
                             </ul>
                             <button id="add-layer-dependencies" class="btn btn-info add-layer">Add layers</button>
                         </div>
@@ -278,9 +290,9 @@ $(document).ready(function () {
             {% if target %}
                         <li>
                             <a href="#">{{target.target}}{% if target.task%} (target.task){%endif%}</a>
-			    {% if target.notprovided %}
+                {% if target.notprovided %}
                             <i title="" data-original-title="" id="msg1" class="icon-exclamation-sign get-help-yellow" data-title="<strong>Target may not be provided</strong>" data-content="From the layer information it currently has, Toaster thinks this target is not provided by any of your added layers. If a target is not provided by one of your added layers, the build will fail.<h5>What Toaster suggests</h5><p>The <a href='#'>meta-abc</a> and <a href='#'>meta-efg</a> layers provide core-image-notprovided. You could add one of them to your project.</p><button class='btn btn-block'>Add meta-abc</button><button class='btn btn-block'>Add meta-efg</button><button id='dismiss1' class='btn btn-block btn-info'>Stop showing this message</button>"></i>
-		            {% elif target.notknown %}
+                    {% elif target.notknown %}
                             <i title="" data-original-title="" id="msg2" class="icon-exclamation-sign get-help-yellow" data-title="<strong>Target may not be provided</strong>" data-content="From the layer information it currently has, Toaster thinks this target is not provided by any of your added layers. If a target is not provided by one of your added layers, the build will fail.<h5>What Toaster suggests</h5><p>Review your added layers to make sure one of them provides core-image-unknown. Clicking on a layer name will give you all the information Toaster has about the layer. </p> <button class='btn btn-block btn-info'>Stop showing this message</button>"></i>
                             {% endif %}
                             <i title="" data-original-title="" class="icon-trash" id="del-target-icon" x-data="{{target.pk}}"></i>
@@ -347,7 +359,7 @@ $(document).ready(function () {
                 </p>
                 <h3>Yocto Project version</h3>
                 <p class="lead">
-                    {{project.release}} - {{project.short_description}}
+                    {{project.release.name}} - {{project.release.description}}
                     <i title="" data-original-title="" class="icon-pencil"></i>
                 </p>
             </div>
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
new file mode 100644
index 0000000..8c5942c
--- /dev/null
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -0,0 +1,59 @@
+{% extends "baseprojectpage.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block localbreadcrumb %}
+<li>Project builds</li>
+{% endblock %}
+
+{% block projectinfomain %}
+                <div class="page-header">
+                    <h1>
+                        All builds
+                        <i class="icon-question-sign get-help heading-help" title="This page lists all the layers compatible with Yocto Project 1.7 'Dxxxx' that Toaster knows about. They include community-created layers suitable for use on top of OpenEmbedded Core and any layers you have imported"></i>
+                     </h1>
+                </div>
+                <!--div class="alert">
+                    <div class="input-append" style="margin-bottom:0px;">
+                        <input class="input-xxlarge" type="text" placeholder="Search layers" value="browser" />
+                        <a class="add-on btn">
+                            <i class="icon-remove"></i>
+                        </a>
+                        <button class="btn" type="button">Search</button>
+                        <a class="btn btn-link" href="#">Show all layers</a>
+                    </div>
+                </div-->
+                <div id="layer-added" class="alert alert-info lead" style="display:none;"></div>
+                <div id="layer-removed" class="alert alert-info lead" style="display:none;">
+                    <button type="button" class="close" data-dismiss="alert">&times;</button>
+                    <strong>1</strong> layer deleted from <a href="project-with-targets.html">your project</a>: <a href="#">meta-aarch64</a>
+                </div>
+
+
+{% include "basetable_top.html" %}
+    {% for build in objects %}
+        <tr class="data">
+            <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a></td>
+            <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
+            <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
+            <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
+            <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
+            <td class="failed_tasks error">{% query build.task_build outcome=4 order__gt=0 as exectask%}{% if exectask.count == 1 %}<a href="{% url "task" build.id exectask.0.id %}">{{exectask.0.recipe.name}}.{{exectask.0.task_name}}</a>{% elif exectask.count > 1%}<a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}}</a>{%endif%}</td>
+            <td class="errors_no">{% if  build.errors_no %}<a class="errors_no error" href="{% url "builddashboard" build.id %}#errors">{{build.errors_no}} error{{build.errors_no|pluralize}}</a>{%endif%}</td>
+            <td class="warnings_no">{% if  build.warnings_no %}<a class="warnings_no warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings_no}} warning{{build.warnings_no|pluralize}}</a>{%endif%}</td>
+            <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent|sectohms}}</a></td>
+            <td class="log">{{build.cooker_log_path}}</td>
+            <td class="output">
+              {% if build.outcome == build.SUCCEEDED %}
+              <a href="{%url "builddashboard" build.id%}#images">{{fstypes|get_dict_value:build.id}}</a>
+              {% endif %}
+            </td>
+        </tr>
+
+    {% endfor %}
+{% include "basetable_bottom.html" %}
+
+    <!-- Modals -->
+
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
new file mode 100644
index 0000000..e8b0c39
--- /dev/null
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -0,0 +1,62 @@
+{% extends "baseprojectpage.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block localbreadcrumb %}
+<li>Project configuration</li>
+{% endblock %}
+
+{% block projectinfomain %}
+    <div class="page-header">
+        <h1>Configuration Variables</h1>
+    </div>
+
+    <div style="padding-left:19px;">
+
+        <dl class="dl-vertical">
+        {% for c in configvars %}
+            <dt>
+                {{c.name}}
+                <i class="icon-question-sign get-help" title="{{c.desc}}"></i>
+            </dt>
+            <dd class="lead">
+                <span id="distro">{{c.value}}</span>
+                <i class="icon-pencil" id="change-distro-icon"></i>
+                <form id="change-distro-form" style="display:none;">
+                    <div class="input-append">
+                        <input type="text" id="new-distro" value="poky tiny">
+                        <button id="apply-change-distro" class="btn" type="button">Save</button>
+                        <button id="cancel-change-distro" type="button" class="btn btn-link">Cancel</button>
+                    </div>
+                </form>
+            </dd>
+        {% endfor %}
+
+
+        </dl>
+        <form id="variable-form">
+            <fieldset style="padding-left:0px;">
+                <legend>Add variable</legend>
+                <label>
+                    Variable
+                    <i class="icon-question-sign get-help" title="Variable names are case sensitive, cannot have spaces, and can only include letters, numbers, underscores and dashes"></i>
+                </label>
+                <input id="variable" type="text" placeholder="Type variable name">
+                <label>Value</label>
+                <input id="value" type="text" placeholder="Type variable value">
+                <div style="display:block;margin-top:10px;">
+                    <a href="#" class="btn save" disabled>
+                        Add variable
+                    </a>
+                </div>
+            </fieldset>
+        </form>
+        <!--button id="add-variable" class="btn air">
+            <i class="icon-plus"></i>
+            Add variable
+        </button-->
+
+    </div>
+
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index 30f0063..a9c0592 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -76,7 +76,7 @@ urlpatterns = patterns('toastergui.views',
 
         url(r'^project/(?P<pid>\d+)/$', 'project', name='project'),
         url(r'^project/(?P<pid>\d+)/configuration$', 'projectconf', name='projectconf'),
-        url(r'^project/(?P<pid>\d+)/builds$', 'projectbuilds', name='projectbuild'),
+        url(r'^project/(?P<pid>\d+)/builds$', 'projectbuilds', name='projectbuilds'),
 
         url(r'^xhr_projectbuild/(?P<pid>\d+)/$', 'xhr_projectbuild', name='xhr_projectbuild'),
         url(r'^xhr_projectedit/(?P<pid>\d+)/$', 'xhr_projectedit', name='xhr_projectedit'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 167b687..13788b0 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -903,7 +903,7 @@ def tasks_common(request, build_id, variant, task_anchor):
     retval = _verify_parameters( request.GET, mandatory_parameters )
     if retval:
         if task_anchor:
-	        mandatory_parameters['anchor']=task_anchor
+            mandatory_parameters['anchor']=task_anchor
         return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Task)
     queryset_all = Task.objects.filter(build=build_id).exclude(order__isnull=True).exclude(outcome=Task.OUTCOME_NA)
@@ -917,19 +917,19 @@ def tasks_common(request, build_id, variant, task_anchor):
     else:
         queryset = _get_queryset(Task, queryset_all, filter_string, search_term, ordering_string, 'order')
 
-	# compute the anchor's page
+    # compute the anchor's page
     if anchor:
-	    request.GET = request.GET.copy()
+        request.GET = request.GET.copy()
         del request.GET['anchor']
         i=0
         a=int(anchor)
-		count_per_page=int(request.GET.get('count', 100))
+        count_per_page=int(request.GET.get('count', 100))
         for task in queryset.iterator():
             if a == task.order:
-				new_page= (i / count_per_page ) + 1
-				request.GET.__setitem__('page', new_page)
-				mandatory_parameters['page']=new_page
-				return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
+                new_page= (i / count_per_page ) + 1
+                request.GET.__setitem__('page', new_page)
+                mandatory_parameters['page']=new_page
+                return _redirect_parameters( variant, request.GET, mandatory_parameters, build_id = build_id)
             i += 1
 
     tasks = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
@@ -1917,10 +1917,12 @@ if toastermain.settings.MANAGED:
             return HttpResponse(json.dumps({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
     def importlayer(request):
-        raise Exception("TODO: implement page #6595")
+        template = "importlayer.html"
+        context = {
+        }
+        return render(request, template, context)
 
     def layers(request):
-        # "TODO: implement page #6590"
         template = "layers.html"
         # define here what parameters the view needs in the GET portion in order to
         # be able to display something.  'count' and 'page' are mandatory for all views
@@ -2000,7 +2002,11 @@ if toastermain.settings.MANAGED:
         return render(request, template, context)
 
     def layerdetails(request, layerid):
-        raise Exception("TODO: implement page #6591")
+        template = "layerdetails.html"
+        context = {
+            'layerversion': Layer_Version.objects.get(pk = layerid),
+        }
+        return render(request, template, context)
 
     def targets(request):
         template = "targets.html"
@@ -2159,11 +2165,171 @@ if toastermain.settings.MANAGED:
         return render(request, template, context)
 
     def projectconf(request, pid):
-        raise Exception("TODO: implement page #6588")
+        template = "projectconf.html"
+        context = {
+            'configvars': ProjectVariable.objects.filter(project_id = pid),
+        }
+        return render(request, template, context)
 
     def projectbuilds(request, pid):
-        raise Exception("TODO: implement page #6589")
+        template = 'projectbuilds.html'
+        # define here what parameters the view needs in the GET portion in order to
+        # be able to display something.  'count' and 'page' are mandatory for all views
+        # that use paginators.
+        mandatory_parameters = { 'count': 10,  'page' : 1, 'orderby' : 'completed_on:-' };
+        retval = _verify_parameters( request.GET, mandatory_parameters )
 
+        # boilerplate code that takes a request for an object type and returns a queryset
+        # for that object type. copypasta for all needed table searches
+        (filter_string, search_term, ordering_string) = _search_tuple(request, Build)
+        queryset_all = Build.objects.all.exclude(outcome = Build.IN_PROGRESS)
+        queryset_with_search = _get_queryset(Build, queryset_all, None, search_term, ordering_string, '-completed_on')
+        queryset = _get_queryset(Build, queryset_all, filter_string, search_term, ordering_string, '-completed_on')
+
+        # retrieve the objects that will be displayed in the table; builds a paginator and gets a page range to display
+        build_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
+
+
+        # set up list of fstypes for each build
+        fstypes_map = {};
+        for build in build_info:
+            targets = Target.objects.filter( build_id = build.id )
+            comma = "";
+            extensions = "";
+            for t in targets:
+                if ( not t.is_image ):
+                    continue
+                tif = Target_Image_File.objects.filter( target_id = t.id )
+                for i in tif:
+                    s=re.sub('.*tar.bz2', 'tar.bz2', i.file_name)
+                    if s == i.file_name:
+                        s=re.sub('.*\.', '', i.file_name)
+                    if None == re.search(s,extensions):
+                        extensions += comma + s
+                        comma = ", "
+            fstypes_map[build.id]=extensions
+
+        # send the data to the template
+        context = {
+                    'objects' : build_info,
+                    'objectname' : "builds",
+                    'default_orderby' : 'completed_on:-',
+                    'fstypes' : fstypes_map,
+                    'search_term' : search_term,
+                    'total_count' : queryset_with_search.count(),
+                # Specifies the display of columns for the table, appearance in "Edit columns" box, toggling default show/hide, and specifying filters for columns
+                    'tablecols' : [
+                    {'name': 'Outcome',                                                # column with a single filter
+                     'qhelp' : "The outcome tells you if a build successfully completed or failed",     # the help button content
+                     'dclass' : "span2",                                                # indication about column width; comes from the design
+                     'orderfield': _get_toggle_order(request, "outcome"),               # adds ordering by the field value; default ascending unless clicked from ascending into descending
+                     'ordericon':_get_toggle_order_icon(request, "outcome"),
+                      # filter field will set a filter on that column with the specs in the filter description
+                      # the class field in the filter has no relation with clclass; the control different aspects of the UI
+                      # still, it is recommended for the values to be identical for easy tracking in the generated HTML
+                     'filter' : {'class' : 'outcome',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Successful builds', 'outcome:' + str(Build.SUCCEEDED), queryset_with_search.filter(outcome=str(Build.SUCCEEDED)).count()),  # this is the field search expression
+                                             ('Failed builds', 'outcome:'+ str(Build.FAILED), queryset_with_search.filter(outcome=str(Build.FAILED)).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Target',                                                 # default column, disabled box, with just the name in the list
+                     'qhelp': "This is the build target or build targets (i.e. one or more recipes or image recipes)",
+                     'orderfield': _get_toggle_order(request, "target__target"),
+                     'ordericon':_get_toggle_order_icon(request, "target__target"),
+                    },
+                    {'name': 'Machine',
+                     'qhelp': "The machine is the hardware for which you are building a recipe or image recipe",
+                     'orderfield': _get_toggle_order(request, "machine"),
+                     'ordericon':_get_toggle_order_icon(request, "machine"),
+                     'dclass': 'span3'
+                    },                           # a slightly wider column
+                    {'name': 'Started on', 'clclass': 'started_on', 'hidden' : 1,      # this is an unchecked box, which hides the column
+                     'qhelp': "The date and time you started the build",
+                     'orderfield': _get_toggle_order(request, "started_on", True),
+                     'ordericon':_get_toggle_order_icon(request, "started_on"),
+                     'filter' : {'class' : 'started_on',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ("Today's builds" , 'started_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=timezone.now()).count()),
+                                             ("Yesterday's builds", 'started_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                             ("This week's builds", 'started_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(started_on__gte=(timezone.now()-timedelta(days=7))).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Completed on',
+                     'qhelp': "The date and time the build finished",
+                     'orderfield': _get_toggle_order(request, "completed_on", True),
+                     'ordericon':_get_toggle_order_icon(request, "completed_on"),
+                     'orderkey' : 'completed_on',
+                     'filter' : {'class' : 'completed_on',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ("Today's builds", 'completed_on__gte:'+timezone.now().strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=timezone.now()).count()),
+                                             ("Yesterday's builds", 'completed_on__gte:'+(timezone.now()-timedelta(hours=24)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(hours=24))).count()),
+                                             ("This week's builds", 'completed_on__gte:'+(timezone.now()-timedelta(days=7)).strftime("%Y-%m-%d"), queryset_with_search.filter(completed_on__gte=(timezone.now()-timedelta(days=7))).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Failed tasks', 'clclass': 'failed_tasks',                # specifing a clclass will enable the checkbox
+                     'qhelp': "How many tasks failed during the build",
+                     'filter' : {'class' : 'failed_tasks',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Builds with failed tasks', 'task_build__outcome:4', queryset_with_search.filter(task_build__outcome=4).count()),
+                                             ('Builds without failed tasks', 'task_build__outcome:NOT4', queryset_with_search.filter(~Q(task_build__outcome=4)).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Errors', 'clclass': 'errors_no',
+                     'qhelp': "How many errors were encountered during the build (if any)",
+                     'orderfield': _get_toggle_order(request, "errors_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "errors_no"),
+                     'orderkey' : 'errors_no',
+                     'filter' : {'class' : 'errors_no',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Builds with errors', 'errors_no__gte:1', queryset_with_search.filter(errors_no__gte=1).count()),
+                                             ('Builds without errors', 'errors_no:0', queryset_with_search.filter(errors_no=0).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Warnings', 'clclass': 'warnings_no',
+                     'qhelp': "How many warnings were encountered during the build (if any)",
+                     'orderfield': _get_toggle_order(request, "warnings_no", True),
+                     'ordericon':_get_toggle_order_icon(request, "warnings_no"),
+                     'orderkey' : 'warnings_no',
+                     'filter' : {'class' : 'warnings_no',
+                                 'label': 'Show:',
+                                 'options' : [
+                                             ('Builds with warnings','warnings_no__gte:1', queryset_with_search.filter(warnings_no__gte=1).count()),
+                                             ('Builds without warnings','warnings_no:0', queryset_with_search.filter(warnings_no=0).count()),
+                                             ]
+                                }
+                    },
+                    {'name': 'Time', 'clclass': 'time', 'hidden' : 1,
+                     'qhelp': "How long it took the build to finish",
+                     'orderfield': _get_toggle_order(request, "timespent", True),
+                     'ordericon':_get_toggle_order_icon(request, "timespent"),
+                     'orderkey' : 'timespent',
+                    },
+                    {'name': 'Log',
+                     'dclass': "span4",
+                     'qhelp': "Path to the build main log file",
+                     'clclass': 'log', 'hidden': 1,
+                     'orderfield': _get_toggle_order(request, "cooker_log_path"),
+                     'ordericon':_get_toggle_order_icon(request, "cooker_log_path"),
+                     'orderkey' : 'cooker_log_path',
+                    },
+                    {'name': 'Output', 'clclass': 'output',
+                     'qhelp': "The root file system types produced by the build. You can find them in your <code>/build/tmp/deploy/images/</code> directory",
+                    },
+                    ]
+                }
+
+        return render(request, template, context)
 else:
     # these are pages that are NOT available in interactive mode
     def managedcontextprocessor(request):
-- 
1.9.1


