Return-Path: <linusti@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2BC433F5
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 14:06:32 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.137.1635861991285281936
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:06:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OBEWWPq2;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: linusti@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id b17so9861073qvl.9
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JTsvZhsShVvgc0X95y7/K86WO/ZCJz2knFjC7OdSQo=;
        b=OBEWWPq28EvwyOjsMjUIdr2I4cRMKzSwk13Gm4+SggZeoHbl1z/HUqc65UnKfRcwZs
         uouRZcpYD98h3bSsrMT8slCokmuVbk31aT0HcBDghjNurL0GE9zCydZYI0VGABWisOyD
         Q+JSuBO1zPITeWtpj+Y3H6p8islhoG84MyxeTDZWiTx6q/jUTn8D0VsqSXQ8HqPEO/7R
         PdjrYiGwjSXKzlyDnm3foT6cyIBhKRqpDVxmhN7IIdtyeuwDG+DffcwFhIlopIeQ3wAS
         xotnn9g7ENxedwJbr8zMgQTvhdSfwlRp5cemiLkmXjVGM3jTK8ENrAHLAXCRodW7Z673
         Vieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JTsvZhsShVvgc0X95y7/K86WO/ZCJz2knFjC7OdSQo=;
        b=pj/c+Pr7iIREjAcI+Ivnm191PcN2vkVFVJDKhxm9iKeTv0ZT4ZAm3t6Z6T+AxyoHmS
         PW0NqMZ4zuf6+il4VK99U/4/gsQDx7Mcil4gjE/Jl0mtwuqlf6mnxasB9K6uiKMQGY9a
         eHaljj5ycKk8jNORQZmWncSmuwEL0hpGg7uufJCVZeRqUR+BA9gK0OXf54841IpjEkq0
         OuzdWcaXA/CsjukepLdOUDFaSxaCh93ujhZFj3LOYLvWMDg/fEpp+ApMSR7wN5ipcugL
         XQDFhv4tLNjjDQxXUtJzTnlkJF/5pRf9yiNbmD0FhAgftLGBb41aaL8hdh6+7wi4gpRn
         e13Q==
X-Gm-Message-State: AOAM530i2CR1dsY3xn8znXqSXYJyQHbxFHEdfYnhOIm5/8EjT/aSZYcl
	FT4OhKnSxSvCRsj7uDDtPOB9iSHGtvtR2UMCBZg=
X-Google-Smtp-Source: 
 ABdhPJyZk6uauQloBgMJWvWDzoHpzZqZlPDwyuQ5MfpUnfhgUgEyJcfs7hpd2MzwraFieeep204CrP2WlIgB84XgwR0=
X-Received: by 2002:a0c:e592:: with SMTP id t18mr34743899qvm.4.1635861990346;
 Tue, 02 Nov 2021 07:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211102124500.3542952-1-richard.purdie@linuxfoundation.org>
 <AM9PR09MB4642729BBF86DB48FCA16DFCA88B9@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <7930bb9f4875fdc32c4fa43395da68bae76a24c0.camel@linuxfoundation.org>
In-Reply-To: 
 <7930bb9f4875fdc32c4fa43395da68bae76a24c0.camel@linuxfoundation.org>
From: Frank Earl <linusti@gmail.com>
Date: Tue, 2 Nov 2021 09:06:19 -0500
Message-ID: 
 <CANepkxCNovifgi84YiXmoydUpQbTLoV-uGWVF_oJ6rp10+V4cA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Konrad Weihmann <kweihmann@outlook.com>,
 bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d617cc05cfcecc2e"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 14:06:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12860

--000000000000d617cc05cfcecc2e
Content-Type: text/plain; charset="UTF-8"

(Reply to all, since I simply hit reply...not nearly enough caffeine
yet...)

This kind of breaks other things- what if you have a server that you need
to do protocol=ssh and it's authenticated (We have some of this at Motorola
Solutions going on for security reasons...)?   The proposed change causes
access to that to go away.  You almost need to fix this by checking the
target host and if it's GitHub, do those changes since they're not allowed-
but that's a more invasive change for "fixing" the older branches (We're
working on catching up, PROMISE!  X-D)   Not sure what the right answer is
for this other than Yowl at GitHub and Microsoft for this one- the only
place you know of this and finding out about it is on their blog and when
you get punted out.



