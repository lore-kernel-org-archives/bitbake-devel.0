Return-Path: <rehsack@gmail.com>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail.openembedded.org (Postfix) with ESMTP id 9AD38608E1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Feb 2020 06:27:26 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id a9so5413736wmj.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 22:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id;
	bh=CTw4qOCbgEUJyVo4fN6OkOEuXzT4Nc94n+JWmASd+rg=;
	b=avSf48woO8+mizlB67/jE7HOIEbYKH0OcaqVdjBAL0susSCaI3C7xo+n4zvs8LmzvY
	r5EuZ0WD5RR66d877MHhEdrVSRsw6+/muqBA9g2Rpj8fFtz69chFS+JDBH68zQl1V+hJ
	86MuX3zaddA+dkLHUt16AxCBF2DCRM6e8GaANFCiGdY9zeLDe61fzfKb9NVmdKx+LGDp
	FhtRTXbPW6hZZPF5bMfxp/Mox+wDYZw6Iysk5gvX4mcvEzhHM0NbenFzbPjTxglvPlfl
	vd2nAmfjDLllXcBQy3cBuL0cPQyOrmn0Ke4EvC/v2+AoW501NcPgsLql3R0qHUxV0pbD
	ObwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
	bh=CTw4qOCbgEUJyVo4fN6OkOEuXzT4Nc94n+JWmASd+rg=;
	b=ZyB4i79KT+HbkEv6qfivRJqWVD2d90sLMkpicWN9I5/GVGJ6HNjLI5qXM4RQx5Thby
	dVfR1+XI9oHlUnuIlx/yXFcOvgYpsfzsVM5xRSgag5jkQQbOXpKqmw8YlFhk6i/U2eb9
	UnL8by3JS2VVUrj0joyU62lk8r65VAUYXbmDNvX8T9KItLyZHfEUKXWH7Z6//RVNuo2W
	bB6VA5lbL67E3pelY+4rNjDtPwLn/mTiqo/hKg3VCESSJYUAwwYYRHXR8tpFQ6qEAa0p
	NOD9mQxmdcblA3TkektRHmTTFafnOXjQyzUyRbGDh5t88tde8Dkir556rajDjA52yxys
	EEpA==
X-Gm-Message-State: APjAAAXw42RFK4Fa9IaLD7mQHHQE+zQ8UluMDpNdIrbBcD8W8kVnIxek
	+vnNrnSqliSmernV1MC6iUDd7qER
X-Google-Smtp-Source: APXvYqxgkMWxH6ej8xzBM71lv9qaprQ4kjjvNdQCHMrkqmtVLaNgVk+XreD5Fyjc8d3mJaTnQmbT8Q==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr7603114wmr.72.1582093646551; 
	Tue, 18 Feb 2020 22:27:26 -0800 (PST)
Received: from beaker.muppets.liwing.de (p4FE93807.dip0.t-ipconnect.de.
	[79.233.56.7])
	by smtp.gmail.com with ESMTPSA id a5sm1611237wmb.37.2020.02.18.22.27.24
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 18 Feb 2020 22:27:24 -0800 (PST)
Sender: Jens Rehsack <rehsack@gmail.com>
From: Jens Rehsack <sno@netbsd.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Feb 2020 07:27:20 +0100
Message-Id: <20200219062720.4509-1-sno@netbsd.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH REBASED] bitbake: fetch2: svn: care for path_spec
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
X-List-Received-Date: Wed, 19 Feb 2020 06:27:26 -0000

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


