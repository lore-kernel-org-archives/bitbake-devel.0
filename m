Return-Path: <kergoth@gmail.com>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id 1A46B606B2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 17:08:59 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id l10so14451169wrb.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=lGge4vr6n82k+sAoprhSAIWhybvLnyN8GJ37ehLAVR0=;
	b=AwMb4ogi14Q+8TqhTEIphMhVQ0eO2Cl/iKeF+iXtCTyb11hrkcJ0vKD1lOpMdxFXQh
	dwcPDKZt3IkWAw0XQLel30R/ja/AIvymhMcW0DXosAxSAZ7f2lO8dN6MDLV3tUiATDI7
	zEvxKPDqjskcHI12Tgzyg379lO+LPvrzpBpaYjl1SPjK54SBVNM8IKbkHpWk9KSAwZ1e
	jTSG85674wtczCmxfDyIh9kwwz+sLuIPrV1bi5lWFQsaS9OD/xltSRukK7g+dU0IFbgf
	30m/znkUyfHSk+y/ekcqDqsDBOi6XrhXX1kyycPB6XWP5GFvXjPDkuV/D6oj4YfZkZ8u
	1w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=lGge4vr6n82k+sAoprhSAIWhybvLnyN8GJ37ehLAVR0=;
	b=BxZdpHkGho0UStkQ++hxvUGvrLjWz3+5PLqEVqmbY3I1xM8bHcjQeXD/Nuw7w+9Cxz
	iGzggF5AX0qr9UoKCq77a58Zd/1mCt2W7lhTU2CwfK19HBpAfwSmTWfS/6qn6XEfK1km
	+YcI9cEgpi4Dmu5dLztTKA92IGDio8zv+KK+KYYr+i6gg9h8HlfMOaVXG4qOj7jAr/dh
	d7kmDzQgr7HBYhw+tOkR2ytGV7PAbh8eZyHHwnAVdsfiM6gm8ByHHm9HmSRI8etvFpMM
	TrVq3DIDa4ZBOelCwCzi5J5syFUx/nsWzR2h0VsG4B8vO9Kh8k14KOKkLymdKxwwPyP/
	p9eg==
X-Gm-Message-State: APjAAAXntuwHpRCtS7a/mUitWIkdgO6eRy23bzaS9Vc2V8CVmyYEaerZ
	LhOqV9BSccrKThIu5/t+1MvhAfsi
X-Google-Smtp-Source: APXvYqwNqiVZStha5KNAXC14+kw1PEthvJ6bMsd+SMlu7hbX9YRBQJiLrDFw+CJo908j9VkAvXVsGA==
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr20423007wrw.169.1571677739499;
	Mon, 21 Oct 2019 10:08:59 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id y1sm18532170wrw.6.2019.10.21.10.08.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Oct 2019 10:08:58 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Oct 2019 22:09:54 +0500
Message-Id: <df3bfc72ecd36ebe6109ae0af50f2a6e22ad3bb1.1571423503.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1571423503.git.chris_larson@mentor.com>
References: <cover.1571423503.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 2/2] tests/fetch: add test for fetching shallow revs
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
X-List-Received-Date: Mon, 21 Oct 2019 17:08:59 -0000

From: Christopher Larson <chris_larson@mentor.com>

[YOCTO #13586]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/tests/fetch.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a0b656b6..83fad3ff 100644
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
2.11.1


