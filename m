Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1Sj2Q5-0004xF-AV
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jun 2012 08:05:05 +0200
Received: by eaal1 with SMTP id l1so1127481eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Jun 2012 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=7mVOg5S70xX8HD0ZVT4/ZecIYnF1C9mZ7ycO/SLFaKc=;
	b=Y1iSxpy5zT93xKGJs9Hae3aLM15uYJL419opX30x/n1KaIb8fxyvW6Rb4gd8rOPMGt
	G5AolWVn7j/qi/E7tM8AjDF3Maa6goh/6V0QCY/F6ydNeSo3NsYNdC32eF1lmrB/mfPt
	RrkYT5L1NytHMWO4O3JUY480LHvzsOmz6oVzfUNKMSGC4juy08GHSoPpm3lQpjwOZGJ7
	whkaMrNREyTY9X8zdaFmr3Z4X+4qOFr9F4auTimLXe306ERP4rXDTrgqIJP2/fYTZxWU
	vwEcmd0aNeaEaJZ2KCAhYgK/NsAaabrrF4ir9cjQppuI97YdXE25WfGLX6nDKDaYSN7k
	oImA==
Received: by 10.14.37.76 with SMTP id x52mr2163622eea.102.1340603654889; Sun,
	24 Jun 2012 22:54:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.14.219.71 with HTTP; Sun, 24 Jun 2012 22:53:44 -0700 (PDT)
In-Reply-To: <20120625003941.798e4914@wrlaptop>
References: <752ca278.1ab5.138076d8860.Coremail.scanli@126.com>
	<40776A41FC278F40B59438AD47D147A90FDA26A2@SHSMSX102.ccr.corp.intel.com>
	<20120625003941.798e4914@wrlaptop>
From: Khem Raj <raj.khem@gmail.com>
Date: Sun, 24 Jun 2012 22:53:44 -0700
Message-ID: <CAMKF1sqW-V-j8iQ3pioAt362SxnFWkENARus_9sF5QKK3+vM4g@mail.gmail.com>
To: Peter Seebach <peter.seebach@windriver.com>
Cc: =?UTF-8?B?5p2O6YeR5oiQ?= <scanli@126.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Hob can't support external toolchain?
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
X-List-Received-Date: Mon, 25 Jun 2012 06:05:05 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 24, 2012 at 10:39 PM, Peter Seebach
<peter.seebach@windriver.com> wrote:
> On Mon, 25 Jun 2012 00:51:08 +0000
> "Xu, Dongxiao" <dongxiao.xu@intel.com> wrote:
>
>> Well, we met the same error (No GNU_HASH in the elf binary) even with
>> command line. The different is that we failed on =E2=80=9Czip=E2=80=9D r=
ecipe.
>
> There are a number of packages which do not pass --hash-style=3Dgnu to
> the linker correctly. =C2=A0With the native toolchain, this doesn't matte=
r
> because it's the default. =C2=A0With the CS toolchain, you either need a
> bunch of INSANE_SKIP_rpmname =3D "ldflags" or to get a build that's been
> modified to enable GNU_HASH by default.
>


you can also add TARGET_CC_ARCH +=3D " ${LDFLAGS}" at global level for
external toolchain.

> -s
> --
> Listen, get this. =C2=A0Nobody with a good compiler needs to be justified=
.
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


