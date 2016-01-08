Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 5EEE2731EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 11:17:33 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 08 Jan 2016 03:17:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,538,1444719600"; d="scan'208";a="722947369"
Received: from deryaeke-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.84])
	by orsmga003.jf.intel.com with ESMTP; 08 Jan 2016 03:17:33 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jan 2016 11:17:21 +0000
Message-Id: <cb846246dea1d4283dc78e860737c01d6d48e4c7.1452251694.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
References: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
In-Reply-To: <cover.1452251694.git.elliot.smith@intel.com>
References: <cover.1452251694.git.elliot.smith@intel.com>
Subject: [PATCH 7/8] toaster: show 'satisfied via' text for build deps
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
X-List-Received-Date: Fri, 08 Jan 2016 11:17:33 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Showed '<dependency> satisfied via <provider>' text and
help tooltip for the build dependencies provided through
'PROVIDES' in the 'Build dependencies' tab.

[YOCTO #6169]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/templates/recipe.html | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index bbe7475..d6b464b 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -172,7 +172,14 @@
 
                     {% for rr in object.r_dependencies_recipe.all|dictsort:"depends_on.name" %}
                     <tr>
-                        <td><a href="{% url "recipe" build.pk rr.depends_on.pk %}">{{rr.depends_on.name}}</a></td>
+                        <td><a href="{% url "recipe" build.pk rr.depends_on.pk %}">{{rr.depends_on.name}}</a>
+                            {% if rr.via %}
+                                <span class="muted">satisfied via {{rr.via.name}}</span>
+                                <i class="icon-question-sign get-help hover-help"
+                                 title="This dependency is satisfied by the PROVIDES value
+                                       {{rr.via.name}} in the {{rr.depends_on.name}} recipe"></i>
+                            {% endif %}
+                        </td>
                         <td><a href="{% url "recipe" build.pk rr.depends_on.pk %}">{{rr.depends_on.version}}</a></td>
                     </tr>
                     {% endfor %}
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


