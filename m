Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 7BF4D77FF5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 20:53:24 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v5RKrQMW007412
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jun 2017 13:53:26 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.209) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Tue, 27 Jun 2017 13:53:24 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Jun 2017 13:44:32 -0700
Message-ID: <37ee5206684cd5d24cd411f3362459a3c6d09fa1.1498595653.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1498595646.git.David.Reyna@windriver.com>
References: <cover.1498595646.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.209]
Subject: [PATCH 5/5] toaster: test 'commit' first in get_vcs_reference
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
X-List-Received-Date: Tue, 27 Jun 2017 20:53:24 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The 'commit' value should be tested and used first when resolving the ref
for a layer, since that is an explicit override in each layer index
'layeritem' record. If should take precedence over more-global 'branch'
and 'release' values, instead of being last.

[YOCTO #11515]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 5c14727..630e4a0 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1516,12 +1516,12 @@ class Layer_Version(models.Model):
         return self._handle_url_path(self.layer.vcs_web_tree_base_url, '')
 
     def get_vcs_reference(self):
+        if self.commit is not None and len(self.commit) > 0:
+            return self.commit
         if self.branch is not None and len(self.branch) > 0:
             return self.branch
         if self.release is not None:
             return self.release.name
-        if self.commit is not None and len(self.commit) > 0:
-            return self.commit
         return 'N/A'
 
     def get_detailspage_url(self, project_id=None):
-- 
1.9.1


