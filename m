Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7EC8276FDE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 12:48:58 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 15 Oct 2015 05:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,685,1437462000"; d="scan'208";a="664924235"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 15 Oct 2015 05:48:58 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id A7ACD6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 05:47:59 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 15:45:14 +0300
Message-Id: <6e153f556a5319bf4086222660bc244034fad12e.1444910218.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444910218.git.ed.bartosh@linux.intel.com>
References: <cover.1444910218.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/4] toaster: Remove Toaster exceptions section of build dashboard
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
X-List-Received-Date: Thu, 15 Oct 2015 12:48:58 -0000

From: Elliot Smith <elliot.smith@intel.com>

Fatal build errors were displayed as exceptions, and highlighted
with less severity than they deserved.

Roll back to treating Toaster exceptions as errors by removing
the toaster_exceptions member on Build objects and displaying
EXCEPTION events in the errors section on the dashboard.

[YOCTO #8320]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/orm/models.py                          |  4 --
 .../toastergui/templates/builddashboard.html       | 45 ++--------------------
 2 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 6ca45e0..a784b1b 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -348,10 +348,6 @@ class Build(models.Model):
         return Build.BUILD_OUTCOME[int(self.outcome)][1]
 
     @property
-    def toaster_exceptions(self):
-        return self.logmessage_set.filter(level=LogMessage.EXCEPTION)
-
-    @property
     def errors(self):
         return (self.logmessage_set.filter(level=LogMessage.ERROR) |
                 self.logmessage_set.filter(level=LogMessage.EXCEPTION) |
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index fc6cae6..75ca8bc 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -44,14 +44,6 @@
 
 {%endif%}
     </div>
-    {% if build.toaster_exceptions.count > 0 %}
-    <div class="row">
-        <small class="pull-right">
-        <i class="icon-question-sign get-help get-help-blue" title="" data-original-title="Toaster exceptions do not affect your build: only the operation of Toaster"></i>
-        <a class="show-exceptions" href="#exceptions">Toaster threw {{build.toaster_exceptions.count}} exception{{build.toaster_exceptions.count|pluralize}}</a>
-    </small>
-    </div>
-    {% endif %}
   </div>
 </div>
 
@@ -69,12 +61,10 @@
     <div class="accordion-body collapse in" id="collapse-errors">
       <div class="accordion-inner">
         <div class="span10">
-          {% for error in logmessages %}
-            {% if error.level == 2 or error.level == 3 %}
-              <div class="alert alert-error">
-                <pre>{{error.message}}</pre>
-              </div>
-            {% endif %}
+          {% for error in build.errors %}
+            <div class="alert alert-error">
+              <pre>{{error.message}}</pre>
+            </div>
           {% endfor %}
         </div>
       </div>
@@ -271,33 +261,6 @@
 </div>
 {% endif %}
 
-
-{% if build.toaster_exceptions.count > 0 %}
-<div class="accordion span10 pull-right" id="exceptions">
-  <div class="accordion-group">
-    <div class="accordion-heading">
-      <a class="accordion-toggle exception toggle-exceptions">
-        <h2 id="exception-toggle">
-          <i class="icon-warning-sign"></i>
-          {{build.toaster_exceptions.count}} Toaster exception{{build.toaster_exceptions.count|pluralize}}
-        </h2>
-      </a>
-    </div>
-    <div class="accordion-body collapse" id="collapse-exceptions">
-      <div class="accordion-inner">
-        <div class="span10">
-          {% for exception in build.toaster_exceptions %}
-            <div class="alert alert-exception">
-              <pre>{{exception.message}}</pre>
-            </div>
-          {% endfor %}
-        </div>
-      </div>
-    </div>
-  </div>
-</div>
-{% endif %}
-
 <script type="text/javascript">
     $(document).ready(function() {
         //show warnings section when requested from the previous page
-- 
2.1.4


