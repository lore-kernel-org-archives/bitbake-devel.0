Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RVgVc-0005Dj-RX
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 Nov 2011 10:31:21 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pAU9Oel9004839
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Nov 2011 01:24:40 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Wed, 30 Nov 2011 01:24:40 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Nov 2011 17:23:50 +0800
Message-ID: <443f574322e598e3d1df230a7a8c6b10c03291b3.1322644797.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1322644797.git.liezhi.yang@windriver.com>
References: <cover.1322644797.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] Remove the duplicated assignments of self.configuration.cmd
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
X-List-Received-Date: Wed, 30 Nov 2011 09:31:21 -0000
Content-Type: text/plain

The assignments of self.configuration.cmd in BBCooker seems duplicated,
have the followings in both BBCooker::__init__ and
BBCooker::loadConfigurationData:

if not self.configuration.cmd:
    self.configuration.cmd = self.configuration.data.getVar("BB_DEFAULT_TASK", True) or "build"

The __init__ invokes the loadConfigurationData, and it would make sure
that self.configuration.cmd has been assigned a proper value, so we can
remove the one in __init__.

[YOCTO #1791]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5bbabfc..212c434 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -135,9 +135,6 @@ class BBCooker:
         self.configuration.data = None
         self.loadConfigurationData()
 
-        if not self.configuration.cmd:
-            self.configuration.cmd = self.configuration.data.getVar("BB_DEFAULT_TASK", True) or "build"
-
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
         lockfile = self.configuration.data.expand("${TOPDIR}/bitbake.lock")
-- 
1.7.4.1



