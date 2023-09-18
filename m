Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAC3CD37B0
	for <webhook@archiver.kernel.org>; Mon, 18 Sep 2023 10:37:53 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.48093.1695033471724215987
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 03:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PDbq63mz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-403012f276dso46870545e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695033470; x=1695638270; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UmTWSlqodZaQGQ6fl7D70huup9eLXA9swdWce7Pbg8=;
        b=PDbq63mzztqWi8QVPfd5ruM/Xieu5Othbg/i+R6gXfJqrQtJvcGqTQNt4ckJZExEr4
         UIN9aFGbjsHlTqu0V5nD/iuwPzaKRdanFoTqvWtvPgQIF06NA/khhJ+JEPEbWHYuJ3y8
         N/zs5ab8D3HhDcrvPrD2xN3IOtOD12SvL6pT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033470; x=1695638270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UmTWSlqodZaQGQ6fl7D70huup9eLXA9swdWce7Pbg8=;
        b=DTcwonWcW0FqHDBnne5Ts3cTWSO12b5B9sH6fR1rjdDyHHT7gOw90ZuA/yCVyXXSQJ
         zyx7BSL5qvmj8vADcfqA37tCCEIHjFiBUDTpGGPCblYYpZ3T0DDUt8vgxgsckr4hHCZY
         uls1BpAQgNJCSg0llNL1bgUQAv2h1MAiXsww4RNVmHnzGz5DSmIxrgE3LactWtM4jBZv
         FZjK9qPdd2tdfN32arQDJay6YTbcVydq1sNJmuVWFwM4YaBfysTzVo8qqQhiht1EnFYI
         pTLETY97RiPXJZjIQjd42aHqrIFYXDeUwNVeeaF2Evgevm0VW0QmGncE+Egw/G27tbOX
         N57A==
X-Gm-Message-State: AOJu0Yx6a5zNpGuPweK6T4CHrF8XaaVihEyyfyD2Cs9X4oZ7cELNhIKK
	3DTwedR5KvZ243jT83K1y3wa9iO2EAaUOii/4/4=
X-Google-Smtp-Source: AGHT+IHvn8QGPAM7uF33TNzg/7qCc2pkizeLE/nkqx9lRlVGk8+oepBanNtNF5/0XOVm0ORp4F+fJw==
X-Received: by 2002:a7b:c8c2:0:b0:401:519:d2 with SMTP id f2-20020a7bc8c2000000b00401051900d2mr7226191wml.23.1695033469565;
        Mon, 18 Sep 2023 03:37:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c207:9dee:97a6:8348])
        by smtp.gmail.com with ESMTPSA id s4-20020a05600c044400b003fee567235bsm14848595wmb.1.2023.09.18.03.37.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:37:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Drop unneeded flush calls
Date: Mon, 18 Sep 2023 11:37:48 +0100
Message-Id: <20230918103748.678809-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 10:37:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15079

Since the flush calls have significant effects for bitbake timeout issues,
drop the remaining ones from cooker. These aren't in as critical paths
as the other issues but it makes sense to clean up.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4089d003bb..87aa71bb65 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -172,7 +172,6 @@ class BBCooker:
             self.waitIdle = server.wait_for_idle
 
         bb.debug(1, "BBCooker starting %s" % time.time())
-        sys.stdout.flush()
 
         self.configwatched = {}
         self.parsewatched = {}
@@ -209,13 +208,11 @@ class BBCooker:
         signal.signal(signal.SIGHUP, self.sigterm_exception)
 
         bb.debug(1, "BBCooker startup complete %s" % time.time())
-        sys.stdout.flush()
 
     def init_configdata(self):
         if not hasattr(self, "data"):
             self.initConfigurationData()
             bb.debug(1, "BBCooker parsed base configuration %s" % time.time())
-            sys.stdout.flush()
             self.handlePRServ()
 
     def _baseconfig_set(self, value):
-- 
2.39.2


