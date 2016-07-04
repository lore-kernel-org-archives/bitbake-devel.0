Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id 7350E6011C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jul 2016 11:52:59 +0000 (UTC)
Received: by mail-pf0-f171.google.com with SMTP id i123so61105646pfg.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 04 Jul 2016 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=5FD6iA/xThJckjpDj0gy9y/nYZXxxAqyXZvHr00/kYo=;
	b=vm2p8gnb8xY6TESquOLKnlYmhGrRNwhLHUWpaaArN7VdrzynN+XLY1WU2jjKnuxrd0
	yje4mdNsRH+CwfMJCuPjcmFq8mom0Qup2GHx7lsCrTt7k11fuEL1BZ3t5+D/8OTYwiAY
	qtrcNKAjQACIgjErXNrJ0DhuFYKH3gVJc630+SK815sAzyc5dLtN74QJx7t/Fl0bN2nz
	Mz7QErW05NGaGu3+5FT8mSIrEIqsmFzKnuPPXqMgKcectKCGxhYfWmMiV/uhWkkZbG1n
	aDqpCKCDpTm01d5PSdqUhENLdldbVouVea2opdjc8qH51iMy9Xw36hBks0K71MoPsCR1
	WlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=5FD6iA/xThJckjpDj0gy9y/nYZXxxAqyXZvHr00/kYo=;
	b=Ha1FmpugSJkuftKLT7zwxEzy9CTVC+MkajbIFTt97+CXK9PiK545/MIsTD52PpNGzm
	YMR8vQtrYDoGS9zhQLITmMVziXRo9pM9lrRoUuydokBsodFU+fcJdft5sTxjRUNediE0
	57DSB2aKKExv1JWjASD9+yfgy6zxaydt5PKVJNzR7rjN6bcrsez9lyYADnjGNdCOu9jG
	hWA9LtK/NuDhH9O4Q+04HkSe3xZH+TXYStRa7YH5tGi7DtnfeIO+LTPargTziGl7Kakb
	wgBJkE4ZfxfxzVNUZ1s45eFHLbs/mv2BdcvouYjgwCOVvUtOz+yjIDxbE6q5eYZ1SY0k
	ln6A==
X-Gm-Message-State: ALyK8tK4flR4IoSVJ0bbAO8Qp6y+rgA5/uSManBi+GUFRizSCyUr875E/w/AkVMZM6AUS4lH
X-Received: by 10.98.0.83 with SMTP id 80mr22114572pfa.0.1467633179750;
	Mon, 04 Jul 2016 04:52:59 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38])
	by smtp.gmail.com with ESMTPSA id i3sm4596768pfk.30.2016.07.04.04.52.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 04 Jul 2016 04:52:59 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jul 2016 12:52:53 +0100
Message-Id: <1467633173-11557-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] toaster: fix layout for command-line builds in recent builds area
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
X-List-Received-Date: Mon, 04 Jul 2016 11:52:59 -0000

From: Elliot Smith <elliot.smith@intel.com>

Command-line builds were displayed incorrectly, so that the
HTML elements for other builds were being "consumed" by the
command-line build elements due to incorrect positioning of
element end tags.

Fix by ensuring end tags close elements in the right places.

As the indentation was all over the place in the most recent
builds section template, it was almost impossible to see what the
problem was. So that was fixed, too.

