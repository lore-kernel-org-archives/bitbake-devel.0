Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web08.6784.1628070946973544726
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Aug 2021 02:55:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KReWSZy6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id p5so1541442wro.7
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Aug 2021 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ddfk0y+EzefXZQh1UtseV4mSSc1BqgTBMQ3a/Bc9TPg=;
        b=KReWSZy6TkjC6BkOhCOrubW0fK0As6DiOy1Mnd1yALGmV5nv4h1kSs00Zwd5S2RdYk
         TiNsBE9C/rMJ12djnrEe8kCdVoHERGEtV5tsC0JVBw6k16/4/LiGtKPt4nEYDDQ1ggw7
         2ZepxtQG5lqMORJ7wF4gwK7XVv1FR/SBNGDTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddfk0y+EzefXZQh1UtseV4mSSc1BqgTBMQ3a/Bc9TPg=;
        b=XK2QJZ9jGzsCPzDF226nJ/9ssiP6QKziO0roWU6vkJAtJINa7e3iWuG0NDqM0V7LEL
         MGMGCPWqlVZq8t4eDeYMJq67zGmZKuQ6p4w4uMQYPIUwV7UeTNaduIbn/Vg8pdw0/Rdb
         BP8tNCiwzWS3Nvoz3jTr5C9h83BlXl5f/1cqyGYYV22npLPh6Az3HdNJDD4zhKKJ8lYh
         fA1stjoCATs8Uw4O7sV8R/9VL3mChEG61M5r+NZZ/Po99DjDL4LxKQrmDKMkJt/o1sCl
         CxxTbcpHiTg7uC38Vy9Wtw5mY0vxh7jKCSMPVV/Ya8pg2ASSJUJJS/56SyQFtJkckX6d
         MR0A==
X-Gm-Message-State: AOAM533UyVEi9T7RDtuHvmNTDph+zMQW/4xXd47tBHFS16HjQQ+Ze+Up
	e9ePskTDkyxCJCjeHjH0LaNdYSAlDzAWhA==
X-Google-Smtp-Source: ABdhPJwTQGWQNS3HGY6gQR+neUsweRIVlcVztPTgVCHKmgxNX3xiLUyajH06P2e7O//jTEQ4GUyJkw==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr27828384wrr.100.1628070945552;
        Wed, 04 Aug 2021 02:55:45 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:895b:15d0:6c2e:72fa])
        by smtp.gmail.com with ESMTPSA id k17sm1855512wrw.53.2021.08.04.02.55.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:55:45 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] fetch/tests/toaster: Override conversion fixups
Date: Wed,  4 Aug 2021 10:55:44 +0100
Message-Id: <20210804095544.3500614-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804095544.3500614-1-richard.purdie@linuxfoundation.org>
References: <20210804095544.3500614-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some references that missed during the overrides syntax migration or
were incorrect. Thanks to Quentin Schulz <foss@0leil.net> for the patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py       | 2 +-
 lib/bb/tests/parse.py           | 2 +-
 lib/bb/utils.py                 | 2 +-
 lib/toaster/toastergui/views.py | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 60aaf3902a..ad898680ff 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1146,7 +1146,7 @@ def srcrev_internal_helper(ud, d, name):
     pn = d.getVar("PN")
     attempts = []
     if name != '' and pn:
-        attempts.append("SRCREV_%s_pn-%s" % (name, pn))
+        attempts.append("SRCREV_%s:pn-%s" % (name, pn))
     if name != '':
         attempts.append("SRCREV_%s" % name)
     if pn:
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 1b6b6d412e..4d17f82edc 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -99,7 +99,7 @@ exportD = "d"
 
     overridetest = """
 RRECOMMENDS:${PN} = "a"
-RRECOMMENDS:${PN}_libc = "b"
+RRECOMMENDS:${PN}:libc = "b"
 OVERRIDES = "libc:${PN}"
 PN = "gtk+"
 """
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 6ba1d2a376..e6e82d1118 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1178,7 +1178,7 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
         variables: a list of variable names to look for. Functions
             may also be specified, but must be specified with '()' at
             the end of the name. Note that the function doesn't have
-            any intrinsic understanding of _append, _prepend, _remove,
+            any intrinsic understanding of :append, :prepend, :remove,
             or overrides, so these are considered as part of the name.
             These values go into a regular expression, so regular
             expression syntax is allowed.
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 04ab8bcb04..74f9d56963 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1840,7 +1840,7 @@ if True:
             pass
         try:
             context['image_install:append'] =  ProjectVariable.objects.get(project = prj, name = "IMAGE_INSTALL:append").value
-            context['image_install:append_defined'] = "1"
+            context['image_install_append_defined'] = "1"
         except ProjectVariable.DoesNotExist:
             pass
         try:
-- 
2.30.2

