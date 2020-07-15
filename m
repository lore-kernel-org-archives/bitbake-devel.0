Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.web11.7949.1594823244511802395
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=tEws8E1A;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.65, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f65.google.com with SMTP id f16so3052063pjt.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=IXJ/KpRao7LgcwdOQ4Wh/H9RA2kI0Tmv5uPsUZC79p0=;
        b=tEws8E1ApcrgW2w1+UyoI+tbp2SFWFyLY1OHW5w9EDwIXqj9mjjFM7bqfTqKoezkaD
         GxBTba1nY9btIvjJMbpU1mflnFLnhBDJr3sHV/G05+gh+8MHa1ooDM0B0uR2w64k7Jlh
         dPVv8kk86KaIj8qBX6lLW6qlz98Hbv3HrKBPM2vcZTHxGc5yfL23I2iMKFPujz6xF2RS
         WPHzkX5EYC4GS9ohuI1lU1fhzQeX3BofA2bNxdJwEqbc/seW698OnEoZVg4UJ+SdFKAs
         C2EYQUYD3nJdluxeXSa7YXVhhbefXZFy09GBykb2CH7xlq4m/tQv+rvBQXbj45/dppVu
         LLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=IXJ/KpRao7LgcwdOQ4Wh/H9RA2kI0Tmv5uPsUZC79p0=;
        b=Or/DHFdkFS9meO9qQ6oDr0s14s6DLUow9M4ilz2BUxfmXneCGVq2DqVTPCcT1LdcKm
         KqKSXxKh8YEvetQAtWaRLKCc749bEHy2hBTu4KWZtsMzN/MtMSPvG4lvhaEzrI5LTjlH
         qlFmiS7buRR1dsr+RVmsJxjoOXsRaIBbv5v6OSmO0iMonIL6dfiatbkXAnf2rrbQeZab
         GgVqYZRyRHDWXWZYjWWkCe33eJMvtWv/yryT1C9Y7SZF5CigXfyxRmOD6bbmPa10T3CV
         qpTtYHKkS80O0KHM7A5D0K9jO7UlsAmSeBYJOo9wLt8wuQW8LruU/KCVve8r2pbDMV8D
         W5vg==
X-Gm-Message-State: AOAM530hVp4GnRjSYnwLSQb6mhmy9pH6Enck+plN5uy0weMug/gVZXNy
	raACRE71D98JxuHRNbVtN8Zcpx1iqV3j4Q==
X-Google-Smtp-Source: ABdhPJwO9YV/czohgeafl5nlIFKBbuAxisOnSqDmDt3LuzPqE2UtMtFCtsp8eF+sBgGZnh0UMsvp1w==
X-Received: by 2002:a17:902:30d:: with SMTP id 13mr5875040pld.251.1594823243556;
        Wed, 15 Jul 2020 07:27:23 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:22 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/8] lib/ui/taskexp: Validate gi import
Date: Wed, 15 Jul 2020 04:26:43 -1000
Message-Id: <45e32f2651d35bf7a315af95cfe0b1070e038c9e.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594822992.git.steve@sakoman.com>
References: <cover.1594822992.git.steve@sakoman.com>

From: David Khouya <dakhouya@gmail.com>

When running bitbake -g -u taskexp without having gi python module or
and invalid gtk version, bitbake fails with a stack trace.

In case of import or version error, bitbake should exit with an error
message instead of a stack trace.

Signed-off-by: David Khouya <dakhouya@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2a2c507f239b047f34765312df4168030e38b90d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/taskexp.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 8fff2442..336d197d 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -8,9 +8,15 @@
 #
 
 import sys
-import gi
-gi.require_version('Gtk', '3.0')
-from gi.repository import Gtk, Gdk, GObject
+
+try:
+    import gi
+    gi.require_version('Gtk', '3.0')
+except ValueError:
+    sys.exit("FATAL: Gtk version needs to be 3.0")
+except ImportError:
+    sys.exit("FATAL: Gtk ui could not load the required gi python module")
+
 import threading
 from xmlrpc import client
 import bb
-- 
2.17.1

