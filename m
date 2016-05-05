Return-Path: <ticotimo@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 1698160762;
	Thu,  5 May 2016 05:10:03 +0000 (UTC)
Received: by mail-pa0-f49.google.com with SMTP id bt5so31641402pac.3;
	Wed, 04 May 2016 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:references:mime-version:in-reply-to:content-transfer-encoding
	:message-id:cc:subject:date:to;
	bh=9Xs0vl7aDcHJb4EaELoYDEbCGOXNGDL2Hr2D9hZmaxg=;
	b=oTDXignxoBUnRVRpR5qut2ifq99wNs8AKwZV3pvJg6zinFk522vNw3LOutvyhxij1s
	uG9LBb12QWgZeO/9FMEJ7x9JYfNtnJq5R0jjo2A+630UkuZGojLAwNqo40/Dn80edl00
	M93vnwbS81A+zfXUBf80yYN9TaH+foh93uHCXmBjXW7x0MHYcZseYkfGZBGRN3bjaE6I
	QBX+WT7r9oHiDHJ8nxEIBFgyHwlIOqQL/qdowzjwLOKMT2lOPSSG2NdAeglaSfB5EMmH
	Kh1H0ijwbgbrSnMKwGT9u0zMjz0FedYBZalHsizNaAtBVCtQZ8NxbtNlhN3Sd+YngwtC
	TAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:references:mime-version:in-reply-to
	:content-transfer-encoding:message-id:cc:subject:date:to;
	bh=9Xs0vl7aDcHJb4EaELoYDEbCGOXNGDL2Hr2D9hZmaxg=;
	b=kFUkuyxQx8obHsQEPZbxuK80bnufFct7R03p+yRq4l21jCIsE5+b2xbRG3O7eWS2UX
	DKje5A101vuEIcgt3VvPG1q5HeonmCr+JRM8nH1Uj2wsZOz39gbv6O/esUhQmTgc+x+F
	zwX6IKPQSZFpKwADiIY2aI4d4ac8E3kFttnKRNoIfPjulbdOm51R1uamznKxnqcVHB3s
	jhnu5kiq+ajew9PjLN/lxIbUM1BTSDSU/ZZEfxV3ngb4UZSo0nQHxi5ZsNFNELyTy3JY
	shLW767aFv/zaOgAshi9HtjSo8U4Bfy5nzOuN14fgRIRl+v7fA0jvemU2Md4Ggt1+/8G
	80jA==
X-Gm-Message-State: AOPr4FUeN2jLOPMv58RIM1uoLDAOGWpVEDFpFE4fSOebmVjG29fbQydIt2lFY6/hn706wA==
X-Received: by 10.66.237.66 with SMTP id va2mr17773189pac.2.1462425004032;
	Wed, 04 May 2016 22:10:04 -0700 (PDT)
Received: from [10.0.0.85] (c-76-115-105-5.hsd1.or.comcast.net. [76.115.105.5])
	by smtp.gmail.com with ESMTPSA id
	n10sm9859022pfj.14.2016.05.04.22.10.02
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 04 May 2016 22:10:02 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <TicoTimo@gmail.com>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
	<CAJTo0LaFCGWy_NbXNu72zsYmLzjE58i5=_hdiyUvXUQbdpTMkg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CAJTo0LaFCGWy_NbXNu72zsYmLzjE58i5=_hdiyUvXUQbdpTMkg@mail.gmail.com>
Message-Id: <B753B579-438D-4D33-A568-2B21D7BAE4AA@gmail.com>
X-Mailer: iPad Mail (13E238)
Date: Wed, 4 May 2016 22:10:01 -0700
To: "Burton, Ross" <ross.burton@intel.com>
X-Mailman-Approved-At: Fri, 06 May 2016 09:12:57 +0000
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] Python 3 for Bitbake
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
X-List-Received-Date: Thu, 05 May 2016 05:10:04 -0000
Content-Type: multipart/alternative;
	boundary=Apple-Mail-0D1A4B60-81C4-472C-9D46-7CF5D8E551B7
