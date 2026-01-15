Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F72AD31A0A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:00:41 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30950.1768464036313632209
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 00:00:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=M4iIHfNj;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88059c28da1so5017186d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768464035; x=1769068835; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LjL8nxf0THDl0w/m8nY/4zXs6+gZqlg7lYl6W+IdJLU=;
        b=M4iIHfNjVl5RtJRH3+CWm1YO9nBVKq8OjU9LcE/CznHPVK02odkDbRxwg6pMBr9cN6
         6cfb3CU4QdPTi0i1cozYuvFOc7dkzR5jyO0De3gn1W1UvUpS+HufkqWcYI2zzWZcjjwI
         BxwFS1VBR2LpLR743kU2DBdxih3Wl8rPPQ8xRO9jbN2qkY7w1dHOy+qJYQCgyHsF1KT1
         lr/hhRFKsa8zbWO9/udPn/ljIqMQNbf80n2GtJ2fUMzmd9aP1YbkLnOPWcX40k/6YTLo
         VLf1y2gya6ijgmV9O+6U2bgbh0ezFWPMLKY6gTZo9/GnZe3cnWByOtcrzXwS/dDtYHnn
         IhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768464035; x=1769068835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjL8nxf0THDl0w/m8nY/4zXs6+gZqlg7lYl6W+IdJLU=;
        b=N4LDA4hKymH1w/UEKXXkYcm1XbiKSqWYEilNkNAFVeJXFZBLlkO7U9t2HzF8QfNJpQ
         BBtWh/BKZwevaWuHsEcurDRADsiFtVrrv4DXX7NPfn3KfE4xnhCPI0ezDEaqSSLtJQgo
         oIwKPnaOzB4vKm/ybRcPxXR5La3f/ppLRUl+Sqt1kA9bmRQwHLZacfbr+KKwxZmy3HzZ
         Upw2iUmXXZ/daSHa3NZfVEcgyHShsmRMRUUWiVOp4UsfgaR7TXyIgVCROAZn7/rHVQaV
         XTYA2Agl/Ut0kPMvWR1WpFDU1Ya9QDfi0/cBqTMEdD4G0e/02NG9M2azSm0dM0DsTWd3
         4oew==
X-Forwarded-Encrypted: i=1; AJvYcCW1ki2nbk+BDY9BMU92L9tnj9utFN2ZsMstLY8dOLhf0fDncHnjfgtv6w5K2m4uVopX7KsFpQp0W85tuQoT@lists.openembedded.org
X-Gm-Message-State: AOJu0YypCR/3zpq56EOxpeN7CCTrkbRf56iIZDZ1C8tWADX9ORGtrL2l
	znv2TtCOmWA8ZWXdqtMTfrciM12TpoVnR7w+w9QxM9bl/sLyAJsR8gUBdmSpP4zrqB2NE+XCXXL
	gMGtCLeWygQ2haN0KSSYzDETXAeMM1kZqtp198mk=
X-Gm-Gg: AY/fxX5/bHupKfp9Hte6sRWyyzDsm3G23PSQaOQ9XEeAdjsVoLCAkgmRI2XXzMaExz/
	auZDBGhTP3W92eKrT/Ey2nQ1nQO3MzdfoI/E8xBJKufPmr4Upz5eSuZeK2sgGW1h/Wtne7EOhih
	L0+qxYiIPcm+quW/ZhOD9YYnwwKNEQuf2sUQmxooFVPlXZ2IRxlIw2Shf0tx+1Zr8Ma7Of3YHWp
	MLzxi46ecK2BtsVx6vI5RNz4PKj9Hj7hRk2xt5vfDhG9hXMkADIkQl6k50LVhUSeaHCZ9P6
X-Received: by 2002:a05:6214:19e6:b0:87c:2360:d404 with SMTP id
 6a1803df08f44-89275ad83b3mr72225756d6.7.1768464035001; Thu, 15 Jan 2026
 00:00:35 -0800 (PST)
MIME-Version: 1.0
References: <CAP9ODKowQqn-VuqaT1w3cXCWGfBeMtG2rHR9HXBFqxSfttAk4Q@mail.gmail.com>
 <CANNYZj_ERuqEY6w49NRKO5OsBr-HqG8hDSHiAB-e55LVhZq=cQ@mail.gmail.com> <CA+HEL78C8y7fgiw1GVkGovT-rEBObyqF1+eRy62suE-wHHW-og@mail.gmail.com>
