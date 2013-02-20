Received: from mail-lb0-f182.google.com ([209.85.217.182])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1U8AxK-0004xG-Ek
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Feb 2013 15:47:34 +0100
Received: by mail-lb0-f182.google.com with SMTP id gg6so6060678lbb.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Feb 2013 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=pqXADl/jIPpQtfR5tao2jxjpM4uA//d1n5ly3xEP4yA=;
	b=QhSO2HDT53e+6V8TyVgQkV0F4eLB0ZiQp8LmNflvyXKPfY06nxDrUlZRg+5wBcukak
	X4FK1S2byLIp29PoMNWPBVUaeUyCoG9c3VGDXtlbyEK5ExLbJke8wS713t/7rFSxZ7aT
	pomc4YOU1fhEqJoRS6vuOpELDhVMRhcc0IKUE7xyHx3ZXS1+gQMl7rLfU7APHUitiF93
	QPccT4oixcRgHADYQYq9HzwaWQgyEbmCiz0NKwI3QftD10lcdpDeeuW8IJqP1VjlwO+r
	Wocg8z4XCsUMLHa48GpVDKhIyHiqPuqWnFZjuLXPu5kQjqn1euUM9p8bWanPuu9IAaaN
	nEqg==
X-Received: by 10.112.103.168 with SMTP id fx8mr8816866lbb.32.1361370683431;
	Wed, 20 Feb 2013 06:31:23 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.25.195 with HTTP; Wed, 20 Feb 2013 06:31:03 -0800 (PST)
In-Reply-To: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 20 Feb 2013 07:31:03 -0700
X-Google-Sender-Auth: BS-C1-9ydYBzaKXYlhPqef2UU-Q
Message-ID: <CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
To: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: trouble during parsing
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
X-List-Received-Date: Wed, 20 Feb 2013 14:47:34 -0000
Content-Type: multipart/alternative; boundary=f46d04016a99fe5c4504d628cfd0

--f46d04016a99fe5c4504d628cfd0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2013 at 5:54 AM, Andreas M=C3=BCller <
schnitzeltony@googlemail.com> wrote:

> with current bitbake master I get
>
> ERROR: Command execution failed: Traceback (most recent call
> last):#########################################################
>                               | ETA:  00:00:17
>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", line
> 92, in runAsyncCommand
>     self.cooker.updateCache()
>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
> 1330, in updateCache
>     if not self.parser.parse_next():
>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
> 1703, in parse_next
>     self.virtuals +=3D len(result)
> TypeError: object of type 'ExpansionError' has no len()
>

Hmm, looks like it's returning the exceptions rather than raising them, for
some reason, but that doesn't make much sense =E2=80=94 the pool code alway=
s raises
any exceptions from its imap iterator's next() method.
--=20
Christopher Larson

--f46d04016a99fe5c4504d628cfd0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Feb 20, 2013 at 5:54 AM, Andreas M=C3=BCller <span dir=3D"ltr">&lt;=
<a href=3D"mailto:schnitzeltony@googlemail.com" target=3D"_blank">schnitzel=
tony@googlemail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":214">with current bitbake master=
 I get<br>
<br>
ERROR: Command execution failed: Traceback (most recent call<br>
last):#########################################################<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | ETA: =C2=A000:00:17<br>
=C2=A0 File &quot;/home/andreas/oe-core/sources/bitbake/lib/bb/command.py&q=
uot;, line<br>
92, in runAsyncCommand<br>
=C2=A0 =C2=A0 self.cooker.updateCache()<br>
=C2=A0 File &quot;/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py&qu=
ot;, line<br>
1330, in updateCache<br>
=C2=A0 =C2=A0 if not self.parser.parse_next():<br>
=C2=A0 File &quot;/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py&qu=
ot;, line<br>
1703, in parse_next<br>
=C2=A0 =C2=A0 self.virtuals +=3D len(result)<br>
TypeError: object of type &#39;ExpansionError&#39; has no len()</div></bloc=
kquote></div><br>Hmm, looks like it&#39;s returning the exceptions rather t=
han raising them, for some reason, but that doesn&#39;t make much sense =E2=
=80=94 the pool code always raises any exceptions from its imap iterator&#3=
9;s next() method.<br>

-- <br>Christopher Larson</div></div>

--f46d04016a99fe5c4504d628cfd0--
