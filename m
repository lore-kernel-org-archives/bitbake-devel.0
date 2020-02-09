Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
	[209.85.210.169])
	by mail.openembedded.org (Postfix) with ESMTP id D11C66080B
	for <bitbake-devel@openembedded.org>;
	Sun,  9 Feb 2020 16:03:18 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id k29so2392258pfp.13
	for <bitbake-devel@openembedded.org>;
	Sun, 09 Feb 2020 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=wTmlm/RPqDyYAnR9qEiFqWQG9T+XUTWMIdUIy0jQ5k0=;
	b=E0T6RuLXDoocRP3XFmsHUIydlJ+IkmvGDBR3+04F5oGABf7tBSovFu2CEBlZCNl/9t
	vIRpp2g9jLHRgamco0kl6mcl2kuNEz7wKP/whXdMjKrcmpjCoDWuWIrdNbe7pNbOklUx
	65MjrMhajLBTrXCS72AScuGmyW9vzc79wWRHvUrM51IdEvIV1cOeznvC7Ote0mFMd8sr
	sjVsEEJDtRX50ySORkT31MK6pyD4mihlXyXqlfKSZOcnrl8HWIxd/0aK4mv2Ug/jiInU
	IaQzihu5KtdK0iQi+pt8eOfd7imjFtbel4ouKgX14OkiXOJPu/xi3qJT7LvFFYgMrLu5
	nIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=wTmlm/RPqDyYAnR9qEiFqWQG9T+XUTWMIdUIy0jQ5k0=;
	b=bB1bFsEDZFscJ4haur/e/7McUkCuFZqZ2LgYc082kJJbnS4YQB//mEZTMM4xm7T8E7
	CWNgp1BIeK9Q8+Cg8ijFwcy554Cg/GWtQtdvSbgUxQAmVVppUrgO8YtX3iziyosiRAnr
	BQamNehA+5eq8BnLl20lj9Ui7vTdVf1wOoF1w3FOliyziuRfLy+gneFUDnbEvy8QDsjn
	GEFHv/fBfeGXQc7T/ECgvZJPTTMQ7BoSfJHE46tbEFnKjnPMU619PVaMIQdwjwqNWBDk
	apZcPliRECKtSy6Lkf1CtzN0xdyeJ8nMgA9YtOOe6JsKO+BCVn96hyiRFAPBviVd+LHy
	oZVA==
X-Gm-Message-State: APjAAAUImO3I8utrCa6m05qzExpadb+/huchpypdAhWBgdoCeEKlieXE
	h8XVrNmWQJpq1BIuk4bYcr8ZezYq
X-Google-Smtp-Source: APXvYqxeyZKjp58/RiZzNs3xvevsEY2ZeadA+xT7r9UlJFnJNuV3lwEDvY+AwjezQpJgBU0aI5eEsw==
X-Received: by 2002:a63:4e63:: with SMTP id o35mr8004046pgl.279.1581264199539; 
	Sun, 09 Feb 2020 08:03:19 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:154b:3780:5122:4aa9])
	by smtp.gmail.com with ESMTPSA id d3sm8529353pjx.10.2020.02.09.08.03.18
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 09 Feb 2020 08:03:19 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun,  9 Feb 2020 08:03:09 -0800
Message-Id: <63556259f2e34003ad0618a8fe19e1cfe8aef5c9.1581264053.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1581264053.git.akuster808@gmail.com>
References: <cover.1581264053.git.akuster808@gmail.com>
Subject: [1.44 1/7] fetch2: do not suffix srcrev cache key with PN
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
X-List-Received-Date: Sun, 09 Feb 2020 16:03:18 -0000

From: Chris Laplante <chris.laplante@agilent.com>

Prior to this change, two different recipes pulling from the same
exact repo could get a different SRCREV during a single parse session.

This was originally observed using git. For git at least, it still
allows recipes to pull from the same repo, but with different branches
or tags, since the form of the srcrev cache key for git is:

        "git:" + ud.host + ud.path.replace('/', '.') + ud.unresolvedrev[name]

Where the 'unresolvedrev' part is the branch or tag name.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6c938e6fd29beebe09b32be839dae008fe6491d2)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/__init__.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 731c1608..4a781bde 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1567,8 +1567,7 @@ class FetchMethod(object):
         return True, str(latest_rev)
 
     def generate_revision_key(self, ud, d, name):
-        key = self._revision_key(ud, d, name)
-        return "%s-%s" % (key, d.getVar("PN") or "")
+        return self._revision_key(ud, d, name)
 
     def latest_versionstring(self, ud, d):
         """
-- 
2.17.1


