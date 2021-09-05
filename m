Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web08.15334.1630880893940571628
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Sep 2021 15:28:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lnBwNa8b;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: weaverjs@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id f22so5155092qkm.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Sep 2021 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TdL3JgOVGv0GTaUpnEmC4NhFxzuedqlZpC74pwdHlaQ=;
        b=lnBwNa8bY41f9jJJUNv8otR1l6QCCnnWn/61zpEsfnFgLc8bDRx0lbV5pRCwN/FMl9
         l2k2JHSkFw5e61b2nkv8XMAHAjFFdh3VVGgyWcahWJod293jgMpD4i3j7gKKE4QKRXbJ
         1/gOT+gY4PbfzEZOhCvmz5IzXUUjqpKQefmGVsmqRzLcl1PGv8k6aOVp3kmPJJdfetnu
         DvuOvZ25PprbRkzel+d8tktgY+ibkdDxrVO5G7j00WwsQED1WY8+RshI3k7FRi1khucn
         4Yjzc91nc6mGGKjVEkgtxM1Q1nbj7b0vHZcO4g6U6wig5v+qDMzzKxmKxdn9wTk/wre5
         opAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TdL3JgOVGv0GTaUpnEmC4NhFxzuedqlZpC74pwdHlaQ=;
        b=l26XXLVoNtU7VSa44tSD4/gVnyOFKrKkNB9P89Y26LSyZwi/UnRZP3iR6WCMX0CsvP
         lbXcWRo8uxKGjkwWJBD6d5aLyBJOz8cVuQbhzIL0J5SMNIFo3mopw7LC+cyloKfEeSj3
         jm+62o2+aM073mQ9iO5dFV+RyT6pF7ecaKpCOhwQT9Y+ii8qOff72slq8hsvCSo9mQDI
         ACY/Vv+0jxWK+4JSI8hgseOFziKP1QpPThh+9QdZAOEVSnkeCGdLIU6sFCjw2TY9XOB4
         t8ldbBA30pbMkdORO0TrG/wCq4CGrvW2Ay77xDLfidr0aN0yapd1WXTJ5IFtYwLU5UeO
         4xZA==
X-Gm-Message-State: AOAM532Ho/jWLdYdMufWThlvf65BgKq6ZuD1/bvQWkNGtZTPZJoLHO9c
	7mStS4Li+UPsvPWx98wuCgU6srYC3tkucI3dqw==
X-Google-Smtp-Source: ABdhPJxqiqPXT8DKjGLZ3BrIUKJuvBNJtquU8U3SlgeAg/H3Bh2uaLomU//ke022DCyLngENmjwruQ==
X-Received: by 2002:a37:58b:: with SMTP id 133mr8718922qkf.146.1630880892774;
        Sun, 05 Sep 2021 15:28:12 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from p-impout007.msg.pkvw.co.charter.net (cpe-69-133-48-66.cinci.res.rr.com. [69.133.48.66])
        by smtp.gmail.com with ESMTPSA id w12sm4202790qtc.47.2021.09.05.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 15:28:12 -0700 (PDT)
From: "Scott Weaver" <weaverjs@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Scott Weaver <weaverjs@gmail.com>
Subject: [bitbake-devel][ 3/3] bitbake: tests/fetch: add and fix npm tests
Date: Sun,  5 Sep 2021 18:27:38 -0400
Message-Id: <20210905222738.1050768-4-weaverjs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210905222738.1050768-1-weaverjs@gmail.com>
References: <20210905222738.1050768-1-weaverjs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds one new test that verifies the use of a specific filename
when defined in PREMIRRORS.

bb.tests.fetch.NPMTest:
	- test_npm_premirrors_with_specified_filename

While testing bz#13039, it was found that test_npm_registry_alternate
fails with ENOTFOUND. This was corrected by using npmjs's public mirror.

The change to fetch2 for bz#13039 highlighted an issue with the
test_npm_premirrors test where the created file:// mirror was using the
downloadfilename rather than the tarball that is defined by the npm url.

Signed-off-by: Scott Weaver <weaverjs@gmail.com>
---
 bitbake/lib/bb/tests/fetch.py | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 1735d0b071..242be36891 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2278,9 +2278,10 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
         # Setup the mirror
+        pkgname = os.path.basename(ud.proxy.urls[0].split(';')[0])
         mirrordir = os.path.join(self.tempdir, 'mirror')
         bb.utils.mkdirhier(mirrordir)
-        os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(ud.localpath)))
+        os.replace(ud.localpath, os.path.join(mirrordir, pkgname))
         self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/\n' % mirrordir)
         self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
         # Fetch again
@@ -2288,6 +2289,27 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
 
+    @skipIfNoNpm()
+    @skipIfNoNetwork()
+    def test_npm_premirrors_with_specified_filename(self):
+        url = 'npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+        # Fetch once to get a tarball
+        fetcher = bb.fetch.Fetch([url], self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+        # Setup the mirror
+        mirrordir = os.path.join(self.tempdir, 'mirror')
+        bb.utils.mkdirhier(mirrordir)
+        mirrorfilename = os.path.join(mirrordir, os.path.basename(ud.localpath))
+        os.replace(ud.localpath, mirrorfilename)
+        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s\n' % mirrorfilename)
+        self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
+        # Fetch again
+        self.assertFalse(os.path.exists(ud.localpath))
+        fetcher.download()
+        self.assertTrue(os.path.exists(ud.localpath))
+
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_mirrors(self):
@@ -2350,7 +2372,7 @@ class NPMTest(FetcherTest):
     @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_alternate(self):
-        url = 'npm://registry.freajs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+        url = 'npm://skimdb.npmjs.com;package=@savoirfairelinux/node-server-example;version=1.0.0'
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
-- 
2.25.1

