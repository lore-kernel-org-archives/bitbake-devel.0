Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59051C3DA49
	for <webhook@archiver.kernel.org>; Fri,  2 Aug 2024 09:47:22 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
 by mx.groups.io with SMTP id smtpd.web10.73423.1722530909708711085
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 01 Aug 2024 09:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ideasonboard.com header.s=mail header.b=OWeWGPgp;
 spf=pass (domain: ideasonboard.com, ip: 213.167.242.64, mailfrom: kieran.bingham@ideasonboard.com)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4FCDD842;
	Thu,  1 Aug 2024 18:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722530858;
	bh=gnJEnyIWv2uqYi0x3LYYF/Hg5127XgdYUkZy2MvhbjI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=OWeWGPgpre4rRf6z1c6MoPQk97SS2Qt1iqNodRgmXeTFlHsq1Y6qUvW6ZDWqFcicg
	 KSzuJ0QjhFIL8OvO4IWa9HGWYgCCT0ecHeRtHVEIrhvUm1GvZaSjvBSsoJnQTKA/Od
	 58CNTasaaXYLQRBxqf7kIE+iVRwfToST5Vl0pmVc=
MIME-Version: 1.0
In-Reply-To: <CANx9H-BbTqYwGhd=JqBiFCtnfrf94Hj261SiLZAgJEfUAuw2_g@mail.gmail.com>
References: <20240524-b4-support-v1-1-0c4334c36cc7@cherry.de> <CAMKF1sq9U9VpPPbkmpot7TejVOemWjGqydyWiBn68Dz2vyhEEA@mail.gmail.com> <de18f958-d6db-4f90-a49b-a181d046f77e@cherry.de> <CAMKF1spNvMbuy+a-HS7wEbx5D817t6oxb_R12=gBgKgG8Eja1Q@mail.gmail.com> <CANx9H-CC9YHqTv6LgZE8jP0KVJC5Wsvyc8wmzhnf9crRG7ej4A@mail.gmail.com> <CANx9H-BbTqYwGhd=JqBiFCtnfrf94Hj261SiLZAgJEfUAuw2_g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] add basic b4 config file
From: "Kieran Bingham" <kieran.bingham@ideasonboard.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, foss@0leil.net, bitbake-devel@lists.openembedded.org
To: Tim Orling <ticotimo@gmail.com>, raj.khem@gmail.com
Date: Thu, 01 Aug 2024 17:48:24 +0100
Message-ID: <172253090400.372468.11616779990785740190@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Aug 2024 09:47:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16442

Hi Tim,

Quoting Tim Orling (2024-05-24 19:36:45)
> On Fri, May 24, 2024 at 11:24=E2=80=AFAM Tim Orling <ticotimo@gmail.com> =
wrote:
>=20
> >
> >
> > On Fri, May 24, 2024 at 9:28=E2=80=AFAM Khem Raj via lists.openembedded=
.org
> > <raj.khem=3Dgmail.com@lists.openembedded.org> wrote:
> >
> >> On Fri, May 24, 2024 at 8:33=E2=80=AFAM Quentin Schulz <quentin.schulz=
@cherry.de>
> >> wrote:
> >> >
> >> > Hi Khem,
> >> >
> >> > On 5/24/24 5:18 PM, Khem Raj via lists.openembedded.org wrote:
> >> > > On Fri, May 24, 2024 at 6:49=E2=80=AFAM Quentin Schulz via
> >> > > lists.openembedded.org <foss=3D0leil.net@lists.openembedded.org> w=
rote:
> >> > >>
> >> > >> From: Quentin Schulz <quentin.schulz@cherry.de>
> >> > >>
> >> > >> b4[1] is a very nice tool for mail-based contribution. A config[2]
> >> file
> >> > >> exists to set up a few defaults. We can use it to set the Cc
> >> recipients
> >> > >> to always add, in our case the mailing list.
> >> > >>
> >> > >> This shouldn't be necessary if we had a script that b4 prep
> >> --auto-to-cc
> >> > >> could call to find the mail address(es) to send to. While we coul=
d do
> >> > >> that, this opens the door to people trying to add a way to notify
> >> some
> >> > >> people (e.g. a MAINTAINERS file) which is not somewhere the proje=
ct
> >> > >> wants to go right now, and this also makes sure the address is al=
ways
> >> > >> added even if one forgets to run b4 prep --auto-to-cc (which is p=
art
> >> of
> >> > >> the typical workflow for U-Boot and Linux kernel, but is not
> >> necessary
> >> > >> thanks to this patch).
> >> > >>
> >> > >> [1] https://pypi.org/project/b4/
> >> > >> [2] https://b4.docs.kernel.org/en/latest/config.html
> >> > >>
> >> > >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> > >> ---
> >> > >> This adds a basic config file for b4 to avoid to have to add the
> >> mailing
> >> > >> list by hand. For documentation patches, one will still need to r=
un
> >> > >> b4 send --cc docs@lists.yoctoproject.org
> >> > >> manually for sending it to the docs ML as well.
> >> > >>
> >> > >> Note that b4 supports patchwork, c.f.
> >> > >>
> >> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration=
-settings
> >> > >> though I have no clue what it does with it as I am no maintainer,=
 but
