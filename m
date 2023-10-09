Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B14CD610E
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 17:23:11 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
 by mx.groups.io with SMTP id smtpd.web11.68874.1696872184665987204
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Oct 2023 10:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhukoff.net header.s=fm2 header.b=hcsmAk5f;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Bai1oD3T;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.19, mailfrom: pavel@zhukoff.net)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id AB4A83200AA7;
	Mon,  9 Oct 2023 13:23:01 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Mon, 09 Oct 2023 13:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1696872181; x=1696958581; bh=lf
	4PGcbfuzBGdiQAveTU+3BrLDwCQeRvFpOGS9f/E7c=; b=hcsmAk5f2SYRzFaRnT
	XMT+M0olvn4FUsNPPInc/CLMJQABV4rhsU9pX+H9EICjPKdpZ1hqb6154FIC6rxl
	pO1C5cayhkqZ3oQh0hxK3yqgTXOFt5F89cg11eCuYkDKmJWdHz/LESnj8k1JXWMo
	wSe1E80vlJKlKM3BaocieoJZNTFKHgcG0snanE0TdIeR8pWL2FHKmrb+5eiFGBWj
	y6QbR5KOtj/GogabUu3F8JUo08tFylot58LcuLDru4nJ6o5LqVll/KVhoVwuzaiw
	NyGmakmMTnGqBZpShxjGU6Ir0tVnFbWK8RVme2zQAQR9vNH9tr+H7UmxP9AKYZ9q
	23aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696872181; x=1696958581; bh=lf4PGcbfuzBGd
	iQAveTU+3BrLDwCQeRvFpOGS9f/E7c=; b=Bai1oD3Twlxly93dvw34gXOCzz97S
	oZJnaciHdVdyUgl4gMXGbY/dL1obpPNNkk4GY1oxIM9c9aBcxrj5vrHLRA2Z9XeZ
	wbyr0Py6qVAP5/itziNYT0Y1doe2jQRrfBLntXuyTsKt403d3znHINf5uyDsw3+U
	+nrUBt7DLMHKlUEY+NM8KShXHPO0YVyqx8KPjMDNko3E+tjJt7XobVVjDpOBw2OL
	zwuwZTiC5/i1Ik0cWcoDRvDG/eI3Qy93E6db++9YBY4+C+2EidnfARzVX2neBnyr
	WwTDFNsmd7ds9OBEvo00MNVE83lm93oGKdY6Pp8LLhbQ9hNvYP3hO5i9Q==
X-ME-Sender: <xms:9DYkZZw55hiF3T2W7QIAZsZUZG0zLHPvAEmzil-etixOmFw2BW9Wbw>
    <xme:9DYkZZTLjh0leuDGvKZPcgsPrO77zSJo7eyH6os694gyVxYCEPs2dlhZgwTM98gMo
    fHQxrb6lbohDeciRTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsegrtd
    erreerredtnecuhfhrohhmpedfrfgrvhgvlhcukghhuhhkohhvfdcuoehprghvvghlseii
    hhhukhhofhhfrdhnvghtqeenucggtffrrghtthgvrhhnpedtgfdvudejkeejgeevtedvie
    dtteekvddtgfefudfhhfeiffeiteeutdeftdfhueenucffohhmrghinhepohhpvghnvghm
    sggvugguvggurdhorhhgpdgvnhgushifihhthhdrsggsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphgrvhgvlhesiihhuhhkohhffhdrnhgv
    th
X-ME-Proxy: <xmx:9DYkZTX-g9z-wZMQjjTq7giS73m_ypFnqH6i6tEqrFuyhveJs6U0KQ>
    <xmx:9DYkZbhGVg74Ud0JCg9tOv0Qeb7CFEkS-jYUX91AZgiy_gfDPk_vuA>
    <xmx:9DYkZbAwKZxBgSMFH_rVTz_F7kxvFwp1eVzcgfeFiFuPIaOD2QispA>
    <xmx:9TYkZerM3DiGqC2Mwb9xnSqYa0cFPNDNYBEtHflpP5HZaCHQ4LLtIQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A6CB51700089; Mon,  9 Oct 2023 13:23:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <5d529ab9-6581-4225-b059-997a58f90c25@app.fastmail.com>
In-Reply-To: <bae7df5d-fbf2-48e1-b11a-dd0bf326f15c@theobroma-systems.com>
References: <20231009145918.900167-1-bhstalel@gmail.com>
 <bae7df5d-fbf2-48e1-b11a-dd0bf326f15c@theobroma-systems.com>
Date: Mon, 09 Oct 2023 19:22:40 +0200
From: "Pavel Zhukov" <pavel@zhukoff.net>
To: quentin.schulz@theobroma-systems.com, bhstalel@gmail.com,
 bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] Fix find_bbfiles when BBFILES contains directory
Content-Type: multipart/alternative;
 boundary=838435a500c84cadb3ae1d20cbb74715
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 17:23:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15197

--838435a500c84cadb3ae1d20cbb74715
Content-Type: text/plain

Looks like documentation doesn't support this but the code does...
Simple test case can be useful.

