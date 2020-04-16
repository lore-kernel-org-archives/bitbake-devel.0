Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web12.2807.1587026957456620156
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Apr 2020 01:49:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=E5ye5TWO;
 spf=pass (domain: konsulko.com, ip: 209.85.128.66, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f66.google.com with SMTP id e26so3657299wmk.5
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Apr 2020 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8SFxII3tkNl/nccQ1cQ64UfoY30IQAJhxr1Q+o9awA=;
        b=E5ye5TWO3lvIK8kyhNrVAUy1UlYCZp2bafLT+WN4zxnqvwcu1tpwc1rKZhRtq1Cy7y
         TlQlXID5zyaj+nFoU/2XYmW/X5VpvXxZq34rE8/EZ+4yPPa7ARVVyc7UcVyliK+Q0+KL
         42SoqrdhHlLPAQ0odwIbaFxUi7Va3hspiNAvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8SFxII3tkNl/nccQ1cQ64UfoY30IQAJhxr1Q+o9awA=;
        b=C5jLHT+HboJiq5XZmRKuegHup2j7VOSNqDukFQGmd82PRDwT+RHFjIvtdWWpe5qU6D
         fvhveWvSHycRQz4X7nlTwFbzBe2i7ZG1BPGRdMRypjtgK/7lp3VdmhXboxskJg3TG5bR
         dMZrQugi+uZpe42QtDytefX8d8cxxpha9n2t6ARR4v4bdCtQMoiU/M+ohfgGfbrd4K4p
         TuqThymplJcytPNyCvP0Q4CnQuv7g8czBjTQ/MDhc/V1ehUVMj3PjgoyecttV75BB5yN
         wOnN32IFjWVcKAiEiek3VNyg9BIwKQwQ6d5RrpXfcpe+5iylii+bzU/l7J+vtlV0sp54
         Xy3Q==
X-Gm-Message-State: AGi0PuatXQ6SdcP7h69E/DT9v+IopOQe6cTyB3XRIYcZdJkEfIjQUqCW
	yTmoDp+B08ovpioHxu7/nn06uhF8bOtdNA==
X-Google-Smtp-Source: APiQypL/aUmcIStawDuwZ0hGyikfNAnBXVLP7uh972MihcVu9wHsAoNwXtYrMyq50bO98MwWz+uEcw==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr3645335wmi.178.1587026955808;
        Thu, 16 Apr 2020 01:49:15 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from ub1910.Hitronhub.home ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id i16sm8863946wrm.8.2020.04.16.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:49:15 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <pbarker@konsulko.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH] fetch2/wget: Set User-Agent when checking status of a URL
Date: Thu, 16 Apr 2020 09:49:05 +0100
Message-Id: <20200416084905.6453-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a website is behind a CDN like Cloudflare there may be a "Browser
Integrity Check" or other test applied to requests before they are
allowed through to the server. Downloading via wget passes these tests
as headers are set appropriately, however the Python urllib module may
fail these tests unless additional headers are set. This causes
Wget.checkstatus() to fail where Wget.download() would actually succeed.

For Cloudflare in particular a valid User-Agent is needed, it's easy to
add this to the headers in Wget.checkstatus(). The user agent string is
copied from Wget._fetch_index().

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/fetch2/wget.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 5235ae4d..f7d1de26 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -300,6 +300,7 @@ class Wget(FetchMethod):
             # Some servers (FusionForge, as used on Alioth) require that the
             # optional Accept header is set.
             r.add_header("Accept", "*/*")
+            r.add_header("User-Agent", "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12")
             def add_basic_auth(login_str, request):
                 '''Adds Basic auth to http request, pass in login:password as string'''
                 import base64
-- 
2.20.1

