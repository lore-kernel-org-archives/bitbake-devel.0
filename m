Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 559C560125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 10:20:33 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 07 Oct 2015 03:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,648,1437462000"; d="scan'208";a="821200096"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 07 Oct 2015 03:20:35 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 9D3D86A4083
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 03:19:36 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 13:20:15 +0300
Message-Id: <2bd6d137555b44c374853068767e7f4c736898d1.1444213003.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444213003.git.ed.bartosh@linux.intel.com>
References: <cover.1444213003.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444213003.git.ed.bartosh@linux.intel.com>
References: <cover.1444213003.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/2] toaster: Hide "Download build log" button if log doesn't exist
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
X-List-Received-Date: Wed, 07 Oct 2015 10:20:34 -0000

From: Elliot Smith <elliot.smith@intel.com>

Our builds pages show all builds, but also include build requests
which may have resulted in a build failure, before the build
started (e.g. at the recipe parsing stage).

In such cases, the BuildStarted event is not captured by Toaster,
so we have no idea where the log file for the failed build is.

The result is that a build is shown by the Toaster UI /builds/ pages,
but it is really a pretend build which never went beyond being a
build request, and which has no associated log file. In turn, this
breaks the "Download build log" button on the build dashboard,
as there's no log file associated with the build.

Fix this by hiding the "Download build log" button for builds
which don't have a cooker_log_path.

[YOCTO #8373]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/templates/builddashboard.html | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/builddashboard.html b/bitbake/lib/toaster/toastergui/templates/builddashboard.html
index bab8e38..aa99134 100644
--- a/bitbake/lib/toaster/toastergui/templates/builddashboard.html
+++ b/bitbake/lib/toaster/toastergui/templates/builddashboard.html
@@ -37,7 +37,9 @@
     <span > <i class="icon-warning-sign yellow"></i><strong><a href="#warnings" class="warning show-warnings"> {{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a></strong></span>
 {% endif %}
             <span class="pull-right">Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent_seconds|sectohms }}</a>
-            <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%else%}btn-danger{%endif%} pull-right log" href="{% url 'build_artifact' build.id "cookerlog" build.id %}">Download build log</a>
+            {% if build.cooker_log_path %}
+                <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%else%}btn-danger{%endif%} pull-right log" href="{% url 'build_artifact' build.id "cookerlog" build.id %}">Download build log</a>
+            {% endif %}
             </span>
 
 {%endif%}
-- 
2.1.4


