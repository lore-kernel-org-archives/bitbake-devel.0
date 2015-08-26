Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 22F6776E04
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:26 +0000 (UTC)
Received: by pabzx8 with SMTP id zx8so75121753pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WNIgIV2u3Wf0X9ikg40Mn+cuOLrlDAjti62zfyRmi5g=;
	b=EPtJyQGWbjN3SenqWMM9dTIttLwYmXGsCQXBvtfC98W0NR7vDh1A2A4ccCR5qc1iDN
	COgYz6VOdhrsytuBnX0aITq7tjZU7dL+wkINf8+KLCevZftinyMDmza7BLukqRjYXCg9
	LIOytIBYY1g0KbbbIBXTrk275XgsfFoHkJh8wWIc9XzlfS/L3v6XjlHX8oZi2cthLo4X
	1QpJwqOzSmDtnX6QDJnRuLBffbJQ0+mL/kuStJMn466DTdHGsIkSsV3YFUhmIq+h/F0t
	3BhPY5KMauIX8H5wYDIn16Lt/2xhtpjYk2ClcfEG4a8BA+YjhSk/BRXG9KbHIBhw6jWJ
	fclA==
X-Received: by 10.68.135.161 with SMTP id pt1mr70844674pbb.47.1440607047037;
	Wed, 26 Aug 2015 09:37:27 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	qe3sm25214673pbc.73.2015.08.26.09.37.25
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:26 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:38:08 -0700
Message-Id: <1440607088-14563-5-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
References: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 4/4] bb.fetch.git: truncate branches to SRCREV
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:27 -0000

From: Christopher Larson <chris_larson@mentor.com>

This removes the commits after SRCREV up to the branch HEAD, as they aren't
needed for us, and just increase the size of the tarball. The user can always
`git fetch` to pull down those commits. Repack/prune the repository before
archiving it to ensure those commits are physically removed.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 99cc508..3be32f2 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -288,6 +288,10 @@ class Git(FetchMethod):
         runfetchcmd("%s remote add origin %s" % (gitcmd, source), d)
         for name, (shallow, revision, branch) in branchinfo.iteritems():
             runfetchcmd("%s fetch -a origin %s" % (gitcmd, branch), d)
+            runfetchcmd("%s update-ref refs/remotes/origin/%s %s" % (gitcmd, branch, revision), d)
+        runfetchcmd("%s repack -Ad" % gitcmd, d)
+        runfetchcmd("%s prune --expire now" % gitcmd, d)
+        runfetchcmd("%s pack-redundant --all | xargs -r rm" % gitcmd, d)
         runfetchcmd("%s remote set-url origin %s" % (gitcmd, repourl), d)
 
     def build_mirror_data(self, ud, d):
-- 
2.2.1


