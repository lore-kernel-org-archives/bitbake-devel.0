Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6484ACCA471
	for <webhook@archiver.kernel.org>; Fri,  3 Oct 2025 14:59:11 +0000 (UTC)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
 by mx.groups.io with SMTP id smtpd.web11.9775.1759503544618715699
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Oct 2025 07:59:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XP+N+1g1;
 spf=pass (domain: gmail.com, ip: 74.125.224.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63470a6f339so2435650d50.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759503544; x=1760108344; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLC3ESJmPL2/2Cb+c02PbXPsvlkbh7417NG45hUoBvM=;
        b=XP+N+1g1Uhkx9FivTaVMNlh38t80ROeCHrJCxvvmIxVOoyyI8TTiJ0P9WaZ/kV+HAd
         N5eIi+Vt++6BM7QFobzOQ89JRy6SrAVGTJR/Mv3GRmuZFwGofAlgpY3SXVXozvgtbvOH
         1e9v+S+qr9rUtpr5fOEXSpbuKYfSh1/xvuSFXljNEH3cNccvcmGTShGIyB5oJCFjPUZt
         a69pdfK/X1dQPRW9eK+9zpmzd+MTYaJRKhG+ySGBWQ7W3o72jgMAVSSSIkgAndiu6sso
         xn2YRwwG7Q8v9eCgu686ZhG6sV4G6haFhfBX4RFfswP4p4wo/OuPGzik20d6+CgilwPR
         4kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503544; x=1760108344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLC3ESJmPL2/2Cb+c02PbXPsvlkbh7417NG45hUoBvM=;
        b=KpLIZAFqPFom8s/xaB3b79cOm2upS4FAGhibkd+ukj5XbP+GdNiqNScRWjKBlBd1zJ
         +/EqPSOiqive+McRmfR+ARnaAuGfN8jnUQj8HHBKusCDxSEHBiRTKZ9E4+lwPamvSaOy
         c3BFf9rFciO4MrmjarW9VafU2yE6yGGQoP67qet8Mq19GSLQB7cdqUqGAuPxbZslLO27
         6hZ/z83C7sYDmRR9MPvGC2Z8UimDMo7TmpT+6ljSOQ+WQXuaGEtNDp5F4H2hTdbSgyGh
         kThP85JZ4cwsx/H8YN9U0YGzHyx64GWviJqBGZWpLAuwQ2Oh5NLC2d3/Lbzj1xbh5Rjn
         2TfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvhJHoJAmaH6LDbhkpmt6P2OcOf/bV43K1o+Dwhu7R73P5v6wr401QhuI3pPLPy7nqhwfNvqU9KaZfSh0b@lists.openembedded.org
X-Gm-Message-State: AOJu0YwtURBWAhqlBChjfoBJHgewSt9YkvV/bL2KDkTxH1cKL5xG2FvF
	3u/7XzeW1HpkpyLHhphgudYOYd5ioPFdFnjc1HXCz0X2CO/8L3fBj8x0YfcPZkdaPh9vCPruSDD
	f7tlmMIgLv+VUeH78X+5c5oCNxB1WfFw=
X-Gm-Gg: ASbGncuV0tKjD6R7IqUbTvPrbpzTm5Nici/yjhOJ/annG3tg5nL6yaAtwhygHMnjSfS
	MvJfvlD64Z5JbgFpBBsRTysAPWSOI/qpVWsnqGEd6H6ZSUhh8ixEopzC42weGE+HBZXniKiEzXi
	YZNJen5ptJB2wOH7jpCBsM0PaKkKjjpH9X+p4wfrr9X5DL/HOr7pzZ6dBtOSdmB3/Y6dcoKkdS/
	uwSeURR5LqE3XRmax94IGteYM9ckQP9y4o5lxl5sp0+Zw==
X-Google-Smtp-Source: AGHT+IFYndqRUnUd3xMKpHuFTtf3Mk3Zpu411X3AaqjqQrOv4sUV711UeKhQmwlq+R4+jMxG1RG/eyqE2BtTNg70aFg=
X-Received: by 2002:a53:dac5:0:b0:636:da4:cfbb with SMTP id
 956f58d0204a3-63b9a05b469mr2880530d50.12.1759503543470; Fri, 03 Oct 2025
 07:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251002155210.782342-1-yoann.congal@smile.fr> <8bf3234625affeee077859ea356928d64b7116b0.camel@linuxfoundation.org>
In-Reply-To: <8bf3234625affeee077859ea356928d64b7116b0.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 3 Oct 2025 08:58:51 -0600
X-Gm-Features: AS18NWBhMA6Ctcxch05J4vmT5qRalJmHlCMe0ZQJG9QtC4y-MDpa4khEm2YEt5M
Message-ID: <CAJdd5GYroEC5B599SVMpeJH8uvh12jafcR0WE3Cjdz-5NTNbew@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: optionally support
 JSON5 (e.g. comments) format
To: richard.purdie@linuxfoundation.org
Cc: yoann.congal@smile.fr, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 14:59:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18132

On Fri, Oct 3, 2025 at 3:35=E2=80=AFAM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> On Thu, 2025-10-02 at 17:52 +0200, Yoann Congal via lists.openembedded.or=
g wrote:
> > From: Yoann Congal <yoann.congal@smile.fr>
> >
> > One major limitation of JSON files is that comments are not
> > supported.
> > JSON5 (https://json5.org/) is an extension of the current JSON file
> > format that support comments (among other evolutions).
> >
> > This patch adds the support of the JSON5 file format when reading
> > configuration files.
> >
> > Sadly, no JSON5 support exists in Python stdlib, so we have to
> > install a
> > module. I chose https://pypi.org/project/json5/ (but
> > https://pypi.org/project/pyjson5/ may be an alternative).
> >
> > I took care of only patching reading of the config file, the internal
> > JSON files of bitbake-setup are still in classic JSON, which mean
> > that
> > operations that don't need to read the original configuration still
> > work
> > without a json5 module.
> >
> > I put an example of a JSON5 config in
> > default-registry/configurations/poky-master_json5.conf.json
> > This is poky-master.conf.json translated to JSON5 plus some comments.
> >
> > To try this:
> >   python3 -m venv .venv; . .venv/bin/activate # if needed
> >   pip install json5
> >   ./bin/bitbake-setup init default-registry/configurations/poky-
> > master_json5.conf.json poky_json5
>
> We could do something horrible like preprocess the json file and remove
> any lines starting with "//". That works for reading but not for
> writing.

Maybe just a "comment" property that gets ignored then? That's what
JSONschema uses (although it does "@comment"), and then it doesn't
violate any parsing? e.g.

{
  "comment": "This is a comment",
  ...
}

>
> I'm keen to try and keep the external dependencies that bitbake has to
> a minimum. Why? People don't realise the issues they create for
> documentation, container environments, things like build-appliance and
> general ease of use. Yes, you can usually pip install things but it is
> an extra hurdle for users. The websockets requirement for remote
> hashequiv is an example of how an obvious/"trivial" dependency can work
> out to be a pain and a usability issue.
>
> Given that, I'd really prefer to stick to what the python standard
> library supports, which effectively means json at this point.
>
> FWIW I personally really dislike yaml files too, for no particularly
> good reason, I just don't get on with the format.
>
> Cheers,
>
> Richard
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18128): https://lists.openembedded.org/g/bitbake-deve=
l/message/18128
> Mute This Topic: https://lists.openembedded.org/mt/115555001/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

