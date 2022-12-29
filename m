Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50526C54E76
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.209994.1672333653060041532
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QejJvfrA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id j17so12539130wrr.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nvlhv/xI3RCqmomtv1v37EcS/G6BUEAe5DWKoRCliPo=;
        b=QejJvfrAUJ8Y+1Pmf9S8CSCVzkJstC2dJoM1sIeEgfLXlbWc8NxqZeR6uni9ggy39g
         xkOsyi3sOY1XzJYWsWAxWGGdYjTVt3O/HBPt0zuOwYxX70dgwKDUlqZ753Ruh/1sgXkg
         uXvop3twH/JUbhkUt5aAIFJIGtbdeH5WmQ9io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvlhv/xI3RCqmomtv1v37EcS/G6BUEAe5DWKoRCliPo=;
        b=B0svFS9z7OX22gLWqYj7XY6kdYXiHwss5GUKi0Ez8bkcf+7ARtf2uXztme0JRgEp9k
         DIUP9fvA8NWHotOtf7SUJioMhcpONcOB0HpYd6/6XsT2GV+Etm1EYyOAehRwk8jvWg2M
         zPJTaJ54YbXd5CtofWmqlwJNgoa+I+tGq5NH3XAH6AnF0r7shqPR98w0/3a6JF5EYno9
         gtRarsC180edGx4fHbE/aLhrhofGFzfjc0zxUWNOPkUd1TU4gS98Ejvi/XPu96Ap8wzz
         iAhxoppn7QoHybs/JnjeMnyhQb27/vGjR6fEQg8+0Jd0/0YDvz3zV/KBWVj6jGt9EVQQ
         OFrw==
X-Gm-Message-State: AFqh2kpkw3nERJOe2mVEkYJ1G7Lut7SSTWegqnB+UkUrHMwFDuMWvZCl
	NNNv9+rcwDel1frORBpRTEvundpm3jXK0itr
X-Google-Smtp-Source: AMrXdXtu9PsNV/RIgjV8iAKqomDgLnNkJYXvFlTkeO1XS/UKC8SHVNBVhzW6zSyDTYsxrLgYwOhE/A==
X-Received: by 2002:a5d:4351:0:b0:256:ff7d:2346 with SMTP id u17-20020a5d4351000000b00256ff7d2346mr16345300wrr.51.1672333655947;
        Thu, 29 Dec 2022 09:07:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 09/15] knotty: Avoid looping with tracebacks
Date: Thu, 29 Dec 2022 17:07:22 +0000
Message-Id: <20221229170728.880367-10-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14251

If there are events queued and there is an exception in the main loop
of the UI code, it will print tracebacks on the console indefinitely.
Avoid that by improving the loop exit conditions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index ab1a367be0..c398f591e8 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -631,7 +631,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     termfilter = tf(main, helper, console_handlers, params.options.quiet)
     atexit.register(termfilter.finish)
 
-    while True:
+    while main.shutdown < 2:
         try:
             if (lastprint + printinterval) <= time.time():
                 termfilter.keepAlive(printinterval)
@@ -646,8 +646,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         return_value = 3
                         main.shutdown = 2
                     lastevent = time.time()
-                if main.shutdown > 1:
-                    break
                 if not parseprogress:
                     termfilter.updateFooter()
                 event = eventHandler.waitEvent(0.25)
-- 
2.37.2


