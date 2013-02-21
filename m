Received: from mail-ve0-f177.google.com ([209.85.128.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <pranap@gmail.com>) id 1U8gEZ-0000gq-FZ
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Feb 2013 01:11:30 +0100
Received: by mail-ve0-f177.google.com with SMTP id m1so83144ves.36
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Feb 2013 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=jiAl6bJCOR0tkKaZBCMH5EYwUD+o0FA5k93Tluo7hv4=;
	b=BUFKhVL06sU6PiULCOYKyPK7dD1CnC+G6nwnBcT9RHXjWX8V9EMMbFB6chrWbWAJ2a
	qxkx9rK+IZcScJNODouUsPc4vLX/uQcunikWFKYCJe6IX40SBpATtVWU2tjmcYLFlCOB
	v0q3d5MIxuDg9GGFofBoTImwGCsmquDf2GGAHIKlsryROdGhFPjUnM+jSwVgp9FWTjbB
	epuICKPUmceusNBiolv31j3x40vcB3C2lHh9oKgRDDNq0Oft6EjEvVyj4awnvQkido0h
	aj+0Sw4c6MVjMqn+dSo5gVgzLDu1zNR2iuGgix5TukzbJBX7wsZN2XbnE07oS38zTpEc
	g/lQ==
MIME-Version: 1.0
X-Received: by 10.220.241.141 with SMTP id le13mr33240725vcb.26.1361490913523; 
	Thu, 21 Feb 2013 15:55:13 -0800 (PST)
Received: by 10.58.186.229 with HTTP; Thu, 21 Feb 2013 15:55:13 -0800 (PST)
In-Reply-To: <1361460215-30292-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1361460215-30292-1-git-send-email-paul.eggleton@linux.intel.com>
Date: Thu, 21 Feb 2013 16:55:13 -0700
Message-ID: <CAKFDafV47wYzXObALnyFVnzcKRzcqsx0Yy+7mYF4FBu8r1nsXg@mail.gmail.com>
From: Pr Pe <pranap@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] build.py: avoid deleting taint files when writing stamps
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 22 Feb 2013 00:11:32 -0000
Content-Type: multipart/alternative; boundary=14dae9cdc32b43f8c804d644cec1

--14dae9cdc32b43f8c804d644cec1
Content-Type: text/plain; charset=ISO-8859-1

I have an image recipe (appending to core-image-minimal) that builds
components specific to my project and I get a bzImage and a
core-image-minimal.iso out of it. I want to add some bootloader code to be
built as a separate entity  like bzImage and not as part of the
core-image-minimal.iso. Is there a way to do this in yocto?

Thanks,
Prana

--14dae9cdc32b43f8c804d644cec1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I have an image recipe (appending to core-image-minimal) that builds c=
omponents specific to my project and I get a bzImage and a core-image-minim=
al.iso out of it. I want to add some bootloader code to be built as a separ=
ate entity =A0like bzImage and not as part of the core-image-minimal.iso. I=
s there a way to do this in yocto?</div>
<div><br></div><div>Thanks,</div><div>Prana</div><div><br></div>

--14dae9cdc32b43f8c804d644cec1--
