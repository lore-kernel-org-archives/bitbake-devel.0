Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF2C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 18:37:01 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.2825.1716575819392091263
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 11:36:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i3Jgg+nW;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-628c1f09f5cso23078997b3.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716575818; x=1717180618; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ9gf1FeCTMdvWbkDVhQOg6gYpGFtXrt/ATLonsYoCU=;
        b=i3Jgg+nWQ6pSlFuj+8CwsbJCmXw9N7Q0Tm2uAkcKEugbQBsr8dVmI4EcAYFozBT4kf
         Fs54d34a1q/mifbS0tyHtzVmWOb5B3TUnPmC+uEMhVH2qWepbCdrU4euw/hlpTwRTzpB
         d8hAxThLNHxCrMRVcWXZ/zuYIlg+IOVc18U3ULqkIquLQFsGnNYFN2bXTJCggv8x1ZeJ
         lzALPz3kbj0uMx8x/iIIr0Y9aLLp+UHEmFFWqW9dabXZSzCyuUrj9DraU4RRa4ygquQU
         IhGXw5MpkaNELENE1d309d3lnF62xl+i4IBcsKA8uZSSY258uQnws+AYPch3t0hypLTB
         xZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575818; x=1717180618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJ9gf1FeCTMdvWbkDVhQOg6gYpGFtXrt/ATLonsYoCU=;
        b=mr8HBQkGfyLoI+JcZUQKxoRfGhIo1n6s9wr4af6sPJn74fXPBVGd13iLpGfsagG16C
         NfOwVX2CH7OcGhbGU5+UPbRo1gzJu9yrfbf4zLYMhObYlv54cI5SbsrQi7tYP09jg6cq
         +1btfUa/FqXVeO+xkbr+FnR2NZHxsojEU635lFaPPF2GmW/KB4nkUUirKlROPp4TnFEV
         69JZcONqmxwySCqyYan26cN+mxZ33tij/3SmCGCbTWcSqpXuITf/3304E3o9PLkeR3W4
         Ft2QV1UFgzYxVl4sxvftmoCVbnjsecSounRAFuphXlrfqi/zUZO1DrTO1LiM/pFvPvuN
         0U0A==
X-Forwarded-Encrypted: i=1; AJvYcCW+PDjiPqsNCB0VJWCmPYuH3LCSt0gPyhoID5ApiQnNERCn91y7xox528yI0pAcmluDRBqtLRy2yzGvjdgyDhwiWoyixOV+CPgLnd9tamPvPGGx9Ow=
X-Gm-Message-State: AOJu0Ywlb/BOfiyw2C3WfrVWYebchrEZm9SJ+Nr+oNXi/cHE+W5ToB8z
	VDuVF5aHJxKHg/df6pmcJ1+RDjD1xKLv5UMwk6CgpfkNds8h+iG9QEOJOx9hWOHbIfUgKo3cHC6
	G43TVu41Sp3a/wbbLGO2HQsWG/y4=
X-Google-Smtp-Source: AGHT+IGaHH8qly91K6uIN9A25K5478ma5OXfieipbZeTeNigdrIvmRDEl2FNtXNKkYxrbL6YptAp5efenyo84Sy2XQ8=
X-Received: by 2002:a05:690c:82c:b0:622:f785:5499 with SMTP id
 00721157ae682-62a08f923d3mr36657037b3.37.1716575816939; Fri, 24 May 2024
 11:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de>
 <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com>
 <de18f958-d6db-4f90-a49b-a181d046f77e@cherry.de> <CAMKF1spNvMbuy+a-HS7wEbx5D817t6oxb_R12=gBgKgG8Eja1Q@mail.gmail.com>
 <CANx9H-CC9YHqTv6LgZE8jP0KVJC5Wsvyc8wmzhnf9crRG7ej4A@mail.gmail.com>
