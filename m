Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id C9610723AC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:12 +0000 (UTC)
Received: by mail-wi0-f173.google.com with SMTP id r20so16393496wiv.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=kxs/rz/lfwWF5O8u4m2hkexTASlsgwzDigNxJm/MwN8=;
	b=P2Uk/JSZVqH/tVHcmiLnw7nWw6WetM18aiSL1R0nzjz1VNPiHua3rW+lfBrPDlWZ5e
	S+J3Is24jnKGFPm117/YTa7EmmiyEdSzUoSNDXthJ8HfTcSliLXlL2q0QuvdL3OXuCE5
	hH9MaSLdzLDDXVPkpKsAuI8GXCiMFNAmzYZSSFLOGAVLYWyTdm3HWYJQrTEMoikDbxn5
	hLouT5eyL74MKf8Gh/dctwwQ28UDGLA8T+XSozFQKdY/o1XfxVvkVs5WG0yZy4VHbjHN
	ozR+44eDePAZaEYr/d2GYhY0ZmEInopNgg354hacV9vomRW80hW8wLSZWogwIYL5ek+D
	g98A==
X-Gm-Message-State: ALoCoQl1hqHysWNCRyKBDH1i/SDUDmcNHgucKy9ZJTBtvqfh0SjPZH4+ToWnxNj3T/DvRSFrSkGD
X-Received: by 10.180.90.241 with SMTP id bz17mr53710931wib.41.1417108092769; 
	Thu, 27 Nov 2014 09:08:12 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id c5sm12429100wik.3.2014.11.27.09.08.09
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 087A556410C; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:59 +0000
Message-Id: <be357d147d525ac3d6b7bd33ca0aa594728ffedd.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 08/14] toastergui: new project page
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Patch that brings in to new project page according to specifications.

