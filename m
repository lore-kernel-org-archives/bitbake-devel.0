Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 5B2ED7F2F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 14:46:05 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id i63so4276078wmg.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=v3WelEI4+ZM9Eb0azK9djFizLj7ZeSgaSPPlOcj1vew=;
	b=fnS2y/fyHgnhZ/y+nmuBL4KyXi9RUY2YFrL6T4cVymO6E9hoW3xITuYMRh8Wt16lRm
	y/aMcw3VuJIzbs3V/SIv+Br26LRTWerqyTKbDjBJixY3Jkc93UxenxIb+XA7g+JSBJlw
	gCTsoK9cqZCeP/G+LbTNRxdxTQbPe4tN7n2PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=v3WelEI4+ZM9Eb0azK9djFizLj7ZeSgaSPPlOcj1vew=;
	b=hD8m6bnhO5CokgqJi63Cb1vEAJWGxA1KNPM8Ga6fQsMPeKHUzrYskXtpJPe07oZtIF
	98N+K7ydlgcUHlTo2qgefFGl7JK/STq7KP3lFrURlcz5dev4Dq7XuBF7Kf4K3+J/jn7H
	zw3UR6xFemrLAEqShl7cATEP2IWzY/r21diJCHGWCgabS57aen3QAUVSC8a0YA4/l07j
	9i9AjXiQyaTp9Z9xfh2MOkHHNhXj9I+vnpWnp2QrAHJ5Dg07lRxvd+FH6Nor/Fa+GXof
	KJrToVgYrXmvu8LCmChCm5Xp2ynoi4IzcTeymkk7aM0T62MKKPNpRI18RhgKeirgeaas
	02/g==
X-Gm-Message-State: APjAAAWLJBVingXK5ae+HRWCSHHDKeLrrhOdvn2UsMMird9QTe+v+s5H
	hsaZJpkLG44OBu/GHoUkC9ne04POJ9wykg==
X-Google-Smtp-Source: APXvYqxEyo9zDq37g8OQQMuQ3e8e1rZ7m3E1ltbqe7DFnubACZiSY0mlPm3GmH1mXbOmEmadXOGfhQ==
X-Received: by 2002:a1c:1f41:: with SMTP id f62mr8093786wmf.176.1565966763538; 
	Fri, 16 Aug 2019 07:46:03 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	q3sm6126651wma.48.2019.08.16.07.46.02
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 16 Aug 2019 07:46:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 15:46:01 +0100
Message-Id: <20190816144601.20352-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816144601.20352-1-richard.purdie@linuxfoundation.org>
References: <20190816144601.20352-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/2] runqueue: Small but critical fix
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
X-List-Received-Date: Fri, 16 Aug 2019 14:46:05 -0000
Content-Transfer-Encoding: 8bit

We've observed do_package and do_package_setscene running in parallel. The
reason is that holdoff_tasks wasn't getting updated. Looking at the code, it
would seem the reason is that the task was in pending_migrations and hence
changed wasn't set and holdoff_tasks wasn't updated.

Fix this. It only affects builds with rehashing enabled.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7fa074f679..88212ca00c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2283,6 +2283,7 @@ class RunQueueExecute:
                 continue
 
             self.pending_migrations.remove(tid)
+            changed = True
 
             if tid in self.tasks_scenequeue_done:
                 self.tasks_scenequeue_done.remove(tid)
-- 
2.20.1


