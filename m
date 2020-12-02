Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.2628.1606902637260438502
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Dec 2020 01:50:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="unable to parse pub key" header.i=@blade-group.com header.s=google header.b=bjUIVhkf;
 spf=pass (domain: blade-group.com, ip: 209.85.221.44, mailfrom: yann.dirson@blade-group.com)
Received: by mail-wr1-f44.google.com with SMTP id 23so2847036wrc.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Dec 2020 01:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blade-group.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DUq8bjCFuILCPQMw3pzz8KVXpUqVTKWsagKe9ljZwM=;
        b=bjUIVhkffd4dJuL4bjSvjbi3AHkoDmFcV/D8iXIEkGOoEC7iOFgNPbYJEEboHqUujK
         XlyrU0lN4OJH/ttwadOgbctbfWcoIlGFiTUEBTeFfgwQ/vGyinZ3mSEWh05WxRbp5XF2
         2WGO4DgDfMcJ7DzmnlDwQW+JLT4d639feIHXtTDT6GR0ToOqFjeGQpfV7nYVAXUwWB5j
         OS3M1de5XyymSlQ74qS2aScCeTExCxhvrzG/jCXBN2wD91ajKuy7YlyOHO+dEMVGKEKz
         uOTn5GYL3oJTKOtrgA4KMUn2+btuhRuTqiPa67PzBkFW8IiDaO9Xsmtl5gnUjdjjxs1X
         eB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+DUq8bjCFuILCPQMw3pzz8KVXpUqVTKWsagKe9ljZwM=;
        b=a5z0A6em4JpOBkkJf3pZJz9LOBlOwMK1RJe+mDoUpdeLmiANbsBW6Nms8BUM7Ky8OS
         1GBVy635hblY4mGJ0nEWKT5CGOH2NgXdAyQR8DBw8aRKbgvTJEALpuT3Vcon5GTdoFB4
         cZS3bQeBxW7YZ0EuWeG5DCkpYSCvuJRxyD124GWChh6Nx+78WdJIkb99YJfWroNeKScd
         9tXv3f0nETE7P5PA0I3riVPokiMeUKENIgKr15olq0u3mAIZp/3LHVd9/krUmHrUtaeg
         ZZLnJYJaz/T4KMSDckMRUqA1Wd/1U2tXZhDH3yxcHnay1VKzGvOFmF3ImnFntb0tqsB6
         wzSw==
X-Gm-Message-State: AOAM530txl7my0ely8h9Vp6PWuztMynpvwj6jwJLnRZ9uJe7enIgbjiI
	Ldwg/IjoQ4bp/WJsyAPbg0ygLEvmjX00pQ==
X-Google-Smtp-Source: ABdhPJywOFzqHi9Z+o1HSHMlOSDbSZuMih5TMg13vHF+K6PLtdPe8VcggLbsYcvS1IQTXwtwovdkwA==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr2328833wrt.425.1606902635049;
        Wed, 02 Dec 2020 01:50:35 -0800 (PST)
Return-Path: <yann.dirson@blade-group.com>
Received: from blanquette.blade-group.net ([88.120.44.86])
        by smtp.gmail.com with ESMTPSA id a1sm1425015wrv.61.2020.12.02.01.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:50:34 -0800 (PST)
From: "Yann Dirson" <yann.dirson@blade-group.com>
X-Google-Original-From: yann@blade-group.com
To: bitbake-devel@lists.openembedded.org
Cc: Yann Dirson <yann@blade-group.com>
Subject: [RFC][PATCH] fetch2.wget: add support for per-source download flags
Date: Wed,  2 Dec 2020 10:50:20 +0100
Message-Id: <20201202095020.1439530-1-yann@blade-group.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yann Dirson <yann@blade-group.com>

Adds support for a new FETCHFLAGS_wget variable, overridable for
individual SRC_URI entries:

 FETCHFLAGS_wget = "--some-flag"
 FETCHFLAGS_wget[uriname] = "--some-better-flag"

Typical use: add authorization headers to a request, for example to
access a gitlab private package registry:

 FETCHFLAGS_wget[foo] = '--header="Authorization: Bearer ${FOO_NPM_REGISTRY_TOKEN}"'
---
 lib/bb/fetch2/wget.py | 6 ++++++
 1 file changed, 6 insertions(+)


If this approch is OK, I guess this will need a doc update.


diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index e6d9f528..d9ec6e3b 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -99,6 +99,12 @@ class Wget(FetchMethod):
         if ud.user and ud.pswd:
             fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user, ud.pswd)
 
+        flags = d.getVar("FETCHFLAGS_wget") or ""
+        pername_flags = d.getVarFlags("FETCHFLAGS_wget")
+        if pername_flags and ud.names[0] in pername_flags:
+            flags = pername_flags[ud.names[0]]
+        fetchcmd += " " + flags
+
         uri = ud.url.split(";")[0]
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
-- 
2.29.2

