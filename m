Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web12.33872.1601900836122095821
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2020 05:27:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=PFOENm+G;
 spf=pass (domain: linaro.org, ip: 209.85.221.51, mailfrom: nicolas.dechesne@linaro.org)
Received: by mail-wr1-f51.google.com with SMTP id e17so639410wru.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2020 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjhK+6LYPv+trMAYj89yE14k9vVl5otlLdUEOLdvAEk=;
        b=PFOENm+GYTgzyZ3ZaNdrUQr/jdlwYUKthMzriwwTSwrJuz/G+7eCogyR8QXGVYsp3T
         EkME4yV4JZwHCAzsO1Jo8lSPgqAIKUiaEwnlKWmNKhvL4biCpvep0eMTq0v2uA6O3DQN
         x3xtpMWgzOklWM34izLKMTuXrjv0G0LSXPW5ZXQWBqxdVgvm9rTKyhpd9QL6NbPZlE04
         RerzJBSV84IFwINLNHcIqS+nLhDF0PYI063GIVG3V9Yh23x+HYZ87/U6pX31wNfI/gpv
         pVmvQ1QWmAkVsw52Q+AUfSpyFf8PjxfK+7EhmRgG9BTb6DjKGq9fo7PtixRRvcwst9IC
         EmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjhK+6LYPv+trMAYj89yE14k9vVl5otlLdUEOLdvAEk=;
        b=c15J4c38Hn2jMO+3GdYc6k+Ce4QOglqieD64SKbp5ZFFudKMy9ntLTv/xRNEGZzyRC
         001D+2crCXTZoAD5pzSPc+gf9D+TFmjPhWqxZJrHmLeNxnr/ilvElOjxfqlsxG0Rgd+H
         kS8FRb8MlJ6xtQAXhDlQOsrzJSxcytK8kqMoe1N+FBad1GYaU2fLU8xd55/XS69KFhqT
         qEwMjW/W2yUKL0NZPpPwjUTynXOLkmhzyWqquhN3P8Y++y+q0dFz+vrVYoji+YUkInGn
         tIBBk36aM5Asw+wSNWq4hqrHltI5lsD1TTUGKEBw5ORcjAmX2FY2ljc067DhKY8nN2m3
         oVyQ==
X-Gm-Message-State: AOAM5327O+vAb3ek5D5uNFNVZdv0c5YP81UisTXQwsf7xtOr+x2YB2YN
	HYv9RR57TNazoHkQrSwV3NR+II+mfijg6Q==
X-Google-Smtp-Source: ABdhPJzdgRtOiSbJ/6MHykuR+rMdOakrieV8PLoccQxmDa/IYDT+Ad09VyreJplZOU0ZKzWecGRT8g==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr17318797wru.163.1601900834151;
        Mon, 05 Oct 2020 05:27:14 -0700 (PDT)
Return-Path: <nicolas.dechesne@linaro.org>
Received: from localhost.localdomain (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id c130sm1953628wma.17.2020.10.05.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 05:27:13 -0700 (PDT)
From: "Nicolas Dechesne" <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: foss@0leil.net,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH 3/5] docs: update README file after migrationg to Sphinx
Date: Mon,  5 Oct 2020 14:26:50 +0200
Message-Id: <20201005122652.392528-4-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
References: <20201005122652.392528-1-nicolas.dechesne@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 doc/README | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/doc/README b/doc/README
index 303cf8ee..62595820 100644
--- a/doc/README
+++ b/doc/README
@@ -15,25 +15,41 @@ Each folder is self-contained regarding content and figures.
 If you want to find HTML versions of the BitBake manuals on the web, 
 go to http://www.openembedded.org/wiki/Documentation. 
 
-Makefile
-========
+Sphinx
+======
 
-The Makefile processes manual directories to create HTML, PDF,
-tarballs, etc.  Details on how the Makefile work are documented
-inside the Makefile.  See that file for more information.
+The BitBake documentation was migrated from the original DocBook
+format to Sphinx based documentation for the Yocto Project 3.2
+release.
 
-To build a manual, you run the make command and pass it the name
-of the folder containing the manual's contents. 
-For example, the following command run from the documentation directory 
-creates an HTML and a PDF version of the BitBake User Manual.
-The DOC variable specifies the manual you are making:
+Additional information related to the Sphinx migration, and guidelines
+for developers willing to contribute to the BitBake documentation can
+be found in the Yocto Project Documentation README file:
 
-     $ make DOC=bitbake-user-manual
+https://git.yoctoproject.org/cgit/cgit.cgi/yocto-docs/tree/documentation/README
 
-template
-========
-Contains various templates, fonts, and some old PNG files.
+How to build the Yocto Project documentation
+============================================
 
-tools
-=====
-Contains a tool to convert the DocBook files to PDF format.
+Sphinx is written in Python. While it might work with Python2, for
+obvious reasons, we will only support building the BitBake
+documentation with Python3.
+
+Sphinx might be available in your Linux distro packages repositories,
+however it is not recommend using distro packages, as they might be
+old versions, especially if you are using an LTS version of your
+distro. The recommended method to install Sphinx and all required
+dependencies is to use the Python Package Index (pip).
+
+To install all required packages run:
+
+ $ pip3 install sphinx sphinx_rtd_theme pyyaml
+
+To build the documentation locally, run:
+
+ $ cd documentation
+ $ make -f Makefile.sphinx html
+
+The resulting HTML index page will be _build/html/index.html, and you
+can browse your own copy of the locally generated documentation with
+your browser.
-- 
2.28.0

