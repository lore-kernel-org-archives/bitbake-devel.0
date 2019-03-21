Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id C78C160102
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Mar 2019 07:00:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x2L70rIh008996
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Mar 2019 00:00:54 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 21 Mar 2019 00:00:50 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Mar 2019 15:20:21 +0800
Message-ID: <61fb9e18afc98ecbb558ae3c7fa036938e21aab5.1553152790.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1553152790.git.liezhi.yang@windriver.com>
References: <cover.1553152790.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cooker: Fix bbfile_config_priorities when BBFILE_PATTERN is empty
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
X-List-Received-Date: Thu, 21 Mar 2019 07:00:52 -0000
Content-Type: text/plain

The layer was not in bbfile_config_priorities when BBFILE_PATTERN is empty,
this caused "bitbake-layers show-layers" can't show these layers, this was
incorrect since these layer did exist. Add these layer to
bbfile_config_priorities can fix the problem.

Fixed:
Add BBFILE_PATTERN_core = "" in oe-core/meta/conf/layer.conf
$ bitbake show-layers | grep oe-core

There was nothing, now the layer is shown

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1982e88..9ccaa79 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1216,8 +1216,8 @@ class BBCooker:
                     continue
                 elif regex == "":
                     parselog.debug(1, "BBFILE_PATTERN_%s is empty" % c)
+                    cre = re.compile('^NULL$')
                     errors = False
-                    continue
                 else:
                     try:
                         cre = re.compile(regex)
-- 
2.7.4


