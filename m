Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
	[209.85.214.177])
	by mail.openembedded.org (Postfix) with ESMTP id 071907F873
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:51 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id c13so6714470pls.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=cvqFWcNQYjhZTEHrqrlJZpAl26iBLGPd9X2gvWDBXBE=;
	b=gBckRoeHTMlnysBIKDtInESqzYxLx/1OVgRjl8h7nFIWBxyTVHbvK+hONk7TlmHlTu
	D7RqwZmv/6JkqDrdBrGRot6ePspAzfj8HnHp1V4WWa0iQwU0Oe85Tk8ZJGHDbAZX5GVr
	8hN+CB2BhrBH4TAUTuvp+NTXcM1W4Zjy+bKcKmd5+R4ps9xbsj+2l8uFeiCWHCICeLZ0
	LNT18uPWRfvrTOulfdhhz7uEoiU0c+Al+/VFCkPV2U1mjWXgY/HSlZN6hOanVk6Amz/E
	xO8Cp6mXj9JSq3MAdvBBgmIQZxPJfu/uZHNK6uAX+j5m83re5CGK07EbNZYRlQYkqe0S
	+FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=cvqFWcNQYjhZTEHrqrlJZpAl26iBLGPd9X2gvWDBXBE=;
	b=O4kjLYEo15ipXmULinHbg+rRFJ5vRsOXphclCW/HolFCvc8id1uIp3sUTQEnL/eSkC
	zdfRryWGebYLSC/uOxIYyydaWeR9vOyoBiA8u2ReeOVT2MRokG1PRrZvAj0I/aMJHUzc
	XoTF5OuLrfFtCUT/zm45g8JQFnjrCJwoTewdvx/Oms3zUTX5EfVSEc68tX5PUh1tRdak
	kZLBR/ybIkXTNtBOFe+Y/Uf1tjdBDSY8C2DD/4yTdUIrmr5oSazq+FCGhEHiW/0KCH6H
	bKQu1pyWVAzLnsQvwJr4Ob31KsXbeeG23ZxQOkmDBLMfetLIY2E1QQ682ddJ1TqGUX57
	kIXQ==
X-Gm-Message-State: APjAAAWhQ66MJ+53VTgM1uPBM/XSfIzYTs5I0q6Hqwx4MNRJk/P6garc
	HPBIHTzUyiZg+VdTU0AdZbSYNj/vq2Y=
X-Google-Smtp-Source: APXvYqw1PctfUwkSraULSFrkpzTCg1cF0+ybyJE/2MEQkcrZ6riek35kWYOWKBsC7UlSib+w/Orccg==
X-Received: by 2002:a17:90a:d995:: with SMTP id
	d21mr32360640pjv.118.1577076653063; 
	Sun, 22 Dec 2019 20:50:53 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:52 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:32 -0800
Message-Id: <5afad266f2ce55db2038c36f2e49a3c80be9bbfc.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 08/18] siggen: Fix performance issue in get_unihash
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:52 -0000

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
index dbf5102..2fec859 100644
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
2.7.4


