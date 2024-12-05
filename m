Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9ABE77178
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 17:14:04 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.17026.1733418836805716922
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 09:13:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Var8SG/0;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a1639637so12606915e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418835; x=1734023635; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rK9y802Yall2lViE6YKaILaNPI/JW8MHA4E8hGsJbcw=;
        b=Var8SG/08m0cfj16kPeV/9KlK35XwQ9oQ+KVf6fQ8UiOwSOdphZkAU9VeXQ5Mpv9jO
         XhsKvl76APL29UaYYYXldT0BQQRrApiU30ArIEu7qyMOaoNKu9c2wwLi/iuhdhjre16b
         nikZg56TSm42jMj8Jq0UHCS0x1eF8mLEbpJ6CMOcd9VplVuOMPNw9qMrKA+UTn4hCLL+
         blRkSkyH8cnzJQ5xGnYBL3wLLUEtVeEJCja9n4ZGwQyMFSRYGPJ1XXKSjJIWS/2PgVD1
         wnGzULVgwXuY46QvvUOLdPNbtGPpJeJgTe0J52hrt+yV0X6SPIm3jDXyLTQkMzRVprkX
         gGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418835; x=1734023635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rK9y802Yall2lViE6YKaILaNPI/JW8MHA4E8hGsJbcw=;
        b=KzjY3/rJMktcQ3dECYpkwD1kZBkZR33Lc5Kr7vMufWQs1DZkPHvY/q83CG7DvJVC0U
         YWvdtnGGBu67zwtIkiSGg3fyi4WwaTENuux8D/Ay3LZR0Rv5eJPmDQcVUNyC6w3N1GPb
         ngz/kucDkN5ChlVQfkLhQQmZdWhf5U3Aks/47vr3Kk+zHj8/u0EYGRC6c3muGmW5NZhz
         dSSEwhMe5H24zoDGgwFoRiH9gqa0lnejrkML589Dw+qHbdpzV+9gLAIJjf1lvwcZOc2M
         zZ/fBlC37nhoag4F1pUDPau+TeZn/GSf4D+XileGXvfJN7fFT/BF4o9OYrW/KGrqa+Hz
         wvVQ==
X-Gm-Message-State: AOJu0Yw5VWvXLEWoyJGtuB4GKsNf1LFy4Ed4ezgwbYZrWMZM5HTi1gaq
	YCUxUayDgxYYi4aF9Frtbm9ITDBqo7QgK6VeKT50xwz7mMCE1OeQd2v1oA==
X-Gm-Gg: ASbGncuibi8V8s1AfmeJSUZUXWDNV6LpeV/r5qLlEotW3YUqI77jPkSlOub1hKGgGCv
	D8HyNT1BdVkWc1yVr0q1cPVlpx+ssyDPPFm60gN9465vtaIlFQXAwUZaw49wDz8lisANnCiv+EM
	B8EcGF8OtWQGd3iDNncPPz8WVClT0NOC31QkaWQ9xjUE7sDiUxmoC2lDUWWivtNWmIlerEGGyHf
	uxlr1rhq3RGFMuwl2crh3udSR9H9BQtVu4CuBgbLjnLl13HhDDMjHR4Hm9uhFX8lC3l86oJBPKl
	wo4C5+CV/3I=
X-Google-Smtp-Source: AGHT+IHeBcEjKB0y0kOHfQBLIHqntJ1G6butxwKbCh1jdEHMR2/xVoNQK01zM6n9QE6WRiYKkVvzvg==
X-Received: by 2002:a05:600c:35d5:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-434dded6649mr624925e9.25.1733418834979;
        Thu, 05 Dec 2024 09:13:54 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113508sm30238775e9.35.2024.12.05.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:54 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v5 1/3] parse/ConfHandler: allow / in variable flags
Date: Thu,  5 Dec 2024 18:13:37 +0100
Message-Id: <20241205171339.4051793-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 17:14:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16884

From: Alexander Kanavin <alex@linutronix.de>

This is beneficial for config fragments, as their names
are specified via flags, and those names can include slashes:

BB_CONF_FRAGMENT_SUMMARY[init/systemd] = "This fragment enables systemd as an init manager"

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 7826dee7d3d..27665443dd4 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
     (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
-    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]*)\])?
+    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@/]*)\])?
 
     \s* (
         (?P<colon>:=) |
-- 
2.39.5


