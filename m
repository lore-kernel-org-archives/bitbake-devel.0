Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.584.1602515298874792175
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2020 08:08:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=hBR3tzmC;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id h2so8729908pll.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2020 08:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gEplYJSRlEj+FPBB60mtZJ6bLO4hZl/Mo5q5s25Quns=;
        b=hBR3tzmC6ZQLu/yObdQ1Z5MQHhg8zWJSO4Ynx8mCpbveCpIaSBlUgoMGWZgOfHi2CM
         0AjcxG69rxEVHNdMjVMTMmeGjbuWuuEOIeNBn3T3XBUNaOvl9e3UadjSaXAL4zLbcwkn
         6uoHUoFbXUXCamFsmOG7nrQuhc5wndDdVqXgPGvc1SThMjZTx7iCikLz8ZUhGTdDpNBA
         1h8dI04mdX1SJhzARHJB7rTZX6KKK50R+pew4LCCqoYYClGpvG7XnPp+de0Y5u0zsv7f
         P4+6gWrZnyjmbBjKxTOvIO5ek3TEk6fGOhPR+pS5oLJE2Y1tELR2nA+lUAZX3dgwLYny
         GKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=gEplYJSRlEj+FPBB60mtZJ6bLO4hZl/Mo5q5s25Quns=;
        b=A2moeXxOgXPcZFLW+JNqJAnM4VW8vCKEwlGHW0ut8mNT+GmRk8eVrU2FMNLKWwBFY6
         XTdZzb+JqV6B3H61MFvzlIblYljLGd3dtqriozJnvnFVlSkkzu597gfsJ/jolIaWk+yV
         M720Zltb88cejwFSpQ3rDxDd3QZ3rzp0KdANfNjr4IqGBqBOBgkCcq0WbgkNvkCY3dCa
         SXu8kgAJVgEOx2V785bveyhwCjqTFctvTeuZufpfYejS7LfYKe9u694oXiOPBMb0aNix
         4jQItAM916Rqxpxz2dXEV6jT8W4I+0OYuaBrADeHlnliBAhUpN/WLVCYRgu5YfA/y5/z
         n7BA==
X-Gm-Message-State: AOAM5313OzI4lBS0ikPHVbcd/v2tP4QXzLTVpvYTrguJov7g5n4HKXvc
	fCvgu4yY/kejYgi2zApOXKb76nvEnGkd3puq
X-Google-Smtp-Source: ABdhPJwEuNzEsqwfM1rsNIlr8EqmYK6MF0QgPYmuYnmv9FJQ9X811CdvfHpmE9TiPgY51nvl5X3ZrA==
X-Received: by 2002:a17:902:c1d2:b029:d3:ea72:cdec with SMTP id c18-20020a170902c1d2b02900d3ea72cdecmr24541918plc.47.1602515297913;
        Mon, 12 Oct 2020 08:08:17 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id f9sm24009246pjq.26.2020.10.12.08.08.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:08:17 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] bitbake: tests/fetch: add unit tests for SRC_URI with spaces in url
Date: Mon, 12 Oct 2020 05:07:53 -1000
Message-Id: <1c2a787d2b70b81a8d2adbbbb2eba726297b841b.1602515077.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602515077.git.steve@sakoman.com>
References: <cover.1602515077.git.steve@sakoman.com>

From: Charlie Davies <charles.davies@whitetree.xyz>

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e7dab75c8d1923abcbbc7c9ac7de215d720ccf26)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b1883541..f7fe78b4 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -223,6 +223,21 @@ class URITest(unittest.TestCase):
             'query': {},
             'relative': False
         },
+        "git://tfs-example.org:22/tfs/example%20path/example.git": {
+            'uri': 'git://tfs-example.org:22/tfs/example%20path/example.git',
+            'scheme': 'git',
+            'hostname': 'tfs-example.org',
+            'port': 22,
+            'hostport': 'tfs-example.org:22',
+            'path': '/tfs/example path/example.git',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'query': {},
+            'relative': False
+        },
         "http://somesite.net;someparam=1": {
             'uri': 'http://somesite.net;someparam=1',
             'scheme': 'http',
@@ -2080,6 +2095,38 @@ class GitLfsTest(FetcherTest):
         shutil.rmtree(self.gitdir, ignore_errors=True)
         fetcher.unpack(self.d.getVar('WORKDIR'))
 
+class GitURLWithSpacesTest(FetcherTest):
+    test_git_urls = {
+        "git://tfs-example.org:22/tfs/example%20path/example.git" : {
+            'url': 'git://tfs-example.org:22/tfs/example%20path/example.git',
+            'gitsrcname': 'tfs-example.org.22.tfs.example_path.example.git',
+            'path': '/tfs/example path/example.git'
+        },
+        "git://tfs-example.org:22/tfs/example%20path/example%20repo.git" : {
+            'url': 'git://tfs-example.org:22/tfs/example%20path/example%20repo.git',
+            'gitsrcname': 'tfs-example.org.22.tfs.example_path.example_repo.git',
+            'path': '/tfs/example path/example repo.git'
+        }
+    }
+
+    def test_urls(self):
+
+        # Set fake SRCREV to stop git fetcher from trying to contact non-existent git repo
+        self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
+
+        for test_git_url, ref in self.test_git_urls.items():
+
+            fetcher = bb.fetch.Fetch([test_git_url], self.d)
+            ud = fetcher.ud[fetcher.urls[0]]
+
+            self.assertEqual(ud.url, ref['url'])
+            self.assertEqual(ud.path, ref['path'])
+            self.assertEqual(ud.localfile, os.path.join(self.dldir, "git2", ref['gitsrcname']))
+            self.assertEqual(ud.localpath, os.path.join(self.dldir, "git2", ref['gitsrcname']))
+            self.assertEqual(ud.lockfile, os.path.join(self.dldir, "git2", ref['gitsrcname'] + '.lock'))
+            self.assertEqual(ud.clonedir, os.path.join(self.dldir, "git2", ref['gitsrcname']))
+            self.assertEqual(ud.fullmirror, os.path.join(self.dldir, "git2_" + ref['gitsrcname'] + '.tar.gz'))
+
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
         import shutil
-- 
2.17.1

