Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C46CA0EC4
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 15:49:27 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
 by mx.groups.io with SMTP id smtpd.web10.51723.1754927360381181129
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 08:49:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aDz6Lb58;
 spf=pass (domain: gmail.com, ip: 209.85.219.172, mailfrom: jpewhacker@gmail.com)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e902849978bso3466409276.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754927359; x=1755532159; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F8uf5Xmo8wLt/eYLJaf1jCKQ+3RhWujE7GNasbcYGXs=;
        b=aDz6Lb58aMzcHaqU+F8QnBnY2xUewzaQiU0keHjJbG9fhoZ4HTC3AJ/PhEuOU30I9Z
         81Dzdl0Yg53hBzdIVy7+Us//h6sa10UI1mjTlzUMiQb61Hll5rsZEcHvPO54CadRs+lU
         bFA95lfMZrM5I90e92rjjB1LQEIIVVgZa674oRqUWZ4hz+5+r9+YBtW1/xTn5GFRN52F
         +YPRs34+a40rmP+RCtKnTTQRs4FnY5Dojo8MEEiqDHER7ZKbyIa2SFjsDOsYlu38wiNH
         ddlA5mieS4uVQhjVFzmdofyJq7tlno/IK+n6WqcAT2iE7qeyfCdg8bjepZRT640kRhyp
         BUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754927359; x=1755532159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8uf5Xmo8wLt/eYLJaf1jCKQ+3RhWujE7GNasbcYGXs=;
        b=i1w6Y33ijV/VRilMxLrFQNlXN7uE2KRsXHpp9IcEgKF1hsKtZfMToc30Av7vUOfVHp
         AlzckWEh8miqDZdybZxEzcC4JVVmOpSKjumcSdR48J4OLREBs8KPpFZvWtG9oxmUlxU6
         WkuctXNiq1iCeHMcdmxKTqtIHaEr5Zbp/dVbeaxqlnnCum/DBOTKLIUXGnky+NZOglrv
         QMd7bqmZQO3bOUXJvoHjE9BHzZ4uibt2dUCcYIa/QMFAGeOeSvxW18fI0FKlcBT+OK9P
         L2+J3l0zisfEgDcu93pdBaKB9ih1LlRaZi8z6c/zBGvlLZ9SD1Gfo3Un7ldeC3CXBhsv
         lgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZbF1f7Ak6lFblxNCXH2WTcq9JI1G9BUS7Gxy+OahaBo6eZBH0yVn8u4n9wCX+HaCbydFzcocffMAN2fSI@lists.openembedded.org
X-Gm-Message-State: AOJu0YwZ0nFQhmz+MrkLnOLJ9pLGlME58x0aT2Zq/LQwVN41j3jqNCi8
	5g9VG29GosXuFuWWFYcRpUJ0hvZ+b2t45s9LLBvJdiDpRUYPhQqMw4ik4I8/IAxvmrxI5JtGHxZ
	jKfd5DCk/Z4WufM0Xi1G8uUlcc9I6G2Q=
X-Gm-Gg: ASbGncupWi0R1I1Bm8BNmnZL6Gk248V0zCXJHAf8qk1oRyj3WDKcX44qTsrzxQcOb8P
	3jX2EoQWPS/RI3khj0FNu6bX9sy7G8Jfeyg0jHyRA0Kf6oY3thVRQSVIRMPJC4FKFIGuKXWqFH5
	H8UzP+IJ3fOkRAOM7eSGMoxodVfJPhrO+U+odhVLKoKeOCnqD/DdiWfJrdkDAjHYBpImGvFoP9U
	GXgMsrsjf1Bm6pN8hS6IQ==
X-Google-Smtp-Source: AGHT+IGGYqZoRPlW6WN0uwPSEmLen3dYWYxagDQ0/VgoZm4YagsD2v2HHCqiEdvvVCLFmRpOYAvcQl/6nZd4t9B53w4=
X-Received: by 2002:a05:6902:6d11:b0:e8f:d7ca:d1be with SMTP id
 3f1490d57ef6-e917a199decmr463289276.5.1754927359158; Mon, 11 Aug 2025
 08:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
 <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
 <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com>
 <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net> <CANNYZj_7MebKw3iKvgRdKkpQvBW4a+4kdP8QZX_yWoY3DxN6TA@mail.gmail.com>