In-Reply-To: <CANx9H-CC9YHqTv6LgZE8jP0KVJC5Wsvyc8wmzhnf9crRG7ej4A@mail.gmail.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 24 May 2024 11:36:45 -0700
Message-ID: <CANx9H-BbTqYwGhd=JqBiFCtnfrf94Hj261SiLZAgJEfUAuw2_g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] add basic b4 config file
To: raj.khem@gmail.com
Cc: Quentin Schulz <quentin.schulz@cherry.de>, foss@0leil.net, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000cc867c06193773b1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 18:37:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16266

--000000000000cc867c06193773b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 11:24=E2=80=AFAM Tim Orling <ticotimo@gmail.com> wr=
ote:

>
>
> On Fri, May 24, 2024 at 9:28=E2=80=AFAM Khem Raj via lists.openembedded.o=
rg
> <raj.khem=3Dgmail.com@lists.openembedded.org> wrote:
>
>> On Fri, May 24, 2024 at 8:33=E2=80=AFAM Quentin Schulz <quentin.schulz@c=
herry.de>
>> wrote:
>> >
>> > Hi Khem,
>> >
>> > On 5/24/24 5:18 PM, Khem Raj via lists.openembedded.org wrote:
>> > > On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via
>> > > lists.openembedded.org <foss=3D0leil.net@lists.openembedded.org> wro=
te:
>> > >>
>> > >> From: Quentin Schulz <quentin.schulz@cherry.de>
>> > >>
>> > >> b4[1] is a very nice tool for mail-based contribution. A config[2]
>> file
>> > >> exists to set up a few defaults. We can use it to set the Cc
>> recipients
>> > >> to always add, in our case the mailing list.
>> > >>
>> > >> This shouldn't be necessary if we had a script that b4 prep
>> --auto-to-cc
>> > >> could call to find the mail address(es) to send to. While we could =
do
>> > >> that, this opens the door to people trying to add a way to notify
>> some
>> > >> people (e.g. a MAINTAINERS file) which is not somewhere the project
>> > >> wants to go right now, and this also makes sure the address is alwa=
ys
>> > >> added even if one forgets to run b4 prep --auto-to-cc (which is par=
t
>> of
>> > >> the typical workflow for U-Boot and Linux kernel, but is not
>> necessary
>> > >> thanks to this patch).
>> > >>
>> > >> [1] https://pypi.org/project/b4/
>> > >> [2] https://b4.docs.kernel.org/en/latest/config.html
>> > >>
>> > >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> > >> ---
>> > >> This adds a basic config file for b4 to avoid to have to add the
>> mailing
>> > >> list by hand. For documentation patches, one will still need to run
>> > >> b4 send --cc docs@lists.yoctoproject.org
>> > >> manually for sending it to the docs ML as well.
>> > >>
>> > >> Note that b4 supports patchwork, c.f.
>> > >>
>> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-s=
ettings
>> > >> though I have no clue what it does with it as I am no maintainer, b=
ut
>> > >> maybe something worth having a look at if some maintainer of this
>> repo
>> > >> wants to use b4 to merge stuff?
>> > >
>> > > I use b4 regularly for meta-openembedded maintenance and it also
>> updates
>> > > patchwork when patch is accepted, I have this config.
>> > >
>> > >     [b4]
>> > >      pw-url =3D "https://patchwork.yoctoproject.org/"
>> > >      pw-key =3D "<mykey>"
>> > >      pw-project =3D "oe"
>> > >      pw-review-state =3D "under-review"
>> > >      pw-accept-state =3D  "accepted"
>> > >      pw-discard-state =3D "rejected"
>> > >      send-series-to =3D "openembedded-devel@lists.openembedded.org"
>>
>
> This inspired me to revisit the issue I was having with "b4 shazam <
> message.id for an AUH upgrade>", where
> shazam would stumble because of the "scissors line" (--- >8 ---)
>
> Turns out the solution appears to be
> [b4]
>     stdin-pipe-sep =3D "--- >8 ---"
>

Correction, where I was having trouble was with "git pw patch apply"

$ git pw patch apply 43726
Failed to apply patch:
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To record the empty patch as an empty commit, run "git am
--allow-empty".
hint: To restore the original branch and stop patching, run "git am
--abort".
hint: Disable this message with "git config advice.mergeConflict false"
Patch is empty.

