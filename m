Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
	[209.85.214.178])
	by mail.openembedded.org (Postfix) with ESMTP id 526677FC05
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:35 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id c23so19660765plz.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=LiWJLKqi9pFegSoVEfTeD4wh9oClWOTDZXocYAp3wXU=;
	b=j1awQP2M/vFSUeZNOkM05UW/XL/VD8p83CcgXnieHS7/axHeSwF7aCX6Kokmp1iSKl
	KcXRDfKIjHB/axzGWxVu5eTU8idYX+wMkQ+8zpdTn0PFmpj9lzUnSqixGKrYvw7gqOSq
	XqG7DMb7eSEg63fxX2jlDurGyx8J5v864/PGNz5peXkpBY4LqiE2kHkh1iuKptMfDaYD
	JAMMo+EwP5wy2f7HyzLXOy18xkXpM3XMDsAZS3P2dzO/nGW2DoLNGT+czxcYirijEYcB
	Xr5dFgm8mdZtMnqxntTgy7SZ7E7goq4x9hpMZFLZkdxX0j0fryal2Udnhss1Bo2djihI
	u/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=LiWJLKqi9pFegSoVEfTeD4wh9oClWOTDZXocYAp3wXU=;
	b=ULNfirtsqPxUbh8x0ZrEF1cNMC5Da93r3UXreZe27nPCiV1/BHNwZ7kE8QRTU5yyXH
	AUzfYowfWxKssj6/xuzDKsQjnHELKBuDqozGp0LZTknHC3Ec746kOWAfHeQnxVuOemJu
	mnGoXL8jqdG2hlQ8rJTmvE9czjh+TWSl//ImdqISvBNaHAllMZx+CR1w72vwdIehFVoU
	D7zfC+PdE0lEjyupdlhNUjSiNaPR7oDWW33hD825Q7K5tGrjPpaOB2/YeB6qPoeGfVDj
	LkC/4i+4Pfcfp1c8mjwBJjiNUnoxTTHtZJKJjo2+xk7orqpn2qjux8YHqGB+aA1Sy1oV
	7e3w==
X-Gm-Message-State: APjAAAVV/cxOuwkIMTsM5tpxnLHzEPaHFiRHrtgTMgZiHR7it92czjHv
	Q9clZhFGSUzoRFaBzuGifkXEvrwtxNE=
X-Google-Smtp-Source: APXvYqztMS5KKQiZRBQhERUUJLJMitaUgwFR7H1p0n+c8S0q7UYujqKBm+RsmvRnL4wf4QGiscDvMg==
X-Received: by 2002:a17:90b:145:: with SMTP id
	em5mr29673590pjb.20.1578104616383; 
	Fri, 03 Jan 2020 18:23:36 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:35 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:10 -0800
Message-Id: <46969195492708a705390896c9dea515f158954c.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 25/25] cache: Lower debug level for wold build messages
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:35 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

These messages spam the logs for no good reason, they were useful for debugging
a particular problem long ago but are distracting noise now. Disable them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1a9247c468cf09da60e5d396ccb81e950841c99e)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/cache.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index b6f7da59..ead8abc5 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -208,10 +208,10 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         # Collect files we may need for possible world-dep
         # calculations
-        if self.not_world:
-            logger.debug(1, "EXCLUDE FROM WORLD: %s", fn)
-        else:
+        if not self.not_world:
             cachedata.possible_world.append(fn)
+        #else:
+        #    logger.debug(2, "EXCLUDE FROM WORLD: %s", fn)
 
         # create a collection of all targets for sanity checking
         # tasks, such as upstream versions, license, and tools for
-- 
2.17.1


