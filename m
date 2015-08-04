Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id AD1F576599
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:47:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 04 Aug 2015 12:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,611,1432623600"; d="scan'208";a="742158888"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 04 Aug 2015 12:46:45 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id CED9B6A4083;
	Tue,  4 Aug 2015 12:45:58 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:29 +0300
Message-Id: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 01/12] bitbake: toaster: orm Add util function to return the url to layerversion
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
X-List-Received-Date: Tue, 04 Aug 2015 19:47:11 -0000

From: Michael Wood <michael.g.wood@intel.com>

Save duplicating this call and make a utility function for it on the
Layer_Version object.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/orm/models.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 2d7ef09..3b72f80 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -23,6 +23,7 @@ from django.db import models
 from django.db.models import F, Q, Avg
 from django.utils import timezone
 
+from django.core.urlresolvers import reverse
 
 from django.core import validators
 from django.conf import settings
@@ -1109,6 +1110,9 @@ class Layer_Version(models.Model):
             return self.up_branch.name
         return ("Cannot determine the vcs_reference for layer version %s" % vars(self))
 
+    def get_detailspage_url(self, project_id):
+        return reverse('layerdetails', args=(project_id, self.pk))
+
     def __unicode__(self):
         return "%d %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
 
-- 
2.1.4