Whereas "b4 shazam
0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833-000000@us-west-2.amaz=
onses.com"
works:

$ b4 shazam
0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833-000000@us-west-2.amaz=
onses.com
Grabbing thread from
lore.kernel.org/all/0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833-0=
00000@us-west-2.amazonses.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
Retrieving CI status, may take a moment...
---
  =E2=9C=93 [PATCH] nghttp2: upgrading to 1.62.0 SUCCEEDED
  ---
  =E2=9C=93 Signed: DKIM/yoctoproject.org
---
Total patches: 1
---
Applying: nghttp2: upgrade 1.61.0 -> 1.62.0


Any tricks to getting the Message-Id from patchwork?


>
>> > >
>> >
>> > Thanks for the example! Would it make sense for me to add the pw parts
>> > to this patch as well (in a v2 for example)?
>>
>> Maybe, it can be documented like this but I would leave it to the
>> maintainers
>> to promote using b4 not.
>>
>> >
>> > I'm perplexed about the pw-key though. This is very much something we
>> > don't want to version nor potentially leak by mistake. I assume it is
>> > not possible to add to the global ~/.config/git/config or ~/.gitconfig
>> > because the URL would change for example between projects (I assume we
>> > may have a different patchwork for OE and YP, but for sure if people
>> > maintain kernel stuff as well, then they would have one for kernel.org
>> > for example). Mmmm but maybe a simple
>> >
>> > git config b4.pw-key "<mykey>"
>> >
>> > from within the local git repo would be enough :)
>>
>> right, it must be documented clearly. setting up b4 is not simple like a
>> pull
>> request merge.
>>
>> >
>> > BTW, I see you have -to instead of what I sent (-cc), is there a
>> > preference here? (I took Cc since this is what we document in the
>> README).
>>
>> I used --to because at times to field was being left empty.
>> >
>> > Cheers,
>> > Quentin
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#16264):
>> https://lists.openembedded.org/g/bitbake-devel/message/16264
>> Mute This Topic: https://lists.openembedded.org/mt/106281674/924729
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
>> ticotimo@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>

