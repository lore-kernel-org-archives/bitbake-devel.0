Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 1D3176FF01
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jun 2016 02:42:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u5F2gCJn013149
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2016 19:42:12 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Tue, 14 Jun 2016 19:42:11 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 14 Jun 2016 19:42:10 -0700
Message-ID: <1002d2b4b2a2a715982f4351f0412954b1735d74.1465958474.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1465958474.git.liezhi.yang@windriver.com>
References: <cover.1465958474.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] lib/bb/build.py: remove task flag in deltask()
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
X-List-Received-Date: Wed, 15 Jun 2016 02:42:13 -0000
Content-Type: text/plain

Otherwise the function like d.getVarFlag(e, 'task', True) which is used by
do_listtasks will still get it, and list the deleted tasks.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/build.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index e016ae3..2ebe673 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -778,6 +778,7 @@ def deltask(task, d):
     bbtasks = d.getVar('__BBTASKS', False) or []
     if task in bbtasks:
         bbtasks.remove(task)
+        d.delVarFlag(task, 'task')
         d.setVar('__BBTASKS', bbtasks)
 
     d.delVarFlag(task, 'deps')
-- 
2.8.0


