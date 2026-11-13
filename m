Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9473.1794571485915145382
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Nov 2026 04:04:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fxk/XOhJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so14591305e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Nov 2026 04:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794571484; x=1795176284; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gS/aiBBaxXcWEBK9zqm3LOfH7uSXcgNDiEY4epL6Z3k=;
        b=fxk/XOhJoPNzjLQu+cuGkQdT2LvAzFB0h+u2FIPPqT4ApNQ3QLEUJ3+LYVVZogPz+d
         88/EYkhl8NAZQ3yp7Gk6maDCuBtkDLiIWsCrx/Kqr7Pgs1raPnYcl8jYwYyOAlzXYJGg
         oEjMH0LKqv15x5oxwx/jxZFe80twa1bZN0PUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794571484; x=1795176284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gS/aiBBaxXcWEBK9zqm3LOfH7uSXcgNDiEY4epL6Z3k=;
        b=k5sS5QX7mHOkOrM7IleedMcrF0hehwDfU53vWTDVm0Vy6k7/u/V7vUxA3KGzovcprV
         hWfox1Gz03O4MT4IfQG6zi4zYc3nI3onb9WZpJq21EMQe5GgIcBIt06XIpl2WxTrxjBG
         143qIAa2neI0XrFQFM4uJb844yRHsoEomfZqUuHs2HhSKKdYCtF2XI53aEsgid4pirUv
         Uw0zZlPvFL1lf1V+TQPLatyMXiym6OqflNavq8Q71rsWxZmC0sFVq/FVQbcMh4gYNRdX
         pvYvg2CxwqMQro5IEVMCF1IXk3P9qyzS2kOd732/eiQXkdtFpTYX2wXpw50unwjvTub6
         mklQ==
X-Gm-Message-State: APuU4Z9jowuX0+hoKAaZHJIcj9eIBotsruxiUPHhhhuty2y/WWKqzsr6
	it4Rkkxdi/IIcMVmyVsYfSLlfC8u4xdwsj4oarLeSACsBkm0RoujhJBv+e9FmqPBlR6zUgIOtPh
	RSjz6IaU=
X-Gm-Gg: AYBFou2XvSp0j2bruUaUbNfKFLPZpjq4RoX6ObbQxnzKY2rSnJpYDRFWAKDnu83U0vi
	fPEU8ioe7/9ThebVbpkfLvythamKNrS77oj8ZOyaJxZv6LyU+SV3s8WmJpFSwuKxKydfmU+8uhL
	CbRnTYyI/490kKos/K9La6VnMzOVst+QfdC5uDrFP1sd3lpECECh9XEO204/AwjkfwVnmUizKn1
	JQcB8gGqVgY0V60Oo0MiF2RzPV5TU6IgKyV1CNNvmT7r/CqxTm3V6Vmh6zoMpBatfR83DXLxM2e
	Fu1xTTGn3pi2cHR0K2x0fzgTVZe+TvLdLSz+jN1MSuyoifGXkAM60eJSwFCRULVoUAI1WNKMDci
	YeMPzkxbSfkHSo3qn62TFJT20KTdPe6pA+65O3fUyLZy3iQzVT085OoOGJZf5tvmox5I60mOWYk
	V3b0ZsFgQZ1T05+wB6BfiMnbJ9cTmS7MZcYZajc7PXHlWyiI+hPqM5Bsbxf2RZHxHZDE+LQr0bA
	ggcYGLrVTvClDuejb+RUokmP0sJoIPTD+uTDwrZi10OIQDTw6i26PCUh62TLDM8/zQnn23kZv3r
	+aEiv9CjsrS0Grt1v1T99f6dR9lca06cf/WjdDZsx+zpRfkQ1BGgEyy9hQ==
X-Received: by 2002:a05:600c:1f96:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4bb55a4eb97mr44291595e9.12.1794571483621;
        Fri, 13 Nov 2026 04:04:43 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1d86:400b:8b66:ddaf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5b4a3fcdsm21111305e9.0.2026.11.13.04.04.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:04:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Fix/remove broken git directory naming test
Date: Fri, 13 Nov 2026 12:04:41 +0000
Message-ID: <20261113120441.226372-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 13 Nov 2026 12:04:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20429
Content-Type: text/plain; charset="utf-8"

The fetcher changed behaviour in that it now fetches changes directly into
git trees without needing a separate clone directory for mirrors. This invalidates
assumptions tests were making, they just happened to pass depending on ordering.

Drop the broken test and rename the other to be clearer/simpler.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1a33671a4fb..92000b509e0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -592,18 +592,7 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         self.assertIn(self.recipe_dir, dir)
 
     @skipIfNoNetwork()
-    def test_that_directory_exists_for_mirrored_url_and_recipe_url_when_mirroring_is_used(self):
-        self.setup_mirror_rewrite()
-        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
-
-        fetcher.download()
-
-        dir = os.listdir(self.dldir + "/git2")
-        self.assertIn(self.mirror_dir, dir)
-        self.assertIn(self.recipe_dir, dir)
-
-    @skipIfNoNetwork()
-    def test_that_recipe_directory_and_mirrored_directory_exists_when_mirroring_is_used_and_the_mirrored_directory_already_exists(self):
+    def test_that_directory_is_named_after_recipe_url_when_mirroring_is_used(self):
         self.setup_mirror_rewrite()
         fetcher = bb.fetch.Fetch([self.mirror_url], self.d)
         fetcher.download()
