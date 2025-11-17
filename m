Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B688CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 18:43:15 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17168.1763404993700207319
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 10:43:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T18GDpAh;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b109c6b9fcso38646401cf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763404993; x=1764009793; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2h2PAuDpwWPw2Z5gbP+hEQt/ldakIITnX/BVCK3jpQ=;
        b=T18GDpAhCKshmTdjJg2O9LEHzxsCGGmrnYaFLIpe6NAMkmWnwl9Q435jFzb4bkczG1
         5I1s+HZKvuxYp22E3+JgbjyhXSsAkC8ROjFEeBtdz3uMG4MOJ9q1jBKG8okQQZEKPwvv
         tMJxm0j8r70zh1lHKXyqEBpa1RclB8868gYWAFKY4q8fot5tfhrtTeM7dNk2JQbeo/jj
         8L2WVVkt+/WKqZQLaXvk9c5VuXbSNfuPFn+5O2x+z9iMIBBANNEnt0K1JkNSb+fIoCFt
         d057azwyjMeL3oueG63867rvjwcba4kOc1Et8JQESsayHLiZVspv/s4pjvrCCmrrcYjH
         N2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763404993; x=1764009793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2h2PAuDpwWPw2Z5gbP+hEQt/ldakIITnX/BVCK3jpQ=;
        b=LaiRzfQbHj7MXezxAieG7BN5wd8MDFytQD45pBv89lPZyIwaBhMWLR38A3On+y9aPi
         /vre+nn/9SeqWIipl8iXCU7hbsA0fIDTB8aTur9Wu+HkJ4yHfNJddAYORU8dJ5rqgsbd
         XFqCUnTVTcq9o4goxWWmVPyc0oqTs7MMaJ232kqpDnpKct79PQwI//MCfl0u/Am79gGK
         BxrOdbjHVodoM/vswSTG1TP5pDhFY11tbUbnaUFYHZXtzATGWU5ipLfpDl2UjKUsjW1t
         pVfx4i/4ZLyRu1paJes8gnVy1JMZZYchpreb4/7IS2Mw/lEy63QylZZOibT0kAtig6pv
         +JpQ==
X-Gm-Message-State: AOJu0Ywa8U5ULoLUHnVqRPlvPTcHHeXNLlMsz9Cc7FfW3dYBVKHvJdfP
	Bt+3al+jnDvaWIcWi/lPjukhbsynaiPjVIBEUZWetRJziCJ541tySeh6vQ5QGZx3RBBypMLlnjk
	IHdSc+Vy96unslGgxr9/8ALj50p7m9Tc=
X-Gm-Gg: ASbGncuKGZa7xZ8YiRKdZX4HshJGRo4eJ4/nHyRJe3X8tnPsfFp7riaTis4A5S+DsPI
	8r9ECDTOBEcqjdy82a3WOhdda38m4bqUZ79BaI8z0eaOCwt5LNl2k5A4rCH5dLOGp+EsVC710cF
	ajPpSsvtBRvkFyr0ECfdubU4bx2YkLnfQbIp5ZVuYl1C38z+rw3EIPEblRevNmDySigv3H+dsFC
	4oXVmA8e3uGrjsYd0hiPz13AjfPdHQBdbAG5z9HlbsYiEd62+/zW1BJquIf6IT7t5nqPF1XHixJ
	1Xtt
X-Google-Smtp-Source: AGHT+IGYEhypT/6588rbe89lVAX3wyFfxhyguv3W6r+IODM4CzCSBkVwP7PVNwF5WSn6GxNb2YMw7mLnJh+G22ZdpOk=
X-Received: by 2002:a05:622a:64b:b0:4ee:18e7:c4de with SMTP id
 d75a77b69052e-4ee18e7c892mr86146421cf.78.1763404992583; Mon, 17 Nov 2025
 10:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20251112154121.3750738-2-JPEWhacker@gmail.com> <20251113161524.4068231-1-JPEWhacker@gmail.com>
In-Reply-To: <20251113161524.4068231-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 19:43:01 +0100
X-Gm-Features: AWmQ_bm0-g_hweqPFJhbKaGguAtvjNPT7ptWY7quu0zANpWnFxxkjfQX8fg59VI
Message-ID: <CANNYZj9E7yTmM5BX08wNveWJ-LnVbx3gbRcR7kd6wpBofo0Gxg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] bitbake-setup: Tell the user what to do
 if they don't like the top dir
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 18:43:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18433

I had the vague feeling during the call there's a patch I've seen
which was missed, and this is the patch.

Can you tweak it, so that this message:
Bitbake-setup is using /home/alex/bitbake-builds as top directory
("bitbake-setup settings --help" shows how to change it).

does not anymore include the bit in ( )
(RP pointed out that "bitbake-setup settings --help" doesn't actually
show that, but the newly added prints would address that)

Alex




On Thu, 13 Nov 2025 at 17:15, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
>
> If the top level directory look new (e.g. doesn't contain a site.conf
> file), then instruct the user on how to choose a different directory if
> they desire. This should help clarify what bitbake-setup is about to do
> and how to change it if desired.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bin/bitbake-setup | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 3a281defa..b54e98ba2 100755
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
> --
> 2.51.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18379): https://lists.openembedded.org/g/bitbake-devel/message/18379
> Mute This Topic: https://lists.openembedded.org/mt/116276734/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

