Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bruce.ashfield@gmail.com>)
	id 1TCVFw-0004b7-L0; Fri, 14 Sep 2012 14:44:24 +0200
Received: by lban1 with SMTP id n1so2475193lba.6
	for <multiple recipients>; Fri, 14 Sep 2012 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=2TOORy80qS38RGmRtP28gqdkn6obaaaQ7A6+2aT5g0A=;
	b=kV95Gm1CnC8PzvRAcK92qF2uOYH4rLfyHO9cij3jo7Ao+IyGRAk8Mvvu5XiumQYaog
	Cww2acDvZk8qlvQssCkIqeKHZrGTHD8xx8h72KQCFGNiGktoMGqIgPQSDGnnDu9u70um
	Ij7o0s0AriVjMcHdF9zUJnT/vMqHe1kHJuLQ89x1EAklvR62uvLbYqNN9NIpY8kTmdwS
	EFRDoxu5ZsavJCKMOk99XpKg1b0497LcSmsPTJBD20shXf9FBIj8uXAhFlFdn++0hDTL
	JEYPUSVdENuJnyi9U6LYp/47kmluVEtcExqUqKaGKU5cN6N5LGXVEKqM4fE1y/DTgtlu
	w6Jg==
MIME-Version: 1.0
Received: by 10.152.113.68 with SMTP id iw4mr2259092lab.50.1347625909744; Fri,
	14 Sep 2012 05:31:49 -0700 (PDT)
Received: by 10.114.68.20 with HTTP; Fri, 14 Sep 2012 05:31:49 -0700 (PDT)
In-Reply-To: <1347623908.13596.2.camel@ted>
References: <cover.1346905978.git.raj.khem@gmail.com>
	<5c54fcdb91d19909f8658b6a6e8d6e6cac934cf2.1346905978.git.raj.khem@gmail.com>
	<504FF70B.7060701@mlbassoc.com> <1347458928.11710.21.camel@ted>
	<CAMKF1so6qUDFMw_aOZTdC4W_Dh=rDiiC1O7pvjaUQS2xkG8xWg@mail.gmail.com>
	<20120913121935.GC18675@giant>
	<CAP9ODKp8sKpVMi9MwdFxwZTq2-VMiRGzDzD=bBrFu8r4hZ0xMA@mail.gmail.com>
	<CABcZANkbpR66G2-4WnBjdcjUGd4Khbje-kvpd2geUaVMMxE=4A@mail.gmail.com>
	<1347623908.13596.2.camel@ted>
Date: Fri, 14 Sep 2012 08:31:49 -0400
Message-ID: <CADkTA4OYJWjO0Z8XQwJ3nzG8DhR0j5kh+qOS4wG8Z5KLvGNXwA@mail.gmail.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailman-Approved-At: Sun, 16 Sep 2012 14:57:54 +0200
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
X-List-Received-Date: Fri, 14 Sep 2012 12:44:24 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 7:58 AM, Richard Purdie
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

Sounds ok to me, and there are other uses like my nearly completed
'low bandwidth' yocto kernel recipe tweaks that should be able to leverage
something like this as well.

Cheers,

Bruce

>
> Cheers,
>
> Richard
>
>
>
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core



--=20
"Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end"


