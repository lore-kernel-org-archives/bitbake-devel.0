Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id F2F0C7A286
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Oct 2018 07:49:36 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w917ncBT023459
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 1 Oct 2018 00:49:38 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 1 Oct 2018 00:49:37 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 1 Oct 2018 00:45:57 -0700
Message-ID: <c294eb97588c62ed7fb31cfff67efb8569c74746.1538379577.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1538379577.git.David.Reyna@windriver.com>
References: <cover.1538379577.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 3/3] toaster: disable git remote check to allow for firewalls
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
X-List-Received-Date: Mon, 01 Oct 2018 07:49:37 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster users behind firewalls that block "git" access usually
require developers to add remap rules in their "~/.gitconfig"
to remap GIT accesses to HTTP* access. However, there is a
"git remote" test in Toaster that is not aware of such remaps,
resulting in a false error.

For now, disable this nice-to-have check to support this release,
and re-enable when we can add remapping accommodations for this
test.

[YOCTO #12944]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 67bfbf6..9490635 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -177,8 +177,11 @@ class LocalhostBEController(BuildEnvironmentController):
                 try:
                     localremotes = self._shellcmd("git remote -v",
                                                   localdirname,env=git_env)
-                    if not giturl in localremotes and commit != 'HEAD':
-                        raise BuildSetupException("Existing git repository at %s, but with different remotes ('%s', expected '%s'). Toaster will not continue out of fear of damaging something." % (localdirname, ", ".join(localremotes.split("\n")), giturl))
+                    # NOTE: this nice-to-have check breaks when using git remaping to get past firewall
+                    #       Re-enable later with .gitconfig remapping checks
+                    #if not giturl in localremotes and commit != 'HEAD':
+                    #    raise BuildSetupException("Existing git repository at %s, but with different remotes ('%s', expected '%s'). Toaster will not continue out of fear of damaging something." % (localdirname, ", ".join(localremotes.split("\n")), giturl))
+                    pass
                 except ShellCmdException:
                     # our localdirname might not be a git repository
                     #- that's fine
-- 
1.9.1


