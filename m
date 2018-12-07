Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id E8F836D47F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Dec 2018 12:36:55 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id r10so3632244wrs.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Dec 2018 04:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=9T/xd13dWprbW+4PWndsUqcWgACaASX8SnbhkFqZ5cc=;
	b=DPTjxW8ZUvajNc6D+tJQ6bFoTdQP0oJDhWXjvsF4Dvw6vkbKVkLTahtQIVIaO873Yd
	x/PLKcDYPnQ2msvfdLcD6WkGzskZyw06ni7Eqw6g+mT3rkDvcAlHDSqo4uJca3zD5NNV
	v5mFFFoRBZJlrEjWwQ8HcH0poJIIJaL1Swa+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=9T/xd13dWprbW+4PWndsUqcWgACaASX8SnbhkFqZ5cc=;
	b=owEOs4mtQ61W2OKsRzFrY9Ikep2ZjNzCgSNFeXfxfDyi/ziVA8wTL2Bjov+L4twX1J
	RtZ65IwbhtJGSxGYTOhiWUyKCoIPAN1SOffAqKHME5q5yTwyetU5xksh1lctEoSizMPX
	5nJMjQ9pkISJYcWbY96QDkypPg2t3/GQHJo64y8UBaF6qJvnnCBlq6rwY4wiKIwfAugL
	FVssgfik07l7Z+vJeCwphbDCsdpZvrpBPPyOnXo2QBbwUOGFkKem2yVHr+G8DZ34gMCA
	Ae/Xyj3A0QcSMz1Aj6K68ooY0JjfVbPYF9tzujP+6uR5n8eMCid0BoVK74PT4e/dfqdL
	xygQ==
X-Gm-Message-State: AA+aEWb3vK+pUnKOQ3skhpV10QC/SHxl5ZeEXXN4bC3qmotdHeWGsSsl
	SxHCJ2NNVew2DUGuk4oLsRAzFaXk56s=
X-Google-Smtp-Source: AFSGD/UrqXoXiyfq48Xk79IFBnAbi1IwJfPl0pfKHHMri/e2rm0jkWk35OuqYPsGVYwWEapcAeo27g==
X-Received: by 2002:adf:8544:: with SMTP id 62mr1761555wrh.1.1544186216257;
	Fri, 07 Dec 2018 04:36:56 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g198sm5216657wmd.23.2018.12.07.04.36.55
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Dec 2018 04:36:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Dec 2018 12:36:53 +0000
Message-Id: <20181207123654.13832-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH 1/2] server/process: Increase server startup time delay
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
X-List-Received-Date: Fri, 07 Dec 2018 12:36:56 -0000
Content-Transfer-Encoding: 8bit

On loaded production systems we've seen bitbake server take over
40s to start up. Increase the timeout to 90s which tries to avoid
failures in selftests.

The delays come from setting up the inotify watches (31s) so can't
really be avoided.

After 5s delay we now warn the user we're waiting for 90s so the
interactive exeperience shouldn't be much changed and its very
unlikely the user would see that anyway.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 49973d6670..1a6a826746 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -400,7 +400,10 @@ class BitBakeServer(object):
         os.close(self.readypipein)
 
         ready = ConnectionReader(self.readypipe)
-        r = ready.poll(30)
+        r = ready.poll(5)
+        if not r:
+            bb.note("Bitbake server didn't start within 5 seconds, waiting for 90")
+            r = ready.poll(90)
         if r:
             try:
                 r = ready.get()
-- 
2.19.1