In-Reply-To: <CANNYZj_7MebKw3iKvgRdKkpQvBW4a+4kdP8QZX_yWoY3DxN6TA@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 11 Aug 2025 09:49:07 -0600
X-Gm-Features: Ac12FXzIv7GiTOMqjlRruwHbFCa2r1LCQdPCPmfFkYUS9nEsN9KIoBS6dgLd3gM
Message-ID: <CAJdd5GZXsmby-n5XRX+U1-Hg66xricNt_oyAz0CG9mY89U+3Xg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Chuck Wolber <chuck@wolber.net>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d96f0b063c18dd90"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 15:49:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17863

--000000000000d96f0b063c18dd90
Content-Type: text/plain; charset="UTF-8"

> I am totally listening, but you (and Joshua) aren't actually saying much.
>
> You do need to explain with sincerity and clarity and full details
> what is this 'maintenance overhead' that is so burdensome that
> branching becomes impossible. Pretty much every community layer
> manages this, so why not your product layer?
>
>
Ok.

THE BACKGROUND:

We don't produce just one product, we produce many products simultaneously
(north of 60), and we do so at scale. One of the things we highly value is
the efficiency with which we can develop so many products at the same time.
Developer efficiency is one of the primary reasons that we chose to use
Yocto in the first place; while the first product we did had a bit of a
steep learning curve, it was very clear that we could efficiently scale it
out much better than competitors. Looking back, I think the project has
actually exceeded my expectations for just how well we've been able to
scale.

Highly valuing efficient with our development has a few side effects:

 1) We do (more or less) trunk development on all our products at once.
This means there is a single branch where we do all development work on all
our products simultaneously, regardless of what version of upstream Yocto
they are using, which BSP they are using etc. This not only means its easy
for developers to find all products, but our CI also tests any change made
against all products to make sure it doesn't break anything. We aren't
willing to give up this development style and trade away the efficiencies
this provides, which is why we can't simply branch our internal repos.

 2) We like all our products to behave consistently, at least in userspace
if not sooner. This means that as much as possible we configure our distro
to act the same, regardless of Yocto release, BSP, etc. Similarly, if the
BSP allows it, we like to use the same boot flow across all products, etc.
Consistency allows our userspace developers to be more efficient because
they know that the code they write should work the same regardless of which
platform it's running on, the development and debugging experience is
pretty much the same across all products, etc. It (mostly) eliminates the
need for a developer to have to learn 60+ different ways of doing
development. However, we still need to customize the behavior of many
things (think distro policy settings, etc.), so we need a way to make sure
we get as similar behavior in these customization as possible, even across
multiple Yocto releases.

 3) We don't diverge from master of upstream OE (or any other layer). We
have internal mirrors of all the layers we use, and we have a branch for
each Yocto version in those mirrors that we maintain. I will apply changes
to these internal mirror branches for a given release (effectively forking
it), but I *never* fork master (e.g. master always exactly matches upstream
master). Any change that is made to a release branch in the mirror I
require to exist on the master branch first (this is occasionally
unpopular). The reason for this is so that as we move to newer releases, we
aren't carrying along patches that are not upstreamed. Another way to think
about this is that I'll more or less backport anything to a release branch,
as long as the behavior matches master. I wouldn't say this is entirely
ideal, but it does IMHO strike the proper balance between allowing us to do
trunk development and not diverging from upstream in the long run.

THE PROBLEM:

Hopefully, that sets the stage for *why* we do things the way that we do,
and now we can look a concrete example of why we'd prefer to allow dangling
bbappends. Here is the list of bbappend we use in our disto layer for
wpa-supplicant:

  wpa-supplicant_2.%.bbappend
  wpa-supplicant_2.10.bbappend
  wpa-supplicant_2.11.bbappend
  wpa-supplicant_2.5.bbappend
  wpa-supplicant_2.6.bbappend
  wpa-supplicant_2.7.bbappend
  wpa-supplicant_2.9.bbappend
  wpa-supplicant-CHIP.bbappend

