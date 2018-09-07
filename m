Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail.openembedded.org (Postfix) with ESMTP id B851E74C97
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Sep 2018 11:46:24 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id s14-v6so5690256wrw.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Sep 2018 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+XttyB44+PM8mzmYutqK7dKba0GBtk7cy2QtYdPtMTI=;
	b=Cmpp7AavxRISeFcUnupC7w403wlxh6trzqLjGOePilmBvCrNmMGS5hDsTR4cgSfAHs
	HIy/oG6lGFR4BbQCOGwMjBqYfN7/zLA5HcsDIGv1S9k2JFMO7T09mJM9AUR6qs2o1RZP
	CUtiR/oUBNW7knOh7Zdi9880re8Q6Wo9KsYdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+XttyB44+PM8mzmYutqK7dKba0GBtk7cy2QtYdPtMTI=;
	b=sDt64qwiyzuHxHrkHpJ0JLne2FxB6KmdbUEcphzwZBRVwGFBdHaSgKWF9aE2tMdL8X
	8+guKi6MQVLeRyVHuKW/d6OuVXXq0qcM58GhGdnbTHuRJBk+PuSuez87VCagr9y/2guM
	Z4z9fnYzhBvoH+jDlEXlH72nNgMz4UHbJ7IIL8cpNOLeh6kL9DqO/69egptol6pygk2C
	JMlX80Eihr/EBsZWPkQDCZQOiKVjQvxKNEzsX+jaazdwV9y6QQD/R3AVGrZR6r+38TX1
	zMrEwtdpz8iKESwCGz1Pt0gm+j61UbMsflo5DOyf8f8aGVR/3x0kQ1pxoxVPq4QJg/DO
	V0Uw==
X-Gm-Message-State: APzg51AlM5jGbq/2Appt7tS87GOjo3jjPQuT0KISVY9/LSbqezx0DyOC
	sMH+Teths8Jb/xa/GHBHvvReiQ==
X-Google-Smtp-Source: ANB0VdbheGXFXazpAT+ZTWlyZY8RPj1tatOewVFGLSnlXR+6G/0qdBByIhOX3+jdYDQHSrRQCWutag==
X-Received: by 2002:a5d:6150:: with SMTP id
	y16-v6mr6058748wrt.141.1536320785365; 
	Fri, 07 Sep 2018 04:46:25 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l16-v6sm4950844wmc.38.2018.09.07.04.46.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 07 Sep 2018 04:46:24 -0700 (PDT)
Message-ID: <2b44d47767cd66fc0840e90bd173ee32abe573bd.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: =?UTF-8?Q?=C5=81ukasz_Gardo=C5=84?= <lukaszgardon555@gmail.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Sep 2018 12:46:22 +0100
In-Reply-To: <CAHTiZf+DyebwL3N9y15RgvJZKnTx4Bh+XhqEo8FVxg5w_C=L7w@mail.gmail.com>
References: <20180901133644.1577-1-lukaszgardon555@gmail.com>
	<CANNYZj9-ybLPr=kNLEGFgdPG1U_kNJEEVzCw_5FiYUPYVVQQYw@mail.gmail.com>
	<94B3180E-9326-43AC-9780-39A3E2D9F850@gmail.com>
	<CANNYZj9UY7rrTySn-ctmd0u+OGnneB+p_nH=OvXe35L+JB-Zzg@mail.gmail.com>
	<1577859A-5F16-4E3F-8C23-1ECB099AB770@gmail.com>
	<7679349B-ECD4-4895-BE9D-052E4674408C@gmail.com>
	<CC13D61A-9A15-4BD7-B8F8-531EC354D62A@gmail.com>
	<26d9005d53f6bbde44236b6bb44098045af0b9eb.camel@linuxfoundation.org>
	<D234347A-BA5D-4001-9F81-2E1D393CCB25@gmail.com>
	<6CD09F44-529F-4395-8342-5C295F7B2BFD@gmail.com>
	<CABr9L5DzAv5RtZZv3HBHTO3fuKrQWeazT1WZ4czYL1kpKzyhSg@mail.gmail.com>
	<7ed5a587326097169c70965e34e0a690f0d549e5.camel@linuxfoundation.org>
	<CABr9L5Cfa5Z-gQTOZeMwJ0jV-r91XboZAaT8oM0HW5Rn4mcy2A@mail.gmail.com>
	<645d033f38db0a4389002c2c42ef8f83aa619045.camel@linuxfoundation.org>
	<CAHTiZf+x-vUPHTmR=yYFcSday9v4Pw0J88oz3HvzN9cuTKenTw@mail.gmail.com>
	<560fd234a8e60cc339d58db20b0c684564df6da7.camel@linuxfoundation.org>
	<CAHTiZf+DyebwL3N9y15RgvJZKnTx4Bh+XhqEo8FVxg5w_C=L7w@mail.gmail.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Cc: ville.skytta@iki.fi
Subject: Re: Add files supporting bash completion for bitbake tools
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
X-List-Received-Date: Fri, 07 Sep 2018 11:46:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2018-09-07 at 12:38 +0200, Łukasz Gardoń wrote:
> Indeed, poky repository is combined with using combo layer tool, I
> forger about this fact. 
> 
> So how fell can I prepare a change with adding completion files for
> BitBake into bitbake repository (just storing those files under
> contrib dir). And also prepare a change for oe-core also with adding
> complete files under contrib dir (e.g for devtool) and adapt env
> scripts.
> 
> I am volunteering my self for keeping update these files if this is
> possible.

I guess I'm ok in principle to do something like this and happy to have
a maintainer. I did look at the patches and I don't think they're
acceptable in their current form though.

The list of tasks is hardcoded whilst in reality different recipes have
different tasks and the available tasks is metadata defined. I do not
want to see a hardcoded list of tasks. The expression to obtain recipe
data is also rather ugly.

Ultimately our plan is to have bitbake be memory resident so there is
no real parsing overhead for queries. If that were the case we'd be
able to get correct recipe/task information from bitbake.

So in principle, I'm open to the idea but we likely need memory
resident bitbake and a helper to pull the info you need for correct
completion data directly from bitbake rather than guessing.

Cheers,

Richard

