Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id BA1F077000
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:23:10 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 07 Oct 2015 06:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="821409601"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 07 Oct 2015 06:23:11 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 388C86A4083;
	Wed,  7 Oct 2015 06:22:13 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 16:20:54 +0300
Message-Id: <ce97e8e1565732c97f90eaf368382d5e63d7bf00.1444223946.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
References: <b8bbed3da4991f25019c6e0319fb5880b7f403bd.1444223946.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444223946.git.ed.bartosh@linux.intel.com>
References: <cover.1444223946.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 09/10] toaster: Exclude "command line builds" project from projects typeahead
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
X-List-Received-Date: Wed, 07 Oct 2015 13:23:12 -0000

From: Elliot Smith <elliot.smith@intel.com>

The "New build" drop-down provides autocomplete for Toaster projects.

However, it should not include the default project (for command
line builds), as it should not be possible for the user to
select this project as the container for a Toaster build.

[YOCTO #8231]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/typeaheads.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index 9db3182..dd4b7f5 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -121,12 +121,12 @@ class RecipesTypeAhead(ToasterTypeAhead):
         return results
 
 class ProjectsTypeAhead(ToasterTypeAhead):
-    """ Typeahead for all the projects """
+    """ Typeahead for all the projects, except for command line builds """
     def __init__(self):
         super(ProjectsTypeAhead, self).__init__()
 
     def apply_search(self, search_term, prj, request):
-        projects = Project.objects.all().order_by("name")
+        projects = Project.objects.exclude(is_default=True).order_by("name")
 
         primary_results = projects.filter(name__istartswith=search_term)
         secondary_results = projects.filter(name__icontains=search_term).exclude(pk__in=primary_results)
-- 
2.1.4


