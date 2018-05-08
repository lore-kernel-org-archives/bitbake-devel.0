Return-Path: <armccurdy@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
	[209.85.218.68])
	by mail.openembedded.org (Postfix) with ESMTP id C908574B0D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 May 2018 01:02:18 +0000 (UTC)
Received: by mail-oi0-f68.google.com with SMTP id a6-v6so26901867oia.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 May 2018 18:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=AvzVZHTXg8Cd+PWtcTAJik/QzxLm+IbEuRDMFcWcRlw=;
	b=QAI8fnQsEDPqS4Y1b/3m42W/H0k7r2NiebZ0dX1YFyqCH94dOaxe0Io/ph3NjnMmX1
	EEwlFq4alDq5R89JXO5+kl6S+LpgZ37Dyqi422QuejkgkIET0ZXYc6/iGrOR/KbG4nbl
	hB9kagsMqZiOv7Yu7Ent+1yyReZ38XdJkOuINrNiaFKPsWdMuwfRA+8M3n4k9ocO7Idu
	O++PlYFl86AJ7dazp5/d07WxL90EDENVnFwvGuWGhlxQrPTdLPv1Vw3EjwpQ0Q5hiVoc
	x0xoETX+AouQvwucWxmnxXsPC5MC1bpaD8s3dZoj+ZO93EENrRto10pwHdbVjba1Il5L
	eEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=AvzVZHTXg8Cd+PWtcTAJik/QzxLm+IbEuRDMFcWcRlw=;
	b=mcSBlZQjJC/DxpbImXBTTQVTvZxx+V7/YwnHe9efxxoNGkg/rh8covSD6viUYPY7Fy
	Lw9P4efzu7N200RBCRYWIlUoA3sjAeP3PmmvnehkEAnJraSPyRmN7c9QsaEB9+jZFxNb
	RucVg6/CCuJ3xj2B2Eat/FM4KQ1xfiRtyJvmm5cCgMiMqN1imyWnzRrIJ/HwYogF6W4w
	iv5ShuzF+L/9e4cqd+X9vI1gYqV4MPKQY+JMmXAl82GmQr9bt1ZDlSZJKZP8Vyp2R+sY
	Tpdjb1LwXMObrOx1+xk7Q7c+NPH7uUwfs3T4WIcOPvkgivnw9qRVNeDGesxbbeU5Pv1x
	rkvQ==
X-Gm-Message-State: ALQs6tCvO5DdYCuATJlaZ9svIydiZJztaVXZLzQ2DPvwlqa/oG60NshF
	8vRMyBMEKM/pSxKy/kQz5NAHug==
X-Google-Smtp-Source: AB8JxZpyYwwpjjTmjg+rPPXBS+M5cN8T1SY1kogRyh3xCxQ1zIimlv23Nn08nTT52RxtwqfC5EIuNA==
X-Received: by 2002:aca:42d5:: with SMTP id
	p204-v6mr23138687oia.265.1525741339450; 
	Mon, 07 May 2018 18:02:19 -0700 (PDT)
Received: from e6520.guest-wifi.scl.liberty.com ([4.16.80.121])
	by smtp.gmail.com with ESMTPSA id
	v44-v6sm15299675ota.65.2018.05.07.18.02.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 May 2018 18:02:18 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 May 2018 18:02:12 -0700
Message-Id: <1525741332-13479-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetch/git: make fewer calls to _contains_ref() from download()
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
X-List-Received-Date: Tue, 08 May 2018 01:02:18 -0000

Updating a local git repo clone currently results in multiple calls
to self._contains_ref(), some of which appear to be redundant and can
be eliminated by minor tweaks to the logic in download().

Also drop redundant calls to os.path.exists(ud.clonedir) before
self.need_update(), since need_update() includes its own built-in
check for the existance of ud.clonedir.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/git.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 3de83be..b733be9 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -322,16 +322,13 @@ class Git(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        no_clone = not os.path.exists(ud.clonedir)
-        need_update = no_clone or self.need_update(ud, d)
-
         # A current clone is preferred to either tarball, a shallow tarball is
         # preferred to an out of date clone, and a missing clone will use
         # either tarball.
-        if ud.shallow and os.path.exists(ud.fullshallow) and need_update:
+        if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
             ud.localpath = ud.fullshallow
             return
-        elif os.path.exists(ud.fullmirror) and no_clone:
+        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
             bb.utils.mkdirhier(ud.clonedir)
             runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
 
@@ -353,6 +350,8 @@ class Git(FetchMethod):
         for name in ud.names:
             if not self._contains_ref(ud, d, name, ud.clonedir):
                 needupdate = True
+                break
+
         if needupdate:
             try: 
                 runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
@@ -373,6 +372,7 @@ class Git(FetchMethod):
             except OSError as exc:
                 if exc.errno != errno.ENOENT:
                     raise
+
         for name in ud.names:
             if not self._contains_ref(ud, d, name, ud.clonedir):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
@@ -472,7 +472,7 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        if ud.shallow and (not os.path.exists(ud.clonedir) or self.need_update(ud, d)):
+        if ud.shallow and self.need_update(ud, d):
             bb.utils.mkdirhier(destdir)
             runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
         else:
-- 
1.9.1


