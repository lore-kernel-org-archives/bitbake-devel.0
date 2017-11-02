Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2265971C1F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Nov 2017 00:01:08 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id vA2019Mm000574
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 1 Nov 2017 17:01:10 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.361.1;
	Wed, 1 Nov 2017 17:01:09 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 1 Nov 2017 20:01:08 -0400
Message-ID: <20171102000108.14102-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee
MIME-Version: 1.0
Subject: [PATCH] bitbake-layers: Add support for multiple recipes at once
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
X-List-Received-Date: Thu, 02 Nov 2017 00:01:09 -0000
Content-Type: text/plain

bitbake-layers show-recipes and show-appends supported listing all recipes
or one recipe.  Adjust the system to permit specifying more then one recipe.

Also update show-appends to match the --help description and support file
style wildcards for selecting the recipe to display.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bblayers/query.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index bef3af31..efd22cb4 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -161,7 +161,12 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         items_listed = False
         for p in sorted(pkg_pn):
             if pnspec:
-                if not fnmatch.fnmatch(p, pnspec):
+                found=False
+                for pnm in pnspec:
+                    if fnmatch.fnmatch(p, pnm):
+                        found=True
+                        break
+                if not found:
                     continue
 
             if len(allproviders[p]) > 1 or not show_multi_provider_only:
@@ -251,8 +256,14 @@ Lists recipes with the bbappends that apply to them as subitems.
         pnlist.sort()
         appends = False
         for pn in pnlist:
-            if args.pnspec and pn != args.pnspec:
-                continue
+            if args.pnspec:
+                found=False
+                for pnm in args.pnspec:
+                    if fnmatch.fnmatch(pn, pnm):
+                        found=True
+                        break
+                if not found:
+                    continue
 
             if self.show_appends_for_pn(pn):
                 appends = True
@@ -480,10 +491,10 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_recipes.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
         parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
         parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class', metavar='CLASS', default='')
-        parser_show_recipes.add_argument('pnspec', nargs='?', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
+        parser_show_recipes.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
         parser_show_appends = self.add_command(sp, 'show-appends', self.do_show_appends)
-        parser_show_appends.add_argument('pnspec', nargs='?', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
+        parser_show_appends.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
         parser_show_cross_depends = self.add_command(sp, 'show-cross-depends', self.do_show_cross_depends)
         parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
-- 
2.14.2.666.gea220ee


