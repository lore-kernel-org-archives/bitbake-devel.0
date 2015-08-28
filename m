Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id C8A8776A4B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 16:06:58 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 28 Aug 2015 09:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,425,1437462000"; d="scan'208";a="550366124"
Received: from abityuts-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.11.19])
	by FMSMGA003.fm.intel.com with ESMTP; 28 Aug 2015 09:06:57 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Aug 2015 17:06:35 +0100
Message-Id: <1440777995-10431-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: fix show / hide columns in all builds table
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
X-List-Received-Date: Fri, 28 Aug 2015 16:06:58 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The classes errors_no and warnings_no were removed from the
td tags in the builds.html template. That broke the show / hide
columns functionality, which would hide only the table heading,
but not the data cells.

This patch brings back those classes so that you can hide
and show the errors and warnings information.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/builds.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/builds.html b/bitbake/lib/toaster/toastergui/templates/builds.html
index b68fa6f..c0d0c64 100644
--- a/bitbake/lib/toaster/toastergui/templates/builds.html
+++ b/bitbake/lib/toaster/toastergui/templates/builds.html
@@ -81,12 +81,12 @@
                         <a href="{% url "tasks" build.id %}?filter=outcome%3A4">{{exectask.count}} task{{exectask.count|pluralize}}</a>
                     {%endif%}
             </td>
-            <td class="errors.count">
+            <td class="errors.count errors_no">
                 {% if  build.errors.count %}
                     <a class="errors.count error" href="{% url "builddashboard" build.id %}#errors">{{build.errors.count}} error{{build.errors.count|pluralize}}</a>
                 {%endif%}
             </td>
-            <td class="warnings.count">{% if  build.warnings.count %}<a class="warnings.count warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a>{%endif%}</td>
+            <td class="warnings.count warnings_no">{% if  build.warnings.count %}<a class="warnings.count warning" href="{% url "builddashboard" build.id %}#warnings">{{build.warnings.count}} warning{{build.warnings.count|pluralize}}</a>{%endif%}</td>
             <td class="time"><a href="{% url "buildtime" build.id %}">{{build.timespent_seconds|sectohms}}</a></td>
             <td class="output">
               {% if build.outcome == build.SUCCEEDED %}
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


