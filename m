Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0BC433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 15:44:50 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by mx.groups.io with SMTP id smtpd.web09.13820.1636472689516695935
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 07:44:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=K6fP+4RG;
 spf=pass (domain: gmail.com, ip: 209.85.222.47,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f47.google.com with SMTP id v3so39243568uam.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfKRYHyewzFa2rWdY3M6S7AaQiVbsHlDMuGTcZxwO18=;
        b=K6fP+4RGeFVWrE8mYbDnSdQs4znxh/mpYyOGdczPHnf828Deb+wkazQOAElFZBz3gB
         JN06ryazXwSXDmdnwYNspEOAr8jbm2iO8q71vWiD2fFpKWInYu0M4MxXwGRxjk3CX5/u
         awQ5gqfPY4vtxaNfsAlieek6GX73y8UJQeUm8JiprChIqXz8O9o7fctuNaakMBjgc/cn
         9148ucS1dVcvcwIvV3TXBkmcXYo+oMeQ+FwAYNNH29gVbn52qg1KnZq0KO094cMTVArB
         piDVdIkTjmBP5WVIAMq1cnugQKSbYnfM3Nw+H78uMk0uJPr+lz9iKU/vPhhxm3ZnMJAs
         SAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfKRYHyewzFa2rWdY3M6S7AaQiVbsHlDMuGTcZxwO18=;
        b=2gwMj8T2LpSclrLhCoL3UMVYiYZGUU6ryyz4ssMLknmULnjRME7I/laxT4HSY0Y6oS
         X5vuM0VA5N2MN/uEYuP8BKMVJF56Jmr6mNlcnvv3Hn3twXsuyzbER/Kd44QhEsIjJh88
         G/7KCOeETB+qe8Gzqc5SyFMAEl0mCWTrQ0G/t6Y7F3Fx4x1tZaH6wdCdaH6PmLj3xLzC
         3RIGFbdKpqgdJOFclFS00eN1xjUX/sdgvKFO5C/2gpeCrlmOgfDd5orkugpBcXrUJLuL
         uneL7udPbhhqOVrg9eMpu/YkIoW9knzrdEUMH4kTExngWjL9suSLzizaafladsIbpl1g
         PlWA==
X-Gm-Message-State: AOAM530Faj7FV/RVMsoOMBd9yEFOHRbZTP+27s5RtdQVzz7ZbwtDWKbI
	WfY+PVIBfA7xW2Z9d55ctzjU+o+SMZC3CULiKdc=
X-Google-Smtp-Source: 
 ABdhPJxB24Si2F+IM9ndC13jTqClFHj9KkmAG8ad/HE4VXjR/dv30BomUSJufjBraGh0HMyMHxgbkyx7is7PjoU+s0g=
X-Received: by 2002:ab0:484:: with SMTP id 4mr11186469uaw.71.1636472688615;
 Tue, 09 Nov 2021 07:44:48 -0800 (PST)
MIME-Version: 1.0
References: 
 <6a5db3389ed956233ca71f9b72b2fc051386ac34.camel@linuxfoundation.org>
 <450.1636472426380500781@lists.openembedded.org>
In-Reply-To: <450.1636472426380500781@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Nov 2021 16:44:37 +0100
Message-ID: 
 <CANNYZj9wcTeRn-4iBbZu9Z-ZPosGs8rby-cvWGxiC3q_vQh3Jw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
To: gabriel.valcazar@digi.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000004a25eb05d05cfdc2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 15:44:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12983

--0000000000004a25eb05d05cfdc2
Content-Type: text/plain; charset="UTF-8"

If the versions are very old (anything older than dunfell really), I think
the only viable path for you is to make private copies of respective yocto
repositories, and patch them as needed.

Alex

On Tue, 9 Nov 2021 at 16:40, gabriel.valcazar via lists.openembedded.org
<gabriel.valcazar=digi.com@lists.openembedded.org> wrote:

> Hi Richard,
>
> Are there any plans to backport this fix to older versions of
> bitbake/poky? My company has a line of legacy embedded products that are
> only supported in older versions of our Yocto distribution (1.3 in the most
> extreme case), and although we can manually change the protocol from git to
> https in the recipes in our layer, we can't do the same for other third
> party layers our distribution depends on (meta-qt5, meta-freescale,
> poky...). Since backporting the fix to older bitbake versions is trivial,
> do you intend to incorporate it in older bibake/poky versions in the near
> future?
>
> Otherwise, are there any alternative approaches we can take to ensure that
> users that depend on our legacy products can continue to build our Yocto
> distribution? Upgrading our entire legacy line to newer Yocto versions is
> not a viable solution for us.
>
> Thanks and best regards,
> Gabriel
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12982):
> https://lists.openembedded.org/g/bitbake-devel/message/12982
> Mute This Topic: https://lists.openembedded.org/mt/86764631/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000004a25eb05d05cfdc2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>If the versions are very old (anything older than dun=
fell really), I think the only viable path for you is to make private copie=
s of respective yocto repositories, and patch them as needed.</div><div><br=
></div><div>Alex<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Tue, 9 Nov 2021 at 16:40, gabriel.valcazar via=
 <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;g=
abriel.valcazar=3D<a href=3D"mailto:digi.com@lists.openembedded.org">digi.c=
om@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Hi Richard,<br><br>Are there any plans to backport=
 this fix to older versions of bitbake/poky? My company has a line of legac=
y embedded products that are only supported in older versions of our Yocto =
distribution (1.3 in the most extreme case), and although we can manually c=
hange the protocol from git to https in the recipes in our layer, we can&#3=
9;t do the same for other third party layers our distribution depends on (m=
eta-qt5, meta-freescale, poky...). Since backporting the fix to older bitba=
ke versions is trivial, do you intend to incorporate it in older bibake/pok=
y versions in the near future?<br><br>Otherwise, are there any alternative =
approaches we can take to ensure that users that depend on our legacy produ=
cts can continue to build our Yocto distribution? Upgrading our entire lega=
cy line to newer Yocto versions is not a viable solution for us.<br><br>Tha=
nks and best regards,<br>Gabriel
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12982): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12982" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12982</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86764631/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86764631/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000004a25eb05d05cfdc2--

