Return-Path: <matt.hoosier@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail.openembedded.org (Postfix) with ESMTP id AFBF77874D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 18:50:56 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id q72-v6so13590580itc.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=bnL3n/nTgBiRrULRUNUNNBZzVQjAnOk83KNkR2QjHZ4=;
	b=JXYXpBZ3dZ+rKVd1obGEdvV1L1T7EcHAKfaUe0MIbKfhFXXt+81vVdeAqbiJLD4qlO
	BWgpP/uIPEEIhDWCu//SjXsNiMal1oiSYuAOZfuLCKA8FXtYZ2sNnGDTj3yd+seEt+Au
	LxkI1Lpsn6i6615hV3+jyWVC/nay7M12JtPPZZKYmhoqKdPtuIEZG6vfnDhdU+U8m9Lv
	kE0JnvafB5Z39g83ajl6bDmfvqSsVHtt5Par6PWhaZnSE7yVs4WZgzAV8QTgjWAF3AqI
	7ie9Xy2OkXdS4+NWmy+dU+hqHR0YgrYTud7Phx9QcQRoj6qOrZ16JZwd1+Ms2xUlcG25
	JqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=bnL3n/nTgBiRrULRUNUNNBZzVQjAnOk83KNkR2QjHZ4=;
	b=TbPkmQzBhh/9l0W/gJCct3lXpAndBW9SHDoYti1rrDtE861fJcbq/cte1K1rN0d+4l
	r6mWOZBTT/TYk4YgQl+PhtXmcYIGG5FutG4HyW4Z2aCZKisUXHZzC3qS+w2R+bu5WIWT
	dYCWv5t8/W/m0w4EX0y+Dt5cqXyll1hqIFbDtJsxx6UfzU/yUXy7DOnBOrz0bLYc47qS
	Y/Dqp49qkmcgAR6aOSx5ifrkEeM9AGIUNlCEP0uxZwnMMRGOshCybVALce5OK+228kTl
	rHMcQpP/R/dAzvzyXqoPg1kLSik++moyB+7nhA/bBZOQRpiiRv0YSzIfY3RGtTzWNiwM
	RLiw==
X-Gm-Message-State: ALKqPwcPReEpL3hnlIFvCYrrycHrGyfQqS6ilMQZA8/A8TQbH5Rx3/RM
	0O4JGP8gWYnzk0n22KLnLkW3QRzw
X-Google-Smtp-Source: AB8JxZrlKu1H4dNSRe1mTADq0kuGnhOhCuX1qK2mSyNXF51tzmxO1ANcHrrdE6YFo3MX3oGHMwjZfw==
X-Received: by 2002:a6b:98ca:: with SMTP id
	a193-v6mr12577714ioe.254.1526323857177; 
	Mon, 14 May 2018 11:50:57 -0700 (PDT)
Received: from localhost.localdomain ([136.63.212.18])
	by smtp.gmail.com with ESMTPSA id
	a78-v6sm4495005itc.1.2018.05.14.11.50.56
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 14 May 2018 11:50:56 -0700 (PDT)
From: Matt Hoosier <matt.hoosier@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 May 2018 13:50:36 -0500
Message-Id: <20180514185036.104469-1-matt.hoosier@gmail.com>
X-Mailer: git-send-email 2.13.6
Subject: [PATCH v4] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Mon, 14 May 2018 18:50:56 -0000

Although the submodules' histories have been fetched during the
do_fetch() phase, the mechanics used to clone the workdir copy
of the repo haven't been transferring the actual .git/modules
directory from the repo fetched into downloads/ during the
fetch task.

Fix that, and for good measure also explicitly tell Git to avoid
hitting the network during do_unpack() of the submodules.

[YOCTO #12739]

Signed-off-by: Matt Hoosier <matt.hoosier@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 0aff1008..c5019e98 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -132,4 +132,30 @@ class GitSM(Git):
 
         if self.uses_submodules(ud, d, ud.destdir):
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
-            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
+
+            updateflags = ""
+
+            # Copy over the submodules' fetched histories too.
+            if ud.bareclone:
+                repo_conf = ud.destdir
+            else:
+                repo_conf = os.path.join(ud.destdir, '.git')
+
+            if os.path.exists(ud.clonedir):
+                # This is not a copy unpacked from a shallow mirror clone. So
+                # the manual intervention to populate the .git/modules done
+                # in clone_shallow_local() won't have been done yet.
+                runfetchcmd("cp -fpPRH %s %s" % (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
+                updateflags += " --no-fetch"
+            elif os.path.exists(os.path.join(repo_conf, 'modules')):
+                # Unpacked from a shallow mirror clone. Manual population of
+                # .git/modules is already done.
+                updateflags += " --no-fetch"
+            else:
+                # This isn't fatal; git-submodule will just fetch it
+                # during do_unpack().
+                bb.error("submodule history not retrieved during do_fetch()")
+
+            # Careful not to hit the network during unpacking; all history should already
+            # be fetched.
+            runfetchcmd(ud.basecmd + " submodule update --init --recursive %s" % updateflags, d, workdir=ud.destdir)
-- 
2.13.6


