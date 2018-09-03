Return-Path: <salahuddinash@gmail.com>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail.openembedded.org (Postfix) with ESMTP id 1DBCA74573
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Sep 2018 11:48:22 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id 20-v6so312288wrb.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Sep 2018 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=CfcuuQfD/yR97ZYiwTP3f4bsK46eA0oCwAK6OUkTD64=;
	b=FXmSExoqy5dujgOTjyV6rYcZgZwBMzb4bYLTPkHmvO7C+J6D8AMUwoi/Bvkz9pyqjz
	zoze9c54KMA3GahyqMh2ykzaFh2felhqm/5sw4/gO2RIMe/WDpcnX+eRjGqdO3FK+azc
	hu79roNAyl3Pr56I/mK8CqUpysQirMgMJ3nMnyWiBYsgqaNNKZ22w2THFse2pvGnrs0Q
	jfHAOQ+CZFDiVRZaxbGC2i7neryND0182lpuyrl/YDi1ZPxFdVAfkwPPNlVGkd8onBw8
	W+2N3XPfP99u8BYjt/dQgXBuQwfVcNEfXC/JUk9M1zQYNTDYuxlU4CfqcJzVZcNz89pO
	Vkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=CfcuuQfD/yR97ZYiwTP3f4bsK46eA0oCwAK6OUkTD64=;
	b=PbRIH1n+fQ4Ia7iTpLlVFyBjCQxNoFDz1Ryfw392dwdj4Z/E04qhesizKTLZGBRVH1
	dUpXBxiP6n7bX9qR2PWj4LlxPFoSFNNsVOwyiH8lKuhRfFHcL4tchlYbessxVZSDZivI
	xNp1EyH4Ng/ugtVfXzwVREkx57gvTWCmu2rvRvQOdSzQEsQoG8BmuKXKWveu/nefVaOD
	pEnfXuxIXWiF5IACV2M5Unv3xOAYQUEylYDTedFFz02NcLghir11kCtTaRxCb1grGKjx
	xgfQ99KjJSpbf2ysbOEC8aFanz9Ej37Z9O9hnV53xe+RxQx9ailfdO7sB/+nZc3RgP8b
	bSsQ==
X-Gm-Message-State: APzg51DMZplquopngx7ucSVACiLP7uro2nM85M5niazTrbkVwoZV95u+
	L1cLg9b2JLottRBAe4Uajz/lWZ/90ZeY7PXlOC47WIOp
X-Google-Smtp-Source: ANB0VdYe6FobXNOHh9wH08WgWKOWBWv6XR8dZQ5L8JWB4QPOyOuvaFAApTqgH6vTgPS9NRsbs+TiSNOxKIgnlw5HFO4=
X-Received: by 2002:adf:ce06:: with SMTP id
	p6-v6mr19975116wrn.118.1535975303532; 
	Mon, 03 Sep 2018 04:48:23 -0700 (PDT)
MIME-Version: 1.0
From: Salaheldin Ahmed <salahuddinash@gmail.com>
Date: Mon, 3 Sep 2018 13:48:11 +0200
Message-ID: <CAFCTZorDwp4OMHVAH5O13GObC6K5O700hzxV-0DjvBYPpPtZrQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Tue, 04 Sep 2018 12:08:08 +0000
Subject: Run bitbake with progress bar in terminal (Ubuntu 16.04)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 03 Sep 2018 11:48:23 -0000
Content-Type: multipart/alternative; boundary="00000000000059d4230574f61e52"

--00000000000059d4230574f61e52
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm new to bitbake and Yocto Project. I tried to run bitbake to create one
image but it takes too long (around 3 hours till not and yet not finished).
I thought having a progress bar to see how much of the process is finished
is a very useful thing.
I found a couple of links where such progress bar is implemented but never
described how to use it for a newbie. Here is one of these links
https://github.com/openembedded/bitbake/blob/master/lib/progressbar/progressbar.py
As far as I saw (by running bitbake -h), there is no option to run bitbake
with progress bar.
Could someone tell me how to run bitbake with progress bar enabled in
terminal?


Thanks

--00000000000059d4230574f61e52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi everyone, <br></div><div><br></di=
v><div>I&#39;m new to bitbake and Yocto Project. I tried to run bitbake to =
create one image but it takes too long (around 3 hours till not and yet not=
 finished). <br></div><div>I thought having a progress bar to see how much =
of the process is finished is a very useful thing.</div><div>I found a coup=
le of links where such progress bar is implemented but never described how =
to use it for a newbie. Here is one of these links <a href=3D"https://githu=
b.com/openembedded/bitbake/blob/master/lib/progressbar/progressbar.py">http=
s://github.com/openembedded/bitbake/blob/master/lib/progressbar/progressbar=
.py</a> <br></div><div>As far as I saw (by running bitbake -h), there is no=
 option to run bitbake with progress bar.</div><div>Could someone tell me h=
ow to run bitbake with progress bar enabled in terminal?</div><div><br></di=
v><div><br></div><div>Thanks<br></div></div></div>

--00000000000059d4230574f61e52--
