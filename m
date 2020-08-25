Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.web11.1348.1598396906395384975
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 16:08:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CJ4xgmfE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.68, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f68.google.com with SMTP id u18so726180wmc.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2020 16:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=C+pXzkpMqI7iLcj0D5RkIisYTH5bj4Y0vuMpU9wnzZk=;
        b=CJ4xgmfEKPUCmnuwFC/4Hii+Y4Rh5GZroH30A7sjAyqGMW+TABMmDzdtubp17i1pp2
         98PDMbVx3ZcMT9Z4tob6EqJ0hddWQP2p8O9A3ccMMuDGdBW6VKFLsh1rVoch7A5FiORl
         dI7WrNs/wQq4uKN2fkKrxB37soWSuvshLSJck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+pXzkpMqI7iLcj0D5RkIisYTH5bj4Y0vuMpU9wnzZk=;
        b=dVAAZw2NXuLj0DXgHMQpftQviV+1s6RqadVyDn9Gf9TA0kNtFRPpd1pKMnldpNrht7
         CgjaFkbrcKuZ0ZcovYrcq1VkK011aYJhnt2qBaFUX8XzFjvUZjoml6ZPM5JnZU0sGzqu
         w3kEV8K8ym9E6elYjiaZP2qJzXqN3F5x/2Ga2xE00o3YQ2wS/BHtTtCCBfTeUPq9XRCx
         wC3xK1SfZ7BdUdphH1Yz6wVIAqq3+EEFK4EM3zyPn5Wyoo9brh4xjQELh4B14GefhZaE
         oVoL2zforXNx4hv5V415zN5qB6KDhJyoiqpJFK4Q8mpqX2pijfbJZ4oDNPefN7cYsPPB
         q5Cg==
X-Gm-Message-State: AOAM532iKRkrdSPKdU0EOd/Bq1l+04ztoEX3TjzTIllJ/nE4dSWH5zyn
	lEhydMWGDzlGQZuTMSmZgy83dYcSGagDUemO
X-Google-Smtp-Source: ABdhPJzj7r3/DPKETTaRRAwd0GwawSepL+e61ftvgV2mQQQghiQYgfbmuFG7o7S8WRmAj7Lui8AE0Q==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr4009806wmi.48.1598396904279;
        Tue, 25 Aug 2020 16:08:24 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.9.b.8.7.0.d.0.8.3.5.0.7.0.4.c.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:c407:538:d07:8b9d])
        by smtp.gmail.com with ESMTPSA id q6sm451710wmq.19.2020.08.25.16.08.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 16:08:22 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] utils: Drop broken timeout function
Date: Wed, 26 Aug 2020 00:08:19 +0100
Message-Id: <20200825230819.1448746-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825230819.1448746-1-richard.purdie@linuxfoundation.org>
References: <20200825230819.1448746-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I strongly suspect this function doesn't work with modern python so
and its unused now, drop it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 50032e50c2..e51b8ca508 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -433,20 +433,6 @@ def fileslocked(files):
         for lock in locks:
             bb.utils.unlockfile(lock)
 
-@contextmanager
-def timeout(seconds):
-    def timeout_handler(signum, frame):
-        pass
-
-    original_handler = signal.signal(signal.SIGALRM, timeout_handler)
-
-    try:
-        signal.alarm(seconds)
-        yield
-    finally:
-        signal.alarm(0)
-        signal.signal(signal.SIGALRM, original_handler)
-
 def lockfile(name, shared=False, retry=True, block=False):
     """
     Use the specified file as a lock file, return when the lock has
-- 
2.25.1