--000000000000cc867c06193773b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 24, 2024 at 11:24=E2=80=
=AFAM Tim Orling &lt;<a href=3D"mailto:ticotimo@gmail.com">ticotimo@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 24, 2024 at 9:28=E2=80=
=AFAM Khem Raj via <a href=3D"http://lists.openembedded.org" target=3D"_bla=
nk">lists.openembedded.org</a> &lt;raj.khem=3D<a href=3D"mailto:gmail.com@l=
ists.openembedded.org" target=3D"_blank">gmail.com@lists.openembedded.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Fri, May 24, 2024 at 8:33=E2=80=AFAM Quentin Schulz &lt;<a href=3D"mailto:=
quentin.schulz@cherry.de" target=3D"_blank">quentin.schulz@cherry.de</a>&gt=
; wrote:<br>
&gt;<br>
&gt; Hi Khem,<br>
&gt;<br>
&gt; On 5/24/24 5:18 PM, Khem Raj via <a href=3D"http://lists.openembedded.=
org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a> wrote:=
<br>
&gt; &gt; On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via<br>
&gt; &gt; <a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" targ=
et=3D"_blank">lists.openembedded.org</a> &lt;foss=3D<a href=3D"mailto:0leil=
.net@lists.openembedded.org" target=3D"_blank">0leil.net@lists.openembedded=
.org</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; From: Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@che=
rry.de" target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; b4[1] is a very nice tool for mail-based contribution. A conf=
ig[2] file<br>
&gt; &gt;&gt; exists to set up a few defaults. We can use it to set the Cc =
recipients<br>
&gt; &gt;&gt; to always add, in our case the mailing list.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This shouldn&#39;t be necessary if we had a script that b4 pr=
ep --auto-to-cc<br>
&gt; &gt;&gt; could call to find the mail address(es) to send to. While we =
could do<br>
&gt; &gt;&gt; that, this opens the door to people trying to add a way to no=
tify some<br>
&gt; &gt;&gt; people (e.g. a MAINTAINERS file) which is not somewhere the p=
roject<br>
&gt; &gt;&gt; wants to go right now, and this also makes sure the address i=
s always<br>
&gt; &gt;&gt; added even if one forgets to run b4 prep --auto-to-cc (which =
is part of<br>
&gt; &gt;&gt; the typical workflow for U-Boot and Linux kernel, but is not =
necessary<br>
&gt; &gt;&gt; thanks to this patch).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; [1] <a href=3D"https://pypi.org/project/b4/" rel=3D"noreferre=
r" target=3D"_blank">https://pypi.org/project/b4/</a><br>
&gt; &gt;&gt; [2] <a href=3D"https://b4.docs.kernel.org/en/latest/config.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://b4.docs.kernel.org/en/late=
st/config.html</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Quentin Schulz &lt;<a href=3D"mailto:quentin.s=
chulz@cherry.de" target=3D"_blank">quentin.schulz@cherry.de</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt; This adds a basic config file for b4 to avoid to have to add =
the mailing<br>
&gt; &gt;&gt; list by hand. For documentation patches, one will still need =
to run<br>
&gt; &gt;&gt; b4 send --cc <a href=3D"mailto:docs@lists.yoctoproject.org" t=
arget=3D"_blank">docs@lists.yoctoproject.org</a><br>
&gt; &gt;&gt; manually for sending it to the docs ML as well.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Note that b4 supports patchwork, c.f.<br>
&gt; &gt;&gt; <a href=3D"https://b4.docs.kernel.org/en/latest/config.html#p=
atchwork-integration-settings" rel=3D"noreferrer" target=3D"_blank">https:/=
/b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings</a=
><br>
&gt; &gt;&gt; though I have no clue what it does with it as I am no maintai=
ner, but<br>
&gt; &gt;&gt; maybe something worth having a look at if some maintainer of =
this repo<br>
&gt; &gt;&gt; wants to use b4 to merge stuff?<br>
&gt; &gt;<br>
&gt; &gt; I use b4 regularly for meta-openembedded maintenance and it also =
updates<br>
&gt; &gt; patchwork when patch is accepted, I have this config.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0[b4]<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-url =3D &quot;<a href=3D"https://patchwork=
.yoctoproject.org/" rel=3D"noreferrer" target=3D"_blank">https://patchwork.=
yoctoproject.org/</a>&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-key =3D &quot;&lt;mykey&gt;&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-project =3D &quot;oe&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-review-state =3D &quot;under-review&quot;<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-accept-state =3D=C2=A0 &quot;accepted&quot=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pw-discard-state =3D &quot;rejected&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 send-series-to =3D &quot;<a href=3D"mailto:op=
enembedded-devel@lists.openembedded.org" target=3D"_blank">openembedded-dev=
el@lists.openembedded.org</a>&quot;<br></blockquote><div><br></div><div>Thi=
s inspired me to revisit the issue I was having with &quot;b4 shazam &lt;<a=
 href=3D"http://message.id" target=3D"_blank">message.id</a> for an AUH upg=
rade&gt;&quot;, where</div><div>shazam would stumble because of the &quot;s=
cissors line&quot; (--- &gt;8 ---)</div><div><br></div><div>Turns out the s=
olution appears to be<br>[b4]<br>=C2=A0 =C2=A0 stdin-pipe-sep =3D &quot;---=
 &gt;8 ---&quot;</div></div></div></blockquote><div><br></div><div>Correcti=
on, where I was having trouble was with &quot;git pw patch apply&quot;<br><=
br></div><div>$ git pw patch apply 43726<br>Failed to apply patch:<br>hint:=
 When you have resolved this problem, run &quot;git am --continue&quot;.<br=
