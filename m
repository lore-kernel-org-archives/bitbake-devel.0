Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id 3D98A731B9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:42:51 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7F0AB101CD4;
	Mon, 22 Aug 2016 15:42:50 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-220-3-24.us-west-2.compute.internal [10.220.3.24])
	by relay.mailchannels.net (Postfix) with ESMTPA id C91571029A9;
	Mon, 22 Aug 2016 15:42:49 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.45.13.172])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:50 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880570130:1919892960
X-MC-Ingress-Time: 1471880570130
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrNA-0002ZA-J1; Mon, 22 Aug 2016 11:42:48 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:36 +0100
Message-Id: <1471880556-9232-9-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 9/9] toaster: localhostbecontroller Remove git assumption
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
X-List-Received-Date: Mon, 22 Aug 2016 15:42:53 -0000

From: Michael Wood <michael.g.wood@intel.com>

We don't need to force everyone to use git for the method in which
openembedded-core is downloaded. For instance it could have been
downloaded and extracted as a tarball.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index fbc5ee9..39de6dd 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -151,11 +151,17 @@ class LocalhostBEController(BuildEnvironmentController):
             localdirname = os.path.join(self.be.sourcedir, self.getGitCloneDirectory(giturl, commit))
             logger.debug("localhostbecontroller: giturl %s:%s checking out in current directory %s" % (giturl, commit, localdirname))
 
-            # make sure our directory is a git repository
+            # see if our directory is a git repository
             if os.path.exists(localdirname):
-                localremotes = self._shellcmd("git remote -v", localdirname)
-                if not giturl in localremotes:
-                    raise BuildSetupException("Existing git repository at %s, but with different remotes ('%s', expected '%s'). Toaster will not continue out of fear of damaging something." % (localdirname, ", ".join(localremotes.split("\n")), giturl))
+                try:
+                    localremotes = self._shellcmd("git remote -v",
+                                                  localdirname)
+                    if not giturl in localremotes:
+                        raise BuildSetupException("Existing git repository at %s, but with different remotes ('%s', expected '%s'). Toaster will not continue out of fear of damaging something." % (localdirname, ", ".join(localremotes.split("\n")), giturl))
+                except ShellCmdException:
+                    # our localdirname might not be a git repository
+                    #- that's fine
+                    pass
             else:
                 if giturl in cached_layers:
                     logger.debug("localhostbecontroller git-copying %s to %s" % (cached_layers[giturl], localdirname))
-- 
2.7.4


