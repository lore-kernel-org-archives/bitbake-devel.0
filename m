Return-Path: <alexandru.damian@intel.com>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
	[209.85.218.50])
	by mail.openembedded.org (Postfix) with ESMTP id B505D73D5A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Apr 2015 13:06:40 +0000 (UTC)
Received: by oica37 with SMTP id a37so3236305oic.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Apr 2015 06:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=uNXihUj+nyc2lupFIx52bcRYFjd+RMNV5eOcygk4h1Y=;
	b=c3WqOxJzcjtKQUYdiLdECkpXSXOSzZvbSmxpV/gvpJMLqmhLjKuHVpu7il/R7x0Zt+
	+kcwjm98BKX3K50UDlzHwZNHGv31zKjuslX/3RDj81VFvbu/Oh04TTFgNFBRi+9hQf3v
	WfMhphV6sdLvJtA5R3NitHdtNO+aV/n4TKtFATeyp+gc1HKB1jekerSnDbv76W1ogseJ
	oTgFf+HreyLkt3eqbTo25CHuRMgDpJ9VJyPuexvdPw4VOPsLdOdm4zH7f5J+o6pmoORS
	Y1cI5LeLkAn0StGRg/iV+MjePZ6HCsn/SWwxG+uJIGW+ct8GNlVfwULtEW0iyXqwJ/5Q
	Z5WQ==
X-Gm-Message-State: ALoCoQlaBJ/v8HKwlg81rJu12kleC+V+LhKi/ETLJdHo9xyYInywF7aum2iFuX2LaBRkEeybrnbJ
X-Received: by 10.202.200.209 with SMTP id y200mr7235691oif.20.1428930401215; 
	Mon, 13 Apr 2015 06:06:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.131.135 with HTTP; Mon, 13 Apr 2015 06:06:20 -0700 (PDT)
In-Reply-To: <5528831F.2060908@gmail.com>
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
	<5528831F.2060908@gmail.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 13 Apr 2015 14:06:20 +0100
Message-ID: <CAJ2CSBsrOdTbP-3EKUZ06t1f5OkDbPEkd3QtxgXwKjt3BkO4DQ@mail.gmail.com>
To: akuster808 <akuster808@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [dizzy 0/7] inotify patchset back-port
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
X-List-Received-Date: Mon, 13 Apr 2015 13:06:41 -0000
Content-Type: multipart/alternative; boundary=001a11c1765af93d1305139ac83c

--001a11c1765af93d1305139ac83c
Content-Type: text/plain; charset=UTF-8

Hi,

Thanks for pulling this.

Alex

On Sat, Apr 11, 2015 at 3:12 AM, akuster808 <akuster808@gmail.com> wrote:

> I found your contrib branch and I will pull the seven changes from there.
> - armin
>
> On 04/10/2015 07:57 AM, Alex DAMIAN wrote:
>
>> cooker: read file watches on server idle
>>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>



-- 
Alex Damian
Yocto Project
SSG / OTC

--001a11c1765af93d1305139ac83c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hi,<br><br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:tahoma,sans-serif">Thanks for pulling this. <br><br></div><div class=3D"=
gmail_default" style=3D"font-family:tahoma,sans-serif">Alex<br></div></div>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Apr 11, 2=
015 at 3:12 AM, akuster808 <span dir=3D"ltr">&lt;<a href=3D"mailto:akuster8=
08@gmail.com" target=3D"_blank">akuster808@gmail.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">I found your contrib branch and I will pu=
ll the seven changes from there.<span class=3D"im HOEnZb"><br>
- armin<br>
<br>
On 04/10/2015 07:57 AM, Alex DAMIAN wrote:<br>
</span><span class=3D"im HOEnZb"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
cooker: read file watches on server idle<br>
</blockquote></span><div class=3D"HOEnZb"><div class=3D"h5">
-- <br>
______________________________<u></u>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.<u></u>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/<u></u>mailman/listinfo/bitba=
ke-devel</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Project<br></di=
v><div>SSG / OTC=C2=A0</div></div></div>
</div>

--001a11c1765af93d1305139ac83c--
