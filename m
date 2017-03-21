Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 7CA5E7300D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 18:41:14 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id r137so19485782pfr.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mD0VrwXDIZmWNHIsGyTuJoD2WoatXT+4vwN9Z0zYp1Q=;
	b=HRdRJJXhQAugNQ6kaa0waI6briyR0Nt6Cd8YTiMDPX+twYSRg5EVB7RokCARHl73Ql
	ft0aU3FsOKobI7Ynifw7+5jh9I/4bLJYaIb+jklkbclCjEhujPXtBAB8Oa70x9GcZChL
	zfQYMEKDuO61ibaD6S0oqvEA0DO55dt8ADu31gyajG/OzdJDGEAcwbHmqUNhsjj+51WX
	Uc3auTRF4jw3XR+rLBBYViH5GFEopor5KnFc3S+riFbjjf0oph5ZiGmn8KuK+5tTdr9E
	hyoPgcOFpkNJ0AZ/yJN4BWImQR14/x5koUexdhKO0YfWMOQVnypt2FybsgGJLUi4Qr/b
	2WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mD0VrwXDIZmWNHIsGyTuJoD2WoatXT+4vwN9Z0zYp1Q=;
	b=lmkvtryRhCOeVnsSRg9AqYj7UE4oYiPpZPouKrC2NwUmXJ+H8UNNAv7rF0CsdhJzqj
	Ep+8BlT5Yyu9Dx8oTvUjm3kPYcMOUR+/KMSS/+OmKU7Y4thMhEPXPynaG+Qnz58hX6nQ
	kAO4+SkYIu7H6p+m4sgLlmkBL2urjws4oUiZPUuem5Q1kBRUQr0+p66ugjc0mVtTjoGc
	ZcOBtXZUprdHZM1hSSlDstpzqXCk8rnaked6CCcFsoSK7inboRngsxjEsiZHxiNckEZh
	6J0w18ez57aKWVx5cYJzjhbVMBZCD4y+Tk0kDlCv1AvCj5k6kkKF7VhOccBAK+BN7N4i
	HHOw==
X-Gm-Message-State: AFeK/H0AVA62TQZKDpO0sXCOvgYrBpA0fn+LkFWye8x2AJIdctc7xAWeCXm2ig0Yv1p1MA==
X-Received: by 10.98.13.197 with SMTP id 66mr41735368pfn.91.1490121675746;
	Tue, 21 Mar 2017 11:41:15 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z19sm25324304pfd.81.2017.03.21.11.41.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 21 Mar 2017 11:41:14 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Mar 2017 11:41:03 -0700
Message-Id: <c8733f4f6e7c4a65c1a077fab8b708e3b09f8f24.1490121529.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1490121529.git.chris_larson@mentor.com>
References: <cover.1490121529.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 3/4] fetch/git: drop pointless os.path.join, workdir=
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
X-List-Received-Date: Tue, 21 Mar 2017 18:41:14 -0000

From: Christopher Larson <chris_larson@mentor.com>

The touch of .done explicitly specifies the path, so there's no need for
workdir=, and "os.path.join('.')" is identical to just '.'.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e1e8765..e420232 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -291,8 +291,8 @@ class Git(FetchMethod):
                 os.unlink(ud.fullmirror)
 
             logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d, workdir=ud.clonedir)
-            runfetchcmd("touch %s.done" % ud.fullmirror, d, workdir=ud.clonedir)
+            runfetchcmd("tar -czf %s ." % ud.fullmirror, d, workdir=ud.clonedir)
+            runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
     def unpack(self, ud, destdir, d):
         """ unpack the downloaded src to destdir"""
-- 
2.8.0


