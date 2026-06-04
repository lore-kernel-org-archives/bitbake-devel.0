Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DBCCD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 13:34:54 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11746.1780580091992824484
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 06:34:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aQs6oRK/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so4106185e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 06:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780580090; x=1781184890; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rizkG9jZuJediubgH/mX6ef/0Hne4R43p5mzR8jB1QE=;
        b=aQs6oRK/ddtBcWzY4/HP/48eeH0q21Nkv2Dcpj9UFNHxMve1IYHQmcbExma1k38O3y
         Qb9WgtlT2kJZNd93q966hdcHi6oU8fPfS1XWohDJGtIhyZ6TJZDg92A8fwdXQPXM5XIi
         UNvTMV5H0/Sd5A/O8Nh1th4p//NivMk0R/xUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580090; x=1781184890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rizkG9jZuJediubgH/mX6ef/0Hne4R43p5mzR8jB1QE=;
        b=m9dMoqr10YuATvM00wBqlsOza9oVgJjXTqSaUve6LOJXBQQrd7DDHixZwLPutzfrfu
         ++JEIZJFx6lG+hjZtro+we/8MN7H9yZrKRY5FNYiMEvOhgEGeazm817oY7UbZYxo4nEI
         +3JB3lKNoZYJSbsUSJCpbXIx2/etk8f4m/bvh0txHcbmuh3PZpmtRKbyGGnaKeCPi5eN
         VZRTLDZN3Z7fXkhhMJSRNOUE/gN0jnFQiiicRwGeKq69mXwbcnrhH/WrQBPAY46HjN1f
         lMY/buwMCm0JAXATWZ6xV7zkhXZq2S/cpN0W0j06liTvjBeexpctk/LoUg86GVPmWJJU
         cEMQ==
X-Gm-Message-State: AOJu0YwMBEVPBBldJ8fShmWJs7s2JUY5EMHkHMIReBur4lGkTxn9nuGk
	NSAm38DIHSwnNR7CncONGmmc9pTNU1Kyt0sS3/aIVN50al7NbdRchZgBw7ZI41koh9bBcK+0+kA
	v22FC
X-Gm-Gg: Acq92OFL/tq6tmQsIFww9voLlrdYEH7VRmduMLd8QgPZy+/G33C5EP7kfkjEzIFrUtK
	4MpIKEgm/9EVLxF5xK94n20VuVWp9uXO89XEEZXWsWhb2dfnsbW6vhfTXkWIR6CdsxcUB9A/mPb
	Y41ZBAuNrbzZpJTRG4SKu/1wluQuMvotnF972HMFvbRsyjKCbD9DL4cQQT1PdMfD0sFOmzgi39j
	Sd9uNJapXaGyqCoRaOO+waEHazbERfO+sD09VI4BRvtSrZEGv6BjNB6UWNnbi8e9HWb71LrtyoK
	LnUOf5p+vPpeMWeeEsEzP4buLLqYwUe2Sv+h8rWXOIDHJkFfJZKdEkvHewD7H+eafdOk75mEIdm
	kgqb8QOCT0dTp0jKBH9GOI8GB5XyakbU/qHyXEaB+fgiC+BNoCou+nCcejcM90QKzxOpS+nW4wJ
	7oYKwyr7nlgysD96Y+yXtGtJvrpHXcOYBU4IZd9UN5xyQNDMQw0Iis35P0CZlghTAIm0UsqOzzH
	g==
X-Received: by 2002:a05:600c:45d2:b0:490:bada:6b15 with SMTP id 5b1f17b1804b1-490bada6c90mr99332305e9.17.1780580090283;
        Thu, 04 Jun 2026 06:34:50 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eed3:d0ae:8f44:9e49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm71326935e9.12.2026.06.04.06.34.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:34:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/5] fetch2: Improve environment handling in unpack()
Date: Thu,  4 Jun 2026 14:34:44 +0100
Message-ID: <20260604133446.2528212-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
References: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 13:34:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19607

Rather than putting environment variables into command strings, pass
them directly to subprocess.

This adds PATH to the environment to a subprocess call to 'ar' where it was
previously missing too so the function is consistent.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 07997946e22..845dd3baab1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1539,7 +1539,10 @@ class FetchMethod(object):
             bb.fatal("Invalid value for 'unpack' parameter for %s: %s" %
                      (file, urldata.parm.get('unpack')))
 
+        env = os.environ.copy()
         path = data.getVar('PATH')
+        if path:
+            env['PATH'] = path
 
         # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
         if 'subdir' in urldata.parm:
@@ -1555,7 +1558,7 @@ class FetchMethod(object):
             unpackdir = rootdir
 
         def _run(cmd):
-            ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir)
+            ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir, env=env)
             if ret != 0:
                 raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), urldata.url)
 
@@ -1618,7 +1621,7 @@ class FetchMethod(object):
                 else:
                     cmd = 'rpm2cpio.sh %s | cpio --no-absolute-filenames -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
-                output = subprocess.check_output(['ar', '-t', file], preexec_fn=subprocess_setup)
+                output = subprocess.check_output(['ar', '-t', file], preexec_fn=subprocess_setup, env=env)
                 datafile = None
                 valid_datafiles = ('data.tar', 'data.tar.gz', 'data.tar.xz',
                                    'data.tar.zst', 'data.tar.bz2', 'data.tar.lzma')
@@ -1656,8 +1659,6 @@ class FetchMethod(object):
         if not cmd:
             return
 
-        if path:
-            cmd = "PATH=\"%s\" %s" % (path, cmd)
         bb.note("Unpacking %s to %s/" % (file, unpackdir))
         _run(cmd)
 

