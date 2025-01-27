Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F01C02188
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 15:45:01 +0000 (UTC)
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
 by mx.groups.io with SMTP id smtpd.web11.54624.1737992693485405364
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 07:44:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T7d8JAx9;
 spf=pass (domain: gmail.com, ip: 209.85.214.195, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-216281bc30fso1665195ad.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737992693; x=1738597493; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjFr9/+15/IPGPpZ1ZzKy+6lQKx2oycoImPgxpGIEUo=;
        b=T7d8JAx9CcLIevcSPFl3k2DLm9DJh4CP2qZIznlPaCMFw4ajZUchlkVL5pB+ki4e/u
         0iqY+0o1Q4yHI8e2dHKIXDR4Z7qScEmhnPw2XDKAmzq9r9SNe1eDYBg5/Odt/S962DdY
         FBWaoa1GX7PKobuQJIGeRk5teV+UdRCxCQMJe/1suZCMc/xuLnSx5s00s1IqJZjcr183
         H7zZOKnBCbTAWxsoFryB4NKKqWUjdAmeJjMg8KdIfWnHm4fXifg4qOou5bp3/fklxvKE
         jvq/igRHt2S6bXE2InQXG676nGXsVuEC+Zwrn4RwpZS8SXg8eywrdGfTsx0Vb3rwkG91
         OCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737992693; x=1738597493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjFr9/+15/IPGPpZ1ZzKy+6lQKx2oycoImPgxpGIEUo=;
        b=tzXXGEhVunnMjqd9966h1E8xVu3VXPP7FnUdri3/Q1ngLy3Up2bdTHZ7Pq4ZLkob3d
         K4wGVaXfJoeNBXKmgDTw+0tAGfCpAs4XHffIkdr4T4v00g+Ozoy3K7mrEW8N81TZeUXZ
         TD3bkLXlqTDAUZvS66UbsTbZLTuP024Iu+Cjeq1PCmJA46qlyK+yHnCLj3u6NlDOeCQf
         2FpmLsbTDCsrzNV+preTIemjdG1p8FgmIh32sdiZwHAIpqm8+cB/iGk5D2ISbRkEigh5
         hu+SfbSvUcNvIKpAPZdOzPXgvtDiwil7EFG4RTv9RjNBUbHtH5JGXlvzfxH7V1oRzMG6
         fdjw==
X-Gm-Message-State: AOJu0YyNB3KHs4L6o4LmKRLtYmlIshr/drftxXJyqYoM+QNoF6v63Pyi
	HbVULXhFZ8Xq7LODWjg+3sv04PxUQtLn2xdEt1AowJiQ1PD2MKR4+5sPO4/TXzH5bGQEZnPVtUC
	/dfDbOF4GEcsXh622yFz1i8li3Vc=
X-Gm-Gg: ASbGncuYoz4S0t1gFAGjXVCXkyqkWCILduO9chIQeDJfH5S3KVS2G4C1EBORSTldv5z
	uGJRFNbfKSPRhRU640+TgWKCFJv9qrH9stC1aq7qDYxolRjoMmSUp1kVmfzCCMw==
X-Google-Smtp-Source: AGHT+IEaUhNfz4Kv0I7ZNiqd6gqDZJ+TQslbw2U4Z6zpttE0XEagLNAKop7loH3+b4nkEyFytVPq8PhNNWxuLUQDfcA=
X-Received: by 2002:a17:902:da8b:b0:215:9642:4d7a with SMTP id
 d9443c01a7336-21c34cc9574mr608123795ad.0.1737992692794; Mon, 27 Jan 2025
 07:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20250127142918.163-1-eric.meyers@arthrex.com> <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
In-Reply-To: <CANNYZj-d4EXpM30v+DgY6p=3NjVZG7ThKTBTPSGX70CXh+rjPA@mail.gmail.com>
From: Eric Meyers <eric.meyers15310@gmail.com>
Date: Mon, 27 Jan 2025 09:45:01 -0600
X-Gm-Features: AWEUYZklYJqwJNmlG30QosCesBPpSfyewaemzgyH6GN294W7JWgLrBL2BJ2DkJY
Message-ID: <CA+cKJ+HEK9d-tvf-Srz=NwHCrkyikb-ws1u8Bn9kD--EiDF5zQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] NPM/NPM Shrinkwrap Basic
 Authentication Credential Support:
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	"eric.meyers@arthrex.com" <eric.meyers@arthrex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 15:45:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17104

On Mon, Jan 27, 2025 at 8:39=E2=80=AFAM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Mon, 27 Jan 2025 at 15:29, eric.meyers15310 via
> lists.openembedded.org
> <eric.meyers15310=3Dgmail.com@lists.openembedded.org> wrote:
> > Changes in this commit include:
> > - npm fetcher changes:
> >     - Add =E2=80=9Cusername=3D=E2=80=9D, =E2=80=9Cpassword=3D=E2=80=9D,=
 and =E2=80=9Cnamespace=3D=E2=80=9D parameters to =E2=80=9Cnpm://=E2=80=9D =
SRC_URI
> >         - These parameters will be used to create a =E2=80=9Cnpmrc=E2=
=80=9D file that is passed into the NpmEnvironment object - used for authen=
tication when connecting to NPM registry
>
> You need to create the file with a separate step, then point the
> fetcher or the underlying executable to use it. We do not allow
> credentials in recipes or other metadata that gets committed to a
> layer repo. It's not different from placing ssh keys or http passwords
> into respective files in $HOME.
>
> Alex

Are you suggesting that instead of username=3D and password=3D parameters
in the npm/npmsw SRC_URI, it should be an "npmrc" parameter that
effectively the user can point to the location of their .npmrc file
for authentication on an NPM registry? Then, within a user's
associated recipe, they would need to create the npmrc file in a
do_fetch:prepend() step that that corresponds to the path passed into
the SRC_URI?

That seems like it'd be fine to retrieve the initial "npm view" output
(https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/npm.py#n186),
which the fetcher uses to resolve the tarball url. But then when
subsequently passing the tarball url into the wget fetcher
(https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/npm.py#n238),
the wget SRC_URI will need to provide a username/password for basic
authentication to access the artifact - that's kinda where I'm stuck
and thought a "username=3D" and "password=3D" parameter were needed for
the npm fetcher similar to the "user=3D" and "pswd=3D" parameters
available in the wget fetcher.

Please correct me if my understanding is wrong, I've been agonizing
over this for a few weeks now and couldn't think of a better/more
concise solution here, but may be overthinking things at this point.

