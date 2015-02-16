Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 6D94F73556
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:28 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id r20so27708306wiv.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=JhBPY7MaXg8hAeaDY4X2NQmCRMaBQ1msjFXzGpplG0k=;
	b=eozRFfiBU4XTW9pbb0Urg46bj1JjWjR7RZqI1h6ucpeTdUkzxL6dwyRghUKc3/isG+
	7LxmNh9PRVeugWm3cxNQQ82w135jPZYiAH21qTa+V3Ew/w/Wnng7VrjMnIxnxDryIJos
	cuIKgxsaTDIoEwuoIlXHoOE0rxRkZXAKhklVouaa0R4lETgkWMAU28wYMV//Z4MFewNq
	CVRuZJeXxbr82QDKK3eEqrBDUHp0jHXHRErBWIdLQQmMyft1fcss6I6QFXYqefoZ5J/8
	6Bs0jR1qNfimfQ8zsFb5zJheegNE1BHluOQKs62WxBYxVJCSk/yHnpVZJ/pzDDtk/g8b
	4U/Q==
X-Gm-Message-State: ALoCoQlJOegdGUjOdrw2v/PzEcmz+g8CqhlaKhtvGQqyBWGPaLVJ1WnmWQTqVf9AQGmT11svFJpn
X-Received: by 10.194.185.68 with SMTP id fa4mr51610673wjc.111.1424109209032; 
	Mon, 16 Feb 2015 09:53:29 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dn1sm4235437wid.11.2015.02.16.09.53.27
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:28 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CA46A560742; Mon, 16 Feb 2015 17:53:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:19 +0000
Message-Id: <25640851c8f8459741d2c423b2bb54f9f59a536a.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
References: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Subject: [PATCH 03/10] toaster: fix git checkout command
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:28 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the git checkout command that would fail to
properly rebase the working tree in some cases.

[YOCTO #7309]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 4814b84..6bd019a 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -252,7 +252,7 @@ class LocalhostBEController(BuildEnvironmentController):
             # branch magic name "HEAD" will inhibit checkout
             if commit != "HEAD":
                 logger.debug("localhostbecontroller: checking out commit %s to %s " % (commit, localdirname))
-                self._shellcmd("git fetch --all && git checkout \"%s\" && git pull --rebase" % (commit) , localdirname)
+                self._shellcmd("git fetch --all && git checkout \"%s\" && git rebase \"origin/%s\"" % (commit, commit) , localdirname)
 
             # take the localdirname as poky dir if we can find the oe-init-build-env
             if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
-- 
1.9.1


