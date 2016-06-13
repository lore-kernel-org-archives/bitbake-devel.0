Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
	[209.85.214.46])
	by mail.openembedded.org (Postfix) with ESMTP id 3B1126FF6B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 14:20:30 +0000 (UTC)
Received: by mail-it0-f46.google.com with SMTP id h190so43866175ith.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=/RdQbxyWN9s5EPeiTsnb9u7nEqChbNtQDb4QAAKhHdk=;
	b=lHSP991jCF7AV+SR1QoiPgJdd2nBrYXpYwRtfV8/jKqWtTxaTgaEGE79UWLgKgDs9W
	mx4IoKFRty4pCZbqt90hwrRT7evryUY+fcMGm5yqyIzCCUznt33nXIm4n0WFpGdB1Wk7
	/beAZ/mNdkCV4PAySwInTJMPlKC7/ugk+czG9/A6tdbk+fOWEB00YkftdHuCzQrKIawb
	zbwKCSz+KbE3lhctU4HsZEBLxHNiFmbtG4AQLARuuwIxkofcvMM/oZ2BSzZxSG16VVBR
	a/jD1eaYLJwbpK2xq5xNLfCJbZc/tu86OaCoJxHXVZzgVJPTAAgh23F4TewpzwqBGQis
	ucRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=/RdQbxyWN9s5EPeiTsnb9u7nEqChbNtQDb4QAAKhHdk=;
	b=V2aGpD/pbWe4Esf+mZAxzXbrg3DWKo1kcx1BbYnbOCmbr38yd8cq4p1/YAlz2YogUW
	239T1pe54ZUBTxp9g1DoPC15b29pSoYoBXUBiNnjwBgL137VL6ihxWmKntwg8LNpOeES
	krhenyUwJkQBSAL8uXmL2ceWF+wgducxTJrSnLgdVCsWX9exCJ3r5CPfQmud1mMAbIMs
	cKXtS0wrM4mA/68sLzoG1qFOX34mN4yE00x8JcsIJMBsa5d/vo3dXJM7oGqBcBaqbyfu
	mTfU3cdOGKlASGWgr9/5NXeB7icqYJOGyTe0Cim7RgYS67CKyBlgRkcufJ2J16dSYrlE
	s8LQ==
X-Gm-Message-State: ALyK8tLFmkOngHIOAP0+b8NXWXEoXBj6dc+g1T8f4BaNjdnrCy/afOUZKttzrrReVL1fyqtw
X-Received: by 10.36.65.71 with SMTP id x68mr2260234ita.86.1465827631008;
	Mon, 13 Jun 2016 07:20:31 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8D775.dip0.t-ipconnect.de. [93.232.215.117])
	by smtp.gmail.com with ESMTPSA id a36sm7978492ioj.2.2016.06.13.07.20.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 Jun 2016 07:20:29 -0700 (PDT)
Message-ID: <1465827626.28632.31.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Otavio Salvador <otavio.salvador@ossystems.com.br>
Date: Mon, 13 Jun 2016 16:20:26 +0200
In-Reply-To: <CAP9ODKrXpD1RC2AVxqszvkM3MZsQ-1dU=BNO4DNzGgCg8k+avw@mail.gmail.com>
References: <1465572809.13979.185.camel@linuxfoundation.org>
	<20160610160710.GA18625@openSUSE-i7.site>
	<1465575223.13979.188.camel@linuxfoundation.org>
	<CAP9ODKrXpD1RC2AVxqszvkM3MZsQ-1dU=BNO4DNzGgCg8k+avw@mail.gmail.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Multi-configuration builds
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
X-List-Received-Date: Mon, 13 Jun 2016 14:20:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-06-13 at 10:48 -0300, Otavio Salvador wrote:
> > Would people really want to support different bblayer files? That would
> > complicate things quite a lot :/.
> 
> The multi configuration should imply same metadata setup; for
> different things people need to use different builddirs.

I agree. Using the same set of layers is sometimes a bit painful to
achieve when BSP layers assume that merely adding the layer is supposed
to modify the resulting build, regardless which MACHINE is selected, but
that's a problem that should be fixed in those BSP layers.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




