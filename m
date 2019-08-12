Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 459E27E58B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Aug 2019 15:14:20 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id t16so14773344wra.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Aug 2019 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=nbx/nLuPLjhsitl85vKef8hCxizM4rj8LS4DVnCxdpU=;
	b=fxby5Ja1/OZ0GQ0FFOiVu2IXNYnKtjT3dm4E8n9pQ9zB09kO0gP5CMk4VIdLHEWNfW
	1NBRVyosFY0rr0xu9ziA1WqbYdC0yOisytVEzzBIC4QtYruI3JDLOVHz8XZvc0XsqBlU
	kHQqObeuQdBhQsSTurB8EB/Numpet+ozeMQK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=nbx/nLuPLjhsitl85vKef8hCxizM4rj8LS4DVnCxdpU=;
	b=U05VYMRSJeoYLR80tqqnnTQMW3puxpKyHhVw1BXBq+J5ooy9ckhCKogKsER72THbju
	TPD/3IQ/M7dpSeJ0ig+WO7AwxDNSFAyrfV8S1tQ1dpWSfiDt84uV2ogYGR+AOF8dBTJU
	/Li5BmgScHy1sDbYbW5w8eQkjPQ02Cw+SodBdYacRLxfsgq6r3FAzCkVgsC2WveGGaP8
	A9yvz3Rg/+neE+VRwc3bGNEiIPO7VBkHGz6IzHyu+kDP1ke5c1zVifHYAMwehWnVD8UP
	KqLkZBj/5EX72mbKmoddITwQfsUneZ2wzW1NSYqmlRnkTONcEub7Byh28QuSSlY1H2k2
	tOsA==
X-Gm-Message-State: APjAAAU38n/3GdROvMbYvTSY8s+7myWXzXYa+n4I0BAZ222NVgTff0KJ
	oLqB/1WUPse14IpzUOk4ree/re5wJOuqWQ==
X-Google-Smtp-Source: APXvYqwrsORV8SmFTbNLRTyfvDs/aLJTBPNxOeqZiAj7y6ylDN9mLXU4CD5cLsY+4Dzjn4oVyn4/dw==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr24593727wrm.271.1565622860660; 
	Mon, 12 Aug 2019 08:14:20 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	b2sm12029638wrf.94.2019.08.12.08.14.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 12 Aug 2019 08:14:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Aug 2019 16:14:15 +0100
Message-Id: <20190812151418.31307-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/4] runqueue: Fix corruption issue
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
X-List-Received-Date: Mon, 12 Aug 2019 15:14:20 -0000
Content-Transfer-Encoding: 8bit

We need to copy this set, not modify the original else all kinds
of weird and bad things break, mostly from circular references.
We'll not go into how much sleep I lost tracking down the fallout
from this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bb61087359..2bf19b9778 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2124,7 +2124,7 @@ class RunQueueExecute:
     # as most code can't handle them
     def build_taskdepdata(self, task):
         taskdepdata = {}
-        next = self.rqdata.runtaskentries[task].depends
+        next = self.rqdata.runtaskentries[task].depends.copy()
         next.add(task)
         next = self.filtermcdeps(task, next)
         while next:
-- 
2.20.1


