Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 828E47C6AF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 09:09:42 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2E99N9S032360
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 02:09:33 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 14 Mar 2019 02:09:12 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Mar 2019 17:28:19 +0800
Message-ID: <aca46e6fee49c13c8b1f091545c5df2873b921f7.1552555629.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1552555629.git.liezhi.yang@windriver.com>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/5] fetch2: Print SCMs list when SRCREV_FORMAT is not set
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
X-List-Received-Date: Thu, 14 Mar 2019 09:09:42 -0000
Content-Type: text/plain

This makes it easier to debug, especially when multipe SCMs like gitsm,
otherwise we don't know why there are multiple SCMs.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 5062bb2..64d7526 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -777,7 +777,8 @@ def get_srcrev(d, method_name='sortable_revision'):
     #
     format = d.getVar('SRCREV_FORMAT')
     if not format:
-        raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.")
+        raise FetchError("The SRCREV_FORMAT variable must be set when multiple SCMs are used.\n"\
+                         "The SCMs are:\n%s" % '\n'.join(scms))
 
     name_to_rev = {}
     seenautoinc = False
-- 
2.7.4


