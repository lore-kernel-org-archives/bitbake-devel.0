Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.1307.1605910955810932587
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Nov 2020 14:22:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=xnxFZIbn;
 spf=pass (domain: linaro.org, ip: 209.85.221.53, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-wr1-f53.google.com with SMTP id k2so12314959wrx.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2020 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGPJDGju6M0BKnhkePk+nLchh1TZQmCp13BBQHuZLx0=;
        b=xnxFZIbn2hVxS8aXa9m45dG5xnXsV5pqPxJ4cJA+b2JJvujoVTOg7tHLAofHhAdCAw
         RwoCWzik187Y2ef4nBbtsQ8ezPTyA5buA5CcpMx2WefQlTCkE+mZcIHM3o74SMG6McL1
         hEavfmQZfPY5bA+mpVUtBGikP8EHtJByBsD3Ue2uTjvb64fYGwoO1FpOCYbPyvavQkuv
         NwfqqJ7tOgna8sUzXffaGuE/X/J5tr1OC7j2VcC9UffTxB2NvgF5TnjeUJZyZA0OBuGp
         hc4vWPLnThnkVppOdNhjPbwT8rQurVG2r6iRGYFhX5bD9lB8aPa4ZFnQtlITSLSCPwrC
         7DXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGPJDGju6M0BKnhkePk+nLchh1TZQmCp13BBQHuZLx0=;
        b=WvXVogi/G+T2FTs9ti80vzYPnggJu8rGzDpUQL1kYtPQcFRrykBZhdy/IJmBsYxZtQ
         4AxQYSHIFjU+svu6OxnZ4urK+Vn9CctHS7USrvrX5eyMlhcPto7VIq+eeyvmDtx6oeXl
         w/qJLKKzwNUU+EDB7b8LObGSwMb9YDhnSIfFYPiV+sGWblnN3YwE4MqvaMNQJhgFfhSZ
         uQ76XT1G7MFWC0vP7UbzyAZ3Q9/uhdN7gptczYXZqUDH/vKclEAenoDT+3rZ1WOewBNC
         06GvnB4y74wtKj4E2vbLv4VCzgDzie7BwrFV2/64suIDEzcyq2OyA8uAa2mblNgEuITT
         9Kug==
X-Gm-Message-State: AOAM5322eQTb3zIR/AwYvfSlVTqY3nb6qBDEHVue4NpNR1QKBQ4hcgeP
	nYpvp+01cJzUJ/LsklAbg0ua2M4ReckFZYqy0UU=
X-Google-Smtp-Source: ABdhPJzbxGsasaB/aV3a2jiRCSam77U3ECltmqMu+jd2GfRa0bFWhrlukSwQDFxCfNtMse2mnVp/Gg==
X-Received: by 2002:adf:f146:: with SMTP id y6mr18264064wro.298.1605910953854;
        Fri, 20 Nov 2020 14:22:33 -0800 (PST)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from matterhorn.localdomain ([2a01:e0a:1b9:3e10:6883:56ff:2b71:f8a3])
        by smtp.gmail.com with ESMTPSA id f16sm6508320wrp.66.2020.11.20.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 14:22:33 -0800 (PST)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH] docs: Makefile: enable parallel build
Date: Fri, 20 Nov 2020 23:22:26 +0100
Message-Id: <20201120222226.378717-1-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From sphinx-build man page:

-j N     build in parallel with N processes where possible
         (special value "auto" will set N to cpu-count)

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 doc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/Makefile b/doc/Makefile
index 4d721d30..d40f390e 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -3,7 +3,7 @@
 
 # You can set these variables from the command line, and also
 # from the environment for the first two.
-SPHINXOPTS    ?=
+SPHINXOPTS    ?= -j auto
 SPHINXBUILD   ?= sphinx-build
 SOURCEDIR     = .
 BUILDDIR      = _build
-- 
2.29.2

