Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F023FCF34AA
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 12:48:46 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6082.1763556519226737295
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 04:48:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ise6iKeq;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so4651943f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 04:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763556517; x=1764161317; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwT85iqWOOT/NJOLHany4M5pCkoglgquUmc2kVdDHNY=;
        b=Ise6iKeqU9iLs+DzFQgglUh0OM79UsewU7CSUyOzcKGvocH7EyTIa4bUcu0h7FZGYq
         p+ysfrJCSevi/Fw4vGSldgIXYqCgbEmG9hSuXCqOH8pYC6Z2qGZH86UQkxDIu8QAMP01
         khYGaIGd7V3ba2jp+/n4U7up1mdZUEqTiCs9QLr9y08h82apKoxp+1Nku8+nOCH7IeyQ
         EFVRLbsElmVz4n4pUdULgv7zd+hvWpJC9qwGe5Z/auLSi0bYvTw/USuoKR1rMfkDSK3H
         1Uyac8pb2gyQ7eFiyuneECaFfB+ontH6Di+1mTP5ch6xJRxG1PPMwts/7sZBljLKSNkp
         NmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556517; x=1764161317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwT85iqWOOT/NJOLHany4M5pCkoglgquUmc2kVdDHNY=;
        b=TfZQeUxhIv+tE+rL2k8aG7AVGPJBqxR0x5T0VLz9apGAO0v8XLTQA7J5WNYL8intVf
         weoBG/EANGGCm6Ff/QtMOs9n+bBraye0VJLEZMQeLEGPpg1TGqD1akj6/2ySDv3hs5h3
         rOf3NLn+ERtxELhOUUSN2WJdL59V8KfjlglcDumQBAcHmlsyRUi7iE7glEObq59XZv4D
         XFlO4mJQOVGm9h/L8YusvrLKTL5EbSbLWX7CUWPLyC0uG4kjZgyT94/WOnBTvwaThqVE
         CST5+qKBYetyHAWvm59L/fs+fG/QpigfcuiHvW140VFLLAOt0ukMVmq4OOZL9vVtm2Vn
         Bl8g==
X-Gm-Message-State: AOJu0YwQ3GXyZKSUJ5GucNbK9iTzof6bOhygvYjWBTQ6XIWue6Icz1EX
	2Di09OExaBCm6/CRkQaj7wvyDYloGbjpSWkh4XPK566vRSeHjKuo4tlf64mAOw==
X-Gm-Gg: ASbGncvF7PDGiGWufEu8f2LhoLcz8X2gP/7ONaHUj/M2z/J//h/jtm+7NLRWroZsMBx
	aR8ao15rgkb8zAlpgq8Frtjf3IsLAw2VxP7qBQBRYGESblCXUFO7OdAGQMNBWpwg5MJUUcN9GgS
	061BvCSehUUfUuEp6X0q8ax2cUciymrw5f9U6oxNPwA0cN3G2y3Hii9FFRmsTUfQ8tNGsdnImrH
	ZYkD/I7iUYNcHoxHe8bZsQNQIH6yz+LXZ3qXJcMMwIV1jTnUTv173HLYP313zKFTtZSfUGE7zSI
	B4o1WhLT9p7gnhJdVQsScQiKnRYOmM8rqR15K0gk4nwRAgx9MI3dXq8b4HsMvkkU9lZ5mLM1zL/
	n+xnyqRD3yUrL+4+Sk2fSWhIXkXdF35+uUch5fept/WlpCsS/9dtk36ultS6hWSh6nnyPixlbdR
	DdkeopQZ7/J8omUnivJMbQENnfc4/vlNOKl5nuvf5KfCIhv7I=
X-Google-Smtp-Source: AGHT+IG2tx85v2BEYCV346rOrbXHiSABpRwt+HFu5eViZnKleS2XxhsfLW2N0TngK5WQxe7J7JaAhQ==
X-Received: by 2002:a05:6000:2909:b0:429:d66b:507f with SMTP id ffacd0b85a97d-42b5939111dmr20430720f8f.48.1763556517318;
        Wed, 19 Nov 2025 04:48:37 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e846afsm36953267f8f.13.2025.11.19.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:48:36 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: "Joshua Watt via lists.openembedded.org" <JPEWhacker=gmail.com@lists.openembedded.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/3] bitbake-setup: Tell the user what to do if they don't like the top dir
Date: Wed, 19 Nov 2025 13:48:30 +0100
Message-Id: <20251119124832.3906214-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 12:48:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18455

From: "Joshua Watt via lists.openembedded.org" <JPEWhacker=gmail.com@lists.openembedded.org>

If the top level directory look new (e.g. doesn't contain a site.conf
file), then instruct the user on how to choose a different directory if
they desire. This should help clarify what bitbake-setup is about to do
and how to change it if desired.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

Changed the wording and order of the two possibilities: changing
the settings comes first.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index ca0517924..cbcd637b2 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -697,7 +697,16 @@ def create_siteconf(top_dir, non_interactive, settings):
     if os.path.exists(siteconfpath):
         print('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
     else:
-        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
+        print(f'{top_dir} looks like a new top directory. If you would like to use a different directory, answer "n" below and either:')
+        print('\t1) Change the default bitbake-setup settings:')
+        print('\t\tbitbake-setup settings set default top-level-prefix <PATH>')
+        print('\t\tbitbake-setup settings set default top-level-name <NAME>')
+        print('\t2) Pass one or more options on the command line to change the top level directory in that invocation only:')
+        print('\t\tbitbake-setup --setting default top-dir-prefix <PATH> ...')
+        print('\t\tbitbake-setup --setting default top-dir-name <NAME> ...')
+        print()
+
+        print('A common site.conf file will be created, please check it is correct before running builds\n    {}\n'.format(siteconfpath))
         if not non_interactive:
             y_or_n = input('Proceed? (y/N): ')
             if y_or_n != 'y':
@@ -947,7 +956,7 @@ def main():
             settings_func(top_dir, all_settings, args)
             return
 
-        print('Bitbake-setup is using {} as top directory ("bitbake-setup settings --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
+        print('Bitbake-setup is using {} as top directory.\n'.format(top_dir, global_settings_path(args)))
 
         if args.func == init_config:
             init_config(top_dir, all_settings, args)
-- 
2.39.5


