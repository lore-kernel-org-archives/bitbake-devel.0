Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 29F986C5BE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 22:14:49 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id p4so24318996wrt.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 14:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=f0q4WgraC8AANFMjD5NGPdlz5mDnv9KgK4iRAKrXwdE=;
	b=FB+plouGBQXkV/EpIgIXA/1bD7WB26oiXx8NRkU5RV4/HIG7Qw3b3HPFPd0mCwZOrS
	SL6O0ZkUuu2BGvQruTX7VaRrMoRvSo8OZBGtJYNjgCGxvkCWcSptVAg+AMOMLmwqXvxM
	w2joXvLfyVXNH2yxBfdh2NhFhBQyJQ13xRkuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=f0q4WgraC8AANFMjD5NGPdlz5mDnv9KgK4iRAKrXwdE=;
	b=qqJzK7mxAOBq4GmJXVRxcJSxvLGmdwho/tHeocG8Q+pE+eiLQHt8wpshbXwTW/cg1e
	7GAoSTJKHReoOiKiu0CWXoyvmYrCqnZpBAQPKeR0x8JlWC7L/oljOYMv3nDmsa+D2f2g
	ZZr4DlZJDi55MzSzwXC9GoyBuTCrfxs/8npWR0jybQf32zIRj4w24gmLMcGfHRgj1G5v
	hdcobQQJ4pNhFR4o3ZoyLijzgtmQJEn+nRuGoLPYbjUn7owzdc0lxXY7BS+JWuFAbZx3
	QT3U79fw2THSpzjiEkiP6P8qmX6oZcAoXsTK71SNBLJL1K1X+Qfr2d97ie8EjbXfHKCR
	TKdA==
X-Gm-Message-State: AA+aEWamSyIsyMCuv1zmToqvLLKNIkKIPKiAzYm48m8qVGoHraQXIHat
	E3DQpTZHvAHyD9PDSsi+QPQ3MSXB1oY=
X-Google-Smtp-Source: AFSGD/VZ4ly2Cl0zIscp9QQVjkX+TToVEEhRHQqskwImObI42FyYy+QA4TkI2a8+HFvPfG2BfiF6jA==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr29738653wrn.88.1543356889618; 
	Tue, 27 Nov 2018 14:14:49 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p6sm4160084wrx.50.2018.11.27.14.14.48
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Nov 2018 14:14:48 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Nov 2018 22:14:46 +0000
Message-Id: <20181127221446.30899-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181127221446.30899-1-richard.purdie@linuxfoundation.org>
References: <20181127221446.30899-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 3/3] fetch2: Avoid warning about incorrect character escaping in regex
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
X-List-Received-Date: Tue, 27 Nov 2018 22:14:49 -0000

Fixes:

lib/bb/fetch2/__init__.py:259: DeprecationWarning: invalid escape sequence \w
  re.compile("^\w+:(?!//)").match(uri):

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8d05f0c3d8..709372e16f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -256,7 +256,7 @@ class URI(object):
 
         # Identify if the URI is relative or not
         if urlp.scheme in self._relative_schemes and \
-           re.compile("^\w+:(?!//)").match(uri):
+           re.compile(r"^\w+:(?!//)").match(uri):
             self.relative = True
 
         if not self.relative:
-- 
2.17.1


