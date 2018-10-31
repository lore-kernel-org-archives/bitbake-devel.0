Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4891579CCC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 19:22:36 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w9VJLvAD002337
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 12:22:07 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.408.0;
	Wed, 31 Oct 2018 12:21:46 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 31 Oct 2018 15:21:43 -0400
Message-ID: <20181031192144.35366-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20181031192144.35366-1-mark.hatle@windriver.com>
References: <20181031192144.35366-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] fetch2/gitsm.py: Disable branch checking on submodules
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
X-List-Received-Date: Wed, 31 Oct 2018 19:22:36 -0000
Content-Type: text/plain

Submodules by definition refer to a specific commit, not branch.  If we don't
ignore the branch, then any commits on a submodule on a branch different then
the original module will trigger a failure that the commit is not on the
branch.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0a982da..dbfa3a4 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -92,7 +92,7 @@ class GitSM(Git):
             url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
-            url += ";bareclone=1;nocheckout=1"
+            url += ";bareclone=1;nocheckout=1;nobranch=1"
 
             ld = d.createCopy()
             # Not necessary to set SRC_URI, since we're passing the URI to
-- 
1.8.3.1


