Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqP-0007wt-A8
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:17 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHJNl007991 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:19 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YoaKgDQ4ppI5 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:19 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHHdD007985
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:18 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLf1-0002SX-4o
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:31 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:12:55 +0100
Message-Id: <86517af9e066c2da1d580fa66b7c7f0340f3403e.1340200207.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 04/14] fetch2: Ensure when downloading we are consistently in the same directory
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
X-List-Received-Date: Wed, 20 Jun 2012 14:27:30 -0000

This assists with build reproducuility. It also avoids errors if cwd
happens not to exist when we call into the fetcher. That situation
would be unusual but I hit it with the unit tests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 2eeec3d..b09753f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -486,6 +486,8 @@ def try_mirrors(d, origud, mirrors, check = False):
             ud = FetchData(newuri, ld)
             ud.setup_localpath(ld)
 
+            os.chdir(ld.getVar("DL_DIR", True))
+
             if check:
                 found = ud.method.checkstatus(newuri, ud, ld)
                 if found:
@@ -1094,6 +1096,8 @@ class Fetch(object):
                 if premirroronly:
                     self.d.setVar("BB_NO_NETWORK", "1")
 
+                os.chdir(self.d.getVar("DL_DIR", True))
+
                 firsterr = None
                 if not localpath and ((not os.path.exists(ud.donestamp)) or m.need_update(u, ud, self.d)):
                     try:
@@ -1155,7 +1159,7 @@ class Fetch(object):
                 except:
                     # Finally, try checking uri, u, from MIRRORS
                     mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
-                    ret = try_mirrors (self.d, ud, mirrors, True)
+                    ret = try_mirrors(self.d, ud, mirrors, True)
 
             if not ret:
                 raise FetchError("URL %s doesn't work" % u, u)
-- 
1.7.5.4



