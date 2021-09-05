Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.15327.1630880885313509744
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Sep 2021 15:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=U0LjMnLY;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: weaverjs@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id p4so5167418qki.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Sep 2021 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJ4KlN0y9UNvvutCYlsh4E5YsQ7NltHGaaOqoQqBChw=;
        b=U0LjMnLYPUFHKlWpflhyFZZupkZdlPFvVx7JYwOLNCOGx7i8QrJa5iE+SwbF9OrzL/
         qge1lW923gQ1/ccRfnCzCS+0VVWo7bRF+ZIxb2Kh+EU/lek/d+1VVwrfGZ9UByvYgoqO
         lvf29YBDmXNPT229A+npixEKmJI4GowNzcy7Zyscy5Fha7cMkpPWN+LB4ExQPv96HVWw
         fqF4AVI1220uWYUvYbs3DHO7D97vauRsqbjy9iWMNphJqPHilE8QsXmMEd1Z9kAxdFOY
         EODhrbXR4YkErjBOcH8ngad8ZtTVNJLDCB/vYX6pevHeoQM9mvKJXj4JmVckQNZQw4jL
         9ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJ4KlN0y9UNvvutCYlsh4E5YsQ7NltHGaaOqoQqBChw=;
        b=pi4ktH1QeBRKFng21pWTk5fjD3wHgRgJpja3YPacbmisEZQiBO9CAyp/q/nLWfcML0
         Olrdt5xkpWNAVdwwzzvvzq/bgNvkHpSdvqJxGRtswOjFaoIgAGBLIH5sW9W4Hy0aeM6u
         Frt+yFSbMYMHhEXtOLch8OuOomTpV4x8JoE2CnGfVvRRdynOzEdQsUj6R9dimfFK3uPb
         WFq8LeWcTr5vouTeqHdORh3jnpBu/yU7qvZUxmGzomUGjbzb/C5AOHDmPncjARdxKh8G
         Uxd4uixr+JYCnVkvyYrAV+scxbLJjN2rc74sqFvSR/9tSr/MDlXOQV18hbTg81sYlIf9
         dhTg==
X-Gm-Message-State: AOAM5339uvyrPYiOdlHc+ARcnBWVe618lFjsLKTSFeWp4dDTHmN6BR3r
	h0ulkaSwrFIIIhUHooqDnKY+rDK9BnZ6K9eQdA==
X-Google-Smtp-Source: ABdhPJz2rt2QDkCC+JPtDISr6Th3zw1+kqJHb8XdUtcOtK+xHnoGQNpPVN45/b2aUKgA16w/Clf38w==
X-Received: by 2002:a05:620a:318e:: with SMTP id bi14mr8563998qkb.274.1630880884198;
        Sun, 05 Sep 2021 15:28:04 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from p-impout007.msg.pkvw.co.charter.net (cpe-69-133-48-66.cinci.res.rr.com. [69.133.48.66])
        by smtp.gmail.com with ESMTPSA id w12sm4202790qtc.47.2021.09.05.15.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 15:28:03 -0700 (PDT)
From: "Scott Weaver" <weaverjs@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Scott Weaver <weaverjs@gmail.com>
Subject: [bitbake-devel][ 1/3] bitbake: fetch2: fix premirror URI when downloadfilename defined
Date: Sun,  5 Sep 2021 18:27:36 -0400
Message-Id: <20210905222738.1050768-2-weaverjs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210905222738.1050768-1-weaverjs@gmail.com>
References: <20210905222738.1050768-1-weaverjs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
defined using the same URI, the downloadfilename is appended to the mirror
URI and it should not be.

[YOCTO #13039]

Signed-off-by: Scott Weaver <weaverjs@gmail.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 914fa5c024..47a4943369 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename = os.path.basename(ud.localpath)
+                    basename = os.path.basename(uri_decoded[loc])
                 if basename and not result_decoded[loc].endswith(basename):
                     result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
-- 
2.25.1

