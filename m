Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-it1-f180.google.com (mail-it1-f180.google.com
	[209.85.166.180])
	by mail.openembedded.org (Postfix) with ESMTP id 89BD8747A2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Sep 2018 03:20:03 +0000 (UTC)
Received: by mail-it1-f180.google.com with SMTP id h1-v6so4329094itj.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Sep 2018 20:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=tTqTDBHLdcGHFtx0t7OaSjXniedWqA7Fm+fKu9k47tc=;
	b=JmaGuwIzLSAwg+HkmqqLg+Z/S6OmkDj9ujDrT9Zn62TXblEm0tlPJC/qi2EtpIjgwZ
	KTDpQYHcx0L8jRVpdV3+qQof8yxwKKxRq+kvM9rBJD4laJ67Cp055/C/ZgLqE349EPXa
	RIT6wzk4HlqMJGDjcrVwkQJJWcVN3/2TFyoIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=tTqTDBHLdcGHFtx0t7OaSjXniedWqA7Fm+fKu9k47tc=;
	b=TKSRPgr6gM4NEhQehTTo/KfQSX+pvd9u3qba3xSUDbV14AQ3ZESzBnuhmyQbRhy7Wa
	YGxyrCx/ta3qO6aE90Dfe0Vk4IddnSRm5gAHQVThi6ybz8H4VGZPddJbvHzbU6N83fMI
	1t/Njv6EMNzIMcG8SHRILbyNJhQALj9vD5Y6XAmrRZoKJ/nD844cRYNpYX1QbfR1oPGy
	4vYZLSEe5QCrdHKkbABu5ZNN225ZhDYHzEfdKfuEk66Q0Cft1TR2gJA/m1Ng1xmEgUwQ
	E7j7IuFLMfAlIC1asC72q5nzFYFUVhC+t1/mjTLeF3G89RK6kRa9wft43U/PFH26U41V
	Dj0A==
X-Gm-Message-State: ABuFfogs7hLUGpUMxjunNeUM3MalVPAH7liMro0DbjshiklQZymVE2Cq
	fAn0Mgo/EszsfnQj+MIQMf5k/5QCTBHbrQ==
X-Google-Smtp-Source: ACcGV63ggeTYaKy1pksi7kMvGpIXYn0ViHj82BlIv+nJn5wobsrN+9U8QTmUH4rZk++dEZoOfxMxVg==
X-Received: by 2002:a24:2848:: with SMTP id h69-v6mr370389ith.63.1537586404072;
	Fri, 21 Sep 2018 20:20:04 -0700 (PDT)
Received: from hex.int.rpsys.net ([209.82.80.116])
	by smtp.gmail.com with ESMTPSA id
	b195-v6sm3226232itc.42.2018.09.21.20.20.02
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 21 Sep 2018 20:20:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2018 20:20:00 -0700
Message-Id: <20180922032001.19553-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/2] COW: Fix StopIteration warning
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
X-List-Received-Date: Sat, 22 Sep 2018 03:20:03 -0000

Fix the warning:

WARNING: lib/bb/data_smart.py:235: DeprecationWarning: generator 'COWDictMeta.iter' raised StopIteration
  for k, v in self.variables.iteritems():

by using return from the generator, not raising StopIteration.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/COW.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index bec6208096..7817473ab8 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -150,7 +150,7 @@ class COWDictMeta(COWMeta):
                 yield value
             if type == "items":
                 yield (key, value)
-        raise StopIteration()
+        return
 
     def iterkeys(cls):
         return cls.iter("keys")
-- 
2.17.1


