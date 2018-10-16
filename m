Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id 0D7D879A5C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Oct 2018 19:27:14 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id 63-v6so26854782wra.11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Oct 2018 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=idgWi58WCFa4KiH+KNvR76LcCYtci4+sRIHwXd99bzA=;
	b=REmFiMupBmnXF7o13EMP+2VuB9xP5TshQ7iAq+kpHxgUQMZAkKN9OKmIUIfc/mOzhs
	9jbf79IVE9D0D0jyfqjXMf9623LFnLK7bSdnETl07cRuE2joPnSZ4hwQgwp9hWfvwySc
	xi3dQSk1H5/ZI9kfs8wDqKeAxDfHGTPAqMhnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=idgWi58WCFa4KiH+KNvR76LcCYtci4+sRIHwXd99bzA=;
	b=mrO8F29bZopLj0s9ChmyaFiZEFTwt1qtH674HrymmUw0R3M67ZZjhZLnc6cm3On6Ok
	enr12VNuIWrXuOczRtTBarQLeLQVDUct7dPuLg5KoNd6TZCbROVnnVOcRVLkj4JVcKS3
	O18AnJFhvhD5Hwl4LI3SLWuM+ZvflrhOzO3XNJfrfz+KIgTHIO9vEihfPgqUH3SHTlcl
	YCB98amVNYZ8jfgC4IPID8N907QnCdkaLyNGVLaA3GjTgs4wo+cxlrsWLB+Pi0T6TECT
	3LQ1OSBix41FzZcE/fnnRMsmE7TlkBSIptJIhFgUBV/Yce29ZtPpuB8nNboTpPn3x2BJ
	1K2g==
X-Gm-Message-State: ABuFfoipZmt3RazYl1BexiPbTqmqqKoGojcnWTyzlEbRI6abyUh5jBgW
	p+7pZUgHk2fiIpZ0hdK2K47Bf5/40IQ=
X-Google-Smtp-Source: ACcGV61+oNpzAHnYU8Nfa7mqFR/OL+lcuGx+SAOEb8aQ6yL+vDUNFl+njp5O9wjeykYIAeoB+L4YtA==
X-Received: by 2002:adf:fc0b:: with SMTP id
	i11-v6mr21691384wrr.9.1539718035243; 
	Tue, 16 Oct 2018 12:27:15 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j2-v6sm11979148wrw.29.2018.10.16.12.27.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Oct 2018 12:27:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 16 Oct 2018 20:27:08 +0100
Message-Id: <20181016192709.15771-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016192709.15771-1-richard.purdie@linuxfoundation.org>
References: <20181016192709.15771-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/3] data: Fix whitespace on _remove operations
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 16 Oct 2018 19:27:15 -0000

We have some slightly odd behaviours with the current implementation of
_remove operations. For example:

TEST = " A B"
TEST_remove = "C"

would trigger TEST to become "A B" even thought it doesn't contain "C".

In particular, this means that an inactive remove operator added in a
bbappend could change the task checksum which is not desireable.

Fix the operation to preserve whitespace, adding new tests to make this
explict and test further corner cases. Also update the manual to match.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-metadata.xml          |  6 +++---
 lib/bb/data_smart.py                          |  5 +++--
 lib/bb/tests/data.py                          | 20 +++++++++++++++----
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index bc08c814d1..fc55ef6483 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -342,7 +342,7 @@
 
             <para>
                 When you use this syntax, BitBake expects one or more strings.
-                Surrounding spaces are removed as well.
+                Surrounding spaces and spacing are preserved.
                 Here is an example:
                 <literallayout class='monospaced'>
      FOO = "123 456 789 123456 123 456 123 456"
@@ -352,8 +352,8 @@
      FOO2_remove = "abc def"
                 </literallayout>
                 The variable <filename>FOO</filename> becomes
-                "789 123456" and <filename>FOO2</filename> becomes
-                "ghi abcdef".
+                "  789 123456    " and <filename>FOO2</filename> becomes
+                "  ghi abcdef    ".
             </para>
 
             <para>
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 4434142a02..0a8488ca1b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -42,6 +42,7 @@ __setvar_keyword__ = ["_append", "_prepend", "_remove"]
 __setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>[^A-Z]*))?$')
 __expand_var_regexp__ = re.compile(r"\${[^{}@\n\t :]+}")
 __expand_python_regexp__ = re.compile(r"\${@.+?}")
+__whitespace_split__ = re.compile('(\s)')
 
 def infer_caller_details(loginfo, parent = False, varval = True):
     """Save the caller the trouble of specifying everything."""
@@ -818,8 +819,8 @@ class DataSmart(MutableMapping):
 
             if removes:
                 filtered = filter(lambda v: v not in removes,
-                                  value.split())
-                value = " ".join(filtered)
+                                  __whitespace_split__.split(value))
+                value = "".join(filtered)
                 if expand and var in self.expand_cache:
                     # We need to ensure the expand cache has the correct value
                     # flag == "_content" here
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index a4a9dd30fb..8279115e03 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -281,7 +281,7 @@ class TestConcatOverride(unittest.TestCase):
     def test_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.d.setVar("TEST_remove", "val")
-        self.assertEqual(self.d.getVar("TEST"), "bar")
+        self.assertEqual(self.d.getVar("TEST"), " bar")
 
     def test_remove_cleared(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
@@ -300,7 +300,7 @@ class TestConcatOverride(unittest.TestCase):
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.d.setVar("TEST_remove", "val")
         self.d.setVar("TEST_TEST", "${TEST} ${TEST}")
-        self.assertEqual(self.d.getVar("TEST_TEST"), "bar bar")
+        self.assertEqual(self.d.getVar("TEST_TEST"), " bar  bar")
 
     def test_empty_remove(self):
         self.d.setVar("TEST", "")
@@ -311,13 +311,25 @@ class TestConcatOverride(unittest.TestCase):
         self.d.setVar("BAR", "Z")
         self.d.setVar("TEST", "${BAR}/X Y")
         self.d.setVar("TEST_remove", "${BAR}/X")
-        self.assertEqual(self.d.getVar("TEST"), "Y")
+        self.assertEqual(self.d.getVar("TEST"), " Y")
 
     def test_remove_expansion_items(self):
         self.d.setVar("TEST", "A B C D")
         self.d.setVar("BAR", "B D")
         self.d.setVar("TEST_remove", "${BAR}")
-        self.assertEqual(self.d.getVar("TEST"), "A C")
+        self.assertEqual(self.d.getVar("TEST"), "A  C ")
+
+    def test_remove_preserve_whitespace(self):
+        # When the removal isn't active, the original value should be preserved
+        self.d.setVar("TEST", " A B")
+        self.d.setVar("TEST_remove", "C")
+        self.assertEqual(self.d.getVar("TEST"), " A B")
+
+    def test_remove_preserve_whitespace2(self):
+        # When the removal is active preserve the whitespace
+        self.d.setVar("TEST", " A B")
+        self.d.setVar("TEST_remove", "B")
+        self.assertEqual(self.d.getVar("TEST"), " A ")
 
 class TestOverrides(unittest.TestCase):
     def setUp(self):
-- 
2.17.1


