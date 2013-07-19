Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
	[209.85.217.172])
	by mail.openembedded.org (Postfix) with ESMTP id 9BC4E6B26D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jul 2013 15:18:23 +0000 (UTC)
Received: by mail-lb0-f172.google.com with SMTP id v20so3571005lbc.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jul 2013 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=7QwHE2e8pJNfQiJpPmCyZ4PEJlMK5K3/QUvcEf9OOHc=;
	b=sM40pGa9mVGQPc3yLECFmH2FWYLmmM0+mTUUgwSwiGSOTvMVyRjwT4juYu/3O0iKRD
	BPM0YYjIvv+gysTd2pbE6KQq1ihhxsAVs7Ws0HhfFEHVEyibVe9/he2lwnGEUe09yV+C
	WwFq17bwayqXKNmgw0wlVHAadY6oHWjvGowLE+9DPsx8YL6Cs9O6lCR59Q7Y+GRDts4Z
	t5DyhX9HqRg1tIdo/zxPy3+s7GZluyvIC1lHfzshwv8y6SSPRkwqRD6oE3HZqSEE81Vj
	z8+iqd/SFQ8x5HMBvUH+Op8hz56X6OVEUauSvmAw34E3J0YaeVVXNR/hd034nLu9INhs
	3PPA==
X-Received: by 10.152.22.42 with SMTP id a10mr7807940laf.30.1374247103358;
	Fri, 19 Jul 2013 08:18:23 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.18.100 with HTTP; Fri, 19 Jul 2013 08:18:03 -0700 (PDT)
In-Reply-To: <1374057344-19708-10-git-send-email-cristiana.voicu@intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
	<1374057344-19708-10-git-send-email-cristiana.voicu@intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 19 Jul 2013 08:18:03 -0700
X-Google-Sender-Auth: VsPBDZkms36ZM8469ZlyrDlopiY
Message-ID: <CABcZAN=NWc3O3T_78bFDsc-YziGz66pDoL4qhSpKTXppoP90BQ@mail.gmail.com>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 09/14] bitbake: when an image is saved, it should require an image from layers
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 19 Jul 2013 15:18:24 -0000
Content-Type: multipart/alternative; boundary=089e0158b7946deb7404e1ded6a4

--089e0158b7946deb7404e1ded6a4
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 17, 2013 at 3:35 AM, Cristiana Voicu
<cristiana.voicu@intel.com>wrote:

> If the image required is not from the layers and it is removed, when sanity
> check is running, Hob will show some errors related to this.
> Agreed to "require" only the images from layers.
>
> [YOCTO #4193]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
>

Two issues with the commit message summary:
- bitbake: isn't necessary for the commit going to bit bake, only for when
it gets pulled into poky
- nowhere does it make it clear that this is hob-related
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e0158b7946deb7404e1ded6a4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jul 17, 2013 at 3:35 AM, Cristiana Voicu <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:cristiana.voicu@intel.com" target=3D"_blank">cristiana.voicu@=
intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1ed" style=3D"overflow:hidden">I=
f the image required is not from the layers and it is removed, when sanity<=
br>

check is running, <span class=3D"il">Hob</span> will show some errors relat=
ed to this.<br>
Agreed to &quot;require&quot; only the images from layers.<br>
<br>
[YOCTO #4193]<br>
Signed-off-by: Cristiana Voicu &lt;<a href=3D"mailto:cristiana.voicu@intel.=
com">cristiana.voicu@intel.com</a>&gt;</div></blockquote></div><br>Two issu=
es with the commit message summary:</div><div class=3D"gmail_extra">- bitba=
ke: isn&#39;t necessary for the commit going to bit bake, only for when it =
gets pulled into poky</div>

<div class=3D"gmail_extra">- nowhere does it make it clear that this is hob=
-related<br>-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Foun=
der - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Sof=
tware Engineer, Mentor Graphics
</div></div>

--089e0158b7946deb7404e1ded6a4--
