Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web08.15333.1630880889159895747
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Sep 2021 15:28:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ZAMBc9wN;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: weaverjs@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id 22so5171121qkg.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Sep 2021 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V9JBU+I1rTB4JQoCdrSrore0Y4pJSoDtsHCGzSErY1M=;
        b=ZAMBc9wNkdkR6HIWDvWLMeziZYO5Iqyyg+WIy/pf2BpRrcEliH4OLyE7heKZNJNvLi
         unOqd5kIQ1l35UprpvS0A9z/F2VvmyhT90XRSUMsbCa6LJJU8MTzDVv5fugv+MICiKBP
         8QdZOvN0LxCtmBPSubq5mUkz31QFJ4IoU6+StWncRybJ4KSr4Z4e0o5gxlOz4GFtUd8b
         0apcHZFSvTZQdmdF3MT1b3OUvBKz6pnA8FhOy2TTKO7Y0vjDF9dvlacogbZrFI0l2Mz/
         DOh6vrLqTgs3tw8ws7Qppg20wlTE1zD9eWw+YdQv1I4AgL/xA+dcKEf1APOhOe8igWPs
         IeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9JBU+I1rTB4JQoCdrSrore0Y4pJSoDtsHCGzSErY1M=;
        b=aFVJ4Q+SGJzJaQmFNh5ejNXACG0wKHplOtMQuRJEG+A0qULjskW85e9NwMZK0KyGJ8
         w4gzkFqpsTBGGBUwid7MDVSB700INl0ypNBSe29Utdw98SMOfB9aBOTNQ90TrFSH7z/j
         zdVtwOqbPkqws9AfNYzL9TNdl+xcNlgOOj3W4/tzRFWtMc7ne116RkeqOunwoE1o0n1m
         T5ZAtlHAUtTHDpPqQ64CCits5kDIVuai7Lt5VUWRcEWqvtFojw7gq+W8kZhRdsCVjIQP
         BThzDqoXfUfszfCpRUY6ChC/cunlmXagQ1oElx1LIScQup99MwrgesXgGMiT7QiDuJBu
         wxLA==
X-Gm-Message-State: AOAM531t/Zi9qD5mUBR4gxm3fvzaiALxg1nnWB1X1k9ETv0lHHPb/NJO
	jDMgmy4x6VzU9PDXHO43PN37u1+0qf5GbnR/lA==
X-Google-Smtp-Source: ABdhPJyTgIX/B/eSGP5/T9BmCLKv6zylXA4kQePCgqgPZyI1NPJxcdJNuhefgBCyIzFQMBmtzmbXug==
X-Received: by 2002:a37:b686:: with SMTP id g128mr8531752qkf.68.1630880887887;
        Sun, 05 Sep 2021 15:28:07 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from p-impout007.msg.pkvw.co.charter.net (cpe-69-133-48-66.cinci.res.rr.com. [69.133.48.66])
        by smtp.gmail.com with ESMTPSA id w12sm4202790qtc.47.2021.09.05.15.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 15:28:07 -0700 (PDT)
From: "Scott Weaver" <weaverjs@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Scott Weaver <weaverjs@gmail.com>
Subject: [bitbake-devel][ 2/3] bitbake: tests/fetch: add downloadfilename tests
Date: Sun,  5 Sep 2021 18:27:37 -0400
Message-Id: <20210905222738.1050768-3-weaverjs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210905222738.1050768-1-weaverjs@gmail.com>
References: <20210905222738.1050768-1-weaverjs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds three new tests which evaluate different use cases of the
downloadfilename property.

bb.tests.fetch.FetcherNetworkTest:
	- test_fetch_specify_downloadfilename
	- test_fetch_premirror_specify_downloadfilename_regex_uri
	- test_fetch_premirror_specify_downloadfilename_specific_uri

Signed-off-by: Scott Weaver <weaverjs@gmail.com>
---
 bitbake/lib/bb/tests/fetch.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 9291ce4a06..1735d0b071 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -866,6 +866,27 @@ class FetcherNetworkTest(FetcherTest):
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
+    @skipIfNoNetwork()
+    def test_fetch_specify_downloadfilename(self):
+        fetcher = bb.fetch.Fetch(["http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar.gz"), 57749)
+
+    @skipIfNoNetwork()
+    def test_fetch_premirror_specify_downloadfilename_regex_uri(self):
+        self.d.setVar("PREMIRRORS", "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake/")
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar.gz"), 57749)
+
+    @skipIfNoNetwork()
+    # BZ13039
+    def test_fetch_premirror_specify_downloadfilename_specific_uri(self):
+        self.d.setVar("PREMIRRORS", "http://invalid.yoctoproject.org/releases/bitbake http://downloads.yoctoproject.org/releases/bitbake")
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar.gz"), 57749)
+
     @skipIfNoNetwork()
     def gitfetcher(self, url1, url2):
         def checkrevision(self, fetcher):
-- 
2.25.1

