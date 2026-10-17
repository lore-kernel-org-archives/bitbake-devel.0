Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3239DCCF2C1
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 15:32:34 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8465.1792251149877184215
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Oct 2026 08:32:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OdKqBDtT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so8118765e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792251148; x=1792855948; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IwpeTEbR6UeZwn3NYwAyVvOK9xR3hTKN1oSwCCqLA7s=;
        b=OdKqBDtTTh8OkHVxKtn7pHb5ERlenQcQV5HDIGbr/K5/BgFSkcK1CSsRISbaD0gOss
         95iZHK97bsrCZAs6uNJOplHHlSsGtlyr+Kpvu//7B/rXLoEMJabC1IwI6oySfhpxgcq9
         BFy7NkEJ56qscig96krsrEFH6ifVlNBlP1dyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792251148; x=1792855948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IwpeTEbR6UeZwn3NYwAyVvOK9xR3hTKN1oSwCCqLA7s=;
        b=BqUznHmwNXKshSLbxbY9mBAkmMekwVXHZv2rSvmugIxp91catmFopRY/+PeDlDA+ng
         3fbgTQPCpDVw5cBF2KGSYYtRKtJxwwJqUV9dUHEM4j+t7wT6FZP7pyfxJg5+sS52UJ9J
         /03X61oqp6uXGhUITha0m1f6Aul8OEsnW4O9DFI39dLPlh8JUcp9tUXFgANBNLXzejIj
         blp6ukiS2MArN6Gy+4qduPUHcOD33ImwuDD7/gWw1ayBR36Mkg16wkYELlxDJckuUZqP
         XVGFN0/qYMnohRjvXGF/PYsrozz0caBCoFbMlLZ0FDF7oQzyBd00yqgWQrDhwXk0YCbH
         550Q==
X-Gm-Message-State: AFq9FYL4Hsaa3MLKiYaPtIdpvxieLpWDrp3K2/QF0ti9Ddaiu2yHl3t5
	GkpuNxYZUjyKhWMbuo/RGGuDd+LIihjRyR+unOlkuDWYDsD99E30pbH3W1pt5csS8+qwpzLql85
	z5ql8hRM=
X-Gm-Gg: AYBFou26qkJMofzS6gHkwPmoi1lYiUS1uXWGrP+B6KUsq2RTIZ4aetBN29Jd/Bd5CkD
	wdnnIViJciSl79ztFdMVyJ55kJ9mKNZNJzVB3uUSLJgba0puU16LAuda5ndejNiIP12ciDN/81T
	9rlym6oAIhJxCPyA8x+2ewC4zz90zPDErmTgrURcHNTxtXzCiCj9Z7LsYErOYBkCgnK4H5JwmDI
	qsdKTqoq0nuF75dGDKTpyI5I+yZLTdR1smB9pI/oLIlbVHg9iNGmttYsWZ9g8UsI8mo35VqORqQ
	xCmfB0mJDchAiaa6ODOYcXczglfkLAmWHEooHSipyshjAixg/oNdGIzOgXyLMTzoeOMzdVKMhup
	SqVORXZSSDjq/iF0agXQii2tUajNmBspapacqYy7T7zJrUGp8IMwi1l6X3MypxrX/tlhsIFZBED
	PxP16XmBCOGe3nyVsuYhkvG1QMt35ccHwBmNF0pg6SDocyaiW25aNXG8EQDRdTMUgSHyXiD72sk
	KHOKjw2CuLJWX47g63lcusQpJo=
X-Received: by 2002:a05:600c:540f:b0:4a1:97c6:d2e8 with SMTP id 5b1f17b1804b1-4a1d7633b35mr62694815e9.32.1792251146672;
        Sat, 17 Oct 2026 08:32:26 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:471d:9ae9:4cd8:a378])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a72sm13032587f8f.4.2026.10.17.08.32.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:32:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] wget: Work around wget2 bugs in Range handling and --continue
Date: Sat, 17 Oct 2026 16:32:24 +0100
Message-ID: <20261017153224.78559-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 15:32:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20356

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch/wget.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
index b464fcfbe97..c554f162c04 100644
--- a/lib/bb/fetch/wget.py
+++ b/lib/bb/fetch/wget.py
@@ -127,6 +127,11 @@ class Wget(FetchMethod):
 
         fetchcmd = self.basecmd.copy()
 
+        wget2 = False
+        version = subprocess.check_output(fetchcmd + ["--version"], text=True)
+        if "Wget2" in version:
+             wget2 = True
+
         dldir = os.path.realpath(d.getVar("DL_DIR"))
         # Where we ultimately want the file
         finalpath = os.path.join(dldir, ud.localfile)
@@ -150,7 +155,11 @@ class Wget(FetchMethod):
                 fetchcmd.append("--password=" + ud.pswd)
 
         uri = ud.url.split(";")[0]
-        fetchcmd.append("--continue")
+        # wget2 has bugs with --continue and -O with servers that don't support Range: headers
+        # so we skip that for now with wget v2+
+        # https://gitlab.com/gnuwget/wget2/-/work_items/728
+        if not wget2:
+            fetchcmd.append("--continue")
         fetchcmd.append("--directory-prefix=" + dldir)
         fetchcmd.append(uri)
         self._runwget(ud, d, fetchcmd, False)