Content-Transfer-Encoding: 7bit

--Apple-Mail-0D1A4B60-81C4-472C-9D46-7CF5D8E551B7
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable



> On May 4, 2016, at 2:34 PM, Burton, Ross <ross.burton@intel.com> wrote:
>=20
>=20
>> On 4 May 2016 at 22:29, Mark Hatle <mark.hatle@windriver.com> wrote:
>> I'd hate for someone to bring in a layer and find it doesn't work, withou=
t
>> understanding WHY it doesn't work.
>>=20
>> Alternative would be to change the 'python' identifier to 'python3'..  Th=
en if
>> 'python' is parsed, we error?
>=20
> That sounds like a lot of dull work.  If a layer's class is using python2 s=
yntax and runs under python3 then it will generally throw exceptions, right?=

>=20
Yes, you will see a lot of TypeError, SyntaxError and other exceptions. In f=
act, the try:catch handling for those exceptions is a frequent crutch for py=
2-py3 compatibility. The other biggest PITA is str vs unicode and friends. L=
ook at the recent commits for pystatgrab (upstream) as an example.

Ripping off the band-aid sounds ok to me too. Flag day +1

--Tim

"Just as long as we aren't switching to perl6 at the same time."

> Ross
> _______________________________________________
> Openembedded-architecture mailing list
> Openembedded-architecture@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-architecture

--Apple-Mail-0D1A4B60-81C4-472C-9D46-7CF5D8E551B7
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><meta http-equiv="content-type" content="text/html; charset=utf-8"></head><body dir="auto"><div><br></div><div><br>On May 4, 2016, at 2:34 PM, Burton, Ross &lt;<a href="mailto:ross.burton@intel.com">ross.burton@intel.com</a>&gt; wrote:<br><br></div><blockquote type="cite"><div><div dir="ltr"><div class="gmail_extra"><br><div class="gmail_quote">On 4 May 2016 at 22:29, Mark Hatle <span dir="ltr">&lt;<a href="mailto:mark.hatle@windriver.com" target="_blank">mark.hatle@windriver.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=":3bw" class="a3s aXjCH">I'd hate for someone to bring in a layer and find it doesn't work, without<br>
understanding WHY it doesn't work.<br>
<br>
Alternative would be to change the 'python' identifier to 'python3'..&nbsp; Then if<br>
'python' is parsed, we error?</div></blockquote></div><br>That sounds like a lot of dull work.&nbsp; If a layer's class is using python2 syntax and runs under python3 then it will generally throw exceptions, right?</div><div class="gmail_extra"><br></div></div></div></blockquote>Yes, you will see a lot of TypeError, SyntaxError and other exceptions. In fact, the try:catch handling for those exceptions is a frequent crutch for py2-py3 compatibility. The other biggest PITA is str vs unicode and friends. Look at the recent commits for pystatgrab (upstream) as an example.<div><br></div><div>Ripping off the band-aid sounds ok to me too. Flag day +1<br><div><br></div><div>--Tim</div><div><br></div><div>"Just as long as we aren't switching to perl6 at the same time."</div><div><br><blockquote type="cite"><div><div dir="ltr"><div class="gmail_extra">Ross</div></div>
</div></blockquote><blockquote type="cite"><div><span>_______________________________________________</span><br><span>Openembedded-architecture mailing list</span><br><span><a href="mailto:Openembedded-architecture@lists.openembedded.org">Openembedded-architecture@lists.openembedded.org</a></span><br><span><a href="http://lists.openembedded.org/mailman/listinfo/openembedded-architecture">http://lists.openembedded.org/mailman/listinfo/openembedded-architecture</a></span><br></div></blockquote></div></div></body></html>

--Apple-Mail-0D1A4B60-81C4-472C-9D46-7CF5D8E551B7--
