Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 43290731A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 03:42:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u6I3grHD019232
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 17 Jul 2016 20:42:56 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Sun, 17 Jul 2016 20:42:52 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 17 Jul 2016 20:42:51 -0700
Message-ID: <1e5f0292a524e5da076e605719b6dbfa039b8926.1468813269.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <cover.1468813269.git.liezhi.yang@windriver.com>
References: <cover.1468813269.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] lib/bb/utils.py: return sorted OrderedDict in explode_dep_versions2
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
X-List-Received-Date: Mon, 18 Jul 2016 03:42:57 -0000
Content-Type: text/plain

The OrderedDict's item is sorted by insertion order, there might be a
problem when build the same recipe again, for example:
- First build of acl:
  Depends: libattr1 (>= 2.4.47), libc6 (>= 2.24)
- Second build of acl:
  Depends: libc6 (>= 2.24), libattr1 (>= 2.4.47)

They are exactly the same depends, but tools like "diff" doesn't think
so. Return sorted OrderedDict will fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 0a1bf68..12f2aef 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -250,6 +250,7 @@ def explode_dep_versions2(s):
         if not (i in r and r[i]):
             r[lastdep] = []
 
+    r = collections.OrderedDict(sorted(r.items(), key=lambda x: x[0]))
     return r
 
 def explode_dep_versions(s):
-- 
2.9.0


