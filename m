Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BACF3187
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 09:54:35 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3237.1763546069401549156
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 01:54:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CYK9zyjq;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee158187aaso36461711cf.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 01:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763546068; x=1764150868; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLqksiy+YcUDaog6dYcBGvnR6/0kUfEOwP6HFF/r65w=;
        b=CYK9zyjq2U8eMbsGNyF7tYNaJsC9hx5zZ2NbObKsEj2JEoMreWCmstSboOdbj1ewNN
         KAt16KBOKy6/7I2OgyKpaot6Yt887o6MUXBhgTyuKJYViAcpT9aERgkp+jEUV0qNOugt
         vr3ZZDjGTkqKs9FLIvP/icUH6zSJzT5TRW5rJ9OBtJmT958mproUx+6EqR/HUK4SL6Bo
         Nj+QW1wYki1jK0bDVbprtou53GOHX4eRkpPB2gD/YHaCvxIxfmjD/063A2HvKOcpuHmb
         cdiskDEzSGvUH2GEzAtCl7HCFTqkyV9hXpbDQ0JOYKl/THlnW8yFB8OEcj5IAXeBZTuk
         Ng4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763546068; x=1764150868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLqksiy+YcUDaog6dYcBGvnR6/0kUfEOwP6HFF/r65w=;
        b=Yoz0oUJ+xper7ty8RGHc1vIwNN/x1myrThmUNFXD6I68I4iUeO2kn3j4IDH/HQPrZk
         W98oCFHBDHasGmyCPyREKgc57Q8GXZNuo6dbmEsP1rUuifuXju3kypltCAFvs6vKwwKx
         W0nuLLFEVlWBuV0nl4XnB8/trFkQlQ3vGszJyuqQ8WD+Km/A58HUV9wXtuuycupNnEga
         di5CVRUOEte9QxYwGolpuginpv/BehOGoSBtSFMORibkG+gKp8zM2RhXRYh+TDpfqvLe
         sZwd17LyKHVexg5CdqpQu7PZ4Lpv+F0nMMF6s4QA1um2bsSzCbSzmhx1EPdwu0fG0wUs
         zxsQ==
X-Gm-Message-State: AOJu0Yzex+r9UoaJQdhebKS/vOpynaUVn+RNYheUhH3GALxY3xKi1oYe
	vqp+tDmnx444gnf4FM2NlZh0PxITNqy5PqxajztOggzraqdOM6dYYNLkMrJhjG7GIkh2gD0uKku
	oD8m55BdxJXFSfG8nSlDut1bjVDw9rwM=
X-Gm-Gg: ASbGncuAcQTAD4tMPHjHivY8nj8mmxEbGBi1nzwZ9gp7QNiXSsoUKMaC1NXukAtyxH2
	s1gM/jvVoWrww4yQdFCdu2mKpkSQ0EXRl6Gtps7ocpeN1AqZRKgSVb/W0Qk7uGf7z7VLclyshSs
	5xISac/C7VhynDUCaFK8zAnv36L01ogp88NSG5nTzqL0A+poNwy4bh323EBKabiRNcQtDB6aV5J
	mUjXO3VgMuZZgcYrCNbliH0nsKa6IGijCNcYP0LMFBECghN/PEU8Ahjqb4sYPydUZ4H/sP19GBw
	wn6a
X-Google-Smtp-Source: AGHT+IESqCEDqZ8YZOgxRyAOE6beibR8vtcjqc1fLQLSiBMZHmUHei72Fp+pPMP4vX+uFMLOoep9CK+kVut0AdxAVnE=
X-Received: by 2002:ac8:5856:0:b0:4ee:1fe2:3d76 with SMTP id
 d75a77b69052e-4ee40039baemr22243371cf.60.1763546068403; Wed, 19 Nov 2025
 01:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20251113161524.4068231-1-JPEWhacker@gmail.com> <20251117194805.2322020-1-JPEWhacker@gmail.com>
In-Reply-To: <20251117194805.2322020-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Nov 2025 10:54:16 +0100
X-Gm-Features: AWmQ_bnYRB8wk-JinR4o-vqhgoDJ6HyQBe6FhpPBDRBNnAl0AhHYmT1g919HQmc
Message-ID: <CANNYZj_u66zunz_b8YR9A0iMU++pna8vpxVxp_RX9-2gTOBXtw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] bitbake-setup: Tell the user what to do
 if they don't like the top dir
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 09:54:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18453

On Mon, 17 Nov 2025 at 20:48, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
> -        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
> +        print(f'{top_dir} looks like a new top directory. If you would like to use a different directory, answer "n" below and either:')
> +        print('\t1) Pass one or more options to bitbake-setup change the top level directory:')
> +        print('\t\tbitbake-setup --setting default top-dir-prefix <PATH> ...')
> +        print('\t\tbitbake-setup --setting default top-dir-name <NAME> ...')
> +        print('\t2) Change the default bitbake-setup configuration with:')
> +        print('\t\tbitbake-setup settings set default top-level-prefix <PATH>')
> +        print('\t\tbitbake-setup settings set default top-level-name <NAME>')

I'm going to slightly tweak this: changing the default should come
first, and 'Pass one or more options to bitbake-setup change the top
level directory' is not good grammar.

Alex

