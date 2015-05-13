Return-Path: <jatedev@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id B115874059;
	Wed, 13 May 2015 22:47:03 +0000 (UTC)
Received: by pabtp1 with SMTP id tp1so64094556pab.2;
	Wed, 13 May 2015 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=5N4kzDZC1TRe54/gXpGtJ2LN8ksQhOmZujPsisu9OTk=;
	b=S0JcucBfg+sLre7W05bIWgXIbGvXkzbRGl/zYp7kEj7UP7jUKayssCzZodCiKYpnci
	kxK/+nTCv4OB0BtQwmPUoqkNNglBWDMRJGn2kEj/g2HfFVu9QtxPi40fOmn7LriP3635
	zPynft4V1Vz/sgpZ+fAA1LblOsf9bm7MLkZYyY+s0yr3g8ptqsNsRqfu5kxQyb2dnuf7
	Y2gicljvuOCJcONqrCAWYHKUxMALapHCeISiYJi9WgSgTUsy9cW8dAs6J2AaOC+bkqrm
	X6WGpYDdJZI2a/K83yO9V9pK9siyluepTW+YvwuxNAsyiXZImSGwoR1h5dpPX01H/Zy2
	bLrg==
MIME-Version: 1.0
X-Received: by 10.70.95.131 with SMTP id dk3mr2212845pdb.44.1431557224440;
	Wed, 13 May 2015 15:47:04 -0700 (PDT)
Received: by 10.66.142.201 with HTTP; Wed, 13 May 2015 15:47:04 -0700 (PDT)
Date: Wed, 13 May 2015 18:47:04 -0400
Message-ID: <CAPphmgZ=za2uinJsgrT2nom1rYeKFOnbE-Nr+BndXV+wf6spnw@mail.gmail.com>
From: Jate Sujjavanich <jatedev@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org, 
	openembedded-core@lists.openembedded.org
Subject: [PATCH v2][0/2] Yocto Bug #6149
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
X-List-Received-Date: Wed, 13 May 2015 22:47:09 -0000
Content-Type: multipart/alternative; boundary=001a11c2ddc6d6a7130515fe637b

--001a11c2ddc6d6a7130515fe637b
Content-Type: text/plain; charset=UTF-8

Richard,

This version uses PREFERRED_RPROVIDER instead of PREFERRED_PROVIDER to
reduce confusion.

These patches add PREFERRED_RPROVIDER which specifies a preferred runtime
provider for a package when multiple RPROVIDER's are available.

It selects the preferred recipe to build and installs the preferred
RPROVIDER during image generation.


Jate

--001a11c2ddc6d6a7130515fe637b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Richard,<br></div><div><br></div><div>This version us=
es PREFERRED_RPROVIDER instead of PREFERRED_PROVIDER to reduce confusion.<b=
r></div><div><br>These patches add PREFERRED_RPROVIDER which specifies a pr=
eferred runtime provider for a package when multiple RPROVIDER&#39;s are av=
ailable.<br><br></div><div>It selects the preferred recipe to build and ins=
talls the preferred RPROVIDER during image generation.<br><br></div><div><b=
r></div><div>Jate<br></div></div>

--001a11c2ddc6d6a7130515fe637b--
