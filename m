Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdF-0004b6-HS
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:41 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhBAI015529
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:11 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:11 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:42 -0500
Message-ID: <1339162913-23759-8-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 07/18] fetch2/git.py: Use local download dir, when using an external read-only GITDIR
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:41 -0000
Content-Type: text/plain

When building the yocto kernel or yocto kernel tools, if the GITDIR is
on a read-only server that is shared and updated by via some cron
jobs, the fetch2 should not try to write to that area.  The end result
will be odd failures if you have download turned off, or extra
needless downloading if you have download turned on.

The fetch2 should prefer to create mirror the mirror clones in the
local "downloads" directory in the work space.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/fetch2/git.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index bcc0da5..59d95cb 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -136,8 +136,11 @@ class Git(FetchMethod):
                 gitsrcname = gitsrcname + '_' + ud.revisions[name]
         ud.mirrortarball = 'git2_%s.tar.gz' % (gitsrcname)
         ud.fullmirror = os.path.join(data.getVar("DL_DIR", d, True), ud.mirrortarball)
-        ud.clonedir = os.path.join(data.expand('${GITDIR}', d), gitsrcname)
+        ud.gitdir = os.path.join(data.expand('${GITDIR}', d), gitsrcname)
+        ud.clonedir = os.path.join(data.getVar("DL_DIR", d, True), gitsrcname)
 
+        if os.path.exists(ud.gitdir):
+            ud.clonedir = ud.gitdir
         ud.localfile = ud.clonedir
 
     def localpath(self, url, ud, d):
-- 
1.7.10