In-Reply-To: <CA+HEL78C8y7fgiw1GVkGovT-rEBObyqF1+eRy62suE-wHHW-og@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 15 Jan 2026 09:00:23 +0100
X-Gm-Features: AZwV_QjjzbQx2oa4QWBYNpWvDrdlFo_WPmHTfGFoxbWpU1yxgmt-leD9LXm895A
Message-ID: <CANNYZj9yJrsWAnjFMSXZbZJGoqMjC9Hc5cHg7MtX9qRiEFGQqw@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] bitbake-setup: Documentation terminology
 and tooling suggestions
To: Daiane Angolini <daiane.angolini@foundries.io>
Cc: otavio.salvador@ossystems.com.br, bitbake-devel@lists.openembedded.org, 
	Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 08:00:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18765

On Wed, 14 Jan 2026 at 18:43, Daiane Angolini
<daiane.angolini@foundries.io> wrote:
> Let me frase this in another way. My project has all and every
> configuration needed into a distro conf file. I want to create a
> .conf.json to share. Can I create one file without any
> variant/fragment/bitbake configuration?

You still need to specify in the json what layers need to be included
into a bitbake configuration, and what distro and what machine needs
to be selected, if you want bitbake-setup to produce a functional
build where bitbake can run. If you don't do that, bitbake will
immediately tell that a machine isn't set, or that there are no layers
or some such error.

So you need to define at least one top level variant thusly:

    "bitbake-setup": {
        "configurations": [
        {
            "name": "poky how it used to be"
            "bb-layers":
["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
            "oe-fragments": ["machine/qemux86-64", "distro/poky"]
        }
        ]
    }

In another message there's a question of what would be the equivalent of:

git clone <poky> -b LTS
source oe-init-build-env
bitbake <image>

The above is the equivalent. bitbake-setup will not ask any questions
about choosing something, because there is only one choice.

I appreciate the standard configs are quite a bit more complex than
that, and a 'simple' example might've been helpful, but we want to
give users a range of options rather than impose very specific
selections on them as was done previously.

> Or, Why is the variant "poky" empty? [1]

There's a "poky-with-sstate" variant next to it. Both variants are
nested in a higher level variant that sets common configuration for
both of them. One is supposed to use that common configuration without
change, the other adds the sstate enabling fragment. Think of it as a
tree of variants. You can define sub-variants with as much nesting as
you want. For example if you have a range of target machines, they
could all share a common configuration, and then each would add a
specific machine fragment.

> Or, why is there "two pokys" for me to choose?
>
> ```
> Available configurations:
> 1. poky-master  Poky - The Yocto Project testing distribution
> configurations and hardware test platforms
>
> Available bitbake configurations:
> 1. poky Poky - The Yocto Project testing distribution
> ```
> from the iterative `bitbake-setup init` output, from [2]

Please do not trim the output because that gives a misleading
impression that the same question is being asked.

The first question is about whether you want poky (the reference
testing distro) or a basic openembedded build, and which release of
either (master, or whinlatter, or soon there will be the upcoming LTS
option there as well) you prefer:

Available configurations:
1. oe-nodistro-master    OpenEmbedded - 'nodistro' basic configuration
2. oe-nodistro-whinlatter    OpenEmbedded - 'nodistro' basic
configuration, release 5.3 'whinlatter' (supported until 2026-05-31)
3. poky-master    Poky - The Yocto Project testing distribution
configurations and hardware test platforms
4. poky-whinlatter    Poky - The Yocto Project testing distribution
configurations and hardware test platforms, release 5.3 'whinlatter'
(supported until 2026-05-31)

Assuming you chose poky, he second question is about whether you want
to enable pre-build sstate from yocto infrastructure to accelerate
your builds if your machine isn't very powerful:

Available bitbake configurations:
1. poky    Poky - The Yocto Project testing distribution
2. poky-with-sstate    Poky - The Yocto Project testing distribution
with internet sstate acceleration. Use with caution as it requires a
completely robust local network with sufficient bandwidth.

We could probably improve the descriptions and suggestions in these,
but the intents of these choices are hopefully more clear now.

> And when I created the draft `conf.json` for meta-freescale I realized
> I could just choose none of the variants (because the base is the
> DISTRO and I might want only that)

You still need to create one top level variant with that distro name
specified in it, and the list of layers to enable, and perhaps a
target machine.

> I'm not sure it makes sense, please help me understand

Hopefully this is a bit more clear now.

Alex