The primary purpose here is to configure wpa-supplicant based on our
product requirements, and remember that we want consistent behavior of
wpa-supplicant across all products. As such, we put as much of the
configuration as we can into wpa-supplication_2.%.bbappend so that it
applies to all wpa-supplicants. However, it's simply not possible to use
the same configuration across all wpa-supplicant versions; new options are
added, old one removed etc. so some configuration changes can only be
applied to specific version, or some versions need a patch to behave like
the latest version, etc. Finally, some BSPs choose to provide their own
wpa-supplicant recipe, and those have to be configured also, which is what
the wpa-supplicant-CHIP.bbappend stands for.

From the perspective of dangling bbappends, this is awful. However, from
the perspective of our developers, this is pretty efficient. Our developers
can go to a single directory and see *all* the distro changes for all
versions of wpa-supplicant. If multiple versions need to share a config
file (this happens frequently), they can easily do that since they all live
in the same directory. It's much easier for our developers to make correct
changes, and understand the implication of changes made in this directory.
Overall, we've been happy to trade off dangling bbappends for this.

A POSSIBLE SOLUTION:

For completeness, since it has appeared that upstream is unwilling to
accommodate this, we have tried to work around this. The approach is to
make our conf/layer.conf look like this:

BBFILES += " \
     ${LAYERDIR}/recipes-*/*/*.bb \
     ${LAYERDIR}/recipes-*/*/*.bbappend \
     ${LAYERDIR}/yocto-${LAYERSERIES_CORENAMES}/recipes-*/*/*.bbappend \
     "

Effectively placing the Yocto version specific bbappends into their own
directory. However, this alone is insufficient because we also have to
account for dangling bbappends in layers that might not be present in a
given product (e.g. because it doesn't use a specific BSP). This
effectively means using dynamic layers is forced in order to prevent
dangling bbappends, however it gets worse when you have dynamic layers that
have version specific bbappends, because then we end up with something like
this:

BBFILES_DYNAMIC += " \
    raspberrypi:${LAYERDIR}/dynamic-layers/raspberrypi/*/*/*.bb \
    raspberrypi:${LAYERDIR}/dynamic-layers/raspberrypi/*/*/*.bbappend \

raspberrypi:${LAYERDIR}/dynamic-layers/yocto-${LAYERSERIES_CORENAMES}/raspberrypi/*/*/*.bbappend
\
    "

This approach (or other similar to it) are certainly better than branching
since we can still do trunk development, but what this effectively doing is
placing each bbappend in it's own directory, so instead of looking in a
single place to understand how we are configuring wpa-supplicant, we now
must look in no less than 8 places, and probably more since we'd have to
look in all the places a bbappend _might_ be instead of all the places that
_actually_ have one. Also, doing this makes it much more difficult to share
a common config file across multiple versions, since the bbappends are all
in separate directories.

This might be what we'll do if upstream refuses to allow the dangling
bbappends.... but we'd still just prefer to have the dangling bbappends as
the lesser of two evils.

FINAL THOUGHTS:

Looking behind the curtain a little, my struggle with this is that there is
some pressure to fork master (and break rule #3) so that we can continue to
have the developer efficiency we are accustom to, so I'm probably going to
have some hard conversions about where we go from here. That's not really
upstreams problem, but I wanted to shed some light on the ramifications of
these types of changes.

Hopefully that accurately outlines our struggle here and why we would like
this feature.

Thanks
Joshua Watt

--000000000000d96f0b063c18dd90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I am totally listening, but you (and Joshua) aren&#39;t actually saying muc=
h.<br>
<br>
You do need to explain with sincerity and clarity and full details<br>
what is this &#39;maintenance overhead&#39; that is so burdensome that<br>
branching becomes impossible. Pretty much every community layer<br>
manages this, so why not your product layer?<br><br></blockquote><div><br><=
/div><div>Ok.</div><div><br></div><div>THE BACKGROUND:</div><div><br></div>=
<div>We don&#39;t produce just one product, we produce many products simult=
aneously (north of 60), and we do so at scale. One of the things we highly =
value is the efficiency with which we can develop so many products at the s=
ame time. Developer efficiency is one of the primary reasons that we chose =
to use Yocto in the first place; while the first product we did had a bit o=
f a steep learning curve, it was very clear that we could efficiently scale=
 it out much better than competitors. Looking back, I think the project has=
 actually exceeded my expectations for just how well we&#39;ve been able to=
 scale. <br></div><div><br></div><div>Highly valuing efficient with our dev=
elopment has a few side effects:</div><div><br></div><div>=C2=A01) We do (m=
ore or less) trunk development on all our products at once. This means ther=
e is a single branch where we do all development work on all our products s=
imultaneously, regardless of what version of upstream Yocto they are using,=
 which BSP they are using etc. This not only means its easy for developers =
to find all products, but our CI also tests any change made against all pro=
ducts to make sure it doesn&#39;t break anything. We aren&#39;t willing to =
give up this development style and trade away the efficiencies this provide=
s, which is why we can&#39;t simply branch our internal repos.</div><div><b=
r></div><div>=C2=A02) We like all our products to behave consistently, at l=
east in userspace if not sooner. This means that as much as possible we con=
figure our distro to act the same, regardless of Yocto release, BSP, etc. S=
imilarly, if the BSP allows it, we like to use the same boot flow across al=
l products, etc. Consistency allows our userspace developers to be more eff=
icient because they know that the code they write should work the same rega=
rdless of which platform it&#39;s running on, the development and debugging=
 experience is pretty much the same across all products, etc. It (mostly) e=
