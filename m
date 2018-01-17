Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 419B9786E7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jan 2018 08:52:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w0H8qZE6022749
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jan 2018 00:52:37 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Wed, 17 Jan 2018 00:52:35 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Jan 2018 16:52:50 +0800
Message-ID: <c401ad1ea3d8b6f35e6966258f91ec4c3c7e5e27.1516179099.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1516179099.git.liezhi.yang@windriver.com>
References: <cover.1516179099.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] cooker.py: the var cre maybe undefined
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
X-List-Received-Date: Wed, 17 Jan 2018 08:52:36 -0000
Content-Type: text/plain

The cre is not defined when re.compile(regex) raise errors, move the code where
use it to the try block to fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 28717f4..ebfed0d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1173,11 +1173,11 @@ class BBCooker:
                 else:
                     try:
                         cre = re.compile(regex)
+                        self.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
                     except re.error:
                         parselog.error("BBFILE_PATTERN_%s \"%s\" is not a valid regular expression", c, regex)
                         errors = True
                         continue
-                self.bbfile_config_priorities.append((c, regex, cre, collection_priorities[c]))
         if errors:
             # We've already printed the actual error(s)
             raise CollectionError("Errors during parsing layer configuration")
-- 
2.7.4