On Tue, Nov 2, 2021 at 8:28 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2021-11-02 at 14:19 +0100, Konrad Weihmann wrote:
> >
> > On 02.11.21 13:44, Richard Purdie wrote:
> > > github is dropping support for git procotol iun git urls. Add code to
> remap
> > > this to https in a way that could be used in older bitbake versions.
> > >
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > ---
> > >   lib/bb/fetch2/git.py | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > index e974445fbe..f5be24d6ab 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -142,6 +142,10 @@ class Git(FetchMethod):
> > >               ud.proto = 'file'
> > >           else:
> > >               ud.proto = "git"
> > > +        if ud.host == "github.com" and ud.proto == "git":
> > > +            # github stopped supporting git protocol
> > > +            #
> https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
> >
> > While having a warning within the bitbake is something very much
> > appreciated, I don't think it's a good idea to remap to https here, as I
> > think rather the recipes that still use this should be fixed.
> > This will just lead to non-core layer (the ones being not so well
> > maintained) just ignoring the warning and leave the original offending
> > recipes as they are.
> >
> > I think this solution does scale very well.
> > For instance this assumes that github.com is used, but I can also think
> > of DNS aliases, where this rule here simply won't catch up... same for
> > the fact that other hosting platforms will likely go in the same
> > direction and we would end up with an ever growing condition here
> >
> > Bottom line: I like the warning, but would rather insist on the recipes
> > that still use git:// + protocol=git to be fixed - at the mentioned
> > 11.1.22 likely fetching them will fail with an explicit error message
> > anyway, so I actually don't see the need to magically fix up things here
>
> With 15 years of legacy branches and recipes out there, this change is
> intended
> to be backported to older bitbakes to at least give some support to people
> stuck
> on older versions. This is why this commit and the warning are separated.
>
> The warning is being added as we're not at 11.1.22 yet and people have
> previously said they don't like instant hard breaking error messages. We'll
> therefore give people some time to update, then change master to an error.
>
> Cheers,
>
> Richard
>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12859):
> https://lists.openembedded.org/g/bitbake-devel/message/12859
> Mute This Topic: https://lists.openembedded.org/mt/86764631/5804681
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> linusti@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000d617cc05cfcecc2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">(Reply to all, since I simply hit reply...not nearly enoug=
h caffeine yet...) <br><div><br>This kind of breaks other things- what if y=
ou have a server that=20
you need to do protocol=3Dssh and it&#39;s authenticated (We have some of t=
his
 at Motorola Solutions going on for security reasons...)?=C2=A0=C2=A0 The p=
roposed
 change causes access to that to go away.=C2=A0 You almost need to fix this=
=20
by checking the target host and if it&#39;s GitHub, do those changes since=
=20
they&#39;re not allowed- but that&#39;s a more invasive change for &quot;fi=
xing&quot; the=20
older branches (We&#39;re working on catching up, PROMISE!=C2=A0 X-D)=C2=A0=
=C2=A0 Not sure=20
what the right answer is for this other than Yowl at GitHub and=20
Microsoft for this one- the only place you know of this and finding out=20
about it is on their blog and when you get punted out.</div><font color=3D"=
#888888"><div><br><br></div></font></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 2, 2021 at 8:28 AM Richard P=
urdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.pur=
die@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Tue, 2021-11-02 at 14:19 +0100, Konrad Weihmann w=
rote:<br>
&gt; <br>
&gt; On 02.11.21 13:44, Richard Purdie wrote:<br>
&gt; &gt; github is dropping support for git procotol iun git urls. Add cod=
e to remap<br>
&gt; &gt; this to https in a way that could be used in older bitbake versio=
ns.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdi=
e@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org=
</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0lib/bb/fetch2/git.py | 4 ++++<br>
&gt; &gt;=C2=A0 =C2=A01 file changed, 4 insertions(+)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py<br>
&gt; &gt; index e974445fbe..f5be24d6ab 100644<br>
&gt; &gt; --- a/lib/bb/fetch2/git.py<br>
&gt; &gt; +++ b/lib/bb/fetch2/git.py<br>
&gt; &gt; @@ -142,6 +142,10 @@ class Git(FetchMethod):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.proto =
=3D &#39;file&#39;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.proto =
=3D &quot;git&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.host =3D=3D &quot;<a href=3D"h=
ttp://github.com" rel=3D"noreferrer" target=3D"_blank">github.com</a>&quot;=
 and ud.proto =3D=3D &quot;git&quot;:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # github stopped suppo=
rting git protocol<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # <a href=3D"https://g=
ithub.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unaut=
henticated-git" rel=3D"noreferrer" target=3D"_blank">https://github.blog/20=
21-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-gi=
t</a><br>
&gt; <br>
&gt; While having a warning within the bitbake is something very much <br>
&gt; appreciated, I don&#39;t think it&#39;s a good idea to remap to https =
here, as I <br>
&gt; think rather the recipes that still use this should be fixed.<br>
&gt; This will just lead to non-core layer (the ones being not so well <br>
&gt; maintained) just ignoring the warning and leave the original offending=
 <br>
&gt; recipes as they are.<br>
&gt; <br>
&gt; I think this solution does scale very well.<br>
&gt; For instance this assumes that <a href=3D"http://github.com" rel=3D"no=
referrer" target=3D"_blank">github.com</a> is used, but I can also think <b=
r>
&gt; of DNS aliases, where this rule here simply won&#39;t catch up... same=
 for <br>
&gt; the fact that other hosting platforms will likely go in the same <br>
&gt; direction and we would end up with an ever growing condition here<br>
&gt; <br>
&gt; Bottom line: I like the warning, but would rather insist on the recipe=
s <br>
&gt; that still use git:// + protocol=3Dgit to be fixed - at the mentioned =
<br>
&gt; 11.1.22 likely fetching them will fail with an explicit error message =
<br>
&gt; anyway, so I actually don&#39;t see the need to magically fix up thing=
s here<br>
<br>
With 15 years of legacy branches and recipes out there, this change is inte=
nded<br>
to be backported to older bitbakes to at least give some support to people =
stuck<br>
on older versions. This is why this commit and the warning are separated.<b=
r>
<br>
The warning is being added as we&#39;re not at 11.1.22 yet and people have<=
br>
previously said they don&#39;t like instant hard breaking error messages. W=
e&#39;ll<br>
therefore give people some time to update, then change master to an error.<=
br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12859): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12859" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12859</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86764631/5804=
681" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86764631/5804681</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:linusti@gmail.com" target=3D"_blan=
k">linusti@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000d617cc05cfcecc2e--

