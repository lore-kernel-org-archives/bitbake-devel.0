Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 136377FC1B
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jan 2020 11:03:11 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id b6so36864708wrq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Jan 2020 03:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=4PTJj3BIDKCA2PhkVD/d0f84ziLMoTO4rRh1tBC0bCU=;
	b=hzjlPdf6DKoMfFWDzEa76VMgG5ZxoX81kzcjXq6cIQhwawWZYA7akieqOIo0G589Y/
	7ZzDsqbUrDZMBTkFs77Pr55kdMlSMiEL4XKhHeDB2F0ASUT1gyHO7UZhsGlcbtYyKPHz
	jgQC+AmXtT8aO/9MT+4/+qWLWneUFsgD0TlT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4PTJj3BIDKCA2PhkVD/d0f84ziLMoTO4rRh1tBC0bCU=;
	b=nz86wpXMaGjnrRX/Zk5HeIPp5jA7Xz8rLTAprRaXVmmQ2imMkJ3GpSMppNpiW8e/af
	RtTBJod0WLLrm3Z9YKBM+JZKMkaWiUj/tffAdDAkZAbcItsxvULB6Xra/U3xUpp8tdTj
	X64vb2HyvNIqZc5k7J8sYSyJkkQbodPI+MQcm71Y57/+Guns5KsiXjYwOLyDJCbgAL9F
	qRy1OWt3vvXn9mHaw7STrzQiQo8/+ZcxDu5lVg2IyU5XP5elpeVTCXNaexsoDBFglNee
	9yy3VOlqr4kLF5sbht7jkXZp1nEOpGTzJyRvjxf5UcGE684+5M+fEt3GJNPl4qiRgN7X
	hMCA==
X-Gm-Message-State: APjAAAWpWqOZJaE6PjV2/wisqhWojFP3TM7MI8GtBMxHW+dsTtp4LDkv
	PN7C6dAm8jSb7dH8eNvRB60Ox4V4xds=
X-Google-Smtp-Source: APXvYqz71AGnvDE8e4pETWYw69V9VxTLCRcky3hQA3lU7naLdZHVrU+3JbqSJLMnp6oQqJLRcgyoAQ==
X-Received: by 2002:a05:6000:367:: with SMTP id
	f7mr74906647wrf.174.1577876592436; 
	Wed, 01 Jan 2020 03:03:12 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a1sm5250672wmj.40.2020.01.01.03.03.11
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 01 Jan 2020 03:03:11 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jan 2020 11:03:05 +0000
Message-Id: <20200101110305.12317-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
References: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 5/5] cache: Lower debug level for wold build messages
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
X-List-Received-Date: Wed, 01 Jan 2020 11:03:12 -0000
Content-Transfer-Encoding: 8bit

These messages spam the logs for no good reason, they were useful for debugging
a particular problem long ago but are distracting noise now. Disable them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index b6f7da5920..ead8abc5d8 100644
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
2.20.1


