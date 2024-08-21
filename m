Return-Path: <charlie.johnston@loftorbital.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0A8C52D6F
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 17:41:28 +0000 (UTC)
Subject: Re: [PATCH] fetch2: Ensure GCP fetcher checks if file exists before download.
To: bitbake-devel@lists.openembedded.org
From: "Charlie Johnston" <charlie.johnston@loftorbital.com>
X-Originating-Location: US (4.42.15.78)
X-Originating-Platform: Windows Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 21 Aug 2024 10:41:21 -0700
References: <CAHUKmYaTcWnhQVcbD6GAnz5ymwUv3GwjfVx6d4kOyDCzrpCCQA@mail.gmail.com>
In-Reply-To: <CAHUKmYaTcWnhQVcbD6GAnz5ymwUv3GwjfVx6d4kOyDCzrpCCQA@mail.gmail.com>
Message-ID: <28323.1724262081445932896@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="nPkbQ8ujgvdPs9tNdzU2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Aug 2024 17:41:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16511

--nPkbQ8ujgvdPs9tNdzU2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I actually ran into the slowness of gsutil stat recently and have been test=
ing a patch locally that does something similar to what you describe. The d=
ifference is that I modified it to drop the runfetchcomd and raise a FetchE=
rror if self.gcp_client.bucket(ud.host).blob(path).exists() is false.
Is that approach acceptable, or is it better to bundle it into the download=
_to_filename logic as you describe?

Regards,
Charlie

--nPkbQ8ujgvdPs9tNdzU2
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hello,<br /><br />I actually ran into the slowness of gsutil stat rece=
ntly and have been testing a patch locally that does something similar to w=
hat you describe. The difference is that I modified it to drop the runfetch=
comd and raise a FetchError if <span style=3D"color: #333333; font-family: =
system-ui, 'Segoe UI', Roboto, 'Helvetica Neue', 'Noto Sans', 'Liberation S=
ans', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI S=
ymbol', 'Noto Color Emoji'; font-size: 16px; font-style: normal; font-varia=
nt-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-s=
pacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-trans=
form: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; w=
hite-space: normal; background-color: #ffffff; text-decoration-thickness: i=
nitial; text-decoration-style: initial; text-decoration-color: initial; dis=
play: inline !important; float: none;">self.gcp_client.bucket(ud.host).blob=
(path).exists()<span>&nbsp;</span></span> is false.</div>
<div>Is that approach acceptable, or is it better to bundle it into the <sp=
an style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Roboto, 'He=
lvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, 'Apple Co=
lor Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'; font-s=
ize: 16px; font-style: normal; font-variant-ligatures: normal; font-variant=
-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-a=
lign: start; text-indent: 0px; text-transform: none; widows: 2; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-col=
or: #ffffff; text-decoration-thickness: initial; text-decoration-style: ini=
tial; text-decoration-color: initial; display: inline !important; float: no=
ne;">download_to_filename<span> logic as you describe?</span></span></div>
<div>&nbsp;</div>
<div><span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Rob=
oto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, '=
Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'=
; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; backgr=
ound-color: #ffffff; text-decoration-thickness: initial; text-decoration-st=
yle: initial; text-decoration-color: initial; display: inline !important; f=
loat: none;"><span>Regards,</span></span></div>
<div><span style=3D"color: #333333; font-family: system-ui, 'Segoe UI', Rob=
oto, 'Helvetica Neue', 'Noto Sans', 'Liberation Sans', Arial, sans-serif, '=
Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'=
; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2=
; text-align: start; text-indent: 0px; text-transform: none; widows: 2; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; backgr=
ound-color: #ffffff; text-decoration-thickness: initial; text-decoration-st=
yle: initial; text-decoration-color: initial; display: inline !important; f=
loat: none;"><span>Charlie</span></span></div>

--nPkbQ8ujgvdPs9tNdzU2--

