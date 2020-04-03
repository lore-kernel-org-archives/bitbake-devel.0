Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by mx.groups.io with SMTP id smtpd.web12.6218.1585898963057702051
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Apr 2020 00:29:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmx.net header.s=badeba3b8450 header.b=l0ss8+LF;
 spf=pass (domain: gmx.at, ip: 212.227.15.19, mailfrom: bernd.bauer@gmx.at)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1585898961;
	bh=jSoPvAPas0hfmRhd5OGsNRcn4sl+7oUB7MK1deFIlnk=;
	h=X-UI-Sender-Class:Reply-To:Subject:To:References:From:Date:
	 In-Reply-To;
	b=l0ss8+LF2HCD540KfwVsuSgh1vcWsgUCshPXh9cYBXQ1Z8YMA4ujxlSNnSaUSUOdw
	 PKG+d6gUORYVJAx4ER6gm8aXgbuqqzWFg1MDJGm1bED+Kq5TOU+V8FJhWP5GwpW3Qw
	 PZGq+cjcdOCLsAnv+f4+CJ3cGAfHoJYZ45C5JcnY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.120] ([46.57.17.1]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiDd-1jh2wY0pdX-00QD9Q for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2020 09:29:21 +0200
Reply-To: bernd.bauer@gmx.at
Subject: Re: [bitbake-devel] [PATCH] Gitsm does not use credentials when cloning submodules
To: bitbake-devel@lists.openembedded.org
References: <20200402195104.2405-1-bernd.bauer@gmx.at>
 <fb960c2f15390746d24fd95368478c518748c957.camel@linuxfoundation.org>
From: "Bernd Bauer" <bernd.bauer@gmx.at>
Autocrypt: addr=bernd.bauer@gmx.at; prefer-encrypt=mutual; keydata=
 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
Message-ID: <55c322d4-aa7a-4a6e-6fbe-70ab9eecee83@gmx.at>
Date: Fri, 3 Apr 2020 09:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fb960c2f15390746d24fd95368478c518748c957.camel@linuxfoundation.org>
X-Provags-ID: V03:K1:16RPPGNxpz/84YSUOKPS0nM/lHmAlwSAcze+PcjXupG3qlXHwTP
 GTMN6nj2l/eE12ZSXmcFfFTnNfeX1wk8nfeZ5RHwCP4trLPB2emvFSVwSO/LuEvtCVBaUP7
 NGjvjmEseziyVaK8BpSkCVaAB+AeJ6P4PDEi1yukyUaNiA+bzI4amF2D17QA6Fkkq9FwT3q
 706zUCcziRel0t+XrOdcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:78fgZXvHW4I=:d3B4jpwF+MO9/XIN9I3kg2
 qCNzaFBWqTaaGG3autFE1A7TYTi/a+1BKzHUjFxLuEscuagmPEun1b906sbe9xUYNPeYxtj0B
 Zk8DCg547jofUQR7h2lcYdznj20Kv4I+SEgqXh/qwZAG4dODOGlUG6EHzaHxq8hfGuo2yqzGJ
 FWten+VQ5GmVWB03oLJ28FpdM5csKiDrUSEHwWBbUZDnl99zZGlH8OXXJjvgVxZFCqqL6rW54
 lxQrYfO9XN911vRldrl+7sQEeWrd4Bqi//B56hpeQetT/l/VZxG3TGr1u56GxzFkrtpE27waO
 iNPyMm2md0Hi18oowfJ4L65C/gFubhxhMOVCdnIEcgy+j2NWKbOx7hPt6ppp+cDXE7cw3b5Ed
 zR+37DEZdl4JrLWe1pLf2EYHKxA7ndKvhnhmfM1iaERMC+nu9v3rD8aAq5XbSBdjPnr8Ekr+W
 JJRiovSAa5sS0WazXT/zggWT/l61Ec5eaOiIa/sBJSIEvLrtKiAtPNrxWodFcDIbse5VFslNR
 W4fN992yIibUsJXjsyMZp8bTMaF44NYF2YlM5sSmlxXcvE3Ayq9b9Dgjb76dGXl2330egSzgI
 Sl8TJJ1L1sA+yYaJZ5QCTrkUaQ+bSJqVWNKQVYCaiUFbnoVcI9OYuMHMU3iBjmIqfOiFbrVV4
 33jy5zNky8TvdN3Vnu025M+0LUOTPEUIEVcpClRRUQ02RcXQBGW7j9JjIcTiSFZ/d5Blv7do6
 19SgvYCc184pN3k+yS8FmOw0IFedPsw/Bek1kkOSpNCOJxepG6P9xhw4qW4uypw7ch+xD7dOX
 CUoCqZzP8HShQbnH3LeF3I/L6UsTtssm+FiPrXVbeh4sXw6LcZoQGmh4Cex+cSVgftLOXiooA
 884TNWPfwX+PTLsg+6u3AskvClfsIHFshAYg+87VXiuk3EXvkXURe+TF0M9Q7WTD56q90KOLe
 PCFvXGSv3a2yrQcHFhtuQjsj8n410Wat6Fr5WOsdoY6sErBBYJG7Y+B9fAGl/OvQjt/HFCCoW
 aMBFQ6oLL9ktQFGveDUmvIlYIj++djfHHHa5qUVQpIdFGIUp5T4tPNxEKjpwqlP1D6kSfj9X7
 m5/Fq5upesRTsD2ErWHSel924oFqwuuiPdovoiBi0RJkS6M2SKCnf6Wg4y+zyMtoHtzetTw4N
 1fukBgcdvxtjpiNWlAH9b+NU7nFhe5NykqRBZijFXdHeBQOMx1bo0TR/ViLI71hHHJ67SSG4D
 5UxcNy2A+kYu8oMCY
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Am 02.04.20 um 23:08 schrieb Richard Purdie:
> On Thu, 2020-04-02 at 21:51 +0200, Bernd Bauer wrote:
>> If the git server needs authentication the credentials are
>> encoded in the URL of the repositories.
>> The credentials from the main repository are deposited in the
>> recipe so main repository can still be cloned.
>>
>> But the URLs from the submodules are listed in the .gitmodules
>> file.
>> The submodule url is encoded with an username and a password
>> or a bitbucket URL token. See example.
>>
>> The password is not stored in the ud.user but in the ud.pswd
>> variable. So in this case the url is made up by ud.user and
>> ud.pswd.
>>
>> Example:
>> [submodule "sub1"]
>>         path =3D sub1
>>         url =3D https://user:password@test.org/url/to/sub1
>>
>> Signed-off-by: Bernd Bauer <bernd.bauer@gmx.at>
>> ---
>>  bitbake/lib/bb/fetch2/git.py | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> We have had requests for this before and we've said "no" since
> encouraging people to put passwords in urls is bad and it leads to
> people making accidental exposures. Its basically too risky.
>
> For git submodules the line becomes blurred.
>
> I'm open to the opinions of others but in this form the patch applies
> to git and gitsm and that in itself makes it more risky.
>
> I do understand why people want this, equally it really isn't a great
> idea in general :/.
>
> Cheers,
>
> Richard

Hi!

Of course it is not a good idea to write the credentials directly
in the recipe or in the .gitmodules.
Unfortunately I have no other choice than to encode the username
and password in the URL. This GIT server only allows HTTPS with
authentication. No SSH keys, no anonymous checkout.

But without my patch the result would be the same.
I would have the URL with username and password in the
recipe and also in the submodules.
The only difference would be that I would have to define a
task in the recipe to check out the submodules.
So my recipe is getting complexer.

do_configure_prepend() {
  cd ${WORKDIR}/git
  git submodules update --init --recursive
}

=46rom my point of view, my patch would be more like
fixing a bug than an extension.

Just my two cents...

Greets Bernd
