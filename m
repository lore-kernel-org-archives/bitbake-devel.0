Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A24C47258
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 19:39:05 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web10.1444.1705088344334706988
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 11:39:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HyzzTwnP;
 spf=pass (domain: gmail.com, ip: 209.85.128.170, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5fa52e173f7so37017987b3.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705088343; x=1705693143; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5DGjJPRoAu3Z4yJwYP25ppZv18YIU6gyCfoqrnOS5k=;
        b=HyzzTwnPTB8HVz3jPOQCOdUEyTj+gs0+N+oD6kMbjmk1h8mqlCBgK01zaChrYtNWk/
         F6ESC5nMDRr81QE8eb619G5kpoiU4Gsb92H7h+WY54AbcsIdMs4VdDA5YPyod/Ugoedx
         A+J/HMkp3WK8CxlKfQDaLisqQ8dyixeipS0wIWg1vvWqEv47lI+yCTYyzx7WM9KPYqbK
         8xWILUtSUSo+MPWLHcqo+nqCoMafvmMWGGeUypVB+fx0Qm5FJ1yBc8N6+g+2uCmILeN1
         vaWgqVhmMMSSXOYKLq/nu9S8wFo/LdOBl0c/pqMfakqqTD+X4S6ILliFCq6CUIRgBqri
         7k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088343; x=1705693143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5DGjJPRoAu3Z4yJwYP25ppZv18YIU6gyCfoqrnOS5k=;
        b=CvEBlbxLysmMB0eAWvkXQiG+mrq4FCWw529TcQf6Gxh0OTuZiskUX88V9C39RheMdL
         SYkb4OrvSr+gUSkbFXnIwKNSlTYUFcvnXxBMJkGoOATUtqIZLUkOzYB5EkVzNHVtLtL/
         UxjcH8gw4a2P2kCFa3n8CPSW42ik++14g+zrjk4Zjl5pXtxcBa6UL5pU1wtFPo1X1KAl
         PDMv+0buURulFjjy2CQMNdI7DABemh9lnQe3Ft1kMQPsY6wejgB+0R8Pe41e0tS8xUUp
         g08xyuTTGoQlR3/A/faOo6QStXrw/GGnbLkwkTiIeKuVJSr0k8bGSXhiE0LNRnIZhN/p
         CR/A==
X-Gm-Message-State: AOJu0Yz+hchKbWLI6L2lS7UiPnjk2UFQwuTrOm8r+iBhXOuNRRAjB+/t
	gwDJ9yCjvnykb4Ez0RkV+sdEcPYzkDwy/48CGDk=
X-Google-Smtp-Source: AGHT+IF+HhI9wXeIFDzwWIZbhNem4+i15ojs4/Q4cSQRgOnTq+RD/H589vCn2nLqtmMF8Bo+5r3Pa1xr/22hapkp5Qw=
X-Received: by 2002:a81:4e81:0:b0:5f7:7de:2c4b with SMTP id
 c123-20020a814e81000000b005f707de2c4bmr1816843ywb.51.1705088343274; Fri, 12
 Jan 2024 11:39:03 -0800 (PST)
MIME-Version: 1.0
References: <81d4da494bd7b892c906e82caee977ef986b98c3.camel@linuxfoundation.org>
In-Reply-To: <81d4da494bd7b892c906e82caee977ef986b98c3.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 12 Jan 2024 11:38:51 -0800
Message-ID: <CANx9H-D04js=yt99nUqOFH1RX3SBMm0uPejX4H574pdYbp1bzA@mail.gmail.com>
Subject: Re: [Toaster] My notes on importing commandline builds into toaster
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	Mohammed Raza <mohammed.raza@savoirfairelinux.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	"toaster@lists.yoctoproject.org" <toaster@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="00000000000002fa60060ec4d15d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 19:39:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15793

--00000000000002fa60060ec4d15d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 7:40=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Since we now have toaster back and operational and able to import
> commandline builds, and we have a usecase where this might be useful, I
> thought I'd try it and see what works/doesn't work.
>
> Alex Kanavin mentioned this build has issues:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/88/builds/3515
>
> I went in and saved the eventlog:
>
> https://autobuilder.yocto.io/pub/failed-builds-data/20240112030913.json.z=
st
>
> then I tried to import this into a locally running instance of toaster.
> I had to compress/decompress the file as it was large.
>
> Toaster failed locally to import the build with no error given on the
> UI. Form the commandline it became clear it was trying to do "mkdir
> /home/pokybuild" which clearly isn't my local username. I created the
> directory just to move past this.
>
> The build then imported from the commandline. The issues I noticed were
> then:
>
> * the build duration was incorrect as it timed the event replay rather
> than the original build
> * toaster.bbclass wasn't included so the layerconfig is missing
> * buildstats info was missing as those weren't present
> * log links don't work as I didn't download the logs locally
> * the UI doesn't use any of the event timestamp data, just that from
> buildstats.
> * the cooker log is the replayed cooker log rather than the original
> one
> * trying to view logs results in tracebacks
>
> Unfortunately toaster doesn't display start/end times of the task and
> doesn't let you view the events themselves so it wasn't so useful for
> what I wanted to look into. You can get the task ordering if you add
> that field to the display (it isn't there by default) which did help a
> bit.
>
> I did save the buildstats so I could try a second run with more data:
>
> https://autobuilder.yocto.io/pub/failed-builds-data/stats.tgz
>
> Since I'm documenting this, I may as well save the logs too:
>
> tar -czf stats2.tgz buildstats log work/*/*/*/temp/
>
> https://autobuilder.yocto.io/pub/failed-builds-data/stats2.tgz
>
> Sadly even with that data restored to the correct place, it didn't load
> into the system correctly for some reason. I realised this may be
> because I didn't have the json eventlog in situ so retried again with
> that in the original build path but that didn't improve anything.
>
> I also realised toaster does read the packageinfo task data which I
> didn't have present so package information wasn't added.
>
> All in all, an interesting learning experience and we've some work to
> to do improve the experience here.
>

Thank you for capturing this. It will be invaluable in any attempts to
improve the features.

>
> Cheers,
>
> Richard
>
>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#6142):
> https://lists.yoctoproject.org/g/toaster/message/6142
> Mute This Topic: https://lists.yoctoproject.org/mt/103684954/924729
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000002fa60060ec4d15d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Jan 12, 2024 at 7:40=E2=80=AFAM Richard Purdie &lt;=
<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxf=
oundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;padding-left:1ex;border-left-color:rgb(204,204,204)">Since we now have to=
aster back and operational and able to import<br>
commandline builds, and we have a usecase where this might be useful, I<br>
thought I&#39;d try it and see what works/doesn&#39;t work.<br>
<br>
Alex Kanavin mentioned this build has issues:<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/88/build=
s/3515" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproje=
ct.org/typhoon/#/builders/88/builds/3515</a><br>
<br>
I went in and saved the eventlog:<br>
<br>
<a href=3D"https://autobuilder.yocto.io/pub/failed-builds-data/202401120309=
13.json.zst" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yocto=
.io/pub/failed-builds-data/20240112030913.json.zst</a><br>
<br>
then I tried to import this into a locally running instance of toaster.<br>
I had to compress/decompress the file as it was large.<br>
<br>
Toaster failed locally to import the build with no error given on the<br>
UI. Form the commandline it became clear it was trying to do &quot;mkdir<br=
>
/home/pokybuild&quot; which clearly isn&#39;t my local username. I created =
the<br>
directory just to move past this.<br>
<br>
The build then imported from the commandline. The issues I noticed were<br>
then:<br>
<br>
* the build duration was incorrect as it timed the event replay rather<br>
than the original build<br>
* toaster.bbclass wasn&#39;t included so the layerconfig is missing<br>
* buildstats info was missing as those weren&#39;t present<br>
* log links don&#39;t work as I didn&#39;t download the logs locally<br>
* the UI doesn&#39;t use any of the event timestamp data, just that from<br=
>
buildstats.<br>
* the cooker log is the replayed cooker log rather than the original<br>
one<br>
* trying to view logs results in tracebacks<br>
<br>
Unfortunately toaster doesn&#39;t display start/end times of the task and<b=
r>
doesn&#39;t let you view the events themselves so it wasn&#39;t so useful f=
or<br>
what I wanted to look into. You can get the task ordering if you add<br>
that field to the display (it isn&#39;t there by default) which did help a<=
br>
bit.<br>
<br>
I did save the buildstats so I could try a second run with more data:<br>
<br>
<a href=3D"https://autobuilder.yocto.io/pub/failed-builds-data/stats.tgz" r=
el=3D"noreferrer" target=3D"_blank">https://autobuilder.yocto.io/pub/failed=
-builds-data/stats.tgz</a><br>
<br>
Since I&#39;m documenting this, I may as well save the logs too:<br>
<br>
tar -czf stats2.tgz buildstats log work/*/*/*/temp/<br>
<br>
<a href=3D"https://autobuilder.yocto.io/pub/failed-builds-data/stats2.tgz" =
rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yocto.io/pub/faile=
d-builds-data/stats2.tgz</a><br>
<br>
Sadly even with that data restored to the correct place, it didn&#39;t load=
<br>
into the system correctly for some reason. I realised this may be<br>
because I didn&#39;t have the json eventlog in situ so retried again with<b=
r>
that in the original build path but that didn&#39;t improve anything.<br>
<br>
I also realised toaster does read the packageinfo task data which I<br>
didn&#39;t have present so package information wasn&#39;t added.<br>
<br>
All in all, an interesting learning experience and we&#39;ve some work to<b=
r>
to do improve the experience here.<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you for ca=
pturing this. It will be invaluable in any attempts to improve the features=
.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)"><br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#6142): <a href=3D"https://lists.yoctoproject.org/g/toas=
ter/message/6142" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctop=
roject.org/g/toaster/message/6142</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/103684954/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/103684954/924729</a><br>
Group Owner: <a href=3D"mailto:toaster%2Bowner@lists.yoctoproject.org" targ=
et=3D"_blank">toaster+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/toaster/unsub" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/toaster/=
unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo=
@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--00000000000002fa60060ec4d15d--

