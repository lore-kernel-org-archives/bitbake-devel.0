Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>)
	id 1TCVKT-0004mt-B5; Fri, 14 Sep 2012 14:49:05 +0200
Received: by pbcwy7 with SMTP id wy7so5291754pbc.6
	for <multiple recipients>; Fri, 14 Sep 2012 05:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:date
	:x-google-sender-auth:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=087Bm0DgKzZvDEsxuPZyKi70zNpGw0tC5ZMRqWNeaYw=;
	b=0TnICjqVFsSqVc7RisEpn5fKgC6thzpBRj5MV+8NcX2yul9E5bVCuJvmpMCrPxfjjb
	OAw2ydoP7WJqOCPllvoPxFP1H0cHoM2rEGR0soyNINOEW1tRIOg8lds2raIj2DOLjiDv
	i4yxcAJ8f3zW/dqlGkWDLbipmMb4h8kw+FnDm6dJ/JkJXzB3pdCPyCV3h3HvWQvm0HwI
	UrPsvRSKmApOEvrW+8fwoRLp5c1ZNrQzY4vfwakIPatUt7jKe187dXjQ4yWa7hRz4fFI
	unPdEk3a/GBiztf5qJSotuq5V/SS2GQdTCdwBkBysJitDbrQXsb7PXB87zOzur2aV8Sq
	B3bQ==
MIME-Version: 1.0
Received: by 10.68.224.133 with SMTP id rc5mr4901352pbc.130.1347626189694;
	Fri, 14 Sep 2012 05:36:29 -0700 (PDT)
Sender: otavio.salvador@gmail.com
Received: by 10.68.36.105 with HTTP; Fri, 14 Sep 2012 05:36:29 -0700 (PDT)
In-Reply-To: <1347623908.13596.2.camel@ted>
References: <cover.1346905978.git.raj.khem@gmail.com>
	<5c54fcdb91d19909f8658b6a6e8d6e6cac934cf2.1346905978.git.raj.khem@gmail.com>
	<504FF70B.7060701@mlbassoc.com> <1347458928.11710.21.camel@ted>
	<CAMKF1so6qUDFMw_aOZTdC4W_Dh=rDiiC1O7pvjaUQS2xkG8xWg@mail.gmail.com>
	<20120913121935.GC18675@giant>
	<CAP9ODKp8sKpVMi9MwdFxwZTq2-VMiRGzDzD=bBrFu8r4hZ0xMA@mail.gmail.com>
	<CABcZANkbpR66G2-4WnBjdcjUGd4Khbje-kvpd2geUaVMMxE=4A@mail.gmail.com>
	<1347623908.13596.2.camel@ted>
Date: Fri, 14 Sep 2012 09:36:29 -0300
X-Google-Sender-Auth: N41JkZvWi_CX6Eq8y2P78zMYsas
Message-ID: <CAP9ODKpZp1bhNg-EoHUYhU1YCU3=dRULpT8K_QCPZ9VLS8+xZg@mail.gmail.com>
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
X-List-Received-Date: Fri, 14 Sep 2012 12:49:05 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 8:58 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Thu, 2012-09-13 at 07:22 -0700, Chris Larson wrote:
>> On Thu, Sep 13, 2012 at 6:06 AM, Otavio Salvador
>> <otavio@ossystems.com.br> wrote:
>> > On Thu, Sep 13, 2012 at 9:19 AM, Bj=F6rn Stenberg <bjst@enea.com> wrot=
e:
>> >> Khem Raj wrote:
>> >>> I agree but then 1.7 GB is noticeably huge too and it will only beco=
me
>> >>> larger in future so I don't think fetching from git will be a good s=
olution
>> >>> for gcc ever.
>> >>
>> >> Can we use shallow clones? A quick test of gcc-4.7 gave me a 308 MB t=
ar.gz when cloned with --depth 1.
>> >
>> > I did not check if the fetcher has this support  but it would be a
>> > nice solution.
>>
>> Shallow clones won't be able to support SRCREV properly, as you can
>> only clone shallowly from HEAD, not from an arbitrary point in
>> history, AFAIK.
>
> Right, shallow clones are a can of worms from a variety of angles.
>
> My current thinking is a ;allowsinglerev=3D1 parameter to the git fetcher
> which:
>
> a) Generates tarballs of single git revisions if tarball generation is
> turned on
> b) Searches for single revision tarballs before trying the main checkout
> approach.
>
> This would mean that WORKDIR may or may not have a .git directory for
> any SRC_URI marked with this. I think we should all be able to live with
> that and it shouldn't break too much?

We'll end with multiple tarballs, aren't we?

--=20
Otavio Salvador                             O.S. Systems
E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br


