Return-Path: <sam@liddicott.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A87C4828F
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 21:22:27 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.1573.1707427347078959451
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Feb 2024 13:22:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@liddicott-com.20230601.gappssmtp.com header.s=20230601 header.b=temBBcZz;
 spf=none, err=SPF record not found (domain: liddicott.com, ip: 209.85.208.50, mailfrom: sam@liddicott.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5602500d1a6so481082a12.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liddicott-com.20230601.gappssmtp.com; s=20230601; t=1707427345; x=1708032145; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kDv2UQRFaidEVuofQSyghIb9798B7gMr8tLfhHdS04w=;
        b=temBBcZz8K5dkejr5hjj6lSqRk/mm2dZwM7gGqBXJWBV/wCkSvfHXn0RBgqgjwYqW3
         wBmLw/azR6yUA1zywQb4s3l26PbMTT/8srss7SSRxClWfy0b0nxDemXPhUkHJR0e1Pzd
         fGsy53CKmAajNwLRsPEMHvnwyEjz5K2dgOIuFUUhLAPTsCyZg1J7lllhmwBjrrcmS9EQ
         Wrwmza6NmqX1AjnfHhVvxa38x7Ugws+7qGw1FFVC1pmzqMvI7cQN4ppUIwevmqtjzf6c
         Tgsqke8FJzycYhfxIhV/XiuIg8Y+DY/wAWqae8l8H84NXo5SjlQ+Cf88D94CyhPOyL7R
         aqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707427345; x=1708032145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDv2UQRFaidEVuofQSyghIb9798B7gMr8tLfhHdS04w=;
        b=I9dKV7nBf1yMeHS8fEaiz5HLctx26T9UTeRXjGyb2dokhAwarzOLbyRzbCdlk2qrhZ
         6MKBbA4J8Pang6L7mbUQZqzC+TTeK0/X9NssaVNNU/MXm0+2XFW1AOcGXerK6ebipUQx
         SeL8kFypaXQ7XQ3aEh3W0IJk3CUIcOko4kasMPASJmlTSSyHgzDhpEwYKay0nZWqKvaq
         JXysIoFbcoX1pC6/jr7EhEr3qxQzbkFJcla0XXP8AkJc4YZbAxaZmwUVWTsjUcK82Q7D
         nk+T1L0VnDouchMjlq8Ms6U+vB0bI40NWrsyxGSVlKayfp8bgAYLbLRAIiatazh543Dy
         Y1uw==
X-Gm-Message-State: AOJu0YxP0n8bctkM0zH+sIBhKM92yr59lxOjvK7FP1XXwR7mbvHdxL6h
	07+IvpF/zIxaV33FarUAjtzZ3gyuCxC7xSXbbfy8prDqB3eoHqRt55szdDTiNl9jdjaY6sdjBga
	h+fq9BWBsk7mkmK4ULY0tHarxOG9Llh84AHCu
X-Google-Smtp-Source: AGHT+IGxHxxLl/YKfgcJEObdv+0mfCB/bzbgShvwEIZJoJDJOEVWwEbwr/+DN5/4kb1GBeAbnFgXIc9KHXVeM9I3pEY=
X-Received: by 2002:aa7:d902:0:b0:561:1364:bd06 with SMTP id
 a2-20020aa7d902000000b005611364bd06mr283661edr.29.1707427345043; Thu, 08 Feb
 2024 13:22:25 -0800 (PST)
MIME-Version: 1.0
References: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com>
 <lya5obge3c.fsf@ensc-pc.intern.sigma-chemnitz.de> <17B1FF6690DC06E7.12768@lists.openembedded.org>
 <DB5PR02MB10213640DC0E0573DB9445CAFEF442@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB10213640DC0E0573DB9445CAFEF442@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Sam Liddicott <sam@liddicott.com>
Date: Thu, 8 Feb 2024 21:21:48 +0000
Message-ID: <CAOj-5WArhvQ5msLi2DO+opMg0m+8+9qR_eOKekZ4ZvuoqzOTJA@mail.gmail.com>
Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filenames
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "enrico.scholz@sigma-chemnitz.de" <enrico.scholz@sigma-chemnitz.de>, Saul Wold <sgw@bigsur.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, 
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>, 
	"randy.macleod@windriver.com" <randy.macleod@windriver.com>
Content-Type: multipart/alternative; boundary="00000000000061b2880610e568c5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 21:22:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15847

--00000000000061b2880610e568c5
Content-Type: text/plain; charset="UTF-8"

Whatever you do I wish that there is some simple text-only non-python
ini-type declaration file to declare these settings, rules & capabilities.

My meta-build-tools have to parse the python or look for specific git
commits to decide whether or not to use : or _ as the override separator in
the generated conf files (e.g. local.conf), and more of this sort of thing
is going to be painful for the next decade. As an example of the
worst case, tools can't tell if the "current distro" is a sanity-supported
distro without first running bitbake.

I don't think I can even tell what the release code-name is without looking
at git revisions in the oe-embedded layer.

Sam

On Thu, 8 Feb 2024 at 21:16, Peter Kjellerstedt <peter.kjellerstedt@axis.com>
wrote:

> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org <bitbake-
> > devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt
> > Sent: den 8 februari 2024 22:09
> > To: enrico.scholz@sigma-chemnitz.de; Saul Wold <sgw@bigsur.com>
> > Cc: bitbake-devel@lists.openembedded.org;
> > richard.purdie@linuxfoundation.org; randy.macleod@windriver.com
> > Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filenames
> >
> > > -----Original Message-----
> > > From: bitbake-devel@lists.openembedded.org <bitbake-
> > > devel@lists.openembedded.org> On Behalf Of Enrico Scholz via
> > > lists.openembedded.org
> > > Sent: den 8 februari 2024 16:39
> > > To: Saul Wold <sgw@bigsur.com>
> > > Cc: bitbake-devel@lists.openembedded.org;
> > > richard.purdie@linuxfoundation.org; randy.macleod@windriver.com
> > > Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filenames
> > >
> > > "Saul Wold" <sgw@bigsur.com> writes:
> > >
> > > > I was looking into Bug 14235 [0] and had initial patch based on
> > > > Randy's original recommendation of using dash (-) which was a basic
> > > > python/tinfoil script to check existing bbclasses in the BBPATH.
> > >
> > > why not make it like rust and replace '-' by '_' when generating
> > > symbols?
> > >
> > > Enrico
> >
> > Taken alone that would open up for problems in case there is both a
> > foo_bar.bbclass and a foo-bar.bbclass (which is kind of ridiculous, but
> > it is at least a theoretical problem). However, if you combine it with
> > the rule that classes should only use dashes in their names, then it
> > should work.
> >
> > Actually, if we want bbclass names to only use dashes, what I would
> > suggest (and this may sound odd to some given the recent discussion on
> > breaking changes that I have been involved in on the
> > openembedded-architecture list) would be to change the bitbake syntax
> > to only allow alphanumeric characters and dashes in bbclass names. This
> > may sound like a huge breaking change, but it actually isn't. As long
> > as Enrico's suggestion is implemented, it is then just to change all
> > class names in OE Core, meta-openembedded, etc. Yes, this will break
> > other layers, but changing them is trivial. And if one has layers that
> > need to work both with nanbield and master for a transition period (like
> > we would have), it is easy to just add some oneliner wrapper classes in
> > one of one's own layers for the new names that inherit the old classes.
> >
> > At least I find that a lot more appealing than adding some check script
> > with a lot of hardcoded exceptions for the currently existing classes.
> >
> > I realize it is probably too late to do something like this for
> Scarthgap,
> > but I think it should be considered for Scarthgap's successor (what ever
> > it will be called).
> >
> > //Peter
>
> I forgot to say that regardless of whether the syntax is changed or not,
> I would really like to see Enrico's suggestion implemented for Scarthgap.
> That would make it a lot easier to transition to the new naming of
> bbclasses even if the new naming policy isn't a hard rule in Scarthgap.
>
> //Peter
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15846):
> https://lists.openembedded.org/g/bitbake-devel/message/15846
> Mute This Topic: https://lists.openembedded.org/mt/104228800/7497305
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> sam@liddicott.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--00000000000061b2880610e568c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Whatever you do I wish that there is some simple text-only=
 non-python ini-type declaration file to declare these settings, rules &amp=
