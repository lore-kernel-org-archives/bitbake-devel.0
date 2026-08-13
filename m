Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A99AC5CFEB
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 12:48:52 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18292.1786625324364940644
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 05:48:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OcWJrzda;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-480033bdcf4so420201f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786625322; x=1787230122; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1liaYcjqx1BoXbvtMlNRXjDqGa2iESeDmfAnlKfT3oI=;
        b=OcWJrzdaTFKSWDlnx/CjG9kxFKKk8LZtAs+MuY5qbOcdqbQLPWA266PY0dc2qOHcOl
         2ANdxlPvwhvMUW7ZHuDjf30FknONWOMq5pwv3lSWVdgPdtbB3w6UBWJrDAQbGnfZdAge
         5Zd+sCAjlwji8C1HXUcz8G8+xqRFzaPIO9Ftg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625322; x=1787230122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1liaYcjqx1BoXbvtMlNRXjDqGa2iESeDmfAnlKfT3oI=;
        b=Tq7NO8D7JYfezwQHnwGEljt3x2+hFYDBjbPTMFZmwvN1MSBIWSYAjYzK4ylf+Nsmyc
         yHZhc/XT0RGXWy1E+SjL3GguDTrhnnIm/Mcwr9axrFXeB3HtLje9/taEAhojQwdTIXkL
         jzJafPZmT+2U4KC5hMckBRGIcjkfU+sh5Q79u38CUniqDlBet6j/2WDr6cPo2THMhnDC
         45xSO2lsXRFKYBwLK64Ytgogg6Jd3AdRE+nA24FB3SXAOTRRbEwirR+DrFM+RYKxCKKM
         hr0o6Wp3xXkOM4/nK32CN0xWwtsD5SIhejY3yykW8/Pw69LW6RV5+vwFSQ0NRAXAteY4
         dwdA==
X-Gm-Message-State: AOJu0YyJYO0QAnkXCkBdwrSVWk/ubQjHoVwUq4HhFZmvypvutsIQVdkf
	tQ3vSjNRSYfDaCPR0DSuqXjNOTxnFqtOqGYbdSpVF5jS9WDIIEIEUW82LemmmxiTJFlLC/MM/Kq
	XNDsYCVY=
X-Gm-Gg: AR+sD12gPSU6Byc+0cu2W1/EEZSQhKdq0IA7Kywz25tz42IaVoqG+zaUoiPEXjn3Lho
	AHxXUCXveajtpTfTg3UzYb+ZBFuv9CALVOSjpMgj0qtHLWarmbqd5uzXSmSKqkUv1bog8DugNsS
	D/rOPkf4Q6flyeSHcjcz6VqlIa3sw1BRDsLXLYlVvhKcSG+ZOzYTG+bM5CnXwlqjnsd6GH7+U5/
	DJhUYRF4fE0NBcCBibCe1vhTJGGJ4Tc+l6g34USlfnLYyVYF/dBGzgngH6V8fSuC+XwmJcrjZNL
	mZlQoLTzRKetiOnN9+L8RutVRx8whwNI7sPazM2NDPJrdlHJm6CNumouRZOqVCkgl9/gMkSZ61o
	/ZsWKRn3JMLPZ77lcbS88stb4d/aJkVXtOPu2Ht/LHO2VFwLJCnmpoMIR2oqIHtYS2YtTOMOgH4
	a6lNVbjLJQpLoR7r+BouwbGOHXCgU+GlYuAjrf9r8KB8K4xf3OaliPN1GGLn1Sstapat7AgJbEO
	TSrcS0UXppM0DpqAg==
X-Received: by 2002:a05:6000:4715:b0:480:c5:d635 with SMTP id ffacd0b85a97d-48159b69091mr8829566f8f.0.1786625322386;
        Thu, 13 Aug 2026 05:48:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e77b:339c:e0c2:6c8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6616sm6685768f8f.25.2026.08.13.05.48.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:48:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/6] fetch2: Switch to shared locking for read accesses
Date: Thu, 13 Aug 2026 13:48:34 +0100
Message-ID: <20260813124834.1770307-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
References: <20260813124834.1770307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 12:48:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19928

Instead of always using an exclusive lock, use a shared lock for unpack
and the initial checks of download. This should mean that if we don't
need to make any writes to the download directory, we only ever need
the shared lock. As soon as any writes are possible, switch to the full
lock.

Also take advanatge of being able to pass None to the lock functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2676e0962b9..b6006fa38d7 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1097,7 +1097,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
     # False means try another url
 
     try:
-        if ud.lockfile and ud.lockfile != origud.lockfile:
+        lf = None
+        if ud.lockfile != origud.lockfile:
             lf = bb.utils.lockfile(ud.lockfile)
 
         if check:
@@ -1174,7 +1175,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
             pass
         return False
     finally:
-        if ud.lockfile and ud.lockfile != origud.lockfile:
+        if ud.lockfile != origud.lockfile:
             bb.utils.unlockfile(lf)
 
 def try_mirrors(fetch, d, origud, mirrorvar, check = False):
@@ -1911,14 +1912,15 @@ class Fetch(object):
             done = False
 
             try:
-                if ud.lockfile:
-                    lf = bb.utils.lockfile(ud.lockfile)
+                lf = bb.utils.lockfile(ud.lockfile, shared=True)
 
                 self.d.setVar("BB_NO_NETWORK", network)
                 if m.verify_donestamp(ud, self.d) and not m.need_update(ud, self.d):
                     done = True
-                elif m.try_premirror(ud, self.d):
-                    done = m.try_mirrors(self, ud, self.d, 'PREMIRRORS')
+                if not done:
+                    bb.utils.lockfile_to_exclusive(lf)
+                    if m.try_premirror(ud, self.d):
+                        done = m.try_mirrors(self, ud, self.d, 'PREMIRRORS')
 
                 d = self.d
                 if premirroronly:
@@ -1980,8 +1982,7 @@ class Fetch(object):
                 raise
 
             finally:
-                if ud.lockfile:
-                    bb.utils.unlockfile(lf)
+                bb.utils.unlockfile(lf)
         if checksum_missing_messages:
             logger.error("Missing SRC_URI checksum, please add those to the recipe: \n%s", "\n".join(checksum_missing_messages))
             raise BBFetchException("There was some missing checksums in the recipe")
@@ -2031,8 +2032,7 @@ class Fetch(object):
                 ud = self.ud[u]
                 ud.setup_localpath(self.d)
 
-                if ud.lockfile:
-                    lf = bb.utils.lockfile(ud.lockfile)
+                lf = bb.utils.lockfile(ud.lockfile, shared=True)
 
                 unpack_tracer.start_url(u)
                 if update:
@@ -2042,8 +2042,7 @@ class Fetch(object):
                 unpack_tracer.finish_url(u)
 
             finally:
-                if ud.lockfile:
-                    bb.utils.unlockfile(lf)
+                bb.utils.unlockfile(lf)
 
         unpack_tracer.complete()
 
@@ -2068,16 +2067,14 @@ class Fetch(object):
                 if not ud.localfile and ud.localpath is None:
                     continue
 
-                if ud.lockfile:
-                    lf = bb.utils.lockfile(ud.lockfile)
+                lf = bb.utils.lockfile(ud.lockfile)
 
                 ud.method.clean(ud, self.d)
                 if ud.donestamp:
                     bb.utils.remove(ud.donestamp)
 
             finally:
-                if ud.lockfile:
-                    bb.utils.unlockfile(lf)
+                bb.utils.unlockfile(lf)
 
     def expanded_urldata(self, urls=None):
         """

