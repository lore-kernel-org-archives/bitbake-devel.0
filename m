Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C870161176
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 10:46:08 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 01IAk9PO002615
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 02:46:09 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Tue, 18 Feb 2020 02:46:09 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Feb 2020 18:48:02 +0800
Message-ID: <fde322a3dc77acd8082419514586c472a3a8a234.1582022808.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582022808.git.liezhi.yang@windriver.com>
References: <cover.1582022808.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake/lib/bb/event.py: Remove duplicated ones from close matches
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
X-List-Received-Date: Tue, 18 Feb 2020 10:46:08 -0000
Content-Type: text/plain

It printed duplicated ones when there are multiple similar recipes in
differrent layers, for example, if python-lockfile in different layers,
and there is no python3-lockfile:

$ bitbake python3-lockfile
ERROR: Nothing PROVIDES 'python3-lockfile'. Close matches:
python-lockfile
python-lockfile
python3-aiofiles

Remove the duplicated ones to fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 5cfbf36..d1359f0 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -508,7 +508,7 @@ class NoProvider(Event):
         extra = ''
         if not self._reasons:
             if self._close_matches:
-                extra = ". Close matches:\n  %s" % '\n  '.join(self._close_matches)
+                extra = ". Close matches:\n  %s" % '\n  '.join(sorted(set(self._close_matches)))
 
         if self._dependees:
             msg = "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s" % (r, self._item, ", ".join(self._dependees), r, extra)
-- 
2.7.4


