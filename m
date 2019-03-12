Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f174.google.com (mail-it1-f174.google.com
	[209.85.166.174])
	by mail.openembedded.org (Postfix) with ESMTP id B41837C6A3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:40 +0000 (UTC)
Received: by mail-it1-f174.google.com with SMTP id z131so7173513itf.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=nYzdgJmOP8mAfnu9ClC3yMq58iMMVQpdSPpJiDYiG80=;
	b=bPvTaEfb3V7AwlGjyOQ8zkNii4vjjM27pLjGa2RvavtEpJVfLc/C+SnqZ2GJc+qpkt
	xjP5D6GyzLWq+HXzk2Vju/srL8uoGZ5JC3426htj/IWUe9Udk4zn1Z0CAPc3U0C3yGyr
	PLYi1hBZURmptptIkzsUcDbRAfkXVebQeKO90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=nYzdgJmOP8mAfnu9ClC3yMq58iMMVQpdSPpJiDYiG80=;
	b=edBoA0ROXvjRR1QV7l/SNVnZaDIT7ZXyzMRiQku09fQ8sQXqDfAF8kgi9PeXCQdMv6
	DpwCkfM1XIfBpmnib442fvL38nCYskepUVWZmCWaOVWhItPySHcwc02/3iYNFH118XkK
	04xLO9bJmmL8JjF1LOG/wQ/xr1pTJ3Ak7G/Eh3ojXc1DzqXtH3io4ij5kr36TeKZ+SHG
	ja/7ycSYeHENt7vPMzzAf+KR5tivpz/3J45PKLPad4TGBbIIyE1nrmkCfbfGUIuMztx2
	fwO3z95J1l8rLkB+QFXQB3hz/gmqWFYtb/cTJueIWD3HtnjjfmX7yYlxHw0ieRdEczUD
	gUUw==
X-Gm-Message-State: APjAAAU/lrnDhz5T/THawwFWX7Q0t0qgsj2ADN1P0sYwmv5aHkp473EJ
	cFMyX32qWkXMbuhSWN53wu3ISGwBzT8=
X-Google-Smtp-Source: APXvYqxf70EIOsAFKO7Eo5yTYG5RFImaDN/pB7wQdsFCY+204wV6Jw3y/FZx9Zp2RK8xh7X6ZT2w1A==
X-Received: by 2002:a02:c908:: with SMTP id t8mr14313743jao.59.1552430561644; 
	Tue, 12 Mar 2019 15:42:41 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:41 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:20 -0400
Message-Id: <20190312224627.12667-4-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 03/10] tests/fetch.py: Add alternative gitsm test case
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:41 -0000

From: Mark Hatle <mark.hatle@windriver.com>

In order to test the ssh processing in gitsm, we add an alternative
testcase that can be downloaded from git.yoctoproject.org.  However,
this test case requries (read) access, via ssh, to git.yoctoproject.org.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c8554cdc1287620fe8e8960561e614567879a010)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/tests/fetch.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6848095c..311c7013 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -893,7 +893,11 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule(self):
-        fetcher = bb.fetch.Fetch(["gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"], self.d)
+        # URL with ssh submodules
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=0d3ffc14bce95e8b3a21a0a67bfe4c4a96ba6350"
+        # Original URL (comment this if you have ssh access to git.yoctoproject.org)
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"
+        fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
-- 
2.17.2


