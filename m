Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09A9D16265
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 13:35:16 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.55005.1728912910250395721
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Oct 2024 06:35:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I8UkjMRu;
 spf=pass (domain: gmail.com, ip: 209.85.218.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99c0beaaa2so523522866b.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728912908; x=1729517708; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UWqXmCvos3djQcSqUbSquTtMYADK0Zu4mruRU3Ec7c=;
        b=I8UkjMRuzsarW0FywvPwXOvsY7KsTMxpE6avB6r8L9eZu15Tk7QzBXn7beszO4Glnn
         X0mw+ZTLuyxkKGpKQLYXhuAuFHSqtxTEV5JaOfsG7UOrN4fQZWIZj9xd7GrZkhmc4o90
         DtblmXJ2P1F1qP9F0XgyUmxgQJwxRsYqh0KcYlo5BukzygI9cSNSUjG6K4RM7WfNQqu+
         P6FApCvwrAOOCmxVjjt+UrGu4fTc1UTt4oGAQaGjli57fvyzNiMyKcHj6ha6A8R9lR6P
         xXZpCNnZRm6D/DSIWDvUNE436OZI0dn1QiFrsPyFbpL4eCPS47/dooE47aD839ckNBn6
         tW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728912908; x=1729517708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UWqXmCvos3djQcSqUbSquTtMYADK0Zu4mruRU3Ec7c=;
        b=FyhyKYpd//qkNEvRWoVgrei9pdRKdb3Pm8FpOzMzNhFnvom9dQnnY6/G7qdKMOFcoq
         VyjoMu2JBM2X9mxy++4wOm1uzcHiff4yItfnXA4gliUUcHDm2jB/zBfJ5eYae1feOx0B
         uOlZKXqxdUnCoklBzl0TXwWoBT/mO6Z6SkLMVFw0Uhy3kzWZrrx7DMwLRb0Y+ryMSsyO
         bK2YEbBKa5mLCj89xVjgqxvUU+F7wnvYBL0ioCVORa2GLrWhAe4/hnfuqc1L3tMdfYGg
         Mxqd6WgDuz1fo7zcjAs7yR5Bl5d0+UY3yhLncjzc3xjdQhdRgecZBBg2loVEdg/ZZSjP
         YdOQ==
X-Gm-Message-State: AOJu0Yz6zqUFrYfqIR2sORH7h8zdcxZmghzJSh/7KX1xAZSBY4Pf/L7S
	KlLuc+tENCj3/L8tDe7TVcKsWwuwFGuHcKLnBNOqpnx8gW01dBM5ug36HQ==
X-Google-Smtp-Source: AGHT+IEm1MfN6yBnWN1ebGpH0MY91BrIcYWCycPE2zTJk9ZD72Rl2qe9CtVmex4zbfqXW1W0JSzY+Q==
X-Received: by 2002:a17:907:3ea8:b0:a99:fd32:11dc with SMTP id a640c23a62f3a-a99fd321240mr407199766b.24.1728912908272;
        Mon, 14 Oct 2024 06:35:08 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a009cceedsm239622866b.61.2024.10.14.06.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:35:07 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	christophe.priouzeau@st.com,
	paul@pbarker.dev
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH] fetch2/wget: set User-Agent to 'bitbake/version' in checkstatus()
Date: Mon, 14 Oct 2024 15:35:04 +0200
Message-Id: <20241014133504.2390211-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Oct 2024 13:35:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16680

From: Alexander Kanavin <alex@linutronix.de>

This eliminates the last usage of 'fake mozilla' in bitbake, and
it's then truthful everywhere about presenting itself, or wget
(when that is used).

I understand this will make people nervous so I want to provide
an extended decription.

1. How was this tested?

- bitbake-selftest -k FetchCheckStatusTest
(tests a few hardcoded URIs, all passed)

- bitbake -k -c checkuri world
(runs checkstatus() over all recipes in oe-core, and all passed again -
this hopefully goes a long way to reassure everyone that hosts around
the world and various CDNs typically do not have a problem with user-agent
strings they haven't seen before or bitbake user-agent specifically)

2. What about that removed cloudflare comment?

I digged into git history, and I think it is not fully accurate. First, 'fake
mozilla' agent is used only for checkstatus() - in actual fetching with wget
it is not. And that has not been a problem for anyone.

Second, here's how the comment occured. Usage of 'fake mozilla' was introduced here:
https://git.yoctoproject.org/poky/commit/?h=master&id=ab26fdae9e5ae56bb84196698d3fa4fd568fe903

At that point it did not have to be specifically 'mozilla', the commit message
indicates that any User-Agent would have been ok. Mozilla was simply copied
from upstream version check for convenience.

Later on, the string was updated to a more recent Mozilla:
https://git.yoctoproject.org/poky/commit/?h=master&id=9f123238261a68e37cec634782e9320633cac5d4

The claim in the added comment become something else: that User-Agent *must* a browser,
without evidence or tests. Even though it demonstrably doesn't have to be - wget is ok.

3. What if someone has a server that is ok with wget agent, but not ok with bitbake agent?

Please see point one. It's not impossible but I think it's highly unlikely. I do think
we should rather tell servers the truth, and learn where the actual issues are. Then
we can consider options - whether that would be pretending to be wget, or allowing user-agent
to be configured. We should also add such servers to bitbake-selftest so we know what they
are.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/wget.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 493a5b62ee2..7856d10fa4b 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -53,11 +53,6 @@ class WgetProgressHandler(bb.progress.LineFilterProgressHandler):
 class Wget(FetchMethod):
     """Class to fetch urls via 'wget'"""
 
-    # CDNs like CloudFlare may do a 'browser integrity test' which can fail
-    # with the standard wget/urllib User-Agent, so pretend to be a modern
-    # browser.
-    user_agent = "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gecko/20100101 Firefox/84.0"
-
     def check_certs(self, d):
         """
         Should certificates be checked?
@@ -356,7 +351,7 @@ class Wget(FetchMethod):
                 # Some servers (FusionForge, as used on Alioth) require that the
                 # optional Accept header is set.
                 r.add_header("Accept", "*/*")
-                r.add_header("User-Agent", self.user_agent)
+                r.add_header("User-Agent", "bitbake/{}".format(bb.__version__))
                 def add_basic_auth(login_str, request):
                     '''Adds Basic auth to http request, pass in login:password as string'''
                     import base64
-- 
2.39.5


