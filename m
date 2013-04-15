Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1URfae-0001kd-3m
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Apr 2013 11:21:05 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r3F93ERu016553
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Apr 2013 02:03:14 -0700 (PDT)
Received: from pek-usp-9.wrs.com (128.224.162.26) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.342.3;
	Mon, 15 Apr 2013 02:03:14 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Apr 2013 16:47:36 +0800
Message-ID: <ad8eacb419e25227877e6d52a694a79c87735cf8.1365993432.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.7
In-Reply-To: <cover.1365993432.git.liezhi.yang@windriver.com>
References: <cover.1365993432.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] monitordisk.py: disable inode checking for btrfs
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
X-List-Received-Date: Mon, 15 Apr 2013 09:21:07 -0000
X-List-Received-Date: Mon, 15 Apr 2013 09:21:07 -0000
Content-Type: text/plain

The btrfs doesn't have static inode, so disable the inode check for it,
the previouse patch has set it:

minInode = None

But this is incorrect, the minInode is just a temporary variable, it
should be:

self.devDict[k][2] = None

[YOCTO #3609]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/monitordisk.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
index a71dd9f..c6d0767 100644
--- a/bitbake/lib/bb/monitordisk.py
+++ b/bitbake/lib/bb/monitordisk.py
@@ -244,7 +244,7 @@ class diskMonitor:
                     # checking for such a fs.
                     if st.f_files == 0:
                         logger.warn("Inode check for %s is unavaliable, will remove it from disk monitor" % path)
-                        minInode = None
+                        self.devDict[k][2] = None
                         continue
                     # Always show warning, the self.checked would always be False if the action is WARN
                     if self.preFreeI[k] == 0 or self.preFreeI[k] - freeInode > self.inodeInterval and not self.checked[k]:
-- 
1.7.7



