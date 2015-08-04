Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 5AC4E76486
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:46:57 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 04 Aug 2015 12:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,611,1432623600"; d="scan'208";a="536004725"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2015 12:46:57 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 391D06A4083;
	Tue,  4 Aug 2015 12:46:11 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:37 +0300
Message-Id: <b17bbbcd9fb9d99e91e576a5692929fe61e435f0.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 09/12] bitbake: toastergui: views Standardise the fields project layer response
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
X-List-Received-Date: Tue, 04 Aug 2015 19:46:57 -0000

From: Michael Wood <michael.g.wood@intel.com>

We need to keep consistent the field names of these objects so that we
can use the object response from different calls. e.g. layer dependences
or listing layers in the project.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/views.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 6a219ed..4563eaf 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2224,9 +2224,10 @@ if True:
                         "id": x.layercommit.pk,
                         "orderid": x.pk,
                         "name" : x.layercommit.layer.name,
-                        "giturl": x.layercommit.layer.vcs_url,
+                        "vcs_url": x.layercommit.layer.vcs_url,
+                        "vcs_reference" : x.layercommit.get_vcs_reference(),
                         "url": x.layercommit.layer.layer_index_url,
-                        "layerdetailurl": reverse("layerdetails", args=(prj.id, x.layercommit.pk,)),
+                        "layerdetailurl": x.layercommit.get_detailspage_url(prj.pk),
                 # This branch name is actually the release
                         "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}},
                     prj.projectlayer_set.all().order_by("id")),
-- 
2.1.4


