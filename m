Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>)
	id 1TCW5u-0005vw-1C; Fri, 14 Sep 2012 15:38:06 +0200
Received: by daks35 with SMTP id s35so2294738dak.6
	for <multiple recipients>; Fri, 14 Sep 2012 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=nfYd0Xf0r9GVxfClPw7F3ph+oZaSZHCeX0QYGxxw1f8=;
	b=Kabi03NUAEezUhjNIqXjqGuXWwfGkt1FTGT0gd5AjXMGgN25DZZRPWuXWZT86fhtjn
	Ry9tB0LNq5jWJJtigB1hW39WmE1EBozuINtBj65by+wU3yTnvZJ6nv2y5kEKk4QAstmd
	okuQbGipmDTU6efO/ad85FMceQJ947L0/f/d5lXsJ3uexVLrqc7ehp8g5EGBGjUWKedA
	sRUlHgyFxY9F1bHh6lsfaOKFvdRpxIjl5KlUZY2vYwTTpOQkIuFCvAFVT7lLegBS92VX
	RX3qLx2Q+ay/tBU26WnFql/cKGDpoBjqbzkYD0VW47cjrvFt2GHHxxeLNbbiC4iN1nE4
	zrRg==
MIME-Version: 1.0
Received: by 10.68.224.133 with SMTP id rc5mr5052360pbc.130.1347629130344;
	Fri, 14 Sep 2012 06:25:30 -0700 (PDT)
Sender: otavio.salvador@gmail.com
Received: by 10.68.36.105 with HTTP; Fri, 14 Sep 2012 06:25:30 -0700 (PDT)
In-Reply-To: <1347629023.13596.12.camel@ted>
References: <cover.1346905978.git.raj.khem@gmail.com>
	<5c54fcdb91d19909f8658b6a6e8d6e6cac934cf2.1346905978.git.raj.khem@gmail.com>
	<504FF70B.7060701@mlbassoc.com> <1347458928.11710.21.camel@ted>
	<CAMKF1so6qUDFMw_aOZTdC4W_Dh=rDiiC1O7pvjaUQS2xkG8xWg@mail.gmail.com>
	<20120913121935.GC18675@giant>
	<CAP9ODKp8sKpVMi9MwdFxwZTq2-VMiRGzDzD=bBrFu8r4hZ0xMA@mail.gmail.com>
	<CABcZANkbpR66G2-4WnBjdcjUGd4Khbje-kvpd2geUaVMMxE=4A@mail.gmail.com>
	<1347623908.13596.2.camel@ted>
	<CAP9ODKpZp1bhNg-EoHUYhU1YCU3=dRULpT8K_QCPZ9VLS8+xZg@mail.gmail.com>
	<1347629023.13596.12.camel@ted>
Date: Fri, 14 Sep 2012 10:25:30 -0300
X-Google-Sender-Auth: 7YymmaL7QELkWaRX63ZyYHKFr6s
Message-ID: <CAP9ODKpmveRGD02wP1DAO=+C0xa4sC3FfxaOud2zE6J=4zspmg@mail.gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 1/4] gcc: Switch SRC_URI to use svn
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
X-List-Received-Date: Fri, 14 Sep 2012 13:38:06 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 10:23 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Fri, 2012-09-14 at 09:36 -0300, Otavio Salvador wrote:
>> On Fri, Sep 14, 2012 at 8:58 AM, Richard Purdie
>> <richard.purdie@linuxfoundation.org> wrote:
>> > On Thu, 2012-09-13 at 07:22 -0700, Chris Larson wrote:
>> >> On Thu, Sep 13, 2012 at 6:06 AM, Otavio Salvador
>> >> <otavio@ossystems.com.br> wrote:
>> >> > On Thu, Sep 13, 2012 at 9:19 AM, Bj=F6rn Stenberg <bjst@enea.com> w=
rote:
>> >> >> Khem Raj wrote:
>> >> >>> I agree but then 1.7 GB is noticeably huge too and it will only b=
ecome
>> >> >>> larger in future so I don't think fetching from git will be a goo=
d solution
>> >> >>> for gcc ever.
>> >> >>
>> >> >> Can we use shallow clones? A quick test of gcc-4.7 gave me a 308 M=
B tar.gz when cloned with --depth 1.
>> >> >
>> >> > I did not check if the fetcher has this support  but it would be a
>> >> > nice solution.
>> >>
>> >> Shallow clones won't be able to support SRCREV properly, as you can
>> >> only clone shallowly from HEAD, not from an arbitrary point in
>> >> history, AFAIK.
>> >
>> > Right, shallow clones are a can of worms from a variety of angles.
>> >
>> > My current thinking is a ;allowsinglerev=3D1 parameter to the git fetc=
her
>> > which:
>> >
>> > a) Generates tarballs of single git revisions if tarball generation is
>> > turned on
>> > b) Searches for single revision tarballs before trying the main checko=
ut
>> > approach.
>> >
>> > This would mean that WORKDIR may or may not have a .git directory for
>> > any SRC_URI marked with this. I think we should all be able to live wi=
th
>> > that and it shouldn't break too much?
>>
>> We'll end with multiple tarballs, aren't we?
>
> Yes. I'm not seeing that as a big problem for most of the usecases where
> we'd use this feature. You could skip shipping the big tarball of the
> whole repo at distribution time.

By the way, there're any tool to clean the repo? (as we do for sstate-cache=
)?

--=20
Otavio Salvador                             O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br


