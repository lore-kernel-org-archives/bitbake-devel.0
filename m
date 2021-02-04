Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.838.1612400418785843512
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Feb 2021 17:00:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=L9+vFtwv;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id b20so1412090ljo.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Feb 2021 17:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQDZZIuct3yjCsdbR6UEZSiQVEJoI1S2SPzuoSv+Ug0=;
        b=L9+vFtwvYX+LDK90a+GQibYUsWYDN8Deh+HV35M5YuLkxKR+S+O6X/Md4L8YH/nDQV
         RtNVHTYTPb/5y7K7jFYLNDcISwitAAu5OEsyEWXviPW6Q7xdNb58Og7sFhezfWyPMbxF
         NR8K3bpzZlwfuR87LuSQYNJ2Lpff6SV2xh+7IF8SMLJrgOKNQhS/vtBRdsOoQYvWg4zH
         LHlHE0CCMWNOO4KubAOXwmOx3FjsUBDNxAdhGMNxBiJLSs2IF6cs3M8I1lGJvdrOqiIA
         99346A4zTRV9jmXtRkJHpQUbqB9fhgXHwpg+d3sBf1AAXEnWlTzNeZVJ1G5UbnGAafQw
         /acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQDZZIuct3yjCsdbR6UEZSiQVEJoI1S2SPzuoSv+Ug0=;
        b=oyOuUwoNCKFIrbsXDg6DhYm5LFVFvLJa0Uk1oFmBturI2yvc1kFTGP8oPTR/LoeO6h
         2QBXE5kRD/o7Po+ByDKAwXbo0TtQfiKyyyshjmAVKGVEQEjMFdUVsCWmZZZUjTMOD00Y
         oJohilVzQ0+gGO8T+x1nqmJZy4f/+7BtZPm04ZS/0XQM3cRR/0oMXzeuknI7wRl9Lr52
         qYKWRmFQPonPWRNdXVpJfoQwTgHNzuSVgZgwqJzFgxQZKtUSj23Wx4BD4KRSawMwVgfS
         cemQRfgOjtTPol4ZBkCTbe73RUahNwGU/s3KT6KidsEaIVQ4/vqth1PO6CL2UqFmftlB
         RXGQ==
X-Gm-Message-State: AOAM530AJ/pliU9sL6YYEKFKWDBWSyE/wRG45Aipn24RwCXLjRs2FZgx
	X7Oi3V1ZISz/sWHEPw9SkOlhQL+kE1Y=
X-Google-Smtp-Source: ABdhPJx2STDpYqJYjSYgl4gURZqHZu4I28c3V1JQG2Hm31WuRsMdCjDavLTrzH6bMOSrtHFWSPkgcw==
X-Received: by 2002:a2e:9188:: with SMTP id f8mr3123341ljg.462.1612400416411;
        Wed, 03 Feb 2021 17:00:16 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id y4sm401731lfg.55.2021.02.03.17.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 17:00:15 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH v2] event: Prevent bitbake from executing events that don't exist for multiconfig target
Date: Thu,  4 Feb 2021 02:02:31 +0100
Message-Id: <20210204010231.1380-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiconfig is used bitbake might try to run events that don't
exist for specific mc target. In cooker.py we pass
`self.databuilder.mcdata[mc]` data that contains names of events'
handlers per mc target, but fire_class_handlers uses global _handlers
variable that is created during parsing of all the targets.

See [YOCTO #13071] for detailed bug information.

I added a condition to check if the handler exists for target using
__BBHANDLERS variable.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>

--- changed the order of conditions, it should be faster than previous patch, since first condition will give False more often
---
 lib/bb/event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 694b4705..ad119bbb 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -114,7 +114,7 @@ def fire_class_handlers(event, d):
     eid = str(event.__class__)[8:-2]
     evt_hmap = _event_handler_map.get(eid, {})
     for name, handler in list(_handlers.items()):
-        if name in _catchall_handlers or name in evt_hmap:
+        if (name in _catchall_handlers or name in evt_hmap) and name in d.getVar("__BBHANDLERS"):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
-- 
2.30.0

