Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id E398C7BEDF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:41 +0000 (UTC)
Received: by mail-it1-f193.google.com with SMTP id k193so7220246ita.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=QiWZsnlEhABwTf6wlJWakE2Z2aHEGMCvZH+dIuROKTY=;
	b=jS21H9uMo5U7spQ74O961VgzcVahhtipKxNghE8A25bnSOPd2XBVRyJyQ5wAL941sX
	jTLtRVhzkHUkJmlG/8+9nolBs1k4ITMoeOrKZYBlKRY9w4nvPoyFgp2hxogGaFcj4ti7
	2ITg3Oedn8SHU9iFQnCB9q7fe8bWxc9hN96ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QiWZsnlEhABwTf6wlJWakE2Z2aHEGMCvZH+dIuROKTY=;
	b=jws5YhzseQfinZjmX2HDX5zLDilbsEz0WpzNhn3zg7s6hLQ2jduGKtXhN64bcqVULv
	ndj0fKRTpUZd3YlKCrPoD+QUomrOph9Lb5LUoMySlcZ3EjtgnkMKlMBat6LERP00HpgX
	DnWFdp4NdGSgqTFbj6+UXADZGHbWv4r4FgF/AD89ed4+V38xIc9zDUgZv0ib2qdGPzxL
	BrrhbaeoR1te75S7ogzAngVH8Yp7OxYnsS3sq9pFn+1OIdNgGSzKxzJ8TcAG41M2j6S+
	nd2arvBDUz4om1rGoRMA0fwEcnein0zmhUZSkU2XadycFVW8ALlBhG4glWzz6H2FnHkC
	JrGA==
X-Gm-Message-State: APjAAAUIwfgJZoK4Lhfy43QffFEYPMupDiY+d+pRrWD32S+hsyy9wNZk
	ovOnEmQeHcQnVp5MqtfzfBvV+mBwFGQ=
X-Google-Smtp-Source: APXvYqySDOJQeBKUt7wJPHoy56otQ6dGFxJAzwm6rfydLKL0neRfXinUThNdAdCXLDfQZZXrVrJ58g==
X-Received: by 2002:a24:5210:: with SMTP id d16mr92404itb.11.1552430562791;
	Tue, 12 Mar 2019 15:42:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.41
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:21 -0400
Message-Id: <20190312224627.12667-5-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 04/10] gitsm.py: Optimize code and attempt to resolve locking issue
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:42 -0000

From: Mark Hatle <mark.hatle@windriver.com>

It was reported that a race condition on a shared download directory could
occur with the gitsm fetcher, the result happened with a call to

  git config

that occured within the update_submodules.  Since the fetch is locked by the
upper level, it was probably the prior need_update(...) function causing this
because of some old code.

The gitsm class inherits the git class.  The need_update was overridding the
version in gitsm, so that it forceably checked the submodules.

It's clear we can optimize the code by only updating if the primary repository
needs updating.  Since we don't care if the submodule repository has changed
because if the primary hasn't, references to the submodule won't change.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 346338667edca1f58ace769ad417548da2b8d981)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index dd94186c..11bfa668 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -148,20 +148,6 @@ class GitSM(Git):
 
         return True
 
-    def need_update(self, ud, d):
-        main_repo_needs_update = Git.need_update(self, ud, d)
-
-        # First check that the main repository has enough history fetched. If it doesn't, then we don't
-        # even have the .gitmodules and gitlinks for the submodules to attempt asking whether the
-        # submodules' histories are recent enough.
-        if main_repo_needs_update:
-            return True
-
-        # Now check that the submodule histories are new enough. The git-submodule command doesn't have
-        # any clean interface for doing this aside from just attempting the checkout (with network
-        # fetched disabled).
-        return not self.update_submodules(ud, d)
-
     def download(self, ud, d):
         Git.download(self, ud, d)
 
-- 
2.17.2


