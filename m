Return-Path: <sgw@bigsur.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E6FC4828F
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 22:22:02 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.3707.1707344521492414545
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Feb 2024 14:22:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bigsur.com header.s=bigsur.com header.b=hfhrvQPf;
 spf=pass (domain: bigsur.com, ip: 209.85.215.173, mailfrom: sgw@bigsur.com)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so802105a12.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Feb 2024 14:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigsur.com; s=bigsur.com; t=1707344520; x=1707949320; darn=lists.openembedded.org;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN2ZVKMV8vODCPWpoBXTUPOUy0x3HlRH9tzRofTQOU0=;
        b=hfhrvQPfr7R8jYv4FgZlpompzI7OimTWyGgGO9OBWHlHm841kZxpMKxlRkKZop3NvN
         poStzr5Edf9AZP9/NqL1rr9fyeKMAerVHzsGWSRIgtZ85LB3sbIfS3RcM1ZvRdkI2zdP
         Jb/nWsEXn5tdmb4cRx1zlSggu+HXL/STITuDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707344520; x=1707949320;
        h=content-transfer-encoding:subject:from:cc:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hN2ZVKMV8vODCPWpoBXTUPOUy0x3HlRH9tzRofTQOU0=;
        b=Fekjkjg1WsvryPqQJ/BNqbr5CJiEQpbqbbI2sHEpyyFO55f6UPAubp2ZbMt3PzUF/u
         poLkxzUR65S8xy1Gf7nY68R9nMb2d3qtaOF0dLM3hNDnhnveRobzR6E3snp5WkoJO4T8
         /j0RG19j8EOnjOlVyGOkJLKdyIruQiK8FKsQ6YSXFheHtHAcho2wccEvnf5iXJRqKi7U
         800rq26Uw6V4xdzcOYy+Xyu514Tm6GDBS9jpaZs7idYAAQwNUgnEXQOsao5FFVlk6WZW
         dSGMLS9fonLc/ANp3ugq7rriiT/eFae9Zq4jLG4O6IDYen1x1iJm9FN1NBRb/l6GLHQE
         37Gg==
X-Gm-Message-State: AOJu0YzMJsuCeMpCq0IvWUw3Ox7qMZdbYA2eXxRsmFEKwtyy6PX7FoHY
	f8GunZtGXSzoAxJdTlF8RWhKXEQa0uNAD1Uxpj4m+nyF6LNgYnrNOShktaPkGYn3KYNuR0zuX5M
	=
X-Google-Smtp-Source: AGHT+IEAb3cpW4u4BaNjVKpx431WA3jYdOm6bq/NEGhk/2h/D/AcOulIeIzAW9cfBugo/1+zB7iHUg==
X-Received: by 2002:a05:6a20:9f8b:b0:19c:7b2b:6cbf with SMTP id mm11-20020a056a209f8b00b0019c7b2b6cbfmr6746912pzb.47.1707344520038;
        Wed, 07 Feb 2024 14:22:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5jfjJ6cVfgVDsmQNWGBhTCwLoTKlRN3LIp3w9OboJAq1etd40horEnXURmFn8fFQ3D2+gNE1xLw2ZJSg0sXnCex1blxVjn/7NQk+J6WKA/sm696+VcWbyATLwNvHXi34mgg==
Received: from [192.168.134.2] ([69.9.134.55])
        by smtp.gmail.com with ESMTPSA id k4-20020a63ba04000000b005c1ce3c960bsm1977540pgf.50.2024.02.07.14.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 14:21:59 -0800 (PST)
Message-ID: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com>
Date: Wed, 7 Feb 2024 14:21:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Language: en-US
Cc: randy.macleod@windriver.com
From: Saul Wold <sgw@bigsur.com>
Subject: Underscore vs Dash in bbclass filenames
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Feb 2024 22:22:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15836


I was looking into Bug 14235 [0] and had initial patch based on Randy's 
original recommendation of using dash (-) which was a basic 
python/tinfoil script to check existing bbclasses in the BBPATH.

It was pointed out that the bbclass name is prepended to exported 
function and that would cause problems for SHELL functions as dash is 
not allowed in the shell function name.

On further investigation this of course becomes a more nuanced problem, 
so I considered an alternative approach for setting up a warning in 
bitbake itself.  There is currently an error check in bitbake's ast.py 
ExportFuncsNode() code. The code below would warnonce() for other 
bbclasses that have a dash and are not in a NO_WARN_BBCLASSES list.

At some point in the future this warning can be changed to an error.
I also noticed that the Regular Expressions defined in ast.py could be 
tightened up slightly, there are a couple that use \s (general string) 
vs \w which limits some special symbols, in order to limit dashes from 
appearing in function names in bbclasses.

This is not for the current Scarthgap release.

diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py 
b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index cd1c998f8f8..faf6e9ede63 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -116,6 +116,9 @@ def handle(fn, d, include, baseconfig=False):
      init(d)

      if ext == ".bbclass":
+        nowarn_bbclass_list = d.getVar('NOWARN_DASH_BBCLASSES')
+        if '-' in root and root not in nowarn_bbclass_list:
+            bb.warnonce("%s contains dash ('-') in name which is not 
safe" % base_name)
          __classname__ = root
          __inherit_cache = d.getVar('__inherit_cache', False) or []
          if not fn in __inherit_cache:


Thoughts from the bitbake team on this approach?


[0] https://bugzilla.yoctoproject.org/show_bug.cgi?id=14235

Sau!


