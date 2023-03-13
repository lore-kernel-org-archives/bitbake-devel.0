Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8CDC6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 17:06:16 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.25487.1678727173253829923
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Mar 2023 10:06:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fN2Yltnd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.44, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-ed1-f44.google.com with SMTP id fd5so17631944edb.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678727171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xKNPejAplccT9OXQzxNClhWAcM7vE+H5uFlmDBZE1Tk=;
        b=fN2YltndeKxTnlwmWVWlQWn0EbY/n0x+thcpftaybPyXY1K2SskGFx/f/WAECTetcW
         iWWUYzfcyw2Cb5T2CH4wa2k/Jfi+RUTGQnulJv7cYWjRIhbYPNcBkreZmomxI9eZkr64
         cecIe/lUm2+0QVv/12EGsfkAE5ZPqT7PyP3Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678727171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKNPejAplccT9OXQzxNClhWAcM7vE+H5uFlmDBZE1Tk=;
        b=Br+OlYYFYJ7OW0Q3pZwuoTqxw4CRtsUPLaJ7wX5Vt+pgY/D6ncVPHl5iSrhFEfL9yZ
         p6eMExPA2BpnxUsQGP/omJrtBFVk4oKqNM53o0oXzCLruehCTn/tVfONJMlGdGT0oZeQ
         2tTtF9JhjMaOf5wRPnBtaGsW67ZI6RLiQ8HE+vP+BGOLykE4zBKaYfhve1wFa199mlVX
         awjTgjzPtXSBCVWlAIecBW2vsslk0/nngeI2p6608J1Ti8mf+7jqOhN3iyaZ2GMToCV1
         oYuZMKIWG4hfpyaJN4pQTag6PGZpyGPT1B0v82FHdLGcRi/u1gO6SUCLlIRkb7C/0J93
         DiXg==
X-Gm-Message-State: AO0yUKWh6XWEZZEgdtKdtvjky6BB5oSRDVIISap2aw1UKtodfcjgEADz
	XE1kgR6n2Auq72RySN650FrpBqgCVfBsruDNPKcLOQ==
X-Google-Smtp-Source: AK7set9jcRuoHhOos5/wy53EMjV3DVBsL+eXFMjont77z6moJFLWk5eK8XdB08Xd8lQ3A6sVfqf4R49P5IsfBqLVeZw=
X-Received: by 2002:a50:d7cb:0:b0:4af:70a5:5609 with SMTP id
 m11-20020a50d7cb000000b004af70a55609mr5941541edj.1.1678727171400; Mon, 13 Mar
 2023 10:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+chaQcSZDgrbeZjOU+THvNTrQt+VzCUGg3p1FMVG9qiP4QDAw@mail.gmail.com>
 <dc9bfbf315b36243781e012ac8117fb8acd59711.camel@linuxfoundation.org> <CANx9H-CBsaZv2t529XT4JhggHJHZZfbQr3wSDgX5LPcQ-Rop3w@mail.gmail.com>
In-Reply-To: <CANx9H-CBsaZv2t529XT4JhggHJHZZfbQr3wSDgX5LPcQ-Rop3w@mail.gmail.com>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Mon, 13 Mar 2023 10:06:00 -0700
Message-ID: <CADfgfoYqdF0UbmVxoem5we7Ovf7NnOpPS=cYK0VeR6Lc_fu8Kg@mail.gmail.com>
Subject: Re: [bitbake-devel] Bitbake repo using the same tag name as branch
To: Tim Orling <ticotimo@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Lee Chee Yang <chee.yang.lee@intel.com>, Martin Jansa <Martin.Jansa@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b9f9fd05f6cb20f8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Mar 2023 17:06:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14554

--000000000000b9f9fd05f6cb20f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've renamed these tags and kept everything else the same:

2.0 -> 2.0.0
2.2 -> 2.2.0

I left these much older tags alone:

1.0
1.1
1.2

On Fri, Mar 10, 2023 at 7:55=E2=80=AFPM Tim Orling <ticotimo@gmail.com> wro=
te:

>
>
> On Fri, Feb 24, 2023 at 5:41 AM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> On Fri, 2023-02-24 at 12:09 +0100, Martin Jansa wrote:
>> > Is there some reason why bitbake started to use tag name identical as
>> > branch name from 2.0?
>> >
>> > It happens only with 2.0 and 2.2, because previous 1.52 branch had
>> > first release named 1.52.0 not 1.52:
>> > commit c78ebac71ec976fdf27ea24767057882870f5c60 (tag: yocto-3.4, tag:
>> > 2021-10-honister, tag: 1.52.0)
>> >
>> > bitbake $ git show 1.52.0
>> > tag 1.52.0
>> > Tagger: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
>> > Date:   Mon Oct 25 15:16:54 2021 -0700
>> >
>> > Tagging for 1.52.0 (yocto-3.4)
>> >
>> > This new scheme has small disadvantage:
>> >
>> > bitbake $ git push github 2.0
>> > error: src refspec 2.0 matches more than one
>> > error: failed to push some refs to 'github.com:shr-
>> > distribution/bitbake.git'
>> >
>> > I can work around it by using refs/heads/2.0 and refs/tags/2.0 to
>> > distinguish between them, but that's still a bit unusual and
>> > unfortunate.
>> >
>> > Adding Chee Yang Lee who authored these 2 tags (see another warning
>> > there):
>> >
>> > bitbake $ git show 2.0
>> > warning: refname '2.0' is ambiguous.
>> > tag 2.0
>> > Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
>> > Date:   Mon Apr 25 22:27:04 2022 -0700
>> >
>> > bitbake $ git show 2.2
>> > warning: refname '2.2' is ambiguous.
>> > tag 2.2
>> > Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
>> > Date:   Sun Oct 23 20:33:14 2022 -0700
>>
>> We should probably drop the 2.0 and 2.2 tags and put 2.0.0 and 2.2.0
>> tags in place instead.
>>
>
> I noticed this as well and this is solution I was hoping for.
>
>
>> Cheers,
>>
>> Richard
>>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#14486):
>> https://lists.openembedded.org/g/bitbake-devel/message/14486
>> Mute This Topic: https://lists.openembedded.org/mt/97203651/924729
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe:
>> https://lists.openembedded.org/g/bitbake-devel/leave/10722602/924729/206=
4237243/xyzzy
>> [ticotimo@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>

--=20
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

--000000000000b9f9fd05f6cb20f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve renamed these tags and kept everything else the=
=C2=A0same:<div><br></div><div>2.0 -&gt; 2.0.0</div><div>2.2 -&gt; 2.2.0</d=
iv><div><br></div><div>I left these much older tags alone:</div><div><br></=
div><div>1.0<br>1.1<br>1.2<br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 10, 2023 at 7:55=E2=80=AFPM=
 Tim Orling &lt;<a href=3D"mailto:ticotimo@gmail.com">ticotimo@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Feb 24, 2023 at 5:41 AM Richard Purdie &lt;<a href=3D"ma=
ilto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@l=
inuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Fri, 2023-02-24 at 12:09 +0100, Martin Jansa wrote:<br=
>
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
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
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
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Michael Halstead<div>Linux Foundation / Yocto Project</div><=
div>Systems Operations Engineer</div></div></div>

--000000000000b9f9fd05f6cb20f8--