[YOCTO #9842]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/mrb_section.html | 247 +++++++++++-----------
 1 file changed, 123 insertions(+), 124 deletions(-)

diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 4b4e3e6..b164269 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -3,6 +3,7 @@
 {% load project_url_tag %}
 {% load humanize %}
 <script src="{% static 'js/mrbsection.js' %}"></script>
+
 <script>
   $(document).ready(function () {
     var ctx = {
@@ -18,165 +19,163 @@
   });
 </script>
 
-{%if mru %}
+{% if mru %}
 
-  {%if mrb_type == 'project' %}
-  <h2>
-    Latest project builds
+  {% if mrb_type == 'project' %}
+    <h2>
+      Latest project builds
 
-    {% if project.is_default %}
-    <span class="glyphicon glyphicon-question-sign get-help heading-help" title="" data-original-title="Builds in this project cannot be started from Toaster: they are started from the command line"></span>
-    {% endif %}
-  </h2>
+      {% if project.is_default %}
+        <span class="glyphicon glyphicon-question-sign get-help heading-help" data-original-title="Builds in this project cannot be started from Toaster: they are started from the command line"></span>
+        {% endif %}
+    </h2>
   {% else %}
     <div class="page-header">
-      <h1>
-      Latest builds
-      </h1>
+      <h1>Latest builds</h1>
     </div>
   {% endif %}
+
   <div id="latest-builds">
-  {% for build in mru %}
-  <div data-latest-build-result="{{ build.id }}" class="alert build-result {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-danger{%else%}alert-info{%endif%}">
+    {% for build in mru %}
+      <div data-latest-build-result="{{build.id}}" class="alert build-result {% if build.outcome == build.SUCCEEDED %}alert-success{% elif build.outcome == build.FAILED %}alert-danger{% else %}alert-info{% endif %}">
         {% if mrb_type != 'project' %}
-        <div class="row project-name">
-          <div class="col-md-12">
-            <small>
-              <a class="alert-link text-uppercase" href={% project_url build.project %}>{{build.project.name}}</a>
-            </small>
+          <div class="row project-name">
+            <div class="col-md-12">
+              <small>
+                <a class="alert-link text-uppercase" href={% project_url build.project %}>{{build.project.name}}</a>
+              </small>
+            </div>
           </div>
-        </div>
         {% endif %}
+
         <div class="row">
           <div class="col-md-3">
-    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
-              <a href="{%url 'builddashboard' build.pk%}" class="alert-link">
-    {% endif %}
+            {% if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+              <a href="{% url 'builddashboard' build.pk %}" class="alert-link">
+            {% endif %}
+
             {% if build.target_set.all.count > 0 %}
-                <span data-toggle="tooltip"
-                  {% if build.target_set.all.count > 1 %}
-                    {{build.get_sorted_target_list.0.target}}
-                    title="Recipes:
-                    {% for target in build.get_sorted_target_list %}
-                        {% if target.task %}
-                            {{target.target}}:{{target.task}}
-                        {% else %}
-                            {{target.target}}
-                        {% endif %}
-                    {% endfor %}"
-                  {% endif %}
-                >
+              <span data-toggle="tooltip"
+                {% if build.target_set.all.count > 1 %}
+                  {{build.get_sorted_target_list.0.target}}
+                  title="Recipes:
+                  {% for target in build.get_sorted_target_list %}
+                    {% if target.task %}
+                      {{target.target}}:{{target.task}}
+                    {% else %}
+                      {{target.target}}
+                    {% endif %}
+                  {% endfor %}"
+                {% endif %}
+              >
                 {% if build.target_set.all.0.task %}
-                    {{build.get_sorted_target_list.0.target}}:{{build.target_set.all.0.task}}
+                  {{build.get_sorted_target_list.0.target}}:{{build.target_set.all.0.task}}
                 {% else %}
-                    {{build.get_sorted_target_list.0.target}}
+                  {{build.get_sorted_target_list.0.target}}
                 {% endif %}
+
                 {% if build.target_set.all.count > 1 %}
-                    (+{{build.target_set.all.count|add:"-1"}})
+                  (+{{build.target_set.all.count|add:"-1"}})
                 {% endif %}
-                </span>
-             {% endif %}
-    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
-                </a>
-    {% endif %}
-            </div>
-    {% if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+              </span>
+            {% endif %}
+            {% if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+              </a>
+            {% endif %}
+          </div>
+
+          {% if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="col-md-2">
-                {% if build.completed_on|format_build_date  %}
-                    {{ build.completed_on|date:'d/m/y H:i' }}
-                {% else %}
-                    {{ build.completed_on|date:'H:i' }}
-                {% endif %}
+              {% if build.completed_on|format_build_date  %}
+                {{build.completed_on|date:'d/m/y H:i'}}
+              {% else %}
+                {{ build.completed_on|date:'H:i' }}
+              {% endif %}
             </div>
-    {% endif %}
-    {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
+          {% endif %}
+
+          {% if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="col-md-2">
-      {% if  build.errors.count %}
+              {% if build.errors.count %}
                 <span class="glyphicon glyphicon-minus-sign"></span>
-                <a href="{%url 'builddashboard' build.pk%}#errors" class="alert-link">{{build.errors.count}} error{{build.errors.count|pluralize}}</a>
-      {% endif %}
+                <a href="{%url 'builddashboard' build.pk%}#errors" class="alert-link">
+                  {{build.errors.count}} error{{build.errors.count|pluralize}}
+                </a>
+              {% endif %}
             </div>
+
             <div class="col-md-2">
-      {% if  build.warnings.count %}
+              {% if build.warnings.count %}
                 <span class="glyphicon glyphicon-warning-sign build-warnings"></span>
-                <a href="{%url 'builddashboard' build.pk%}#warnings" class="alert-link build-warnings">{{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a>
-      {% endif %}
+                <a href="{%url 'builddashboard' build.pk%}#warnings" class="alert-link build-warnings">
+                  {{build.warnings.count}} warning{{build.warnings.count|pluralize}}
+                </a>
+              {% endif %}
             </div>
+
             <div class="col-md-3">
               Build time: <a class="alert-link" href="{% url 'buildtime' build.pk %}">{{ build.timespent_seconds|sectohms }}
               </a>
+
               {% if build.project.is_default %}
-                  <span class="pull-right glyphicon glyphicon-question-sign get-help
-                  {% if build.outcome == build.SUCCEEDED %}
-                      get-help-green
-                  {% elif build.outcome == build.FAILED %}
-                      get-help-red
-                  {% else %}
-                      get-help-blue
-                  {% endif %}
-                  " title="Builds in this project cannot be started from Toaster: they are started from the command line">
-                  </span>
+                <span class="pull-right glyphicon glyphicon-question-sign get-help {% if build.outcome == build.SUCCEEDED %}get-help-green{% elif build.outcome == build.FAILED %}get-help-red{% else %}get-help-blue{% endif %}"
+                title="Builds in this project cannot be started from Toaster: they are started from the command line">
+                </span>
               {% else %}
-                  <a href="#" class="run-again-btn alert-link
-                      {% if build.outcome == build.SUCCEEDED %}
-                          success
-                      {% elif build.outcome == build.FAILED %}
-                          danger
-                      {% else %}
-                          info
-                      {%endif%}
-                      pull-right"
-                      data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
-                      data-target='{{build.target_set.all|get_tasks|json}}'>
-                      <span class="glyphicon glyphicon-repeat"></span>
-                      Rebuild
-                  </a>
+                <a href="#" class="run-again-btn alert-link {% if build.outcome == build.SUCCEEDED %}success{% elif build.outcome == build.FAILED %}danger{% else %}info{% endif %} pull-right"
+                data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
+                data-target='{{build.target_set.all|get_tasks|json}}'>
+                  <span class="glyphicon glyphicon-repeat"></span>
+                  Rebuild
+                </a>
               {% endif %}
             </div>
-    {%endif%}
+          {% endif %}
 
-    {%if build.outcome == build.IN_PROGRESS %}
-    <div class="col-md-4" style="display:none" id="cancelling-msg-{{build.buildrequest.pk}}">
-      Cancelling the build ...
-    </div>
-    <div class="col-md-4 col-md-offset-1 progress-info">
-      <div class="progress" id="build-pc-done-title-{{build.pk}}">
-        <div id="build-pc-done-bar-{{build.pk}}" style="width: {{build.completeper}}%;" class="progress-bar"></div>
-      </div>
-    </div>
-    <div class="col-md-4 progress-info"><span id="build-pc-done-{{build.pk}}">{{build.completeper}}</span>% of tasks complete
-    {# No build cancel for command line builds project #}
-    {% if build.project.is_default %}
-    <span class="glyphicon glyphicon-question-sign get-help get-help-blue pull-right" title="Builds in this project cannot be cancelled from Toaster: they can only be cancelled from the command line"></span>
-    {% else %}
-      <a href="#" class="cancel-build-btn pull-right alert-link"
-          data-buildrequest-id={{build.buildrequest.pk}}
-          data-request-url="{% url 'xhr_buildrequest' build.project.pk %}" >
-        <span class="glyphicon glyphicon-remove-circle"></span>
-        Cancel
-      </a>
-    </div>
-    {% endif %}
+          {% if build.outcome == build.IN_PROGRESS %}
+            <div class="col-md-4" style="display:none" id="cancelling-msg-{{build.buildrequest.pk}}">
+              Cancelling the build ...
+            </div>
 
-    {%endif%} {# end if in progress #}
+            <div class="col-md-4 col-md-offset-1 progress-info">
+              <div class="progress" id="build-pc-done-title-{{build.pk}}">
+                <div id="build-pc-done-bar-{{build.pk}}" style="width: {{build.completeper}}%;" class="progress-bar">
+                </div>
+              </div>
+            </div>
 
-    {% if build.outcome == build.CANCELLED %}
-    <div class="col-md-6">
-      Build cancelled
-    </div>
-    <div class="col-md-3">
-      <a href="#" class="info pull-right run-again-btn alert-link"
-        data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
-        data-target='{{build.target_set.all|get_tasks|json}}'>
-        <span class="glyphicon glyphicon-repeat"></span>
-        Rebuild
-      </a>
-    </div>
-    {% endif %}
-  </div>
-</div>
-  {% endfor %}
-  </div>
+            <div class="col-md-4 progress-info">
+              <span id="build-pc-done-{{build.pk}}">{{build.completeper}}</span>% of tasks complete
+              {# No build cancel for command line builds project #}
+              {% if build.project.is_default %}
+                <span class="glyphicon glyphicon-question-sign get-help get-help-blue pull-right" title="Builds in this project cannot be cancelled from Toaster: they can only be cancelled from the command line"></span>
+              {% else %}
+                <a href="#" class="cancel-build-btn pull-right alert-link"
+                data-buildrequest-id={{build.buildrequest.pk}}
+                data-request-url="{% url 'xhr_buildrequest' build.project.pk %}">
+                  <span class="glyphicon glyphicon-remove-circle"></span>
+                  Cancel
+                </a>
+              {% endif %}
+            </div>
+          {% endif %} {# end if in progress #}
 
-{%endif%}
+          {% if build.outcome == build.CANCELLED %}
+            <div class="col-md-6">
+              Build cancelled
+            </div>
 
+            <div class="col-md-3">
+              <a href="#" class="info pull-right run-again-btn alert-link"
+              data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
+              data-target='{{build.target_set.all|get_tasks|json}}'>
+                <span class="glyphicon glyphicon-repeat"></span>
+                Rebuild
+              </a>
+            </div>
+          {% endif %}
+        </div>
+      </div>
+    {% endfor %}
+  </div>
+{% endif %}
\ No newline at end of file
-- 
2.7.4


