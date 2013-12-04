Return-Path: <Konrad.Scherer@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id A1C89615B0
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2013 15:39:42 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rB4Fdfvk023931
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 4 Dec 2013 07:39:41 -0800 (PST)
Received: from yow-kscherer-d1.wrs.com (128.224.146.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.347.0; Wed, 4 Dec 2013 07:39:41 -0800
From: Konrad Scherer <konrad.scherer@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 4 Dec 2013 10:39:41 -0500
Message-ID: <1386171581-16533-1-git-send-email-konrad.scherer@windriver.com>
X-Mailer: git-send-email 1.8.3.2
MIME-Version: 1.0
Subject: [PATCH] fetch2: Unable to fetch URL should be a warning, not an error
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
X-List-Received-Date: Wed, 04 Dec 2013 15:39:43 -0000
Content-Type: text/plain

From: Konrad Scherer <Konrad.Scherer@windriver.com>

Running a build server with local sstate cache and running the
oe-core sstate-cache-management.sh script on cron can cause errors if
an sstate file is removed before it can be used. This is not an
error because the package can be rebuilt from source. Changing
the message to a warning is more appropriate in this case.

Signed-off-by: Konrad Scherer <Konrad.Scherer@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 199cdca..ddbd7f1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1418,7 +1418,7 @@ class Fetch(object):
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
                     if firsterr:
-                        logger.error(str(firsterr))
+                        logger.warn(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
                 update_stamp(ud, self.d)
-- 
1.8.3.2


