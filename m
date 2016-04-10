Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id 36DE46AC4B
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Apr 2016 18:37:12 +0000 (UTC)
Received: by mail-ig0-f173.google.com with SMTP id kb1so67328541igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Apr 2016 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=HECm1t226pmL9Ws2q328rLGryofq+/naki7u9o9syvw=;
	b=IvFRQoqKqBnZqUD9N5O7bY3OrDyZFT2bkKUYWTKgDy1xdqL/41UQCpf8xN4rPw60tg
	k1SnjjgOBwjMVQWRrP/tUTAJKEgfSzyykKJQb/hzUOxMKlmiQBs0wjpnrQvAynQFQ416
	peBXP7ZR1/j7B1SVW/pLadX/VO5s2c1nUCg+MwdhOA/rHyrdi67y5q4PMEBNx/B7dKO/
	arfP3IGmhYIM5RykJ7AGn0mBX/Wtv4I58NqJyCodYXSFWQWzs+/o9sskitfIxGM7/xFJ
	k3wVX9VQqtHo4I9N5Dg2sOQFCJIglq5k1T3J1T09+i12LSCIRgWRvLWBzvfRjuIVNXds
	Uo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=HECm1t226pmL9Ws2q328rLGryofq+/naki7u9o9syvw=;
	b=MlLiFHX/T6G0jy+jv1FWTP+i5Gs1fd2VI4XEZe4aEWHq7hcyd9AbFMsQpfjVzB+Kj2
	WZ3KAGkvkWA8zxQyMig3kB7oZfHOZyls4BYRKGOEi+v+Mnn0X41U1VB8hykwdJhQR8oS
	uDZMrh3IK6fEWDLgoIr7ZSPcCHFWCYaaMuM5MA+r7uNf65z7iDQM+he8+R8aM2/24xUH
	HfgWFANWRpNJMOBD1KNvTNJZQW/x17ufD2Z95p5k7uTo23H2DeBjqX8cpiQQxvrkKCzq
	dzYJ1KQjee1o/QoXBfGZ7//zvPgP8UoQLL56z9PIRKGPYRAhQAT7N3goDxcgfxN1RGmv
	E1pw==
X-Gm-Message-State: AD7BkJJhch4OiJsp1GHGf6N7PCi/g6QTVuI7RDlvrR61zw4rH9XRVw0KAC+LAMBbaO6Md29vU7Xi/26Dy444JQ==
X-Received: by 10.50.150.70 with SMTP id ug6mr14573638igb.87.1460313433024;
	Sun, 10 Apr 2016 11:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <1460155678.9308.2.camel@linuxfoundation.org>
In-Reply-To: <1460155678.9308.2.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Sun, 10 Apr 2016 18:37:03 +0000
Message-ID: <CABcZAN=Xhtpnm4HOwq-Cm1XGQvYbZtP0g5h3x3YfHNEwujoKfw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart: Restrict expansion regexp to not include : characters
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
X-List-Received-Date: Sun, 10 Apr 2016 18:37:16 -0000
Content-Type: multipart/alternative; boundary=001a1133cb0a6fafa6053025b717

--001a1133cb0a6fafa6053025b717
Content-Type: text/plain; charset=UTF-8

On Fri, Apr 8, 2016 at 3:48 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Bitbake variables don't include ":" characters so exclude these from the
> variable
> expansion regexp.
>
> This assists when parsing shell code which does A=${B:-C} as we don't want
> a
> dependency on a variable called "B:-C".
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Nice, this one's been bugging me on and off for a while :) Looks good.

--001a1133cb0a6fafa6053025b717
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Apr 8,=
 2016 at 3:48 PM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxf=
oundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Bitbake variables don&#39;t include &quot;:&q=
uot; characters so exclude these from the variable<br>
expansion regexp.<br>
<br>
This assists when parsing shell code which does A=3D${B:-C} as we don&#39;t=
 want a<br>
dependency on a variable called &quot;B:-C&quot;.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r></blockquote><div><br></div><div>Nice, this one&#39;s been bugging me on =
and off for a while :) Looks good.</div></div></div>

--001a1133cb0a6fafa6053025b717--
