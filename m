Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 4E31C6CAF9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902460"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id F10F556230C; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:17 +0100
Message-Id: <cec95c34dcfac0b4ab4b6a1b4593317e8197a32d.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 48/94] bitbake: webhob: simple interface dependency list
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:09 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add a diff to obtain a consistent layout of the dependency
field information for tasks.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/bldviewer/templates/task.html | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 88c82d8..2d78668 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -48,10 +48,12 @@
                 <td>{{task.get_script_type_display}}</td>
                 <td>{{task.recipe.file_path}}</td>
                 <td>
+            <div style="height: 3em; overflow:auto">
                 {% for tt in task.depends_on %}
                     <a href="#{{tt.recipe.name}}.{{tt.task_name}}">
                     {{tt.recipe.name}}.{{tt.task_name}}</a><br/>
                 {% endfor %}
+            </div>
                 </td>
                 </tr>
 
-- 
1.8.1.2


