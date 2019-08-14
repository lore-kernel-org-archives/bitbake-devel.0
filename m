Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
	[209.85.128.44])
	by mail.openembedded.org (Postfix) with ESMTP id 739607EAC3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 15:02:52 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id i63so4758649wmg.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=e4S0IFFVi0S12/ZmGE1WE4bnkU35SwuA1GsNYEU/bY4=;
	b=Wkb6e2HRyQ93DVZBCtAUtaV7gjxpfByZ8eyP7fU2bsF1l81i2v9BxgYHnmkT+Zjqy5
	PXTenlS5172D6jHDqmGNb/LmsmwArLBYu/jHsGJe8VOiQpn757mXpBj3b4juWdwilfq+
	pNZ4uHoc3fkptdhYCuaRvTHg3krDJkvu/nWAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=e4S0IFFVi0S12/ZmGE1WE4bnkU35SwuA1GsNYEU/bY4=;
	b=Ta5hV7ybbx3ATR+kDrSpCt92AIb0BtqZvH3JzQQ7XAIwiEec39VWDfjT6kB47SDKmX
	jyRnhBeV2XUK6NO3xYY+Cs3AD5Sj0O4177zAQa9HN7/N8fyBfGmeUuUdBHRAvZOhhBrC
	Rj0+k0wLrqo3Z6GaKPZot5ScDjEgwNDJi7N0rhKDtzig1HY5JBYqpdLHpwEubKRH+HcD
	mUh1gGytOF5kQmH7zqPYeZtEWwgKRCKgJuocu+c/yrZXSj1NWLTwqmD0UTGB0lo4FI98
	X2hZRZXhh9Hi17WsZY0ZjCJVUAYBhuSSWk6kRpaNIrY+wPP4EHksDMiQEa56ChFsJxcg
	X/Zw==
X-Gm-Message-State: APjAAAXqQLe6I9+hLRqLaYZHPqTA/MYpVckmhVurkTn/yeyLBmYIbhYh
	2yBO7gs9m9ft70r3tF4DWprXkVY0E2VO2w==
X-Google-Smtp-Source: APXvYqxIN2Pw//HHMVUtZoCfouRBCmxdQg53A/XLh8m3yKOqGxuJkFfGrmfm/i5BTW/837pwgUFrcw==
X-Received: by 2002:a05:600c:231a:: with SMTP id
	26mr8476749wmo.136.1565794973116; 
	Wed, 14 Aug 2019 08:02:53 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	v65sm6165285wme.31.2019.08.14.08.02.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 08:02:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 16:02:49 +0100
Message-Id: <20190814150250.332-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814150250.332-1-richard.purdie@linuxfoundation.org>
References: <20190814150250.332-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/3] runqueue: Add missing setscene task corner case
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
X-List-Received-Date: Wed, 14 Aug 2019 15:02:53 -0000
Content-Transfer-Encoding: 8bit

We weren't marking this special case of setscene task as buildable leading to
runqueue task failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ff19564a8c..9f4337610b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2294,6 +2294,8 @@ class RunQueueExecute:
             if self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
                 if tid not in self.sq_buildable:
                     self.sq_buildable.add(tid)
+            if len(self.sqdata.sq_revdeps[tid]) == 0:
+                self.sq_buildable.add(tid)
 
             if tid in self.sqdata.outrightfail:
                 self.sqdata.outrightfail.remove(tid)
-- 
2.20.1


