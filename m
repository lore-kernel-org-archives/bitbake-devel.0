Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.718.1794421151882709814
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Nov 2026 10:19:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IQSGEkui;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so30237685e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794421150; x=1795025950; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6XqsJLwbdXGQkwcMpAdHZUk+NOwIK5Kaf6dB6soAUJE=;
        b=IQSGEkui+JMlRibg0gFSLpvdlwbLOiA14NnX65/svFV5dddkUYEByALqa+mg0ABVVs
         0JrzyR6NNw7GLOMWdYnB0EIUETcTF0C1CoGru3Il2oZBda7T9cLYU0DmZ2D9OyZe+B7i
         8iEQduJl6FZS6M+2Av2vg7dz5Tc0b6pRRtgIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421150; x=1795025950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6XqsJLwbdXGQkwcMpAdHZUk+NOwIK5Kaf6dB6soAUJE=;
        b=rR3RAodF1kW+XuNHRd/EBABZxSx2JzJ5EqhIq8bx0HBImENXdqLiUlldemm0stTMVc
         nawbY0iESOZJUDnq0T0uTPlS4kYZ89qSg1ZSStw/miSkJlWJVPFOh/zKQckgSYvb+xSD
         +qTr15/BhKat5Yw6WglLxY67H18yS73VCQ0MD4Ff5xC7e5PTCwCmBn2jJ4RvBOT4JI96
         fGtTxjaV8JTEtPP3xxJS1aqlxP5CT3Db2P51oKY+gNYvx4skMLQynN9c4cALzqT13Eeo
         Yyb3HwE9DApYjcuFq8eeEw4IfSS2C9mEkmWrDlgNXAIezcTDnDdfAA2RhFoCSh5eRknF
         JNiQ==
X-Gm-Message-State: APuU4Z8SYA8GBKA7z8WUutkJx8wd34nyqavChyY2qSKx2pSku/TW6pMe
	28P/3Mn2+JeiFdYIXIvA8u6p/cH5oLmIy6dFG5wQvQZUdO8ZPOfQNna9NfL7V3EvJ7SeC/mNbmh
	pA4gW5vM=
X-Gm-Gg: AYBFou2udjlIbGFtsWqHMqYVhXqaacyr9XfNlUUT1tvmHBv0/Z9amjMcwU9jzE/5imN
	XuGmO0SBHu9cgcJjxucuMhMyVHmd4U3JcEZubioSQJfVMOijNMlPluFMR0zG9ePN/K3lvDNMOwv
	jrEAEN2YB2evv0A5mwVaceH8SlFwOcuuOBE+bDMEcoa+WeFi8YoBFdo25z6ZlLeXKGIrLdXmp1Z
	n1TaYNBkORDm7H415//BpiCzGFcJRcZwieMFHZcuGHNTvEf4yvl8g1Z58fPHtedoS12jT2vm9UF
	9CCJDcBQikYNxnusjoY+YW6x9H0eXhAPcnEYt1jtsWMuW/FHNFPZ5mii7vmKpL7vm/U2fJCl/1/
	WzM3hhGEUZiUxrPvDg2l+LU4cQSwPVUWChleDCsHMt/QtREDL280NkKz68uAKF21ou0VdAzBWU5
	TSZCvEeeK4V36vjsAUU8uCQRGmqaYfqHBNDiUjngOn8j1FnfAgp3l+kLkA6fB/xMfWYeZvr3ECg
	kHhfWUD3xkCkFqG25p944JvYcUc1yI6Auma5n0afbzycYXXKEnCOruJRlcy0zkntO73RjbeNCap
	P4o7roPQ+S3951PxdB4d6pUCUtHYC1N32A2Y2EVD+m8LG7lq+mLc5f3mYA==
X-Received: by 2002:a05:600c:1d1d:b0:4ab:cc03:7f60 with SMTP id 5b1f17b1804b1-4ba09365d6fmr58366485e9.18.1794421149887;
        Wed, 11 Nov 2026 10:19:09 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cf1f:44ae:c155:c362])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988bdef64dsm10936787f8f.20.2026.11.11.10.19.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:19:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch: Fix uninitialised variable issue
Date: Wed, 11 Nov 2026 18:19:07 +0000
Message-ID: <20261111181907.2627513-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 18:19:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20421
Content-Type: text/plain; charset="utf-8"

Running fetcher functions directly from bitbake-setup with an invalid
DL_DIR can result in an obtuse error:

ERROR: cannot access local variable 'lf' where it is not associated with a value

Make sure lf has some value, which means the real error isn't hidden.

[YOCTO #16494]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index eb3483a48ae..233eb6dc49e 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -1904,6 +1904,7 @@ class Fetch(object):
             m = ud.method
             done = False
 
+            lf = None
             try:
                 lf = bb.utils.lockfile(ud.lockfile, shared=True)
 
