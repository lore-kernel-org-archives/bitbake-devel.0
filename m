Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id CBACC73695
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 May 2016 21:34:38 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id u185so77665586iod.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 May 2016 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=7iyC6zNSE1vdcQ1yn7iQYopxTXdMTDOXPajDKZ8/2b4=;
	b=bjMnbT07MsqC018zwRPeNppoJikksnpgPgUnIb6Isj0Zq4o7cMTBo/rJWRqAswFwfz
	cqwRLS05IK5MGpWHZJSuytBHLAVezKLQjxKmFXMHiPfDDq7Om+3hwD9+fWd+WuOSNLGX
	elrLiDwR2HdS0YJWCB8wXnS26EEFTvo/C5zkIa1Nz9z5pJCdhj1Jn/48igNcc4B7QWVd
	0uDOFJBrSVSRztW4NGbVcba/itSgjAOZ13li7Er78unoLmoRjwet0MjFG/luLLFjJp0Y
	kkd2lWONWEfmH9RFFw+viBq5eEGcZiz3he6TCqVAkRJeXURxEBBqeqJmV370l2KGEHQw
	F2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=7iyC6zNSE1vdcQ1yn7iQYopxTXdMTDOXPajDKZ8/2b4=;
	b=k7/OA5Ed2jrNgt9zVHaYGyWsecYxVV6hBBT2pbbz++kUMOeMX2LwCvQ6Iki+T0xP/k
	gTz5T7970YuMmFxLasj0fgDOM0EKvLy9i0snr/u8KJ81/UC1cVlCyFihoK5eVJ5lYCp1
	BZQPjPc9kSa3mpqmfZZiAbOWWgdVzJugclDZ8jCKwAet93fEJnNQsfpLCUDzJKWN3B2O
	lNGN8OtV85Bvu6l6YtF8QdJnZ2h1a0KN5lNvnmwtQi5dVS83f+HCSnXJEFsKUpLbPKY9
	jjem8kEpFBkb44gyIOHkdQMYTXJo4DwTasFaTAM7au1xEc1QV1GbPh2KLbQ8w4Bdpq66
	y9Bg==
X-Gm-Message-State: AOPr4FXwO6KByPGUpP1phAGSON20u7WbrnYLynnSTHNaiDQDTicP851EJKbXvB+xK1wkM1GFYn1CXMi8+DJsvi44
X-Received: by 10.107.179.136 with SMTP id c130mr12751465iof.99.1462397679352; 
	Wed, 04 May 2016 14:34:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.34.142 with HTTP; Wed, 4 May 2016 14:34:19 -0700 (PDT)
In-Reply-To: <53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
References: <1462352176.18407.11.camel@linuxfoundation.org>
	<53677acc-ca69-58d0-1747-b1144aaf8f1b@windriver.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 4 May 2016 22:34:19 +0100
Message-ID: <CAJTo0LaFCGWy_NbXNu72zsYmLzjE58i5=_hdiyUvXUQbdpTMkg@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>
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
X-List-Received-Date: Wed, 04 May 2016 21:34:41 -0000
Content-Type: multipart/alternative; boundary=001a1148578c32c6da05320afe92

--001a1148578c32c6da05320afe92
Content-Type: text/plain; charset=UTF-8

On 4 May 2016 at 22:29, Mark Hatle <mark.hatle@windriver.com> wrote:

> I'd hate for someone to bring in a layer and find it doesn't work, without
> understanding WHY it doesn't work.
>
> Alternative would be to change the 'python' identifier to 'python3'..
> Then if
> 'python' is parsed, we error?
>

That sounds like a lot of dull work.  If a layer's class is using python2
syntax and runs under python3 then it will generally throw exceptions,
right?

Ross

--001a1148578c32c6da05320afe92
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 4 May 2016 at 22:29, Mark Hatle <span dir=3D"ltr">&lt;<a href=3D"mailto:=
mark.hatle@windriver.com" target=3D"_blank">mark.hatle@windriver.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":3bw" class=3D=
"a3s aXjCH">I&#39;d hate for someone to bring in a layer and find it doesn&=
#39;t work, without<br>
understanding WHY it doesn&#39;t work.<br>
<br>
Alternative would be to change the &#39;python&#39; identifier to &#39;pyth=
on3&#39;..=C2=A0 Then if<br>
&#39;python&#39; is parsed, we error?</div></blockquote></div><br>That soun=
ds like a lot of dull work.=C2=A0 If a layer&#39;s class is using python2 s=
yntax and runs under python3 then it will generally throw exceptions, right=
?</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross=
</div></div>

--001a1148578c32c6da05320afe92--
