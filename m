Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
	[209.85.215.193])
	by mail.openembedded.org (Postfix) with ESMTP id C87EA7F894
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:20 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id x7so24175893pgl.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=S2V9pTvvMwwDjaApifsadvDyNlY9W74XCGwyO6ZgOjQ=;
	b=SdCP5SGaJODHADgICEVAlA2UARsCcHLmPRtqhWZDJU0fskrOkpmFyiz6CSRbgDV2K8
	drvdm1J7BjCAwuWH1VZE1idmnnZd7rSi/HVERGfwZ25FJZOtzWKNDOyMUxhfAFIiiGfk
	hMpN7Nqv4Ibi0MSOdv9/j1fEGIBnnYnoP4d0lPki0khZEiOiAQrDia9pxC4pKQU6o6TD
	KHDgRrS43P1+dYAvDGZEgggOWK5ulKDzKI7/iv+Mocg4PCoFeJcOpwDsS27O++zjfBqv
	4JCAltEIC5rE9V1hof2NCnGnvVsIHvjTudCVr4jT3AueAA6hp+gUBXUZX9G57tgJ+kx5
	Nk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=S2V9pTvvMwwDjaApifsadvDyNlY9W74XCGwyO6ZgOjQ=;
	b=SNDLR5CAh9VhrqDtwz//CuNd4b+qjLkeP/1sYO4c5xELlG25IKwixrw/8F9twOaL90
	+X2cFZfRiMaIOV/XUtyvXaB+kVbucW/0kXe8fQEKdlXhFAG2qJ+50bLN+8W3GM5kOLAC
	cJNB13VXaXycWiPGcDdgHjraNJdscX2ftXzYSwy0brvt35mUII0Hc+snQPwzdzNjoNre
	kzmDCgzwBwitzXeg3BNT3CXdJJYz2NiiZQ9ePQhLC5t/BIZjQbiSVMgCVMJ5n1gKQtL6
	7rSCo4o3Kz1uI+VnAUN9YbI2dUi+ZCjcVcUv36e/mck0OHmGkKJJiZivMEutpRgHjUfI
	Eukw==
X-Gm-Message-State: APjAAAUm4fR8xrk1XTuuowLfPkVmF7oI2qlHb/KbeGBWqU9xaLbsgNgq
	VO8Mk+xJr4uv14F5rGNSYQ007CQ+3b8=
X-Google-Smtp-Source: APXvYqyyg8E1md8Kgm+gYj6HpFiVV9n/B2KN+gfg+cVI+rsMBW+gnUcRDyd9SVcjcOGvCEYl+B0rXA==
X-Received: by 2002:a63:4503:: with SMTP id s3mr99819794pga.311.1578104601823; 
	Fri, 03 Jan 2020 18:23:21 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.21
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:21 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:53 -0800
Message-Id: <5afad266f2ce55db2038c36f2e49a3c80be9bbfc.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 08/25] siggen: Fix performance issue in get_unihash
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:20 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There is a significant performance issue in get_unihash(). The issue turns out
to be the lookups of setscene tasks. We can fix this by using a set() instead of
the current list.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1e561672d039ebfb8cd0e0654a44dcf48513317c)
---
 lib/bb/siggen.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index dbf51023..2fec8599 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -44,7 +44,7 @@ class SignatureGenerator(object):
         self.file_checksum_values = {}
         self.taints = {}
         self.unitaskhashes = {}
-        self.setscenetasks = {}
+        self.setscenetasks = set()
 
     def finalise(self, fn, d, varient):
         return
@@ -110,7 +110,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.taints = {}
         self.gendeps = {}
         self.lookupcache = {}
-        self.setscenetasks = {}
+        self.setscenetasks = set()
         self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST") or "").split())
         self.taskwhitelist = None
         self.init_rundepcheck(data)
@@ -157,7 +157,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         return taskdeps
 
     def set_setscene_tasks(self, setscene_tasks):
-        self.setscenetasks = setscene_tasks
+        self.setscenetasks = set(setscene_tasks)
 
     def finalise(self, fn, d, variant):
 
-- 
2.17.1


