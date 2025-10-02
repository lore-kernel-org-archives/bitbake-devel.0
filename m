Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A49CCD183
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 10:09:45 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.4861.1759399777076443389
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 03:09:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PbGXPx/Z;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f0308469a4so419230f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399775; x=1760004575; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/RyxCrvr2O92jjo//uHD7mUneky5UT1SYmXL79yb4E=;
        b=PbGXPx/Z7xOQopZ4tenfr+cBgqWdvqaJNW1Fp2SLowZ+eq5tHGTSDlh+kjy1dOXJGa
         h6l95eH3wODQJ+pSO5Pr3vedLPfiYYbBzX498H03WcbQUDlkmeHiq9KCMjkQ55Q7avJB
         PeB3ktI0XU2x3dHnZizN44CWURWSxYiNam9Y0q8y5NTvJARLh9xI4DF1MS1FEl/UX0+b
         YYgkfrqClYBvtBvw9GFtW46d/LBIepku6FouKKyeCrEIDbY+QIVTwyrXIs5rv59/h33r
         5gxhDE6NzXKbOeQFMHfmRjyzbzRfHMMkyZ0U0VI8mMln+OCXMXMndlVQ6a8XkZQ95tSx
         U29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399775; x=1760004575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/RyxCrvr2O92jjo//uHD7mUneky5UT1SYmXL79yb4E=;
        b=cvoPXS/e3Oa+FdUzI9PdD+RIC4pAdMxGrBgjhnTKw9nmhCCVO2U0RuTuGqUGLqznES
         q69d4dfD6S9oRql4tBJg5fxI26+djk6LtPmuJ0Igy3CU/2DGA+CEpBfGxXgkJo5d8hgO
         +yQClNSAMl2wItL01YA5LMgyluKXinBz2JqCTFjW2fhSHJ3r7p/EWM6PCxgcxnpl/4QU
         NXm70pg+JEAkdrH8YXsMK7N0fITylEDMXM6f5HCFqNmJbfk9nkkoOPQpgMoZTzJekiH6
         1fCg8/lmEdxOukEtztpbZ7EPddGUeTgET+GtNVuvtAgy3QdDAI2f48kJPqBPs9pwItxf
         9bYQ==
X-Gm-Message-State: AOJu0Yyy2sLNVyWU6aLRu3dZrM5XmWLEx6C/4FjlhIPWXf7T4HVsLVJm
	4pS8sdGTmsNbBWjc5HIHc475tnq0mzpiqM68U3zcesJ4o0c9X531oL1k/h+Qqw==
X-Gm-Gg: ASbGncsi+AmVmvToLnMIKWFeYGtl3JlKkW0GJNqK8Rzgv9uWIku3ECeDX6R7IOwcyNu
	XV8UA6w1kvOg2HX26HKXLqTWDv7JzE/XjsLBPu3svHAFuuiZKOHj1mc6QmrFR+JDovQlY0MF7PK
	6ilaYLex8ebImDET3liX2FyeGU3+AP0vEwhZcAmPw1eMRO8BCaOAAN5upD43RtZraZvpVeCaYnI
	T8ZFxflZnzlc8m7xzJ7JIoYqIUBRdQt7zA+PyyqKnKRW/WmF5RwHkkTrYjnbvzdqz8GJHJ/uaFY
	ha6y1KiUkDU6chu7clgoXO+3LX4CwR7cejIzgWZelhCohrACL8E9M7DMaiGThDVeOExd5fzPpes
	YQ4pgULzW49Druzr/fhHFfLohRy7LLDYOrxE41yd5u4WJEbirL8XGug0QnHFxn/cDvkQWc9CzS1
	+dlU15DroOahUmV8O4yn11dqFIJNFUIiQrkztpLps2OWvzzHriSgPSHUXiBsGsrhz5Ncl5PChta
	4dkvQbpzg==
X-Google-Smtp-Source: AGHT+IGDVmSTtldgMOu9q799JiuC23EtaSfajwaaTTQOFIl8FE+pUkTOWASO3+mEEnSoq2I0NYMVqw==
X-Received: by 2002:a05:6000:2510:b0:3f8:e016:41b5 with SMTP id ffacd0b85a97d-425577f0ab9mr4720169f8f.14.1759399775404;
        Thu, 02 Oct 2025 03:09:35 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm2953894f8f.12.2025.10.02.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:35 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Gortmaker <paulg@kernel.org>
Subject: [PATCH 6/7] bitbake-setup: clarify that default answer to prompts is no
Date: Thu,  2 Oct 2025 12:09:28 +0200
Message-Id: <20251002100929.1054540-6-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002100929.1054540-1-alex.kanavin@gmail.com>
References: <20251002100929.1054540-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 10:09:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18120

From: Paul Gortmaker <paulg@kernel.org>

It is common practice to put the default choice in upper case for
yes/no interactive prompts, so that when people just hit enter, they
know what they are getting.  An example that linux users are probably
familiar with is "sensors-detect" from the "lm-sensors" package.

Unify all the prompts to be the same and indicate that the default
answer from hitting enter is a no with an upper case N.  No functional
changes.

Signed-off-by: Paul Gortmaker <paulg@kernel.org>
---
 bin/bitbake-setup | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index de83d780b..bb466d85b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -418,7 +418,7 @@ def init_config(settings, args, d):
 
     print("Initializing a build in\n    {}".format(builddir))
     if not args.non_interactive:
-        y_or_n = input('Continue? y/n: ')
+        y_or_n = input('Continue? (y/N): ')
         if y_or_n != 'y':
             exit()
         print()
@@ -623,7 +623,7 @@ def write_settings(top_dir, force_replace, non_interactive=True):
         print('A new settings file will be created in\n    {}\n'.format(settings_path))
         print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
         if not non_interactive:
-            y_or_n = input('Bitbake-setup will be configured with the above settings in {}, y/n: '.format(top_dir))
+            y_or_n = input('Bitbake-setup will be configured with the above settings in {}, (y/N): '.format(top_dir))
             if y_or_n != 'y':
                 print("\nYou can run 'bitbake-setup install-settings' to edit them before setting up builds")
                 exit()
@@ -669,7 +669,7 @@ def write_global_settings(settings_path, force_replace, non_interactive=True):
         print('Top directory prefix (where all top level directories are created) set to\n    {}\n'.format(settings['default']['top-dir-prefix']))
         print('Top directory name (this is added to the top directory prefix to form a top directory where builds are set up) set to\n    {}\n'.format(settings['default']['top-dir-name']))
         if not non_interactive:
-            y_or_n = input('Write out the global settings as specified above (y/n)? ')
+            y_or_n = input('Write out the global settings as specified above (y/N)? ')
             if y_or_n != 'y':
                 print("\nYou can run 'bitbake-setup install-global-settings' to edit them before setting up builds")
                 exit()
-- 
2.39.5


