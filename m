Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 7A20D71194
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:51 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id n3so6193338wiv.17
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=reY4QCztKqn5qqfs3vWlqrEbAqMG7NRjrcgtNYXPUNY=;
	b=UqiaQoVwPH/06+/BW5D9EvJedH8fEI9CFL2+sQgoBLvAS17VhiF2q9MiHESsWzC3g4
	GSuVkUOVOCrpkR8aX6Lv9T+8rHyhiMLMZdqVgqkNIzuhQnYP3uFwMUMjm/yQ/OKkEghx
	Co+CJgjzYwPIW2oDsJOiJbRTUpYbIE0milXDP8fshwmrnDZMv1oRHOg838QyVIONMykE
	g76pThTChapaZ5tZYzQpxBsxlPT6tGxBXOU89nzUN9pjTG8Gfi5eSbSKqVnYFxcDJa8j
	chwBneZMvV6kvlun1XvKjiGOZI5DPr4W6WJ7B2SzlbnfBSgLZxBiEjGfynEqdTjhELjy
	JGjw==
X-Gm-Message-State: ALoCoQn5zOH31/SqjkjPt5aHT+kkJTijpwnVYlLtcjWLcGQbiyprGzzE51uCL/3jvxZYeL5qsUs4
X-Received: by 10.194.243.230 with SMTP id xb6mr5394244wjc.100.1409160229754; 
	Wed, 27 Aug 2014 10:23:49 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id v4sm2708967wjv.6.2014.08.27.10.23.48
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:48 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B54EF5611DF; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:41 +0100
Message-Id: <bd9b522d8938ee3c4bbeb7cb586e56051da94dd9.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 09/11] toatergui: update pages to match project models
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:52 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We update pages and queries to match the new project
models.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/newproject.html |  4 ++--
 lib/toaster/toastergui/templates/project.html    |  4 ++--
 lib/toaster/toastergui/views.py                  | 13 ++++++-------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index 6ee27d1..12c4e9f 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -28,8 +28,8 @@
 								<i class="icon-question-sign get-help" title="This sets the branch for the Yocto Project core layers (meta, meta-yocto and meta-yocto-bsp), and for the layers you use from the OpenEmbedded Metadata Index"></i>
 							</label>
 							<select name="projectversion" id="projectversion">
-	{% for br in branches %}
-		<option value="{{br.id}}"{%if projectversion == br.id %} selected{%endif%}>{{br.name}} ({{br.short_description}})</option>
+	{% for release in releases %}
+		<option value="{{release.id}}"{%if projectversion == release.id %} selected{%endif%}>{{release.name}} ({{release.description}})</option>
 	{% endfor %}
 							</select>
 						</fieldset>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 0ddfeb3..3c59fcf 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -269,7 +269,7 @@ $(document).ready(function () {
                     <ul class="unstyled configuration-list">
             {% for pl in project.projectlayer_set.all %}
                         <li>
-                            <a href="#">{{pl.name}} (<span class="layer-version">{{pl.giturl}}</span>)</a>
+                            <a href="#">{{pl.layercommit.layer.name}} (<span class="layer-version">{{pl.layercommit.layer.layer_index_url}}</span>)</a>
                 {% if pl.optional %}
                             <i title="" data-original-title="" class="icon-trash" id="del-layer-icon" x-data="{{pl.pk}}"></i>
                 {% endif %}
@@ -358,7 +358,7 @@ $(document).ready(function () {
                 </p>
                 <h3>Yocto Project version</h3>
                 <p class="lead">
-                    {{project.branch}} - {{project.short_description}}
+                    {{project.release}} - {{project.short_description}}
                     <i title="" data-original-title="" class="icon-pencil"></i>
                 </p>
             </div>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5b23365..e68f8b0 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1772,7 +1772,7 @@ if toastermain.settings.MANAGED:
     from django.contrib.auth.decorators import login_required
 
     from orm.models import Project, ProjectLayer, ProjectTarget, ProjectVariable
-    from orm.models import Branch, LayerSource, ToasterSetting
+    from orm.models import Branch, LayerSource, ToasterSetting, Release
     from bldcontrol.models import BuildRequest
 
     import traceback
@@ -1792,7 +1792,7 @@ if toastermain.settings.MANAGED:
         context = {
             'email': request.user.email if request.user.is_authenticated() else '',
             'username': request.user.username if request.user.is_authenticated() else '',
-            'branches': Branch.objects.order_by("-up_id"),
+            'releases': Release.objects.order_by("id"),
             'defaultbranch': ToasterSetting.objects.get(name = "DEFAULT_RELEASE").value,
         }
 
@@ -1819,15 +1819,14 @@ if toastermain.settings.MANAGED:
 
                 #  save the project
                 prj = Project.objects.create_project(name = request.POST['projectname'],
-                    branch = Branch.objects.get(pk = request.POST['projectversion'].split(" ")[0]),
-                    short_description=request.POST['projectversion'].split(" ")[1:])
+                    release = Release.objects.get(pk = request.POST['projectversion']))
                 prj.user_id = request.user.pk
                 prj.save()
                 return redirect(reverse(project, args = (prj.pk,)))
 
             except (IntegrityError, BadParameterException) as e:
                 # fill in page with previously submitted values
-                map(lambda x: context.__setitem__(x, request.POST[x]), mandatory_fields)
+                map(lambda x: context.__setitem__(x, request.POST.get(x, "-- missing")), mandatory_fields)
                 if isinstance(e, IntegrityError) and "username" in str(e):
                     context['alert'] = "Your chosen username is already used"
                 else:
@@ -1917,7 +1916,7 @@ if toastermain.settings.MANAGED:
             # return all project settings
             return HttpResponse(json.dumps( {
                 "error": "ok",
-                "layers": map(lambda x: (x.name, x.giturl), prj.projectlayer_set.all()),
+                "layers": map(lambda x: (x.layercommit.layer.name, x.layercommit.layer.layer_index_url), prj.projectlayer_set.all()),
                 "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
                 "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
                 }), content_type = "application/json")
@@ -1945,7 +1944,7 @@ if toastermain.settings.MANAGED:
 
         queryset_all = Layer_Version.objects.all()
         if 'project' in request.session:
-            queryset_all = queryset_all.filter(up_branch = request.session['project'].branch)
+            queryset_all = queryset_all.filter(up_branch__in = Branch.objects.filter(name = request.session['project'].release.name))
 
         queryset_with_search = _get_queryset(Layer_Version, queryset_all, None, search_term, ordering_string, '-layer__name')
         queryset = _get_queryset(Layer_Version, queryset_all, filter_string, search_term, ordering_string, '-layer__name')
-- 
1.9.1


