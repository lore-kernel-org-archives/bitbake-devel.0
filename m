Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web08.5796.1631702755142281999
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Sep 2021 03:45:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ng0bPJ3I;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id i23so3156921wrb.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Sep 2021 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/Qlju8rcykhERsReho/LLMwAUk7YmtXyoWigJVQCE0=;
        b=Ng0bPJ3I+MsIavfCx92joMBqMJaFBp4XJsXgaBEM3r1I5uJrM+j4PTAHSaU41kivBj
         1J+Ij4A/LRyDqwazsJiVGUYX/IW0yknJOk9mQVdw1zCKcTC70akxTghwhpG9YmiZca2K
         CA6tcj1ySE8Rph2RP7LDuPDiWFo/CY0npj1fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8/Qlju8rcykhERsReho/LLMwAUk7YmtXyoWigJVQCE0=;
        b=eL3au0hA8EDwT2Wu5suRpDG/rqminc0dYhljIUCnXGUlZ21Sk1D2bHWnpJL1I8p0Vb
         jsNW7qqmwV/TxNUUM8+yNASwj+ztI5YKnlYuoONU4+Y9vb4ycGQ6bbqUokukXjs4M9VU
         DcqfGI2jbQzZFBpsx3uuTSCNRwo8glkUt4Br5bcrrU0BRebePBeUI/7J+b6sP9Dx0UW2
         Fg19lYV9ibMtSVfuzsEgUtn/MzOc+FeN/YGm2LQE0kWIqCYaTYa5iaaNlHDvKP8UXvsh
         zFFSi+r3nun4lhqnm9o9WXL0TJAJNFBJWJYJKuecMKlmmHgjtineeu0xxGCMt97t4bDM
         Jniw==
X-Gm-Message-State: AOAM531ox23WQ0ed2As5rduU5T1p3jEJ82zHt/Ll1cEU229w2VFnyMVW
	gosDc4ueD8K9VJgv9XPUnMEZIp1tYeF8ZnUs
X-Google-Smtp-Source: ABdhPJzlU5nd5/LA5VUSgANpqa9AzHt+H4KjHshr3BrN3aRYyR1ZWYH7RScmCyy/rDN67jayoP/beg==
X-Received: by 2002:a05:6000:236:: with SMTP id l22mr4323900wrz.386.1631702753443;
        Wed, 15 Sep 2021 03:45:53 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:cb98:b99:6df8:dffd])
        by smtp.gmail.com with ESMTPSA id h18sm3909837wmq.23.2021.09.15.03.45.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 03:45:53 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-worker: Improve error handling
Date: Wed, 15 Sep 2021 11:45:52 +0100
Message-Id: <20210915104552.1400939-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If bitbake-worker fails, return an error code showing that. Also
make the thread cleanup code explict in a finally clause as it would
otherwise hang.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index a9e33ca7c7..11f22c11fc 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -512,9 +512,11 @@ except BaseException as e:
         import traceback
         sys.stderr.write(traceback.format_exc())
         sys.stderr.write(str(e))
-
-worker_thread_exit = True
-worker_thread.join()
+finally:
+    worker_thread_exit = True
+    worker_thread.join()
 
 workerlog_write("exiting")
+if not normalexit:
+    sys.exit(1)
 sys.exit(0)
-- 
2.32.0

