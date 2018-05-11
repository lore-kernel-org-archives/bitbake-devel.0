Return-Path: <matt.hoosier@gmail.com>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
	[209.85.214.68])
	by mail.openembedded.org (Postfix) with ESMTP id 7A51176034
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 13:53:48 +0000 (UTC)
Received: by mail-it0-f68.google.com with SMTP id c5-v6so2076184itj.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 May 2018 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=IqZc83wSuv4b0ouyY5RrQq01ANi5mYjl5s2I+2qa834=;
	b=EoIZSyPITb0vY9ZAchQSbxYdn0x4vZHfJjwS/V1sntjvhAg/Ft1UxyNz1yxuj2Dpvl
	GQ95vYGhXVNZ+w5bCvI5H3s0XrWstYm567krn6dprVMzSk4gDa4lRVtG7HMgSvAPYtzS
	9ZGS0LciOaGbnD2pwhu49bmZaB/OwalEnNENO/HNUqtqDtQJBo6bde1cD2bp18imYPr3
	3xRKXoMWoFluW6KVPTwTdydjTQrkWDN+MJ+swSYg4YHYyvfF0z3nVFG11dhowd/mNKV0
	3r31jdjHbCSY6Fg62a3SAmmspM8I8kEEPAGAHBUpzkM6glO1oQoTiCW7H31Zd1rH+inQ
	ll2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=IqZc83wSuv4b0ouyY5RrQq01ANi5mYjl5s2I+2qa834=;
	b=VNEisgHP8lYrjcg3MYXVv+P9++169mjlP+5FEL0THPPsrw+GCfPYa9RHsjVosUipad
	tugSwEbSWgnvhm4AHybnjhjLnpVtgSC/krjw54Ll4+ycyxeHzxpwCOK4Q4MwE1WGRDPQ
	3RpT8YNdeHEAyXlyKLqStt8SuRc8ijjSyFLJzH8gilka71X2DxeTTEs/INkBO77OWvs/
	6Qe2CH3CKV8kTYlatqzl0CN8vm+x6dVRbXlcbYAV1TkjCngSLxiD43Jr6u4ubPFuhmKo
	t7XruXGViwRHOED77s5xhxUWqgLqt7rmmd0Dg50uKNXKH0zg6ZG9tlFmaDG8qbU1r1Gk
	yirQ==
X-Gm-Message-State: ALKqPwfIYvlywylAcHK0TGJYc+K0a0OzljJ3AEkZ0SN3E44VK1Devp9V
	LkjXGVNyhC2tQztyLZq8Almqug3d
X-Google-Smtp-Source: AB8JxZo1Zb+RPL8RkrYtkgtMNm/pa3JYOJwKQ+wRbHPUJzqZWh0k1P0HeCcRhhdFDmjF2KDh4Fo0RQ==
X-Received: by 2002:a24:45a4:: with SMTP id
	c36-v6mr3378488itd.18.1526046829766; 
	Fri, 11 May 2018 06:53:49 -0700 (PDT)
Received: from localhost.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	m11-v6sm1706646ioo.60.2018.05.11.06.53.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 11 May 2018 06:53:48 -0700 (PDT)
From: Matt Hoosier <matt.hoosier@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 May 2018 08:53:46 -0500
Message-Id: <20180511135346.3476-1-matt.hoosier@gmail.com>
X-Mailer: git-send-email 2.13.6
Subject: [PATCH] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Fri, 11 May 2018 13:53:49 -0000

Although the submodules' histories have been fetched during the
do_fetch() phase, the mechanics used to clone the workdir copy
of the repo haven't been transferring the actual .git/modules
directory from the repo fetched into downloads/ during the
fetch task.

Fix that, and for good measure also explicitly tell Git to avoid
hitting the network during do_unpack() of the submodules.

Rev2 changes:

- Fixed a failure when unpacking a shallow cloned mirror repository.

[YOCTO #12739]

Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0aff1008..1f3fc443 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -132,4 +132,14 @@ class GitSM(Git):
 
         if self.uses_submodules(ud, d, ud.destdir):
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
-            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
+
+            # Copy over the submodules' fetched histories too.
+            if ud.bareclone:
+                repo_conf = ud.destdir
+            else:
+                repo_conf = os.path.join(ud.destdir, '.git')
+            runfetchcmd("cp -pr %s %s" % (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
+
+            # Careful not to hit the network during unpacking; all history should already
+            # be fetched.
+            runfetchcmd(ud.basecmd + " submodule update --init --recursive --no-fetch", d, workdir=ud.destdir)
-- 
2.13.6


