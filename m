Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1B0C17704D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 14:43:56 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 03 Sep 2015 07:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,462,1437462000"; d="scan'208";a="797501692"
Received: from tmistat-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.10.21])
	by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2015 07:43:56 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Sep 2015 15:43:51 +0100
Message-Id: <7d3e190cfb4c5cf665008d36ab1285683d51e938.1441291289.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <2371961c2f0b587ac5c5dd1aee3277052c3b5486.1441291289.git.elliot.smith@intel.com>
References: <2371961c2f0b587ac5c5dd1aee3277052c3b5486.1441291289.git.elliot.smith@intel.com>
In-Reply-To: <cover.1441291289.git.elliot.smith@intel.com>
References: <cover.1441291289.git.elliot.smith@intel.com>
Subject: [PATCH 2/2] toaster: show incomplete configuration warning
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
X-List-Received-Date: Thu, 03 Sep 2015 14:43:56 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the new build button form, make sure we show a
warning when you select a project with an incomplete
configuration that cannot be built.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 1 +
 lib/toaster/toastergui/templates/base.html    | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index e252dc1..9723db3 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -216,6 +216,7 @@ dl textarea { resize: vertical; }
 .tooltip-inner { max-width: 250px; }
 .new-build { padding: 20px; }
 .new-build li { line-height: 30px; }
+.new-build li .alert { line-height: 20px; width: 200px; white-space: normal; }
 .new-build h6 { margin: 10px 0 0 0; color: #5a5a5a; }
 .new-build h3 { margin: 0; color: #5a5a5a; }
 .new-build form { margin: 5px 0 0; }
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 0b93bb3..640bc47 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -148,9 +148,11 @@
                   <p><a id="view-all-projects" href="{% url 'all-projects' %}">View all projects</a></p>
                 </form>
               </li>
-              <li style="display: none">
-                This project's configuration is incomplete,<br/>so you cannot run builds.<br/>
-                <p><a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a></p>
+              <li>
+                <div class="alert" style="display:none;">
+                  <p>This project configuration is incomplete, so you cannot run builds.</p>
+                  <p><a href="{% if project.id %}{% url 'project' project.id %}{% endif %}">View project configuration</a></p>
+                </div>
               </li>
               <li id="targets-form">
                 <h6>Recipe(s):</h6>
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


