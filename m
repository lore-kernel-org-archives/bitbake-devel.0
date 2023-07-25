Return-Path: <dit.kozmaj@kynetics.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD26C0015E
	for <webhook@archiver.kernel.org>; Tue, 25 Jul 2023 13:47:24 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.20761.1690292838282540085
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jul 2023 06:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kynetics.com header.s=google header.b=eirQyB5Y;
 spf=pass (domain: kynetics.com, ip: 209.85.128.54, mailfrom: dit.kozmaj@kynetics.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so54743375e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Jul 2023 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics.com; s=google; t=1690292836; x=1690897636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZYWA6qB2mx//aN80PJn6UJjU+P7Q/XnQn7fmJXKjLQ=;
        b=eirQyB5YPlv0LBGsCdj+ToZwFWKi43S1MGO0y+PWf3Y82isAqR35hLCJn0vsgEHRGj
         gqeWUfmQsdbLdG7z1sJs2J0K/bqAbmCiFpMGfwgcsIb9ihH3Af/zKNLpJX7MElnVetmP
         Xs7moG6Q5s13cbWV6dQroqx3dFMMC+xGmGzyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292836; x=1690897636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZYWA6qB2mx//aN80PJn6UJjU+P7Q/XnQn7fmJXKjLQ=;
        b=ggIBx1yMt4Y6L9MWu+54YMb+SDzhp+kq5h7LOxeUJgIX99xXlBkE0u9y+CfPOZtnw8
         gMS8KSa2l/9w4nxIWJ9O26ebQbEyNIzvIV+JBlGvLXjlDvTS9MNgRUWnUQyz3KXVWZfa
         Doo/zuo+OIckfKr8w+s2WlNVAHIEVtrkwpt57lMFNJQYQYmlsCXAEspfkxiCz0/Pmh4V
         bseq2/rhurxt2Osqt+kmkdkiE8n7DXjJu7gmuuawoRJlBDmLfon4Mq+8KiHfQekYEF3H
         XwnH4LeuI2fHCXTVHChY+j5IuXIu1YMIZSYETfCPEbTFbupv/xR8ZCmBf1DzhvJLLaNW
         JRjA==
X-Gm-Message-State: ABy/qLYTK2f0U/FJZYoQZ8f0vfUNVgUO8WoYoU2BhJk98XLp0YVBmKLA
	DSumLEg/JzYmFOy6RRHkiqkjR6dtOC+WaanDvds=
X-Google-Smtp-Source: APBJJlEKb/hO3X0Hf/7L+G4M2+9p4M5KPRHPsoozuhfxI0J1fIy00n5I20vuzOFYK0j6FoOVS4hPHA==
X-Received: by 2002:a05:600c:260d:b0:3f9:c82e:9d87 with SMTP id h13-20020a05600c260d00b003f9c82e9d87mr10193060wma.13.1690292836273;
        Tue, 25 Jul 2023 06:47:16 -0700 (PDT)
Received: from ip-172-31-5-183.eu-west-1.compute.internal (ec2-3-253-245-184.eu-west-1.compute.amazonaws.com. [3.253.245.184])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bcb8e000000b003fbc9371193sm13392761wmi.13.2023.07.25.06.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:47:15 -0700 (PDT)
From: dit.kozmaj@kynetics.com
To: bitbake-devel@lists.openembedded.org
Cc: Dit Kozmaj <dit.kozmaj@kynetics.com>
Subject: [PATCH] fetch2: Set maxsplit to match expected variables
Date: Tue, 25 Jul 2023 13:47:10 +0000
Message-Id: <20230725134710.85784-1-dit.kozmaj@kynetics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jul 2023 13:47:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14887

From: Dit Kozmaj <dit.kozmaj@kynetics.com>

Set the maxsplit value to match the expected number of variables.
This also avoids an unnecessary split as the parameters are in the form 'key=value'
and the 'value' could contain the '=' character.

Signed-off-by: Dit Kozmaj <dit.kozmaj@kynetics.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 bitbake/lib/bb/tests/fetch.py     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 3e6555bd67..79b289eaec 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -388,7 +388,7 @@ def decodeurl(url):
             if s:
                 if not '=' in s:
                     raise MalformedUrl(url, "The URL: '%s' is invalid: parameter %s does not specify a value (missing '=')" % (url, s))
-                s1, s2 = s.split('=')
+                s1, s2 = s.split('=', 1)
                 p[s1] = s2
 
     return type, host, urllib.parse.unquote(path), user, pswd, p
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 61dd5cccaf..a261ad69d8 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1197,6 +1197,7 @@ class URLHandle(unittest.TestCase):
        "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', collections.OrderedDict([('tag', 'V0-99-81'), ('module', 'familiar/dist/ipkg')])),
        "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
        "file://somelocation;someparam=1": ('file', '', 'somelocation', '', '', {'someparam': '1'}),
+       "https://somesite.com/somerepo.git;user=anyUser:idtoken=1234" : ('https', 'somesite.com', '/somerepo.git', '', '', {'user': 'anyUser:idtoken=1234'}),
     }
     # we require a pathname to encodeurl but users can still pass such urls to 
     # decodeurl and we need to handle them
-- 
2.25.1


