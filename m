Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
 by mx.groups.io with SMTP id smtpd.web11.36209.1584903310133632130
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2020 11:55:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Q3HktN62;
 spf=pass (domain: gmail.com, ip: 209.85.160.196, mailfrom: raj.khem@gmail.com)
Received: by mail-qt1-f196.google.com with SMTP id c9so2845692qtw.7
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2020 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B/TwMEbK6fJymJiUwRZU1J1ptsSRZ5QOfvRpcIBhfRU=;
        b=Q3HktN627Jxf1aiAuc1eqDzwXOkA0VRr3K5zhLaHOXPGIgctCb/c98yaXNOGnHUZrB
         mLaqm4MXTJqkx6SrBAoIJXArj7mmCifUCJhqwXTkiOlTnsc4PRDSfCGHR1tnssZCKJZG
         ODUahIINwxqxx20WGJTpz2fBAGc//IiX3zTPKHNK77tGTtaJJ2ZF/bVfdXdtZS4hngQi
         ipSNEV6aH1Ok2TqG5I9U8fvdKRKTVJbRoq9ezV714dsnI0fWWS4ypvtb/YokA9ueXK/O
         Pdm2ZCkbjhPhuaUGDUoO/OtJoukz77tgGDQtvF7WFmLD94Lvt/YCisWP8kd7OjFYgYvm
         4cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B/TwMEbK6fJymJiUwRZU1J1ptsSRZ5QOfvRpcIBhfRU=;
        b=aQiSPbrh1FxA6kLyd6SdRbaQNkEWUuLYRqMVYDakFBFbReIh5PABykp/fOj6mtE9Q4
         vo+E6QRo5YDWZ4PrnUToTMQxgO/8mKnE2FtMSHSrv4pzixjUf7rTZB1xldz0He+bbwgz
         b0mMLS8K4jEk7jaT4XP85AC4x3ElyWhhrGd2N3c0z9uLDzGBodHKYsmhcxcwdbObuGXJ
         T4Bi4slfXg+stPRvAwdeMdNJTacQDz+SIyRyUqFEkVmoHsRcNI5b6Ml+ua2ashBx5Tvf
         vRUtXyPd++fhHDJ0na8sdYsozfIshKFXn7S/DedPYmfN7wv4X9sTK5KUGTf9YhxTHGNW
         Ssgw==
X-Gm-Message-State: ANhLgQ2sE3vZ9gX8dhk3PSzuTG69+yXFfEedxIjPuZ8h7kFbB7Ip/OWY
	WmQCMaVe7D6G4MR7obEwcKFV07WGKzoAtpW+Fiw=
X-Google-Smtp-Source: ADFU+vs0SLDxflgtsopceR/GlISMRTOL2uhNrUgz5Psfz7qWUUtYCOwMHNC3Ne+tGWCN+6PywDIsPwQ8w0yIZU1n70c=
X-Received: by 2002:ac8:17f9:: with SMTP id r54mr17917905qtk.285.1584903309111;
 Sun, 22 Mar 2020 11:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200215032955.3958-3-pkj@axis.com> <5532.1584827063458682607@lists.openembedded.org>
 <1cdd50184c1f4af488baee9ee691b495@XBOX03.axis.com> <CAMKF1srOQVRW8n9bzr9GXiA3NBOX=cE5EV-W9S_dq+JFRqNjMQ@mail.gmail.com>
 <2f891d304ee448538457d2b94c32bba3@XBOX03.axis.com> <0fa4ecce8452d9f015c00afe29710c45e5328899.camel@linuxfoundation.org>
In-Reply-To: <0fa4ecce8452d9f015c00afe29710c45e5328899.camel@linuxfoundation.org>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Sun, 22 Mar 2020 11:54:42 -0700
Message-ID: <CAMKF1spR4qGxt+LBKAEiT2rOcxCwRgGMusvi64yUAajn+8DVbQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2020 at 1:56 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Sun, 2020-03-22 at 00:38 +0000, Peter Kjellerstedt wrote:
> > > -----Original Message-----
> > > From: Khem Raj <raj.khem@gmail.com>
> > > Sent: den 22 mars 2020 00:59
> > > To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > > Cc: bitbake-devel@lists.openembedded.org
> > > Subject: Re: [bitbake-devel] [master][zeus][PATCH 3/3] fetch2: Allow
> > > ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
> > >
> > > On Sat, Mar 21, 2020 at 4:50 PM Peter Kjellerstedt
> > > <peter.kjellerstedt@axis.com> wrote:
> > > > Rather than blindly reverting, can=E2=80=99t we update the document=
ation
> > > > instead? If you use ${AUTOREV} you obviously do it because you alwa=
ys want
> > > > the latest revision.
> > >
> > > Autorev + clear srcrev policy if you want that
> >
> > Well, obviously ${AUTOREV} works with BB_SRCREV_POLICY =3D "clear". But
> > BB_SRCREV_POLICY is a distro configuration and it is not possible to ov=
erride
> > it per recipe.
>
> BB_SRCREV_POLICY is quite an old piece of code and its design has
> issues. It should really be changed to work per recipe (and use
> something other than persist db but that is another story).
>

Right, I agree lets keep it as it is.

> >  Which means that if it is set to "cache", it is not possible
> > to use ${AUTOREV}. This is not documented, and to the developers it wil=
l look
> > as if it is working, since it fetches the very first time the recipe is=
 built.
> > But there will be no updates, so it is as useful as setting SRCREV =3D =
"master"
> > (which some of our developers also have tried before being educated to =
how
> > BitBake works)...
> >
> > > > Before this change, using ${AUTOREV} in combination with
> > > > BB_SRCREV_POLICY =3D "cache" didn=E2=80=99t work, which also wasn=
=E2=80=99t documented.
> > >
> > > It could be interpreted also that cache also caches AUTOREVs
> > > this will break downstream projects. Its equivalent of ABI change,
> > > that perhaps will do more harm then what it fixes.
> >
> > I fail to see how it will break stuff as it was not possible to use ${A=
UTOREV}
> > before in a meaningful way together with BB_SRCREV_POLICY =3D "cache".
>
> It gives a behaviour people asked for and need under certain scenarios.
> I appreciate that isn't yours. I should not have merged the patch as it
> breaks behaviour that people do use and I misunderstood what the patch
> was doing :(.
>
> The question is where from here, technically a revert is justified but
> I do understand the per recipe configuration issue.

I think there are large usecases depending on current behaviour. While
RDK will migrate away
from AUTOREVs but this is not happening in 3.1 time frame and there
are other projects perhaps
who are in same boat.

>
> Cheers,
>
> Richard
>
