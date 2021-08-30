Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web09.12636.1630295824872870920
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Aug 2021 20:57:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=HkbtDNo8;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: weaverjs@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 4so816663qvp.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 29 Aug 2021 20:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lx/p+/rW540xATkRsGMfg872grR2MO5TKpkiedBrfTs=;
        b=HkbtDNo8qOF5l5O6V91y+glO3VFQRg2EphNF1EsHhQEgzvR0/AoA63UK4RNR7o5lJg
         0OFvgrNMg8L0GkLUs5iFr6QGVUsvz/iprfGnWiogWbMzLEl78O3AH3O2/w2r6kP+7i5P
         kylQ0Malcmcv5eLiPvmryHgXaPOsHfUjPtH0xvKpNF2UQBJR4RwxD1qn9w15j2HjX+/8
         4kg5Z/f0TAPcF/LVQmNM4e8A/hYcCTRcMYijjn1dhSKeOUHt6I9RPfOoWKnyCa1umanm
         FxP2ZdXfcIYewN1+y2W3AgxYNwmwdAqcVM2c3tbjFtJt4XR55Iiq+1ASG0YydF7vZS6Z
         4KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lx/p+/rW540xATkRsGMfg872grR2MO5TKpkiedBrfTs=;
        b=KOmmWhSzdMST7NyTrv6t1BQXTDDIXnUoqGme812Irzd5Xn+XvoSMrz9Ka9VvFgWpE1
         uD3nx4rjwQ+o9L1Llhx+++N4IJuN25bOpqMuFiQrNN8dm/0LKiI9KsWM1Ayt4ddQpq/z
         c+JcZfkNLl1v46a03o/6hqYGCyniHm2ihGmLx+07oCiZmGXxL471Eehi7k+H9IZEKtqI
         ++cg/7VvyrckI+S2xGXpU4mCbrO5nlIu6gxOeyG2SQvHzkXQa6nZ3KEj4QMEtlQttfPA
         bjVZNF/wBm/9/nBEhtheZVzO3GXhlmwT68NmRjDpKtDGFU/5yVoDJE7c4HJSYW9SJPXz
         /JaA==
X-Gm-Message-State: AOAM531fNkIB/LtZRWhnifaux+w3G79j/SpfGihY94NOshCtQwn7rjTp
	t6C9EX8zNc9+Qk6xaYK2TpLAkeY+Qv2MG6WdfA==
X-Google-Smtp-Source: ABdhPJyZRgG8YrHbpyH/N9ufHZoERG+li+zL81OFEEPLLTj/pqV/QgXpKHCadrozCfD1uz7SEiDxoQ==
X-Received: by 2002:a0c:e883:: with SMTP id b3mr20897995qvo.16.1630295823642;
        Sun, 29 Aug 2021 20:57:03 -0700 (PDT)
Return-Path: <weaverjs@gmail.com>
Received: from p-impout009.msg.pkvw.co.charter.net (cpe-69-133-48-66.cinci.res.rr.com. [69.133.48.66])
        by smtp.gmail.com with ESMTPSA id n11sm10755270qkk.17.2021.08.29.20.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 20:57:03 -0700 (PDT)
From: "Scott Weaver" <weaverjs@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Scott Weaver <weaverjs@gmail.com>
Subject: [bitbake-devel][RFC][PATCH] bitbake: fetch2: correct PREMIRROR URI
Date: Sun, 29 Aug 2021 23:56:30 -0400
Message-Id: <20210830035630.3634069-1-weaverjs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When downloadfilename is defined in a recipe's SRC_URI and a PREMIRROR is also
defined for that URI, the downloadfilename is appended to the mirror URI and it
should not be appended.

Three new fetch bitbake-selftest tests were added to test downloadfilename
scenarios.

