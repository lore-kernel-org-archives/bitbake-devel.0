Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id F18BA7EE59
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jul 2019 15:20:19 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id 31so32693795wrm.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jul 2019 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dUQJ2hswBCupKlLOPt3T730pHhG5RLjyOCAoGBbQ2i8=;
	b=SZgEPAfCxBTd0ybfZWj0J2zZD6V2KXEJDSV3XxvBZ170wArH5Yow4ChTHYxsYqm3XZ
	Kp9/LIzHh9aAKIhDB0VqzUaYplmRiGrXq6YOHOo1k1ukJMxtYQEFl3JwiHK5tBXNHTXv
	83zhrBdh16tN88vUnZpow+ue3ag3O4BrYsbwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=dUQJ2hswBCupKlLOPt3T730pHhG5RLjyOCAoGBbQ2i8=;
	b=Yt01L28+fXJS04XEDmm+B6fYLCIXZkjC+2a2QZ5KRN767zMVNp60bDNgW5VRLvIS/H
	iqp/UYRdQF137JZwRlLiy6N2LVnaF2/HUUxFX5UIaRmIBtKrFG+2tjOnR4uIzTC4BnRx
	zIRGuJPUGduKkOQktF/1lDgjlkApFxEnve+YbA3NCaiijkahXskSbAOSofaWdwgs8Dj3
	eMVANnY3F5YuhVCgIEJQ3TQ/gslt20ojqRqTGtqRZpdtGwPERUSc3ZCCSGI6oPqTExMj
	6O42BuDiskVHkb+XInmagGmXKd/nb/H/nzmbvCagsU7Wwg+rgaw1vVc8ayp2194mQ8DY
	hVrQ==
X-Gm-Message-State: APjAAAXVHxwCI/Xh7BvsoQ8aJIV+d289OShl+HBnV1/Mp0+896THcOFx
	hbb5wzxheArEn7u6ch5vQUozTIwwl5I=
X-Google-Smtp-Source: APXvYqyUkYWTk4Zu1k2xaYYs0EOu6V5ic9U/iokvh6bqpkgU8HUv6ZIZq5O2OUFNnwxZ1rv23vZrjg==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr51968964wrq.137.1563549620333;
	Fri, 19 Jul 2019 08:20:20 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r14sm28494978wrx.57.2019.07.19.08.20.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 19 Jul 2019 08:20:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Jul 2019 16:20:18 +0100
Message-Id: <20190719152018.12154-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] siggen: Fix handling of tainted sig files
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
X-List-Received-Date: Fri, 19 Jul 2019 15:20:20 -0000
Content-Transfer-Encoding: 8bit

The addition of some debugging code meant that comparisions between sig
files with a taint and without a taint weren't working. Tweak the logic
to avoid tracebacks if one side doesn't have a taint.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index f9c4798e3d..6a729f3b1e 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -645,9 +645,9 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)
     if a_taint != b_taint:
-        if a_taint.startswith('nostamp:'):
+        if a_taint and a_taint.startswith('nostamp:'):
             a_taint = a_taint.replace('nostamp:', 'nostamp(uuid4):')
-        if b_taint.startswith('nostamp:'):
+        if b_taint and b_taint.startswith('nostamp:'):
             b_taint = b_taint.replace('nostamp:', 'nostamp(uuid4):')
         output.append(color_format("{color_title}Taint (by forced/invalidated task) changed{color_default} from %s to %s") % (a_taint, b_taint))
 
-- 
2.20.1


