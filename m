Return-Path: <daisuke.yamane@miraclelinux.com>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail.openembedded.org (Postfix) with ESMTP id A35EB6160B
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2020 06:17:21 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id b9so2081069pgk.12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2020 22:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=I8o5mnu2+gAeld2aq7rDAdBVj7uGt7Chsjf0yHETBpo=;
	b=UjMbK30yxMkesBEYZMumYHGrbNJlpSvTVCf09icv2nZe6sy6xyk9oDVh+7zlsOXJtI
	KYZwJg5QbM1mIM+rO5fhYyWIUARlIrckxOtnJIUlMFtUcmTb4mk+s0j2jU1e6xfOg5zX
	iFJ8YEHMYtHFH57fNei2ZGEy+1sdRKt9X5LRFSqtqFrac/nQGcNirLRBtHXDOe+AXwUi
	t3M+9aU8ufGvCc+Ld0EntTMRi+m5ultNc6Y2q/s1if0TKia/SfGvmtRe9hmAM6j2N4lm
	MfOIEskNGjiAZSGdYzq+lfH57y40vTKDxxyMX7bwuQPS8OyTfD5fOGRPe2RMb0/Jeu3+
	BGaQ==
X-Gm-Message-State: APjAAAVJYI7PZSErwcL7vRJJezGOXidYRR+iWvyiFllp298NrGeeHnHW
	01OlPJSjTyKIjegukLttFGU++aXvb/U=
X-Google-Smtp-Source: APXvYqwwwnnB6afjzWugps/hETXF3qnXkiBTEhQctLxUuvBQ36HFj7hbkcV5Is9Z0pWkWbEH7T9FAQ==
X-Received: by 2002:a63:7e52:: with SMTP id o18mr15716991pgn.46.1582352242126; 
	Fri, 21 Feb 2020 22:17:22 -0800 (PST)
Received: from AIBox-1804.lxd (219x123x27x194.ap219.ftth.ucom.ne.jp.
	[219.123.27.194]) by smtp.googlemail.com with ESMTPSA id
	o11sm4445430pjs.6.2020.02.21.22.17.20
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 21 Feb 2020 22:17:21 -0800 (PST)
From: Daisuke Yamane <daisuke.yamane@cybertrust.co.jp>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 22 Feb 2020 06:17:14 +0000
Message-Id: <20200222061714.15922-1-daisuke.yamane@cybertrust.co.jp>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] lib/bb/utils.py: Preserve ownership of symlink
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
X-List-Received-Date: Sat, 22 Feb 2020 06:17:21 -0000

Yocto Bug: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13806

Uncomment lchown() to preserve ownership of symlink.

Signed-off-by: Daisuke Yamane <daisuke.yamane@cybertrust.co.jp>
---
 bitbake/lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 47805d02cf..5f5767c1da 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -864,7 +864,7 @@ def copyfile(src, dest, newmtime = None, sstat = None):
             if destexists and not stat.S_ISDIR(dstat[stat.ST_MODE]):
                 os.unlink(dest)
             os.symlink(target, dest)
-            #os.lchown(dest,sstat[stat.ST_UID],sstat[stat.ST_GID])
+            os.lchown(dest,sstat[stat.ST_UID],sstat[stat.ST_GID])
             return os.lstat(dest)
         except Exception as e:
             logger.warning("copyfile: failed to create symlink %s to %s (%s)" % (dest, target, e))
-- 
2.17.1


