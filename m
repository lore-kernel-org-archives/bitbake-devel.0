Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 195B37CD3E
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Mar 2019 12:21:57 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id o17so621935wrw.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 02 Mar 2019 04:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=yGPk9JFA1aC/NLU9XeAYPtbbLx9fjEH0J2l86yvy6yo=;
	b=YdGFcrMnJ0OVwtIIeNC8YWDOMgglSCsKWk+5csPEjjxAmEm9290XAV5099Bh+hpLWx
	2Lms25SrF9NjTLrNasVll8uQKwYCWPxGzhuRuoHgcKstokSkNGEp0606kMVUI1fncHmC
	ukCc1B+dywhWwoLp3EM1S5ks/Dz1Abi/0UuPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=yGPk9JFA1aC/NLU9XeAYPtbbLx9fjEH0J2l86yvy6yo=;
	b=ntIr952MuO1gfeEJ67BIc7v5oTZfPhdX/ElFMlRNWUCmnOdzFMP5RXH7d7OUqfCowV
	fRB833S5GZXBXYq3AmT0kytrPMsSAE8V+NvzCiWi02vdTgluITdVnK5ozqpoBOhLiujW
	Ko52Pkfs3e+hpT6yznkYQ3MAW9zc1STvDriE5gHdKBU0Z08lCq1Oi3OBWNVQymgtakrS
	0pcmQnIYvqAWRajudzjJFAj0Aqxc3bazE9YcJWkmnoNyx5V8ASEBTO3z+2boyLvAXh87
	tcOItGxKtTvNRR9cAhoCZTGYmG8cC709OivaeEJQmjvOPFl6tWFiceBcIu2GlPRahQ93
	C13Q==
X-Gm-Message-State: APjAAAWd1SZvsmRcbCHD2E8FGOOCe566ZMxWYUJlr4lwoSYwHj7gv+0L
	gm7+qlGbiBY/y8DUIrhgXLpe1g==
X-Google-Smtp-Source: APXvYqyyvExda3q/S60Ogn56AWdPp1zM8mVvIkfwM2Hu8netAwCo1HpFzlg0NCvn7f9Ss248Q7Gqzg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr7196587wru.59.1551529318559;
	Sat, 02 Mar 2019 04:21:58 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c126sm2045259wma.0.2019.03.02.04.21.55
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 02 Mar 2019 04:21:57 -0800 (PST)
Message-ID: <d104283b569d34efec7502fe4ade89c34f2ba3c9.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, openembedded-core
	<openembedded-core@lists.openembedded.org>,
	Daniel Gomez <daniel@qtec.com>, bitbake-devel@lists.openembedded.org
Date: Sat, 02 Mar 2019 12:21:53 +0000
In-Reply-To: <CAPybu_1GLgMMBysaCD0GDiPSmJr6jEqVptzX6+DQmU7ZBOigMA@mail.gmail.com>
References: <CAPybu_1GLgMMBysaCD0GDiPSmJr6jEqVptzX6+DQmU7ZBOigMA@mail.gmail.com>
User-Agent: Evolution 3.31.90-1 
MIME-Version: 1.0
Subject: Re: [OE-core] Two recipes providing the same .so... How it should not be done :)
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
X-List-Received-Date: Sat, 02 Mar 2019 12:21:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-03-01 at 12:28 +0100, Ricardo Ribalda Delgado wrote:
> Hello
> 
> I have a build system that supports some aarch64 machines. For most
> of
> the them, the only difference is the kernel configuration, kernel
> version.
> 
> I am using multiconfig on my build server and the build goes really
> fast thanks to all the shared binaries/artifacts.
> 
> But I have a problem adding a new machine. This machine is also
> aarch64, with a special kernel (nothing new here), but in this case
> the vendor provides a binary .so for libgl that is required to get
> hardware acceleation.
> 
> I could .bbappend mesa and on the installation part replace libgl
> with
> the new .so. But then everything that depends on mesa needs to be
> rebuilt for that machine and I could not use multiconfig.
> 
> Instead I have created a new recipe: mesa-gl-replace.bb that has the
> file. This breakes completely the design of OE, but works.
> 
> Some snipsets of the "magic" to make it work:
> 
> #Force that the version is allways higher than the one from mesa:
> PE = "5"
> 
> #Rprovide the same as mesa
> RPROVIDES_libgl-mesa += "libgl"
> 
> #Do not overwrite pkgdata of mesa
> PACKAGEFUNCS_append = " rm_pkgdata_runtime"
> rm_pkgdata_runtime() {
> rm -rf ${WORKDIR}/pkgdata/runtime/*
> rm -rf ${WORKDIR}/pkgdata/shlibs2/*
> }
> 
> #Keep this on machine
> PACKAGE_ARCH = "${MACHINE_ARCH}"
> 
> #Make sure we are not saved as providers for libgl
> PRIVATE_LIBS = "libGL.so.1"
> 
> #Avoid sanity checks
> read_subpackage_metadata () {
> }
> 
> 
> If your eyes have not fallen as this point, this means you have a lot
> of tolerance for crappy code, congrats :)
> 
> Now the question. Is there a better way to do this?

I'd probably let mesa build as normal but then add a recipe which
RRPROVIDES, RREPLACES and RCONFLICTS with the specific mesa package you
want to replace. It would create and equivalent package with the right
contents and make it machine specific.

There should be more variables like PRIVATE_LIBS which stop you having
to use the more horrible hacks (INSANE_SKIP_*?).

You might then only have the issue of ensuring this machine specific
package gets installed into the images which need GL (or just install
it in all images for that machine).

Cheers,

Richard


