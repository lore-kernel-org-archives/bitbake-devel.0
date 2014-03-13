Return-Path: <alexandru.damian@intel.com>
Received: from mail-oa0-f53.google.com (mail-oa0-f53.google.com
	[209.85.219.53])
	by mail.openembedded.org (Postfix) with ESMTP id 8EB266F776
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Mar 2014 11:24:23 +0000 (UTC)
Received: by mail-oa0-f53.google.com with SMTP id j17so882561oag.12
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Mar 2014 04:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=UVB0CpZt0ZZAlcnLf1el9IBiYiU5NCL/g2mKhAPzFM8=;
	b=L0rV6kzYxZB5Xg06/ya4EuJ+H9PuLA8Subrl8KawnIXobRRQL2oOGoX51UMzf6UGyX
	lnKY+R6vuehFnBNatRPfMgS+7fXMsPZ+dTagBygG8KPiL6QCNGq3MyBfNFbOno8rX3tj
	tH+bqYUvuv1QHxNvuGKghafq5zZJg8vnDf+BjX7CSQ/e5yNs3tXyNqGlLHjltab4x/GI
	wrzJsjBAFjDHRBaOHeUFNxQhwBxss2XrY1teCyiOh/xN0Rzf3mlSiAPjDr9KM2+TWRwJ
	A8H34waNmOlTjqD57/um4kXRb20GpFd0j+6uVFf0TzFlWh1ixp7ddrM8HyXmLdpCZde0
	1mVQ==
X-Gm-Message-State: ALoCoQlFfs0COVlqUX2z3CntVzLeSFunlKoyiRZ37LU3jpgxwDnhad9/xJ2o0YiLDuNXG+Uc3d3M
X-Received: by 10.60.58.193 with SMTP id t1mr65982oeq.78.1394709864430; Thu,
	13 Mar 2014 04:24:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.11.165 with HTTP; Thu, 13 Mar 2014 04:24:04 -0700 (PDT)
In-Reply-To: <1433949.4mLA2GKP3u@peggleto-mobl5.ger.corp.intel.com>
References: <1394631711-1083-1-git-send-email-alexandru.damian@intel.com>
	<CAJTo0LY3oh5S2w1QxsGWBuYf1OUJbUBtakOWDGvRHVtafzYDvQ@mail.gmail.com>
	<CAJ2CSBv4rwENCu1q7RFFBV8Fr3y8sZS2RX74ZSNd6fj8DKnvKQ@mail.gmail.com>
	<1433949.4mLA2GKP3u@peggleto-mobl5.ger.corp.intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Thu, 13 Mar 2014 11:24:04 +0000
Message-ID: <CAJ2CSBtaEUMrWSE_1gSGJKYVqgKv8Cny-wowPYk4UKPbLdaa3w@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 13 Mar 2014 11:24:24 -0000
Content-Type: multipart/alternative; boundary=089e013cb94608d67704f47b3222

--089e013cb94608d67704f47b3222
Content-Type: text/plain; charset=UTF-8

I hear you, thanks for the input on various configurations.

Please do not submit this patch, I'll come back with a v2.

Ross, I tried time.tzname (as it currently stands) and it doesn't provide a
/usr/share/zoneinfo/ compatible name :(.

Alex


On Thu, Mar 13, 2014 at 10:11 AM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> On Wednesday 12 March 2014 18:49:02 Damian, Alexandru wrote:
> > This is a Debian-ism :(
>
> You say that, but the Fedora 20 install I have here (a) doesn't have TZ and
> (b) has /etc/localtime -> ../usr/share/zoneinfo/Europe/London. On my CentOS
> 6.5 machine (possibly irrelevant for Toaster, but...) TZ is also unset but
> /etc/localtime is just a plain copy of some timezone file rather than a
> symlink. Older RH-style systems such as CentOS 6 have a ZONE value in
> /etc/sysconfig/clock but Fedora appears to have eliminated this file.
>
> Given that, I don't think this is a complete fix.
>
> Cheers,
> Paul
>
> --
>
> Paul Eggleton
> Intel Open Source Technology Centre
>



-- 
Alex Damian
Yocto Project
SSG / OTC

--089e013cb94608d67704f47b3222
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">I hear you, thanks for the input on various configurations.<br><=
br>Please do not submit this patch, I&#39;ll come back with a v2.<br><br></=
div>

<div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Ross, =
I tried time.tzname (as it currently stands) and it doesn&#39;t provide a /=
usr/share/zoneinfo/ compatible name :(. <br><br>Alex<br></div></div><div cl=
ass=3D"gmail_extra">

<br><br><div class=3D"gmail_quote">On Thu, Mar 13, 2014 at 10:11 AM, Paul E=
ggleton <span dir=3D"ltr">&lt;<a href=3D"mailto:paul.eggleton@linux.intel.c=
om" target=3D"_blank">paul.eggleton@linux.intel.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">

<div class=3D"">On Wednesday 12 March 2014 18:49:02 Damian, Alexandru wrote=
:<br>
&gt; This is a Debian-ism :(<br>
<br>
</div>You say that, but the Fedora 20 install I have here (a) doesn&#39;t h=
ave TZ and<br>
(b) has /etc/localtime -&gt; ../usr/share/zoneinfo/Europe/London. On my Cen=
tOS<br>
6.5 machine (possibly irrelevant for Toaster, but...) TZ is also unset but<=
br>
/etc/localtime is just a plain copy of some timezone file rather than a<br>
symlink. Older RH-style systems such as CentOS 6 have a ZONE value in<br>
/etc/sysconfig/clock but Fedora appears to have eliminated this file.<br>
<br>
Given that, I don&#39;t think this is a complete fix.<br>
<br>
Cheers,<br>
Paul<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
<br>
Paul Eggleton<br>
Intel Open Source Technology Centre<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr">Alex Damian<div>Yocto Project<br></div><div>SSG / OTC=C2=A0</div><=
/div>
</div>

--089e013cb94608d67704f47b3222--
