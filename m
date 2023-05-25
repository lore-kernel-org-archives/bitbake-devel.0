Return-Path: <tomasz.dziendzielski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D222C77B7E
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 12:09:59 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
 by mx.groups.io with SMTP id smtpd.web11.9941.1685016592155998352
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 05:09:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=M48nf+lE;
 spf=pass (domain: gmail.com, ip: 209.85.222.54, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-783e4666739so595489241.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 05:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685016591; x=1687608591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F23P4n0PkEtkassATEJub6EdqejLMl3Sb73y3Zffw40=;
        b=M48nf+lEk/D+6CG0vUXbhcg0WsoIIWqN+nAGFo5iVCLoV7R0GC6VeG0ohADScahEO4
         7bvxpD4clPQVDJC17ujZqIIyhvjfvV3PPf/6fyZsK0tk+aaqbfv5cE0OT8S+FuwKN0dc
         05Bcj8hwUbuZSHCr/zt9FFQniZgoWVfASlgMJMe81Cu4V98RR3HuJLoT6gjxP/y2OOef
         DQq/JOEVftEH1HpnMMkb4zyJbxMyWP3eO7xQ/J4rTn8r6XBNc3xoL029tbw+xlwWmwxx
         tvkxkS0yeRjNXe8st+4qSy5qvsOIitAUoQo67nAdkecDaVgyV8ctAdruirYkAuTeMkvt
         YBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016591; x=1687608591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F23P4n0PkEtkassATEJub6EdqejLMl3Sb73y3Zffw40=;
        b=baUPFb8dYftu92r79s5sS0M8KVdJ/DbAjmHjCG8a7XeRO+5+YtyHisenRQ+XgQBKaN
         NDD4w87JqiH54sZMkHDkF8z/w0zMBJ7tpvyqxCcTk/+IuIxnPMobfxIYKf7vCD9uKDo/
         kLxl/WUFlSibxj6IhwrR2mlsedBms7dNPsI0ASlGgwZfL8EE1tS6XL9OZmI2G65+tNko
         O2XaVWmYUa3KtGMX3326ta2UMpZ6WZYgBfiyTFtqib34RaO03x6ectgrMhREEBgbrdyW
         /UYgJHc6Uk3On2Bqi7H/444zsTKBfTZ6Uz5tqpOtZ4JMeBdpfmzY7QaVnfjgnm4fB32U
         K4Ug==
X-Gm-Message-State: AC+VfDzGHXFOPPTyg9mmZ/VeHfziFW+ekiy//lVZWcGyijEV2t0CLiLD
	AsHRB4ciCfAZepoFI9xt5DQbQ5DHQnxDMDnZxrU=
X-Google-Smtp-Source: ACHHUZ6AbrnabGJgro5Omto+r9GHtrpLcm36yEQJS5yZij5Cd56zxn6UuRoOxLATmB85ZbmUc8QCgE4kriNcTBkgCGU=
X-Received: by 2002:a67:f148:0:b0:434:2f6a:6009 with SMTP id
 t8-20020a67f148000000b004342f6a6009mr7109601vsm.8.1685016591168; Thu, 25 May
 2023 05:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230525102105.1480610-1-michalwsieron@gmail.com>
 <ZG88JxkZkP4z3kR5@nuoska> <CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
 <CAJkqNs2iyuVXRU-Wva+9pC58XixbM5YPC6c8hfgNuDY+9aYaRg@mail.gmail.com> <CANNYZj_PG2e4tk5u4TWj3utBsE1cnTArgPmB1n9893j3JnrQ4g@mail.gmail.com>
In-Reply-To: <CANNYZj_PG2e4tk5u4TWj3utBsE1cnTArgPmB1n9893j3JnrQ4g@mail.gmail.com>
From: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Thu, 25 May 2023 14:13:10 +0200
Message-ID: <CAJkqNs33qZDkgJGgFh5a9CZ7wZFZqvVGPDmZnKruP5g_7MRBNw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>, Michal Sieron <michalwsieron@gmail.com>, 
	bitbake-devel@lists.openembedded.org, 
	Mateusz Marciniec <mateuszmar2@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005b7a0305fc837f9f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 12:09:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14811

--0000000000005b7a0305fc837f9f
Content-Type: text/plain; charset="UTF-8"

>Yocto has a download cache mechanism, so you should not have to fetch
>more than once. Are you throwing away that cache between builds?

Do you mean the DL_DIR or something else as cache mechanism? We do keep
DL_DIR between builds, but we're talking about cases where there was a
change in the repository.

>the actual problem is slow gerrit/artifactory instances, not
>stuck fetch tasks
Totally agree, but we're not able to fix the slow gerrit/artifactory in a
short term.

>The idea of 'retrying' the fetch
Well, it's  not like I'm saying this as a solution, usually we just
disable jobs until the slowness is gone. But isn't that what we already do
with wget in bitbake?
"wget -t 2 -T 30" from bitbake/lib/bb/fetch2/wget.py, where -t is tries,
and -T is timeout
Problem is that we get the slowness for git repositories and git does not
support such a thing.

Best regards,
Tomasz Dziendzielski

--0000000000005b7a0305fc837f9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;Yocto has a download cache mechanism, so you should no=
t have to fetch<br>&gt;more than once. Are you throwing away that cache bet=
ween builds?<br><br>Do you mean the DL_DIR or something else as cache mecha=
nism? We do keep DL_DIR between builds, but we&#39;re talking about cases w=
here there was a change in the repository.<div><br>&gt;the actual problem i=
s slow gerrit/artifactory instances, not</div><div>&gt;stuck fetch tasks</d=
iv><div>Totally agree, but we&#39;re not able to fix the slow gerrit/artifa=
ctory in a short term.<br><br>&gt;The idea of &#39;retrying&#39; the fetch<=
/div><div>Well, it&#39;s=C2=A0 not like I&#39;m saying this as a solution, =
usually we just disable=C2=A0jobs until the slowness is gone. But isn&#39;t=
 that what we already do with wget in bitbake?</div><div>&quot;wget -t 2 -T=
 30&quot; from=C2=A0bitbake/lib/bb/fetch2/wget.py, where -t is tries, and -=
T is timeout</div><div>Problem is that we get the slowness for git reposito=
ries and git does not support such a thing.<br><br>Best regards,<br>Tomasz =
Dziendzielski</div></div>

--0000000000005b7a0305fc837f9f--

