Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]
	helo=am1outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>)
	id 1TCarT-0001fR-8Y; Fri, 14 Sep 2012 20:43:31 +0200
Received: from mail97-am1-R.bigfish.com (10.3.201.234) by
	AM1EHSOBE008.bigfish.com (10.3.204.28) with Microsoft SMTP Server id
	14.1.225.23; Fri, 14 Sep 2012 18:30:55 +0000
Received: from mail97-am1 (localhost [127.0.0.1])	by mail97-am1-R.bigfish.com
	(Postfix) with ESMTP id D72483801A5;
	Fri, 14 Sep 2012 18:30:55 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: -9
X-BigFish: VS-9(zz98dI9371Ic89bh936eI1441M1432I1453I62a3Id6f1izz1202h1d1ah1d2ahzz17326ah8275bh8275dhz2dh2a8h668h839h8e2h8e3hd25hf0ah107ah10d2h1288h12a5h12a9h12bdhbe9i1155h)
Received: from mail97-am1 (localhost.localdomain [127.0.0.1]) by mail97-am1
	(MessageSwitch) id 13476474542015_19286; Fri, 14 Sep 2012 18:30:54 +0000
	(UTC)
Received: from AM1EHSMHS015.bigfish.com (unknown [10.3.201.233])	by
	mail97-am1.bigfish.com (Postfix) with ESMTP id E25593A00AD;
	Fri, 14 Sep 2012 18:30:53 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS015.bigfish.com
	(10.3.207.153) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Fri, 14 Sep 2012 18:30:52 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.124]) by
	039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id
	14.02.0309.003; Fri, 14 Sep 2012 13:30:50 -0500
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Otavio Salvador <otavio@ossystems.com.br>
Thread-Topic: [bitbake-devel] [OE-core] [PATCH 1/4] gcc: Switch SRC_URI to
	use svn
Thread-Index: AQHNkqcQztcAN31T+0+Zoql5iEanQw==
Date: Fri, 14 Sep 2012 18:30:50 +0000
Message-ID: <70CC66F5C30A414DADDA6973E4CA391A67E750@039-SN1MPN1-001.039d.mgd.msft.net>
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
	<CAP9ODKpmveRGD02wP1DAO=+C0xa4sC3FfxaOud2zE6J=4zspmg@mail.gmail.com>
In-Reply-To: <CAP9ODKpmveRGD02wP1DAO=+C0xa4sC3FfxaOud2zE6J=4zspmg@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.112.201.132]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH 1/4] gcc: Switch SRC_URI to use svn
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 14 Sep 2012 18:43:32 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B8A559BD8C190741900B54F38E5ADEB4@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2012 at 8:25 AM, Otavio Salvador
<otavio@ossystems.com.br> wrote:
> On Fri, Sep 14, 2012 at 10:23 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> On Fri, 2012-09-14 at 09:36 -0300, Otavio Salvador wrote:
>>> On Fri, Sep 14, 2012 at 8:58 AM, Richard Purdie
>>> <richard.purdie@linuxfoundation.org> wrote:
>>> > On Thu, 2012-09-13 at 07:22 -0700, Chris Larson wrote:
>>> >> On Thu, Sep 13, 2012 at 6:06 AM, Otavio Salvador
>>> >> <otavio@ossystems.com.br> wrote:
>>> >> > On Thu, Sep 13, 2012 at 9:19 AM, Bj=F6rn Stenberg <bjst@enea.com> =
wrote:
>>> >> >> Khem Raj wrote:
>>> >> >>> I agree but then 1.7 GB is noticeably huge too and it will only =
become
>>> >> >>> larger in future so I don't think fetching from git will be a go=
od solution
>>> >> >>> for gcc ever.
>>> >> >>
>>> >> >> Can we use shallow clones? A quick test of gcc-4.7 gave me a 308 =
MB tar.gz when cloned with --depth 1.
>>> >> >
>>> >> > I did not check if the fetcher has this support  but it would be a
>>> >> > nice solution.
>>> >>
>>> >> Shallow clones won't be able to support SRCREV properly, as you can
>>> >> only clone shallowly from HEAD, not from an arbitrary point in
>>> >> history, AFAIK.
>>> >
>>> > Right, shallow clones are a can of worms from a variety of angles.
>>> >
>>> > My current thinking is a ;allowsinglerev=3D1 parameter to the git fet=
cher
>>> > which:
>>> >
>>> > a) Generates tarballs of single git revisions if tarball generation i=
s
>>> > turned on
>>> > b) Searches for single revision tarballs before trying the main check=
out
>>> > approach.
>>> >
>>> > This would mean that WORKDIR may or may not have a .git directory for
>>> > any SRC_URI marked with this. I think we should all be able to live w=
ith
>>> > that and it shouldn't break too much?
>>>
>>> We'll end with multiple tarballs, aren't we?
>>
>> Yes. I'm not seeing that as a big problem for most of the usecases where
>> we'd use this feature. You could skip shipping the big tarball of the
>> whole repo at distribution time.
>
> By the way, there're any tool to clean the repo? (as we do for sstate-cac=
he)?

scripts/clean-workdir cleans tmp/ - not sure about downloads

-M

>
> --
> Otavio Salvador                             O.S. Systems
> E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
> Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel=



