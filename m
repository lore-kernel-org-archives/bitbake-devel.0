Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web08.9015.1632493348319493087
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=AjtwRad7;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id v19so7093995pjh.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=45DOJsigwAmXQJldIguQrF6ecRcF1+DMD92ABywEobA=;
        b=AjtwRad7VyD6ySy0Z0V/SXV2K61bNZbCmYGd3BGFGoGE6RYybA+Nmpp8NRdTaueQAc
         8qCmWL7rd9Cxw+3wAFdJgITWwZWZnBmPkck8EJIQcgHXv0viQ7Jxv8BeNUmyYA8+E6qg
         z1onycYj2tBNZXtCay/QDb5Kj97lsnPJEJmO7Jul0zyDanZ8yRSsFto1hjasZPLur3uR
         5rTE2swqvALRAjGhz9VoipHgaxszM7594TSMGqR+J4eQOQAoV8SjArH1XTUhqWvMrpKN
         c91N2fu1X4mCqqp3dP+VS/FVtfre8WCscNNy0IAmaf91bsYMcXpzXzphUBmE8N8Fh8sK
         vctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45DOJsigwAmXQJldIguQrF6ecRcF1+DMD92ABywEobA=;
        b=YvkwcEZFj1UN7ap9Vot/9JdiVt85npBPXSyuyFqYazUJhoelXaWwqfotc0YDqjfUtd
         nDl+dC0Wd8Odc6bROZDSsgtpngz9PnktBkCztKBKGNoWcvR6WXRRTXsBHA3kl7oi3E36
         1CDmfiz7M0+TTJRBzZbJTW1yZuD2SAD6rP5yZq3Ll/NUL00brO5uHijiPOxnQXpAAyJA
         1iTZ5vo4I/Nq5/u+OHcWmxCghPXRklCGf5Tcqj42+h7G7gIqWM+e8hNgQX4SpbHwv1GK
         LbSEWaOiyPhZfbagbCsA5EKjYLs3F+hbEEdilLssp7nDc1b6vLMRG8orn3sJcPpD5Guz
         GX5A==
X-Gm-Message-State: AOAM532t/h61K+fDSa+uq/xYppL5QDX7C/B+pU/yI8IRFGyLA343aL34
	oCZT3H5MCd94y7FW2o7TUKQ5LzYBDhL+iC9UZa8=
X-Google-Smtp-Source: ABdhPJysZN6r+hbbxCnp1Gwwx16OgJ9hNCbB0a2FzAYSwupinmrT1Cx+k/R15OG/mRkRXeTk+cONww==
X-Received: by 2002:a17:90b:3b8b:: with SMTP id pc11mr2593221pjb.153.1632493347254;
        Fri, 24 Sep 2021 07:22:27 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:26 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 06/14] build: Handle SystemExit in python tasks correctly
Date: Fri, 24 Sep 2021 04:20:59 -1000
Message-Id: <e7aadd05098fa263f8722e1010d3dff90eaea253.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If a python task fails with sys.exit(), we currently see no TaskFailed event.
The high level code does detect the exit code and fail the task but it can
leave the UI inconsistent with log output.

Fix this be intercepting SystemExit explicitly. This makes python
task failures consistent with shell task failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9eee9fd4f2f96789ad2b037e74d561bdc1426856)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index fa22a1b4..04971636 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -587,7 +587,7 @@ def _exec_task(fn, task, d, quieterr):
         except bb.BBHandledException:
             event.fire(TaskFailed(task, fn, logfn, localdata, True), localdata)
             return 1
-        except Exception as exc:
+        except (Exception, SystemExit) as exc:
             if quieterr:
                 event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
             else:
-- 
2.25.1

