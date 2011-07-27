Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlvJf-0007hu-3a
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:01:51 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Jul 2011 20:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="34904872"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2011 20:57:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 20:57:26 -0700
Message-Id: <4f9a6f6f43cf2ef38115285897fbbde01964e892.1311738866.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
In-Reply-To: <cover.1311738866.git.josh@linux.intel.com>
References: <cover.1311738866.git.josh@linux.intel.com>
Subject: [PATCH 3/4] cooker: populate rdepends-pkg in generatePkgDepTreeData
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 27 Jul 2011 04:01:51 -0000

The rdepends-pkg field of the generated depend_tree model was not populated
in the original implementation of this method, this series adds in the
loop to populate the rdepends-pkg column of the model.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1f305d9..146c211 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -452,6 +452,9 @@ class BBCooker:
 
                 rdepends = self.status.rundeps[fn]
                 for package in rdepends:
+                    depend_tree["rdepends-pkg"][package] = []
+                    for rdepend in rdepends[package]:
+                        depend_tree["rdepends-pkg"][package].append(rdepend)
                     packages.append(package)
 
                 for package in packages:
-- 
1.7.6



