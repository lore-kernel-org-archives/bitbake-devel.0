Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id EFB547229E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jan 2015 07:29:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0K7THkX019315
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jan 2015 23:29:18 -0800 (PST)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.174.1;
	Mon, 19 Jan 2015 23:29:17 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 19 Jan 2015 23:29:16 -0800
Message-ID: <565b6f79717a7dec0d36bc0df94ef54dfa0db0ce.1421738928.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1421738928.git.liezhi.yang@windriver.com>
References: <cover.1421738928.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] cooker.py: trap the ENOSPC error and translate it
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
X-List-Received-Date: Tue, 20 Jan 2015 07:29:18 -0000
Content-Type: text/plain

Trap the ENOSPC error and translate it into a human readable error
message, which is good for debugging.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 95f65ac..011f069 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -198,6 +198,11 @@ class BBCooker:
                         f = os.path.dirname(f)
                         watcher.bbseen.append(f)
                         continue
+                    if 'ENOSPC' in str(e):
+                        providerlog.error("No space left on device or exceeds fs.inotify.max_user_watches?")
+                        providerlog.error("To check max_user_watches: sysctl -n fs.inotify.max_user_watches.")
+                        providerlog.error("To modify max_user_watches: sysctl -n -w fs.inotify.max_user_watches=<value>.")
+                        providerlog.error("Root privilege is required to modify max_user_watches.")
                     raise
 
     def sigterm_exception(self, signum, stackframe):
-- 
1.7.9.5


