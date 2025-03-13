Return-Path: <patrik.nordvall95@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ACEC282EC
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 15:59:52 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.18629.1741881583959824359
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Mar 2025 08:59:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IDv1/dVV;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: patrik.nordvall95@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so1262108e87.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Mar 2025 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741881582; x=1742486382; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SOOwZsjRZC4gvzFIZf+HneEaEeKdD6XnWaCQC7GDns=;
        b=IDv1/dVVxR1rB804feIz0gWi0+Ak5v5YXP/DXaNu0ES4KcyLUUobO3VfsTNEenZQQ/
         hdxRyNMse4LPbWMQZrrT6CyYx92pH4bZkhoOcr8f2H/UxltCcXC6qfc5CbfTgUIljx9i
         DBms/Pf5g7vxMeE6erAg7oJyoS6/ddGLefmSrwsy/rd6ik609DDB5txCLw7Vz0mnnIdo
         QnmdO26AMaBg5LXBk7GJNcHv27fLUaNGG8uxwAbWcKX0Py+WhKzN5UrIoyKkdhzIX07G
         l02CtKnLwH0ne97LHL7UdBdZ3v0CDO0YvI6ftDHix8wfTNbhQu6PmvBhDuwiWnBkGPgx
         c3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881582; x=1742486382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SOOwZsjRZC4gvzFIZf+HneEaEeKdD6XnWaCQC7GDns=;
        b=cac13N5V9vfzwbLWM8RY1KbeileDx8TGyeufjKIQH6R1qpKI4x9xwQqlxiwWDo700x
         Cq0D1LMoYgIUzfQ0+JmQRguehtEyVzm8b8gvRbLrCcWAMQidXprSkvj3lAM095K3SyY2
         HhYuZQiL87EzuF0X/4FHpJ7ZODAei2HA5o9qXa0QQ3Xpoc8rWIEYF5K4U849Hy3jo3Qb
         Hu+yPayIMq5kFu34zPC5hAmXPIMI12GDb4JAmnKGRNStVFkS7EzOVbdLL9sIJWXAIa2n
         IoIiqpBTXl1/6hXUqQFjo0mfvZzQk+sWhFsFnl8esIy+Q9DKLoKksam8j7zRm2D5Kaec
         sgyA==
X-Gm-Message-State: AOJu0Yxu6WpeygbG9s9kmfWgP8ETHwJEFaEZbOqGbswXan9tGG/pehBC
	s6L4ykb4wzebiEHnZiC1obFELigp2BuWSQlR06vHvgnUee0KuUtZZNQuPacCEuA=
X-Gm-Gg: ASbGncsi5YtZYPVJI8mMpP4gd8kBCaSR98u/dPJE455zrlDBdCzpFWl30Po5QsCTSA6
	JXNiOVnFy+pG2XK7UHCJ5bN94kHSAompNtfjioW9Lu/2L5PKrWgVxDPYsqEpGdEvEyB1IVSn92f
	mDBE5lf91LmzbTCq8m5wnpKjRmaUePs7OuIKPfPohO/h+eI7LEzCMK+UJRA24wGAgDlxC4Lo7LI
	3gnoRXfpzm9K4wTe9smdj8xyCvd+WQLSOObEy4RBtL/TXvczk+4dagaN/BR1llIynRY47k2To+n
	j1STYNOjsugo5J1DBjvnL32X782FUbHHdNLc5L3JpQp1eSEYAUqwsDqzbNJA21j9/AqS2jNH9g7
	GbaYpLNmlsVIGu/Id70N9gf+RS0JWeN0N8A==
X-Google-Smtp-Source: AGHT+IGRyFqL97yWTmEX/2TrWce6I9vsq3GNgpkbC8LCIZaVLJP5HqWO1zTaCmrajSwdcCMBJ4gpKQ==
X-Received: by 2002:a05:6512:159a:b0:545:154:52b0 with SMTP id 2adb3069b0e04-549c09ec4bdmr60127e87.22.1741881581386;
        Thu, 13 Mar 2025 08:59:41 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-3-54.A240.priv.bahnhof.se. [155.4.3.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c12a1sm246329e87.83.2025.03.13.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:59:40 -0700 (PDT)
From: Patrik Nordvall <patrik.nordvall95@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Patrik Nordvall <patrik.nordvall95@gmail.com>
Subject: [PATCH] fetch2/git: Restore escape quoting for the git url when used
Date: Thu, 13 Mar 2025 16:58:50 +0100
Message-ID: <20250313155850.2924491-1-patrik.nordvall95@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Mar 2025 15:59:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17441

This fixes a bug where escapes in the url path would not be properly
restored for the git commands in the git fetcher. For example, a
space which is encoded as '%20' was not properly encoded before the
clone command.

e.g.

SRC_URI="git://git.openembedded.org/bitbake%20example/bitbake;protocol=https"

resulted in
git clone 'https://git.openembedded.org/bitbake example/bitbake'

instead of
git clone 'https://git.openembedded.org/bitbake%20example/bitbake'

Signed-off-by: Patrik Nordvall <patrik.nordvall95@gmail.com>
---
 lib/bb/fetch2/git.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5b678827e..aaf571eb6 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -81,6 +81,7 @@ import shlex
 import shutil
 import subprocess
 import tempfile
+import urllib
 import bb
 import bb.progress
 from contextlib import contextmanager
@@ -828,7 +829,7 @@ class Git(FetchMethod):
             username = ud.user + '@'
         else:
             username = ""
-        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+        return "%s://%s%s%s" % (ud.proto, username, ud.host, urllib.parse.quote(ud.path))
 
     def _revision_key(self, ud, d, name):
         """
-- 
2.48.1


