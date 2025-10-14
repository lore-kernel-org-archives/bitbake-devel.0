Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C385CCD18E
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 20:08:29 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web11.5951.1760472501481943988
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Oct 2025 13:08:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CyxPHlC2;
 spf=pass (domain: gmail.com, ip: 209.85.128.177, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-780fe73e337so69225177b3.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Oct 2025 13:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760472500; x=1761077300; darn=lists.openembedded.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by3gEkAlb3ujrCSUO6zp1xtYUxfesfkSZ+RKaEve6k4=;
        b=CyxPHlC20sliPvFt03nP9VbRM7+G4A0V840RS160uxVXEptkcZdsSMZv2/3RT2hsbf
         xtoINY2n8QkENTrmAMGB4rtcjbA/k74N7B9VfLbQume1w6Ldgt2/bh6MgpWIdOPolKKK
         3DXNOs1gBQ6IdO2NDVzGs+ZJWMIuz2xW5QNu0x2JLC/GuNkZUwwfv4RAC7pJmWfllJUK
         QNNmqGJogzigjvrMffdqjOfD3ZEmbEzwYf396rdhV1qbwLb8p+g4MuyulQfPcBxvVqgH
         SmIW9RLNaT0rtpPDo+nh5DBj+DzCbSMCGmMY8uFrV3CGW5Xyczsw2EkCsSEyt9vQy/pB
         HaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760472500; x=1761077300;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by3gEkAlb3ujrCSUO6zp1xtYUxfesfkSZ+RKaEve6k4=;
        b=ZJqdKGrlINkVfLnMMUrupdU4Ca9a07BtApiWbAvLSavXbH3oeSzC69X7DIYI5fCV8N
         wj2WDiBGZ+Y1k2ne0P7bSrqQXIHZpKfLUSQ+CPshWuPvaZfbGT7NDWJRdOKTnCVjz0l4
         716/6E2x7QWrdSiOqZZeXW2BYwAcIR/ct1WldC4Z3Vcipf+wuNii/vTx5SzvNIMwYRja
         hfDaiIDWWyRziBIJIzGxLpxQNaiS8SHzYihe5Ner58ZW/JZ+pyzORTKEgVswg3uS/DFL
         /jXi2IGVKw6ih4SZKvUjPhhMj1zELN7SQ1YxfTTU9edBHsPgRejU890PTDJK9NasttGR
         7e6Q==
X-Gm-Message-State: AOJu0YxU2xNHi21i/YLs+IQ0sDSZGI8MyXrVBkcwZGl2WWg1XoOxvO7i
	4s7AYBQFpqFZNyejCMSjijxMDadqGLpRI9wwJbIv18HSR5O72NW4uuIEXp+bkFy3BOP52G9rr73
	Ac9zSpxlyoUd7P3ygTbPFcbel5AJV1h6nyA==
X-Gm-Gg: ASbGncsckx2jWsdcCkWK8cD3NoCS96Rdi/nNavzGf6S74Zbt1XW/h9glEWEPTxOmJxJ
	KHd7IJvOv2PK9eCDTeIfK/sz0OEPcd4dBa7seBSrpLNgZCjtxYZ4sOL4nU05BUTqXe0Hk2bpvOY
	rTg766gByGPkrJl1zV5d8hLQZJ0uiX2sMCwDtuMXpy61IOTZ5n1XmUfj9p8e3b3Rb6CywO5NR5Z
	adK+u651FX7b44w2HXV9QaMRz7L/oiBvFtKVyOGdX+EAS+KbBI=
X-Google-Smtp-Source: AGHT+IEWeuA+kkad+ijAsjNFERb9uzeDKvcl6cFLXcoxf72wtrid+B9H4RQK7OZBsPKH6j89An+32kjW3hl5X9bDCvo=
X-Received: by 2002:a05:690e:1a5e:b0:635:4ecd:759c with SMTP id
 956f58d0204a3-63ccb8dba6emr17385037d50.42.1760472500192; Tue, 14 Oct 2025
 13:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com> <CAJdd5GbA5G+2of5NzN52gFP0iYGp=Q+q5cQTn7gXv_zY_FEpXw@mail.gmail.com>
In-Reply-To: <CAJdd5GbA5G+2of5NzN52gFP0iYGp=Q+q5cQTn7gXv_zY_FEpXw@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Tue, 14 Oct 2025 14:08:09 -0600
X-Gm-Features: AS18NWBwzIWQ0hYhKsJVUkmJpWMrd0jzOIKbBWUcipNi_72rXfVbBw-kJ1UlB3g
Message-ID: <CAJdd5GbWr4izQ8J4Lkt66-+JZk62GBJMxZCekTrGU0by+OjeGA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Oct 2025 20:08:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18182

On Mon, Oct 6, 2025 at 4:37=E2=80=AFPM Joshua Watt <jpewhacker@gmail.com> w=
rote:
>
> Any update on this? I'm still getting a lot of internal questions
> asking if it's going to be merged or not.

Following up from the Yocto Technical Call:

The suggestion was made in the Yocto Technical Call to try a pattern
like this to allow version specific include files:

 $ cat openssl_%.bbappend
 require openssl_${PV}.inc

I did try this, but it doesn't work as expected. The main problem is
that _at parse time_ (when I need it), PV is "%" because that is the
name of the actual file being parsed. Thus, this ends up looking for a
file named "openssl_%.inc", which doesn't really do me any good.

Of note: When used in a task, PV does take the value of the actual
recipe version, but, again, that doesn't help me.

The next suggestion was to look at the BBINCLUDED list to find the
name of the current .bb file being parsed.This unfortunately has a
similar problem; at parse time BBINCLUDED doesn't contain the name of
the current .bb file being parsed (it does when running a task
however, so it shows up when you do e.g. `bitbake -e openssl`).

As far as I've found, there isn't any variable or mechanism to get
either the file name of the base bb file name, or the version _at
parse time_, unless someone is aware of something else I should look
at?

>
> On Tue, Jul 29, 2025 at 8:49=E2=80=AFAM Joshua Watt <jpewhacker@gmail.com=
> wrote:
> >
> > Implements a new layer-specific variable called
> > BB_DANGLINGAPPENDS_IGNORE. This variable is similar to the removed
> > BB_DANGLINGAPPENDS_WARNONLY, except that it is scoped to a specific
> > layer, and it also causes appends to be completely ignored instead of
> > warning about them.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> > BACKGROUND AND RATIONAL:
> >
> > I was fully on board with removing BB_DANGLINGAPPENDS_WARNONLY, since i=
t
> > was pretty bad that it operated on all layers if any layer set the
> > variable. However, I did mention at the time that it was going to cause
> > us some trouble, but not wanting to hold up a good change, I indicated
> > that I would attempt a fix for it later. Later is now :)
> >
> > After much poking around in our setup and deliberation, the conclusion
> > that I came to is that we do actually need _something_ along the lines
> > of being able to ignore dangling appends, at least in a few specific
> > layers.
> >
> > Our setup is that we have a "disto" layer that we need to maintain
> > against several version of Yocto at once. In this disto layer, we make
> > policy choices that sometimes are tied to a specific version of a recip=
e
> > found in a specific version of Yocto using a bbappend; and often that
> > version is only in one or two Yocto versions, which means that the
> > bbappend will be dangling in the others.
> >
> > dynamic-layers doesn't work here because we are keying off the Yocto
> > version, not the existence of some layer (unless there is something I'm
> > unaware of).
> >
> > BBMASK is also a less than satisfactory solution (IMHO). Part of the
> > reason we have structured our distro layer in the way we have is to
> > reduce the cognitive overhead required to maintain our dozens of
> > products that more or less need to behave similarly. Keeping all the
> > distro stuff together makes the quite easy to reason about, but having
> > then again to track (probably quite complicated, and possibly
> > per-product) BBMASKs erodes that maintainability.
> >
> > We did go through and eliminate as many dangling appends with other
> > methods as possible, but at the end of the day, we ended up with some
> > for which we didn't really see a viable (and maintainable) solution.
> >
> > I'm open to suggestions if this change is entirely reprehensible, but
> > our primary goal is to keep the maintenance of our cross-yocto distro
> > layer simple.
> >
> > I also decided to simplify this to just ignore dangling BBAPPENDS, sinc=
e
> > I suspect anyone setting this is simply going to ignore the warnings
> > anyway, but that can be changed if there's a strong option to do it
> > differently.
> >
> >  bitbake/lib/bb/cooker.py | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > index 1810bcc604..349e27d538 100644
> > --- a/bitbake/lib/bb/cooker.py
> > +++ b/bitbake/lib/bb/cooker.py
> > @@ -953,7 +953,11 @@ You can also remove the BB_HASHSERVE_UPSTREAM sett=
ing, but this may result in si
> >              appends_without_recipes[mc] =3D []
> >              for _, appendfn in self.collections[mc].bbappends:
> >                  if not appendfn in applied_appends:
> > -                    appends_without_recipes[mc].append(appendfn)
> > +                    layername =3D self.collections[mc].calc_bbfile_pri=
ority(appendfn)[2]
> > +                    ignore =3D self.databuilder.mcdata[mc].getVar("BB_=
DANGLINGAPPENDS_IGNORE_%s" % layername,
> > +                        False) or "no"
> > +                    if ignore.lower() not in ("1", "yes", "true"):
> > +                        appends_without_recipes[mc].append(appendfn)
> >
> >          msgs =3D []
> >          for mc in sorted(appends_without_recipes.keys()):
> > --
> > 2.49.0
> >

