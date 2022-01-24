Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EB6C433F5
	for <webhook@archiver.kernel.org>; Mon, 24 Jan 2022 17:58:10 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by mx.groups.io with SMTP id smtpd.web12.385.1643047089500592484
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Jan 2022 09:58:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=O0z47pyp;
 spf=pass (domain: gmail.com, ip: 209.85.222.47,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f47.google.com with SMTP id y4so32578075uad.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Jan 2022 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Sm8WF3DIGJE1vgW/NWV3ajfBz/ka9bORqXvzg7YaMI=;
        b=O0z47pypGR+aMKALEMRmk2xfmyda+CV3aRAOFWqB+3FPWz5ykSpj93gK4hI8zSvBCR
         GD9TWAVQAh8OfHsI5AmqcL/4kcanvwwNcJdClpaf+42YWJ81qgXm2+crQVanCj0AXB3T
         gmincG5nWJzZhzUdC4S0pjhwLYx/s8rmqHf95yETZYi4LwOnSDHN0a62BKHXhc1Dlc+k
         RmrauN7vZRKS9pyjkuAXqpu067BhfI/oVIqLVIrke3hvu99EWtQxJH0MIojAWqsrJV+O
         A60zM7V+rOR9UwoolETuIc4hS7tSpmzybgqV3Kxk293pJTlBQikZocZM1XwVyuEPRnLS
         yiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Sm8WF3DIGJE1vgW/NWV3ajfBz/ka9bORqXvzg7YaMI=;
        b=JFg6V9FoPWu469+nwoLD5oFyZmzFvs718mYHFfAd7JJOe0BVWi1zVZE+yE6D9KePh6
         MZeCvfxsnRnsfcakEjrxyR35cDayM8mI8gc80A0/Ovv1rkDlPXaJH39Qezysjbtznb77
         OCBc/C1lVDXl0oK7yYOffoOmflZ/ytu19XpHjsTXBKWh9dtKRI60QDL9UJgbvbJBtuat
         aRejaHy4ivSNPXXOeDAP7ZqmZ813TqTOV6LVJrFvPBrfJQORcOhgCeLBRycoxULhjiPG
         1EtPF9MTnwgXiM9EUhb1xs8gUQozyJiynBt3Hdckrd0AtC1Vjs/MuKa/d3gCwzT/x3yS
         uM+Q==
X-Gm-Message-State: AOAM531JC/VAHo+W9E3sdV6jIQHr4hSG2WVijAb8PiXw+HLlIwVRTkwA
	YCAai7ZxqSkocmBEMR3HJuCXgbiTXWWzOdTrqhE=
X-Google-Smtp-Source: 
 ABdhPJxkwp9QElTvEZkjtGMZXIp9cNzIonFwz158WaOevBGpsVgPY+6w8kQi3acQ55MtaTabFeEwuay8OnmpEWk9Yy0=
X-Received: by 2002:a67:b449:: with SMTP id c9mr1135205vsm.81.1643047088542;
 Mon, 24 Jan 2022 09:58:08 -0800 (PST)
MIME-Version: 1.0
References: <5aln.1643046764438530024.CPYI@lists.openembedded.org>
In-Reply-To: <5aln.1643046764438530024.CPYI@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 24 Jan 2022 18:57:57 +0100
Message-ID: 
 <CANNYZj_RCo4=9q2bxnU9D9nS952ss-J1mtqVfr35RFDw-x0Wig@mail.gmail.com>
Subject: Re: [bitbake-devel] Custom SDK generation from YoctoSDK
To: Praveen <praveen44com@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000000fd6c705d657b678"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Jan 2022 17:58:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13275

--0000000000000fd6c705d657b678
Content-Type: text/plain; charset="UTF-8"

Please introduce yourself, who are those 'we'?

Also, this is not a bitbake questions and should go to the yocto mailing
list.

Alex

On Mon, 24 Jan 2022 at 18:52, Praveen <praveen44com@gmail.com> wrote:

> We have a new requirement generating Custom SDK with filtered Header
> files/libraries based on some rules/approvals. It means not all files from
> YoctoSDK will be packaged in the CustomSDK.
>
> What is the mechanism or approach where we can pull only those approved
> header files & libraries from YoctoSDK and package as Customized SDK tar?
>
> Is there a way we can fetch those approved header files from YOCTO SDK and
> filter it?
>
> We are thinking like creating subset versioned module recipe and specify
> those approved header files and package only those files. Is there any
> better mechanism on packaging or filtering the SDK based on some rules to
> filter some header files?
>
> Like for example in YoctoSDK, we have 2 modules moduleA (A1.h, A2.h,A3.h
> and libA.so), moduleB (B1.h, B2.h, B3.h and libB.so)
> Lets say A3.h & B3.h are not approved in my Custom SDK, then in final
> Customer SDK we will only package
> moduleA (A1.h, A2.h and libA.so), moduleB (B1.h, B2.h, and libB.so)
>
> We have a requirement to keep YoctoSDK without any filters, so that
> A3.h/B3.h can be used for internal purposes without any issue.
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13274):
> https://lists.openembedded.org/g/bitbake-devel/message/13274
> Mute This Topic: https://lists.openembedded.org/mt/88652811/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000000fd6c705d657b678
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Please introduce yourself, who are those &#39;we&#39;=
?</div><div><br></div><div>Also, this is not a bitbake questions and should=
 go to the yocto mailing list.</div><div><br></div><div>Alex<br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mo=
n, 24 Jan 2022 at 18:52, Praveen &lt;<a href=3D"mailto:praveen44com@gmail.c=
om">praveen44com@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div>We have a new requirement generating Custom =
SDK with filtered Header files/libraries based on some rules/approvals. It =
means not all files from YoctoSDK will be packaged in the CustomSDK. </div>
<div>=C2=A0</div>
<div>What is the mechanism or approach where we can pull only those approve=
d header files &amp; libraries from YoctoSDK and package as Customized SDK =
tar?</div>
<div>=C2=A0</div>
<div>Is there a way we can fetch those approved header files from YOCTO SDK=
 and filter it?<br><br>We are thinking like creating subset versioned modul=
e recipe and specify those approved header files and package only those fil=
es. Is there any better mechanism on packaging or filtering the SDK based o=
n some rules to filter some header files?<br><br>Like for example in YoctoS=
DK, we have 2 modules moduleA (A1.h, A2.h,A3.h and libA.so), moduleB <span =
style=3D"color:rgb(0,0,0)"><span style=3D"color:rgb(136,136,136)">(B1.h, B2=
.h, B3.h and libB.so)<br>Lets say A3.h &amp; B3.h are not approved in my Cu=
stom SDK, then in final Customer SDK we will only package </span></span><br=
><span style=3D"color:rgb(136,136,136)"><span style=3D"color:rgb(0,0,0)">mo=
duleA (A1.h, A2.h and libA.so), moduleB </span><span style=3D"color:rgb(136=
,136,136)"><span style=3D"color:rgb(0,0,0)">(B1.h, B2.h, and libB.so)</span=
><br><br><span style=3D"color:rgb(0,0,0)">We have a requirement to keep Yoc=
toSDK without any filters, so that A3.h/B3.h can be used for internal purpo=
ses without any issue.</span><br></span></span></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13274): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13274" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13274</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/88652811/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/88652811/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000000fd6c705d657b678--

