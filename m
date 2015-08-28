Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 2D48F76DA6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 16:28:24 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 28 Aug 2015 09:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,425,1437462000"; d="scan'208";a="792839247"
Received: from abityuts-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.11.19])
	by orsmga002.jf.intel.com with ESMTP; 28 Aug 2015 09:28:05 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Aug 2015 17:27:55 +0100
Message-Id: <5d29445b63e78439faa1c5b46d76580051c10410.1440779114.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <4ecc69540a5fc01212f45c8e2af91096fc89aa27.1440779114.git.elliot.smith@intel.com>
References: <4ecc69540a5fc01212f45c8e2af91096fc89aa27.1440779114.git.elliot.smith@intel.com>
In-Reply-To: <cover.1440779114.git.elliot.smith@intel.com>
References: <cover.1440779114.git.elliot.smith@intel.com>
Subject: [PATCH 2/2] toaster: fix global navigation
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
X-List-Received-Date: Fri, 28 Aug 2015 16:28:24 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The "All builds" item in the global navigation should
only be active when you are in the "all builds" page.

The global navigation should not appear at all in the
landing page and in the new project page.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/templates/base.html | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index f187100..0b93bb3 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -89,8 +89,9 @@
             <i class="icon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
             {% endif %}
           </span>
+          {% if request.resolver_match.url_name != 'landing' and request.resolver_match.url_name != 'newproject' %}
           <ul class="nav">
-            <li {% if "builds" in  request.path  %}
+            <li  {% if request.resolver_match.url_name == 'all-builds' %}
                 class="active"
                 {% endif %}>
               <a href="{% url 'all-builds' %}">
@@ -98,7 +99,7 @@
                 All builds
               </a>
             </li>
-            <li {% if "projects" in  request.path  %}
+            <li {% if request.resolver_match.url_name == 'all-projects'  %}
                 class="active"
                 {% endif %}>
               <a href="{% url 'all-projects' %}">
@@ -107,6 +108,7 @@
               </a>
             </li>
           </ul>
+          {% endif %}
           <ul class="nav pull-right">
             <li>
               <a target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
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


