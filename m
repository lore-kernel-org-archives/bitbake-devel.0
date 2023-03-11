Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A544EC678D5
	for <webhook@archiver.kernel.org>; Sat, 11 Mar 2023 03:55:33 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web10.38977.1678506925843029559
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Mar 2023 19:55:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=GdlVRJvW;
 spf=pass (domain: gmail.com, ip: 209.85.128.172, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-53916ab0c6bso136001757b3.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Mar 2023 19:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678506925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vsUybItw4wuNaMmixBRRbOrbfHOtnJGEZjCGNkDpnng=;
        b=GdlVRJvWeKZ6M/twCpwcG4brSuf0Ba3vl/wrrqHHR0sY9qL4/pE64LIqvZMz2SQ+1b
         WukhOhyPowp5rme80ugMFx0Mfue+k3aRBymqGh4/ui08S7EbUogCJw5DHK+BQ0Od6xMP
         F54VAQVPVD505Y1ifC6Fz1kec1EkAkE2XpxSbFU0sNkr1nSULMRpif63L5RtP30Uzpjn
         seBdg/U66LssYKoX2xuVLVdQyHC0M3tWi9OCfUYeph2OCJO3kOK4v3JcMqPjJTpDAOy7
         /uxNnSbtmRqp7FuT78+Hyao2ASEQm5n2rHhd69oD0XfI0Jd9aEQPF1M9gybNeZbPSkT6
         CrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678506925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsUybItw4wuNaMmixBRRbOrbfHOtnJGEZjCGNkDpnng=;
        b=HnRqMZsg8F3dYoWTcz14feyPX2zwnVUF9meNIE7fOEv/YrysbqxNcjqzYNvMTkdg2+
         66CoAkt/EYPc+siqv3ZZYJRPRYujL2/z167C2iVRkitwFPPexcfNA6ztiZ2HL6LkQsj9
         ob+u4rlkkEeMH9eR2gLCofgRhA3jsf2EVX6pamBtiaQcM0ZFEwiGxZVrEKKyUz8HoOvM
         MFTJQC1EO4N05uvNwu7YJeHzJFSYuzmFZPLjsxGLyXiG7FHpx0oevfATEj6MnNXgwV+1
         RlCfgK4MaV1fYNOXqFeME/SQLTdF5foueySBz+6B39VebQoaa8xE9PS2GHlIsOzW/0tK
         akHg==
X-Gm-Message-State: AO0yUKWHEIsC7B1VgmTBbhc20zyfYWeMYkorazgiEzAKjez71p8A+bAh
	yfq55nLZM1Ydw8gVcSJZ4JRsq5tFfGvs3j4AGow=
X-Google-Smtp-Source: AK7set9iH7siWgNuSNoxjOFwEmVzfwbbg6xL2JWsYtUvlcR7D05eUD3iyQsAzecRMbb1qNKkf3yCAGJIrHnQGP5ziWQ=
X-Received: by 2002:a81:a983:0:b0:52e:e095:d840 with SMTP id
 g125-20020a81a983000000b0052ee095d840mr18430885ywh.0.1678506924772; Fri, 10
 Mar 2023 19:55:24 -0800 (PST)
MIME-Version: 1.0
References: <CA+chaQcSZDgrbeZjOU+THvNTrQt+VzCUGg3p1FMVG9qiP4QDAw@mail.gmail.com>
 <dc9bfbf315b36243781e012ac8117fb8acd59711.camel@linuxfoundation.org>
In-Reply-To: <dc9bfbf315b36243781e012ac8117fb8acd59711.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 10 Mar 2023 19:55:13 -0800
Message-ID: <CANx9H-CBsaZv2t529XT4JhggHJHZZfbQr3wSDgX5LPcQ-Rop3w@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake repo using the same tag name as branch
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Lee Chee Yang <chee.yang.lee@intel.com>, Martin Jansa <Martin.Jansa@gmail.com>, 
	Michael Halstead <mhalstead@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000000110fa05f697d930"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 Mar 2023 03:55:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14548

--0000000000000110fa05f697d930
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 24, 2023 at 5:41 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2023-02-24 at 12:09 +0100, Martin Jansa wrote:
> > Is there some reason why bitbake started to use tag name identical as
> > branch name from 2.0?
> >
> > It happens only with 2.0 and 2.2, because previous 1.52 branch had
> > first release named 1.52.0 not 1.52:
> > commit c78ebac71ec976fdf27ea24767057882870f5c60 (tag: yocto-3.4, tag:
> > 2021-10-honister, tag: 1.52.0)
> >
> > bitbake $ git show 1.52.0
> > tag 1.52.0
> > Tagger: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
> > Date:   Mon Oct 25 15:16:54 2021 -0700
> >
> > Tagging for 1.52.0 (yocto-3.4)
> >
> > This new scheme has small disadvantage:
> >
> > bitbake $ git push github 2.0
> > error: src refspec 2.0 matches more than one
> > error: failed to push some refs to 'github.com:shr-
> > distribution/bitbake.git'
> >
> > I can work around it by using refs/heads/2.0 and refs/tags/2.0 to
> > distinguish between them, but that's still a bit unusual and
> > unfortunate.
> >
> > Adding Chee Yang Lee who authored these 2 tags (see another warning
> > there):
> >
> > bitbake $ git show 2.0
> > warning: refname '2.0' is ambiguous.
> > tag 2.0
> > Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
> > Date:   Mon Apr 25 22:27:04 2022 -0700
> >
> > bitbake $ git show 2.2
> > warning: refname '2.2' is ambiguous.
> > tag 2.2
> > Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
> > Date:   Sun Oct 23 20:33:14 2022 -0700
>
> We should probably drop the 2.0 and 2.2 tags and put 2.0.0 and 2.2.0
> tags in place instead.
>

I noticed this as well and this is solution I was hoping for.


> Cheers,
>
> Richard
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14486):
> https://lists.openembedded.org/g/bitbake-devel/message/14486
> Mute This Topic: https://lists.openembedded.org/mt/97203651/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/leave/10722602/924729/2064237243/xyzzy
> [ticotimo@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000000110fa05f697d930
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Feb 24, 2023 at 5:41 AM Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 2023-=
02-24 at 12:09 +0100, Martin Jansa wrote:<br>
&gt; Is there some reason why bitbake started to use tag name identical as<=
br>
&gt; branch name from 2.0?<br>
&gt; <br>
&gt; It happens only with 2.0 and 2.2, because previous 1.52 branch had<br>
&gt; first release named 1.52.0 not 1.52:<br>
&gt; commit c78ebac71ec976fdf27ea24767057882870f5c60 (tag: yocto-3.4, tag:<=
br>
&gt; 2021-10-honister, tag: 1.52.0)<br>
&gt; <br>
&gt; bitbake $ git show 1.52.0<br>
&gt; tag 1.52.0<br>
&gt; Tagger: Vineela Tummalapalli &lt;<a href=3D"mailto:vineela.tummalapall=
i@intel.com" target=3D"_blank">vineela.tummalapalli@intel.com</a>&gt;<br>
&gt; Date: =C2=A0 Mon Oct 25 15:16:54 2021 -0700<br>
&gt; <br>
&gt; Tagging for 1.52.0 (yocto-3.4)<br>
&gt; <br>
&gt; This new scheme has small disadvantage:<br>
&gt; <br>
&gt; bitbake $ git push github 2.0<br>
&gt; error: src refspec 2.0 matches more than one<br>
&gt; error: failed to push some refs to &#39;github.com:shr-<br>
&gt; distribution/bitbake.git&#39;<br>
&gt; <br>
&gt; I can work around it by using refs/heads/2.0 and refs/tags/2.0 to<br>
&gt; distinguish between them, but that&#39;s still a bit unusual and<br>
&gt; unfortunate.<br>
&gt; <br>
&gt; Adding Chee Yang Lee who authored these 2 tags (see another warning<br=
>
&gt; there):<br>
&gt; <br>
&gt; bitbake $ git show 2.0<br>
&gt; warning: refname &#39;2.0&#39; is ambiguous.<br>
&gt; tag 2.0<br>
&gt; Tagger: Chee Yang Lee &lt;<a href=3D"mailto:chee.yang.lee@intel.com" t=
arget=3D"_blank">chee.yang.lee@intel.com</a>&gt;<br>
&gt; Date: =C2=A0 Mon Apr 25 22:27:04 2022 -0700<br>
&gt; <br>
&gt; bitbake $ git show 2.2<br>
&gt; warning: refname &#39;2.2&#39; is ambiguous.<br>
&gt; tag 2.2<br>
&gt; Tagger: Chee Yang Lee &lt;<a href=3D"mailto:chee.yang.lee@intel.com" t=
arget=3D"_blank">chee.yang.lee@intel.com</a>&gt;<br>
&gt; Date: =C2=A0 Sun Oct 23 20:33:14 2022 -0700<br>
<br>
We should probably drop the 2.0 and 2.2 tags and put 2.0.0 and 2.2.0<br>
tags in place instead.<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">I noticed this a=
s well and this is solution I was hoping for.</div><div dir=3D"auto"><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14486): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14486" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14486</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/97203651/9247=
29" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt/=
97203651/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/leav=
e/10722602/924729/2064237243/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.openembedded.org/g/bitbake-devel/leave/10722602/924729/20642372=
43/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000000110fa05f697d930--

