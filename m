Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91865D41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 11:10:34 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46189.1765797028227967293
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 03:10:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CVdiDOAj;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a288811a4so15296316d6.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 03:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765797027; x=1766401827; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vvu7tUeJZUB0Ga9pfAiB201KBILb3UFaw67l/bxLWLc=;
        b=CVdiDOAjMJsu9POf3DqTYKq10P3FGzVDQWkUwFDyPDyxo6P3HR7GCHk5G63l2gu1Wr
         hrew7T6Rk2CcGChvPmzUxFArWVGCf1SCkJpuBDsobXObFIaco5Qcpfr37RWDtf0u6X1X
         2zUHKcvixw311ctoMw+bPSjBOrhWCJbwbwOR7NB2oT822W2y7lLEJWW87FIffqOtpMMo
         T39ViApglSNrk9em0vpwrnzz48H3ITQd6XCTEBMMf7O8HV6BzRZxLRyw1hxv/HvhI0qU
         0UsWpo/K1vuZ+wpUbolo99L4akkqQfnOl55QslO6oF6jv+H+BAtRACd32ja/O6JyCjXt
         3ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765797027; x=1766401827;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvu7tUeJZUB0Ga9pfAiB201KBILb3UFaw67l/bxLWLc=;
        b=WAHr1Cfohq+g1wgFxb28PmYGdjCXPbqb/NPGs713oc0BLhTGueJvhGGBIs7++4QHlw
         paZfhDPH/jn8CKJ10IREPKbCjEihJlbFqKPF0LDqc/Hybi42ZDmEWAdr5OPqMB2DsD24
         CSz+agAAk2NV1/ZwxmsmUrnXjdqOVoPWeBEXlVhfj21qA278WWQ8dCzF5VoEn0BgZNIw
         zuBVb24zVmqAMpgUR4OPZ+zQKH5NX2mVXGZarbQL4eG7CO8WpyB0fCVHVZRGDF5vqgyC
         DAsgF37E3M468I/rgI5iTQQLUalZRaPyo2AiCvcIXIlm9mwoSZdpYjBmfGKhiPoRGpty
         dMZw==
X-Gm-Message-State: AOJu0YyXkMXJwM1om7IAOIO7I1ldyXMyeo3vMGBOc3I1Seh3ufxpsJbU
	kIYMuqNz8RYBuTXJUQ3O+yxAfnDrXDfZ21LWCXRRuhU9kUqt3Nsyq4FfOE4rB9N5K6pr3mvUYi7
	xu4cmw7uus+bvyWUTK00ZqEVQy5Y6jU8=
X-Gm-Gg: AY/fxX7i/CCjpD5AJbE8OlJM7IyATTTNiVXDu25XMlLceWZUUqQNxgJbTB7wJ03HRvf
	9dRCW33nIChOf8Wbx2PnOWVGcG9JYAghMx6K4ytg+wA9lJ/Cs7wxTQa0Cq+Ued6wI+vWR9bu09m
	Yvhl/KzXj9WOcZh08sUap1PWCV0xVgucaermFkOrMuxTPYZ76XLSE4EBji6iYNCluswZ6jDgZhp
	YNjOZqJYyUCoNiISKNx1IKtyL9PRjiWv/sdeikv6trAxCpCIWtGUisBB6Uk03iA6jfLGJVMWXso
	SkDOEDvgwJc4AwOo8uVzBleiN6X6mg==
X-Google-Smtp-Source: AGHT+IHQkW8kJU/x+bJ4j/F/7ihbHkkspvV8mdxyx3BJ6Zyz7evkaobRytrOd5RB1ZJBRSMN+RW9iBO6XmIbWihAMdI=
X-Received: by 2002:ad4:5c48:0:b0:888:1e72:afb5 with SMTP id
 6a1803df08f44-8887e1e98a0mr179757046d6.2.1765797027211; Mon, 15 Dec 2025
 03:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20251215103256.902711-1-corentin.guillevic@smile.fr> <20251215103256.902711-2-corentin.guillevic@smile.fr>
In-Reply-To: <20251215103256.902711-2-corentin.guillevic@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Dec 2025 12:10:16 +0100
X-Gm-Features: AQt7F2pKECpT5JjoGHpl5Dl_szP5I8Pj1PHZ80K6AYOr3tFW6SFdQE0SsTzbhNo
Message-ID: <CANNYZj99BQNDEF3FmuUL6MrET_Qm7TGDv9XAvV4c-fOrOxdECw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 2/3] layers.schema.json: support 'uri'
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 11:10:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18588

On Mon, 15 Dec 2025 at 11:33, Corentin Guillevic via
lists.openembedded.org
<corentin.guillevic=smile.fr@lists.openembedded.org> wrote:
> +                                    "uri": {
> +                                        "description": "Shorcut for the URI",
> +                                        "type": "string"
> +                                    },

This should be a little bit more descriptive (and it has a typo):
"Specifies the git URI, can be used instead of the more elaborate
'remotes' property when there is only a single URI".

Also, updates to the schema need updates to the
doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst as
well.

Alex

