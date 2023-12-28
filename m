Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A342C3DA6E
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 22:59:52 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.134213.1703804385133094101
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Dec 2023 14:59:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AYMO/ndU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so5400302f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 14:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1703804383; x=1704409183; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ed7ghNgOSLlEvLsLbXGn8aeWjQgRdS83IthcUsgEUWk=;
        b=AYMO/ndUcXBigeSw0r6CTBWAQkz5XtLqQzebhr4qlrSJSY2s0jzOfN5GKXsb4Y5Sbv
         sIHVkeq/8/yexgQvfIiAj0WvDwJMgIpFXLkk4i6/mwxkplLss6gAKzvwSAwR2PQoH+qL
         7SnlwsHTtFaKIKG13BaYHvJeFJISCuP8ZkM5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703804383; x=1704409183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ed7ghNgOSLlEvLsLbXGn8aeWjQgRdS83IthcUsgEUWk=;
        b=ciZInqElIFx5C0ralKED6klLhQvYKdiYEP4YxfWCcZ8I7aHoTTmwD26PobXtUZkHpN
         4rW5DRIzgO2jVKgKTTbNQb01cpu0oIjTNz/+BYzX6ugzGghshONweauPV81hu+kF+Hoq
         urWuwKiENunzQSYRPcLw/XQlnSQqZ+ro/URo1sQsWn0JnSZfQJM4DTpWi6gkfweSC8pF
         mcmFdVIaD6xh5sRxLlD5SWbSiBnK9/dSXtaboy8jbz0Y28N0IivlkiZbeNFqJvZWzf5q
         yF94OSaRdJRdbrYT64F8qqZOzXHej2PTSOgqgi1e+2ZKw2YPskuUPT3VilvEXil5MpUh
         R7fg==
X-Gm-Message-State: AOJu0YyuS+VFP7EoA0mGeo2cnPhWWWIgmrmhjSndJ07Cuij74ZMROfF8
	n+d6YcmR6jfUlqBrlfCmBfQ7SysHqt1sSSxG3e/cab7xlm8=
X-Google-Smtp-Source: AGHT+IF4dMWRBK9ujoDeKOJTqwDK7JBAuRY+J7lD+KFRTtlT04IbcdF7n9l0HQHkpGqK+OPW5KBiAw==
X-Received: by 2002:a05:6000:2c2:b0:336:c9de:5192 with SMTP id o2-20020a05600002c200b00336c9de5192mr3191697wry.57.1703804382883;
        Thu, 28 Dec 2023 14:59:42 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:87c1:7de2:db24:7cc8])
        by smtp.gmail.com with ESMTPSA id a4-20020adff7c4000000b003366da509ecsm17897509wrq.85.2023.12.28.14.59.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 14:59:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] lib/bb: Add workaround for libgcc issues with python 3.8 and 3.9
Date: Thu, 28 Dec 2023 22:59:40 +0000
Message-Id: <20231228225940.327530-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 22:59:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15715

With python 3.8 and 3.9, we see intermittent errors of:

libgcc_s.so.1 must be installed for pthread_cancel to work
Aborted (core dumped)

which seem related to:

https://stackoverflow.com/questions/64797838/libgcc-s-so-1-must-be-installed-for-pthread-cancel-to-work
https://bugs.ams1.psf.io/issue42888

These tend to occur on debian 11 and ubuntu 20.04.

Workaround this by ensuring libgcc is preloaded in all cases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 3cf02069c5..37ac878f96 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -15,6 +15,13 @@ import sys
 if sys.version_info < (3, 8, 0):
     raise RuntimeError("Sorry, python 3.8.0 or later is required for this version of bitbake")
 
+if sys.version_info < (3, 10, 0):
+    # With python 3.8 and 3.9, we see errors of "libgcc_s.so.1 must be installed for pthread_cancel to work"
+    # https://stackoverflow.com/questions/64797838/libgcc-s-so-1-must-be-installed-for-pthread-cancel-to-work
+    # https://bugs.ams1.psf.io/issue42888
+    # so ensure libgcc_s is loaded early on
+    import ctypes
+    libgcc_s = ctypes.CDLL('libgcc_s.so.1')
 
 class BBHandledException(Exception):
     """
-- 
2.39.2


