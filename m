Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TyiC1-0003oy-By
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Jan 2013 13:15:38 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r0P8YH8w013486
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 00:34:17 -0800 (PST)
Received: from pek-usp-13.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 25 Jan 2013 00:34:17 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2013 16:34:13 +0800
Message-ID: <917f8cbf7fd9f2f99d3a53474084240e9961acd5.1359083205.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1359083205.git.liezhi.yang@windriver.com>
References: <cover.1359083205.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] cache.py: remove the duplicated self.file_depends
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 25 Jan 2013 12:15:39 -0000
Content-Type: text/plain

There are two "self.file_depends =" lines in cache.py::CoreRecipeInfo:

class CoreRecipeInfo(RecipeInfoCommon):
    __slots__ = ()

    cachefile = "bb_cache.dat"

    def __init__(self, filename, metadata):
        self.file_depends = metadata.getVar('__depends', False)
    [snip]
        self.file_depends = metadata.getVar('__depends', False)

They are duplicated, remove the last one.

[YOCTO #3795]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index a3c073a..fd5fbb3 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -119,7 +119,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.basetaskhashes = self.taskvar('BB_BASEHASH', self.tasks, metadata)
         self.hashfilename = self.getvar('BB_HASHFILENAME', metadata)
 
-        self.file_depends = metadata.getVar('__depends', False)
         self.task_deps = metadata.getVar('_task_deps', False) or {'tasks': [], 'parents': {}}
 
         self.skipped = False
-- 
1.7.1



