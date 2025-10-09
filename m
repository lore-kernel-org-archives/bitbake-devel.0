Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53928CCD187
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 16:07:48 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.4344.1760026061070849515
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 09:07:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=pM0vJ6wT;
 spf=pass (domain: smile.fr, ip: 209.85.208.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso2057906a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760026059; x=1760630859; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPBHjGw0oYp1JPBBChKE5Src7Bg0SO29NsZUF0pdOxc=;
        b=pM0vJ6wT5gZ6wT4DFUPj/n5jB2OGdZbxN+imqUUTH44MvwYA+ZXTCI8vpQhH68BR6S
         NuUdE/gieP853GRMWypNhEXgzQZEV0HB2eWbjGq2QXAyHl9E+h5QtfDERYBptr3Jry9z
         IgsJGf2S1vtG1KU5rbuL+KnjKwDKV0fUAYOWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026059; x=1760630859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPBHjGw0oYp1JPBBChKE5Src7Bg0SO29NsZUF0pdOxc=;
        b=QArZHK2eF2xodEz3KetvPbZiETesYJgTVJsDdq1EgAPiOz3a87WGkQZdiizx8IZtdl
         NvoX9mThTK1BMzQ3bHyzOey6y8AToRjAWWbmeL9xTBzpSR/+qMr1Hp8IlGac7h+bn207
         /sK5ketM8qG9/iZN2lzEN70KgIzFMeJK3FKlzqq1eeu0SXD1KrCQm4Lay1ohaFntRk/q
         j7eVWOpg1++qbFGfIZpLSMBk5Ph7bOb510Z4U6BFFptgpuqiQqKLyUeU1t0OuORNwovu
         0JtjvvlSA8rg5giDJqRgyrnfx9ZL8jD6uw4ZLCMoiIbRhWCqGvwWFXnhMI5ggeyVtu60
         f0yQ==
X-Gm-Message-State: AOJu0Yz8n4THib8Xk7CP51nuYa1uHCT0zas9Wf7cuFyxtbVhci6Uf34M
	QNlwSrNUN6Ex3RAqT2cDvZnsl77x6XsQeUWvkbE6ogb9QZPQOAMi2p1ANGAbF5MFMhOmENtv/Ou
	nkgy+vsE=
X-Gm-Gg: ASbGnctzPg49ZPzcmAGQtTTPVZZayzDHkw9VWM1tSH0TZEZARORc+powfac8ZrAmxVv
	nO9N+ueP/RJOHWvI80gyNmmFT9x8YjW0Tfk2kHy4qAoaGuCiajkr0sF5B+Sj2TDlyGciBjZdvfB
	OGfOlwktAW5GZhOARmZm6TgBr0wgrw2KjOZmZxbFsG4GEdjpfKkzO/wy5Yco0G7pbESWNvm9tlC
	YfweykSDN5oQJx4E7JXZtS5m2rW1N2k+W7Dpsq2jltutepuXFkWB5bqD3Dr3hK157X+qWIAa6AE
	id9D0PDkUdrE2Z4tjAnZWvf+4LF8LjgW7xF0EB73Gn6QU6H7eO032g3OlB6keQLdERFGNunKA95
	wFwKMNfCevtZjkDlru5XYn2tpxHECK7hbh6ceM9pvFpgjYtwExq88M5sz06dp383H2yUlpU0gQF
	04Oai9bJeS1aJwZB7qu5uO/VTDFYVVt3I9TK3zFEHeMGgY8C8JM1mgP33TV2w93A==
X-Google-Smtp-Source: AGHT+IFlbZ569lEFaU8FfRe7SYDYNeYA59iA8XwfTAKT3gMY3i2tzQKGXfL/8rFA8dGXz4jnj2SMSg==
X-Received: by 2002:a17:907:9445:b0:b3e:5f20:889f with SMTP id a640c23a62f3a-b50aa79f502mr912975466b.26.1760026059063;
        Thu, 09 Oct 2025 09:07:39 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (2a01cb001331aa00007c0d5248a1aaa1.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:7c:d52:48a1:aaa1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cac037sm7616366b.12.2025.10.09.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:07:38 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH] ast: Better variable history for builtin fragments
Date: Thu,  9 Oct 2025 18:07:17 +0200
Message-Id: <20251009160717.2527351-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 16:07:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18151

From: Yoann Congal <yoann.congal@smile.fr>

As of now, the variable history for builtin fragments looks like this
(edited for clarity):
   $ bitbake-getvar MACHINE
  #
  # $MACHINE [2 operations]
  #   set ast.py:368 [check_and_set_builtin_fragment]
  #     "qemux86-64"
  # pre-expansion value:
  #   "qemux86-64"
  MACHINE="qemux86-64"
User can't know where MACHINE was set, this is bad.

This patch tries to reconstruct a MACHINE history from OE_FRAGMENTS
history.
With this patch, history looks like this (for a simple case):
   $ bitbake-getvar MACHINE
  NOTE: Starting bitbake server...
  #
  # $MACHINE [2 operations]
  #   set .../auto.conf:2
  #     "qemux86-64 (OE_FRAGMENTS contains "machine/qemux86-64")"
  # pre-expansion value:
  #   "qemux86-64"
  MACHINE="qemux86-64"
The path where the "machine/qemux86-64" fragment was added to
OE_FRAGMENTS is displayed, this is definitely better.

But, (and this is why this patch is a RFC), on a complex case : adding
a fragment, another, then the first one again, history looks like this:
   $ bitbake-getvar MACHINE
  NOTE: Starting bitbake server...
  #
  # $MACHINE [4 operations]
  #   set .../auto.conf:4     # <<<<=== This line number is wrong
  #     "qemux86-64 (OE_FRAGMENTS contains "machine/qemux86-64")"
  #   set .../auto.conf:3
  #     "test (OE_FRAGMENTS contains "machine/test")"
  #   set .../auto.conf:4
  #     "qemux86-64 (OE_FRAGMENTS contains "machine/qemux86-64")"
  # pre-expansion value:
  #   "qemux86-64"
  MACHINE="qemux86-64"
I don't know how to match OE_FRAGMENTS history with MACHINE history in
this case. When MACHINE is set to "qemux86-64", how does the code can
know whether it is the first instance or the second? (My patch take the
last one)

Also, a fragment can be removed from OE_FRAGMENTS with:
OE_FRAGMENTS:remove = "machine/test"
In this case, as of now, that does not generate a line in MACHINE
variable history. I not entirely sure this is a problem or not.

Related to [YOCTO #15939]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/parse/ast.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index cb06e8917..27adbd860 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -364,8 +364,16 @@ class AddFragmentsNode(AstNode):
         def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
             prefix, value = fragment.split('/', 1)
             if prefix in builtin_fragments.keys():
+                fragment_history = data.varhistory.variable(self.fragments_variable)
+                loginfo={}
+                for fh in fragment_history[::-1]:
+                    if fh['op'] in ("set", "append") and fragment in fh["detail"]:
+                        loginfo["file"]   = fh["file"]
+                        loginfo["line"]   = fh["line"]
+                        loginfo["detail"] = f"{value} ({self.fragments_variable} contains \"{fragment}\")"
+                        break
                 # parsing=True since we want to emulate X=Y and allow X:override=Z to continue to exist
-                data.setVar(builtin_fragments[prefix], value, parsing=True)
+                data.setVar(builtin_fragments[prefix], value, parsing=True, **loginfo)
                 return True
             return False
 

