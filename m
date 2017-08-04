Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 965BE71DCF
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Aug 2017 03:17:26 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v743HSEZ032163
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Thu, 3 Aug 2017 20:17:28 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.361.1;
	Thu, 3 Aug 2017 20:17:27 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Aug 2017 22:15:32 -0500
Message-ID: <1501816532-89236-6-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1501816532-89236-1-git-send-email-mark.hatle@windriver.com>
References: <1501816532-89236-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
Cc: toaster@yoctoproject.org
Subject: [PATCH 5/5] bitbake-layers: disable parsing for layerindex commands
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
X-List-Received-Date: Fri, 04 Aug 2017 03:17:26 -0000
Content-Type: text/plain

These don't need to access recipe information, so let's not waste the
user's time parsing all recipes.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bblayers/layerindex.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index f5c4cca..6eef67d 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -132,12 +132,12 @@ class LayerIndexPlugin(ActionPlugin):
         self.do_layerindex_fetch(args)
 
     def register_commands(self, sp):
-        parser_layerindex_fetch = self.add_command(sp, 'layerindex-fetch', self.do_layerindex_fetch)
+        parser_layerindex_fetch = self.add_command(sp, 'layerindex-fetch', self.do_layerindex_fetch, parserecipes=False)
         parser_layerindex_fetch.add_argument('-n', '--show-only', help='show dependencies and do nothing else', action='store_true')
         parser_layerindex_fetch.add_argument('-b', '--branch', help='branch name to fetch')
         parser_layerindex_fetch.add_argument('-i', '--ignore', help='assume the specified layers do not need to be fetched/added (separate multiple layers with commas, no spaces)', metavar='LAYER')
         parser_layerindex_fetch.add_argument('layername', nargs='+', help='layer to fetch')
 
-        parser_layerindex_show_depends = self.add_command(sp, 'layerindex-show-depends', self.do_layerindex_show_depends)
+        parser_layerindex_show_depends = self.add_command(sp, 'layerindex-show-depends', self.do_layerindex_show_depends, parserecipes=False)
         parser_layerindex_show_depends.add_argument('-b', '--branch', help='branch name to fetch')
         parser_layerindex_show_depends.add_argument('layername', nargs='+', help='layer to query')
-- 
1.8.3.1


