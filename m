Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 394D76093E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 16:26:32 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id t201so130162262wmt.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=jiomM4ew7JVfTwd0vE1ebBxNyB0EWX6eKMRFGA/OhlA=;
	b=z6vbXvyzWzsiG2zNXl0+9xtZ4Ep0r74WSMy1hOTYhf7XdfdCj3TxNHC6d11uZPNkHm
	rrRJ43rQoaVk/Ef1K/YQqltrsKg3XadICsZr5/XcY3h2kolyEhbw34dV34K2CxXPQrCH
	IwspJssTSQWBmXOXqEIAhTg3hdAQ+48jCoaURVr3BYOdR+QxVIdya0wYvCU2+AI5bTjz
	6nQymLNnFOlSjlg7P12QATxrNuZt4lJsi5E3SrKusOdHgdbloNSPjkUoBTjtR5UqDh6E
	7/GrlQIHsg/1q+clZ7fEEQCHCHbEN+x1PseGn1lA8x9rF3niMtXA3ruqBpCZ7umEzhJE
	y7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=jiomM4ew7JVfTwd0vE1ebBxNyB0EWX6eKMRFGA/OhlA=;
	b=iAzHju9cqQpdKJBG/tAZZRjF+0cKSpd/NqnwlA7fpMVfTgi8wdr9KiJieKYOCkMSsS
	cc4dlAWtopa36lh5g8lYFLGbHY29HkW5D2WGqIH3dARToCx5BqpCuxbSeYifa1/iqEwD
	MTY4FJUQD6hbbFkXwCzByJAi0y2c+xMoayBBwFS0l9W0ucw3vySsNyiwfcf5bJaujBq5
	Mro4NAia+EeUbOOMTQNFEU6cOoqcfJcEzbGnmHX4ROr0sO1eFxzzTRU3KbNN++16aEZW
	noSmTwslLaIty7gAvB61k43voAJhMbEL1Y6wmdxyLDieRMkIOLAgnbMFXtYt4YfZf7qr
	4/WA==
X-Gm-Message-State: AIVw112CrLFZ3b+Jk4OXJ5NdjI0jOw4Zg3VFjEmTMyWsdtIyfCLCLlHy
	lu1tcblEUXLI62odriA=
X-Received: by 10.28.152.136 with SMTP id a130mr6360359wme.177.1501259192848; 
	Fri, 28 Jul 2017 09:26:32 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	l143sm4643150wmg.46.2017.07.28.09.26.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 28 Jul 2017 09:26:32 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 17:26:23 +0100
Message-Id: <20170728162623.5904-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] fetch2: fix checkstatus fallback to MIRRORS
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
X-List-Received-Date: Fri, 28 Jul 2017 16:26:32 -0000

The checkstatus() code was expecting checkstatus to throw exceptions if it
failed, but in general it should return False.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index bd23533ebc0..7afb2aeb734 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1726,9 +1726,8 @@ class Fetch(object):
             ret = try_mirrors(self, self.d, ud, mirrors, True)
             if not ret:
                 # Next try checking from the original uri, u
-                try:
-                    ret = m.checkstatus(self, ud, self.d)
-                except:
+                ret = m.checkstatus(self, ud, self.d)
+                if not ret:
                     # Finally, try checking uri, u, from MIRRORS
                     mirrors = mirror_from_string(self.d.getVar('MIRRORS'))
                     ret = try_mirrors(self, self.d, ud, mirrors, True)
-- 
2.11.0


