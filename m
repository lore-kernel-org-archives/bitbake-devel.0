Return-Path: <ross.burton@intel.com>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
	[209.85.214.47])
	by mail.openembedded.org (Postfix) with ESMTP id 984B174F45
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 May 2018 11:44:45 +0000 (UTC)
Received: by mail-it0-f47.google.com with SMTP id t7-v6so16646734itf.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 May 2018 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=z50T/GeS8vuPjt0dwMKUY5ZQX1LKuTbHri8xW0IbW88=;
	b=gHVs/IZl/56KyTHwVk78jTo8rlC2pBO2ixoJNIuSJu3oI+bbrw9cl584KcVRnpY/kt
	Eq7C1elvWSgyr54c7TA+lhgwxHhpm/J/zZuQ6LZSu1A70C63htPj6qSQBxBa9Tz1c3RE
	ATlVr77gzthFtqrprFAI69Ph+Ht4BCpNl2DwS8peowV0DEV9BnGb4ctPAMxtycreBKRb
	PrE8PsVGZxvTrwaUhnzsz7Ruh2d60kQiBxIvyqtH3Xk3+qJncZH/MacLkyACx/KrfcfX
	LUgRkEQo4uHJfjB52sqmphy2CI58K1uRxLSmHSMqt4wB7ga6Wn+ARbDzTBEow0a7fFpm
	sIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=z50T/GeS8vuPjt0dwMKUY5ZQX1LKuTbHri8xW0IbW88=;
	b=YJoFR977YEe37A0siLsV1NmYJvArLjhb3z+62gktdToqX1nW6wdoPPKAfwkQoWWgx7
	j31cbfGXJjKvV6vdphQhx6HeEGh8TXzLQ5Z3jYYb1hYwE5DL79lk42H7OFZIO42ifHbs
	gPPHMGkHfqlafuP3hEHmPFixWAFybVBYpcxC05J9Fsur+9XrrlXjosrnQjNcHaQpuV/O
	EWbeKJsAYg1eOoqNtOTUgr20bzK1z91BVHVL01ZrjIvmiPMtDJF51BKPemyk6V32QpgH
	pL0VbGcrSlqEYJIuTG5ydt19Cc9d5qY7vTzp7thmMsPl0dQw1AWJCPdDGO8vb6zOvIYK
	H9Cw==
X-Gm-Message-State: ALKqPwf2qP0EZ/DS8YlIfqTj733yXhRASvF+k7gWSVhQYHGdARgqO9R+
	fjdj82c7D9tP+L+36n+eAj/yQob8LXyH3YB3aQVszA==
X-Google-Smtp-Source: AB8JxZrhtIQpmOwj8iZoImEUeVrJ/QGGdVb+fGbppLKfshCRaxuX85ERPGkafUZI/Sto9lNySYs4Q5cgGgk6DAsnC4M=
X-Received: by 2002:a24:496:: with SMTP id
	144-v6mr8969232itb.131.1525866286304; 
	Wed, 09 May 2018 04:44:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.239.11 with HTTP; Wed, 9 May 2018 04:44:25 -0700 (PDT)
In-Reply-To: <1184471455.1381374.1525832300014@mail.yahoo.com>
References: <1184471455.1381374.1525832300014.ref@mail.yahoo.com>
	<1184471455.1381374.1525832300014@mail.yahoo.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 9 May 2018 12:44:25 +0100
Message-ID: <CAJTo0LZGEBwiZr7csd3vxYaThN7-fTjexeRfkT+1ksX-AerbvA@mail.gmail.com>
To: Ugesh Reddy <kumar.ugesh003@yahoo.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: .bb script file for auto tools
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
X-List-Received-Date: Wed, 09 May 2018 11:44:45 -0000
Content-Type: multipart/alternative; boundary="000000000000f86a09056bc46d21"

--000000000000f86a09056bc46d21
Content-Type: text/plain; charset="UTF-8"

The easy way is to just use devtool to create the recipe for you.  The
important bit is just "inherit autotools" to handle
autoreconf/configure/make/make install for you.

