Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 38C1A75D4F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 23:46:43 +0000 (UTC)
Received: by paccq16 with SMTP id cq16so3612624pac.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=x1dLB8JiV/tNcDhGrZOErwXafav0pQjvA3I8D9/CbgM=;
	b=M1yZWVGJOBqZLgBLMw4oaQv3vYhqPQhApqEkvXPB9skTebPeK9eEW4NnlZPtpY4WPR
	sOTjEfaMJe+DyqpYLR4qFPoob3hnc9hZZRfZ1DbB7BxIkUKt1i+G5QiPnipi32GdlEo3
	QHjz+hVc7SwiUmj/hPRF85kz9e0LQwvU4h9OD5xmcNrMw5oNe8U41JaURKMRHeT1sMPe
	315+RZV2YzPLM1eQEesqTjDw/Ptya8lo0E0dGg0f/PyooMX+3Y6pLB7b6t2zdmkQlRm1
	aLqibV75PV8hoIiWsiNYYcbxczFNYZkXXkFaq+kBHU7C/mapYGfDogkGDbn5ua4goX2E
	e/pA==
X-Received: by 10.68.69.108 with SMTP id d12mr83483114pbu.24.1439509604191;
	Thu, 13 Aug 2015 16:46:44 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i10sm3883933pdr.78.2015.08.13.16.46.43
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Aug 2015 16:46:43 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Aug 2015 16:46:36 -0700
Message-Id: <80488eab91bb07e2b5bcd5b27125cae1c8df8a04.1439509247.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
Subject: [RFC PATCH 2/5] bb.fetch.git: truncate branches to SRCREV
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
X-List-Received-Date: Thu, 13 Aug 2015 23:46:44 -0000

From: Christopher Larson <chris_larson@mentor.com>

Rather than keeping the commits between SRCREV and the branch HEAD, point the
remote branch at the SRCREV, so no commits after SRCREV are kept. If the user
needs them, a git fetch will pull them down.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e88736d..c19b111 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -299,6 +299,11 @@ class Git(FetchMethod):
                     runfetchcmd("%s remote add origin %s" % (ud.basecmd, ud.clonedir), d)
                     for name, branch in ud.branches.iteritems():
                         runfetchcmd("%s fetch -a origin %s" % (ud.basecmd, branch), d)
+                        runfetchcmd("%s update-ref refs/remotes/origin/%s %s" % (ud.basecmd, branch, ud.revisions[name]), d)
+                    runfetchcmd("%s gc --prune" % ud.basecmd, d)
+                    runfetchcmd("%s prune-packed" % ud.basecmd, d)
+                    runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
+
                     repourl = self._get_repo_url(ud)
                     runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d)
                     logger.info("Creating ud.fullmirror of git repository")
-- 
2.2.1


