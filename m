Return-Path: <jpewhacker@gmail.com>
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
	[209.85.128.51])
	by mail.openembedded.org (Postfix) with ESMTP id 228977DB57
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2019 22:23:34 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id u8so10283995wmm.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2019 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to
	:content-transfer-encoding;
	bh=FVTpkmULGZiJXG3k9Pb7KBMOI91TR2POcGPkqUBdXHQ=;
	b=FYzxoxUiyF6lJW1lNskWI0aLge+14dKcBo55ASs9IO0FUOGexm4yvoqyh0jTRp5RYY
	TPrSxokv1pFO8mVWIphApuet36GiJq1gVDzqC0svKg6j5xZOjVyUQw+9VfeczEGJCnNG
	0IO9FRFWXaHOoDAxOZ51I5SezNcMq4WI+FMMM6f5mCS5qXHbvhyviLlugF4NdDvSx/ak
	fTPyiTHgCXFNAN4rRrmW9igjO0c5Zs4zvfeK+hF1VlkXa03bXHxbUQy3JJxIoMR5rp9R
	NXn/c/E98tGT6gc5gIjmLiSG/gPCS4HDfZkIcYu7fPU8gx7uYrs2BSBaYxJ+jylWvmAN
	HDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to
	:content-transfer-encoding;
	bh=FVTpkmULGZiJXG3k9Pb7KBMOI91TR2POcGPkqUBdXHQ=;
	b=it/OFcO2USbiLJRhrId1Jl8Ba9zAfz3WYbRMJXycEb3viQyIBqSrgTGq769hDe/QU7
	7VgN2yyG1ORi7lBDvOCGPtqNSNfNDME0c0nx3zINNegO/55fTEK13QWjB3jU18TM//9D
	Rv359CHK43HaDrZOrt6nBTq2w+ZOU+8dUi0RNWpg6hNIQOqPEhZO6TkIJ/Fm2j2KmR6E
	6jj1USMiI6OwRXRrUJUtoHecbOjC9Zd8VA+2fIDkBmw6oV1JQj+Bw5kheJKq2r5iIjoI
	xkdlRMTigcNEW/Xr3w5LyXg4h3rE40cQ5PXv1V+aMsRdAZiZ4cohd/shjmqB9EOVs2rs
	P9Kg==
X-Gm-Message-State: APjAAAVL8sGKaUkD7SYLO8SOMLBQ6kgu5e6w4uHaMr+RpqMzbUOgiaBn
	wThdondyWLJi6vD1gea0CMyb5EnRigvRoCFjPA4yAVqX
X-Google-Smtp-Source: APXvYqwFz1iKPPbDLI5L/OWvB0ADkdX5txv28AwF7kQGkOsCia2A28hjZa9yq8dPG9RmO6vc8ujr7FCdQ/hHfGtFjEQ=
X-Received: by 2002:a7b:c398:: with SMTP id s24mr8737259wmj.53.1561760614574; 
	Fri, 28 Jun 2019 15:23:34 -0700 (PDT)
MIME-Version: 1.0
From: Joshua Watt <jpewhacker@gmail.com>
Date: Fri, 28 Jun 2019 17:23:23 -0500
Message-ID: <CAJdd5GbvT5NaKsn0MvLLKWaHuo2izHCLxGPW0oN88+EKxO-G2A@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: setscene fetch failures are fatal
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
X-List-Received-Date: Fri, 28 Jun 2019 22:23:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm having an issue with the _setscene tasks failing to fetch causing
our builds to fail. For example: we see the following in our CI build
logs:

 WARNING: flac-1.3.1-r0 do_package_write_ipk_setscene: Failed to fetch
URL file://07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cort=
exa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.sigin=
fo;downloadfilename=3D07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.=
3.1:r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ip=
k.tgz.siginfo,
attempting MIRRORS if available
 ERROR: flac-1.3.1-r0 do_package_write_ipk_setscene: Fetcher failure:
Unable to find file
file://07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cortexa1=
5hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.siginfo;d=
ownloadfilename=3D07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:=
r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tg=
z.siginfo
anywhere. The paths that were searched were:
  /tmp/tmp.S3vCIuI7SE/sstate

The build carries on as normal and even builds everything
successfully, but the final error code returned from bitbake is '1'.
This is particularly annoying because A) this happens a lot and B) the
build did actually produce usable outputs so failing isn't really
accurate.

Near as I can tell, this is caused because the knotty UI treats any
logging.error() message as fatal and will have a non-zero return code
if one occurs.

I also realize this is probably mostly caused by an infrastructure
problem on our end, but I don't seem to be able to get anyone to
magically make that better so that this failure stops happening :(

Does anyone have any ideas for things that could be done to mitigate
this? So far, the only thing I've come up with is to modify the
bitbake Fetch.download() so that an argument can be passed that says
whether to use logger.error() or logger.warning() when reporting an
error, but that feels really ugly.

Thanks,
Joshua Watt

