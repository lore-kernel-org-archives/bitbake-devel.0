Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 86BF17632C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 13:19:59 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 30 Jul 2015 06:19:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="758401089"
Received: from kanavin-desktop.fi.intel.com ([10.237.68.143])
	by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2015 06:19:53 -0700
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 16:20:49 +0300
Message-Id: <3aeeda88e236f3da577adc20597dab38a66157c5.1438262095.git.alexander.kanavin@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438262095.git.alexander.kanavin@linux.intel.com>
References: <cover.1438262095.git.alexander.kanavin@linux.intel.com>
Subject: [PATCH 1/1] wget.py: fix incorrect regexes
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
X-List-Received-Date: Thu, 30 Jul 2015 13:19:59 -0000

[\.-_] means "any character between . and _"
What was meant here is certainly "any character from the three characters .-_"

Signed-off-by: Alexander Kanavin <alexander.kanavin@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 425b6b9..bd2a897 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -406,7 +406,7 @@ class Wget(FetchMethod):
         version_dir = ['', '', '']
         version = ['', '', '']
 
-        dirver_regex = re.compile("(\D*)((\d+[\.-_])+(\d+))")
+        dirver_regex = re.compile("(\D*)((\d+[\.\-_])+(\d+))")
         s = dirver_regex.search(dirver)
         if s:
             version_dir[1] = s.group(2)
@@ -465,7 +465,7 @@ class Wget(FetchMethod):
         pn_regex = "(%s|%s|%s)" % (pn_prefix1, pn_prefix2, pn_prefix3)
 
         # match version
-        pver_regex = "(([A-Z]*\d+[a-zA-Z]*[\.-_]*)+)"
+        pver_regex = "(([A-Z]*\d+[a-zA-Z]*[\.\-_]*)+)"
 
         # match arch
         parch_regex = "-source|_all_"
-- 
2.1.4


