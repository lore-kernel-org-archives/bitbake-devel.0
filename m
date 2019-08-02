Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id 7E34F7F357
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:21:04 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id f9so77548725wre.12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=qS8O0sjT24hMYb2xextODzoj/OxvF9ZwrYh96tVj8+M=;
	b=UwZ3XA+HoNDxPNGgnh1lp62hohrPNqQNFc/U7A58W3mD4UzsUNH+AFz6OBsBA1aBK2
	7F9lCK4KhWfpKvzGPw6dn+o3QXOhC9lHmGVaKscPvZfPTIh2QywjTMfUQ/uRvg3qDmyl
	EY6X+ap8gTXQ+9yyfep65U05YSW5TA8m3bPYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qS8O0sjT24hMYb2xextODzoj/OxvF9ZwrYh96tVj8+M=;
	b=jxzRJ0WQEZohYME5OFUHg+7fbXP4gI52AR72Hl4VuPOfjdxZ28xx8YbLt3cOelCGXf
	Sg8q1MQ84EBzmIs3rxMb1Oy90GbgGJQao+H5A2GJADgwQOaG62eMwzboogjssWTlvLfc
	dzgHJutW5RF38J+POb2npS17O6nE4NWy9Cddp4HJvUwlU8+LnAZfwvuxRyAwaTj7EBPo
	MfDBCErNMt6+few1D1Q2i3lxT0zWEUTEe6SoosIXnNcRfDCuxHYXZk9dttE41h9mriHV
	LOZBIW6VC7DL/VgYmzEdQQXyGjRYQtk/Ll+8bV18P3nrnSE2lJlEpzumMvhwJ4i/rLxl
	KVRA==
X-Gm-Message-State: APjAAAWCitqC+qVOQGvdFeK6abGTm57AUconbNXCgHRmgvn6vEH0KIhP
	dYA4dDNQbpCoVEvebmN7XccDtKc17Fo=
X-Google-Smtp-Source: APXvYqyDXhx7sdwvJxOhEYfusR1BYC87upQ6ET1NZaZ9XUDN9PpSDA6V5CFKI8z4OBfo7EwnYfuv/A==
X-Received: by 2002:adf:f204:: with SMTP id p4mr29029671wro.317.1564759265000; 
	Fri, 02 Aug 2019 08:21:05 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.21.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:21:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:49 +0100
Message-Id: <20190802152049.16529-16-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 16/16] bitbake: Bump version to 1.43.1 for API changes
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
X-List-Received-Date: Fri, 02 Aug 2019 15:21:04 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index b219d362e7..4834a71585 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -26,7 +26,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
 
-__version__ = "1.43.0"
+__version__ = "1.43.1"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 7579a893b6..322a1e0937 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "1.43.0"
+__version__ = "1.43.1"
 
 import sys
 if sys.version_info < (3, 4, 0):
-- 
2.20.1


