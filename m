Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id 1A55271AD6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Oct 2017 08:30:14 +0000 (UTC)
Received: by mail-pf0-f180.google.com with SMTP id b6so6651374pfh.7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 28 Oct 2017 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=lnJKR/t1Gew5uPKe7Oi9GblTVlQHePBTT3esLDSNZUM=;
	b=l+rx7/Qz0lmSH6pyZn0Un+K2WPoTVWYeX37Cam+LH+euJOL/ELKTDptlXLxP4Ked8X
	3V5gEKI+4pHFlyqRaT3GLutX2Fx6fXZhehnN+ROKHheTgcQJmhCLIqcxcP4hvdmUkW1B
	3bEFU2ga1jyYuJ0GeIcZrUW6Bu3h/AGRLqAcNqEcDztZ7fGLG8/CMcCxNxjf2CN+rXcC
	kujf3Lj2zoRsLw2qicTm0Za7JVZIwi7xXOvXRPf5AUkIa8h+b+XJJFNsdqwa8ZZ7tEdc
	01CJXe7VEP4vxeHPjgGnsJqfjv6WYfFb9WEi0Su6Jj6GoKSZMJc6zwxvtW3ZyrsnwrAg
	Af6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=lnJKR/t1Gew5uPKe7Oi9GblTVlQHePBTT3esLDSNZUM=;
	b=AlFJ5iHs8e77CmRUDcSz+9dw7jyPnO+vjKdMDMhINMPqroQyEqPMNm23rHjsfxf+hw
	tDjf587MN3qzJTS3DkFDULG233IdoPUsl/+Pszj+R7Isrm8Ne6U/JuqaQJfmaJiE4r4w
	EnwzJkOIRgrOTOLV9NX7Ig1J5rD8z8KHUkpkhKM7KwuHbkgBpLz4gZHG9LiiekBbVsPL
	cceceecq3p7MHGiRPZLxcpJzKpNwNkhlFC/uhzqSxAfnL1MX805sO/jcWYBcOCmP32Dv
	iPGQh4jeP7dYBnT4LrvMet9X3O8MGNIxRyE/6NwLWOr+0o8N0slLg0FP6huzE75axplZ
	Rx9g==
X-Gm-Message-State: AMCzsaU/hytBhkyIjtEIyZkSRt/RBez+jYhN833y/SgvjBnCS3WN6E2V
	NWOfOyyMFyQiYV/Sayp2Nh7U3w==
X-Google-Smtp-Source: ABhQp+Qs8pRqWoaO6FYtbngnYPwwyCf/YtbUR/OWDFUB7/xzOG2MPH23I7UnLJ7TAd6QAvQdhJLOEA==
X-Received: by 10.159.249.9 with SMTP id bf9mr2413238plb.383.1509179415942;
	Sat, 28 Oct 2017 01:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8882:b8c::231f])
	by smtp.gmail.com with ESMTPSA id
	c1sm17953632pfa.12.2017.10.28.01.30.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 28 Oct 2017 01:30:15 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 28 Oct 2017 01:29:56 -0700
Message-Id: <20171028082956.13020-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.14.3
Subject: [1.36][PATCH] bitbake: Update version to 1.36.0 for stable release
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
X-List-Received-Date: Sat, 28 Oct 2017 08:30:15 -0000

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index daedd647..558e32d7 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -38,7 +38,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports utf-8.\nPython can't change the filesystem locale after loading so we need a utf-8 when python starts or things won't work.")
 
-__version__ = "1.35.0"
+__version__ = "1.36.0"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 45559b99..52688315 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -21,7 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-__version__ = "1.35.0"
+__version__ = "1.36.0"
 
 import sys
 if sys.version_info < (3, 4, 0):
-- 
2.14.3


