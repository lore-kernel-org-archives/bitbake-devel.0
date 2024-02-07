Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B66C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 19:49:30 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.7851.1707335364527279534
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Feb 2024 11:49:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JWlh7lB1;
 spf=pass (domain: gmail.com, ip: 209.85.167.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5116643c64eso1846179e87.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Feb 2024 11:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707335363; x=1707940163; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eH9aWWacBUmYVnTlaHsBGER3ptUSm9rGNvDXBeYjOhg=;
        b=JWlh7lB13aeX2Ssnk3DElI9cUQFcQvJz1MSgUeQ7MML4DksptgKyr1DKxtr8TLvSRQ
         CaniI2nI9GXsaD+GjSnIb7ygFVEdYJZ8Ws03dw5OMLT+1h9N/t2G0DpTXG8nTAyFXRaI
         yzyg5DTdL+RFCN9U2rBY1yCPVEiw1UmiOCkD9jIs9W/pToa1l6eS5mrzsy7moR67HrYT
         dmNyCVqP+kE6ZGCR5MUvrbAZTDVfuQHZI0eKi/dzTY3MIAzHZ+wXDy3rkC90EAckPlFt
         MKNT90fDJQpi++AsD8cp0cInNI2sNe1dBGhx7f3IWUGINCsEWMr1tMUJikYVockC5RTx
         H69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707335363; x=1707940163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eH9aWWacBUmYVnTlaHsBGER3ptUSm9rGNvDXBeYjOhg=;
        b=VRT+2lfj6lKF/PSpo+j/Flv1QtmTZAi+avCjcar3HQqs4U4Ai6YG+SggFxX3RTlQtB
         rfLCtP4QIuBq79kr/rGkObe9vsfKMfglU4NPG8rBvotMyDMRWN1RyuUeY8Uw8S4w7xCb
         dLkBtQ4OUJmOEQIuNQ5/G9M6Y9iFTbgP6xb3NtbAaepDtR/GH4BU83bVCDkFd3YUpZp+
         uKMZwdgICCvKKzPkQj8n+tqe0De6mMOd/Abjv5ihz033IgEJZQHkdmQQ+dsVxX49hAkh
         msCyeGO3jqbUZ03eVmusxDMsJKSRRG3eDtelP2QtoBzrNBttGv3fz04MFN9Bc/3PZz8i
         v04Q==
X-Gm-Message-State: AOJu0Yxis5cMU4FiLhidAfjx8eeeb/x4tLXrQ8FecCU2DUqKLemeM1lp
	05TAPfgKYxC9ULxPLWY2wnwadRBrUe95c66OKxsionpOUYXaCeDpBFu9xkXLBPB9P8DWwIuRc0F
	r2+oFc3KJJRbAayt59FKZ0W73HV8=
X-Google-Smtp-Source: AGHT+IHQDtZhzmDJ7F9ps/ZzogdWiIDT5jRWn4D0L5dPGky+4/TxWBNNm9aNu+ScZJqcTEPpgqZ0G9ZgwZkvQm+ypX4=
X-Received: by 2002:ac2:5327:0:b0:511:3aad:388a with SMTP id
 f7-20020ac25327000000b005113aad388amr4370771lfh.61.1707335362411; Wed, 07 Feb
 2024 11:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20240207172121.4044574-1-ross.burton@arm.com>
In-Reply-To: <20240207172121.4044574-1-ross.burton@arm.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 7 Feb 2024 20:49:11 +0100
Message-ID: <CANNYZj_vLSgRzA6EE5v0dccF8hs+DD3Gwxfs5ATCVGnszW++Nw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-layers: add show-machines command
To: Ross Burton <ross.burton@arm.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Feb 2024 19:49:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15835

I have to ask. How useful is this really, if it's a bare list of .conf
files with no help for choosing from them?

Sample output :)
https://www.irccloud.com/pastebin/3MmYNuAD/

Should we think of useful metadata to go with this, similar to
templates improvements I posted a few days ago?

Alex

On Wed, 7 Feb 2024 at 18:21, Ross Burton <ross.burton@arm.com> wrote:
>
> From: Ross Burton <ross.burton@arm.com>
>
> Add a show-machines command to list all of the available machines in the
> currently configured layers.
>
> By default it includes the layer name, but for machine-readable uses
> this can be hidden by passing --bare.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  bitbake/lib/bblayers/query.py | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
> index bfc18a75939..3080763abfd 100644
> --- a/bitbake/lib/bblayers/query.py
> +++ b/bitbake/lib/bblayers/query.py
> @@ -10,6 +10,7 @@ import logging
>  import sys
>  import os
>  import re
> +import pathlib
>
>  import bb.utils
>
> @@ -515,6 +516,19 @@ NOTE: .bbappend files can impact the dependencies.
>
>              logger.plain("%s %s %s" % (f, keyword, best_realfn))
>
> +    def do_show_machines(self, args):
> +        """List the machines available in the currently configured layers."""
> +
> +        for layer_dir in self.bblayers:
> +            layer_name = self.get_layer_name(layer_dir)
> +
> +            for p in sorted(pathlib.Path(layer_dir).glob("conf/machine/*.conf")):
> +                if args.bare:
> +                    logger.plain("%s" % (p.stem))
> +                else:
> +                    logger.plain("%s (%s)" % (p.stem, layer_name))
> +
> +
>      def register_commands(self, sp):
>          self.add_command(sp, 'show-layers', self.do_show_layers, parserecipes=False)
>
> @@ -540,3 +554,6 @@ NOTE: .bbappend files can impact the dependencies.
>          parser_show_cross_depends = self.add_command(sp, 'show-cross-depends', self.do_show_cross_depends)
>          parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
>          parser_show_cross_depends.add_argument('-i', '--ignore', help='ignore dependencies on items in the specified layer(s) (split multiple layer names with commas, no spaces)', metavar='LAYERNAME')
> +
> +        parser_show_machines = self.add_command(sp, "show-machines", self.do_show_machines)
> +        parser_show_machines.add_argument('-b', '--bare', help='output just the machine names, not the source layer', action='store_true')
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15833): https://lists.openembedded.org/g/bitbake-devel/message/15833
> Mute This Topic: https://lists.openembedded.org/mt/104222816/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

