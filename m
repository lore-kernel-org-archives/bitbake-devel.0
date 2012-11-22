Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Tbg9i-0002cB-DU
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Nov 2012 00:26:02 +0100
Received: by mail-la0-f47.google.com with SMTP id u2so6301324lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 15:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=pOpKCspps5dfSzrMuvE4YzTzZD30Jgg8BxZh0QSNLDk=;
	b=a+ZwwvHvrZyJZWWrsrZZ5RG+UW4QDT24Tj3jTX4htijzEHSEo90bKVszLrU/NWcaep
	4r2/8TLm5Fbcfb8HtmbynijPx6t9ms+F8BBVVv5TYhNga4pTOarb7hVb4kkT+MS1FVZ/
	NMoRHI/XsWEvYooe3XO2u8vkK8v/JVyCoY4nuqWJfxg3h5xysngJ9r2x4GZ9uaSfVddH
	6w/5kZO3+gkvWqRxLMfUovsZ9uN/GVMTewRPaoyO1f0hcdyHOANRYmLLsoHmWOA3gNxf
	/RVTb1mjTTuTWtSXh1u9KFFkmO1YTZ1qOxuKOugCm0DEs+lpYagtcrIWr8EasZNmz/JY
	U2AA==
Received: by 10.112.45.35 with SMTP id j3mr1127176lbm.82.1353625915465; Thu,
	22 Nov 2012 15:11:55 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Thu, 22 Nov 2012 15:11:35 -0800 (PST)
In-Reply-To: <CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
	<CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
	<alpine.DEB.2.02.1211221531260.7504@oneiric>
	<CABcZANnHBqZvOhgZNYPjCJUwKqW+0W6KWuRU+r87094R-4R-qw@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 22 Nov 2012 16:11:35 -0700
X-Google-Sender-Auth: M6cUocynsdHTg2v8p8VqccS3wjo
Message-ID: <CABcZANmUB-L0E307Aqsa7tsh1Ji2uanBndWVkYB5iHN6NHTy=w@mail.gmail.com>
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
X-List-Received-Date: Thu, 22 Nov 2012 23:26:02 -0000
Content-Type: multipart/alternative; boundary=bcaec55405c8d9a1be04cf1d97e5

--bcaec55405c8d9a1be04cf1d97e5
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 22, 2012 at 4:10 PM, Chris Larson <clarson@kergoth.com> wrote:

> Yeah, that quick script just ran bitbake -e, not bitbake -e <provider>.
> You could modify it easily enough to support that, though.
>
> You could also try out https://gist.github.com/4133101. It's just a quick
> prototype. Drop it next to bitbake in bitbake/bin/. It fixes a couple minor
> annoyances with bitbake -e and it sends all the bitbake log output from
> stdout to stderr, so you can redirect that independently of the emitted
> variables and values.
>
> Usage examples:
>
>     bitbake-env DISTRO MACHINE do_configure
>     bitbake-env -r virtual/kernel FILE
>     eval $(bitbake-env TMPDIR | grep -v '^#')
>

Oh, I forgot to mention that it can handle filtering not just regular
variables, but functions as well, since it's in python:

    bitbake-env base_set_filespath
-- 
Christopher Larson

--bcaec55405c8d9a1be04cf1d97e5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu, Nov 2=
2, 2012 at 4:10 PM, Chris Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:cl=
arson@kergoth.com" target=3D"_blank">clarson@kergoth.com</a>&gt;</span> wro=
te:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"gmail_extra">Yeah, that quick =
script just ran bitbake -e, not bitbake -e &lt;provider&gt;. You could modi=
fy it easily enough to support that, though.</div>

<div class=3D"gmail_extra">
<br></div><div class=3D"gmail_extra">You could also try out <a href=3D"http=
s://gist.github.com/4133101" target=3D"_blank">https://gist.github.com/4133=
101</a>. It&#39;s just a quick prototype. Drop it next to bitbake in bitbak=
e/bin/. It fixes a couple minor annoyances with bitbake -e and it sends all=
 the bitbake log output from stdout to stderr, so you can redirect that ind=
ependently of the emitted variables and values.</div>


<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Usage examp=
les:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=
=C2=A0 =C2=A0 bitbake-env DISTRO MACHINE do_configure</div><div class=3D"gm=
ail_extra">=C2=A0 =C2=A0 bitbake-env -r virtual/kernel FILE</div>


<div class=3D"gmail_extra">=C2=A0 =C2=A0 eval $(bitbake-env TMPDIR | grep -=
v &#39;^#&#39;)</div></blockquote></div><br>Oh, I forgot to mention that it=
 can handle filtering not just regular variables, but functions as well, si=
nce it&#39;s in python:</div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=C2=A0 =C2=
=A0 bitbake-env base_set_filespath<br>-- <br>Christopher Larson<br>
</div>

--bcaec55405c8d9a1be04cf1d97e5--
