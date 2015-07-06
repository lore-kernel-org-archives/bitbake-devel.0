Return-Path: <eu@felipetonello.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 49E6275D89
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jul 2015 16:05:50 +0000 (UTC)
Received: by wiga1 with SMTP id a1so233201105wig.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 06 Jul 2015 09:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=V2iLYwYqU2fDQiLrXORVeIye9AVouD2c8LI7a5FQXLc=;
	b=k6NTwghxeP3XJF/k/jI7R7tRgBEumSrFJ84/HTjmAhpdwCyvup3q64dDRh4wUAgDMF
	6jeNExH4daSZXu5yLPaIKiHaW8rpBI8phxWB1wGP6vyh3eHZ41ITI9pYqwadSECkVzCM
	G7wn/05bs7C6fv9uSsSLJ13YwwKM7lCjgSt/Eh5OmmfBV3mRoAaiZI9sKwlHxREh2iJf
	1oIOT7wivl8VZqGP/9yLnr4qTXLkFQfZqSMKDH+WY/Mj15eXZ3tnamLxF8aPnPXzSLDN
	+2A7LSDGeru4amwcN9jNQ2/70Bkr6mq6emjp6nWX5FwHyNBFw5tiLvdU0HBqw0JbmDI7
	K0Yw==
X-Gm-Message-State: ALoCoQlRhYZJOwUqWqT4aWg4hh7LxXk0PSh3jfdf9tayvVMF4mLXi6pnWjqCTLjgFmBRXreHRC0N
X-Received: by 10.180.83.137 with SMTP id q9mr96991118wiy.68.1436198750826;
	Mon, 06 Jul 2015 09:05:50 -0700 (PDT)
Received: from felipe-fedora.localdomain ([81.145.202.106])
	by mx.google.com with ESMTPSA id
	ju2sm29351745wid.12.2015.07.06.09.05.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 Jul 2015 09:05:49 -0700 (PDT)
From: eu@felipetonello.com
To: bitbake-devel@lists.openembedded.org
Date: Mon,  6 Jul 2015 17:05:43 +0100
Message-Id: <1436198743-29337-1-git-send-email-eu@felipetonello.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH] fetch2: Checkout to correct ref begore init and update submodules
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
X-List-Received-Date: Mon, 06 Jul 2015 16:05:51 -0000

From: "Felipe F. Tonello" <eu@felipetonello.com>

This is nessary when specified branch with submodules is different then
default (master) branch.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 lib/bb/fetch2/gitsm.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c125cff..0392e48 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -109,6 +109,7 @@ class GitSM(Git):
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare = false/'", d)
         os.chdir(tmpclonedir)
         runfetchcmd(ud.basecmd + " reset --hard", d)
+        runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d)
         runfetchcmd(ud.basecmd + " submodule init", d)
         runfetchcmd(ud.basecmd + " submodule update", d)
         self._set_relative_paths(tmpclonedir)
-- 
2.1.0


