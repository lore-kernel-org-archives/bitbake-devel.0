Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 7710479AE7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2019 21:04:02 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id f10so2567823wmb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2019 14:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BHz806pB9hJM+w+AD7doztUmB0dXJbzZywu61t4nfX4=;
	b=ZrQNmeU/KlP03h1bn4dmlTVPf3cwhMh9gkDaYuitngMK7QnZUhYHF57kTKflyxVrcq
	O1BZR2maSirjD6GXjvboRFO4N/NqOTTYoZP9JaHtmjBPgEGv2ARMtdvNigk5xbxh2hkN
	4USLDXeUgNDS1ftths6sC8fkL4TL8EV3XYL8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BHz806pB9hJM+w+AD7doztUmB0dXJbzZywu61t4nfX4=;
	b=U50J3/rMGfEiGSpIstJZFBQFREY26vPFjKkXYcx/3EnSONyMdb8F0cinJz/GEv2Lim
	C1qw9Eu/nkpE3NAxbroxmn9ZdxaSnXVuuePv8b+dHJlZih70AYr83Q99rkp61mYUgJcZ
	8lxeZAZA2pJ6e0ZW46O9aRsBWeQ220GEO2xhAgHuisByJUGjAd1xX4QhS4klCYXTZwPK
	+w+kqrg5aWbTTQRySBD5LH0jQwNHtsC1HchbsCfq3x9me7jrWGw5nNGR/aLlOxAexR8n
	jhiuGSpQIAqKk6+v4G1RuL1BVHHgUtisjVVYOdIg8jTbBjCeMWiHl4V2cSflM2WZyEgg
	3+mQ==
X-Gm-Message-State: APjAAAWEtELM1JQ/WhakFl79++xGxX5gebFLWkzvIWAK1oOsg5TUHaXq
	UFsgqONwtU7ZLyJ9GyBEP0Vf/Y58pkg=
X-Google-Smtp-Source: APXvYqwekpGCAO91JAux/3ezl0uQc6YM2M4FFE3YYuj2fipXEqOdHrtr1rvxAZ9VpGAYJ59tZyDZ/w==
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr32136wma.175.1559163842876; 
	Wed, 29 May 2019 14:04:02 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g185sm335839wmf.30.2019.05.29.14.04.01
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 14:04:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 May 2019 22:04:01 +0100
Message-Id: <20190529210401.18944-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] main: Fix error message typo
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
X-List-Received-Date: Wed, 29 May 2019 21:04:02 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index 8d1978f986..ca59eb9af8 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -491,7 +491,7 @@ def setup_bitbake(configParams, configuration, extrafeatures=None):
 def lockBitbake():
     topdir = bb.cookerdata.findTopdir()
     if not topdir:
-        bb.error("Unable to find conf/bblayers.conf or conf/bitbake.conf. BBAPTH is unset and/or not in a build directory?")
+        bb.error("Unable to find conf/bblayers.conf or conf/bitbake.conf. BBPATH is unset and/or not in a build directory?")
         raise BBMainFatal
     lockfile = topdir + "/bitbake.lock"
     return topdir, bb.utils.lockfile(lockfile, False, False)
-- 
2.20.1


