Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 88007786CB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 20:34:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w6CKYIYa024395
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jul 2018 13:34:18 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.399.0;
	Thu, 12 Jul 2018 13:34:18 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 Jul 2018 16:34:12 -0400
Message-ID: <20180712203413.118578-5-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180712203413.118578-1-mark.hatle@windriver.com>
References: <20180712203413.118578-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/5] bitbake-layers: disable parsing for layerindex commands
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
X-List-Received-Date: Thu, 12 Jul 2018 20:34:17 -0000
Content-Type: text/plain

These don't need to access recipe information, so let's not waste the
user's time parsing all recipes.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bblayers/layerindex.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 9b0d6c1..9b56252 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -188,12 +188,12 @@ class LayerIndexPlugin(ActionPlugin):
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


