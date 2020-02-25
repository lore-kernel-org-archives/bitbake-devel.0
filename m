Return-Path: <daisuke.yamane@miraclelinux.com>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
	[209.85.210.195])
	by mail.openembedded.org (Postfix) with ESMTP id 1C3D8610B9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2020 09:24:03 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id 185so6871476pfv.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2020 01:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=20CImprZOYWJ0kJehmLwTy8+Pk7eRvRWjpPeEcxk1Z8=;
	b=ga9gN1RQZxgzxTD+nPTY6d0rM/D1aKBHq5Vgtb7j+G1RFWWRlpV1QVKeR5oJGA9VRC
	UxpqPA8hT/wWU9+sunPMfNzKzcWM7Xe335d2gkrlH6osJMCU4EiO7jYoExqXB0kG3KeH
	xDKkx9MRj5YX9aNffxq1r+aLOw3wDJXmZJk6igMGqE9f/2zbyms6Cyr5c0JyFExwMzF0
	2DAHZSmgnW+WemcAlwTBRbAGEW0vSZDsE8/tEfU73zXEK2Fi0vYpGATjSLjRgeKyG9Om
	cvWxyxWNmEkZKPEyByKyqOrfAaqmwZkz1yZc/yvwRzux5z/AbU1qJ72FYuom1z85DsVd
	oV7w==
X-Gm-Message-State: APjAAAUfitY6JXEuJfZvd5CxHFChWeyBBkmmEPaSxWYElR6bhPqLZ3g4
	Tanv0pTwYYflvCnO07GUp8t/jCMNCV8=
X-Google-Smtp-Source: APXvYqxly7tMiqsIZCaCWBWxP6aXyMTOxgnj/bp7PUkm+TswY/NlwmpC85Qwx26eXnin7IPfE4DWzg==
X-Received: by 2002:a62:7883:: with SMTP id
	t125mr58064145pfc.141.1582622644668; 
	Tue, 25 Feb 2020 01:24:04 -0800 (PST)
Received: from AIBox-1804.lxd (219x123x27x194.ap219.ftth.ucom.ne.jp.
	[219.123.27.194]) by smtp.googlemail.com with ESMTPSA id
	r11sm16102870pgi.9.2020.02.25.01.24.02
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 25 Feb 2020 01:24:03 -0800 (PST)
From: Daisuke Yamane <daisuke.yamane@cybertrust.co.jp>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Feb 2020 09:23:56 +0000
Message-Id: <20200225092356.898-1-daisuke.yamane@cybertrust.co.jp>
X-Mailer: git-send-email 2.17.1
Subject: [1.44, 1.42, 1.40] lib/bb/utils.py: Preserve ownership of symlink
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
X-List-Received-Date: Tue, 25 Feb 2020 09:24:04 -0000

Yocto Bug: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13806

Uncomment lchown() to preserve ownership of symlink.

Signed-off-by: Daisuke Yamane <daisuke.yamane@cybertrust.co.jp>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 47805d02..5f5767c1 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
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


