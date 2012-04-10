Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SHbjY-0004mj-9V
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Apr 2012 16:07:48 +0200
Received: by qafl39 with SMTP id l39so2956865qaf.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2012 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=775ZDaQmY2YK/+M4p+XwjmE+YfVQS9YvRep1yWE0hSQ=;
	b=tFQcUwvCrUlWNWH7M33PqXRRxn6PXij01PXrnbyvOBYyLOjUS5UquWXzCsGmZylTgs
	sqTZLzdqmQ1X+NLEpOeb9432wZ3mhr2+cfVpw9hhWTWjW/+OZ9Ve4V3PYKXd3vOptF7O
	+fYxTQ6ExR2uswYI33kqpNe6Fl7yMnB2qpXHM41DUHoxcASr7hXkj+mcZrMBQQYRVMta
	HSkpYDh6k8RaNRw3vYgL60XDrQwudAgcscgN24VY9VcYF97TyKTD9kOAiGiCBrbnfFuN
	wiYgUlKYdjOb0ELjB5OjB1XtsJH3+iu2u9sA829srRR+ZgmOlEUCCcZDH6Eu5TMAGwyh
	19hQ==
Received: by 10.224.111.5 with SMTP id q5mr14541279qap.41.1334066310204; Tue,
	10 Apr 2012 06:58:30 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.79.79 with HTTP; Tue, 10 Apr 2012 06:58:09 -0700 (PDT)
In-Reply-To: <4F83EE3C.8040904@windriver.com>
References: <4F83EE3C.8040904@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 10 Apr 2012 06:58:09 -0700
X-Google-Sender-Auth: W1leD8xeGZb0FBxpQNcnVprLsbg
Message-ID: <CABcZANm628Wm0TYo45eSjLsVjzpseV=4__he=s=Lz_r1ekyJBw@mail.gmail.com>
To: Robert Yang <liezhi.yang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: questions about bitbake world
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
X-List-Received-Date: Tue, 10 Apr 2012 14:07:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 1:24 AM, Robert Yang <liezhi.yang@windriver.com> wr=
ote:
> In the following code:
>
> def buildWorldTargetList(self):
> ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for f in self.status.possible_world:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0terminal =3D True
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pn =3D self.status.pkg_fn[f]
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for p in pn_provides[pn]:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if p.startswith('v=
irtual/'):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pars=
elog.debug(2, "World build skipping %s due to %s
> provider starting with virtual/", f, p)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0term=
inal =3D False
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0brea=
k
> ...
>
> Does it mean that if a recipe contains:
>
> PROVIDES =3D "virtual/something"
>
> Then it would not be built until a pkg depends on it? Why we design it in
> this
> way, please?

The original intent with world was that when two recipes provided the
same thing, we'd still only want to build one of them, not both, as
building both can cause problems with stepping on one another in
sysroot, etc.
--=20
Christopher Larson


