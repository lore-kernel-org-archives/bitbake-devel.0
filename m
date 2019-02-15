Return-Path: <mr.k.zawadzki@gmail.com>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by mail.openembedded.org (Postfix) with ESMTP id 6CC2A7C691
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Feb 2019 03:25:50 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id j19so6343417ljg.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2019 19:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=9AyqJb0AZC3ngzs787SDZ5YcpcFj+kxaslVbxIB+gYY=;
	b=Hfqp4GbOcyWn2tnCQFR8LcvQi6Y+DGqFCriyOgRBeLG50U8Ew4LyDWrZCbC7l8Di4Q
	pjQKjkCgF5SxhWmhp0vFvUib0zbOZWZYxrAa1ynP1fqF8vJ/vOLsou5LF7X0xkRtxDrp
	wAx5EIIAeB+OjxW6ji5MdpF7xdITMNNRggGAdfxhc3soQaA34PKXf3iqsb2EM7220SGd
	qudCBatVJRaE+gQNcr4qx1lgWzktVfPQf8mGOgD/IgnpNoi/pprNa7IXAAC/DZHCoVky
	b/Wh5AbHsgarjDHwHCpTagd7WEUgvBE3Qa8C8IaM3JbGQYjIlYm58KDdJWoh5piFl9kg
	9xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=9AyqJb0AZC3ngzs787SDZ5YcpcFj+kxaslVbxIB+gYY=;
	b=Xcidz5svFksdmIsnYs20hupDZcwbK7yW5+8r27Sz+Q3RDQUC2S0RcZEGH6H/SEaKW1
	Gh22Lcu/5puUxfXTh06mt8UO0IrZIMToZC/eLBLYdUlWxDzTpqXfa9eq+GowOxeJz5Oi
	OeYQhmsMop8MyGgA90Yfg+nKdavbx875ns84CKFzA2yb1jsl14KQrhcMzvQofBzh/tNP
	MZFAZ2YZmYHU55bsz4gdTM47rtJ+kfKm/yqUqhr0V5lAJ6XzWEb02oyKhDw/ay2UybR5
	BEFS8w7oBX2vck6XRhu2QSzNn4OOVP1IQ/cxrzfgTB/BIVpGI5ruPAMyLt2bB2+NzZJn
	Pe+w==
X-Gm-Message-State: AHQUAuZu6Z+LRCSNnBVB2rSW9yrnkfpWTrDOZQtRT6yJIt8AbYhRtnmJ
	nJyb7+aqfKoYFdfm0YXy3ZQUCSWq
X-Google-Smtp-Source: AHgI3IZ925trD1xuNUTjmWeENtBfHzb4bh+bw9hpBHvUXXTn7EJ1nk7/BgXNYneltumFpvy3ZKGCGQ==
X-Received: by 2002:a2e:8795:: with SMTP id
	n21-v6mr4663344lji.109.1550201150423; 
	Thu, 14 Feb 2019 19:25:50 -0800 (PST)
Received: from localhost.localdomain ([80.68.230.94])
	by smtp.gmail.com with ESMTPSA id
	z19-v6sm845225ljz.19.2019.02.14.19.25.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Feb 2019 19:25:49 -0800 (PST)
From: Krzysztof Zawadzki <mr.k.zawadzki@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Feb 2019 04:25:39 +0100
Message-Id: <20190215032539.5297-1-mr.k.zawadzki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] fetch2/svn: adds svn --ignore-externals option
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
X-List-Received-Date: Fri, 15 Feb 2019 03:25:50 -0000
Content-Transfer-Encoding: 8bit

With this option we can force users to provide all used sources in recipe.
Without this there is possibility that repositories which are using svn:externals
 can point to source code from HEAD or to nonexisting repository.
This can cause attempt to reproduce build after some time impossible.

Signed-off-by: Krzysztof Zawadzki <mr.k.zawadzki@gmail.com>
---
 lib/bb/fetch2/svn.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/svn.py b/lib/bb/fetch2/svn.py
index 9dcf3eb0..f4a07be3 100644
--- a/lib/bb/fetch2/svn.py
+++ b/lib/bb/fetch2/svn.py
@@ -97,13 +97,20 @@ class Svn(FetchMethod):
 
         if ud.pswd:
             options.append("--password %s" % ud.pswd)
-
+        
         if command == "info":
             svncmd = "%s info %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
         elif command == "log1":
             svncmd = "%s log --limit 1 %s %s://%s/%s/" % (ud.basecmd, " ".join(options), proto, svnroot, ud.module)
         else:
             suffix = ""
+
+            if "externals" in ud.parm:
+                if ud.parm["externals"] == "ignore":
+                    options.append("--ignore-externals")
+                else:
+                    raise FetchError("Invalid value for 'externals': expected 'ignore'")
+
             if ud.revision:
                 options.append("-r %s" % ud.revision)
                 suffix = "@%s" % (ud.revision)
-- 
2.20.1


