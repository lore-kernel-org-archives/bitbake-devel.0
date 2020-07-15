Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
 by mx.groups.io with SMTP id smtpd.web11.7960.1594823256063729981
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Bp9RNkIF;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.196, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f196.google.com with SMTP id k4so2449336pld.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bClQnQotuxm9EInM32FWNIMoCOroxh/BJg4QP59sWww=;
        b=Bp9RNkIFeTbd1VeV+XKC977N4LUpOneHdmnJEk9LMz7D7Lag+F/VPFz+FbWVB35myb
         KBE7qf9e3pN/63gXuBJzqL5cj210XidK2C0qAMCXU50CDTeYkecRzixaMxT7UaHD3/9B
         XkQ4lW67z0iPtw9Ve/ke7nHk4A1DNb5Q57jGxThPh5HRIuS+zgnFo93GwwEjumAWuVsI
         Hr1py9as7KJPaOjQWUmeYxZaX28slEwdjBwSfqtoMnEppCPFAhI9i8z3uqxIcOZSo2Ma
         +FjeDIDZRz8Jb9Lti1fZJFskJ8fPaOmU83tt1D87ma707Gqxst2DVNtWp3hupm7n3yZK
         Ge/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bClQnQotuxm9EInM32FWNIMoCOroxh/BJg4QP59sWww=;
        b=deAGjI3hJ8FwWJubCDxQNsGzfo71wze6qXnQYooSochcUfQguvEMEl2RUOdVxrZIi3
         ziEu7zpLIV6nk/J0VUZwgvl5FJ9T8oJsZ29SAAnhg2Jrp48+3bVbVw1cBTnYbJlu6mJb
         wZzWDuklah9Zf/jObQk2sWvo5gVbinUaJN5JgCv9+wlX+bWkHT4JFiF+ClETvyR75KnF
         Jh9F+rkMbsn1GYJnAWf4v8BGz6EgFg4JfHq3NGi/dYM8GwspSfXeiaLOvP3PNaJJ6UgH
         9MjCINzQ3X0tj2XQyqAQc+wxXdY3WDOKebVSHUulINNBJo1ANlkkOQYPb+QGSnANnSle
         6TDQ==
X-Gm-Message-State: AOAM533QYQe789GTaLVddeqsI7ujYLQFcOiWtadm9qiW2nTceBAYxXg9
	O4s7SoQi0b5hrEd4zeHUvAI3dk+YHXdqvw==
X-Google-Smtp-Source: ABdhPJy+eRtXHogL4apZAfd6dV6CYKc8yCOrv6Rv6LcG72OoeigBMnHAybc8ZqTttszclQUZTYLzMw==
X-Received: by 2002:a17:90a:39c8:: with SMTP id k8mr10869644pjf.118.1594823255200;
        Wed, 15 Jul 2020 07:27:35 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:34 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 6/8] pyshyacc: allow double COMMA statements
Date: Wed, 15 Jul 2020 04:26:48 -1000
Message-Id: <85a499f8915dd6596d56808e6e1c536015e4eb34.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594822992.git.steve@sakoman.com>
References: <cover.1594822992.git.steve@sakoman.com>

From: Konrad Weihmann <kweihmann@outlook.com>

this allows shell statements like '; ;' to pass the parser.
As it may be bad code but still valid enough to execute

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b7732b1b5085bea73e17d112e1bd9ac3d4dc34fb)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/pysh/pyshyacc.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/pysh/pyshyacc.py b/lib/bb/pysh/pyshyacc.py
index de565dc9..924860a6 100644
--- a/lib/bb/pysh/pyshyacc.py
+++ b/lib/bb/pysh/pyshyacc.py
@@ -570,6 +570,7 @@ def p_linebreak(p):
 
 def p_separator_op(p):                 
     """separator_op : COMMA
+                    | COMMA COMMA
                     | AMP"""
     p[0] = p[1]
 
-- 
2.17.1

