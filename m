Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail.openembedded.org (Postfix) with ESMTP id F09A07EADD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:21 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id p77so3393792wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=ibwP5FTSBEKvZ7TFAu8faLuh4nuUF+bqbt2IJhwMoBg=;
	b=gU1UxBGKtU3ahgivE0Btj//LyFdwof+Nb+HIqL2N2vHQgxz2uJ4nodmfMApyOxZQXx
	9ZADgRV2zAWgvAENGFxOjdRvLvRNQz8Di//k6gGpAPa74H/5snWsV+FJA9oGmIkNIQsJ
	fTdoZ0go0pWXREFSkjDTW3bfMUYi/OZ8aPT08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ibwP5FTSBEKvZ7TFAu8faLuh4nuUF+bqbt2IJhwMoBg=;
	b=S06essvDEIjZirT86WQRqbob3twvtzwCOFW+w24jJwdC+JjiMqlecWLfs+nq6qjhXO
	G6xWFR+A81AcIWK6h/C3McdMhtbdGh8Y1PulDqShtaPMN7BEAPYP/NXWM8sPI5TW176S
	uVO+1tFDEbmisMuWcYm0Fp9VXR76IcZho54pyp0/v42JJFibQUR5hhpteFxrIhDA9m9i
	lD4qxtDCbzkk5xkLJGmjDlV4jFmSrD0KBrkE9y3j0+VeIWaZznJVK3c+bAvEr+d+KyQe
	REJvkBtcn71cGDj2tGLgQ2hfPKuh/3p/W1dFSnfG0SSE8SemH2M6SGR4B4NTNZIl5Vvw
	/toA==
X-Gm-Message-State: APjAAAUt9FMxUWeRif0QCRUs/Q67yAwii4vDw+q1mtERdujBdtdBRlkA
	B+D9NaKzB8pBgdlG6C2iv7WUNJf9YMkvcw==
X-Google-Smtp-Source: APXvYqzRKpELRAonmuc7DIP3yc9ySXaxFjtMUjevIaKUn0NTSAn2NYhfV5UjRLUO5CERZDxXBW9Sbw==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr8594698wmf.115.1565790802550; 
	Wed, 14 Aug 2019 06:53:22 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.21
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:12 +0100
Message-Id: <20190814135317.28887-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
References: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 05/10] runqueue: Wait for covered tasks to complete before trying setscene
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:23 -0000
Content-Transfer-Encoding: 8bit

If tasks are in the covered list of tasks for a given setscene task,
it needs to wait for those to complete before we can start.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 29786c400b..9acad7af8e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1920,6 +1920,10 @@ class RunQueueExecute:
                             if nexttask in self.sq_deferred:
                                 del self.sq_deferred[nexttask]
                             return True
+                    # If covered tasks are running, need to wait for them to complete
+                    for t in self.sqdata.sq_covered_tasks[nexttask]:
+                        if t in self.runq_running and t not in self.runq_complete:
+                            continue
                     if nexttask in self.sq_deferred:
                         if self.sq_deferred[nexttask] not in self.runq_complete:
                             continue
-- 
2.20.1


