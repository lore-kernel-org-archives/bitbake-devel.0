Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id 3B9FA7300D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 18:41:15 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id p189so17764125pfp.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rB2vWAG/hnpyM9M0KkFJ8R8IL53BFSHo8ClcLR2uBV4=;
	b=YKGlzzOPfNmx7xQDUonQ3a2UAiaN71eN63sbbzfYBdqTKgL00HvTr5gxeFvt2wWd7/
	TgEXU1R8haKLkSQuNIw8CRu99UcjLRINPbzOB/7su010fs1WTbPXH/IQCf6q1MF2aCWM
	7dk/7TFs01s2fE5R/B3+qJgYzhwNOg5rwAgCUAKc6bSnA345HTqaNHTZUDeN/kk5lh5X
	7t6tl7uXE4eoULC1gHxAWy2Vos7Qd1gENTTjZCfUaRp3xPRbUh74s5cf9tAHkI0Ziv2D
	R3/CcNl1pnQiERQE257WEq0XHLouD62XVq53GRJoYOISlHPbOxx96pokhLWeEqYSi7BR
	/8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=rB2vWAG/hnpyM9M0KkFJ8R8IL53BFSHo8ClcLR2uBV4=;
	b=NBo6dXC1E+9Xrk7aRK+F8cgWdekxgiEzbtn0KRltZGO8SnpmLvU8KfkmrfwCrBjo0r
	tYqgOv3XW1Rucbf24YE8lBWBd7HlOuhXkvLgzxpWcIev3gG2GQSvgUbKD7ITwc8RmXkD
	SWNLli/riSNXG+VipSwYVxannqeHj5L4moCYdmuNbpz6rKKj6pOTcORcSVt1Q+mNvT6H
	bStFIrBnQ6hoJH0NJ08ggiydb87EUtgcFqTYFgQDeCapMx6fTj0CZg2kwPmVFTQI6mst
	Sy7x/xk1kmBo2iHilAUpBlCDunereZDFU3jiQ8lIL9I8qGTro1rod+2OowLoblBd2NGZ
	sEdg==
X-Gm-Message-State: AFeK/H0igEC2QSMuDGoYWnNnENpSrnn0GPrAqeDjadIXt0yrWpaendl0GjuGD/G4XqecoA==
X-Received: by 10.98.15.145 with SMTP id 17mr30311247pfp.183.1490121677454;
	Tue, 21 Mar 2017 11:41:17 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	z19sm25324304pfd.81.2017.03.21.11.41.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 21 Mar 2017 11:41:16 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Mar 2017 11:41:04 -0700
Message-Id: <0f71517b5208e117133b67fe728d482e7a575f35.1490121529.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1490121529.git.chris_larson@mentor.com>
References: <cover.1490121529.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 4/4] fetch/git: fix FetchError reference
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
X-List-Received-Date: Tue, 21 Mar 2017 18:41:16 -0000

From: Christopher Larson <chris_larson@mentor.com>

FetchError isn't defined, use bb.fetch2.FetchError in this context.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e420232..a8be859 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -484,5 +484,5 @@ class Git(FetchMethod):
         try:
             self._lsremote(ud, d, "")
             return True
-        except FetchError:
+        except bb.fetch2.FetchError:
             return False
-- 
2.8.0


