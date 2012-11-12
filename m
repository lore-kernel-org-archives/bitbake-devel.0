Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TXjuj-0003oW-5r
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Nov 2012 03:38:24 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so2058393lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Nov 2012 18:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=6AdelWjX+ug0xMTnoS6rlNmZlAAQ6qjYQlpWlUEx8dM=;
	b=0263XibXKplwbWoNzPNumsDZ2spnFcfiFbAhNw2OU4BgzeOwztfMf6innccN1sTThH
	ocFrn8oHKvVmgWBe93kYEXwxtXyM/XqlM5nsnQ7St9sbvI8D6VVZm7YB1kZerN60PyEu
	57iNWReDX3KPSl/CIWvo/HIYhcQzOfbqp2ecKbLvscpHbMXYKcXMxvF3lvPI62YE/M6/
	fUFKzLY7FdCfxwaXpLOIQHwJo3ezFuQgNlk9AHPK0Izww/NuoFUg0oWukCqPQko1+sGC
	w+Ym3M5ilccU9O3DLSbIva4DqgpI3jGQrHX0LQOtjaaRUPmhpxLwAhxUzvLzEzkkJC6W
	2DDQ==
Received: by 10.112.31.194 with SMTP id c2mr7003413lbi.44.1352687064942; Sun,
	11 Nov 2012 18:24:24 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.18.239 with HTTP; Sun, 11 Nov 2012 18:24:04 -0800 (PST)
In-Reply-To: <CA+JN8xNCoawwA2Nu1-7fh5kH1w7uPpKVJCbB==ua3OyzTTs+bQ@mail.gmail.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<CABcZANkEh-RvPBDRcGAbu3R=SBMrkqxFThjuvBwgj8Y2WuhLuQ@mail.gmail.com>
	<CA+JN8xNCoawwA2Nu1-7fh5kH1w7uPpKVJCbB==ua3OyzTTs+bQ@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sun, 11 Nov 2012 19:24:04 -0700
X-Google-Sender-Auth: mih6m-QQ9umthqz9gcUhcwolAvE
Message-ID: <CABcZANnqqzxUkeo-gKws8N-DdDuxR-5KjsPbV7-z8U1meCB8MQ@mail.gmail.com>
To: Seth Bollinger <seth.boll@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
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
X-List-Received-Date: Mon, 12 Nov 2012 02:38:24 -0000
Content-Type: multipart/alternative; boundary=f46d04016951ff877f04ce42ff65

--f46d04016951ff877f04ce42ff65
Content-Type: text/plain; charset=UTF-8

On Sun, Nov 11, 2012 at 7:02 PM, Seth Bollinger <seth.boll@gmail.com> wrote:

> color_enabled is initialized on line 58 of msg.py.  I did this in the same
> way as other class variables are initialized.
>
>     levelnames = {
>         DEBUG3   : 'DEBUG',
>         DEBUG2   : 'DEBUG',
>         DEBUG   : 'DEBUG',
>         VERBOSE: 'NOTE',
>         NOTE    : 'NOTE',
>         PLAIN  : '',
>         WARNING : 'WARNING',
>         ERROR   : 'ERROR',
>         CRITICAL: 'ERROR',
>     }
>
>     color_enabled = False
>


Ah! I missed that, thanks for clarifying. Other than that question, it
looks pretty decent to me. We'll see if Richard agrees.
-- 
Christopher Larson

--f46d04016951ff877f04ce42ff65
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Sun, Nov 1=
1, 2012 at 7:02 PM, Seth Bollinger <span dir=3D"ltr">&lt;<a href=3D"mailto:=
seth.boll@gmail.com" target=3D"_blank">seth.boll@gmail.com</a>&gt;</span> w=
rote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1s8">color_enabled is initialize=
d on line 58 of msg.py. =C2=A0I did this in the same way as other class var=
iables are initialized.<div>

<br></div><div><div>=C2=A0 =C2=A0 levelnames =3D {</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 DEBUG3 =C2=A0 : &#39;DEBUG&#39;,</div><div>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DEBUG2 =C2=A0 : &#39;DEBUG&#39;,</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEBUG =C2=A0 : &#39;DEBUG&#39;,</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VERBOSE: &#39;NOTE&#39;,</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NOTE =C2=A0 =C2=A0: &#39;NOTE&#39;,</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 PLAIN =C2=A0: &#39;&#39;,</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 WARNING : &#39;WARNING&#39;,</div><div>


=C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR =C2=A0 : &#39;ERROR&#39;,</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 CRITICAL: &#39;ERROR&#39;,</div><div>=C2=A0 =C2=A0=
 }</div><div><br></div><div>=C2=A0 =C2=A0 color_enabled =3D False</div></di=
v></div></blockquote></div><br><br clear=3D"all"><div>Ah! I missed that, th=
anks for clarifying. Other than that question, it looks pretty decent to me=
. We&#39;ll see if Richard agrees.</div>

-- <br>Christopher Larson<br>
</div>

--f46d04016951ff877f04ce42ff65--