-- 
Pavel
On Mon, Oct 9, 2023, at 17:16, Quentin Schulz via lists.openembedded.org wrote:
> Hi Talel,
> 
> On 10/9/23 16:59, BELHADJ SALEM Talel via lists.openembedded.org wrote:
> > 
> > When BBFILES in layer.conf contains a directory, this triggers find_bbfiles function
> 1) BBFILES docs clearly specifies:
> 
> A space-separated list of recipe files BitBake uses to build software.
> 
> So I would say that giving it a directory is incorrect. If it is 
> supposed to be supported, then we need to fix the documentation.
> 
> What are you trying to do?
> 
> > which will fail on endswith that does not expect a list.
> > 
> > Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
> > ---
> >   bitbake/lib/bb/cooker.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > index 2adf4d297d..a354f2f0ab 100644
> > --- a/bitbake/lib/bb/cooker.py
> > +++ b/bitbake/lib/bb/cooker.py
> > @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
> >               for ignored in ('SCCS', 'CVS', '.svn'):
> >                   if ignored in dirs:
> >                       dirs.remove(ignored)
> > -            found += [os.path.join(dir, f) for f in files if (f.endswith(['.bb', '.bbappend']))]
> > +            found += [os.path.join(dir, f) for f in files if (f.endswith(tuple(['.bb', '.bbappend'])))]
> 
> 2) Just replace the square brackets with parenthesis instead to save an 
> unnecessary array creation.
> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15195): https://lists.openembedded.org/g/bitbake-devel/message/15195
> Mute This Topic: https://lists.openembedded.org/mt/101854064/6390638
> Group Owner: bitbake-devel+owner@lists.openembedded.org <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [pavel@zhukoff.net]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

--838435a500c84cadb3ae1d20cbb74715
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><title></title><style type=3D"text/css">p.Mso=
Normal,p.MsoNoSpacing{margin:0}</style></head><body><div>Looks like docu=
mentation doesn't support this but the code does...<br></div><div>Simple=
 test case can be useful.<br></div><div><br></div><div>--&nbsp;<br></div=
><div>Pavel</div><div>On Mon, Oct 9, 2023, at 17:16, Quentin Schulz via =
lists.openembedded.org wrote:<br></div><blockquote type=3D"cite" id=3D"q=
t" style=3D""><div>Hi Talel,<br></div><div><br></div><div>On 10/9/23 16:=
59, BELHADJ SALEM Talel via lists.openembedded.org wrote:<br></div><div>=
&gt;&nbsp;<br></div><div>&gt; When BBFILES in layer.conf contains a dire=
ctory, this triggers find_bbfiles function<br></div><div>1) BBFILES docs=
 clearly specifies:<br></div><div><br></div><div>A space-separated list =
of recipe files BitBake uses to build software.<br></div><div><br></div>=
<div>So I would say that giving it a directory is incorrect. If it is&nb=
sp;<br></div><div>supposed to be supported, then we need to fix the docu=
mentation.<br></div><div><br></div><div>What are you trying to do?<br></=
div><div><br></div><div>&gt; which will fail on endswith that does not e=
xpect a list.<br></div><div>&gt;&nbsp;<br></div><div>&gt; Signed-off-by:=
 Talel BELHAJSALEM &lt;<a href=3D"mailto:bhstalel@gmail.com">bhstalel@gm=
ail.com</a>&gt;<br></div><div>&gt; ---<br></div><div>&gt;&nbsp;&nbsp; bi=
tbake/lib/bb/cooker.py | 2 +-<br></div><div>&gt;&nbsp;&nbsp; 1 file chan=
ged, 1 insertion(+), 1 deletion(-)<br></div><div>&gt;&nbsp;<br></div><di=
v>&gt; diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<=
br></div><div>&gt; index 2adf4d297d..a354f2f0ab 100644<br></div><div>&gt=
; --- a/bitbake/lib/bb/cooker.py<br></div><div>&gt; +++ b/bitbake/lib/bb=
/cooker.py<br></div><div>&gt; @@ -1827,7 +1827,7 @@ class CookerCollectF=
iles(object):<br></div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for ignored in ('SCCS', 'CV=
S', '.svn'):<br></div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if i=
gnored in dirs:<br></div><div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; dirs.remove(ignored)<br></div><div>&gt; -&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found +=3D [o=
s.path.join(dir, f) for f in files if (f.endswith(['.bb', '.bbappend']))=
]<br></div><div>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; found +=3D [os.path.join(dir, f) for f in files if (f.e=
ndswith(tuple(['.bb', '.bbappend'])))]<br></div><div><br></div><div>2) J=
ust replace the square brackets with parenthesis instead to save an&nbsp=
;<br></div><div>unnecessary array creation.<br></div><div><br></div><div=
>Cheers,<br></div><div>Quentin<br></div><div><br></div><div><br></div><d=
iv>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br></div><div>Links: Yo=
u receive all messages sent to this group.<br></div><div>View/Reply Onli=
ne (#15195):&nbsp;<a href=3D"https://lists.openembedded.org/g/bitbake-de=
vel/message/15195">https://lists.openembedded.org/g/bitbake-devel/messag=
e/15195</a><br></div><div>Mute This Topic:&nbsp;<a href=3D"https://lists=
.openembedded.org/mt/101854064/6390638">https://lists.openembedded.org/m=
t/101854064/6390638</a><br></div><div>Group Owner:&nbsp;<a href=3D"mailt=
o:bitbake-devel%2Bowner@lists.openembedded.org">bitbake-devel+owner@list=
s.openembedded.org</a><br></div><div>Unsubscribe:&nbsp;<a href=3D"https:=
//lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedd=
ed.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:pavel@zhukoff.net">p=
avel@zhukoff.net</a>]<br></div><div>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-<br></div><div><br></div><div><br></div></blockquote><div><br><=
/div></body></html>
--838435a500c84cadb3ae1d20cbb74715--

