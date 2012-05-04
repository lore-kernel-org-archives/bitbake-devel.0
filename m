Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jeff.polk@windriver.com>) id 1SQKCJ-0001Uc-Ma
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 17:13:32 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q44E5Hnd010651
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 07:05:17 -0700 (PDT)
Received: from delos.DELOS.COM (172.25.35.98) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 4 May 2012 07:05:16 -0700
From: Jeff Polk <jeff.polk@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 4 May 2012 08:05:15 -0600
Message-ID: <1336140315-5171-2-git-send-email-jeff.polk@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1336140315-5171-1-git-send-email-jeff.polk@windriver.com>
References: <1336140315-5171-1-git-send-email-jeff.polk@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake/fetch2: Fix spelling error in network access error message
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
X-List-Received-Date: Fri, 04 May 2012 15:13:32 -0000
Content-Type: text/plain

Signed-off-by: Jeff Polk <jeff.polk@windriver.com>
---
 lib/bb/fetch2/__init__.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 414cc2b..3391e6a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -99,7 +99,7 @@ class ParameterError(BBFetchException):
 class NetworkAccess(BBFetchException):
     """Exception raised when network access is disabled but it is required."""
     def __init__(self, url, cmd):
-         msg = "Network access disabled through BB_NO_NETWORK but access rquested with command %s (for url %s)" % (cmd, url)
+         msg = "Network access disabled through BB_NO_NETWORK but access requested with command %s (for url %s)" % (cmd, url)
          self.url = url
          self.cmd = cmd
          BBFetchException.__init__(self, msg)
-- 
1.7.5.4



