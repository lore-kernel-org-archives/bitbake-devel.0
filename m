Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF9CAC5BE
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:56:45 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.52702.1759150600613969950
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:56:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GCad9kQw;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-634cdb5ed4bso4910945a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150599; x=1759755399; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+TZO3Ots/Smbk4S3CECLp+WN8bxQf4cC8blJNg/c2A=;
        b=GCad9kQwywZNtlN+5zlKG8sahY3WqvilhekeQqmJvVpjeaNiUKmNW+AmESicfpc2+q
         BqkOKBed7hDsDBOsBjLPCGppOoG7dMdaggzylZMehrByGDgAzxmj/KzHHXZIbRv8ZKC6
         B7rPbv3Ixd+fKS3NvCnbMw+3B3jjCFnPSJ0JXHWivQKp9uMuL/7M6xlfHl/iTFVyYp4I
         KtmIna7gR6pVnPdKsZ70y+ue9enTz0UixXxZuGTLxCLgf4DrpHfXc8P2oU6MLdexsMB2
         MWHDkC6Ao4tq3usIOttPkuiwMpQdUBRQpeghQd8ecFn1kYDQnockiEBN+O8tV6MGTfV5
         Inmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150599; x=1759755399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+TZO3Ots/Smbk4S3CECLp+WN8bxQf4cC8blJNg/c2A=;
        b=m/okQMURra9S9l/c5iM0rY4gkPtnX7Tdm6NC+H7qNc8fHvLFHABXZ094V1MvrE6gGv
         s3E+0xPPWIhMC3un+K/gkR/htTspAtV9aY6T1xBIe2X0/FmULTYrtpiZjnY5XprAHxpb
         ym3jbRuedQQcWSgfMf/fFAUIUk9ftua3LjEnkob+lFojhWduvoV4dBqeGpgtV8lLl4H5
         XewOuHKWitTPF609fRTGAi9q+pBU0oSxylB+9SNOMS87k2z3TK0jOHG56LaXt5BNiHMk
         PiKZYFC5p24sgmDFcctdAZ9C39ZFaeYC5TLuqxsagABKZdjaFkAz26PFhmllHlPAkyqi
         dPfA==
X-Gm-Message-State: AOJu0Yxld1xBAfzD0T8Yk+jm0TJqK0MghG+lO0M9kIsu+zzpcUskg15E
	CeUaHiqQg3Vd5aDzggDpTWDfzauDA75pjmxN66HMq4wMNPalm49zpqVmOMuJUg==
X-Gm-Gg: ASbGncsMoJbGh39MRpHNI+hGnGbHP/vW3+L/LG6yFyfr6uBrbplU7GfhEAoES8cya5n
	DYon5YUdms9Ou9qqVGL7osN5g6QSxZYNXbYls6fgK8/HrH6rmwGjisczz9a/K0T7cy2lAoCFtms
	iBJtI0CbFL70tWfdPxJGhWzVqQlu6zzcl5L3jaMYR51UD/MstymUJ/4fKddVtx/NsV54EqNGE7R
	6F3af8Bk1tWRJczb8mV24c2ZxZhU1060D7QHQARJ/O4rhONXssH1fkDE5DTKqdhz9RmT3IDYMr2
	vFzvdPnhlXJWDmmpGoqV61+VKsKbYouDJ0TfiMgHxJ0ZcZ8cfFDT5shOx0xMAQ1oy2IyQr+PT08
	LAX7+TEzj1AzX1QGFz24psEQTmeVhKgt8cXS4OwQaB9FwQCTl/sVYt65eNYN9fnBIAuOj/Wbs6z
	/QOTcoRLvgUv3poBwQuyd5Ge3glG/bO/Rkg32QoYjkPcfPQ/C1jgHnXbouW0F4pDcot7Na
X-Google-Smtp-Source: AGHT+IEDHmtnXQCFIQ1auUg0G/JN1CnSZoCWoWjsQgzcZqFPaRSsk05EJbhjoyETO3Vwio+ItQ++RA==
X-Received: by 2002:aa7:d603:0:b0:632:67ba:f9af with SMTP id 4fb4d7f45d1cf-6349fa08f1amr11665626a12.12.1759150598881;
        Mon, 29 Sep 2025 05:56:38 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634b46dca59sm6575915a12.8.2025.09.29.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:56:38 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 10/10] bitbake-setup: improve robustness of loading/writing settings
Date: Mon, 29 Sep 2025 14:56:16 +0200
Message-Id: <20250929125616.1751116-10-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929125616.1751116-1-alex.kanavin@gmail.com>
References: <20250929125616.1751116-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:56:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18109

From: Alexander Kanavin <alex@linutronix.de>

Particularly:

- ensure global settings command line argument is always expanded to
full path
- ensure any errors that happen when loading settings are reported
at that point, otherwise we get an empty dictionary and cryptic
key errors later

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 8ceacada9..1fbb65494 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -635,11 +635,11 @@ def load_settings(top_dir, non_interactive):
     settings_path = default_settings_path(top_dir)
     settings = configparser.ConfigParser()
     print('Loading settings from\n    {}\n'.format(settings_path))
-    settings.read([settings_path])
+    settings.read_file(open(settings_path))
     return settings
 
 def global_settings_path(args):
-    return args.global_settings if args.global_settings else os.path.join(os.path.expanduser('~'), '.config', 'bitbake-setup', 'config')
+    return os.path.abspath(args.global_settings) if args.global_settings else os.path.join(os.path.expanduser('~'), '.config', 'bitbake-setup', 'config')
 
 def write_global_settings(settings_path, force_replace, non_interactive=True):
     if not os.path.exists(settings_path) or force_replace:
@@ -673,7 +673,7 @@ def load_global_settings(settings_path, non_interactive):
 
     settings = configparser.ConfigParser()
     print('Loading global settings from\n    {}\n'.format(settings_path))
-    settings.read([settings_path])
+    settings.read_file(open(settings_path))
     return settings
 
 def change_settings(top_dir, new_settings):
-- 
2.39.5


