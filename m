Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
	[209.85.214.180])
	by mail.openembedded.org (Postfix) with ESMTP id 6F3397FDA9
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:14 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id s21so19298695plr.7
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=LiWJLKqi9pFegSoVEfTeD4wh9oClWOTDZXocYAp3wXU=;
	b=DD3/JgcGI4l5MHqg+F8pQVwXr72E3pMioQJLzdFd2gOJyPRivmG2puSz+vj4Nux1xO
	aTQS4vdX3D35jwdV9pUug+XWjEDHgypLqw1mz3nA5mcpTDC6b3wu0vsMTb7EHZQD9bMp
	+CJeaXvRa9EflNfd8mxCE4rhm4YkbN9hELab4wODPdTnSjd/JB847tRHZ7nhXqQ6tbxQ
	aKC7i59gb0fiO5GlB+q77fgmsHD0pU+NoabT3MP5KNy3YqP09haqU5Obd+MC0+sugcIK
	HXJgqv18TZYt/V8gNbB8m45UcEBw2rDXQSFlbHmEIze8IJ65cZYsn7ZLjjlSdlzIdOUD
	9kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=LiWJLKqi9pFegSoVEfTeD4wh9oClWOTDZXocYAp3wXU=;
	b=Lb8hVSd4Ea9xzoTjPVfEJVzFXINjCzgZ1S7/FQGEWw9UsAPo+9bBNEhxhxAiZerGtb
	l6i1a6wMy8SLziC4NckCrSA23Dp3G/lLL5aeop7wo5CnFs6Dxpf+m8N1LvLbhRhqDp8E
	0cBkMTMHwLU89KyCOv+V60vN4HCjXrM+PhU4G3LPRrTLX9PsoxmGefFOo8BgB5F67WMi
	TYxHrgwBSmvqtxa/L7oXL1NFoGCrXU+8lkEX67q2I1W/SVYYMrwH04d5APZN+AU6j3b5
	1aQmTBXLIjRVvaDzOzAzUfsOBjeMngD7jigiL0cdQnqw9P643Q9jlFeH3bGDq+0TDoDq
	UoSw==
X-Gm-Message-State: APjAAAXTqIT2XXzsr+KtkPCDQXDxq+FCff0wF0c9m4C+x1MnERuHZsq/
	I8Cdc3jskZXffSa0CbhXpLoQYZeS
X-Google-Smtp-Source: APXvYqzOKWC9AirLP4lQ+pSdCqfTO2F91ylfjl7V4PehQ8Cys43aas2wDlcHSKGWYcPBl1YGcI3/uA==
X-Received: by 2002:a17:90a:d995:: with SMTP id
	d21mr44099120pjv.118.1578328035390; 
	Mon, 06 Jan 2020 08:27:15 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.14
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:14 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:46 -0800
Message-Id: <46969195492708a705390896c9dea515f158954c.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 25/25] cache: Lower debug level for wold build messages
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:14 -0000

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


