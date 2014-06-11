Return-Path: <Wenlin.Kang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 935E16FB90
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Jun 2014 02:56:29 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s5B2uTk2017257
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jun 2014 19:56:29 -0700 (PDT)
Received: from PEK-WKANG-D1.corp.ad.wrs.com (128.224.162.182) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.169.1; Tue, 10 Jun 2014 19:56:29 -0700
From: Wenlin Kang <wenlin.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 Jun 2014 10:55:40 +0800
Message-ID: <1402455340-29531-2-git-send-email-wenlin.kang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1402455340-29531-1-git-send-email-wenlin.kang@windriver.com>
References: <1402455340-29531-1-git-send-email-wenlin.kang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH] fetch2/svn.py: fix Unable to fetch URL bug
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
X-List-Received-Date: Wed, 11 Jun 2014 02:56:33 -0000
Content-Type: text/plain

For svn source, when download a revsion on branches, if the download
revsion < the branch created time revsion, then it will fail.

The detail description reference the Yocto Project bugzilla, please see:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=6258

Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 lib/bb/fetch2/svn.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 8847461..75e21df 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -98,7 +98,8 @@ class Svn(FetchMethod):
             suffix = ""
             if ud.revision:
                 options.append("-r %s" % ud.revision)
-                suffix = "@%s" % (ud.revision)
+                #follow this line can make the fetch fail when download a revsion on branches if the download revsion < the branch created time revsion.
+                #suffix = "@%s" % (ud.revision)
 
             if command == "fetch":
                 svncmd = "%s co %s %s://%s/%s%s %s" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module, suffix, ud.module)
-- 
1.7.9.5


