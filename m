Return-Path: <akuster808@gmail.com>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
	[209.85.192.196])
	by mail.openembedded.org (Postfix) with ESMTP id C456B70030
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 23:36:48 +0000 (UTC)
Received: by mail-pf0-f196.google.com with SMTP id n24so4151644pfb.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fJ8aJXvboDwbDptswd1oyV0FpiVzCR0dWrrScwGk3u4=;
	b=Ucisi4Qkvyw0qcgF6L2GdfrnMmL54WPEQf6ukkNam6M7TOZigpFXheD5DDbw36X+hA
	pDCUDMhykIPUUbpXW6izP6dIxREj7DD4IJeFUTUWaudZU4u124GF7AxtGYhoUmKa9QwU
	KlOQGUYadK70YeWAQ5a+/1WVQolAV7N3kjZCSxqxUjVBALGOAIoLO4zKup46Tdlk3g1n
	Vk9kh/ED9djUVcn+cyPZoGxDog/Ktd+OgdLLsycUokzVhnSd4RlZztJUXizGAWfrfoHU
	qCGvL/mMA6T6YShSpZdtxNsye53Wox1LlPT+2ryucwCfPWRsV1zeUsy30OjA/Uyvy3s4
	IUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fJ8aJXvboDwbDptswd1oyV0FpiVzCR0dWrrScwGk3u4=;
	b=b6ZD+N0Bx2zmxpHx2qAURG4Vi/+a3hPiF1Qr8K4mj38QBfWB348f51yzuxDcPsPXiw
	RtJjX1p43b4dW78D9HEbq1aW/Mi3bGbyZrSmX9qrQgSOWiQKZUK8a0Zi5DsELcqIbMNA
	WiBxYNn3AC8mmm3/JZR2ncHfqylLrLr9Mp/z/l4RymZaIShaa+LA5zQGyDse7F3nDRwy
	yY1rQ4e6YFIa2Tp6YKd0NT+R2qrG3VpCm6jZFvyXhT4piPOzn19dCaVE71QODUYPLu+3
	HAoaahXvmLdIySbXDYw28Fm0OVYLDIaoVWJh+H0r0SUGMb0dVzJZ0fmkvGW+qRex3UXc
	xLhA==
X-Gm-Message-State: AE9vXwPvkLQBVTUl6Nyg0gI4fh6isxmy362bwWuiGzlsmdpPSaqz6meP1rqlAl77PiLOvg==
X-Received: by 10.98.90.133 with SMTP id o127mr26801043pfb.61.1474069009776;
	Fri, 16 Sep 2016 16:36:49 -0700 (PDT)
Received: from akuster-ThinkPad-X240.mvista.com
	([2601:202:4001:9ea0:142f:f172:55ee:c116])
	by smtp.gmail.com with ESMTPSA id q9sm8988434pfi.35.2016.09.16.16.36.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 16:36:48 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	akuster808@gmail.com
Date: Fri, 16 Sep 2016 16:36:42 -0700
Message-Id: <1474069004-10786-2-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
References: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
Subject: [PATCH 1/3] bb/tests/fetch: Update cups url
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
X-List-Received-Date: Fri, 16 Sep 2016 23:36:48 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Update the upstream url used for testing cups versions after upstream website
changes.

minor fixup to apply

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

[Bitbake upstream: 5f06041d4936fc22297945bbbad7020bfa9083c6 ]
Signed-off-by: Armin Kuster <akuster@mvista.com>
---
 lib/bb/tests/fetch.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 94173c1..73eba8c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -692,8 +692,8 @@ class FetchLatestVersionTest(FetcherTest):
             : "5.0",
         ("xserver-xorg", "http://xorg.freedesktop.org/releases/individual/xserver/xorg-server-1.15.1.tar.bz2", "", "")
             : "1.15.1",
-        # packages with valid REGEX_URI and REGEX
-        ("cups", "http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2", "http://www.cups.org/software.php", "(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
+        # packages with valid UPSTREAM_CHECK_URI and UPSTREAM_CHECK_REGEX
+        ("cups", "http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2", "https://github.com/apple/cups/releases", "(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
             : "2.0.0",
         ("db", "http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz", "http://www.oracle.com/technetwork/products/berkeleydb/downloads/index-082944.html", "http://download.oracle.com/otn/berkeley-db/(?P<name>db-)(?P<pver>((\d+[\.\-_]*)+))\.tar\.gz")
             : "6.1.19",
-- 
2.7.4


