Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <msm-fsl@mcclintock.net>) id 1SFTl1-0004Hv-KJ
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 19:12:32 +0200
Received: by qao25 with SMTP id 25so379456qao.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Apr 2012 10:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=FinT0Y93l5ygEzzWrAWBhhgDwNlSIiVakLxYhp7Jb6A=;
	b=Lo+uxTggjFJWjE3Q1YRc5j/zW7QbmjVvAwSNdnf7sE6V87ccnlTLdXVQJH4eAcaaIU
	eCJJVBjqZGEywwkKctiZ9Vo1rH/U3WS58UenY6SvcPP/rhlT1XUe8KdpEloytHInXYH0
	X+/f2trfqaBmiLuQp830WWKdRvXDmDF+JQPLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding:x-gm-message-state;
	bh=FinT0Y93l5ygEzzWrAWBhhgDwNlSIiVakLxYhp7Jb6A=;
	b=FHAhoQ5nhzyx4Ot3jPyvj8L8MKRifGaH4UhZ2SLG3en+DAesGiDBk3NG6OneYN+wfT
	6mcw7TnFadr8pOa2wrxzC7QKMPUoZaNKdNrVcKzSy/gRSp7IZLn2JShsKv0q6EzC2nQM
	o1a2ab4rECBEWgodCRRq+fu2E1XDehmKgtYaNTOaWkeNLzkc4zRGx4oszIG9FtyDeiMh
	QOGW3Gbbb1ZpATLGWSnJVoPVO50PAxvipPQIDxBVS17ytN6SjDQAxCycpZqSv5AJOCLE
	ebpszKQZGN7wHNb6HseCIP6VL/t03JfKh5u2tI73C84R2dsU4ZZ7WDM6PGpiX3L8aYzK
	mh5g==
Received: by 10.229.137.3 with SMTP id u3mr2838633qct.20.1333559000167; Wed,
	04 Apr 2012 10:03:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.11.234 with HTTP; Wed, 4 Apr 2012 10:02:59 -0700 (PDT)
In-Reply-To: <1333495429-17048-1-git-send-email-kergoth@gmail.com>
References: <1333495429-17048-1-git-send-email-kergoth@gmail.com>
From: Matthew McClintock <msm-fsl@mcclintock.net>
Date: Wed, 4 Apr 2012 10:02:59 -0700
Message-ID: <CAEsOVNf_1-a62a8ZY=9WsVXg+YPSGZ8Afv7QiJKQq7Ayik9qBw@mail.gmail.com>
To: Christopher Larson <kergoth@gmail.com>
X-Gm-Message-State: ALoCoQkagcnt/zdLeWpwyczOjNTaxLRbIqPl/H6cHSncXTZHQbku0n3W1ZQcTmNh/T1DQEmfWdxG
Cc: Christopher Larson <chris_larson@mentor.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Remove whitelisted vars from non-task deps
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
X-List-Received-Date: Wed, 04 Apr 2012 17:12:32 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 3, 2012 at 4:23 PM, Christopher Larson <kergoth@gmail.com> wrot=
e:
> From: Christopher Larson <chris_larson@mentor.com>
>
> Though the value of variables in the BB_BASEHASH_WHITELIST is kept out of=
 the
> checksums, dependency on them is not, at least for variables and non-task
> functions. In the code, the whitelist is removed from the overall task de=
p
> list, but not the individual variable deps. The result of this is that
> functions like sysroot_stage_all and oe_runmake end up with whitelisted
> variables like TERM listed in their dependencies, which means that doing
> a 'unset TERM' before building will result in all checksums for tasks tha=
t
> depend on those changing, and shared state reuse not behaving correctly.
>
> This is only really a potential issue for variables from the environment,=
 as
> it's the existance/removal of the variable that's an issue, not its value=
, and
> the other whitelisted variables are set in our metadata. This which means=
 in
> practical terms the only cases where this is likely to be an issue are in
> environments where one of the following are unset: TERM, LOGNAME, HOME, U=
SER,
> PWD, SHELL. This may seem like an unlikely circumstance, but is in fact a=
 real
> issue for those of us using autobuilders. Jenkins does not set TERM when
> executing shell, which means shared state archives produced by your jenki=
ns
> server would not be fully reused by an actual user.
>
> Fixed by removing the whitelisted elements from the individual variable d=
eps,
> not just the accumulated result.

Which recipes/packages were you seeing this on? I've noticed the TERM
issue on several packages but not on all of them.

-M

>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> ---
> =A0lib/bb/siggen.py | =A0 =A09 +++++----
> =A01 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 8c79b17..7f5ae93 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -89,6 +89,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bb.error("Task %s from %s seems to be emp=
ty?!" % (task, fn))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D ''
>
> + =A0 =A0 =A0 =A0 =A0 =A0gendeps[task] -=3D self.basewhitelist
> =A0 =A0 =A0 =A0 =A0 =A0 newdeps =3D gendeps[task]
> =A0 =A0 =A0 =A0 =A0 =A0 seen =3D set()
> =A0 =A0 =A0 =A0 =A0 =A0 while newdeps:
> @@ -98,12 +99,12 @@ class SignatureGeneratorBasic(SignatureGenerator):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for dep in nextdeps:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if dep in self.basewhitelist:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gendeps[dep] -=3D self.basewhite=
list
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 newdeps |=3D gendeps[dep]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 newdeps -=3D seen
>
> - =A0 =A0 =A0 =A0 =A0 =A0alldeps =3D seen - self.basewhitelist
> -
> - =A0 =A0 =A0 =A0 =A0 =A0for dep in sorted(alldeps):
> + =A0 =A0 =A0 =A0 =A0 =A0alldeps =3D sorted(seen)
> + =A0 =A0 =A0 =A0 =A0 =A0for dep in alldeps:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D data + dep
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if dep in lookupcache:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 var =3D lookupcache[dep]
> @@ -113,7 +114,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if var:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D data + str(var)
> =A0 =A0 =A0 =A0 =A0 =A0 self.basehash[fn + "." + task] =3D hashlib.md5(da=
ta).hexdigest()
> - =A0 =A0 =A0 =A0 =A0 =A0taskdeps[task] =3D sorted(alldeps)
> + =A0 =A0 =A0 =A0 =A0 =A0taskdeps[task] =3D alldeps
>
> =A0 =A0 =A0 =A0 self.taskdeps[fn] =3D taskdeps
> =A0 =A0 =A0 =A0 self.gendeps[fn] =3D gendeps
> --
> 1.7.7
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


