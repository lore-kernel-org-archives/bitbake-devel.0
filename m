Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EEFF483E5
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 18:48:27 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2329.1774291697775566158
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Mar 2026 11:48:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=S4Fo2JL1;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cfc1aced74so480541785a.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 11:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774291697; cv=none;
        d=google.com; s=arc-20240605;
        b=cgiouv39Gxv5pCgxXimUPGjTG7oGf4aRiUNoGeoVi8yLdDPS8rG61fKLPsYaz541ki
         zmHtletzg2L5SprEs+W0nr6NId5jh3zvj/RJL++ikBcmnFERQvphySHVH9N/iy4ZD5b1
         WUMePEvcoeDa07gGq2Cl28UUQ7+W/WfBdNVgYPO6ORzD1xr6PELsbkwS/wPzj9B5ubiP
         C8m+rV4iTOdJ1c7rWlh+uhfeslEO8fo6l4CiTURah1Ffr3tYJ8/eplL+gIfNUj9u/by1
         ZjHRFcsGFacR6QYyU2W7Zk+OLhTZGDHxiC9e3nQ7scOji/mMozg0Pn4HqoBftMIVInLm
         wZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cGI52ibGWmF7BswJ10pyt75KoOvgNPjZfFZFSg/Gl4U=;
        fh=z79r7devTYIWKIIJnNEQrp8fu91t3iK8WPc0gYxDyHM=;
        b=GhF8Ztm01MU2ATwFAlJ/s9JFeHW40FtP6AFWaQxpt2nYAt61L5A6OG8qYzNn8CvtnY
         ff25mnQVWlWUZsbqbIkm/KXD7ImZhHGhRDyQRHQz2PNo9NdMnbjpu4XXA/SdccoT91c+
         Kk/jqkusr/v7N8kj+80R/ZN7C7Vt+GTK0vJqeTwbyEex3lN3rtfq2top26MMNMV29FW4
         iYDgSo/lxbX9rbcCAgo9ANwQDbfsRLZOeb7fm1YLySiqSLnCeNBYWOH31BMxvtqLDYCJ
         4uSuxaflkyGRQs81kaW3Uqg/iBEiStwjkLQzzojLxiTCrSerF7j3J2231J6EesPX9RGy
         LL4A==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774291697; x=1774896497; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cGI52ibGWmF7BswJ10pyt75KoOvgNPjZfFZFSg/Gl4U=;
        b=S4Fo2JL17iiPnc/0E6U0L/C9n01nnj8/qtfrBRnH5648j44mjcGf1HIftAcHqCTntH
         TmkAyde3h8TUSIucZT13oplJ9XrzXSibkDkyq9dnBz3rGDioVKaNbceaISoRyfk51wGg
         ZMvE+Why0COB+Sw1v4dM6viXc/jI7Ne4H0akzBBq6hwCzd+yiEe1bqSR9rv1xvFAxNoW
         ViPz07xfkNMHT+JOPWV/sf5VWpgXNZ+jvFRyBd58C98MQJvVGaoY/+lnxTiqcptsg7bF
         B9DiVqpaC3BEFe7ArUO0eLDUxPIg2J/VcK5CCp/pelTgC2dvsYTzBwk1tCauACWjf7CO
         WNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291697; x=1774896497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGI52ibGWmF7BswJ10pyt75KoOvgNPjZfFZFSg/Gl4U=;
        b=GwLI3bwB92C7Klyws6R5kDKOyP7C/BxWMD+OrEN1DhgodDQtQplnIgKKj64R0NDo7r
         8gktgPW6NIhcH029QwQfrLq+oMt+uKqAnpeYWe0Dp9bFXOvfJda+eIYpPmtuH+ja9sy7
         w035hwgQeyeBzK0JAa+cwfHPzoOKvIIKhM/eEKevwHOGPXBgLAgSQwwnSjjDeHdU5e7T
         q8itLo4ipZO4nxY/lAbSLl68NvFY00gvj/WfQMYxb/T9YfY+XAAVEP7KijvuoSHCHsgw
         Z6E5O1tCpoIfg0GtIa66d3MbXPEO5k0l/7teEOpG/PQPUXgDD8ik4WAAcjrb0LbHbTzt
         C+qQ==
X-Gm-Message-State: AOJu0YySvtd1HAdkU6f6Ar58SHG0NL91FOX2mw2bN5XPOJX7ZX9uTKoJ
	083aDRlYgxN4Ow1Vmfifwm7mly5wZjF3dQsaWwkI7AgtFn3D6nxJWAk28Hev9gd18ioWHgxtu9p
	gEbVfKfJ5a/W0lwYnUsqUuDub2tCe9zw=
