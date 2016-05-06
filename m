Return-Path: <ross.burton@intel.com>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
	[209.85.213.177])
	by mail.openembedded.org (Postfix) with ESMTP id 095C760767
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 May 2016 08:41:16 +0000 (UTC)
Received: by mail-ig0-f177.google.com with SMTP id bi2so39628521igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 May 2016 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=sX2lGLjyW5mijcOCAysxnLSeXHBDccWkZI5a9LeCucQ=;
	b=FicGtR5degflNjRlnplbQ2mZRjKyWTd3zWfECWLCu7U61N/zaWskW3APHgl220E3m+
	YLZrbaX/q6k6GE9vAT07z9LhgcTrGp9SV3Cuj9WNJUSsLFja0bnjMDqXWJ8m1rTzNx0Y
	K+qmVsciPWbnWc0DfpnFFdsDQe3v1/TZ03UG2dhNERIhTy7BQuq4ExUBm77CzK/v5QS5
	mHNBmQ+BcAZJ0GEZflWDxXSgzrXvZMH9+WhzlLY73SR0OIF9POCYj79O2fUi4vQ08+06
	V7uIGI2d0rT0a1tc1KSC5br7BxGdtV8yO1fvWNiFqc/xc/klJg8TRRO25V6189Z1/fO/
	zkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=sX2lGLjyW5mijcOCAysxnLSeXHBDccWkZI5a9LeCucQ=;
	b=FkKFU0rk1roVzonBZ2uJcojezVgpqvJgMQktSCmSYE9AxjuyUkrXkH4dWBLc2Iq+N1
	Mgocc/OwNiOXM/e9r1pUmeOoLKs8hU9Tw0ZC5FDmAc4XwMbZPB3I3dNVY7PY/TGkRADo
	5eK+n5GOzfc8NrvjNDrFl5QqAmIREt9E+RXdAQa5bWaNLPkn7MCl+uvjx0A9IAhmYcZQ
	X1UbjH9/cxFYTCJrVGz0wb5ZshrDs0w0C+qw5iOPAeI5/MF56IZDumyQ6kqa/TUi+dA/
	JolYbJKfCSiBFbD1yuShNcyD0xkoCC1gliXQ6vkTlHKNpbNxZkMqhak6qNLrKzt4IXC0
	3C9w==
X-Gm-Message-State: AOPr4FX1/9/KZwbmQNPX6jSBrvreAoV039oMMhHxTGpFZzq9HBuoI3/PxPho+nNWJpfC+t3r1ALJEiuHyCttFvwg
X-Received: by 10.50.150.1 with SMTP id ue1mr8803752igb.52.1462524077387; Fri,
	06 May 2016 01:41:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.34.142 with HTTP; Fri, 6 May 2016 01:40:58 -0700 (PDT)
In-Reply-To: <B753B579-438D-4D33-A568-2B21D7BAE4AA@gmail.com>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
	<CAJTo0LaFCGWy_NbXNu72zsYmLzjE58i5=_hdiyUvXUQbdpTMkg@mail.gmail.com>
	<B753B579-438D-4D33-A568-2B21D7BAE4AA@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 6 May 2016 09:40:58 +0100
Message-ID: <CAJTo0LaCk=XLgA-8_=KNauTzJV0xUSjA06f8PO0YccHaZ6bYyw@mail.gmail.com>
To: Tim Orling <ticotimo@gmail.com>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
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
X-List-Received-Date: Fri, 06 May 2016 08:41:18 -0000
Content-Type: multipart/alternative; boundary=001a11c30f0a1beef10532286c2c

--001a11c30f0a1beef10532286c2c
Content-Type: text/plain; charset=UTF-8

On 5 May 2016 at 06:10, Tim Orling <ticotimo@gmail.com> wrote:

> "Just as long as we aren't switching to perl6 at the same time."
>

I just spilt coffee over my desk you scoundrel.

Ross

--001a11c30f0a1beef10532286c2c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 5 May 2016 at 06:10, Tim Orling <span dir=3D"ltr">&lt;<a href=3D"mailto:=
ticotimo@gmail.com" target=3D"_blank">ticotimo@gmail.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div>&quot;Just as long as we aren&#3=
9;t switching to perl6 at the same time.&quot;</div><div></div></blockquote=
></div><br>I just spilt coffee over my desk you scoundrel.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a11c30f0a1beef10532286c2c--
