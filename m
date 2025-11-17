Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F72CEBF93
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 13:16:43 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9034.1763385396041643957
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 05:16:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E/8LFv0a;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8824888ce97so64205266d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763385395; x=1763990195; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TdOZblPKQdjWuDqP6V0CktbQTuZVm8utKzWM5cIktmc=;
        b=E/8LFv0a3PFPtXHjlUETW+4R6u0cgGF+gR8UyiEjCfINkjw+uMBdHNap+KXDHsxfm1
         ei0KZVDOha2x7KvIlGFZ9GmlDeHL+HsB0q5L0GCyNLfwVmfWGxqO7xATI7V964Ss0uvE
         8r8Qs/u66D3zqQT2odrvKIMzOMQK2ZZEFddcDBvBigftef+a9mxZ/LlTX9YesCAz2jG0
         UqY9iF96pyv9rxUGoJGayUjp0ybYXHUTDZHHHz8wVlPD5FD1BxQb2N7msNvIv+Fm/mhs
         E7TPMHoeh+UziiVSYiS/4LEWl2LgEqgdEJHlMkkESljb6+p55ivT1qgNFXSdBTzjuySM
         EGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763385395; x=1763990195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdOZblPKQdjWuDqP6V0CktbQTuZVm8utKzWM5cIktmc=;
        b=UkV55WSJmqOn8gVC93GDpLWnG5SjG6W0VTwxOc8dnjANi7DXY16QNp7/hFWln0tO1i
         Jny5DRgqXOVW0NzH45l0+cyeXMX1U42JOnVMVNjHsMT9y17BGdy5vDYZjureGLIlAcWb
         0ucyNC0SXtrqczaewrIYzpScbs3G54brlQeUBfTU4R9q5MgLx+Bq1hfDDFVUQ71/xXPq
         Ur0RnOV67gO5DfdzMxDHrX292NPMeRThl+Vlh6S5vyUI7wrkWRTkivmD/xel0UCfT5gq
         hifiPwK7URvavjJaRjOK6GqWyfX5mDdLXJHZ3kQNttNyDNVsH0wLcYgFTcMPbFPhdW2c
         Si2g==
X-Gm-Message-State: AOJu0Yw7yXtTBNRLhpnNHNu0bJCbEC67SnnKtjYueg/HdUEU5J99zxL7
	7GePlO7vi36rukEMR4OtjVwlsy1Hwkd0pZjaHPjkWS0UNOeEynXXRfyizq5EfbcL/fNFWHCSuJw
	EOPf3Q4qgeZLgj76pTDMkmdQror59XVo=
X-Gm-Gg: ASbGncsqskkh/+QuOvLl7aHPHvm/k/JdDSnM/r5i/1UX8O4ALBij97tz6zUCgaETH97
	f3Dy6QTKmsBoUFP9iiVYMciLt9afvhoinXDOu6uEiGOtcdUBT4+Wwt9SFJ/opXChB1J/kpg6vDP
	tb0hG3ITc8fEMUypsxlD2zzlP69vkygc6K4FaTx26LcionC8odVUsKkNqRPA73SajW2JN/QENRM
	nZX3o1M2ThkUMEYJRpRs/NcVqDj0p8CxfMlZao88QipN4xCyvLFgXCEGTLglDLTlHml5djPAmRC
	FkJDXNYHWWEsWL7KiW7FPNorBFR891JQBUsE1YI9
X-Google-Smtp-Source: AGHT+IGDzZcndsT+IDhOjGp3dsFqCrn0r0EY8y3hRHcJAZoMidNqUWNG1hRvS7yIr8TYzxd2zLDlgj/dJ5Ygf7G1wmI=
X-Received: by 2002:a05:6214:19ca:b0:880:51f0:5b8a with SMTP id
 6a1803df08f44-882925e98e5mr162267386d6.15.1763385395044; Mon, 17 Nov 2025
 05:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20251117-bitbake-setup-conf-updates-v3-0-46cdf826e79c@bootlin.com>
 <20251117-bitbake-setup-conf-updates-v3-1-46cdf826e79c@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-conf-updates-v3-1-46cdf826e79c@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 14:16:23 +0100
X-Gm-Features: AWmQ_blyp92O0gytuRcH9BPipSLlDSEzyWe5dAK8UgXLl6TLoYYTT0Jlsycfkko
Message-ID: <CANNYZj-XZeTQYWFoar+odfYT0yhMCFi_-z_ETprQRDOqn7J8aA@mail.gmail.com>
Subject: Re: [docs] [PATCH v3 1/2] bitbake-setup: update: add a
 --update-bb-conf option
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 13:16:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18430

On Mon, 17 Nov 2025 at 13:52, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> +    update_bb_conf = 'prompt'
> +    try:
> +        update_bb_conf = args.update_bb_conf
> +    except AttributeError:
> +        # this arg is only passed from build_update()
> +        pass
> +
>      if config_diff:
>          print('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
>          if update:
>              commit_config(confdir)
> -            update_build(new_upstream_config, confdir, setupdir, layerdir, d)
> +            update_build(new_upstream_config, confdir, setupdir, layerdir, d, update_bb_conf=update_bb_conf)
>          else:
>              bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
>          return
>
>      if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
>          if update:
> -            update_build(current_upstream_config, confdir, setupdir, layerdir, d)
> +            update_build(current_upstream_config, confdir, setupdir, layerdir, d, update_bb_conf=update_bb_conf)
>          return

As both usages of update_bb_conf are guarded by 'update' variable
being true, and that guarantees that args.update_bb_conf exists, you
don't have to have that try..except block, and can pass in
args.update_bb_conf directly into update_build() ?

Other than that, looks fine!

Alex

