Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web12.1252.1593105874378847195
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2020 10:24:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=m9uG7Mkc;
 spf=pass (domain: gmail.com, ip: 209.85.216.45, mailfrom: akuster808@gmail.com)
Received: by mail-pj1-f45.google.com with SMTP id b7so3657317pju.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2020 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=0HJhcCsH08ovBXT83pfGUs8ypTzhtDfs3/imDvfxpl0=;
        b=m9uG7MkcdNcGJiCm9DoVjKfeVwB18HBjhRwTin6o10Lm7F8h7CLcCtnwSjpF4ZVdF+
         4/87OdzAvaiChG+LqbePVkTj37AenHDSX/a/6E7Ao9RwMehj7Ge60yvp+mYO1GxbCu7H
         EPFx4AxHV50eFg4pH/9eWpKf9ESU5JycDQ4axkCNpM43VNH0Gz5A11euVHtvfLk1XJGT
         GDveAr6psYaIjepGe3v/P50U2VPT9bS840xti83m518I0idgu/I6tTo0XABP2Y429MnE
         vLm7FTUUG2T4D8wxzdieEJHfnK85pWv5bJ/tAgIxt6XUgkIp6xG5pYFAwM4s5+UmG+Tk
         ENgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=0HJhcCsH08ovBXT83pfGUs8ypTzhtDfs3/imDvfxpl0=;
        b=SDYJ4SIOqxpapzhpjG+F2iToZt+YADX0d59GPJ/MKInyO5kSMR1cum7eDz3sUj9lUh
         niqDpy+ekBbTGTtoaOtDTJdcLHNZYENlx/caraD5n25ERs0XPfY5kASxOWBGAUc9IV0h
         MEr05JJf/7Q+SkBt7KBOaztWMuQgKejOb+Xekiyq2fUxobwZnSjtGwCgXLrdc6RsFcF6
         YIZDAiVlGAAM8MxsMC6LeE76ai2FsuSlrl+Lm++tbPqL4TBvHfeAVAhFHtTTV8A+VFDV
         /DWR9yUklkpSq8k2sgXZs0bGWyTA40UO+86WRWDioxzvkWcVpV26turh6h3f/I4587jA
         S/hQ==
X-Gm-Message-State: AOAM5310kJL3mh5Jm8tAAjf1S/OPUw5VuEIjKQupfkPHZhsTwUNknbI+
	fVYBkD/o51N7ilx6mi/hcQBtUFRZ
X-Google-Smtp-Source: ABdhPJx4MvQ/xINSfOD2wwPAmSk4dNUzOHiXAl+EltOJ1NTXXIxIPGrt8IqwDK61f5mpsI1uPTj7NA==
X-Received: by 2002:a17:90a:2a04:: with SMTP id i4mr4401815pjd.91.1593105873603;
        Thu, 25 Jun 2020 10:24:33 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:acbe:8216:8a55:1b44])
        by smtp.gmail.com with ESMTPSA id i10sm20127182pgq.36.2020.06.25.10.24.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 10:24:32 -0700 (PDT)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] test/fetch: change to better svn source
Date: Thu, 25 Jun 2020 10:24:31 -0700
Message-Id: <20200625172431.11907-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1

fixes:
svn: warning: W175002: Unexpected HTTP status 504 'Gateway Timeout' on '/openembedded/bitbake/!svn/vcc/default'
svn: E205011: Failure occurred processing one or more externals definitions

picked pcre2

[Yocto #13948]

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4697ef59..29c96b2b 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1031,7 +1031,7 @@ class SVNTest(FetcherTest):
 
         bb.process.run("svn co %s svnfetch_co" % self.repo_url, cwd=self.tempdir)
         # Github will emulate SVN.  Use this to check if we're downloding...
-        bb.process.run("svn propset svn:externals 'bitbake http://github.com/openembedded/bitbake' .",
+        bb.process.run("svn propset svn:externals 'bitbake svn://vcs.pcre.org/pcre2/code' .",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
         bb.process.run("svn commit --non-interactive -m 'Add external'",
                        cwd=os.path.join(self.tempdir, 'svnfetch_co', 'trunk'))
-- 
2.17.1

