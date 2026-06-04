Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38331CD6E77
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 13:34:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11719.1780580091242758327
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 06:34:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fjdI4fLY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b3e03939so6287755e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780580089; x=1781184889; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WZfIfFTkKfF7UF6Z58s5k16OwxGsysCgzW84wlDcJk=;
        b=fjdI4fLYwTWmj7ZFFUD3KFNkw67Mv3fnx23U7poqkYPueZ2Va30gBEy3Yy6ZEczkAx
         mcTus80NtUDlIlkWpnDDtGztRZ0qNWEG7pfzMSD8T8gHemDmdiuoMDxEq8f5CvT3+5lU
         ncdqIxO9XgYcVnYDyAQ044U3j8wGNwm8Gs3Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580089; x=1781184889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5WZfIfFTkKfF7UF6Z58s5k16OwxGsysCgzW84wlDcJk=;
        b=PuJ8/86kOLzofEL7uPahqzBv4ca2iGvezXN6uW2K4ugiFG9NmEFZud/LCx6GHL442Y
         ACOZzOdhRbDX2OnS3isfxvPGKJ1RQmFQ5nQUZqjJiwPxe421nYjzqsvwlyNrbO9XKflZ
         wSDEru16CWjAFUiDvB8s5qyfCPwXa8Mx0121YhVvgfCz9DMmfcYlgET4YrnYNMtFaNPB
         wOVD6bWxP4sA7T2ny7iLqnGURc1PD2T9veHzESYD8CkGHyN/ewKK0fFLMdWSNYHAKIjz
         87jn4iWDhuS+bVn3p3I1nnZMqDwqhTyUlTob0H2RPMH5BgXTP3UTeXQi8gIJrNtmlLrb
         EB3w==
X-Gm-Message-State: AOJu0YzZ9eCYIdVci5MN/91ZgYuFJhRabpDvtzKvpDrcbt+0w5ZHZlh/
	XRV3QICXCOORQwVhJVINUvoxg3vRrNpYpV+6Lau92RtEvsEeytcXw3z7CltJ4bu/Xy6gd9QcGrR
	OJk3U
X-Gm-Gg: Acq92OEm8GXFzxwdR4XUvZPSBZ6ymQOI0KdczyLRkO6bltdfNqj3JHRgjXLfM4jjBFj
	QnJOq9MZzqrlEzA4Dy2+h/tR+HdWY3rfPRxk0HRWSRhntpmLKgluisogH+PBDedmthWxZbiOXxd
	FV4pmIC9icVvfT9FfNRxCFkUfFFnnFmRgDtnYlgO0Vh0ZvCHS8UgQcr/J6mlc3QgscRNJ/ajNny
	Qg9hj+XGg6MHH3soXL6GPL6LeBxOuT09W8NweJ01Rlw/5tpxpLgkD2Mj3glB08JBdVcW6poGI7k
	jfmi/V76eP35yNJF630Uw/F2YKrYqzV7H+JPBo2O62rHMkDHECyjeNnaqwXm92MDtNuWKNHKju1
	QXmeN3K074w+aSA2RqEK1/S2r5GOwJpM8ulUVUQTtg2LFXgNTfMDCsPW/TQUUmWsvbQj63J5uPU
	MfVCDbjetEt6HpbswX6EuaHZBAru54KkVpf4uyycfbJMGkWQcEYFqqS1+hscwIjn4=
X-Received: by 2002:a05:600c:528a:b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490bc506460mr56775315e9.15.1780580089163;
        Thu, 04 Jun 2026 06:34:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eed3:d0ae:8f44:9e49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm71326935e9.12.2026.06.04.06.34.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:34:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/5] fetch: Abstract command execution in unpack()
Date: Thu,  4 Jun 2026 14:34:43 +0100
Message-ID: <20260604133446.2528212-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
References: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 13:34:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19606

Make the command execution a function as we need to do this multiple
times in some cases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d94f54d1bc5..07997946e22 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1554,6 +1554,11 @@ class FetchMethod(object):
         else:
             unpackdir = rootdir
 
+        def _run(cmd):
+            ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir)
+            if ret != 0:
+                raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), urldata.url)
+
         base, ext = os.path.splitext(file)
         if ext in ['.gz', '.bz2', '.Z', '.xz', '.lz', '.zst']:
             efile = os.path.join(rootdir, os.path.basename(base))
@@ -1654,10 +1659,7 @@ class FetchMethod(object):
         if path:
             cmd = "PATH=\"%s\" %s" % (path, cmd)
         bb.note("Unpacking %s to %s/" % (file, unpackdir))
-        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir)
-
-        if ret != 0:
-            raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), urldata.url)
+        _run(cmd)
 
         if iterate is True:
             iterate_urldata = urldata

