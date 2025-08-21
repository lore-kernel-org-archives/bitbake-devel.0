Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7212BCA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 14:08:52 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.10625.1755785331866405369
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 07:08:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Los3mM7P;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afdf4c4a2beso271211666b.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785330; x=1756390130; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BI3fgnAFyq9M0/GWGy8kGPqqb1LWv8FUmz2Iw9iLbQk=;
        b=Los3mM7PXPof0Cj75+UUeH+haXi1wbr0VP3DkqbwIV5eHwmaTFwrU+dgTi8s0vGJ6h
         ZONNbBjokx7amk8jUs4Q1xZWPz9r8jd4UyyrEepZ3RJDUrnvMpBECpuGVx7ED5H27+5W
         WMQRBx62O2VKCNgLNL18bPqFwur1yNdzrm+lG/J8rCMreC3rT8bdJfsoQUXeS2JVKDib
         wHnM/Gp09QQPBAeA529ERwUZw/iXwkqpo1VgnOy24PpPrzUCP8pb52FM43Fg+kgOSHqT
         OFXnrJFdhsTh5Me6SNtJXuiWToA5Hcqz5FpFlWLOt0d5eBnWzUxVahIuk4uksBoqzFPb
         EZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785330; x=1756390130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI3fgnAFyq9M0/GWGy8kGPqqb1LWv8FUmz2Iw9iLbQk=;
        b=tQ8Z6pz8GYZLAh8sKsm2sQcV1N1XEBPjZ5m+q4KtIv5hENjrfpMhRkUHgxVyhFFXd+
         TTKNnQ3i6ZE8OBtGDmFTFmqwDMiQX8sXpF4/AbEY1OzWQXyhXYkKG0gTLYTprGDv13sO
         7H8B/JVbGoJJoyXypUK8e+tYNpUafWlCf5+Qlyx+rCWI4eOlhNPjoQBFATKnOMFiCSzH
         UW5Pk2JgyQo1+hVE6bXPVZbUvOLdWixgMvui7XAbXMemI2NYkqiqQIwa/PKt+JLMXfvS
         6rEC+cxqWqo4VgdTx7PjMF6KptELOVkYReIE9p3pSFz0yp2k1a3veEimtLirPdGbGfHL
         urmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVozmlp5SVrJVtKmkUQjurnPUU5hwAuutz6X7T0+owxgPWjIAzvv6d2Y8RvCJb4rrEnh/GD5adAiuYeo1a@lists.openembedded.org
X-Gm-Message-State: AOJu0YwJDZX5urkaOmiX9PxGIPqwogGSXizx2rAHx3vMqpns7K+RqakC
	IrSChL4meRbDF3/DQpv33WACKkcB5mMZQ/YCyCyLnj/Lsu6Zxq85wBea
X-Gm-Gg: ASbGncsBIHj6980NRyWcnJusFIKBIO38iuc3C9/IeMYSxPRzYm7YBMcHRkFwAd3HbZ5
	gmp0IYzYUaKLz50Gc9lCqGoSIrWlJFpaJvIGqQ7moOygOWgm7FiWpuTKqAqLYCfCyjLLDTVH5BM
	FApY2TldhQXRSEFTTX+I1b0f1zvQkbsp+OCAbJjN3GqRucb76hUYedkf6EtTCHaXxmLcPptgqn1
	rNIySJK2ODyeAlzL7kajChm9yLg1HMRq3Im+KZ2hXcEQ/ntwMPW6Sm6+SuqUqg4c3i9Z/HcTAfC
	czBkZlSRRz/V36Is7GdFEsu2gznR2dIJQ/LtUyc9wDkZSL38gSQcIpCht1zxN9nx1HHyVhT3NhQ
	c37v6T7++EooSUhb66P2SKGwm55MR6oBI7slc04XLNQ==
X-Google-Smtp-Source: AGHT+IEIKmROCL/pFlaGtb3aCWK+kF7elirfE+x0YWRmTuMIDplE/u9RI0vkv+KXqTIigk9UGXcTDw==
X-Received: by 2002:a17:907:2d2c:b0:af9:38ec:42d9 with SMTP id a640c23a62f3a-afe0b9ecebcmr233962566b.11.1755785329889;
        Thu, 21 Aug 2025 07:08:49 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded3070f9sm391297366b.41.2025.08.21.07.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:08:49 -0700 (PDT)
Message-ID: <9cfa7c31-cbbc-43a3-a65b-fcb9984c6757@gmail.com>
Date: Thu, 21 Aug 2025 16:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
References: <20250821130715.1904574-1-alex.kanavin@gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20250821130715.1904574-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 14:08:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17906



On 8/21/25 15:07, Alexander Kanavin via lists.openembedded.org wrote:
> +
> +def init_config(settings, args, d):
> +    stdout = sys.stdout
> +    def handle_task_progress(event, d):
> +        rate = event.rate if event.rate else ''
> +        progress = event.progress if event.progress > 0 else 0
> +        print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
> +
> +    source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
> +    upstream_config = obtain_config(settings, args, source_overrides, d)
> +    print("\nRun 'bitbake-setup --non-interactive init {}' to select this configuration non-interactively.\n".format(upstream_config['non-interactive-cmdline-options']))
> +
> +    builddir = os.path.join(os.path.abspath(args.top_dir), upstream_config['non-interactive-cmdline-options'].replace(" ","-").replace("/","_"))
> +    if os.path.exists(builddir):
> +        print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(builddir))
> +        return
> +
> +    print("Initializing a build in\n    {}".format(builddir))
> +    if not args.non_interactive:
> +        y_or_n = input('Continue? y/n: ')
> +        if y_or_n != 'y':
> +            exit()
> +        print()
> +
> +
> +    os.makedirs(builddir)
> +
> +    confdir = os.path.join(builddir, "config")
> +    layerdir = os.path.join(builddir, "layers")
> +
> +    os.makedirs(confdir)
> +    os.makedirs(layerdir)
> +
> +    bb.process.run("git -C {} init -b main".format(confdir))
> +    bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))

Possible bug: This throws an error if git email and name are not
configured ("Author identity unknown"). I tried "bitbake-setup init" in
a docker image, where I use git with untouched config. But when I ran
the same command right away once again, it succeeded, saying that it was
already initialized



