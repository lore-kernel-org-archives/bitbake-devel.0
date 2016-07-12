Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0C40673199
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672970"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:52 -0700
Message-Id: <86ed97167bef321cb852f2d058f5375bce11dfb2.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 11/17] toaster: show manifests in their own section of the build dashboard
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:57 -0000

From: Elliot Smith <elliot.smith@intel.com>

In the build dashboard, add a section for manifests to each target,
which will contain the license and package manifests for a target.

As we don't record the package manifest (yet), just move the
license manifest link to that section for now.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/toastergui/templates/builddashboard.html | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index e1bde21..febf8af 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -103,12 +103,15 @@
         {% if not target.targetHasNoImages %}
           <dl class="dl-horizontal">
             <dt>
-                <span class="glyphicon glyphicon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></span>
-                License manifest
+              Manifests
             </dt>
+
             <dd>
-                <a href="{% url 'target' build.pk target.target.pk %}">View in Toaster</a> |
-                <a href="{% url 'build_artifact' build.pk 'licensemanifest' target.target.pk %}">Download</a></dd>
+              <a href="{% url 'build_artifact' build.pk 'licensemanifest' target.target.pk %}">License manifest</a>
+            </dd>
+          </dl>
+
+          <dl class="dl-horizontal">
             <dt>
                 <span class="glyphicon glyphicon-question-sign get-help" title="Image files are stored in <code>build/tmp/deploy/images/</code>"></span>
                 Image files
-- 
1.9.1


