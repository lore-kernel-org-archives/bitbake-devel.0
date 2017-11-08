Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id ECB28784A0
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Nov 2017 02:18:01 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP; 07 Nov 2017 18:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,361,1505804400"; 
   d="scan'208";a="4848773"
Received: from tkdhir-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.68.14])
	by orsmga002.jf.intel.com with ESMTP; 07 Nov 2017 18:18:01 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Nov 2017 15:17:08 +1300
Message-Id: <6791df64f4c46baca11aabaae197d036b21220fc.1510107342.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1510107342.git.paul.eggleton@linux.intel.com>
References: <cover.1510107342.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] bitbake-layers: show-recipes: fix help to mention -i supports multiple classes
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
X-List-Received-Date: Wed, 08 Nov 2017 02:18:02 -0000

The -i option supports more than one class, but the help didn't mention
that.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bblayers/query.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index efd22cb..9294dfa 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -490,7 +490,7 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_recipes = self.add_command(sp, 'show-recipes', self.do_show_recipes)
         parser_show_recipes.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
         parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
-        parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class', metavar='CLASS', default='')
+        parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class(es) - separate multiple classes using , (without spaces)', metavar='CLASS', default='')
         parser_show_recipes.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
         parser_show_appends = self.add_command(sp, 'show-appends', self.do_show_appends)
-- 
2.9.5


