Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.33873.1601900837300980727
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 05:27:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=LIo92qCX;
 spf=pass (domain: linaro.org, ip: 209.85.128.44, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-wm1-f44.google.com with SMTP id j136so8583259wmj.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2020 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X07ZQ5bTSf4CKJAnC/k7HfVYyZcLDNPLpYYJTIgVBg4=;
        b=LIo92qCXpczT/cAEYIgOTyOUn0o3f95xuXcgDoAO5HiL4Y8/s6j8J1Hw1gMFxvgP2a
         FHsQBhzUQ2NEg1OrnHkn2z/if2jkIvdXUTLouSVj/RlA4+QuBha6yHvmDOFgxz8kyvm0
         lOYklkXF86KjRR2gpcUkEjUwYlvmyng0Z+yR840FlBx2CclQg0DfVAq8jxaYZMHszAXe
         o1p1ANMyryQSZHXs246+rBPx/TZiVF/x2PRTNV5L7JB+9WSFC/g4jQgf17wYshZvo9tm
         6ba7w4yn+RNmn7tV7+NuFkRKH+xX5qffZGShib2HT1EmOuVC5qLUmAr6AchygaZNTzYg
         HcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X07ZQ5bTSf4CKJAnC/k7HfVYyZcLDNPLpYYJTIgVBg4=;
        b=T9ZNliGVQTbI0eZRbjssyE2YRXnWtiJJyC6RlIIoFZCVaAnjH8ieV2+EJ+JvRJYMfL
         sTACosGMOwEjhhh/cuA2uTOOQnUjZShSHBHqqOKzy7PVYvrbQvWuxuf+w4hYBMXutv4n
         bdmx2bC/LMkWaxby8Qx3AcvQrywAlDdEFNujfpkYfB29VMvCRcVbGr9yHrVaxO6ule76
         qxVmjPmtE3uo1O7LiYoaA/6bijYERx5XFWY9+x/Fol7MnLYBxFP8W2Q0TwQh7c4wihn4
         sRhKWkqUBJgYLhtg+Po5hAWUGjYf6CrTOrKsJgkX+A8cQjNQYRe3xAGGF+iU/4T0balf
         kPDg==
X-Gm-Message-State: AOAM530fkbBeQWRKgpgGu2rZ6EuOdmb06LRRKF2HFLBgI2I6dbpafuDc
	s/Mxb23p3P/5OIsnBhgZrujkIOb02i/bZQ==
X-Google-Smtp-Source: ABdhPJywID4gYSBXumu/YvIZ0hR9GNvEkgd2/a/kLNsJCefZXUkhvozaUr9f45eH7IqHObWZiAPx6w==
X-Received: by 2002:a7b:ca42:: with SMTP id m2mr17308167wml.145.1601900835395;
        Mon, 05 Oct 2020 05:27:15 -0700 (PDT)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from localhost.localdomain (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id c130sm1953628wma.17.2020.10.05.05.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:14 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: foss@0leil.net,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH 4/5] docs: sphinx: report errors when dependencies are not met
Date: Mon,  5 Oct 2020 14:26:51 +0200
Message-Id: <20201005122652.392528-5-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
References: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 doc/Makefile.sphinx | 4 ++++
 doc/conf.py         | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/doc/Makefile.sphinx b/doc/Makefile.sphinx
index c663c295..c9518558 100644
--- a/doc/Makefile.sphinx
+++ b/doc/Makefile.sphinx
@@ -9,6 +9,10 @@ SOURCEDIR     = .
 BUILDDIR      = _build
 DESTDIR       = final
 
+ifeq ($(shell if which $(SPHINXBUILD) >/dev/null 2>&1; then echo 1; else echo 0; fi),0)
+$(error "The '$(SPHINXBUILD)' command was not found. Make sure you have Sphinx installed")
+endif
+
 # Put it first so that "make" without argument is like "make help".
 help:
 	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
diff --git a/doc/conf.py b/doc/conf.py
index 197f2757..354dff36 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -73,7 +73,13 @@ rst_prolog = """
 # The theme to use for HTML and HTML Help pages.  See the documentation for
 # a list of builtin themes.
 #
-html_theme = 'sphinx_rtd_theme'
+try:
+    import sphinx_rtd_theme
+    html_theme = 'sphinx_rtd_theme'
+except ImportError:
+    sys.stderr.write("The Sphinx sphinx_rtd_theme HTML theme was not found.\
+    \nPlease make sure to install the sphinx_rtd_theme python package.\n")
+    sys.exit(1)
 
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,
-- 
2.28.0

