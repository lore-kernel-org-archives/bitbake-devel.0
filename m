Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jeff.polk@windriver.com>) id 1SQK8i-0001Qp-AJ
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 17:09:48 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q44E5G5J009439
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 07:05:16 -0700 (PDT)
Received: from delos.DELOS.COM (172.25.35.98) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 4 May 2012 07:05:16 -0700
From: Jeff Polk <jeff.polk@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 4 May 2012 08:05:14 -0600
Message-ID: <1336140315-5171-1-git-send-email-jeff.polk@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
Subject: [PATCH 1/2] fetch2/git: Allow file:// URLs without checking for network access
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
X-List-Received-Date: Fri, 04 May 2012 15:09:48 -0000
Content-Type: text/plain

Don't check for network access before grabbing the the current head,
cloning, or updating a clone when the protocol is 'file'.

Signed-off-by: Jeff Polk <jeff.polk@windriver.com>
---
 lib/bb/fetch2/git.py |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 61fdc4b..bcc0da5 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -184,7 +184,8 @@ class Git(FetchMethod):
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
             clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
-            bb.fetch2.check_network_access(d, clone_cmd)
+            if ud.proto.lower() != 'file':
+                bb.fetch2.check_network_access(d, clone_cmd)
             runfetchcmd(clone_cmd, d)
 
         os.chdir(ud.clonedir)
@@ -202,7 +203,8 @@ class Git(FetchMethod):
 
             runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d)
             fetch_cmd = "%s fetch -f --prune %s refs/*:refs/*" % (ud.basecmd, repourl)
-            bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
+            if ud.proto.lower() != 'file':
+                bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             runfetchcmd(fetch_cmd, d)
             runfetchcmd("%s prune-packed" % ud.basecmd, d)
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
@@ -281,7 +283,8 @@ class Git(FetchMethod):
         basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
         cmd = "%s ls-remote %s://%s%s%s %s" % \
               (basecmd, ud.proto, username, ud.host, ud.path, ud.branches[name])
-        bb.fetch2.check_network_access(d, cmd)
+        if ud.proto.lower() != 'file':
+            bb.fetch2.check_network_access(d, cmd)
         output = runfetchcmd(cmd, d, True)
         if not output:
             raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, url)
-- 
1.7.5.4



