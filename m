Received: from mail-la0-f52.google.com ([209.85.215.52])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Tt3So-00007W-GE
	for bitbake-devel@lists.openembedded.org;
	Wed, 09 Jan 2013 22:46:15 +0100
Received: by mail-la0-f52.google.com with SMTP id fq12so2406248lab.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jan 2013 13:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=/v0vinHtKcffFZqPF4pFHXGa+b/O6Dcuzg8qzcObfk4=;
	b=NThlFm9THHFDUP+qgayK1dMlEWxwIFB6NoWzrkEKGiBZMYEFqePRoxsIfH6Sgkw6y4
	yDg6CSPVzcum/KpIBvuOU9eN0a/9mD3WiPQaqtmMwNGIsQphZX3l9z/C6G/G9e7uEG/l
	uB2pgBAsqB8PO/n4CF8QIwDLbztSBcVYRf9QIVpdGiB5ixeXZmdRJCi4HH2B+6KtgCyH
	HdUDGccuuoPBDeGAxDvDNmnQnjbloS39meIW9Q9FPrtMMlUt0CExxFjax0RnjOMjyLQX
	v/LHMtxRnDavn8ziAJ1XZJYkdrfGaOdYjcu6YSBf2Fg+MyTxVEPM07gh5HfORoU0UywR
	d7lQ==
Received: by 10.152.144.103 with SMTP id sl7mr17575585lab.23.1357767021779;
	Wed, 09 Jan 2013 13:30:21 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Wed, 9 Jan 2013 13:30:01 -0800 (PST)
In-Reply-To: <20130109203544.GR3722@jama.palm1.palmone.com>
References: <20130109122757.5c134665@e6410-2>
	<20130109203544.GR3722@jama.palm1.palmone.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 9 Jan 2013 14:30:01 -0700
X-Google-Sender-Auth: -ckpNFZAPbriIDI0RW9jFh1A0JU
Message-ID: <CABcZANmdLdkuhdwuq6jXpyMaLXt-mubUHn0XJoyfmGYfjS=z+w@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Variable tracking...
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
X-List-Received-Date: Wed, 09 Jan 2013 21:46:16 -0000
Content-Type: multipart/alternative; boundary=e89a8f22bec10559fd04d2e1c58e

--e89a8f22bec10559fd04d2e1c58e
Content-Type: text/plain; charset=UTF-8

On Wed, Jan 9, 2013 at 1:35 PM, Martin Jansa <martin.jansa@gmail.com> wrote:

> On Wed, Jan 09, 2013 at 12:27:57PM -0600, Peter Seebach wrote:
> > So, I sent some variable-tracking patches a while back that had been
> > cleaned up in response to various feedback. And I don't think I heard
> > back anything about problems with them, but I don't think I heard
> > anything positive.
> >
> > Is anyone still interested in the variable-assignment-tracking stuff,
> > other than me? I maintain that it is REALLY useful when trying to track
> > down variables getting the wrong values.
>
> I didn't look at the implementation, but I also find this feature very
> usefull.



More than once over the past few weeks it would have been handy for me, and
more than once it would have helped others asking me questions find the
answers themselves, so I'd definitely like to see it go in. I'm not 100%
happy with how it's implemented, but I honestly can't think of any other
way to make it happen without major refactoring of bitbake, so I personally
think it should go in as is, and potentially revisit things in the future.
-- 
Christopher Larson

--e89a8f22bec10559fd04d2e1c58e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jan 9, 2013 at 1:35 PM, Martin Jansa <span dir=3D"ltr">&lt;<a href=
=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.com=
</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, Jan 09, 2013 at 12=
:27:57PM -0600, Peter Seebach wrote:<br>
&gt; So, I sent some variable-tracking patches a while back that had been<b=
r>
&gt; cleaned up in response to various feedback. And I don&#39;t think I he=
ard<br>
&gt; back anything about problems with them, but I don&#39;t think I heard<=
br>
&gt; anything positive.<br>
&gt;<br>
&gt; Is anyone still interested in the variable-assignment-tracking stuff,<=
br>
&gt; other than me? I maintain that it is REALLY useful when trying to trac=
k<br>
&gt; down variables getting the wrong values.<br>
<br>
</div>I didn&#39;t look at the implementation, but I also find this feature=
 very<br>
usefull.</blockquote></div><br><br>More than once over the past few weeks i=
t would have been handy for me, and more than once it would have helped oth=
ers asking me questions find the answers themselves, so I&#39;d definitely =
like to see it go in. I&#39;m not 100% happy with how it&#39;s implemented,=
 but I honestly can&#39;t think of any other way to make it happen without =
major refactoring of bitbake, so I personally think it should go in as is, =
and potentially revisit things in the future.<br>

-- <br>Christopher Larson</div></div>

--e89a8f22bec10559fd04d2e1c58e--
