Return-Path: <anders@chargestorm.se>
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
	[209.85.215.47])
	by mail.openembedded.org (Postfix) with ESMTP id 1A4067751B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Feb 2017 20:53:02 +0000 (UTC)
Received: by mail-lf0-f47.google.com with SMTP id k202so31339lfe.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Feb 2017 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=chargestorm-se.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3ICEwRyfHdpC+yONo6w1BDle2fTU5SXGsZ8EfGqln+w=;
	b=BmDYficbNE0HhsCBgK2MJ1cLPo9zWCCe6DG17AXVz9svVvcD3+VZLvK5/mCgN0Deyq
	VjIro0ApIN7bck8kzqCiq3dejNPXeJZnzNZf08liaBOBpNJ03wngBGbIzBpxkB1MQvJn
	j4pEEy6taqaXLTJ8gG1GSuT0Bf0fvDsrUe/FWs8lvnO66mfi6iugSTUpIomHHA5jrOy3
	QH/DIESUcPZ44LErGmMF7KbBxWV8WmovM/opQ7/M7KEYN1uaBQaczioOqWHU13HWF0cP
	HUPzm9mM8Cfjar/Xl6HlrxuaPoRfG0ntQxI1wph+jdPbvvzKhZ4bYwj8xI3C7tASI1OY
	minQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3ICEwRyfHdpC+yONo6w1BDle2fTU5SXGsZ8EfGqln+w=;
	b=AlcP0AWlEYCyBf6HIwOzwE33klBSiJM7QmkFFZWGA2EV6CSc2qxvM2cR4ozK1/Jxs0
	7ihNwwbgIOom4N/+eRqwlI/i7XDXp7ElBADAaVlxMt5pZiEFb2vGw0CFLazeLTlS8WdX
	sD68Xu6y/xcAsLl5Ot8ZrowViXCI/o5FxDcIDZHgcBbzAmjMgdFwY1pSt+OBzuIuV6wP
	H1QUlDnLq3OpLhZUDMaSLCzvj+n3V7SsI6MsfdotgGLQGPwsYMUGWYxKOP7stzNa2Yae
	n60DEipJPNG0yDAfTskXeC8Ktn2hIgd+AK3kbgScdzOHIazBGbUJz/aIp6O6w5vUYylC
	4F+g==
X-Gm-Message-State: AMke39mlFOaqSjkf9ykuQiSSzScW9ZIbchb1ABNLSEc0y8Ff2ZfR3/4xaP1kXXYXpqIbxg==
X-Received: by 10.25.79.86 with SMTP id a22mr1463913lfk.106.1487969583422;
	Fri, 24 Feb 2017 12:53:03 -0800 (PST)
Received: from localhost (h83-209-191-235.cust.se.alltele.net.
	[83.209.191.235]) by smtp.gmail.com with ESMTPSA id
	v136sm2195917lfa.66.2017.02.24.12.53.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 Feb 2017 12:53:02 -0800 (PST)
From: Anders Darander <anders@chargestorm.se>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2017 21:52:55 +0100
Message-Id: <41396a5f2aa60b48533a12fb7704699d4ab2b843.1487969243.git.anders@chargestorm.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1487969243.git.anders@chargestorm.se>
References: <cover.1487969243.git.anders@chargestorm.se>
Cc: Anders Darander <anders@chargestorm.se>
Subject: [PATCH 2/2] lib/bb/fetch2: rewrite / to - in package names
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
X-List-Received-Date: Fri, 24 Feb 2017 20:53:03 -0000

Most angular2 packages have names of the form @angular/xxx.
The / obviously can't be used in a file name, replace it with -.

Signed-off-by: Anders Darander <anders@chargestorm.se>
---
 lib/bb/fetch2/npm.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 15b281f..780f26d 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -80,6 +80,7 @@ class Npm(FetchMethod):
         if not ud.version:
             raise ParameterError("NPM fetcher requires a version parameter", ud.url)
         ud.bbnpmmanifest = "%s-%s.deps.json" % (ud.pkgname, ud.version)
+        ud.bbnpmmanifest = ud.bbnpmmanifest.replace('/', '-')
         ud.registry = "http://%s" % (ud.url.replace('npm://', '', 1).split(';'))[0]
         prefixdir = "npm/%s" % ud.pkgname
         ud.pkgdatadir = d.expand("${DL_DIR}/%s" % prefixdir)
@@ -92,6 +93,7 @@ class Npm(FetchMethod):
 
         ud.write_tarballs = ((d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0") != "0")
         ud.mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
+        ud.mirrortarball = ud.mirrortarball.replace('/', '-')
         ud.fullmirror = os.path.join(d.getVar("DL_DIR"), ud.mirrortarball)
 
     def need_update(self, ud, d):
@@ -133,8 +135,7 @@ class Npm(FetchMethod):
 
     def unpack(self, ud, destdir, d):
         dldir = d.getVar("DL_DIR")
-        depdumpfile = "%s-%s.deps.json" % (ud.pkgname, ud.version)
-        with open("%s/npm/%s" % (dldir, depdumpfile)) as datafile:
+        with open("%s/npm/%s" % (dldir, ud.bbnpmmanifest)) as datafile:
             workobj = json.load(datafile)
         dldir = "%s/%s" % (os.path.dirname(ud.localpath), ud.pkgname)
 
-- 
2.10.2


