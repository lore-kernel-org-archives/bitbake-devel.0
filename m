Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.21650.1627918934222097634
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Aug 2021 08:42:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WN88tU3y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id m12so17206230wru.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Aug 2021 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOnLeEL8dzjKV2sR00WIeobGc+7CqR+S1rJFGlEQseA=;
        b=WN88tU3ysolpicTC4+rK/jUvFc2j/1SyUSEYP1E4gW4kACBv4/WFHmRTwYi3havQcr
         VJdtvgy4Ac2bOPa/KEsurNl42178zUEvydxuicqL4WU5Ttas+hMgZ1beDD1jIVZRbF3h
         um9VASFjm6uCetE53GC5644WTVUl/rd/Q/7Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOnLeEL8dzjKV2sR00WIeobGc+7CqR+S1rJFGlEQseA=;
        b=rkV56LN/59bRTA3AwkUcU58OqD6p9F9MYLMrJwuNKJqZk21T58T0ni4TQRnTMXTNJc
         qJJV019MS5tVEH2pPe6qWb5CrjqXWQxQSi0dC/bFDBws81lkl9sWovVDvsFuJoTIArw8
         6l7MG/bURX78y+Sotu4IPPja/bH2q3xCMmESOUxYAtJ6IrnIGAyAJoJUyoIGNh+iE5o/
         2AryeipYODmxumo7tGSrDfkUOmrbVpukEQr+vkfF3fJsskOpqzG8GYDtqFOpW4yKIS8w
         JrylwxtnSWm+S/wLWwEkQJmK5mtO3nl+aUdgJzg8VMy5BqwUw921D4TuCTSPBPlCLczg
         7FoA==
X-Gm-Message-State: AOAM533jqX1d78uO6XhAPtkzS1RLIpe2P8Yl3xEniUr0NTDjKKxtfkgc
	pWhZC+/qp2WJmjs86aKscX7JSDap1cw5bw==
X-Google-Smtp-Source: ABdhPJxPv2eHVgFDSJNXA7EPkm/lEd5hh9zooKLMtHYInAMHofPu2+pDdiQk5yPuJE2vb5v3xPStwA==
X-Received: by 2002:a5d:5147:: with SMTP id u7mr18389562wrt.181.1627918932801;
        Mon, 02 Aug 2021 08:42:12 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9aac:cd42:2ef7:1a7c])
        by smtp.gmail.com with ESMTPSA id a207sm12652024wme.27.2021.08.02.08.42.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:42:12 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Fix inactive overide accidental variable value corruption
Date: Mon,  2 Aug 2021 16:42:12 +0100
Message-Id: <20210802154212.3453639-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting something like:

  BAR:append:unusedoverride

should cause BAR to be None, not "" which was what the datastore was
returning. This caused problems when mixing variables like:

  RDEPENDS:${PN}:inactiveoverride
  RDEPENDS:${BPN}

since key expansion would report key overlap when there was none. This
is a bug in the datastore. Fix it and add a test too.

[YOCTO #14088]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 8 ++++----
 lib/bb/tests/data.py | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 43e9e78555..65528c6ae6 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -750,8 +750,6 @@ class DataSmart(MutableMapping):
 
 
         if flag == "_content" and local_var is not None and ":append" in local_var and not parsing:
-            if not value:
-                value = ""
             self.need_overrides()
             for (r, o) in local_var[":append"]:
                 match = True
@@ -760,11 +758,11 @@ class DataSmart(MutableMapping):
                         if not o2 in self.overrides:
                             match = False                            
                 if match:
+                    if value is None:
+                        value = ""
                     value = value + r
 
         if flag == "_content" and local_var is not None and ":prepend" in local_var and not parsing:
-            if not value:
-                value = ""
             self.need_overrides()
             for (r, o) in local_var[":prepend"]:
 
@@ -774,6 +772,8 @@ class DataSmart(MutableMapping):
                         if not o2 in self.overrides:
                             match = False                            
                 if match:
+                    if value is None:
+                        value = ""
                     value = r + value
 
         parser = None
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 7f1d3ffbbc..e667c7c7d3 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -405,6 +405,11 @@ class TestOverrides(unittest.TestCase):
         bb.data.expandKeys(self.d)
         self.assertEqual(self.d.getVar("VERSION"), "2")
 
+    def test_append_and_unused_override(self):
+        # Had a bug where an unused override append could return "" instead of None
+        self.d.setVar("BAR:append:unusedoverride", "testvalue2")
+        self.assertEqual(self.d.getVar("BAR"), None)
+
 class TestKeyExpansion(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()
-- 
2.30.2

