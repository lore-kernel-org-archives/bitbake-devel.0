Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B29CEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 19:06:05 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17711.1763406357053018876
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 11:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CryQqv0a;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8823cde292eso54482096d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763406356; x=1764011156; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RrOWT9L1Yi2mmJpx/jUfwJWWOh8YeL6sZ5BJYLOSRAU=;
        b=CryQqv0aF1bicTlhTzzJ26hzMampV+n9bERtzds0GnMGQ7iLjFTnoYfX4tSJulNkxh
         Kq3e3klrS0lwXR2QVTR3MMYmXbdThZXWc+IyezLySaQtVXRA+xyFUdAAfTwsN8Mkmncl
         nL+CSfqiK1FgrxXSxOEt8aKf1NpNjOemfaQxmCg5bwVw4vvDFvLk42RSVHYaNHXVISn5
         jlSiY8stSfS/LPS5/tU3mpUEOSfcWdJQfdt+mvpfE5bfhsLUyhEw5mLNdXo9QCe+6/hL
         +VvprnAb61NcLGEfzmiK9C1YsdR59SpDFd09L+yEST6z7/FNBJAag7/fFne4+lyil8AJ
         g69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406356; x=1764011156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrOWT9L1Yi2mmJpx/jUfwJWWOh8YeL6sZ5BJYLOSRAU=;
        b=mP8ZyejsOYhCALq73oE6AIZeNQTRRwpPIEIX2qLXIVUh556qF+d65nVldd6rJoJcbb
         rMreDkWQUBBXXno/7rr/dG3Pwd6wnSAKEXodpFtqSxwZYjh5X8ZYLe7k0yufAiZpu1vE
         UxoE51nmD2XdSjivVj+g75pYKSGTw/RfXDO2GEe7haBSE0PFb4qjoMoIkN7iyg6OVFyX
         nNHPkhRzlwmszGmm5H0Ll1KimqJczx3m+0SQikwj3CNeMW7k2Pq7EeH3MsZsDpJuPI6N
         66Hl1zQcuK+iGLOePzES4NjrXjenRXnO7RuEHYD08Ol0WSZxAFj8HVXkgZCsJgK9jkKj
         KLNA==
X-Gm-Message-State: AOJu0YylWxLrNfgssAzNrg4oKIApSVoBcB6fg7L2bm9qdWA5vRYuCu6U
	7EsN/F2skyxhFG8Il0gSoGHLv+qd2DSXDN4vhGt99lul4mhwdamn3+CmlOfu2kCiY1Mnh/+vhMD
	DPOcJbEEvq/rvK8elBsELXNKP/MBQTA8=
X-Gm-Gg: ASbGncs6j7uNjZo6/w9d3KL7SegHWRbKVjlQdOKAyx87aLgg/W1qKEp+0Yac3b/2hcg
	fr4kSwxa8dRcljADUTUV50uwDRtOEuFW0WwxKtwU8cnZkweTFNKQ7Mt7ZQUZjFLMpKnwrssJ/7M
	a/eF0awOk/DWZcOFlCcM3VSHOwPN1D64p93wTMYcQfIc2wgQwV5y/I66y51KHLuuRs7jzpKPMIZ
	jKowpzwlUcKInYmMX602GO7ubbbmsocf5W+NJOKZPnOzQCvkaceK/z/XJcYo/aq5GLnmKwkNuht
	q8Ux
X-Google-Smtp-Source: AGHT+IGq3ZtQwIM6YJsBZ9F+6s+017o4XItjE4RkectmhNH95ka3jxYGCq4vihDzV2+KNFT+pmHPMKQzCftK1t9KTkU=
X-Received: by 2002:a05:6214:1ccf:b0:880:47d8:dec7 with SMTP id
 6a1803df08f44-882926b36c3mr179257596d6.44.1763406355967; Mon, 17 Nov 2025
 11:05:55 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
In-Reply-To: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 20:05:44 +0100
X-Gm-Features: AWmQ_bmlzFg5Epv7RNJD9B6DXXECa_UH0VoWEI5QMaMzB0pVmIgjx7VJeaKK7kk
Message-ID: <CANNYZj_wF-LY60jTG6hjW_2jfQZiPHt9=h5=uNs-DHw8t60+Vw@mail.gmail.com>
Subject: Re: bitbake-setup steps for release
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, Paul Barker <paul@pbarker.dev>, 
	Ross Burton <ross.burton@arm.com>, reatmon <reatmon@ti.com>, 
	Robert Yang <liezhi.yang@windriver.com>, "antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 19:06:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18434

On Thu, 13 Nov 2025 at 12:16, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> a) The update command needs to prompt y/n on overwriting bblayers.conf
> or local.conf and give the users a choice. We need a way for users to
> update the repos with one command, we can improve the conf file
> upgrading later.
>
> b) There should be a --no-conf-updates (better naming?) to the update
> command

Antonin's patches are nearly ready (one more simple tweak and I'm happy).

> c) The default build path should not include the machine name. Ryan
> mentioned his previous patches which have the concept of a format
> string, or we have a include y/n piece in the json config. Otherwise
> you can end up with multiple elements like poky_poky.
>
> d) We need to tell the user how to change the machine/distro layer as
> nobody knows about the bitbake-config-build command. Mention "bitbake-
> config-build enable-fragment machine/XXX" in output when running the
> tool.
>
> e) Add a comment into toolcfg.conf to point at the command to change

This was discussed on the patch review call. The unresolved question
is what to do with c, as d and e are simple tweaks.

The situation right now is:
- it's possible to specify a custom setup dir name with --setup-dir-name=...
- it's also possible to type in a custom setup dir name in an
interactive initialization, if the suggested default isn't okay
- so the unresolved part is this: the suggested default is long and
ugly. But on the other hand it is guaranteed to be unique, and
includes all the parts that allow easily identifying what kind of
configuration is found inside that directory. I wrote it that way to
basically please myself, as I'm jugging at least 30 different build
directories, and need some kind of structure in their names to see
what is where. Aesthetically pleasant, short names are not important
(to me personally :).

So how is it long and ugly? As of now, if someone initializes poky
from the default registry they will get bitbake configuration in
something like this:

./bitbake-builds/poky-master-poky-distro_poky-machine_qemux86-64/build/conf/

The parts are:
- 'poky-master' is the filename of the configuration file. It contains
the project name and the branch/release name, so a different choice
could produce oenodistro-whintter
- 'poky' is the selected configuration inside that file. Another
option right now is 'poky-with-sstate'
- the remaining parts are fragment selections. bitbake-setup does not
know anything about machine or distro, it just concatenates the
fragment selections made during initialization: name-value.

So where do we go from here? How can we prevent poky being mentioned
three times? Should the tool try a short directory name first, and if
that already exists, try a longer one, and if that's taken, add even
more pieces, and, as a last resort, a magic number? Honestly, I don't
have clarity in my head now. Asking the audience!

> f) Catch conf file configuration of MACHINE/DISTRO conflicting with a
> fragment?

Chen Qi is working on this piece.

Thanks all!

Alex

