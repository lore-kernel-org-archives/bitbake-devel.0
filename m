Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 6A89D7198A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jan 2018 16:06:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w02G6Gfw022819
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 2 Jan 2018 08:06:16 -0800 (PST)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Tue, 2 Jan 2018 08:06:15 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 2 Jan 2018 07:59:49 -0800
Message-ID: <f148ed841b2075e7d7590c2dbf2ec083f5ec7198.1514703701.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1514703701.git.David.Reyna@windriver.com>
References: <cover.1514703701.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/1] toaster: corrupted patch for bldcollector URL file
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
X-List-Received-Date: Tue, 02 Jan 2018 16:06:14 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Fix a fatal error introduced by a corrupted patch file
submission.

[YOCTO #12459]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcollector/urls.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcollector/urls.py b/lib/toaster/bldcollector/urls.py
index ed379bf..888175d 100644
--- a/lib/toaster/bldcollector/urls.py
+++ b/lib/toaster/bldcollector/urls.py
@@ -17,7 +17,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 
-from djaV2 ngo.conf.urls import include, url
+from django.conf.urls import include, url
 
 import bldcollector.views
 
-- 
1.9.1