liminates the need for a developer to have to learn 60+ different ways of d=
oing development. However, we still need to customize the behavior of many =
things (think distro policy settings, etc.), so we need a way to make sure =
we get as similar behavior in these customization as possible, even across =
multiple Yocto releases.</div><div><br></div><div>=C2=A03) We don&#39;t div=
erge from master of upstream OE (or any other layer). We have internal mirr=
ors of all the layers we use, and we have a branch for each Yocto version i=
n those mirrors that we maintain. I will apply changes to these internal mi=
rror branches for a given release (effectively forking it), but I *never* f=
ork master (e.g. master always exactly matches upstream master). Any change=
 that is made to a release branch in the mirror I require to exist on the m=
aster branch first (this is occasionally unpopular). The reason for this is=
 so that as we move to newer releases, we aren&#39;t carrying along patches=
 that are not upstreamed. Another way to think about this is that I&#39;ll =
more or less backport anything to a release branch, as long as the behavior=
 matches master. I wouldn&#39;t say this is entirely ideal, but it does IMH=
O strike the proper balance between allowing us to do trunk development and=
 not diverging from upstream in the long run.</div><div><br></div><div>THE =
PROBLEM:</div><div><br></div><div> Hopefully, that sets the stage for *why*=
 we do things the way that we do, and now we can look a concrete example of=
 why we&#39;d prefer to allow dangling bbappends. Here is the list of bbapp=
end we use in our disto layer for wpa-supplicant:</div><div></div><div><br>=
</div><div>=C2=A0 wpa-supplicant_2.%.bbappend</div><div></div><div>=C2=A0 w=
pa-supplicant_2.10.bbappend<br>=C2=A0 wpa-supplicant_2.11.bbappend<br>=C2=
=A0 wpa-supplicant_2.5.bbappend<br>=C2=A0 wpa-supplicant_2.6.bbappend<br>=
=C2=A0 wpa-supplicant_2.7.bbappend<br>=C2=A0 wpa-supplicant_2.9.bbappend<br=
>=C2=A0 wpa-supplicant-CHIP.bbappend<br></div><div><br></div><div>The prima=
ry purpose here is to configure wpa-supplicant based on our product require=
ments, and remember that we want consistent behavior of wpa-supplicant acro=
ss all products. As such, we put as much of the configuration as we can int=
o wpa-supplication_2.%.bbappend so that it applies to all wpa-supplicants. =
However, it&#39;s simply not possible to use the same configuration across =
all wpa-supplicant versions; new options are added, old one removed etc. so=
 some configuration changes can only be applied to specific version, or som=
