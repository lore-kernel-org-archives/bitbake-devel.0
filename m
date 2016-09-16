Return-Path: <akuster808@gmail.com>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
	[209.85.220.67])
	by mail.openembedded.org (Postfix) with ESMTP id 2348A731F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 23:36:50 +0000 (UTC)
Received: by mail-pa0-f67.google.com with SMTP id my20so995272pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=WjTk5b5k0JYgJY7r7qEQ5HaoVgn/H825Ta3Y4uEDjNg=;
	b=ZbQiP1Gjab+PGjGGVOGo+2n2x37dCEYA57TX93/5baTlgIgozQxvfpfRl6ClSeM5YD
	lY5ZWcgjs+OnieD53hMnhv75e0Qh0vRtzW8IXhiiGqBBm/5XoITv6hFcYPBo2Redqzpz
	wc4+7qBU3vHgDQ5CY3OZex511wQ7GE8wZp1cS1nVbjbXep004pzkx9fAHNtGI+/Rv5MY
	kURrDDOItyrAEZdblZylBgq8LlVzOb5fmvhUdS5i7PaAVJHo6+/gD8cCi2Kp1cjzAFb+
	BTom45j3PyKfFrv1kSe+E4Ac8w135WqX3V4MmIiZ8M+hrwCLAY5tIQsB8VlRKPZIeVWW
	8WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=WjTk5b5k0JYgJY7r7qEQ5HaoVgn/H825Ta3Y4uEDjNg=;
	b=Vp6ZFi3A8cgaMnKxiFjsOVYLuo1Owrnz9qyxz2KETa9HoxuTgVKEz3dB/iXLXEkXOz
	FOQVuw8ZWRONfCzV4APa+iL2j3G/noumw8nWeAJI+uovfM40ey3nLyTSERQw+gdJJ+Gt
	COCh70VQl0qQLIfOZo2b/AQJVgPDYyuOXt6VmbUVZsQ78sLRFx78rRHEjQkit7rWZ2cV
	t7vfMsS5kZJHFHmjG4BHpiBww+riVLohfQI4/f7CXSTeAl4xu3IlPfGvQFVa0+qXL80g
	jsEe22uhdKopVnSUCYW3Ka4WKJSDBJlU1XZcHIgNcrjZzoIkhsx/4Z5sYTYLHqxSh7cR
	FVFA==
X-Gm-Message-State: AE9vXwM1r23G6UmjVv/FBLT3DunD+AqNN9kAugHhFbxWcqJX9/iPQCee+h1xl3q1ISQpPw==
X-Received: by 10.66.172.228 with SMTP id bf4mr26850614pac.137.1474069011351; 
	Fri, 16 Sep 2016 16:36:51 -0700 (PDT)
Received: from akuster-ThinkPad-X240.mvista.com
	([2601:202:4001:9ea0:142f:f172:55ee:c116])
	by smtp.gmail.com with ESMTPSA id q9sm8988434pfi.35.2016.09.16.16.36.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 16:36:50 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	akuster808@gmail.com
Date: Fri, 16 Sep 2016 16:36:43 -0700
Message-Id: <1474069004-10786-3-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
References: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
Subject: [PATCH 2/3] lib/bb/tests/fetch: remove URL that doesn't exist anymore
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
X-List-Received-Date: Fri, 16 Sep 2016 23:36:51 -0000

From: Ross Burton <ross.burton@intel.com>

The CUPS ipptool URL we were checking now redirects to github where the tarball
isn't present, so remove it from the test suite.

Signed-off-by: Ross Burton <ross.burton@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 4b50895fb3462b21e3874a2e99c363c8d05e89e6)
Signed-off-by: Armin Kuster <akuster@mvista.com>
---
 lib/bb/tests/fetch.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 73eba8c..7a08be0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -726,7 +726,6 @@ class FetchLatestVersionTest(FetcherTest):
 
 class FetchCheckStatusTest(FetcherTest):
     test_wget_uris = ["http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2",
-                      "http://www.cups.org/software/ipptool/ipptool-20130731-linux-ubuntu-i686.tar.gz",
                       "http://www.cups.org/",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.1.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
-- 
2.7.4


