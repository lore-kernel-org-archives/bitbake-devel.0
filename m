Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web11.9445.1629635722131261298
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Aug 2021 05:35:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=hgrzMXJq;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: weaverjs@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id l3so11523274qtk.10
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Aug 2021 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQunx82kUOcfhKAs1H3rUYrI4u1BFb6sqFq5WIpZ6Cs=;
        b=hgrzMXJqyuqgJ0VQrcPqShh/hxOzAAOf8Kh130ONSQAAa1qhicvIAWvAm/F31Wn2ut
         o+5bGQM9UF93dmM+RLDTSp9OHI29wP/cZ8rfxQsMYcDhCCIwz5QhbDw6LnjjELY5/6Xz
         IheKh/xTJfAiyaXfGCvx1bHDPFzY9Xh/U548eGuKI4T4KfL938x4uHBAouaBIZRiu2AN
         wvPv3rjVkVvWLs2+xjKt0ZLQk4Gq+WroT4mH2/5Bh8xSZ7hMEIIx8UOhqNSXX+2qVXZ9
         bHemDN2AVgJUg5oHycb/As4qZaApVw885B0lpyGouxpV5fb8WLSik8eliaZCxHhMI1iw
         aYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQunx82kUOcfhKAs1H3rUYrI4u1BFb6sqFq5WIpZ6Cs=;
        b=Dq+tuITaXPMm+KF+LDgQU+a1NyzZm+UWH4tG1An24FjbHRUKtaB54AS1+GvZx3DN02
         OLTqdzbV/iBhTpFNqlkJODvdxArmjMc7QGfKvvCGPC4gN7mslCrGOJgsu618t/EzCTbb
         yuStwwYFTVp21Cqd4j5NA52MCjiOYUQjq1Pf70yJ5HjNr7dMdwGaRUEJzVpY5/wwOfqf
         ZreAgNxNsn/Kczc3bSFJJTKgSGpfBtF0GJtKLluoPtXy4CWNXzuXAkG2mbp+VMDciWe5
         2sHCrB2fRfP+hDFCQEhKen7LQvJn0gRmMb+rBvnj4YY5YU9Eq+4mPn2x6Q4tXKj4EsNQ
         GF0g==
X-Gm-Message-State: AOAM531m9h+p9zlvE2uQTzL8BnAYhEv0Qyc5Vqwu7Ii8p+ISPwkHQk5T
	qu7nJoR9jPBMgIExEbl1ce1aAdJt3KDndWIyBQ==
X-Google-Smtp-Source: ABdhPJwrWykxr/JZNCejAbvRdWmvNXWMF/9d0HErLFo4wCQgVbuE1uHsbfC/hdHQzxyeM9JoyXk1Mw==
X-Received: by 2002:ac8:544e:: with SMTP id d14mr7153268qtq.133.1629635721027;
        Sun, 22 Aug 2021 05:35:21 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from p-impout003.msg.pkvw.co.charter.net (cpe-69-133-48-66.cinci.res.rr.com. [69.133.48.66])
        by smtp.gmail.com with ESMTPSA id i123sm6605020qkf.60.2021.08.22.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 05:35:20 -0700 (PDT)
From: "Scott Weaver" <weaverjs@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Scott Weaver <weaverjs@gmail.com>
Subject: [bitbake][PATCH] bitbake: fetch2: correct PREMIRROR URI
Date: Sun, 22 Aug 2021 08:34:47 -0400
Message-Id: <20210822123447.3477259-1-weaverjs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When downloadfilename is defined in a recipe's SRC_URI and a PREMIRROR is also
defined for that URI, the downloadfilename is appended to the mirror URI and it
should not be.

[YOCTO #13039]

Signed-off-by: Scott Weaver <weaverjs@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 914fa5c024..0bcd566e83 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -467,7 +467,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
                     basename = os.path.basename(ud.localpath)
-                if basename and not result_decoded[loc].endswith(basename):
+                if basename and result_decoded[loc].endswith('/'):
                     result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
             return None
-- 
2.25.1

