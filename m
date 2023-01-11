Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2294C67871
	for <webhook@archiver.kernel.org>; Wed, 11 Jan 2023 17:51:11 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.31181.1673459462210592362
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Jan 2023 09:51:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZjUihHPY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id d17so15864679wrs.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wSjAxRAQcksFAPSyh03+o7qUHlHIZkXm7wrlkoYL4yE=;
        b=ZjUihHPY6m/6l66f7ukWfmzDI5E03cnRWVnRLqGVbOyqK9jQHgoNaSZGJq9hpgthcU
         Yd+BLOITAUHAPPy34n4ytKRDCoR4PMNYVOL8XalhLuksOY3nCNnfBVcY+GgKRYlYKXBX
         yGVJdPw09TpYnXh3yGb1fSpYpHvnIJWVvBZ8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSjAxRAQcksFAPSyh03+o7qUHlHIZkXm7wrlkoYL4yE=;
        b=sY4ZxMKEfTqR+4114wILeKoT6PneQpxOhPuD6EiAL6XuAxAYfMVnNR+mXeOEN4atge
         NMf029ja9jv9owpJHGADAecbRk5cw8C6gVKd1EFvIjoZLC+lOtgtxoHp85HkCKzNMsXZ
         HHrwMoesTlf0y54PqQ+0gEtzPj4Yz1k9l4I60bzszF1Ll7Nw5UIi+u0fw7l00nBA7kWZ
         o0GrpTbJwd6kzyqVF0NfW6tgFuyugjHesrfG5IaqpidTZlBHw0pKT+Zh+S5X7Hk2BWpE
         1wmo4JVkueIKtaGXQ42NV6wg2o/to2ixdz6GVJJjdEaLPnlgbj2Shbjz9sKpki07bskN
         aHOg==
X-Gm-Message-State: AFqh2krcp9IU3P6oLrSrI7R5UOO+leQUi5rYjW95lsCub0TVPud8634s
	/34pwCregDBYdymTLs5aUZgwC6sEvkJkOAtX
X-Google-Smtp-Source: AMrXdXtXC/hEetvs1zt5WcLZyi91VWB9UTXi0nE07A5hdtBdokfxjXKJW6tyoqwFepOqYN2YYJl+4g==
X-Received: by 2002:a5d:490c:0:b0:2bd:bf72:76f2 with SMTP id x12-20020a5d490c000000b002bdbf7276f2mr3619589wrq.14.1673459460125;
        Wed, 11 Jan 2023 09:51:00 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a11f:4d56:748b:c178])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003d9f14e9085sm11689624wms.17.2023.01.11.09.50.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:50:59 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/4] tinfoil: Don't wait for events indefinitely
Date: Wed, 11 Jan 2023 17:50:55 +0000
Message-Id: <20230111175058.1526619-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 17:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14301

If for some reason the bitbake server dies, we shouldn't loop indefinitely
waiting for events within tinfoil. Add a ping test and exit if things
have somehow failed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tinfoil.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 8978bb5261..91fbf1b13e 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -10,6 +10,7 @@
 import logging
 import os
 import sys
+import time
 import atexit
 import re
 from collections import OrderedDict, defaultdict
@@ -729,6 +730,7 @@ class Tinfoil:
 
         ret = self.run_command('buildTargets', targets, task)
         if handle_events:
+            lastevent = time.time()
             result = False
             # Borrowed from knotty, instead somewhat hackily we use the helper
             # as the object to store "shutdown" on
@@ -741,6 +743,7 @@ class Tinfoil:
                     try:
                         event = self.wait_event(0.25)
                         if event:
+                            lastevent = time.time()
                             if event_callback and event_callback(event):
                                 continue
                             if helper.eventHandler(event):
@@ -785,10 +788,13 @@ class Tinfoil:
                                 self.logger.error(str(event))
                                 result = False
                                 break
-
                         elif helper.shutdown > 1:
                             break
                         termfilter.updateFooter()
+                        if time.time() > (lastevent + (3*60)):
+                            if not self.run_command('ping', handle_events=False):
+                                print("\nUnable to ping server and no events, closing down...\n")
+                                return False
                     except KeyboardInterrupt:
                         termfilter.clearFooter()
                         if helper.shutdown == 1:
-- 
2.37.2


