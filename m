Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
	[209.85.192.195])
	by mail.openembedded.org (Postfix) with ESMTP id 34D167713D
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:44:18 +0000 (UTC)
Received: by mail-pf0-f195.google.com with SMTP id e190so17828055pfe.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eJuIIocE0wjA1gKW4vhOpmrdmQFXQANvhMRtfQa34hg=;
	b=qwnCiDyCbp6nlp37fMynl3c+xhI6O7v2bJvDsTG5Q5WJ5mmW1drP7xPOkYyT1OIUne
	9Hvr4PkEz7xWmDvUTDZ5d0xqogInjpqVAKuqQaFm28u2/Fa1NYJPX6nXYBCqdN65x7VM
	Qt52p/4guJskUWfAlH14J5sITqsVUU3mHOXZpsjlxp+/cYa4JtuikPdLUj4V8hgPXS0L
	NCPI5jlwxP52G+KE1tTWZlyUrg2GZWhgb0hh1nG9ZMFbMp1wjq/uUHnncH6C/YJ0KKha
	zffn/vZmbyrY3L9hiWMUYYcKmoPGVJQKDkWfk9w+tW6N6IUoYwKjmeikAGpBmLEqAWmk
	dNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=eJuIIocE0wjA1gKW4vhOpmrdmQFXQANvhMRtfQa34hg=;
	b=ZtYRgoyqIfo6Wp6iBI8c5lgR6mWd/O7mVk392dlYhgOwZuYYJ0X+UmPoHwar4DTj18
	R2HgeNK9azlxhF71q6rpcJzL9QiRXJo6gWdBK0lr7HqqhZ5vxlf8jO4FBTm7CPDFe35i
	MkigH7cmRvPuSvyBeaZD+6HN0RuOepef2WINzmgpEYRwqK0Ywfr9KfS1SYQWqj+0j2PV
	XzA+f0/YkVeWID66rQv7D0Vg+ejMbQF6Te4v0U9J/3MmZosV8wUd7oEuH2n/o3utaOuE
	RvGSZwD80/vBukHXgEYRsE2yxlTazEv3A+yQIkHtsd5kDqPXmr2TFocWPuUSMuyjMzsx
	+OdQ==
X-Gm-Message-State: AOPr4FX299kGbuf8jE0La/cFdAjgHPH3AsLrakyHFCNgupz2dKSx1mJEIsJ1TZIvKhEYTA==
X-Received: by 10.98.75.81 with SMTP id y78mr39154554pfa.161.1462045459389;
	Sat, 30 Apr 2016 12:44:19 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	m184sm33275124pfb.22.2016.04.30.12.44.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:44:17 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:44:12 -0700
Message-Id: <98d64b9af58521cc7c7b33d5584720e88e673a3e.1462042322.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1462042322.git.chris_larson@mentor.com>
References: <cover.1462042322.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH 1/3] bb.fetch: simplify mirror tarball handling in try_mirror_url
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
X-List-Received-Date: Sat, 30 Apr 2016 19:44:19 -0000

From: Christopher Larson <chris_larson@mentor.com>

Rather than checking mirrortarball explicitly, simply check and see if the
localpath basenames match up.

We can't just compare methods, as in the case where an http file is found via
a file mirror, that causes the http fetcher to be run to process the
nonexistent mirror tarball, resulting in an attempt to download from upstream
when we already have the file.

This will make it easier to add the ability to support multiple mirror
tarballs, to implement shallow git mirror tarball support.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/__init__.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index e8fbe89..1b4547d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -954,8 +954,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         # We may be obtaining a mirror tarball which needs further processing by the real fetcher
         # If that tarball is a local file:// we need to provide a symlink to it
         dldir = ld.getVar("DL_DIR", True)
-        if origud.mirrortarball and os.path.basename(ud.localpath) == os.path.basename(origud.mirrortarball) \
-                and os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
+        if os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
             # Create donestamp in old format to avoid triggering a re-download
             if ud.donestamp:
                 bb.utils.mkdirhier(os.path.dirname(ud.donestamp))
@@ -965,7 +964,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                 os.symlink(ud.localpath, dest)
             if not verify_donestamp(origud, ld) or origud.method.need_update(origud, ld):
                 origud.method.download(origud, ld)
-                if hasattr(origud.method,"build_mirror_data"):
+                if hasattr(origud.method, "build_mirror_data"):
                     origud.method.build_mirror_data(origud, ld)
             return origud.localpath
         # Otherwise the result is a local file:// and we symlink to it
-- 
2.8.0


