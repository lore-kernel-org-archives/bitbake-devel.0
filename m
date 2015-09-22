Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 80AE576417
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 09:35:10 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 22 Sep 2015 02:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,572,1437462000"; d="scan'208";a="810261739"
Received: from martinbu-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.21.229])
	by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2015 02:35:08 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Sep 2015 10:34:54 +0100
Message-Id: <3d49e4be3d6cd465242c026de236d89a20aa2c9b.1442914166.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <adee73e311b4f4c21718045b2720affb5de61342.1442914166.git.elliot.smith@intel.com>
References: <adee73e311b4f4c21718045b2720affb5de61342.1442914166.git.elliot.smith@intel.com>
In-Reply-To: <cover.1442914166.git.elliot.smith@intel.com>
References: <cover.1442914166.git.elliot.smith@intel.com>
Subject: [PATCH 3/4] toaster: change UI to show tasks
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
X-List-Received-Date: Tue, 22 Sep 2015 09:35:10 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Changed toaster UI to show tasks if they're specified for the
builds and use them when restarting builds.

[YOCTO #7442]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/templates/builds.html       | 12 ++++++++++-
 lib/toaster/toastergui/templates/mrb_section.html  | 23 +++++++++++++++++-----
 .../toastergui/templates/projectbuilds.html        | 12 ++++++++++-
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index c0d0c64..2b35b01 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -66,7 +66,17 @@
             <td class="outcome">
         <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a> &nbsp;
         </td>
-            <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
+            <td class="target">
+                {% for t in build.target_set.all %}
+                    <a href="{% url "builddashboard" build.id %}">
+                        {% if t.task %}
+                            {{t.target}}:{{t.task}}
+                        {% else %}
+                            {{t.target}}
+                        {% endif %}
+                    </a> <br />
+                {% endfor %}
+            </td>
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
             <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 396fb8e..13e2d0e 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -26,12 +26,25 @@
     {% endif %}
             {% if build.target_set.all.count > 0 %}
                 <span data-toggle="tooltip"
-                  {%if build.target_set.all.count > 1%}
-                    title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"
-                  {%endif%}
+                  {% if build.target_set.all.count > 1 %}
+                    title="Targets:
+                    {% for target in build.target_set.all %}
+                        {% if target.task %}
+                            {{target.target}}:{{target.task}}
+                        {% else %}
+                            {{target.target}}
+                        {% endif %}
+                    {% endfor %}"
+                  {% endif %}
                 >
-
-                  {{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%}
+                {% if build.target_set.all.0.task %}
+                    {{build.target_set.all.0.target}}:{{build.target_set.all.0.task}}
+                {% else %}
+                    {{build.target_set.all.0.target}}
+                {% endif %}
+                {% if build.target_set.all.count > 1 %}
+                    (+ {{build.target_set.all.count|add:"-1"}})
+                {% endif %}
                 </span>
              {% endif %}
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index 27cfcd7..fc659a0 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -66,7 +66,17 @@
                     {% endif %}
             </td>
 
-            <td class="target">{% for t in build.target_set.all %} <a href="{% url "builddashboard" build.id %}"> {{t.target}} </a> <br />{% endfor %}</td>
+            <td class="target">
+                {% for t in build.target_set.all %}
+                    <a href="{% url "builddashboard" build.id %}">
+                        {% if t.task %}
+                            {{t.target}}:{{t.task}}
+                        {% else %}
+                            {{t.target}}
+                        {% endif %}
+                    </a> <br />
+                {% endfor %}
+            </td>
             <td class="machine"><a href="{% url "builddashboard" build.id %}">{{build.machine}}</a></td>
             <td class="started_on"><a href="{% url "builddashboard" build.id %}">{{build.started_on|date:"d/m/y H:i"}}</a></td>
             <td class="completed_on"><a href="{% url "builddashboard" build.id %}">{{build.completed_on|date:"d/m/y H:i"}}</a></td>
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


