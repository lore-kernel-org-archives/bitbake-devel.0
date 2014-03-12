Return-Path: <alexandru.damian@intel.com>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
	[209.85.214.173])
	by mail.openembedded.org (Postfix) with ESMTP id 82F756DE07
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 18:49:21 +0000 (UTC)
Received: by mail-ob0-f173.google.com with SMTP id gq1so10436734obb.32
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 11:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=Tv90c53Max97Tc7PagXo2oAyj0zgz8Jlv3Bif/ux5JU=;
	b=Z6gsOT1Vp0vWuvTrHYUjVE/AfHB9oahH41ucfzsE/KP/AZYH6Ud0RsF+qudbvjD6Vh
	FMy9gfEmQ919s+j9jOYTnRX7HL0t3Nn/4yQsWzOxBIFRXHbL0bfhADnTqmJl0uz74JpB
	kd0bJrkWvag+Y0pRW4HoOgaGTF2NVoZtHQ70N+hIznzNLKVJRlH1ttRYmUzrIeuCUuAw
	rEJ1Y1lMm37ShaTxEE5Lhb3kxtvIti15Wc+KhLJL59jFFL985CIV43ypAJ6y6eaBJ6Q9
	FK4+I8Kr2gS6+b/9cAWGg0efsLRmO2w4/v8Xo0LEFuD7ZX3eXyi31xgzJTjUhywih5rz
	Rv+A==
X-Gm-Message-State: ALoCoQmXt9Hc4/FFJ0kWO2lR58LoOAReqyL/2Bi8ct7XiEPSVo2bhgpcPsJdzkVo2ey8lUOMA7xg
X-Received: by 10.182.142.229 with SMTP id rz5mr39811182obb.12.1394650162097; 
	Wed, 12 Mar 2014 11:49:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.11.165 with HTTP; Wed, 12 Mar 2014 11:49:02 -0700 (PDT)
In-Reply-To: <CAJTo0LY3oh5S2w1QxsGWBuYf1OUJbUBtakOWDGvRHVtafzYDvQ@mail.gmail.com>
References: <1394631711-1083-1-git-send-email-alexandru.damian@intel.com>
	<CAJTo0LY3oh5S2w1QxsGWBuYf1OUJbUBtakOWDGvRHVtafzYDvQ@mail.gmail.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 12 Mar 2014 18:49:02 +0000
Message-ID: <CAJ2CSBv4rwENCu1q7RFFBV8Fr3y8sZS2RX74ZSNd6fj8DKnvKQ@mail.gmail.com>
To: "Burton, Ross" <ross.burton@intel.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] toaster: fix timezone detection
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
X-List-Received-Date: Wed, 12 Mar 2014 18:49:21 -0000
Content-Type: multipart/alternative; boundary=001a11c362e67f85b004f46d4b46

--001a11c362e67f85b004f46d4b46
Content-Type: text/plain; charset=UTF-8

This is a Debian-ism :(

Does toaster show you improper times, or refuses to start ?

Alex


On Wed, Mar 12, 2014 at 4:06 PM, Burton, Ross <ross.burton@intel.com> wrote:

> On 12 March 2014 13:41, Alex DAMIAN <alexandru.damian@intel.com> wrote:
> > This patch replaces faulty timezone detection with a version
> > that simply reads the TZ environment variable if it is set.
>
> My Debian system doesn't have a TZ environment variable but does have
> /etc/localtime which is the current timezone data. Yes, determining
> the local timezone is a pain.  :)
>
> Ross
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>



-- 
Alex Damian
Yocto Project
SSG / OTC

--001a11c362e67f85b004f46d4b46
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">This is a Debian-ism :( <br><br></div><div class=3D"gmail_defaul=
t" style=3D"font-family:tahoma,sans-serif">Does toaster show you improper t=
imes, or refuses to start ?<br>

<br>Alex<br></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gm=
ail_quote">On Wed, Mar 12, 2014 at 4:06 PM, Burton, Ross <span dir=3D"ltr">=
&lt;<a href=3D"mailto:ross.burton@intel.com" target=3D"_blank">ross.burton@=
intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On 12 March 2014 13:41, Alex=
 DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.com">alexandru.damian@=
intel.com</a>&gt; wrote:<br>


&gt; This patch replaces faulty timezone detection with a version<br>
&gt; that simply reads the TZ environment variable if it is set.<br>
<br>
</div>My Debian system doesn&#39;t have a TZ environment variable but does =
have<br>
/etc/localtime which is the current timezone data. Yes, determining<br>
the local timezone is a pain. =C2=A0:)<br>
<br>
Ross<br>
---------------------------------------------------------------------<br>
Intel Corporation (UK) Limited<br>
Registered No. 1134945 (England)<br>
Registered Office: Pipers Way, Swindon SN3 1RJ<br>
VAT No: 860 2173 47<br>
<br>
This e-mail and any attachments may contain confidential material for<br>
the sole use of the intended recipient(s). Any review or distribution<br>
by others is strictly prohibited. If you are not the intended<br>
recipient, please contact the sender and delete all copies.<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Alex D=
amian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div></div>
</div>

--001a11c362e67f85b004f46d4b46--