; capabilities.<div><br></div><div>My meta-build-tools have to parse the py=
thon or look for specific git commits to decide whether or not to use : or =
_ as the override separator in the generated conf files (e.g. local.conf), =
and more of this sort of thing is going to be painful for the next decade. =
As an example of the worst=C2=A0case, tools can&#39;t tell if the &quot;cur=
rent distro&quot; is a sanity-supported distro without first running=C2=A0b=
itbake.</div><div><br></div><div>I don&#39;t think I can even tell what the=
 release code-name is without looking at git revisions in the oe-embedded l=
ayer.</div><div><br></div><div>Sam</div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 8 Feb 2024 at 21:16, Peter =
Kjellerstedt &lt;<a href=3D"mailto:peter.kjellerstedt@axis.com">peter.kjell=
erstedt@axis.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=
=3D"_blank">bitbake-devel@lists.openembedded.org</a> &lt;bitbake-<br>
&gt; <a href=3D"mailto:devel@lists.openembedded.org" target=3D"_blank">deve=
l@lists.openembedded.org</a>&gt; On Behalf Of Peter Kjellerstedt<br>
&gt; Sent: den 8 februari 2024 22:09<br>
&gt; To: <a href=3D"mailto:enrico.scholz@sigma-chemnitz.de" target=3D"_blan=
k">enrico.scholz@sigma-chemnitz.de</a>; Saul Wold &lt;<a href=3D"mailto:sgw=
@bigsur.com" target=3D"_blank">sgw@bigsur.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"=
_blank">bitbake-devel@lists.openembedded.org</a>;<br>
&gt; <a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank=
">richard.purdie@linuxfoundation.org</a>; <a href=3D"mailto:randy.macleod@w=
indriver.com" target=3D"_blank">randy.macleod@windriver.com</a><br>
&gt; Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filenames<b=
r>
&gt; <br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" tar=
get=3D"_blank">bitbake-devel@lists.openembedded.org</a> &lt;bitbake-<br>
&gt; &gt; <a href=3D"mailto:devel@lists.openembedded.org" target=3D"_blank"=
>devel@lists.openembedded.org</a>&gt; On Behalf Of Enrico Scholz via<br>
&gt; &gt; <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" targ=
et=3D"_blank">lists.openembedded.org</a><br>
&gt; &gt; Sent: den 8 februari 2024 16:39<br>
&gt; &gt; To: Saul Wold &lt;<a href=3D"mailto:sgw@bigsur.com" target=3D"_bl=
ank">sgw@bigsur.com</a>&gt;<br>
&gt; &gt; Cc: <a href=3D"mailto:bitbake-devel@lists.openembedded.org" targe=
t=3D"_blank">bitbake-devel@lists.openembedded.org</a>;<br>
&gt; &gt; <a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_=
blank">richard.purdie@linuxfoundation.org</a>; <a href=3D"mailto:randy.macl=
eod@windriver.com" target=3D"_blank">randy.macleod@windriver.com</a><br>
&gt; &gt; Subject: Re: [bitbake-devel] Underscore vs Dash in bbclass filena=
mes<br>
&gt; &gt;<br>
&gt; &gt; &quot;Saul Wold&quot; &lt;<a href=3D"mailto:sgw@bigsur.com" targe=
t=3D"_blank">sgw@bigsur.com</a>&gt; writes:<br>
&gt; &gt;<br>
&gt; &gt; &gt; I was looking into Bug 14235 [0] and had initial patch based=
 on<br>
