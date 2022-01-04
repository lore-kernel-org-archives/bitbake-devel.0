Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CB9C4332F
	for <webhook@archiver.kernel.org>; Tue,  4 Jan 2022 09:56:34 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by mx.groups.io with SMTP id smtpd.web09.4802.1641290194168543318
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jan 2022 01:56:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=RqNhKlUs;
 spf=pass (domain: gmail.com, ip: 209.85.222.52,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f52.google.com with SMTP id u6so54872261uaq.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Jan 2022 01:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csiHguC6wvlyUBzBGvfHHobsdsUsD1QmakCicv8/rOo=;
        b=RqNhKlUsJewVDMjjuJPcnXNl/VydgDLNNo+Y3Zk1kDVKQGre3DkH1tY6RxDsbuZxJr
         TurqbseB4sQs237lYa2qwyxhBtaWTrV9G1xQm6dA6bpt35lUbfXg4AdqPBUqBxx2OI5K
         C/FRmUd7GcGmCoNn8376a5JZbyRoOgWnqPRa48d71V8p55VDx4iwOONezsC6KUNC9U08
         URXMqYJaZA7Rjq3Vo90YGeQyVmbZpcYToIzEOzCmIZLByXca2hlkhUR4cNK/DQNRh3xM
         wfdPynsq2Ofmf5Pm+RL8twFGcYGxkZ57WgXAGVIELWwhyOaq3kJ0xXPcmecx0skcqyLP
         ziBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csiHguC6wvlyUBzBGvfHHobsdsUsD1QmakCicv8/rOo=;
        b=RE5VTHcyJoMK8PiqYSgiTbX/pg3BIm91wPVsDFtPwhF09goSjT+NPpPMuIq2KOwLr3
         B87kU8RZ1BrnniTGM1ufoXyF9v9cPPHAap0GVJXAJ1NgAbeOTk03M5H1+8nXI2Y7YQlB
         rBQMwJbpvI4KR/0b5AymyXodU2cF1KBy3mSjJgFJRcfvHa9NcW8xu17ul3WVBA/jmPhR
         1iyJ7spfae45N5cRRgkPqa6gniuL0vfnc679IbJ3DMPOReq4qIsLU8A8NBmoLEbLqqs5
         hSBCWQBJrbgUmKUAzT2xXYcNUliLHYZHAI/XfdJAz0GfojT9HGgpDqdYjKEu/z5gtK8X
         jTmw==
X-Gm-Message-State: AOAM533Cuk0QJOJ6eXR8fgay/qKlIKE/vbOBgCT4jpgvJpQCxRQ8ZSRf
	dFTZ5W6CDrsAkRFyvfSgIEeylyUAAYyvIHcz49c=
X-Google-Smtp-Source: 
 ABdhPJyc/SWDz81oL2+8xNlFoEuBVMWl3BJEfRhH+bPcIAQ1k0DCJ41A0mEv7Xe03c8NGT0vtc/0qpbYWtBnfE+hW78=
X-Received: by 2002:a67:c81c:: with SMTP id u28mr14573605vsk.38.1641290193243;
 Tue, 04 Jan 2022 01:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20220101112911.1866500-1-alex@linutronix.de>
 <2ec888840075cdb4a9d9883492b3ebf62654c085.camel@linuxfoundation.org>
 <CANNYZj9eAay6ka5o=LMOPNPAdQ7a=vv7PyoxvrEoo36w==mBuA@mail.gmail.com>
 <f80391bccd5070fed6d7d7196bba726459ff9146.camel@linuxfoundation.org>
 <16C7082A88BDA2A4.18901@lists.openembedded.org>
In-Reply-To: <16C7082A88BDA2A4.18901@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 4 Jan 2022 10:56:22 +0100
Message-ID: 
 <CANNYZj_WvFu5nhvVzqC+PhMqo-6SQo8dt0-3Dr5TKfcW=1DjmQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] providers.py: do not skip recipes
 providing 'virtual/x' in world builds
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="000000000000f1112205d4bea694"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jan 2022 09:56:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13219

--000000000000f1112205d4bea694
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jan 2022 at 10:46, Alexander Kanavin via lists.openembedded.org
<alex.kanavin=gmail.com@lists.openembedded.org> wrote:

> Most of these would be have things depending on them and therefore would
> get
>
>> built anyway. If they don't, they're probably not "useful" in the world
>> build
>> context so I still think the code is actually doing what was intended?
>>
>
> The issue here is not a build for purposes of populating another sysroot
> (without packaging for target), the issue is that there's no guarantee
> anything here would end up in package deploy and thus be tested for
> reproducibility. How should we solve this? I'd still want to drop the world
> skipping (given that it does not actually exclude non-useful alternatives).
> I would reluctantly agree to '-k universe' too in the repro test.
>

As a specific example, go-runtime is already part of the world builds
because it's needed by go-helloworld - but only up to do_populate_sysroot.
do_package and later simply do not run due to being excluded from world.
What to do that doesn't require maintaining a list of such items manually?

Alex

--000000000000f1112205d4bea694
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, 4 Jan 2022 at 10:46, Alexander Kanavin via <a href=3D"http:/=
/lists.openembedded.org">lists.openembedded.org</a> &lt;alex.kanavin=3D<a h=
ref=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedde=
d.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div class=3D"gmail_quote">Most of these would be hav=
e things depending on them and therefore would get<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
built anyway. If they don&#39;t, they&#39;re probably not &quot;useful&quot=
; in the world build<br>
context so I still think the code is actually doing what was intended?<br><=
/blockquote></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_=
quote">The issue here is not a build for purposes of populating another sys=
root (without packaging for target), the issue is that there&#39;s no guara=
ntee anything here would end up in package deploy and thus be tested for re=
producibility. How should we solve this? I&#39;d still want to drop the wor=
ld skipping (given that it does not actually exclude non-useful alternative=
s). I would reluctantly agree to &#39;-k universe&#39; too in the repro tes=
t.</div></div></blockquote></div><div class=3D"gmail_quote"><br></div><div =
class=3D"gmail_quote">As a specific example, go-runtime is already part of =
the world builds because it&#39;s needed by go-helloworld - but only up to =
do_populate_sysroot. do_package and later simply do not run due to being ex=
cluded from world. What to do that doesn&#39;t require maintaining a list o=
f such items manually?<br></div><div class=3D"gmail_quote"><br></div><div c=
lass=3D"gmail_quote">Alex<br></div></div>

--000000000000f1112205d4bea694--