e versions need a patch to behave like the latest version, etc. Finally, so=
me BSPs choose to provide their own wpa-supplicant recipe, and those have t=
o be configured also, which is what the wpa-supplicant-CHIP.bbappend stands=
 for.</div><div><br></div><div>From the perspective of dangling bbappends, =
this is awful. However, from the perspective of our developers, this is pre=
tty efficient. Our developers can go to a single directory and see *all* th=
e distro changes for all versions of wpa-supplicant. If multiple versions n=
eed to share a config file (this happens frequently), they can easily do th=
at since they all live in the same directory. It&#39;s much easier for our =
developers to make correct changes, and understand the implication of chang=
es made in this directory. Overall, we&#39;ve been happy to trade off dangl=
ing bbappends for this.</div><div><br></div><div></div><div>A POSSIBLE SOLU=
TION:</div><div><br></div><div>For completeness, since it has appeared that=
 upstream is unwilling to accommodate this, we have tried to work around th=
is. The approach is to make our conf/layer.conf look like this:<br><br>BBFI=
LES +=3D &quot; \</div><div>=C2=A0=C2=A0=C2=A0=C2=A0 ${LAYERDIR}/recipes-*/=
*/*.bb \<br>=C2=A0 =C2=A0=C2=A0 ${LAYERDIR}/recipes-*/*/*.bbappend \<br>=C2=
=A0 =C2=A0=C2=A0 ${LAYERDIR}/yocto-${LAYERSERIES_CORENAMES}/recipes-*/*/*.b=
bappend \<br>=C2=A0 =C2=A0=C2=A0 &quot;<br></div><div><br></div><div>Effect=
ively placing the Yocto version specific bbappends into their own directory=
. However, this alone is insufficient because we also have to account for d=
angling bbappends in layers that might not be present in a given product (e=
.g. because it doesn&#39;t use a specific BSP). This effectively means usin=
g dynamic layers is forced in order to prevent dangling bbappends, however =
it gets worse when you have dynamic layers that have version specific bbapp=
ends, because then we end up with something like this:<br><br>BBFILES_DYNAM=
IC +=3D &quot; \<br>=C2=A0 =C2=A0 raspberrypi:${LAYERDIR}/dynamic-layers/ra=
spberrypi/*/*/*.bb \<br>=C2=A0 =C2=A0 raspberrypi:${LAYERDIR}/dynamic-layer=
s/raspberrypi/*/*/*.bbappend \<br>=C2=A0 =C2=A0 raspberrypi:${LAYERDIR}/dyn=
amic-layers/yocto-${LAYERSERIES_CORENAMES}/raspberrypi/*/*/*.bbappend \<br>=
=C2=A0=C2=A0=C2=A0 &quot;</div><div><br></div><div>This approach (or other =
similar to it) are certainly better than branching since we can still do tr=
unk development, but what this effectively doing is placing each bbappend i=
n it&#39;s own directory, so instead of looking in a single place to unders=
tand how we are configuring wpa-supplicant, we now must look in no less tha=
n 8 places, and probably more since we&#39;d have to look in all the places=
 a bbappend _might_ be instead of all the places that _actually_ have one. =
Also, doing this makes it much more difficult to share a common config file=
 across multiple versions, since the bbappends are all in separate director=
ies.</div><div><br></div><div></div><div>This might be what we&#39;ll do if=
 upstream refuses to allow the dangling bbappends.... but we&#39;d still ju=
st prefer to have the dangling bbappends as the lesser of two evils.</div><=
div><br></div><div>FINAL THOUGHTS:</div><div><br></div><div>Looking behind =
the curtain a little, my struggle with this is that there is some pressure =
to fork master (and break rule #3) so that we can continue to have the deve=
loper efficiency we are accustom to, so I&#39;m probably going to have some=
 hard conversions about where we go from here. That&#39;s not really upstre=
ams problem, but I wanted to shed some light on the ramifications of these =
types of changes.</div><div><br></div><div>Hopefully that accurately outlin=
es our struggle here and why we would like this feature.<br><br></div><div>=
Thanks<br></div><div>Joshua Watt</div><div><br></div></div></div>

--000000000000d96f0b063c18dd90--

