Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 585436C555
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Dec 2018 01:48:57 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wB41mwuw029025
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 3 Dec 2018 17:48:58 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Mon, 3 Dec 2018 17:48:58 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 4 Dec 2018 10:06:02 +0800
Message-ID: <2e220210d606c7dbd461ffca0490b924a4d1f9cb.1543889029.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543889029.git.liezhi.yang@windriver.com>
References: <cover.1543889029.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/4] pysh/pyshlex.py: Set is not importable
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
X-List-Received-Date: Tue, 04 Dec 2018 01:48:57 -0000
Content-Type: text/plain

>>> from Set import Set
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: No module named 'Set'

So remove related code.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/pysh/pyshlex.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/bitbake/lib/bb/pysh/pyshlex.py b/bitbake/lib/bb/pysh/pyshlex.py
index fbf094b..a42c294 100644
--- a/bitbake/lib/bb/pysh/pyshlex.py
+++ b/bitbake/lib/bb/pysh/pyshlex.py
@@ -13,11 +13,6 @@
 # PLY in pull mode. It was designed to work incrementally and it would not be
 # that hard to enable pull mode.
 import re
-try:
-    s = set()
-    del s
-except NameError:
-    from Set import Set as set
 
 from ply import lex
 from bb.pysh.sherrors import *
-- 
2.7.4


