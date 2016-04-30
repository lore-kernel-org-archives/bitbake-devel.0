Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
	[209.85.223.194])
	by mail.openembedded.org (Postfix) with ESMTP id B4923605BA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:43:15 +0000 (UTC)
Received: by mail-io0-f194.google.com with SMTP id k129so19444756iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=VfQyBiG597S74UInA53hwRb/lj6g2yfAKcsbXZIOx5I=;
	b=gAxqejRqpnv86IqnE85Qh6JMVWz/1j8RUUULLSL/DhZkgUpvXftWNA/uh2dc4kVW9n
	4dVLRMC3Z0oPJlaPdtM/btxCkp3WLcudrgRXo1o0DdFQGP5vEOD9idd42upHZsZJQ47w
	R+ow3Va6oBszYdnR5vBszeggpxJsVpOpUHE94M79l9MaUi2igBgVJQDuL+jHWiWUqfY5
	V2D1B3ObZKh8i4uhXvY9sveuYl863cbwqf3/osQRdOc31gjFw6XnASDMMv905teos6/h
	DSWYjfQpwG5WPQ1aTLvNRI01BB2IDwI6CA42M97RE2audwrT8OJFgPxouA/G1cRkie0B
	ZjgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mentor-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=VfQyBiG597S74UInA53hwRb/lj6g2yfAKcsbXZIOx5I=;
	b=nMbR7q0vTtVdNm86czOdS1Dj26Ss2AIw+WVyXWkBpBFctWwHpYoptzzMdG5thnVJJ8
	zUhgpuBL2srNh85pWP/lSaviY+A4hwVf5DIKWumJiNmOR8a5YqQljXQQzbCXiTMo/Z0a
	NVkCnMLu+3t3ldtX4PWdRxEZIkqOcPGAGu4Y5hIFFEU/m4IxfwfDgIbXVOWiOYz07G2l
	PZjCYIFYlpZo/NHps1q4zj2C+KZmB762Rqa57+BRsvPbIiwxS7vWBFPWCQQTJszxGsP4
	iiCQ73ij9x9OInRQHPqKTip86z1gYyyPvQZLl7KwMOTysxrjA3H5LqQUK9XLO2D/LSdn
	Z8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=VfQyBiG597S74UInA53hwRb/lj6g2yfAKcsbXZIOx5I=;
	b=gVPZub6sa1xTWsNI6IG5FR7udsRLus7GR+i4rcY3+gLAqYvtWodgfoZPOjt4EuGXj4
	OGmD35ioocOVloKgIs4RfAYTU5262RLzErOb0WQLb4/jaqp6r9T1X5yXxSgRr5aUGahU
	ubVRm5yGQqxvb5pDo/J32D6JtKdanB101848uSHcob2Sfg2cclgonKeYv72rN8AOt9zp
	7fD1nFrTvD4+i57rx0+p5ALpzTSaHJM2i/UxiQOEwJNbDaNLk1T0Q4MUAXMJByqtALN6
	EMjlupqK/fbtB0K6PnrWwXLI3M5Ta/vFrC+XTbGhGQHjHBzU8d7aNKGaTgLFykfNLbdg
	j52Q==
X-Gm-Message-State: AOPr4FVsT8yQgVF7wiWGNqMkYegVxLWtj3tuQe9k4stvRXDL+9efvekVOr4/8RCaw1BaALnHO9gRWbrq5EHNMQ==
X-Received: by 10.107.147.7 with SMTP id v7mr31411867iod.3.1462045395896; Sat,
	30 Apr 2016 12:43:15 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Sat, 30 Apr 2016 12:42:56 -0700 (PDT)
In-Reply-To: <cover.1462040905.git.chris_larson@mentor.com>
References: <cover.1462040905.git.chris_larson@mentor.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Sat, 30 Apr 2016 12:42:56 -0700
X-Google-Sender-Auth: biCs9mN_qI3hK6Bcg7j9hLh9Dic
Message-ID: <CABcZAN=nmHxh=XU1r97N06wYDiY9W2_BmLLNqO5Nc=NNW9rUUw@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [RFC master][PATCH 0/4] Convert bitbake-layers to plugin-based
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
X-List-Received-Date: Sat, 30 Apr 2016 19:43:15 -0000
Content-Type: multipart/alternative; boundary=94eb2c055f6877dc770531b8f819

--94eb2c055f6877dc770531b8f819
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 30, 2016 at 12:40 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This alters the bitbake-layers tool to use plugins for its sub-commands,
> following the same pattern as devtool and recipetool.
> `<bitbake>/lib/bblayers/` holds the default plugins, and layers can provide
> their own in `<layerdir>/lib/bblayers/`.
>
> A few minor enhancements were made to the plugin loading function after
> pulling it in from scriptutils.
>
>
> Please review the following changes for suitability for inclusion. If you
> have
> any objections or suggestions for improvement, please respond to the
> patches. If
> you agree with the changes, please provide your Acked-by.
>

Erm, used the wrong arguments, didn't intend to send this as RFC, just as a
patch series :)
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c055f6877dc770531b8f819
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Apr 30, 2016 at 12:40 PM, Christopher Larson <span dir=3D"ltr">&lt;=
<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":2xs" clas=
s=3D"a3s aXjCH">From: Christopher Larson &lt;<a href=3D"mailto:chris_larson=
@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
This alters the bitbake-layers tool to use plugins for its sub-commands,<br=
>
following the same pattern as devtool and recipetool.<br>
`&lt;bitbake&gt;/lib/bblayers/` holds the default plugins, and layers can p=
rovide<br>
their own in `&lt;layerdir&gt;/lib/bblayers/`.<br>
<br>
A few minor enhancements were made to the plugin loading function after<br>
pulling it in from scriptutils.<br>
<br>
<br>
Please review the following changes for suitability for inclusion. If you h=
ave<br>
any objections or suggestions for improvement, please respond to the patche=
s. If<br>
you agree with the changes, please provide your Acked-by.<br></div></blockq=
uote></div><br>Erm, used the wrong arguments, didn&#39;t intend to send thi=
s as RFC, just as a patch series :)<br>-- <br><div class=3D"gmail_signature=
"><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founde=
r - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Softw=
are Engineer, Mentor Graphics</div></div>
</div></div>

--94eb2c055f6877dc770531b8f819--
