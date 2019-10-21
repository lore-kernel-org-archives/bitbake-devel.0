Return-Path: <kergoth@gmail.com>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail.openembedded.org (Postfix) with ESMTP id 0B2EE7F568
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 17:08:56 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id l10so14451063wrb.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BPSPhbex76tbdcGxq2t4DPyMj2Jpil7hFcw9eRHCh80=;
	b=QwCG6b0UMxs1gv9AdybW8HUvlkAu8SkFKxPGkmGfJdUNnKviXzeElu8eVo3794m2Lp
	papU/4qEosmspi2BJae31+wxFtygGNdz88QHp4h/F8Xck9HCIwk3MIsY2Xe+AjqQTKCb
	tW/QqaWjIovUC09C+Cwa9HkdZ0Jh3gd1ecND4H7QL18Ki/j0wJeC1tHxafRjTv1l7z2/
	D2AokSf0HD/yKqUtTFmhXSCMs9rcRnBRAcqw+TjQcaFGTEWguh7RA2rEqg3QMosMGSxb
	XUQZ3BiCA4G1wzi16VKA9xOFf16yGauMqkXVnJsuoZv2FMecjYS9XC2a9cTnL/9m9rbU
	KObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BPSPhbex76tbdcGxq2t4DPyMj2Jpil7hFcw9eRHCh80=;
	b=QVQ0KfP0q1zmMl6qMU7pJaBqHqKaZFsMM6CieIpdQ4jJR1tghRuvtZHaSMkPfFi91s
	J1KFK8gwf2NVB0HuTIj4tm+7xVPFYLda2htNw3uLykEKhW/iawR3MabHl5DrrbbPGw9+
	N74/UXO2U4b2ytYtrezUZsgx2SF8d11kvljPRbq13Yd1hx89yPiAE6iefMVBKtxHLkTJ
	nSvtPwSAyhXwx873bJzqiivrrpJrMVMHc7wkHSVI2mW2EFZAdvLLvsD3F3Gu0ZxWi9qm
	05JjGuaSDiDGUobwU9wuX1jalJukA7RbYQN3pkYVtG/fnbRN72Om0pUKyTO61KijFDjV
	Vs5w==
X-Gm-Message-State: APjAAAWzWemYqXFxpobGH/eT3Xb3Xb0EKk6lyy7wvqpXatAtr8z5ofMQ
	Jp8pspPWgrKAMqQRGDrWunApjAqI
X-Google-Smtp-Source: APXvYqxu1TE/O4u3jlAa7E9rGoBgiwjfdQxtOkErIOGr1HI5j3b1v22YVj6CnOnJAiFnJGmCEYMaeQ==
X-Received: by 2002:a5d:63cf:: with SMTP id c15mr15066221wrw.89.1571677737212; 
	Mon, 21 Oct 2019 10:08:57 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id y1sm18532170wrw.6.2019.10.21.10.08.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Oct 2019 10:08:55 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Oct 2019 22:09:53 +0500
Message-Id: <9672192ba6cc9323589641d79b72851255e84fb6.1571423503.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <cover.1571423503.git.chris_larson@mentor.com>
References: <cover.1571423503.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/2] fetch2/git: fetch shallow revs when needed
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
X-List-Received-Date: Mon, 21 Oct 2019 17:08:57 -0000

From: Christopher Larson <chris_larson@mentor.com>

When bitbake determines if a git clone needs updating, it only checks for the
needed srcrevs, not the revs listed in BB_GIT_SHALLOW_REVS, which will fail if
using shallow and the needed rev was added to the upstream git repo after a
previous fetch. Ensure that we also check for shallow revs.

[YOCTO #13586]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/fetch2/git.py | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 2d1d2cab..fa41b078 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -292,11 +292,21 @@ class Git(FetchMethod):
     def clonedir_need_update(self, ud, d):
         if not os.path.exists(ud.clonedir):
             return True
+        if ud.shallow and ud.write_shallow_tarballs and self.clonedir_need_shallow_revs(ud, d):
+            return True
         for name in ud.names:
             if not self._contains_ref(ud, d, name, ud.clonedir):
                 return True
         return False
 
+    def clonedir_need_shallow_revs(self, ud, d):
+        for rev in ud.shallow_revs:
+            try:
+                runfetchcmd('%s rev-parse -q --verify %s' % (ud.basecmd, rev), d, quiet=True, workdir=ud.clonedir)
+            except bb.fetch2.FetchError:
+                return rev
+        return None
+
     def shallow_tarball_need_update(self, ud):
         return ud.shallow and ud.write_shallow_tarballs and not os.path.exists(ud.fullshallow)
 
@@ -339,13 +349,7 @@ class Git(FetchMethod):
             runfetchcmd(clone_cmd, d, log=progresshandler)
 
         # Update the checkout if needed
-        needupdate = False
-        for name in ud.names:
-            if not self._contains_ref(ud, d, name, ud.clonedir):
-                needupdate = True
-                break
-
-        if needupdate:
+        if self.clonedir_need_update(ud, d):
             output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
             if "origin" in output:
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
@@ -369,6 +373,11 @@ class Git(FetchMethod):
             if not self._contains_ref(ud, d, name, ud.clonedir):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
+        if ud.shallow and ud.write_shallow_tarballs:
+            missing_rev = self.clonedir_need_shallow_revs(ud, d)
+            if missing_rev:
+                raise bb.fetch2.FetchError("Unable to find revision %s even from upstream" % missing_rev)
+
     def build_mirror_data(self, ud, d):
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
-- 
2.11.1