&gt; &gt; &gt; Randy&#39;s original recommendation of using dash (-) which =
was a basic<br>
&gt; &gt; &gt; python/tinfoil script to check existing bbclasses in the BBP=
ATH.<br>
&gt; &gt;<br>
&gt; &gt; why not make it like rust and replace &#39;-&#39; by &#39;_&#39; =
when generating<br>
&gt; &gt; symbols?<br>
&gt; &gt;<br>
&gt; &gt; Enrico<br>
&gt; <br>
&gt; Taken alone that would open up for problems in case there is both a<br=
>
&gt; foo_bar.bbclass and a foo-bar.bbclass (which is kind of ridiculous, bu=
t<br>
&gt; it is at least a theoretical problem). However, if you combine it with=
<br>
&gt; the rule that classes should only use dashes in their names, then it<b=
r>
&gt; should work.<br>
&gt; <br>
&gt; Actually, if we want bbclass names to only use dashes, what I would<br=
>
&gt; suggest (and this may sound odd to some given the recent discussion on=
 <br>
&gt; breaking changes that I have been involved in on the <br>
&gt; openembedded-architecture list) would be to change the bitbake syntax =
<br>
&gt; to only allow alphanumeric characters and dashes in bbclass names. Thi=
s <br>
&gt; may sound like a huge breaking change, but it actually isn&#39;t. As l=
ong <br>
&gt; as Enrico&#39;s suggestion is implemented, it is then just to change a=
ll <br>
&gt; class names in OE Core, meta-openembedded, etc. Yes, this will break <=
br>
&gt; other layers, but changing them is trivial. And if one has layers that=
 <br>
&gt; need to work both with nanbield and master for a transition period (li=
ke<br>
&gt; we would have), it is easy to just add some oneliner wrapper classes i=
n<br>
&gt; one of one&#39;s own layers for the new names that inherit the old cla=
sses.<br>
&gt; <br>
&gt; At least I find that a lot more appealing than adding some check scrip=
t<br>
&gt; with a lot of hardcoded exceptions for the currently existing classes.=
<br>
&gt; <br>
&gt; I realize it is probably too late to do something like this for Scarth=
gap,<br>
&gt; but I think it should be considered for Scarthgap&#39;s successor (wha=
t ever<br>
&gt; it will be called).<br>
&gt; <br>
&gt; //Peter<br>
<br>
I forgot to say that regardless of whether the syntax is changed or not, <b=
r>
I would really like to see Enrico&#39;s suggestion implemented for Scarthga=
p.<br>
That would make it a lot easier to transition to the new naming of <br>
bbclasses even if the new naming policy isn&#39;t a hard rule in Scarthgap.=
<br>
<br>
//Peter<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15846): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15846" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15846</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/104228800/749=
7305" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/104228800/7497305</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:sam@liddicott.com" target=3D"_blan=
k">sam@liddicott.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000061b2880610e568c5--

