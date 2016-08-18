Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 58520731A5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 08:26:16 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u7I8QGos013527
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 01:26:16 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Thu, 18 Aug 2016 01:26:15 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 18 Aug 2016 01:26:13 -0700
Message-ID: <474c63bf03bfcba4463ec944575abc84b5730423.1471508749.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <cover.1471508749.git.liezhi.yang@windriver.com>
References: <cover.1471508749.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] dump_cache.py: use python3 as interpreter
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
X-List-Received-Date: Thu, 18 Aug 2016 08:26:17 -0000
Content-Type: text/plain

Fixed:
  File "bitbake/contrib/dump_cache.py", line 39
    print("Error, need one argument!", file=sys.stderr)

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/contrib/dump_cache.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/contrib/dump_cache.py b/bitbake/contrib/dump_cache.py
index a1f09b4..f4d4c1b 100755
--- a/bitbake/contrib/dump_cache.py
+++ b/bitbake/contrib/dump_cache.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
-- 
2.9.0


