Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6896CF3186
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 09:47:15 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3150.1763545627639165220
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 01:47:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d61IHB8H;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so8262706d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 01:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763545625; x=1764150425; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7aNrjsJFhBBzyZ7D6Qv7eh9WwzecCpV41YAAQlB2/Gc=;
        b=d61IHB8Hc1mvqYFqF4mfxKnLKkRhhuSjwv3NGLodY42/XT80DiMl7jo1gO8CpOkd7x
         1NWU9lJZQcxd8xraHEL7vPKqx2wxrR4mf7LZneXk20uLVbzuNsLYGsyhwaMchMKBidv2
         pvZWIWH8Z4zgLr3b0FAXjrlkMn55A7N4k7h9qfPaHLTDFuBEKtw1ku+8PKFUPjxm50Vj
         ya+gx91owgsn5iIGouS9ekb4RF49OYtyWgo9VAVJYIYZedPxfVV/ZA2j/o5NKY28xxVZ
         INSPba7lGu0BiEFraT32p0n1FgJEoz5l6OZ+FcgC6BFY7l+PO6RS6E6xOnOKKnyXkVu6
         J3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763545625; x=1764150425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aNrjsJFhBBzyZ7D6Qv7eh9WwzecCpV41YAAQlB2/Gc=;
        b=tJHtjynhZ9vkrCd2zzEfPikZ953IiZfXlxx7FAYLrlPEZBlaKTR2wdrh5+7mi/A6uc
         vqhn35mXkLykvJvosNyFT5Gojsyn5uCXp4kKBMiqIyXSCt6KIN2oJ2EnJCgJNrARzjHX
         LFG5xF8hW+0hdGGB2DVlDp6YulaUK15kQKBG6axHc9JaGGWoFlMzS79+gBLS5+0n0hD3
         8Mg1HVEdmyyowsflZQrH8RC8r5BX1pj+fZU7Ah0bdWiUhCqYKorH1AA+muARj+JIG682
         1VL/axt5+CtvzB8+wrAOA1fnmDpUR3Nf+CFpgJLx4w+FAWvht1P4bTqKvB67qNvpJXby
         vldQ==
X-Gm-Message-State: AOJu0YyUhlYbQlxYg4M4AOC31MpTP3tLoDRbLXdHU/MFuwYJ30Pf83Gr
	dqqzo4ju/X2vDAJG+w2dUk01SMehCJN/P+AF2ul8u2bCyoR7cmKz+DNOXuBfFDzpEsY31Vxg33i
	VNcPJCGlxHPdpLngozWHMtCjYeVk2vWg=
X-Gm-Gg: ASbGnctFd0JcA830PEMtw8N9fif8fHjTNtcepnlJKX4bMB6fnOMxCaH5k9pUckXbA09
	E9amloRVPqH/zkI088X75cSZMGXM0Sxxs2LnRM2cGl0kAdD1Jysxe1ZMwM4QIFKvLEZVlWJaJa3
	knntV6XCY2RmvLoJtwqCFEHPTBRJsPqsJGsLCeLMhiFCeiRUsimVHA6tNubjUpi164v5Kc+arWC
	FIILSUBlF51zxCINLElQrj9E5tyqRITfkY22y2oy3ieHT1C5JZbFuqAD+9Pj9T3n/Avhgl+v+SA
	5i2p
X-Google-Smtp-Source: AGHT+IHqoDeNibnVMBJKvRWxgAk7gJLWHOWTR8QAARC/+/MMwwXsILavudJJ7mkSHI5Kp9a9uHHlypztKHLUbidIdZY=
X-Received: by 2002:a05:6214:76c:b0:880:837d:aa4c with SMTP id
 6a1803df08f44-8846038358cmr22879596d6.28.1763545625329; Wed, 19 Nov 2025
 01:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20251113161524.4068231-1-JPEWhacker@gmail.com> <20251117194805.2322020-1-JPEWhacker@gmail.com>
In-Reply-To: <20251117194805.2322020-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Nov 2025 10:46:54 +0100
X-Gm-Features: AWmQ_bnyW2K2gEpS8kazXge5wU2lNEqw-NF_ro1EH61Dw8yvcnSf54TzAQqW4bs
Message-ID: <CANNYZj83XxAV8EL1Q3e0FO2YWDyO9iVm=bwbL2ant7_Nwx6Y0g@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] bitbake-setup: Tell the user what to do
 if they don't like the top dir
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 09:47:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18452

This doesn't apply on current master. I'll rebase and resend as part
of further tweaks to address the remaining issues.

Alex

On Mon, 17 Nov 2025 at 20:48, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
>
> If the top level directory look new (e.g. doesn't contain a site.conf
> file), then instruct the user on how to choose a different directory if
> they desire. This should help clarify what bitbake-setup is about to do
> and how to change it if desired.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bin/bitbake-setup | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 3a281defa..7e9491fac 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -671,7 +671,16 @@ def create_siteconf(top_dir, non_interactive, settings):
>      if os.path.exists(siteconfpath):
>          print('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
>      else:
> -        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
> +        print(f'{top_dir} looks like a new top directory. If you would like to use a different directory, answer "n" below and either:')
> +        print('\t1) Pass one or more options to bitbake-setup change the top level directory:')
> +        print('\t\tbitbake-setup --setting default top-dir-prefix <PATH> ...')
> +        print('\t\tbitbake-setup --setting default top-dir-name <NAME> ...')
> +        print('\t2) Change the default bitbake-setup configuration with:')
> +        print('\t\tbitbake-setup settings set default top-level-prefix <PATH>')
> +        print('\t\tbitbake-setup settings set default top-level-name <NAME>')
> +        print()
> +
> +        print('A common site.conf file will be created, please check it is correct before running builds\n    {}\n'.format(siteconfpath))
>          if not non_interactive:
>              y_or_n = input('Proceed? (y/N): ')
>              if y_or_n != 'y':
> @@ -896,7 +905,7 @@ def main():
>              settings_func(top_dir, all_settings, args)
>              return
>
> -        print('Bitbake-setup is using {} as top directory ("bitbake-setup settings --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
> +        print('Bitbake-setup is using {} as top directory.\n'.format(top_dir, global_settings_path(args)))
>
>          d = init_bb_cache(top_dir, all_settings, args)
>          args.func(top_dir, all_settings, args, d)
> --
> 2.51.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18436): https://lists.openembedded.org/g/bitbake-devel/message/18436
> Mute This Topic: https://lists.openembedded.org/mt/116276734/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

