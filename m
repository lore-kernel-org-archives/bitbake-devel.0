Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
	[209.85.210.169])
	by mail.openembedded.org (Postfix) with ESMTP id 05A027FC09
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:27 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id c13so6333171pfp.5
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=FvkjN1a/fuGbTL+7aj7kGfiKLECiMl7j+ALo+zi/nEg=;
	b=Lzg3LznsZv1uTOvEWDbpZjjRQYsVY1pw/IGmgMqOKBmupvFfMIJjSL4Cx9uyR16K/c
	xPu3vvWluzFyJdSkEbxoYMiCN7dvm+b+4feRlkUtKvOq/PAJaI+I4zpSXoxLT5LCRglb
	P7ECLzTXdbiXmsnP+3lTQQYate+uU86LKUYb1nYWsu4VXoio73S6OXE40EMllhouslqB
	2Iq6mA09xEPcNnklJD789EGL83+dhTAJoUa+d8Mv38mwtwXbhcQu2bmQsBKq9bJUBQCE
	cXHMFWNX294LqI607gr3BjSpcp9y0TS0a2TPZQPtQYBmOJNWyKvYOTm/DK3lGzOES1sP
	UBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=FvkjN1a/fuGbTL+7aj7kGfiKLECiMl7j+ALo+zi/nEg=;
	b=Lxsq+YWq2gxLmejPoLb5WTsA2SsfAAl+k0Gs/V3C86tLl0/Xo1lLYBSCNIZqaVbLx4
	yShI+fn++ZP2F37lXABCCwydshpbrraN7o/S5yoNP5qd2/SGR9UUFImhKnkdydGx3/ni
	zz7gMcAUE8QnU/WM8Z43qz4+qBFbvqXD0w1LYn4XHQtSV+IVLF3gRJmAU6zkqP5/hR4P
	nFtNIh9NQatiJ/rBTqJWymg8cL1Lu4hUjBdkINMxV7C+7ku5CncrVY8HXXtcqysyEsXI
	J6d/26xP8RyKUENmUDAtYx+qyBCedP/N9UYnsVb96pYV+7wvEnQ1BVDYtIjK/A4suWPg
	5N0g==
X-Gm-Message-State: APjAAAVHtjAgS/8HqybYihqwp5iRPNOowsQ2Wx+Vcl005PEb3WrzJg2g
	gJnmBSg79LEXxnMoXl8Xtci1m4cA
X-Google-Smtp-Source: APXvYqxlQvbTZ+ITSQHyuTQXNTWhZ7Ukx8BA2Psx5QPPqfJByi01oaQFOQRXRfkBaSxGTbYE9bzeGA==
X-Received: by 2002:a63:7c03:: with SMTP id x3mr29541154pgc.382.1574639008958; 
	Sun, 24 Nov 2019 15:43:28 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.28
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:28 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:15 -0800
Message-Id: <566a6fe8c217c02f1ba5afc621ae9c3523f35d03.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 2/9] tests/fetch: add test for fetching shallow revs
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:28 -0000

From: Christopher Larson <chris_larson@mentor.com>

[YOCTO #13586]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/tests/fetch.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a0b656b..83fad3f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1863,6 +1863,26 @@ class GitShallowTest(FetcherTest):
         with self.assertRaises(bb.fetch2.FetchError):
             self.fetch()
 
+    def test_shallow_fetch_missing_revs(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        fetcher, ud = self.fetch(self.d.getVar('SRC_URI'))
+        self.git('tag v0.0 master', cwd=self.srcdir)
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
+        self.fetch_shallow()
+
+    def test_shallow_fetch_missing_revs_fails(self):
+        self.add_empty_file('a')
+        self.add_empty_file('b')
+        fetcher, ud = self.fetch(self.d.getVar('SRC_URI'))
+        self.d.setVar('BB_GIT_SHALLOW_DEPTH', '0')
+        self.d.setVar('BB_GIT_SHALLOW_REVS', 'v0.0')
+
+        with self.assertRaises(bb.fetch2.FetchError), self.assertLogs("BitBake.Fetcher", level="ERROR") as cm:
+            self.fetch_shallow()
+        self.assertIn("Unable to find revision v0.0 even from upstream", cm.output[0])
+
     @skipIfNoNetwork()
     def test_bitbake(self):
         self.git('remote add --mirror=fetch origin git://github.com/openembedded/bitbake', cwd=self.srcdir)
-- 
2.7.4