[YOCTO #13039]

Signed-off-by: Scott Weaver <weaverjs@gmail.com>
---

This fix is for BZ13039.

downloadfilename is defined as "the filename used when storing the downloaded
file" under the definition of SRC_URI [1].
This definition appears to be echoed in 44.3.2 where it says downloadfilename
"allows the name of the downloaded file to be specified" [2]. Although, the
second definition isn't as clear and could be interpreted to mean that the
name of the file to be downloaded can be specified. Which, if intentional,
would not match the first definition.

I believe that the first definition is the correct definition of
downloadfilename.

I've added three new tests to bitbake-selftest's fetch testsuite.

Executed against the master branch, the following new tests fail (see patch):

test_fetch_premirror_specify_downloadfilename_regex_uri() fails because
the fetcher attempts to download the downloadfilename.

test_fetch_premirror_specify_downloadfilename_specific_uri() was added
to address BZ13039 and is expected to fail.

These tests pass when executed with this patch applied.

However, this change breaks the test that I have commented out in the patch
which is executed by MirrorUriTest.test_urireplace.
I don't believe this is a valid test because a mirror is normally the location
where an artifact can be found and should not specify the filename itself.

I recognize that there might be someone using PREMIRRORS in this way
given that a test was written for this use case and maybe this is a valid
definition of a mirror but this is what leads me to this RFC.

I would like your opinion on my interpretation of downloadfilename and if you
think that it's okay to remove the commented out test. Thus, any use of
PREMIRRORS in this way will now fail because this patch assumes that a mirror
only defines the location and would not include the filename.

[1] https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#var-SRC_URI
[2] https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#http-ftp-fetcher


 bitbake/lib/bb/fetch2/__init__.py | 19 ++++++++++++++++---
 bitbake/lib/bb/tests/fetch.py     | 26 ++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 914fa5c024..01e0d1becf 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -466,8 +466,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename = os.path.basename(ud.localpath)
-                if basename and not result_decoded[loc].endswith(basename):
+                    basename = os.path.basename(uri_decoded[loc])
+                if basename and result_decoded[loc].endswith('/'):
                     result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
             return None
@@ -527,12 +527,25 @@ def fetcher_compare_revisions(d):
     headrevs = dict(bb.persist_data.persist('BB_URI_HEADREVS', d))
     return headrevs != bb.fetch2.saved_headrevs
 
+def mirror_fixup(mirrors):
+    # Ensure that the mirror uri contains a terminating directory separator.
+    # Git mirrors shall not be modified.
+    for m in mirrors:
+        if not re.search("^git:", m[1]):
+            if not ';' in m[1]:
+                m[1] = os.path.join(m[1], "")
+            else:
+                s = m[1].split(';', 1)
+                uri = os.path.join(s[0], "")
+                m[1] = "%s;%s" % (uri, s[1])
+    return mirrors
+
 def mirror_from_string(data):
     mirrors = (data or "").replace('\\n',' ').split()
     # Split into pairs
     if len(mirrors) % 2 != 0:
         bb.warn('Invalid mirror data %s, should have paired members.' % data)
-    return list(zip(*[iter(mirrors)]*2))
+    return mirror_fixup([list(m) for m in zip(*[iter(mirrors)]*2)])
 
 def verify_checksum(ud, d, precomputed={}):
     """
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 9291ce4a06..7b6d253186 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -395,6 +395,7 @@ class FetcherTest(unittest.TestCase):
 
 class MirrorUriTest(FetcherTest):
 
+    # (<src_uri>, <mirror_regex>, <mirror>):<expected_result>
     replaceuris = {
         ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "http://somewhere.org/somedir/") 
             : "http://somewhere.org/somedir/git2_git.invalid.infradead.org.mtd-utils.git.tar.gz",
@@ -412,8 +413,8 @@ class MirrorUriTest(FetcherTest):
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "http://.*/.*", "http://somewhere2.org/somedir3") 
             : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
-        ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz") 
-            : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
+        #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz")
+        #    : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2", "http://www.apache.org/dist", "http://archive.apache.org/dist")
             : "http://archive.apache.org/dist/subversion/subversion-1.7.1.tar.bz2",
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2", "http://.*/.*", "file:///somepath/downloads/")
@@ -866,6 +867,27 @@ class FetcherNetworkTest(FetcherTest):
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

