Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id B706D7849C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Nov 2017 02:20:58 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga105.fm.intel.com with ESMTP; 07 Nov 2017 18:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,361,1505804400"; d="scan'208";a="1241188846"
Received: from tkdhir-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.68.14])
	by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2017 18:20:44 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Nov 2017 15:20:28 +1300
Message-Id: <813f7322afacdf9c124aabbef99dffff157e3966.1510107572.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1510107572.git.paul.eggleton@linux.intel.com>
References: <cover.1510107572.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] cooker: fix typo in bitbake -g message
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
X-List-Received-Date: Wed, 08 Nov 2017 02:20:58 -0000

Flatened -> flattened.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c7fdd72..28717f4 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -885,7 +885,7 @@ class BBCooker:
                         continue
                     f.write('"%s" -> "%s"\n' % (pn, dep))
             f.write("}\n")
-        logger.info("Flatened recipe dependencies saved to 'recipe-depends.dot'")
+        logger.info("Flattened recipe dependencies saved to 'recipe-depends.dot'")
 
     def show_appends_with_no_recipes(self):
         # Determine which bbappends haven't been applied
-- 
2.9.5


