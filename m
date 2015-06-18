Return-Path: <dev@codyps.com>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
	[209.85.220.176])
	by mail.openembedded.org (Postfix) with ESMTP id 93AF075A06
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jun 2015 19:06:52 +0000 (UTC)
Received: by qkeo142 with SMTP id o142so32073761qke.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jun 2015 12:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codyps.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=G1H65sSMUN4hI7iO3v0RSEGIkOukFtc66AKcmftBNjU=;
	b=EaNkiq4eZ7ftqD25tfoDft7BDifLjzzL7MaYA9JvKXwyifOKJee77pmAgEM3cVvt/A
	S28oT5b4SBbsCWGHpXe9n76pLRp6SqyKrvKS8F56rRq+8HH8tdNx0KnNn+6w0O46wYvX
	zWnjfE05XkkjAyY1ZmcnQiSnXTHwODlHf+5VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=G1H65sSMUN4hI7iO3v0RSEGIkOukFtc66AKcmftBNjU=;
	b=XohNsfC9zjlH4Hus/idgQRlVjsawQREx4bXg1Ys1spJVrcMPnChE8AQIssEy54cVmy
	dF9PaDKYeTq2uPx/DLe8EIQQdtuOrJc9l3xxefpG1OhNOTRdmVQSxsiaAKz1hif7LEiv
	elBqJwCj074Gv8JY/7DvhITYkEcYv9iIZ7y3nsHOxb4n6hwCdX9MuClK0wxOhfCTiDH5
	qytTyGyYQAe/TMG3NGuk2of4Jeq5hJc2EHOtVK5Nwk/waK3BPbP6aJKhiTpRcRLJ9s8j
	wFSPVRe9/o1S52fKxUNglepK9uxM0DLyuL4sfPTmPiXpRGAxjwzEHy8q7GV0GRNmzjEY
	ka9w==
X-Gm-Message-State: ALoCoQmvQnSNEPu6ut6BVjyLfsmWleQnwQn94/8NtfEhedxRHBwLzQ3tXBo4ITc2RwXg46G1NIV0
X-Received: by 10.55.33.203 with SMTP id f72mr11407547qki.52.1434654413892;
	Thu, 18 Jun 2015 12:06:53 -0700 (PDT)
Received: from localhost (static-96-237-165-28.bstnma.fios.verizon.net.
	[96.237.165.28])
	by mx.google.com with ESMTPSA id w67sm4385236qgw.41.2015.06.18.12.06.53
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Jun 2015 12:06:53 -0700 (PDT)
From: Cody P Schafer <dev@codyps.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Jun 2015 15:06:50 -0400
Message-Id: <1434654410-26672-1-git-send-email-dev@codyps.com>
X-Mailer: git-send-email 2.4.3
X-Mailman-Approved-At: Tue, 23 Jun 2015 11:54:45 +0000
Subject: [PATCH] When sorting packages, also sort by version at the lowest level
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
X-List-Received-Date: Thu, 18 Jun 2015 19:06:56 -0000

This makes sure we chose the highest versioned package when there is an
option to choose among multiple packages (for example, if
PREFERRED_VERSION contains a wildcard like PREFERRED_VERSION_foo =
"4.%")

Signed-off-by: Cody P Schafer <dev@codyps.com>
---
 lib/bb/providers.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 637e1fa..40b7fd1 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -26,6 +26,7 @@ import logging
 from bb import data, utils
 from collections import defaultdict
 import bb
+from functools import cmp_to_key
 
 logger = logging.getLogger("BitBake.Provider")
 
@@ -77,6 +78,8 @@ def sortPriorities(pn, dataCache, pkg_pn = None):
     """
     Reorder pkg_pn by file priority and default preference
     """
+    def version_cmp(f1, f2):
+        utils.vercmp(dataCache.pkg_pepvpr[f1], dataCache.pkg_pepvpr[f2])
 
     if not pkg_pn:
         pkg_pn = dataCache.pkg_pn
@@ -95,7 +98,7 @@ def sortPriorities(pn, dataCache, pkg_pn = None):
     for pri in sorted(priorities):
         tmp_pref = []
         for pref in sorted(priorities[pri]):
-            tmp_pref.extend(priorities[pri][pref])
+            tmp_pref.extend(sorted(priorities[pri][pref], key=cmp_to_key(version_cmp)))
         tmp_pn = [tmp_pref] + tmp_pn
 
     return tmp_pn
-- 
2.4.3


