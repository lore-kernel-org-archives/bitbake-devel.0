Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4717ECCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 13:43:08 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15687.1762436587152923552
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 05:43:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MAPkaIIQ;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88033f09ffeso10830066d6.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762436586; x=1763041386; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWjjtLYhgoe2r/AxoBn4YN6En2GI/CMMz7dehtBBZLY=;
        b=MAPkaIIQjM8jjOOBU0KLuMECJpn6Bp/63Zm0Kdrv6T0d4PjIn8uHFzNy2SgOm8uRST
         TrAcBAlU9gdNmNv/42Hxvos1GLtLe7nl4e640vOaMILrjTYlgArsq+4Inr9bNoiFPy/n
         wMCi8+9Y8UU7f5yacoPJLp57ho9CODV76ndrJtZ2bMyVfVsxiRKtcxGzxdfkmSbGEuT3
         ycRByJMDa4IHqzaOwAFcfFSFqpkTLBAyf+IBQ9RBNLdFCSSGqX9Ay1zeh/GBpki8MEG6
         hXaCwaSfJaxey6TGlMgJv0FWF2eFMW8f9ZyLcGzsHspJrnmykuSByK/c9FJLXQasOb+s
         0u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436586; x=1763041386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWjjtLYhgoe2r/AxoBn4YN6En2GI/CMMz7dehtBBZLY=;
        b=oPKlzS9AmbYjKCTCJ/TX6LZUtKJzquBMIKQGDZQAZEKHJHtXFfeU/GpMKvmXJsdbdy
         0q15LvJ5pIfwfWnZsJe/F/yOVOYCIciGUtDNZK8/BiFFGjqRo7KDB4Y4NUK9eTqivIJv
         iurTCHGq46civo5TIBYNad4uv4Gm178h53u81Gl2oGEUc3jKc8jzDTHneFek0p37REsE
         8eGsmzNC01xiSVQQIBdLztF1fn6a0CGDc2TxJV4qYTa203oXoMyWuhTTNi5BrlHWbCp5
         UIZdgn/BQg8tQLKsvvq8MkL7ASmYVbNHOGWdAV5NniS5iuCOesUoqTcLw++P+TNosHGP
         OOCA==
X-Gm-Message-State: AOJu0YzoAj/+VyJ1l9yh7ex1rz5ClzK+G8zaCkyct8k135dohP6GSMH1
	O8R9RqWz2XpHvCfuDUosZXKZi2qj0qn5hWAZyVSoeqZmlmOSmH5DOTkbVW+VxCY0m2Y3/mb0DLN
	5ZVozIn5AUgpfwuk+1lIzpUxzek8/SsQ=
X-Gm-Gg: ASbGncu1/iEImdrGlUrkx43T679ovKecpH0cT1O6uv1W33bGLM7p5FSFPx6UsFaPYjd
	5PD6zpYzhWXdNnLOjTeiMCfBrWXzLZ+C85dGWIF8DAMV0n8QDjy68T+VoVb+Ln831RcTe6mRMBI
	hzK6QIQwJjdfLhHswWCAJ9ioKW5H8JbTLNf7EkFMPOrCa4lqixTPdjuFXp84sV5u4DaboIOwKT6
	vVlbYA5Ne+JtIbqU8DR1CIV2REH53M+h5+2OF/1f0bgKY/ggH3vgD/XaeB6RIJUiI5XEojaRWxl
	nYAdSQAkt1A89RU1ikDYJR0W7gPHSw==
X-Google-Smtp-Source: AGHT+IEjopTxcEYT6IHbWR3GOfUuypW7gIwzKrOBmembVX9dSUNHjfsSu2B9dbSEUWxnpx2v5sCedqv5xgBx/DaUIfc=
X-Received: by 2002:a05:6214:f27:b0:880:52b8:2f9e with SMTP id
 6a1803df08f44-88071192619mr96194376d6.21.1762436586107; Thu, 06 Nov 2025
 05:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20251106-bitbake-setup-v2-0-2722ef759c35@bootlin.com> <20251106-bitbake-setup-v2-2-2722ef759c35@bootlin.com>
In-Reply-To: <20251106-bitbake-setup-v2-2-2722ef759c35@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 6 Nov 2025 14:42:54 +0100
X-Gm-Features: AWmQ_blqi0tDYCIFtfkQXnYFzGZaiZ6QFZolztzp8ih7bba72rV6jx-qvPGw_Zc
Message-ID: <CANNYZj-v2AOqTdnA+KegBc9zC9TxEuJsM7d8vMEOsCr_wnT_zA@mail.gmail.com>
Subject: Re: [docs] [PATCH v2 2/2] Add bitbake-setup documentation
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 13:43:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18290

On Thu, 6 Nov 2025 at 10:23, Antonin Godard via lists.yoctoproject.org
<antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:

> +      :term:`Generic Configuration` files are stored in :term:`registrie=
s
> +      <Registry>`, and can be listed with the :ref:`ref-bbsetup-command-=
init`
> +      command.

'list' command, not 'init'.

> +The choices made during the bare ``bitbake-setup init`` command can also=
 be
> +passed directly on the command-line, for example::
> +
> +   bitbake-setup init poky-master poky distro/poky-tiny
> +
> +``bitbake-setup`` will stop and ask to make a choice if the above comman=
d does
> +not contain all of the required configurations to complete the sequence =
of
> +choices.

The first argument to 'init' specifies a generic configuration id in
the registry, or a path to the generic configuration file on local
disk, or a http URI which bitbake-setup will use to obtain the generic
configuration file.

(this probably isn't clear, but it's easy to bypass the registry when
the user already has a configuration file locally or on the internet,
and they want to use that file directly, for example if they want to
change something in the file and test that it works, or otherwise have
a workflow that doesn't involve a registry)

> +      ``{THISDIR}`` translates to the parent directory of the current
> +      :term:`Generic Configuration` file.
> +
> +      This is useful when (one or more) configuration files and (one or
> +      more) layers are hosted in the same Git repository, which is clone=
d
> +      and managed independently from bitbake-setup workflows. For exampl=
e::
> +
> +         =E2=94=9C=E2=94=80=E2=94=80 meta-myproject/
> +         =E2=94=94=E2=94=80=E2=94=80 myproject.conf.json

Once THISDIR is replaced one way or another, this should be updated.

Other than that, I'm very happy with this! Thanks!

Alex

