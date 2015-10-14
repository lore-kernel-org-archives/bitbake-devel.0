Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 1E97A770F1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 20:27:21 +0000 (UTC)
Received: by payp3 with SMTP id p3so15794344pay.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=JWlo/5f2X9TK+kSy22Bkh6yPre9GfYOPiZ7tnYeeGmE=;
	b=YSnAf3j2QgcQp4ZGUN8leGhUMjUs8IofqN6ZBOl4x3bR4fLGoQ3EwM2PkmcdTFWIyb
	qaIVTq9VJ9mUtKUuHbX9+XsN1+ICV98dECPJlU5/FGEIpfonpZVC7zqKTxAENaqv0Dne
	q+HwTdWocujrdjfdQ1sEjy1RfpFTXdwmgsO8c1drAzStlpGDP3LxAEbYmVFqF3nqlgp1
	WHsj7s9BAPOvdsQOp95O5xr6XeXuFiA5IHp/h4UqKp4yx+81vt3pY622zqhlmEwsobHW
	hTYaFuu55M8UggSDeSvKanauxqibvf09nXmaVEA6kV0IwchEq8WV88zml+YJxyUJLmTS
	2HXA==
X-Received: by 10.66.121.110 with SMTP id lj14mr5532739pab.61.1444854441685;
	Wed, 14 Oct 2015 13:27:21 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ce3sm11236656pbb.35.2015.10.14.13.27.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 13:27:20 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:29:16 -0700
Message-Id: <7316b1cff69a0f39b849e9d46cb47bfa8eb9c6ec.1444854417.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
References: <20dd08f325d8ef8c81e951a92979cf98b0a2b905.1444854417.git.avery.brian@gmail.com>
In-Reply-To: <cover.1444854417.git.avery.brian@gmail.com>
References: <cover.1444854417.git.avery.brian@gmail.com>
Subject: [PATCH 08/10] toaster: Clean up template code
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
X-List-Received-Date: Wed, 14 Oct 2015 20:27:21 -0000

From: Elliot Smith <elliot.smith@intel.com>

Some errors in the HTML template didn't show up until
they were rendering command line builds.

One useless conditional was lingering in another template.

Clean up these issues to display the latest builds section
correctly.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/builds.html      |  5 -----
 lib/toaster/toastergui/templates/mrb_section.html | 21 ++++++++++-----------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index 566c279..459fcb0 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -29,8 +29,6 @@
 
   {% include "mrb_section.html" %}
 
-
-  {% if 1 %}
   <div class="page-header top-air">
      <h1>
       {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
@@ -57,8 +55,6 @@
         </form>
       </div>
     </div>
-
-
   {% else %}
   {% include "basetable_top.html" %}
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
@@ -117,7 +113,6 @@
 
   {% include "basetable_bottom.html" %}
   {% endif %} {# objects.paginator.count #}
-{% endif %} {# empty #}
 </div><!-- end row-fluid-->
 
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 55687a1..bd8f991 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -22,19 +22,18 @@
   {% endif %}
   <div id="latest-builds">
   {% for build in mru %}
-  <div data-latest-build-result="{{ build.id }}" class="alert build-result {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}
-    {% if mrb_type != 'project' %}
-    project-name">
-       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
-         <a href={% project_url build.project %}>
-           {{build.project.name}}
-         </a>
-       </span>
-    {% endif %}
+  <div data-latest-build-result="{{ build.id }}" class="alert build-result {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}{% if mrb_type != 'project' %} project-name{% endif %}">
+      {% if mrb_type != 'project' %}
+        <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-important{%else%}label-info{%endif%}">
+            <a href={% project_url build.project %}>
+                {{build.project.name}}
+            </a>
+        </span>
+      {% endif %}
         <div class="row-fluid">
-            <div class="span3 lead">
+          <div class="span3 lead">
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
-                <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
+              <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
     {% endif %}
             {% if build.target_set.all.count > 0 %}
                 <span data-toggle="tooltip"
-- 
1.9.1


