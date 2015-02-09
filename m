Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id A2F25732AF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:06 +0000 (UTC)
Received: by pdjy10 with SMTP id y10so2146719pdj.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=iuui/wBexuYdoP8rASZeQWlkQKOqNkndoVBuhS+qipw=;
	b=ef5re/sut5HCVxetTojnBDao0uIi0611J8t5xxZh314V79dCI2MO/5Luuwj10jFMqy
	tHEssjxLDNCVOzKHvUR6sEhGMOQ0ssG/+01BSrGiGW+qC6s0DfTjt4dIot9PSf69Pmfc
	rP70wqyfiWAzxK+xkHEZ5hgcMLWUsJZieN7535GSmoEA43q8U+sCyaZEZPUp91G4JZyP
	m0QnsAcU0Dv3te+Wm84k+PZB2fxNgbR5+zKtwTS7qNX/p2PQqjblmSjUt6S0/onmdEXX
	94Ny5Jumvobqb5vMQ6R4J/GQQbiK8/KhZCNXynNKMUVr7e84zkFfdiyn5Z3XWmpfFbBI
	EA5g==
X-Gm-Message-State: ALoCoQmXqJDG+o0yUC2gbm+xbYPINvaLb9I12KPLnMhubOyiflALIxJHNrpkPjeBN+zZIOeVekOQ
X-Received: by 10.70.61.106 with SMTP id o10mr31107910pdr.46.1423504927491;
	Mon, 09 Feb 2015 10:02:07 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hh2sm17124046pac.32.2015.02.09.10.02.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:06 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 590A25661A7; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:42 +0000
Message-Id: <29837409a6cbabafe9e4d102e8143bab5ec22dc2.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 12/27] toastergui: add download task log icon to recipe details page
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:06 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

When a task fails, we keep the log and allow users to
download it. Make sure the download is provided in the
tasks table of the recipe details page.

[YOCTO #7207]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js |  4 +++-
 lib/toaster/toastergui/templates/recipe.html   | 11 +++++------
 lib/toaster/toastergui/templates/tasks.html    | 10 +++++-----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 04264cd..2dc5b0a 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -1,4 +1,3 @@
-
 /* All shared functionality to go in libtoaster object.
  * This object really just helps readability since we can then have
  * a traceable namespace.
@@ -315,6 +314,9 @@ $(document).ready(function() {
     // initialise the tooltips for the icon-pencil icons
     $(".icon-pencil").tooltip({ container: 'body', html: true, delay: {show: 400}, title: "Change" });
 
+    // initialise the tooltips for the download icons
+    $(".icon-download-alt").tooltip({ container: 'body', html: true, delay: { show: 200 } });
+
     // linking directly to tabs
     $(function(){
           var hash = window.location.hash;
diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index d91768d..621b852 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -124,17 +124,16 @@
 
                     <td>
                         <a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_outcome_display}} </a>
+                        {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
+                            <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
+                                <i class="icon-download-alt" title="Download task log file"></i>
+                            </a>
+                        {% endif %}
                         <i class="icon-question-sign get-help hover-help" title="{{task.get_outcome_help}}"></i>
                     </td>
                     <td>
                         {% ifnotequal task.sstate_result task.SSTATE_NA %}
                         <a {{ task|task_color }} href="{% url "task" build.pk task.pk %}">{{task.get_sstate_result_display}}</a>
-                    {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
-                        <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
-                        </a>
-                    {% endif %}
-
                         {% endifnotequal %}
                     </td>
 
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index 4cbcc5e..5c1c476 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -93,12 +93,12 @@
             </td>
             <td class="outcome">
                 <a href="{%url "task" build.pk task.pk%} ">{{task.get_outcome_display}} </a>
+                {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
+                    <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
+                        <i class="icon-download-alt" title="Download task log file"></i>
+                    </a>
+                {% endif %}
                 <i class="icon-question-sign get-help hover-help" title="{{task.get_outcome_help}}"></i>
-                    {% if MANAGED and build.project and task.outcome = task.OUTCOME_FAILED %}
-                        <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download task log file"></i>
-                        </a>
-                    {% endif %}
             </td>
             <td class="cache_attempt">
                 <a href="{%url "task" build.pk task.pk%} ">{{task.get_sstate_result_display|format_none_and_zero}}</a>
-- 
1.9.1


