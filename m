Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3DF6160616
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 08:50:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u9R8oJEc024561
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Oct 2016 01:50:24 -0700
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Thu, 27 Oct 2016 01:50:18 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 27 Oct 2016 01:50:18 -0700
Message-ID: <c624edf8377d8b8443fe9c6f76a1d600110db2d1.1477557932.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <cover.1477557932.git.liezhi.yang@windriver.com>
References: <cover.1477557932.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] lib/bb/cooker.py: fix for BBFILE_PATTERN = ""
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
X-List-Received-Date: Thu, 27 Oct 2016 08:50:24 -0000
Content-Type: text/plain

There would be error when BBFILE_PATTERN = None:
  BBFILE_PATTERN_foo not defined

This is the correct behaviour, but when the layer sets BBFILE_PATTERN = "",
it would match all the remaining recipes, and cause "No bb files matched BBFILE_PATTERN"
warnings for all the layers which behind it.

When a layer sets BBFILE_PATTERN = "" (for example, a layer only
provides git repos and source tarballs), now it means has no recipes.
This is different from BBFILE_PATTERN_IGNORE_EMPTY, the later one means
that it *may* not have any recipes.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 42831e2..c08af45 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1240,6 +1240,10 @@ class BBCooker:
                     parselog.error("BBFILE_PATTERN_%s not defined" % c)
                     errors = True
                     continue
+                elif regex == "":
+                    parselog.debug(1, "BBFILE_PATTERN_%s is empty" % c)
+                    errors = False
+                    continue
                 try:
                     cre = re.compile(regex)
                 except re.error:
-- 
2.9.0


