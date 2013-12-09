Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9B8106E26A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:26 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359891"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:25 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:08 +0000
Message-Id: <a9c24343f13d33d159dab0ac2fd8f50262408980.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 02/11] toaster: remove Author field in SimpleUI
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:26 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Removes a left-over Author field in the Simple UI
recipe page.

    [YOCTO #5449]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldviewer/templates/recipe.html | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/toaster/bldviewer/templates/recipe.html b/lib/toaster/bldviewer/templates/recipe.html
index e9a1c10..7d5fbf4 100644
--- a/lib/toaster/bldviewer/templates/recipe.html
+++ b/lib/toaster/bldviewer/templates/recipe.html
@@ -21,7 +21,6 @@
             <th>License file</th>
             <th>Homepage</th>
             <th>Bugtracker</th>
-            <th>Author</th>
             <th>File_path</th>
             <th style="width: 30em">Recipe Dependency</th>
 
-- 
1.8.1.2


