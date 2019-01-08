Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail.openembedded.org (Postfix) with ESMTP id 5051062133
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jan 2019 20:03:28 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id p4so5332988wrt.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Jan 2019 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=4Hbjz+2hI7iR5eGS9VxUaSixqXRKY77HM8lTTlb6mpA=;
	b=dhdC64eaKrcvRLYs8AKj1XIDKqL/Bf2knTNqQLl2nG9KpjGiA0iVDYOg4H22BjIQvg
	9VqP9mzRORIKs3r2ITFep6WT/UN490AJqShZ63urTtu1vj9DpGYrFqDwA3O984ZRikNZ
	gxXm49VsDh7qq8eT4OaXAuiejiyT1O8j+jAIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=4Hbjz+2hI7iR5eGS9VxUaSixqXRKY77HM8lTTlb6mpA=;
	b=aPkOFrR/DtxyyXttiwKGH87Czliz/mTbEBWMQyKzTBNeor4vI/x6a0EHUtqV2u4une
	bXa1UyHN/IwjyAptaEJbsqNpMnVQ4CFk2PnyEuxbEQ8fIS7OY4V6clg6gAlRKqYj+ubR
	jFKqY9kr8jjn13C05H4/koyULaZsConVTJAsR8GS93XdNVakvp8lczobTiVZf2+hCELM
	t2lOiWpwCuLOfIuVTraN9tHNGXYFfsNpFzsf2Swo6/uYTVaC1b6/T6jsSNP6gMkuvsmX
	zKwGWWUrNiBmCXyomw4vEI4fgGd0/QklId4lN5mYtrW4xLLiQjVa+x6w4RMuU9GQsbMt
	Z89A==
X-Gm-Message-State: AJcUukcfQQ9/M1uqqQ01W53q0/HjyN1zK5C5Xj/Tp2XvOxXyAPT4wWo3
	svew7sU4nxUbOO73qF07KOjvZxmrhH7I4g==
X-Google-Smtp-Source: ALg8bN5Gri1PP7pDllowFJk2hrLVP06D75iVpluq1aAGX6odB/MPGEB+Cl5AmHHCW80gVbzCg6sK1A==
X-Received: by 2002:a5d:5649:: with SMTP id j9mr2438548wrw.256.1546977808920; 
	Tue, 08 Jan 2019 12:03:28 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o16sm68107612wrn.11.2019.01.08.12.03.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 08 Jan 2019 12:03:28 -0800 (PST)
Message-ID: <3a6c9b9d4f67d05e2fe7efebe78dc7373030c9dd.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: "Slater, Joseph" <joe.slater@windriver.com>, "Hatle, Mark"
	<mark.hatle@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Tue, 08 Jan 2019 20:03:27 +0000
In-Reply-To: <007BD92917A2324FA403BCF9A464CF84F37255A6@ALA-MBD.corp.ad.wrs.com>
References: <007BD92917A2324FA403BCF9A464CF84F3723F13@ALA-MBD.corp.ad.wrs.com>
	<49a16b88d162e9d3aa3db88deaed47147d914429.camel@linuxfoundation.org>
	<d718f0d7-3834-3b42-2fc2-3667ed4e899c@windriver.com>
	<d87ce682d2a0e2eda230e8b0e7799f2ec68f46db.camel@linuxfoundation.org>
	<007BD92917A2324FA403BCF9A464CF84F37255A6@ALA-MBD.corp.ad.wrs.com>
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Subject: Re: /run/user/<id>/bb
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
X-List-Received-Date: Tue, 08 Jan 2019 20:03:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-01-07 at 20:48 +0000, Slater, Joseph wrote:
> Specifically, libassuan, which is used by gpg, puts named sockets
> under GPG_PATH and that is set by sign_rpm_ext.bbclass to be under
> TMPDIR, although we could override that.  I think that libassuan
> computes the absolute pathname to create the socket.  I admit that I
> did not look very hard at libassuan, but a fix did not seem
> immediately obvious.
> 
> Having a RUNDIR might not be a good idea, though, because it opens
> the issue of how it gets cleaned up if the user never logs out.

That as well as how we differentiate between multiple builds from the
same user or even different multiconfigs within the same build.

I suspect there are safer ways to handle this within TMPDIR even if we
have to patch things...

Cheers,

Richard


