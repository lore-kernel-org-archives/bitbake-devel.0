Return-Path: <jacob.kroon@gmail.com>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
	[209.85.215.42])
	by mail.openembedded.org (Postfix) with ESMTP id AC6DE60DFA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 18:24:48 +0000 (UTC)
Received: by mail-la0-f42.google.com with SMTP id hr17so1877308lab.29
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=BjMo3AyRvBMZ081RrVKfDAbFsCVieNvmZEDiXcYo3nw=;
	b=wa98rmM2Bx0dPIDRljbWPVz4FkF6fs2cUO+f6Bef8G5keT8auwOEcMXFeqsDzfkny9
	kaZR36syl3qS0APsrhKCWkNi5v76mIGM229/8a8KItR3ILLZuJDbse5igKeSD3m75m0Q
	y4asoX5TmkUg1vcIeixHaWqbB5bh0PC7frwiRicunU3Q98V6QTHxZZlKLtajbAATQMbg
	pzyhOylfjpmZOj3Z6ImE0h+n2pnni4901DnZ3v9410sePgrG9KkCsimPhk8wt3kKcMvz
	TEcLH7oHbepo4bq/DNUlql7ZzFQJ2iC1rqYVoXr+doOkqSQlWlh7snHJqIyD6Lwf7DgO
	QqRw==
MIME-Version: 1.0
X-Received: by 10.112.181.7 with SMTP id ds7mr6979973lbc.93.1393093488602;
	Sat, 22 Feb 2014 10:24:48 -0800 (PST)
Received: by 10.112.53.35 with HTTP; Sat, 22 Feb 2014 10:24:48 -0800 (PST)
In-Reply-To: <CAMKF1soqCA_6zQXN2bo7HSqKAqAfYE-eGEncp__1todBqHBg0A@mail.gmail.com>
References: <1393087949-6183-1-git-send-email-jacob.kroon@mikrodidakt.se>
	<CAMKF1soqCA_6zQXN2bo7HSqKAqAfYE-eGEncp__1todBqHBg0A@mail.gmail.com>
Date: Sat, 22 Feb 2014 19:24:48 +0100
Message-ID: <CAPbeDCkJ5kSq_492QqDGNUWJvWh0oeT7qaUxfiPq=nnpbto2wQ@mail.gmail.com>
From: Jacob Kroon <jacob.kroon@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Jacob Kroon <jacob.kroon@mikrodidakt.se>
Subject: Re: [PATCH v2] ast: Fix support for anonymous methods in wildcard .bbappend files
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
X-List-Received-Date: Sat, 22 Feb 2014 18:24:49 -0000
Content-Type: multipart/alternative; boundary=001a11c36c7886f42c04f302da46

--001a11c36c7886f42c04f302da46
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Feb 22, 2014 at 7:12 PM, Khem Raj <raj.khem@gmail.com> wrote:

> On Sat, Feb 22, 2014 at 8:52 AM, Jacob Kroon <jacob.kroon@mikrodidakt.se>
> wrote:
> > +    tr_tbl = string.maketrans('/.+-@%', '______')
> > +
>
> why is this moved out
>

The translation table never changes, so instead of creating one on-the-fly
in each invocation, the idea was to keep and reuse the table in a class
variable.

--001a11c36c7886f42c04f302da46
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On S=
at, Feb 22, 2014 at 7:12 PM, Khem Raj <span dir=3D"ltr">&lt;<a href=3D"mail=
to:raj.khem@gmail.com" target=3D"_blank">raj.khem@gmail.com</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On Sat, Feb 22, 2014 at 8:52=
 AM, Jacob Kroon &lt;<a href=3D"mailto:jacob.kroon@mikrodidakt.se">jacob.kr=
oon@mikrodidakt.se</a>&gt; wrote:<br>

&gt; + =A0 =A0tr_tbl =3D string.maketrans(&#39;/.+-@%&#39;, &#39;______&#39=
;)<br>
&gt; +<br>
<br>
</div>why is this moved out<br>
</blockquote><br></div><div class=3D"gmail_quote">The translation table nev=
er changes, so instead of creating one on-the-fly in each invocation, the i=
dea was to keep and reuse the table in a class variable.<br></div></div>
</div>

--001a11c36c7886f42c04f302da46--
