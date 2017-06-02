Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
	[209.85.218.47])
	by mail.openembedded.org (Postfix) with ESMTP id 5348571994
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Jun 2017 13:59:23 +0000 (UTC)
Received: by mail-oi0-f47.google.com with SMTP id l18so92938567oig.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Jun 2017 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=1Rz67muuRJ5jRKpSisYYiudzlVMblfbsa+vW273PwwI=;
	b=fJPk6DeGPjFa8QTUtqTZ+WDoY01n2y9JrHpumoBCrHsU6a32EE/06EGZjqRBFXQdKr
	ZfYAmvqydsL+0Sy6OJG1WvjeuNj7OBpz3vcokVS5qCb0G09OT4OcVGJ5L4TxDofVSQCn
	L39gAigi2B2UIm53E7/RyqvqQiJc1cJ+XoO/nvkiMa6m2NsJJXaiqG6t7p7mnaGHbj33
	CNUMQ1weRQanPaQ+ZFo0WBDrVZIQ0fAW+9hnzcdmUIIs1Ggk+Q/Nh9LZ1q4Vzm1qVKJD
	VySKir6G+/gw00gKor0cdXexYPogpeALm56lOeAHVmim/+U7wzUPuxQEoWceNCb+kpWW
	QQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=1Rz67muuRJ5jRKpSisYYiudzlVMblfbsa+vW273PwwI=;
	b=FarWD7sKJSvQBFnt7w4p0Qwx61oU77mectFlThFEiTVgiKLG+8QwzZGIWEr9CsReZq
	bLIl9WXufUSrWRg9a4s9qcbYsYPXwezSYra1d+oX5e1Siy2k/MgzjF3A8W2QOqtx9IGl
	+FkGt4sGjsoj5/qx1ADwRWMT4iLBXsHniOwqSYj7W4DLJ1RZCJwiv4C240rfTaK+xf+2
	fROpWIc1FjXzfdPsTORLOjCYkYZJtJZCfPawGJqcvP3P3PrOvl8vHDbYZCS3h+zWt0S8
	Eg2q7xioBXrEiVORhCzGZz0TdimBEhMvGf7OumLgVhS1uNxoVb6BwJH4TZJsYPj8bKKe
	Z3mg==
X-Gm-Message-State: AODbwcDg0oxP0vZ/NDAKecH1ijkpmJnATbbOqFsRzNv+S0fr9z5XClTZ
	HzsI+JL1EhuwXWR6AJdKMdDovq/09g==
X-Received: by 10.157.31.76 with SMTP id x12mr4229805otx.65.1496411965147;
	Fri, 02 Jun 2017 06:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.30.226 with HTTP; Fri, 2 Jun 2017 06:59:04 -0700 (PDT)
In-Reply-To: <1496398059.6630.89.camel@linuxfoundation.org>
References: <cover.1494623828.git.chris_larson@mentor.com>
	<c3f2c1773900f6f0282d72861802d540cf59018f.1494623828.git.chris_larson@mentor.com>
	<1496398059.6630.89.camel@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 2 Jun 2017 06:59:04 -0700
Message-ID: <CABcZAN=f3+Rb442BtCUTv+HizFWV8fkjWWc20q4D-ejUcdHgLg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Scott Rifenbark <srifenbark@gmail.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/8] git-make-shallow: add script to make a git repo shallow
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
X-List-Received-Date: Fri, 02 Jun 2017 13:59:24 -0000
Content-Type: multipart/alternative; boundary="001a113d0f369ed1f40550fa8f89"

--001a113d0f369ed1f40550fa8f89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 2, 2017 at 3:07 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Sorry about the delay in getting to this. In general the series looks
> great.
>

Thanks for taking the time to review this, I appreciate it. I know you have
a lot on your plate, and anything invasive in the fetcher is risky and not
particularly fun.


> One minor thing that bothers me a bit is the name of this
> script. If git itself ever creates something similar it may cause us
> issues. I wondered if we wanted to namespace this more closely to
> bitbake?
>
> I'm leaning towards merging this and then perhaps tweaking the naming.
>

That would be fine with me, I=E2=80=99m not particularly attached to the na=
me. I
only  named it this way because it=E2=80=99s of use outside of bitbake as w=
ell, but
I can see your namespace concern.

The other thing I'd really like to see is the documentation collected
> out the commit messages and sent to Scott Rifenbark (cc'd) as a summary
> of the changes so he can update the manual, particularly the section on
> the git fetcher. If you could review it once Scott has done that, that
> would be awesome :).
>

I can do that. I might still have a more monolithic description in one of
the previous branches, I only broke it up this way to ease review and
reduce confusion.

I do have my worries about how much complexity this adds to the git
> fetcher but I guess its inevitable and at least we have the tests
> (thanks!).
>

