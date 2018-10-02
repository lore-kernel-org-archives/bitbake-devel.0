Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3BD9F65CC7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Oct 2018 21:08:34 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w92L8VJF014911
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 2 Oct 2018 14:08:31 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 2 Oct 2018 14:08:30 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 2 Oct 2018 17:08:03 -0400
Message-ID: <20181002210803.189366-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20181002210803.189366-1-mark.hatle@windriver.com>
References: <20181002210803.189366-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH] gitsm: Allow relative URIs when fetching
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
X-List-Received-Date: Tue, 02 Oct 2018 21:08:35 -0000
Content-Type: text/plain

Some repositories may specify a relative submodule path.  If this happens,
it is our responsibility to use the parents URL (ud) and handle any relative
processing ourselves.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 4d3805a..0a982da 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -31,6 +31,7 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your r
 
 import os
 import bb
+import copy
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
@@ -77,6 +78,10 @@ class GitSM(Git):
                 submodules.append(m)
                 paths[m] = md['path']
                 uris[m] = md['url']
+                if uris[m].startswith('..'):
+                    newud = copy.copy(ud)
+                    newud.path = os.path.realpath(os.path.join(newud.path, md['url']))
+                    uris[m] = Git._get_repo_url(self, newud)
 
         for module in submodules:
             module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=True, workdir=ud.clonedir)
-- 
1.8.3.1