> >> > >> maybe something worth having a look at if some maintainer of this
> >> repo
> >> > >> wants to use b4 to merge stuff?
> >> > >
> >> > > I use b4 regularly for meta-openembedded maintenance and it also
> >> updates
> >> > > patchwork when patch is accepted, I have this config.
> >> > >
> >> > >     [b4]
> >> > >      pw-url =3D "https://patchwork.yoctoproject.org/"
> >> > >      pw-key =3D "<mykey>"
> >> > >      pw-project =3D "oe"
> >> > >      pw-review-state =3D "under-review"
> >> > >      pw-accept-state =3D  "accepted"
> >> > >      pw-discard-state =3D "rejected"
> >> > >      send-series-to =3D "openembedded-devel@lists.openembedded.org"
> >>
> >
> > This inspired me to revisit the issue I was having with "b4 shazam <
> > message.id for an AUH upgrade>", where
> > shazam would stumble because of the "scissors line" (--- >8 ---)
> >
> > Turns out the solution appears to be
> > [b4]
> >     stdin-pipe-sep =3D "--- >8 ---"
> >
>=20
> Correction, where I was having trouble was with "git pw patch apply"
>=20
> $ git pw patch apply 43726
> Failed to apply patch:
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To record the empty patch as an empty commit, run "git am
> --allow-empty".
> hint: To restore the original branch and stop patching, run "git am
> --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> Patch is empty.
>=20
> Whereas "b4 shazam
> 0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833-000000@us-west-2.am=
azonses.com"
> works:
>=20
> $ b4 shazam
> 0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833-000000@us-west-2.am=
azonses.com
> Grabbing thread from
> lore.kernel.org/all/0101018f7d589796-87eb5d6d-06ed-4275-b5bc-6bad87216833=
-000000@us-west-2.amazonses.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 1 messages in the thread
> Checking attestation on all messages, may take a moment...
> Retrieving CI status, may take a moment...
> ---
>   =E2=9C=93 [PATCH] nghttp2: upgrading to 1.62.0 SUCCEEDED
>   ---
>   =E2=9C=93 Signed: DKIM/yoctoproject.org
> ---
> Total patches: 1
> ---
> Applying: nghttp2: upgrade 1.61.0 -> 1.62.0
>=20
>=20
> Any tricks to getting the Message-Id from patchwork?

I've recently been trying to tackle this for the libcamera project as
well.

Essentially - grab the series as json from:=20
https://patchwork.libcamera.org/api/1.1/series/$SERIES_ID/

Then extract from
   data['cover_letter']['msgid']

if there's a cover letter, or=20

   data['patches'][0]['msgid']

otherwise.


I'm using this (quick and dirty, please don't judge the) python code to
script getting the message-id.

```
#!/usr/bin/env python3
import requests
import sys

PATCHWORK_API_URL =3D "https://patchwork.libcamera.org/api/1.1"

def get_first_patch_message_id(series_id):
    # Get series details
    series_url =3D f"{PATCHWORK_API_URL}/series/{series_id}/"
    response =3D requests.get(series_url)
    response.raise_for_status()
    series_data =3D response.json()

    # Check for cover letter and get its msgid
    if series_data.get('cover_letter'):
        message_id =3D series_data['cover_letter']['msgid']
    else:
        # If no cover letter, get the msgid of the first patch
        if not series_data['patches']:
            raise ValueError("No patches found in the series")
        message_id =3D series_data['patches'][0]['msgid']

    return message_id

if __name__ =3D=3D "__main__":
    if len(sys.argv) !=3D 2:
        print("Usage: python3 get-message-id.py <series_id>")
        sys.exit(1)

    series_id =3D sys.argv[1]

    try:
        message_id =3D get_first_patch_message_id(series_id)
        print(f"Message ID of the first patch in the series: {message_id}")
    except Exception as e:
        print(f"An error occurred: {e}")
```

--
Kieran