Ross

On 9 May 2018 at 03:18, Ugesh Reddy via bitbake-devel <
bitbake-devel@lists.openembedded.org> wrote:

> Hello All,
>
>  I am new to bitbake and having the basic understanding on bitbake. My
> project uses auto tools and it has Makefile.am and configure.ac when it
> runs with autogen.sh it could able to generate Makefile and configure with
> generated files the bin program is generated. I would like to do the same
> with bitbake. The below are the structure
>
>    As mentioned in the below link
> https://github.com/DynamicDevices/bbexample
>
> When it executed like below it works fine
>  $ cd bbexample
>  $ ./autogen.sh
>  $ ./configure
>  $ make
>
> How can i write the .bb file for the same ?
>
> Regards,
> Ugesh
>
>
>
>
>
>
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>

--000000000000f86a09056bc46d21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The easy way is to just use devtool to create the recipe f=
or you.=C2=A0 The important bit is just &quot;inherit autotools&quot; to ha=
ndle autoreconf/configure/make/make install for you.<div><br></div><div>Ros=
s</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 9=
 May 2018 at 03:18, Ugesh Reddy via bitbake-devel <span dir=3D"ltr">&lt;<a =
href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">bitb=
ake-devel@lists.openembedded.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div><div style=3D"font-family:Helvetica Neue,Helvetica,Arial=
,sans-serif;font-size:16px"><div style=3D"font-family:Helvetica Neue,Helvet=
ica,Arial,sans-serif;font-size:16px"><div id=3D"m_-799902520484865810ydp388=
441fayiv6951807158"><div style=3D"font-family:Helvetica Neue,Helvetica,Aria=
l,sans-serif;font-size:16px"><div>Hello All,</div><div><br></div><div>=C2=
=A0I am new to bitbake and having the basic understanding on bitbake. My pr=
oject uses auto tools and it has Makefile.am and <a href=3D"http://configur=
e.ac" target=3D"_blank">configure.ac</a> when it runs with autogen.sh it co=
uld able to generate Makefile and configure with generated files the bin pr=
ogram is generated. I would like to do the same with bitbake. The below are=
 the structure</div><div><br></div><div>=C2=A0 =C2=A0As mentioned in the be=
low link</div><div><a href=3D"https://github.com/DynamicDevices/bbexample" =
rel=3D"nofollow" target=3D"_blank">https://github.com/<wbr>DynamicDevices/b=
bexample</a><br></div><div><br></div><div>When it executed like below it wo=
rks fine</div><div><span><div>=C2=A0$ cd bbexample</div><div>=C2=A0$ ./auto=
gen.sh</div><div>=C2=A0$ ./configure</div><div>=C2=A0$ make</div></span><br=
></div><div>How can i write the .bb file for the same ?</div><div><br></div=
><div>Regards,</div><div>Ugesh</div><div><br></div><div><br></div><div><br>=
</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>=C2=A0 =C2=A0</div><div><table cl=
ass=3D"m_-799902520484865810ydp9ae10bc2highlight m_-799902520484865810ydp9a=
e10bc2tab-size m_-799902520484865810ydp9ae10bc2js-file-line-container" styl=
e=3D"border-collapse:collapse;color:rgb(36,41,46);font-family:-apple-system=
,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;A=
pple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quo=
t;;font-size:14px"><tbody><tr><td id=3D"m_-799902520484865810ydp9ae10bc2LC1=
" class=3D"m_-799902520484865810ydp9ae10bc2blob-code m_-799902520484865810y=
dp9ae10bc2blob-code-inner m_-799902520484865810ydp9ae10bc2js-file-line" sty=
le=3D"padding:0px 10px;line-height:20px;vertical-align:top;font-family:SFMo=
no-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace;fon=
t-size:12px;word-wrap:normal;white-space:pre-wrap">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</td></tr></tbody></table></div><=
/div></div></div></div></div><br>-- <br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
<br></blockquote></div><br></div>

--000000000000f86a09056bc46d21--