X-Gm-Gg: ATEYQzxWUu0sYE9FS/DLN0UkyPJA6go5Z1Qul2obK50Udmx0iK95kvID2zikizi/Nmk
	zLPmyP7AlDTxNgcnwG4AhAtnsjt4Xkc8EN4AoJSvpgwt5NPca81q85P0PE8Z62/Ette7RIev+Vo
	UIFDTkQLFwCncI9r33v6RMHpfwe7kouLLnWqbVyT/chxIP3Jsd+LAWFfP0qQO8A4sbwpKmOjCfH
	KXZ2bB/k6IeceIhuq2IdS71J7XXqK2rOWi2uJim24rEr7LatvCLIc0MttWdE/EUopPtgyzQBv9U
	K3Erv5dgKupef7SpRYzg3E+92VHBvr8FwAnHjDGqZw==
X-Received: by 2002:a05:620a:4588:b0:8cf:ebeb:c284 with SMTP id
 af79cd13be357-8cfebebc5d4mr465233385a.54.1774291696789; Mon, 23 Mar 2026
 11:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260322193440.870120-1-adrian.freihofer@siemens.com> <20260322193440.870120-7-adrian.freihofer@siemens.com>
In-Reply-To: <20260322193440.870120-7-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 23 Mar 2026 19:48:03 +0100
X-Gm-Features: AQROBzDegWJKiOxXWSly7GyUCLhe4dzfTKVZBvI2M_mpM6CSM3IdykaKES_eoi4
Message-ID: <CANNYZj9DLHBhbKuaExm8+Do=HBh-g4Vyu0ASVkDPYb_8ikW5uA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 6/9] bitbake-setup: generate config files
 for VSCode
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Mar 2026 18:48:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19211

On Sun, 22 Mar 2026 at 20:35, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
> -def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf):
> +def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf, init_vscode=False):

....

>      write_upstream_config(confdir, upstream_config)
> -    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
> +    bitbake_builddir, init_script = update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes", init_vscode=args.init_vscode)
> +
> +    if args.init_vscode:
> +        configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
>
>      bb.event.remove("bb.build.TaskProgress", None)
>
> @@ -773,8 +932,10 @@ def build_status(top_dir, settings, args, d, update=False):
>      if config_diff:
>          logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
>          if update:
> -            update_build(new_upstream_config, confdir, setupdir, layerdir, d,
> -                         update_bb_conf=args.update_bb_conf)
> +            bitbake_builddir, init_script = update_build(new_upstream_config, confdir, setupdir, layerdir, d,
> +                         update_bb_conf=args.update_bb_conf, init_vscode=args.init_vscode)
> +            if args.init_vscode:
> +                configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
>          else:
>              bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
>          return
> @@ -782,11 +943,16 @@ def build_status(top_dir, settings, args, d, update=False):
>      layer_config = merge_overrides_into_sources(current_upstream_config["data"]["sources"], current_upstream_config["source-overrides"]["sources"])
>      if are_layers_changed(layer_config, layerdir, d):
>          if update:
> -            update_build(current_upstream_config, confdir, setupdir, layerdir,
> -                         d, update_bb_conf=args.update_bb_conf)
> +            bitbake_builddir, init_script = update_build(current_upstream_config, confdir, setupdir, layerdir,
> +                         d, update_bb_conf=args.update_bb_conf, init_vscode=args.init_vscode)
> +            if args.init_vscode:
> +                configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
>          return
>
>      logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
> +    if update and args.init_vscode:
> +        configure_vscode(setupdir, layerdir, os.path.join(setupdir, "build"),
> +                         os.path.join(setupdir, "build", "init-build-env"))

This last call to configure_vscode isn't consistent with the rest of
them which rely on data from update_build(); this one is doing
'guessing'. I guess the intent is to force configure_vscode() with an
'update --init-vscode' even when nothing has changed in the
configuration, but I'd suggest this is taken out for now and dealt
with separately. Perhaps we can add a separate command: 'bitbake-setup
configure-vscode'.

If this is done, then a *much* simpler approach would be to run
configure_vscode() inside setup_bitbake_build(), rather than at much
higher levels? That would not require passing additional data around,
and ensuring every call to update_build() must be followed by
configure_vscode().

Alex

