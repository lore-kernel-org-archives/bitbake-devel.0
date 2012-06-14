Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SfI07-0000n6-Jq
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 23:54:48 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5ELi9L8029502
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2012 14:44:09 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 14 Jun 2012 14:44:09 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2012 16:44:04 -0500
Message-ID: <1339710244-6755-4-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339710244-6755-1-git-send-email-jason.wessel@windriver.com>
References: <1339710244-6755-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v2 3/3] fetch2: Remove mirrortarball check from uri_replace
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
X-List-Received-Date: Thu, 14 Jun 2012 21:54:48 -0000
Content-Type: text/plain

It does not appear as if any additional fetch2 class
uses the mirrortarball.  Future classes can
assign a class instance to mirrorcheck that implements
getbasename() to return mirrortarball.

The git fetch2 class demonstrates how this works.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/fetch2/__init__.py |    2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1bd4ee4..bd51864 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -203,8 +203,6 @@ def uri_replace(ud, uri_find, uri_replace, d):
                     basename = None
                     if ud.mirrorcheck:
                         basename = ud.mirrorcheck.getbasename(ud, result_decoded[0], result_decoded[loc])
-                    elif ud.mirrortarball:
-                        basename = os.path.basename(ud.mirrortarball)
                     elif ud.localpath:
                         basename = os.path.basename(ud.localpath)
                     if basename and result_decoded[loc].endswith("/"):
-- 
1.7.10