>hint: If you prefer to skip this patch, run &quot;git am --skip&quot; inst=
ead.<br>hint: To record the empty patch as an empty commit, run &quot;git a=
m --allow-empty&quot;.<br>hint: To restore the original branch and stop pat=
ching, run &quot;git am --abort&quot;.<br>hint: Disable this message with &=
quot;git config advice.mergeConflict false&quot;<br>Patch is empty.</div><d=
iv><br></div><div>Whereas &quot;b4 shazam=C2=A0<span style=3D"color:rgb(0,0=
,51);font-size:13px"><a href=3D"mailto:0101018f7d589796-87eb5d6d-06ed-4275-=
b5bc-6bad87216833-000000@us-west-2.amazonses.com">0101018f7d589796-87eb5d6d=
-06ed-4275-b5bc-6bad87216833-000000@us-west-2.amazonses.com</a>&quot; works=
:</span></div><div><span style=3D"color:rgb(0,0,51);font-size:13px"><br></s=
pan>$ b4 shazam <a href=3D"mailto:0101018f7d589796-87eb5d6d-06ed-4275-b5bc-=
6bad87216833-000000@us-west-2.amazonses.com">0101018f7d589796-87eb5d6d-06ed=
-4275-b5bc-6bad87216833-000000@us-west-2.amazonses.com</a><br>Grabbing thre=
ad from <a href=3D"http://lore.kernel.org/all/0101018f7d589796-87eb5d6d-06e=
d-4275-b5bc-6bad87216833-000000@us-west-2.amazonses.com/t.mbox.gz">lore.ker=
nel.org/all/0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833-000000@us=
-west-2.amazonses.com/t.mbox.gz</a><br>Checking for newer revisions<br>Grab=
bing search results from <a href=3D"http://lore.kernel.org">lore.kernel.org=
</a><br>Analyzing 1 messages in the thread<br>Checking attestation on all m=
essages, may take a moment...<br>Retrieving CI status, may take a moment...=
<br>---<br>=C2=A0 =E2=9C=93 [PATCH] nghttp2: upgrading to 1.62.0 SUCCEEDED<=
br>=C2=A0 ---<br>=C2=A0 =E2=9C=93 Signed: DKIM/<a href=3D"http://yoctoproje=
ct.org">yoctoproject.org</a><br>---<br>Total patches: 1<br>---<br>Applying:=
 nghttp2: upgrade 1.61.0 -&gt; 1.62.0</div><div><br></div><div><br></div><d=
iv>Any tricks to getting the Message-Id from patchwork?</div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cl=
ass=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
&gt; &gt;<br>
&gt;<br>
&gt; Thanks for the example! Would it make sense for me to add the pw parts=
<br>
&gt; to this patch as well (in a v2 for example)?<br>
<br>
Maybe, it can be documented like this but I would leave it to the maintaine=
rs<br>
to promote using b4 not.<br>
<br>
&gt;<br>
&gt; I&#39;m perplexed about the pw-key though. This is very much something=
 we<br>
&gt; don&#39;t want to version nor potentially leak by mistake. I assume it=
 is<br>
&gt; not possible to add to the global ~/.config/git/config or ~/.gitconfig=
<br>
&gt; because the URL would change for example between projects (I assume we=
<br>
&gt; may have a different patchwork for OE and YP, but for sure if people<b=
r>
&gt; maintain kernel stuff as well, then they would have one for <a href=3D=
"http://kernel.org" rel=3D"noreferrer" target=3D"_blank">kernel.org</a><br>
&gt; for example). Mmmm but maybe a simple<br>
&gt;<br>
&gt; git config b4.pw-key &quot;&lt;mykey&gt;&quot;<br>
&gt;<br>
&gt; from within the local git repo would be enough :)<br>
<br>
right, it must be documented clearly. setting up b4 is not simple like a pu=
ll<br>
request merge.<br>
<br>
&gt;<br>
&gt; BTW, I see you have -to instead of what I sent (-cc), is there a<br>
&gt; preference here? (I took Cc since this is what we document in the READ=
ME).<br>
<br>
I used --to because at times to field was being left empty.<br>
&gt;<br>
&gt; Cheers,<br>
&gt; Quentin<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16264): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16264" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16264</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/106281674/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/106281674/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--000000000000cc867c06193773b1--

