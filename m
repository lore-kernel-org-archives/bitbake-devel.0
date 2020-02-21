Return-Path: <raj.khem@gmail.com>
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
	[209.85.222.182])
	by mail.openembedded.org (Postfix) with ESMTP id F00F061716
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2020 19:54:13 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id l13so270934qkk.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2020 11:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=6GvGLX54WKNRoYpXOnbJjyA7XGB3oM0iBb17DGAaLYY=;
	b=O4C4dnQ4t0F3PKBcBywWFuJIfu312EoO5xCyV5Oo/83c7OZQ5xJB7DfEDrv2qom6TI
	62tF3yvqixTD905kd6FelAevER0DgVaBKRcPypIUY3V7mf5fwyGZIO9iiOEfPi0CRGt1
	yqvDn40l5/6rO97IdGJH5KHwfQ+u2D9zgDGdOL9iKo9X/wX10W8hiORRUZay9F/O/SHo
	kbcJCsoVGe83fK8QMZJCW0vK13wnuMmflq18qDm0jVB76sx0JjAlZ0KZrGwhfEEM5ZqO
	EzaGNL7Ia5MTjUr8EpguycwbaGug2HEB9S/2HL9Ll5OWJM0Ch3HjQxgi/NUnF3m7jJ4/
	XQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=6GvGLX54WKNRoYpXOnbJjyA7XGB3oM0iBb17DGAaLYY=;
	b=YE14csd5AdwXLWfXF1oMndWMd2t94npAfNaCZInRwOj2vMJyH92NJDo8Z5bo0Y3y/K
	apBvaKvzhlHK1rdslJEnFMtTRq3GbGcx8hvmQ/t58dFOKmyFuEumaEv4QHyQHSyCwpG0
	kJDt5FoUWn6zS/Ka9uommTzP6O5cma6lfm7x4SVn33HbHeMD+8qu7ct9HSvPP0slWCCK
	vGQRCZWFs5u9OWU3ZuLFh1W057LZSbxP17A8e4WHykyYDCwwlKzGI6u17NRvgHX+Df5D
	ylhMiE+vFtfNnr7grt6sGeY2gYBMnO2yFNmepamoFKZU4CTGxEzfS9oJBh8Hjg5CplEd
	H+MQ==
X-Gm-Message-State: APjAAAV/FaTjx31Wnr17mzwsOWMlTWV5XHTYg2wI6hbMPi718mKeqvLF
	AkJSaEol4EvXliwb84t28R6wuonxZXJRE9bfKWg=
X-Google-Smtp-Source: APXvYqxSN6el1qdtaFZv0x0aT/nsw3+1iDXlLVz7As84BawnEr8XC1s48N0qao+GdI/EEJZq81bADbtwAt+KVsQZ3rI=
X-Received: by 2002:a37:e47:: with SMTP id 68mr12151725qko.17.1582314854524;
	Fri, 21 Feb 2020 11:54:14 -0800 (PST)
MIME-Version: 1.0
References: <CA+ABUwgr=FsQ8grXtuhL1ggsHn3HMPRu+uC1QHR8paxYxK6_qQ@mail.gmail.com>
In-Reply-To: <CA+ABUwgr=FsQ8grXtuhL1ggsHn3HMPRu+uC1QHR8paxYxK6_qQ@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 21 Feb 2020 11:53:48 -0800
Message-ID: <CAMKF1sqjOhuUv8NkZZxt8X4yEWuZ2i53fef4YNnYG=auG48VPg@mail.gmail.com>
To: =?UTF-8?Q?I=C3=B1igo_Vicente_Wali=C3=B1o?= <inigovicentewalino@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake error
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
X-List-Received-Date: Fri, 21 Feb 2020 19:54:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 3:54 AM I=C3=B1igo Vicente Wali=C3=B1o
<inigovicentewalino@gmail.com> wrote:
>
> Hi,
>
> I'm trying to build yocto project ZEUS for imx8m mini.
>
> I have this configuration EXTRA_IMAGE_FEATURES=3D =E2=80=9C ssh-server-op=
enssh tools-sdk tools-debug dbg-pkgs dev-pkgs doc-pkgs package-management t=
ools-profile=E2=80=9D in my build/conf/local.con file.
>
> But it reports error when executing bitbake core-image-base.
> Host environment: Ubuntu 18.04.3 LTS
>
> Can any one explain how to resolve this?
>

perf uses kernel sources to build and its perhaps related to BSP
kernel you are using to build the image
that it might need certain tweaks to compile perf, it seems it asking
for using python2 so perhaps you can inherit pythonnative in the perf
recipe and that might help

> The error log is below.
>
>
> Thanks, best regards
>
> I=C3=B1igo.
>
>
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

