Return-Path: <andre.draszik@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id DCD7D786E9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Nov 2017 09:21:45 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id 70so1083481wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Nov 2017 01:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=9+ezVjgMzZEiPQT0M2x1P+zpIcpbcJ1YXs7N+sugJ4c=;
	b=DbYFxYkgTxIW6xoLYZ0vQdeIPn58H9/TiHTW38NC2wXWx9aginAi5KZbP89w+9Nl/u
	A/4wwmr2TIBOSx7SrSTjgwGUat0j3mupv5+zsHhziYmx6325eDQRoNZkDKgwAJbvPga5
	rA8RoNrqdmHfOSSonvY2t76Nj6ikU1u6GmTY/zkd495nK6LzPrCwjZXwwc7XdRWvhkFp
	IZHzzxosFP1YutQB4YAPgwpX3M7PqhKxJ31rWQnX0XSbHfOKDtlWEhzBWgTYeKYbehze
	izx1C5Hm6t15habWSxHbM8P4H62UREMqx3b96ehq6Ee6F1b5MnEFY4LT2libVeIIm/q1
	7e+A==
X-Gm-Message-State: AJaThX67FbRoOWGqBbw8cqk3v3/P43nIJ+x9WpD0wL+1Kn7g7XIQ4du8
	M9mJO9MPwvxYcaIsGzW32+pIBrni
X-Google-Smtp-Source: AGs4zMYtUszByjRq+ZjI4Q9y5FCjKvus5FXH79AQI6Dae99zDEjjf2Uaz/ICJPJekU1Jrq93h1fvNA==
X-Received: by 10.80.208.10 with SMTP id j10mr1787737edf.194.1510824106337;
	Thu, 16 Nov 2017 01:21:46 -0800 (PST)
Received: from tfsielt31850.garage.tyco.com ([77.107.218.170])
	by smtp.gmail.com with ESMTPSA id a7sm899859edd.19.2017.11.16.01.21.45
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Nov 2017 01:21:45 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Nov 2017 09:21:44 +0000
Message-Id: <20171116092144.17649-1-git@andred.net>
X-Mailer: git-send-email 2.15.0.rc1
MIME-Version: 1.0
Subject: [master][PATCH] fetch2: fix unpack of .txz files
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
X-List-Received-Date: Thu, 16 Nov 2017 09:21:46 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

.txz is the same as .tar.xz, and can be found in the wild.

Signed-off-by: André Draszik <git@andred.net>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f70f1b51..cb94bf60 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1424,7 +1424,7 @@ class FetchMethod(object):
                 cmd = 'gzip -dc %s > %s' % (file, efile)
             elif file.endswith('.bz2'):
                 cmd = 'bzip2 -dc %s > %s' % (file, efile)
-            elif file.endswith('.tar.xz'):
+            elif file.endswith('.txz') or file.endswith('.tar.xz'):
                 cmd = 'xz -dc %s | tar x --no-same-owner -f -' % file
             elif file.endswith('.xz'):
                 cmd = 'xz -dc %s > %s' % (file, efile)
-- 
2.15.0.rc1


