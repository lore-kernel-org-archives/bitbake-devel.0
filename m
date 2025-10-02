Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF95CAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 15:01:28 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.11094.1759417285129567433
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 08:01:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gw1R65Hg;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b00a9989633so237253966b.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759417283; x=1760022083; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUh/ajgG6p1c/hjY3Sobt7SvIC60ZPnKZnvX9M4HXVk=;
        b=gw1R65HgiahkPYdXJUERd9URq7szlsp5aInOJBWyeG8fUYGnFTw8vgYgj9M9lN5ydN
         R6LGkWEmZCDoWfU1CZ4Pb1e+vQyhnu/JmNYRDuLXuAdWH5t7OrtBAcv9avmJ4qULAr5F
         t95jtZAwW20G2AZ9wvXAXtWDTravelesWeKQvv/rQljQjUycIlQQdAOjwHhuw7LqQTh1
         sdJ3u4NxR+WXUckjZ2A6VdgOEZdykKosKm9d+AZtMTtn+qaIkR8wmzjX8VF5EGQH4dJ3
         2F9ZFkXs+FfrfFAIXBTz4wGAnSmCiwBEcehIJgWeDoOD+ywjBVtueaUz9i5ckh9AjGGA
         RlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759417283; x=1760022083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUh/ajgG6p1c/hjY3Sobt7SvIC60ZPnKZnvX9M4HXVk=;
        b=CFBBQT9PECYl2bjtdNWmzq7PeNd74FnIZLuhqB6AFi5q37DrkdfKJ24MXWJeEIRe7x
         TFRNtp7VXP8Yd/TCjFEOu1g42gEDeo74dhswDO7nDK8RmMLKIJnfdf6APkrPdMhaZcaZ
         4JWs0FyIsIG6feVUaDsFvf4wzLvxf/UgIK9FkWzOpaesVXdXanhLm63YAN3tGhBuw+Iq
         l2lC1xuWiZlHA18BcHHZ4pPvcTduqFyfdGpP9yDFqFATad8yi0BI+pSkVvPRNMbZ+c5d
         WyGzsQhcQNTi86++5VxYl8XtoQsrmPVPUfhvFiKVc0dGTJQrq9UTOKYs9Zv7ew8bNA51
         26Ug==
X-Gm-Message-State: AOJu0YyXBn/3BLofsmoC9cwex65fAFEDM5tcFfN4d7goJodvRGZUc1Dd
	x2f60tyCzM77cr8Wn48GYzrON40dYqgElT84TPwkLLa47nPQ5UV2X7c0jylhmQ==
X-Gm-Gg: ASbGncuNEtePON+DMK1rhfP2GKMcO8kkPZaMFoZbp7EktBDAtR+9a3lrLUoVz+fRfSC
	jm90i2wXrMoiIBezFwTUxJLj6UY1ZROjh/HEuUB3VKhaM4UHxwRShuT627qMfeXnTqJQIKaucJy
	1mOB7mmIFAITK7Dqh7P8okVw1ECaWooHnz39+3pUJ+AmD7RN45Em4Z4VpmjZDOEFIAwSdrWI1/u
	yhMLzpqf/lkf9VetH9FXBI4AwIKbANUqPlPRBhw0fAetE4aRqxJ+fRbvCIpJo3nYudfcr0/z/y7
	JqYWqqYzKb89MQUuDQFlbfNyVwdGKemYwCGHubXJKIR6507Ha+GSNiQXrT/jJTgy85TluYKowCq
	fE+BDGaXmRNEyuqifI2wyzDkxi6POsK/1of5tIx8jsv71d0NJjNg3aRc2JJ+2Y9mPrLVG+HwI/v
	B38WnsnkOF0VPOIQ1FIF8+4UaUYfMY+hOhzkqAlI4kC5/KYRKn/yNIMdWqWV2ipAEULbNCGwzj/
	CLAPAPfAQ==
X-Google-Smtp-Source: AGHT+IFJmhyyuKWayPsglMKiuAKaAdoYcuB8F4O7lYHHIIyt+zwCDJmq7z2OVcYI/UZVbaqlGAJeaQ==
X-Received: by 2002:a17:907:94ce:b0:b07:dd5e:16be with SMTP id a640c23a62f3a-b4859594206mr503141966b.4.1759417282687;
        Thu, 02 Oct 2025 08:01:22 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486a177c9csm219869966b.89.2025.10.02.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:01:22 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: add support for skipping a fragment selection
Date: Thu,  2 Oct 2025 17:01:16 +0200
Message-Id: <20251002150116.1342276-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 15:01:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18122

From: Alexander Kanavin <alex@linutronix.de>

In autobuilder testing a use case arised where
- the available choices in configuration file for choosing a machine are incomplete
- putting every possible machine choice into that configuration is undesirable/not possible
- autobuilder code can write a machine selection into the bitbake config
after the fact.

So this --skip-selection option is intended for advanced users that know what they're doing
and is generally not recommended as it requires manually tweaking the bitbake config to
make it usable.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index bb466d85b..e7b955213 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -339,9 +339,12 @@ def choose_config(configs, non_interactive):
     config_n = int_input([i[0] for i in config_list])
     return config_list[config_n][1]
 
-def choose_fragments(possibilities, parameters, non_interactive):
+def choose_fragments(possibilities, parameters, non_interactive, skip_selection):
     choices = {}
     for k,v in possibilities.items():
+        if skip_selection and k in skip_selection:
+            print("Skipping a selection of {}, as requested on command line. The resulting bitbake configuration may require further manual adjustments.".format(k))
+            continue
         choice = [o for o in v["options"] if o in parameters]
         if len(choice) > 1:
             raise Exception("Options specified on command line do not allow a single selection from possibilities {}, please remove one or more from {}".format(v["options"], parameters))
@@ -395,9 +398,10 @@ def obtain_config(settings, args, source_overrides, d):
         upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
 
     upstream_config['bitbake-config'] = choose_bitbake_config(upstream_config['data']['bitbake-setup']['configurations'], config_parameters, args.non_interactive)
-    upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive)
+    upstream_config['bitbake-config']['oe-fragment-choices'] = choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-of',{}), config_parameters[1:], args.non_interactive, args.skip_selection)
     upstream_config['non-interactive-cmdline-options'] = [config_id, upstream_config['bitbake-config']['name']] + sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values())
     upstream_config['source-overrides'] = source_overrides
+    upstream_config['skip-selection'] = args.skip_selection
     return upstream_config
 
 def init_config(settings, args, d):
@@ -492,6 +496,7 @@ def build_status(settings, args, d, update=False):
 
     args.config = current_upstream_config['non-interactive-cmdline-options']
     args.non_interactive = True
+    args.skip_selection = current_upstream_config['skip-selection']
     source_overrides = current_upstream_config["source-overrides"]
     new_upstream_config = obtain_config(settings, args, source_overrides, d)
 
@@ -778,6 +783,7 @@ def main():
     parser_init.add_argument('--non-interactive', action='store_true', help='Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.')
     parser_init.add_argument('--source-overrides', action='store', help='Override sources information (repositories/revisions) with values from a local json file.')
     parser_init.add_argument('--build-dir-name', action='store', help='A custom build directory name under the top directory.')
+    parser_init.add_argument('--skip-selection', action='append', help='Do not select and set an option/fragment from available choices; the resulting bitbake configuration may be incomplete.')
     parser_init.set_defaults(func=init_config)
 
     parser_status = subparsers.add_parser('status', help='Check if the build needs to be synchronized with configuration')
-- 
2.39.5