Believe me, I have the same concerns. The fetcher is quite complex as it
is, but I don=E2=80=99t see any other way to solve this particular issue,
unfortunately. I split out git-make-shallow for this reason, to try to pare
down the changes to the fetcher itself, though of course that just
relocates the complexity rather than removing it :) I=E2=80=99d love to hea=
r any
ideas on how to simplify things, or solve this in a different way, as
unfortunately I=E2=80=99m completely out of ideas. I do think this solves a=
 problem
that we should solve, though.

In the back of my mind there is another way I've been wondering about
> assisting fetches, namely a "common reference repo" which urls may name
> (e.g. git://xxx;refrepo=3Dlinux-kernel). If this was specified, any clone
> would happen into the reference name as a subset namespace before a
> clone by reference into the main repo name. With kernels, this would
> mean one core repo and then all the subset kernels would clone by
> reference from it. That should mean all kernels would share a common
> repo so once you have one things should all be fast. Obviously shallow
> clones solve a different problem in some ways but there is overlap.
>

I like that idea as an additional improvement. As you say, similar but
slightly different, as shallow helps reduce what sources need to be shipped
/ distributed on and downloaded from a mirror, whereas refrepo is more
about reducing duplication amongst multiple recipes.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a113d0f369ed1f40550fa8f89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Jun 2, 2017 at 3:07 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div id=3D":ov" class=3D"a3s aXjCH m15c684664ea89bf5">Sorry about th=
e delay in getting to this. In general the series looks<br>
great.</div></blockquote><div><br></div><div>Thanks for taking the time to =
review this, I appreciate it. I know you have a lot on your plate, and anyt=
hing invasive in the fetcher is risky and not particularly fun.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div id=3D":ov" class=3D"a3s aXj=
CH m15c684664ea89bf5">One minor thing that bothers me a bit is the name of =
this<br>
script. If git itself ever creates something similar it may cause us<br>
issues. I wondered if we wanted to namespace this more closely to<br>
bitbake?<br>
<br>
I&#39;m leaning towards merging this and then perhaps tweaking the naming.<=
br></div></blockquote><div><br></div><div>That would be fine with me, I=E2=
=80=99m not particularly attached to the name. I only =C2=A0named it this w=
ay because it=E2=80=99s of use outside of bitbake as well, but I can see yo=
ur namespace concern.</div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv id=3D":ov" class=3D"a3s aXjCH m15c684664ea89bf5">
The other thing I&#39;d really like to see is the documentation collected<b=
r>
out the commit messages and sent to Scott Rifenbark (cc&#39;d) as a summary=
<br>
of the changes so he can update the manual, particularly the section on<br>
the git fetcher. If you could review it once Scott has done that, that<br>
would be awesome :).<br></div></blockquote><div><br></div><div>I can do tha=
t. I might still have a more monolithic description in one of the previous =
branches, I only broke it up this way to ease review and reduce confusion.<=
/div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":ov" class=3D=
"a3s aXjCH m15c684664ea89bf5">
I do have my worries about how much complexity this adds to the git<br>
fetcher but I guess its inevitable and at least we have the tests<br>
(thanks!).<br></div></blockquote><div><br></div><div>Believe me, I have the=
 same concerns. The fetcher is quite complex as it is, but I don=E2=80=99t =
see any other way to solve this particular issue, unfortunately. I split ou=
t git-make-shallow for this reason, to try to pare down the changes to the =
fetcher itself, though of course that just relocates the complexity rather =
than removing it :) I=E2=80=99d love to hear any ideas on how to simplify t=
hings, or solve this in a different way, as unfortunately I=E2=80=99m compl=
etely out of ideas. I do think this solves a problem that we should solve, =
though.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":ov" =
class=3D"a3s aXjCH m15c684664ea89bf5">
In the back of my mind there is another way I&#39;ve been wondering about<b=
r>
assisting fetches, namely a &quot;common reference repo&quot; which urls ma=
y name<br>
(e.g. git://xxx;refrepo=3Dlinux-<wbr>kernel). If this was specified, any cl=
one<br>
would happen into the reference name as a subset namespace before a<br>
clone by reference into the main repo name. With kernels, this would<br>
mean one core repo and then all the subset kernels would clone by<br>
reference from it. That should mean all kernels would share a common<br>
repo so once you have one things should all be fast. Obviously shallow<br>
clones solve a different problem in some ways but there is overlap.</div></=
blockquote></div><br>I like that idea as an additional improvement. As you =
say, similar but slightly different, as shallow helps reduce what sources n=
eed to be shipped / distributed on and downloaded from a mirror, whereas re=
frepo is more about reducing duplication amongst multiple recipes.<br>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot =
com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engin=
eer, Mentor Graphics</div></div></div></div>
</div></div>

--001a113d0f369ed1f40550fa8f89--
