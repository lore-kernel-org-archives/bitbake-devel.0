Return-Path: <rehsack@gmail.com>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 39F7061581
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 05:41:10 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id y11so22323138wrt.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Feb 2020 21:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id;
	bh=CTw4qOCbgEUJyVo4fN6OkOEuXzT4Nc94n+JWmASd+rg=;
	b=gl+dkndwVkTRuLH9GyMOYFYOvaGqx1EbjTiOjB9XuAQYfdzAdK9Ozpi2YS7t9fAr0W
	1p73bQPQSZ9SOpHRf7fAP39cpvYc3pu6ZbTUoabQ+1p/Ql3TGu8BYtg7C2TfYKNZ21Ce
	M+E5fnbb1sdWAJYJtvCITm7lqK0eN67NurddfwS01O+h278KMgqLTfCpdmxrZYNtU/8W
	UaROCGd9/w2//IMPMV6D6refPyhOQHkgJJxW2LP2jqWehzmvzBMux+3Ll/4Yueh9DVUH
	itMgVIHrN3Thr5VVmob8xu0cfppSSleSEZ1u5Po0cn2C2uaTdDeOATvLtKwPp9LkKBOo
	ubnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
	bh=CTw4qOCbgEUJyVo4fN6OkOEuXzT4Nc94n+JWmASd+rg=;
	b=L8pbI3rTsJS6Rcp9ETKKuJzRjm9R3H/R3r4UwPgxPOKd09t60/+dlCN6FlTXeE3Al6
	6wT0Y+cLsE2DZ9xGB7Nqxx7xRuohVnLdhENnBz+5e7ww6OcMZJs4xI7UHj3ujWM2lGSP
	4FzilWoFyKNypVwpCDv7W7ksTovy9qNIzyIcqIS58qJqZU0oAaekWC7gGALPloVONfBn
	eJAuI3B807IIrSo63EQiOiEDUaoVuEVK2esbM0zmmUhBHZ8MO5m6NB3VCCORQDyiz233
	UK/apcSiLxtMyQOARBJG/HSvv30XX5/XoOV7ZYJI8Epu6C+/+U6plLCVUkjBiv696+zx
	F84g==
X-Gm-Message-State: APjAAAXrFCYhJ14T/Z43LybhgK4aDeKSWc41qoXmTPgwAVIuNT/irlni
	ThGHxsVXcDk9XH7iTSMdJA8V1GPA
X-Google-Smtp-Source: APXvYqy+dp3P/DlEJKDgNP5Lt0uGtVNoOesJZst6VTiXEqY6Sefe/Ts1lW+uSGKWhoQzwyT4duZqBg==
X-Received: by 2002:adf:f986:: with SMTP id f6mr27476962wrr.182.1582004470564; 
	Mon, 17 Feb 2020 21:41:10 -0800 (PST)
Received: from beaker.muppets.liwing.de (p4FE93807.dip0.t-ipconnect.de.
	[79.233.56.7]) by smtp.gmail.com with ESMTPSA id
	c74sm2211990wmd.26.2020.02.17.21.41.09
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 17 Feb 2020 21:41:09 -0800 (PST)
Sender: Jens Rehsack <rehsack@gmail.com>
From: Jens Rehsack <sno@netbsd.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Feb 2020 06:40:53 +0100
Message-Id: <20200218054053.2891-1-sno@netbsd.org>
X-Mailer: git-send-email 2.17.1
Subject: [OE-core][PATCH REBASED] bitbake: fetch2: svn: care for path_spec
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
X-List-Received-Date: Tue, 18 Feb 2020 05:41:10 -0000

From: Jens Rehsack <sno@NetBSD.org>

Documentation says:
    "path_spec": A specific directory in which to checkout the specified
    svn module.
but existing svn fetcher uses "module" always as path of checked out
svn-module, regardless whether path_spec was given or not.

Signed-off-by: Jens Rehsack <sno@NetBSD.org>
---
 bitbake/lib/bb/fetch2/svn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 6c8caf5fb9..385a6b2cf1 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -47,7 +47,7 @@ class Svn(FetchMethod):
         svndir = d.getVar("SVNDIR") or (d.getVar("DL_DIR") + "/svn")
         relpath = self._strip_leading_slashes(ud.path)
         ud.pkgdir = os.path.join(svndir, ud.host, relpath)
-        ud.moddir = os.path.join(ud.pkgdir, ud.module)
+        ud.moddir = os.path.join(ud.pkgdir, ud.path_spec)
         # Protects the repository from concurrent updates, e.g. from two
         # recipes fetching different revisions at the same time
         ud.svnlock = os.path.join(ud.pkgdir, "svn.lock")
-- 
2.17.1


