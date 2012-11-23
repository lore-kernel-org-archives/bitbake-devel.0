Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TbhIg-0003or-88
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Nov 2012 01:39:22 +0100
Received: by mail-lb0-f175.google.com with SMTP id gg13so3751486lbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 16:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=lxwQF4AKauVz5l5xXsw/OqK4cSea/Qa5gs+1LlW77A0=;
	b=R8/p4UegoxlOk4+gr5DwR2CKu9G+Fu2S8/Yc214F6km6KL61r2xuTC0hHuCcE9sLHH
	8FPNmvxkXec/yq9Z0NJGV2du7DUv3QX66Thwsm7NbJM1X045WxvF31/wPWwr9CypzT2d
	Nr0hOi4Kt28dc0q8JzyQd65h1YguI9RYACy5Q5Bc7goyssod9sjzH7xTCxhGjOS0y9yi
	KCggPs8h5LaF0zzdgZ54ehaOacfJky3lMPHimrr22OkUZJyRajitiUAfCOYxO2xS5RCM
	j+3z+SDQkqWlRPd/jlsnh4v4tesGilz78sCPudZ+axZMcQFlYl/g4V+99USpjlq1sfnR
	X9KA==
Received: by 10.152.104.148 with SMTP id ge20mr1784682lab.51.1353630315292;
	Thu, 22 Nov 2012 16:25:15 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Thu, 22 Nov 2012 16:24:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1211221901200.5418@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
	<alpine.DEB.2.02.1211221531260.7504@oneiric>
	<CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
	<alpine.DEB.2.02.1211221901200.5418@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 22 Nov 2012 17:24:54 -0700
X-Google-Sender-Auth: BrlCw-YR10FxJEGjM69PtpEYwxQ
Message-ID: <CABcZANkFraUCk5OKQpHjFpzK-5fUGp+LS-QV2gsZ6to=b-9WTg@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: how easy to extend "bitbake -e" to print *selected* subset of variables?
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
X-List-Received-Date: Fri, 23 Nov 2012 00:39:22 -0000
Content-Type: multipart/alternative; boundary=f46d0407116919a9a204cf1e9eb1

--f46d0407116919a9a204cf1e9eb1
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 22, 2012 at 5:03 PM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

> On Thu, 22 Nov 2012, Chris Larson wrote:
>
> > Yeah, that quick script just ran bitbake -e, not bitbake -e
> > <provider>. You could modify it easily enough to support that,
> > though.
>
>   hang on ... i actually did just that to search the output of:
>
> $ bitbake -e linux-omap4
>
> but i still don't see a number of variables i'm interested in, and i'm
> not sure how to do that.
>

What variables are you not seeing? bitbake -e shows all variables but ones
which are flagged 'unexport' (e.g. DISTRO, MACHINE).
-- 
Christopher Larson

--f46d0407116919a9a204cf1e9eb1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu, Nov 2=
2, 2012 at 5:03 PM, Robert P. J. Day <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcourse.ca</a>&gt;</s=
pan> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Thu, 22 Nov 2012, Chris=
 Larson wrote:<br>
<br>
</div><div class=3D"im">&gt; Yeah, that quick script just ran bitbake -e, n=
ot bitbake -e<br>
&gt; &lt;provider&gt;. You could modify it easily enough to support that,<b=
r>
&gt; though.<br>
<br>
</div>=C2=A0 hang on ... i actually did just that to search the output of:<=
br>
<br>
$ bitbake -e linux-omap4<br>
<br>
but i still don&#39;t see a number of variables i&#39;m interested in, and =
i&#39;m<br>
not sure how to do that.<br>
<div class=3D"im"></div></blockquote></div><br>What variables are you not s=
eeing? bitbake -e shows all variables but ones which are flagged &#39;unexp=
ort&#39; (e.g. DISTRO, MACHINE).<br>-- <br>Christopher Larson<br>
</div>

--f46d0407116919a9a204cf1e9eb1--
