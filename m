Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1ScJkq-0005Qx-00
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 19:10:44 +0200
Received: by eaal1 with SMTP id l1so1986831eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Jun 2012 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=I6SMoZhLr0f+gvjbYeD2X/JCZJUC2tP8NaBgu8Jbn1U=;
	b=FyymzNyuBb6fjf5ANvlctbDdOMzGybcxjdYl4f55Om/tbmhjW4ieJoOjRF3Jp3CLtf
	tjAiWjHP8AQY2haLuhmOqMYm3WFbxBf5jPUo/rXGOyhh+rqAp6SOwq7yaG/kT3yT6m7r
	DsKQzGHcusD4a/6OL2OwTNkReH3hBn0wYfIqgWxEsuSLPxRQkgVEDmBLRVkPJaMfoCid
	CTjR+zGctGXf92YBNhjPkWywV84zzZemvCRBj/R6B6sibbZA/f0zWrEdeLceszoGNZK6
	XAadDpvAO/3QtC9valyjxVygEi5/0XEirdpEevixaUe5NfyGRl8m29ed8xkVFbh6Hlre
	lq2Q==
Received: by 10.14.119.197 with SMTP id n45mr9933769eeh.180.1339002016293;
	Wed, 06 Jun 2012 10:00:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.14.188.11 with HTTP; Wed, 6 Jun 2012 09:59:46 -0700 (PDT)
In-Reply-To: <098684E1B7B2F54491C5DA349D2EF443098C4884@POCITMSEXMB03.LntUniverse.com>
References: <098684E1B7B2F54491C5DA349D2EF443098C4884@POCITMSEXMB03.LntUniverse.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 6 Jun 2012 09:59:46 -0700
Message-ID: <CAMKF1sr_5n7kUVvb+aUYUqq8Amap-h2zSa=RiiiY0tvJyV9BSw@mail.gmail.com>
To: Girija B <Girija.B@lnties.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Error when Setting up Open Embedded Environment
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
X-List-Received-Date: Wed, 06 Jun 2012 17:10:44 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 31, 2012 at 10:11 PM, Girija B <Girija.B@lnties.com> wrote:
> I had installed Bitbake and open embedded as described in the OE User Man=
ual
> , when I tried to Build using : bitbake build command , am getting the
> following Error ,


How did you install it ?
you should check it out from git repo and use it not the package
provided by distro on your build system

>
> Please help in solving this .
>
>
>
> solar@ubuntu:~/Downloads/test/build$ bitbake build
>
> Traceback (most recent call last):
>
> =C2=A0 File "/usr/local/bin/bitbake", line 143, in <module>
>
> =C2=A0=C2=A0=C2=A0 main()
>
> =C2=A0 File "/usr/local/bin/bitbake", line 123, in main


