Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 38DEA78F9A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 18:02:36 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id f21-v6so9748695wmc.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=ty/l5H9CCdR0iznmgpFCcbV1lOMgOvhEtwvqyueAF4w=;
	b=PZtHPLgXKU50CF4Qigjg170BB03c4CwGPKBIuLQvqnvGoMPRzjG8ITt/U3dkkAkujp
	ezqXtS8QHJYKh2Mvcd9wamni9qCWX1UdkYg4HrfQTIrxL+7d7vriT1P7vnvBT6lKQyTL
	3r5qYs1TReQ9RZFcDx2CZVIOTIb5RgWEx/s2j9opQVOo/xIndx/UTz3nD3mcou9i7hmJ
	PqBb4jVyscqYWUjOM/hyU7Jjbq3d483yh42H8YDaIlheH8SIj/lapO1pnuk/sUnLq44c
	CubO1Vd9m3gGJew8a++FcJ24z0hgF6DMp+y0f0QLZQdT2VLm1KOObReVuvv8L5SpnHG3
	VoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=ty/l5H9CCdR0iznmgpFCcbV1lOMgOvhEtwvqyueAF4w=;
	b=CdJhl4M+A4ww7vlx2X1/Ckqb7eSWRuZ+jSBlVltbjcx+KABV6DiTldx9Ta1J9VvY1/
	m2Q1mh40TH31E5Yealahm0idbkD1+rnWFejdYzOf7aDcHY6uHmggZYLYvryIHGhsBxz0
	8yxRTdyGuKSUX4rOw26KsLch1D9OjAOMV6x2qE/qEX73odcSZ7/DzyonjXcOX3bMTmrH
	MuuXdp3LSXgsw4GUdnDs3Q/cKT6CouhwvU8SawiBrLUJzsgAHuizKZ2CJp/CykjMK7a2
	4aXqlSnQbbTdrLKDasKHe6Mo5HViO+pQ7EI7PTwVVZNv9GC3UpYcTsv0VRyYPhJPbIm2
	IYwQ==
X-Gm-Message-State: AOUpUlG6bbQM6c1qwNdBdcfGfz0fDMztFlJrCQ5JucQzS4le2id0HS0+
	d89UkMgFyr3DImBMXbFwRqzXqHu6oI4=
X-Google-Smtp-Source: AA+uWPysaGzWOiFU7qfTF12d03dxNAwHrqsf6iHZiUGs9XoQaicCbP/MO/JsV/tWTpNegH/O9/N9NQ==
X-Received: by 2002:a1c:e5cf:: with SMTP id
	c198-v6mr8963913wmh.113.1534183356645; 
	Mon, 13 Aug 2018 11:02:36 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	x23-v6sm6373245wmh.26.2018.08.13.11.02.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 Aug 2018 11:02:35 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Aug 2018 19:02:26 +0100
Message-Id: <20180813180226.18299-2-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180813180226.18299-1-ross.burton@intel.com>
References: <20180813180226.18299-1-ross.burton@intel.com>
Subject: [PATCH 2/2] checksum: sanity check path when recursively checksumming
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
X-List-Received-Date: Mon, 13 Aug 2018 18:02:36 -0000

In case something goes tragically wrong, catch a request to checksum / and
refuse.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/checksum.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/checksum.py b/bitbake/lib/bb/checksum.py
index 84289208f44..4e1598fe835 100644
--- a/bitbake/lib/bb/checksum.py
+++ b/bitbake/lib/bb/checksum.py
@@ -97,6 +97,8 @@ class FileChecksumCache(MultiProcessCache):
 
         def checksum_dir(pth):
             # Handle directories recursively
+            if pth == "/":
+                bb.fatal("Refusing to checksum /")
             dirchecksums = []
             for root, dirs, files in os.walk(pth):
                 for name in files:
-- 
2.11.0


