Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail.openembedded.org (Postfix) with ESMTP id 015C07F33F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:55 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id v17so5984266wml.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=AlKjrsJMeAuUPf85PcZ+Hi9v+AjmMmF3DQkLd2O5Pwo=;
	b=Lll1NLD/kLph8nvGuS7pmYLxSA3A2r7ZHE8797THXyLgaZm2+jf78rJoNLyakhcvbs
	KqiRhHABErrRvrQ7TZVPSLskBpT2seYAazqcnK8VpmSCKUg7dj+40mLBikdluZcAan7E
	CvmafFzelMctNyN6xU1V0cVgDCm2tl3ht0QXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AlKjrsJMeAuUPf85PcZ+Hi9v+AjmMmF3DQkLd2O5Pwo=;
	b=n9k2OCZL7o+f4YjKN+7eLN/E2C5erUh1ajAjp1hG+6JTAaqN4vPA+D+Vd8vCgdSiuI
	v4dhwutJFwbDjoxvXORUBvyaP6dZKtr+YVDGGJmnSOc8uhn/upmCVnuKYNa5QLuWpwR8
	X1SgDd0VhlM8mIqtjxlOv0jXkoEX+whGJ9uduKpIcltEa0dSSlBBiQ+WdITV4vdPdxBJ
	2W556WGFvQKSfcRCngrfN5BzNbwIz+ZqTYMMBMELRaZ71l6Xt2jaepwkjIMR8KJQAE5/
	Xm0UejMx/U5o7F1lpH0ANKUudg0iOqHYonW4kDDdKZDLkCnT/AF++NEGqqapApHQg2B5
	/7hg==
X-Gm-Message-State: APjAAAWq+0tM7OnTfjWP/RfujHqV1XALz9SULIOm+wCrmcYgA/gr42TS
	upfEv+Ad68EuLvl9dfIEfFzY+1/o6ck=
X-Google-Smtp-Source: APXvYqzLbtld0QxNsfoHO1CcCWVGJxqBObNf/Osz3vTvPlL6ZqrnfcpUkE9zP2ljJxezAkpnMG3dig==
X-Received: by 2002:a1c:1a45:: with SMTP id a66mr6939460wma.102.1569587636348; 
	Fri, 27 Sep 2019 05:33:56 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.55
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:55 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:46 +0100
Message-Id: <20190927123347.19276-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 8/9] runqueue: Small performance optimisation
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:56 -0000
Content-Transfer-Encoding: 8bit

A minor performance optmisation to keep lists smaller when running large
builds. We can do this since once a task has been built, we don't need
to worry about it. This improves a major bottleneck that shows up on
performance profile charts in dryruns.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 31de3ed1cf..18049436fd 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -207,6 +207,8 @@ class RunQueueScheduler(object):
 
     def newbuildable(self, task):
         self.buildable.add(task)
+        # Once tasks are running we don't need to worry about them again
+        self.buildable.difference_update(self.rq.runq_running)
 
     def removebuildable(self, task):
         self.buildable.remove(task)
-- 
2.20.1


