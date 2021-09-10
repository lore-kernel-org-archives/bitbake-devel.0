Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web08.6710.1631265311701101603
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 02:15:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=An14TM9l;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id w29so871677wra.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gjNMxpvn4JF92bDp805LFwNm0i8oDu0s6S82wL2d0zA=;
        b=An14TM9lAF0nkyFcRfiOGEeWwUCDBuQyfjRvkhuD6Z7rZ3AmvD8SctBoO3nlQV6/0J
         GvLhm6xEwfi6oUDYEmzKM4S0WivOlwaQ3GzU5QU3v5TRvTe+KHeB1iCylyOkQyxrDYor
         qIp/PzJzVeI+Me7SPDMXZCvXAr5DDnVzJX+3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjNMxpvn4JF92bDp805LFwNm0i8oDu0s6S82wL2d0zA=;
        b=uxhJA6b+hFXUOFW+yyigfiH1EpqV3DWG0yHztn/9ofxMe5YI+ZAo3VEEKkOeDBzbyg
         p8nAzV13zNYjNj+pJccQsLwzzflEEHhRLn0lqs92ru+wS6HbfUvoQ0fQpQ6nFqKQCugM
         Fg47WJ+Cbh5cHWDjY5satkL0hCoavn+gRp0fqHfhpuW+k70aWMVLFbtiZTH+qE9UHh/R
         zJA0OCA/iJgmkf8efF0jJPpVqtDezbfKXdaaq7lPXzjTGXGSxT5vsQPrKs9pU+CZ0uo3
         wMdHsQdTvbgPsZuizbxMHNh19AHQr+Lto7wrfCio+KJwA4vWSpgAABTx2JiPSfTse2Yn
         bQag==
X-Gm-Message-State: AOAM531rYlukZ3w4QH4mZewx0D4SYFZT0P0UoSeQ/bM0wkdyEmnk0/Gx
	V3J3c+jmYCvZG6T4DbBRIAArb8WPj05VmiIt
X-Google-Smtp-Source: ABdhPJx5cVZ3JNEa0kzb2DkfBTolUnf+OiVYifNY0+7dCapMV8nZ45DP0XlqqPdq4Bhpix+50cDKJA==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr8806482wrz.139.1631265310248;
        Fri, 10 Sep 2021 02:15:10 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id d29sm4372893wrc.6.2021.09.10.02.15.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 02:15:10 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] process: Don't include logs in error message if piping them
Date: Fri, 10 Sep 2021 10:15:08 +0100
Message-Id: <20210910091508.1249752-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210910091508.1249752-1-richard.purdie@linuxfoundation.org>
References: <20210910091508.1249752-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the caller is piping the logs, they likely don't want them in the error exception
as well. This removes duplicate output from the build output allowing the UI level
controls on whether to show logs to work correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/process.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/process.py b/lib/bb/process.py
index 7c3995cce5..d5a1775fce 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -181,5 +181,8 @@ def run(cmd, input=None, log=None, extrafiles=None, **options):
             stderr = stderr.decode("utf-8")
 
     if pipe.returncode != 0:
+        if log:
+            # Don't duplicate the output in the exception if logging it
+            raise ExecutionError(cmd, pipe.returncode, None, None)
         raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
     return stdout, stderr
-- 
2.32.0