[YOCTO #6596]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/base.html       |   2 +-
 lib/toaster/toastergui/templates/newproject.html | 116 +++++++++++++++++------
 lib/toaster/toastergui/views.py                  |   7 +-
 3 files changed, 92 insertions(+), 33 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 8170a3d..594c495 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -60,7 +60,7 @@
             </a>
             {%if MANAGED %}
             <div class="btn-group pull-right">
-              <a class="btn" href="{% url 'newproject' %}">New project</a>
+                  <a class="btn" id="new-project-button" href="{% url 'newproject' %}">New project</a>
             </div>
             <!-- New build popover -->
             <div class="btn-group pull-right" id="new-build-button">
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index 43c4e28..5a5e1e6 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -3,35 +3,91 @@
 {% load humanize %}
 {% block pagecontent %}
 <div class="row-fluid">
-				<div class="span6">
-				<div class="page-header">
-					<h1>Create a new project</h1>
-				</div>
-				<div class="container-fluid">
-		{% if alert %}
-			<div class="alert alert-error row-fluid" role="alert">{{alert}}</div>
-		{% endif %}
-				</div>
-					<form method="POST">{% csrf_token %}
-						<fieldset>
-							<label>Project name <span class="muted">(required)</span></label>
-							<input type="text" class="input-xlarge" required name="projectname" value="{{projectname}}">
-							<label class="project-form">
-								Yocto Project version
-								<i class="icon-question-sign get-help" title="This sets the branch for the Yocto Project core layers (meta, meta-yocto and meta-yocto-bsp), and for the layers you use from the OpenEmbedded Metadata Index"></i>
-							</label>
-							<select name="projectversion" id="projectversion">
-	{% for release in releases %}
-		<option value="{{release.id}}"{%if projectversion == release.id %} selected{%endif%}>{{release.name}} ({{release.description}})</option>
-	{% endfor %}
-							</select>
-						</fieldset>
+    <div class="page-header">
+          <h1>Create a new project</h1>
+        </div>
+        <div class="container-fluid">
+    {% if alert %}
+      <div class="alert alert-error row-fluid" role="alert">{{alert}}</div>
+    {% endif %}
+        </div>
+    {% if releases.count > 0 %}
+        <form method="POST">{% csrf_token %}
+            <fieldset>
+              <label>Project name <span class="muted">(required)</span></label>
+              <input type="text" class="input-xlarge" required id="new-project-name" name="projectname">
+       {% if releases.count > 1 %}
+              <label class="project-form">
+                Release version
+                <i class="icon-question-sign get-help" title="The version of the build system you want to use"></i>
+              </label>
+              <select name="projectversion" id="projectversion">
+  {% for release in releases %}
+    <option value="{{release.id}}"{%if projectversion == release.id %} selected{%endif%}>{{release.description}} ({{release.name}})</option>
+  {% endfor %}
+              </select>
+  {% for release in releases %}
+    <div class="row-fluid helptext" id="description-{{release.id}}" style="display: none">
+        <span class="help-block span5">{{release.helptext|safe}}</span>
+    </div>
+  {% endfor %}
+       {% else %}
+    <input type="hidden" name="projectversion" value="{{releases.0.id}}"/>
+       {% endif %}
+            </fieldset>
 
-						<div class="form-actions">
-							<input type="submit" class="btn btn-primary btn-large" value="Create project"/>
-						</div>
-					</form>
-				</div>
-			</div>
-		</div>
+            <div class="form-actions">
+              <input type="submit" class="btn btn-primary btn-large" value="Create project"></input>
+              <span class="help-inline" style="vertical-align:middle;">To create a project, you need to enter a project name</span>
+            </div>
+        </form>
+    {% else %}
+    <br/>
+    <div class="alert alert-warning row-fluid span6">
+    <h3>No releases configured</h3>
+    <p>
+    It looks like Toaster releases have not been configured properly. Contact the person who set up Toaster, and tell them about it.
+    </p>
+    <p>
+    If you are the Toaster administrator, we are sorry: setting up Toaster is not easy.
+    <ul>
+    <li><a href="{% url 'admin:orm_release_changelist' %}">Log in to the Django administration interface</a> and check  the "Releases" section.</li>
+    <li>Check out the <a href="https://wiki.yoctoproject.org/wiki/Setting_up_a_hosted_managed_mode_for_Toaster#Releases">documentation about configuring releases</a></li>
+    </ul>
+    </p>
+    </div>
+    {% endif %}
+
+    </div>
+    <script type="text/javascript">
+        $(document).ready(function () {
+            // hide the new project button
+            $("#new-project-button").hide();
+            $('.btn-primary').attr('disabled', 'disabled');
+
+            // enable submit button when all required fields are populated
+            $("input#new-project-name").keyup(function() {
+                if ($("input#new-project-name").val().length > 0 ){
+                    $('.btn-primary').removeAttr('disabled');
+                    $(".help-inline").css('visibility','hidden');
+                }
+                else {
+                    $('.btn-primary').attr('disabled', 'disabled');
+                    $(".help-inline").css('visibility','visible');
+                }
+            });
+
+            // show relevant help text for the selected release
+            var selected_release = $('select').val();
+            $("#description-" + selected_release).show();
+
+
+			$('select').change(function(){
+				var new_release = $('select').val();
+                $(".helptext").hide();
+				$('#description-' + new_release).fadeIn();
+			});
+        })
+    </script>
+</div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index b13f3e8..49a7769 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1894,9 +1894,12 @@ if toastermain.settings.MANAGED:
             'email': request.user.email if request.user.is_authenticated() else '',
             'username': request.user.username if request.user.is_authenticated() else '',
             'releases': Release.objects.order_by("id"),
-            'defaultbranch': ToasterSetting.objects.get(name = "DEFAULT_RELEASE").value,
         }
 
+        try:
+            context['defaultbranch'] = ToasterSetting.objects.get(name = "DEFAULT_RELEASE").value
+        except ToasterSetting.DoesNotExist:
+            pass
 
         if request.method == "GET":
             # render new project page
@@ -2156,7 +2159,7 @@ if toastermain.settings.MANAGED:
 
 
             def _lv_to_dict(x):
-                return {"id": x.pk, "name": x.layer.name, 
+                return {"id": x.pk, "name": x.layer.name,
                         "detail": "(" + x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.up_branch.name+")"),
                         "giturl": x.layer.vcs_url, "layerdetailurl" : reverse('layerdetails', args=(x.pk,))}
 
-- 
1.9.1


