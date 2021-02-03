Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.1685.1612381653093184001
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Feb 2021 11:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=OD6L/IKO;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id u25so958636lfc.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Feb 2021 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3iEJKKa/mEOvQZYZ0FYuc5XJzBAiQW3CITOdUw88e0=;
        b=OD6L/IKOyuX6tegLmI/Q1P5OdBxsfoaZewoEPByS02Zai8mrTRTYblUZ57k8l4oMjz
         e9EtqTAmwhuZJDT3gAmxrblBfO9/T0pUXyn1sY+lLasXSQyWYIFDUOpELMFZpONLtX0L
         AjG25G5QNclaErxP8RWrUg0E5cyTnHb5I8GWrZIGK8dot/t+8kA/T0GZ+qzWfWfzJsrT
         EnIJwmE4zSM9WQXPbbH/rq4tDxvp4eeHityMb2SpTt2vJJJx4j0/aV34vwaTaXYukFbq
         zatdlvvu/88a8bWWMAfzkTGVAk0LmyIfUCMw1zG1csAgltPa0YITu9DHu3V+B/l7pVbs
         SnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3iEJKKa/mEOvQZYZ0FYuc5XJzBAiQW3CITOdUw88e0=;
        b=VMVJjidBk1ns/7fDTnXwqzWN0sB91pn//aHnSI05yXTK0lJpKMha74u6tAmoGmZzA8
         Zc2c1/i3DXoI8erPOEiqzK0CCVwhJaX/mYUVKIaayBhiCdNvS5NqCNgZzS+/atnYnAvm
         vocE9mrcBY4i3z6eeJWkhpjgbVoaBa8LuXF5KAE/MUIpFKt8w5e0Vo3oqG0eTPOMux98
         PuXEGkIRAt7OOTSJkGwaTmgFRlGf+bOHhTfKx6tVbEO70Cn7Wzd6/keoOrM7+DN5wIsi
         ZzJibT4/y3ZJPRir7SvTUzlW0gjZsck5dIZZbfdYvrh8gx3AvT5HtC3NBG/ufkP0vBbd
         wsew==
X-Gm-Message-State: AOAM532NIFBMU+NplW2fdUjfWfnKX8xnn+d+qu7evAlZsBjNZu+keNf8
	V0D4W72I+r+JPOih4oxA++vdCHfHHLI=
X-Google-Smtp-Source: ABdhPJzneTxWnRBN0WWRJh9dgPU7dYvLrrxZy65JeS6I6m4mtvT0i8Elp5cq41JQ/edH6s05kqrVzA==
X-Received: by 2002:a19:6c3:: with SMTP id 186mr2546007lfg.500.1612381650704;
        Wed, 03 Feb 2021 11:47:30 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id 24sm333684lfy.32.2021.02.03.11.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 11:47:29 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH] event: Prevent bitbake from executing events that don't exist for multiconfig target
Date: Wed,  3 Feb 2021 20:49:54 +0100
Message-Id: <20210203194954.13029-1-tomasz.dziendzielski@gmail.com>
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
---
 lib/bb/event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 694b4705..bfc1e67c 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -114,7 +114,7 @@ def fire_class_handlers(event, d):
     eid = str(event.__class__)[8:-2]
     evt_hmap = _event_handler_map.get(eid, {})
     for name, handler in list(_handlers.items()):
-        if name in _catchall_handlers or name in evt_hmap:
+        if name in d.getVar("__BBHANDLERS") and (name in _catchall_handlers or name in evt_hmap):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
-- 
2.30.0

