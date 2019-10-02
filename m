Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id 4B4D17ECB9
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Oct 2019 14:09:26 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id o18so19800724wrv.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Oct 2019 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Lv0ORxeEbbH9Wiyrii7BGVC7hraMdjPF0UJ0yBKbTvs=;
	b=LiZkbRIWnM7cNAzkaSZCs4EEmnNxdIDQfAVtj+CJt1KkROj2S3XQtn8zY/vOc0XG/0
	d/3wLxu6AqrD6gCWmajw6rXIfuXCOYVRMrOGwHaZQ+AC6NMov1ktBfRl/WdU2MTrWRy7
	O4cu1XaeLl2dC4sSAzvdrDp92gkvI1jMQgDPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=Lv0ORxeEbbH9Wiyrii7BGVC7hraMdjPF0UJ0yBKbTvs=;
	b=LCPNy7aufhHF/tzRidg5UkoJ5Cdo1anzUUTbXslCtwfhW8LtoIyWkxcC3l7P3Qng5T
	FXOhVyDeU5IO4GyIg0YQSxE059N15iB36IYg//3wv87wlBVmFX9KKnxVJFWmbpJq/5+I
	f9+eV3V72nHmG5/3agCywxYnXxwCjzqQnvrnZGro8JTxqw5Yr0BBmrDN0MGQ9GXgq7U8
	LFSCTuUZpShMeidIkxqEh4Q+BVJzPufK0PFZhuCobjScjxvBZiVtjU4aG4Z/iN2U+mde
	T13HKYL5IEZiEIlrxU79dUBW1TS3+0qqow3l5JoAhAttEXyo85RursZVQERbhE/bPlnb
	hrvQ==
X-Gm-Message-State: APjAAAXq8Jx8E6lLKvVp9N6CyFv2STssHTZhaVir1RRE0FMQLXvcO3D2
	5xq4EP8P7/mDZ48Uj6s26t3QYSXDMGw=
X-Google-Smtp-Source: APXvYqy+O42u/16/QzGZE3HBpshX8f97BgYGQh4zvL12nihDIe6CCEcwUMX3QNbjbjO+wcdtb/QvOg==
X-Received: by 2002:adf:fd4d:: with SMTP id h13mr2910661wrs.66.1570025365754; 
	Wed, 02 Oct 2019 07:09:25 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	z9sm30275676wrp.26.2019.10.02.07.09.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 02 Oct 2019 07:09:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Oct 2019 15:09:24 +0100
Message-Id: <20191002140924.30412-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] bitbake: Bump verison 1.43.1 -> 1.43.2
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
X-List-Received-Date: Wed, 02 Oct 2019 14:09:26 -0000
Content-Transfer-Encoding: 8bit

This allows metadata to depend on SignatureGeneratorUniHashMixIn which was recently added.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 4834a71585..778b1d69eb 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -26,7 +26,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
 
-__version__ = "1.43.1"
+__version__ = "1.43.2"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 322a1e0937..f899691741 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "1.43.1"
+__version__ = "1.43.2"
 
 import sys
 if sys.version_info < (3, 4, 0):
-- 
2.20.1


