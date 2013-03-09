Received: from mail-la0-f53.google.com ([209.85.215.53])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1UETK6-0002UG-57
	for bitbake-devel@lists.openembedded.org;
	Sun, 10 Mar 2013 00:37:08 +0100
Received: by mail-la0-f53.google.com with SMTP id fr10so2814115lab.12
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 09 Mar 2013 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=fQtHcWB2uuvPOrFRgnGDkpQNCrRGtrLF43mzGp7LQi4=;
	b=t723hgQp8YAwbi0iclPISX2Bw4PKo9u2q3FnuEWfPaEDNSpZAA8hJJJzeQExTRTys8
	rVZlNP1pPIbnYeXi6IQElumLk9e8zpS6v1/ayUtCvcRE2xr/mcwfuu9YMdvp62gmEeau
	DfvtUQPCZtcj6L3BsjFr6ABc9TCLbnSDjipOrjwVyr1pOZF4kXd+ZRGN6iLCZSKiAaiz
	i0su5DUXFeZ1oCeNpemDGEaK8Rowodg85LVvjchBJ0nA1C9auvWWx9Smrbd6e9nv5/2o
	lfgPgWSMt5kNi1W66yRhAw+6jV9Y12w07JphLoQkBFZ87+vJhC+JTrLEEPGTOUooX6B5
	3xCw==
X-Received: by 10.112.49.201 with SMTP id w9mr2719357lbn.2.1362871230233; Sat,
	09 Mar 2013 15:20:30 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.25.195 with HTTP; Sat, 9 Mar 2013 15:20:10 -0800 (PST)
In-Reply-To: <1362833241.9443.208.camel@ted>
References: <1362833241.9443.208.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Sat, 9 Mar 2013 16:20:10 -0700
X-Google-Sender-Auth: le2lVOh3hG9Xs2ILkzTLUeIwwmw
Message-ID: <CABcZANmT5Z6B=PoD9k06aqFq08nzDjUt9DYkBUwdgSTFLKM+6w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart: Add _remove operator
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
X-List-Received-Date: Sat, 09 Mar 2013 23:37:11 -0000
Content-Type: multipart/alternative; boundary=bcaec554d9848d8ab704d7862f45

--bcaec554d9848d8ab704d7862f45
Content-Type: text/plain; charset=UTF-8

On Sat, Mar 9, 2013 at 5:47 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> There are long standing complaints about the fact its very difficult
> to remove a portion of a variable. The immediate request is for a -=
> and =- operator. The trouble is that += and =+ are "immediate"
> operators and are applied straight away. Most people would expect
> -= and =- to be deferred to have the effect most people desire and
> therefore implementing -= and =- would just make the situation more
> confusing.
>
> This deferred operation is much more similar to the override syntax
> which happens at data store finalisation. The _remove operator is
> therefore in keeping with the _append and _prepend operations.
>
> This code is loosely based on a patch from Peter Seebach although it
> has been rewritten to be simpler, more efficient and avoid some
> potential bugs.
>

This is a nice idea, though I'm slightly concerned about the naive
implementation (use of str.replace). Without it being either word-based
(limits flexibility to optimize for the common case) or regex-based (more
complex), we may be greatly limiting the usefulness. I wouldn't want to try
to remove a word from DISTRO_FEATURES and end up removing part of a word,
for example.
-- 
Christopher Larson

--bcaec554d9848d8ab704d7862f45
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Mar 9, 2013 at 5:47 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":y2">There are long standing comp=
laints about the fact its very difficult<br>
to remove a portion of a variable. The immediate request is for a -=3D<br>
and =3D- operator. The trouble is that +=3D and =3D+ are &quot;immediate&qu=
ot;<br>
operators and are applied straight away. Most people would expect<br>
-=3D and =3D- to be deferred to have the effect most people desire and<br>
therefore implementing -=3D and =3D- would just make the situation more<br>
confusing.<br>
<br>
This deferred operation is much more similar to the override syntax<br>
which happens at data store finalisation. The _remove operator is<br>
therefore in keeping with the _append and _prepend operations.<br>
<br>
This code is loosely based on a patch from Peter Seebach although it<br>
has been rewritten to be simpler, more efficient and avoid some<br>
potential bugs.</div></blockquote></div><br>This is a nice idea, though I&#=
39;m slightly concerned about the naive implementation (use of str.replace)=
. Without it being either word-based (limits flexibility to optimize for th=
e common case) or regex-based (more complex), we may be greatly limiting th=
e usefulness. I wouldn&#39;t want to try to remove a word from DISTRO_FEATU=
RES and end up removing part of a word, for example.<br>

-- <br>Christopher Larson</div></div>

--bcaec554d9848d8ab704d7862f45--
