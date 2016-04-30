Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
	[209.85.223.193])
	by mail.openembedded.org (Postfix) with ESMTP id 34FEB605BA
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:46:30 +0000 (UTC)
Received: by mail-io0-f193.google.com with SMTP id d62so19549995iof.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=rSw4+zzLM8jHx9MX8GTDthLQRiZQta+2C+ociobUi+8=;
	b=tuhAJxLqhZd3Dn0lPfvpuL7dLSwa+Q7B9InnpkMaPT/hVyDi+GgBdvwIFKSZ09K6oo
	SKPbXKP8NAgs6HhtYy0RFWNBZNyQ3r379fT0Rjr8CMPJSIQxmQ8m2zCXYhIqhp94rvlf
	hWdeUgMC6JHB9Pxwb8K0+sZWDo3tzX7h/MXvM/PciNv7hZcaCOpL21dg1ena0licm/Cv
	sQ4NHqN67Xy5glS0aaJKBI+g9gydK4cBp0Ris/x2HJYMUTJqUYyLN5wcOYbLrT3h0TGP
	HHZPlWzy3qxBNuTu+eYvTo4O7ZF2U3JUxPn/QxoLiI5kqQzVpW0tQZeN6lEneckW6tWc
	BCxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mentor-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=rSw4+zzLM8jHx9MX8GTDthLQRiZQta+2C+ociobUi+8=;
	b=iS4Oss8xS9dJhfb9xKKJHT0fZOqEUQ0XdphFOEVc+C36PcU7tdX+AQ6kFdTIbUJ859
	loKWmV3UlLjd8QzsFLksk5UUGGQmSYcfJ8zqSlIhCKYZwnkZ3H7Axo2+SxDbUa7AxeuT
	7oyDObM+5Ljc7Ef64YoJb/z1i6uTIMURYljUHoYYcYr5G0BwRBM8/yIBq+OBd4b2OdEp
	wR8NNJbqv0diFx/eBU0a9GqSMDTGNIZBj0g0rhLFWM7FvDohiC3YkhMVYl7A1RY6DNbQ
	p4lOsdHXt/SiFfA+ZzKhq+wUW2edwTH08vdfq8795++PMzRyQxyHQELayU703nepMcFH
	k4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=rSw4+zzLM8jHx9MX8GTDthLQRiZQta+2C+ociobUi+8=;
	b=ToKeG4DcDlU+xnaSJYCHY4ZBQhbSh++aA0ubEpa//tHsu4eN6z8rUHKhn7ejC3yuXc
	K8cmmwr37JR966XQRsDWcKnFrwmpiUNHKOYGirekoieU1CS1WE0YinLCgCt/rbl8g9Yo
	hgQ2RBV/MCKs6JyraCK0h5Vrq3FtbQlpp+DtENlfc5xKztik0/si/eiC1qIXzqx6CulO
	V9bGeD4sgdD/FBKLR3D6ZF3iSdC20LeICui9bCqzDiceMBfDhDEESVQq0NjVSz7lo8L8
	E2K1Oe4AmgJS43wGjaBHgYTR0we3LVN4C2u4JBv8XB4DEzOJUuJHLnHex8MEjC05rsn2
	Z4GA==
X-Gm-Message-State: AOPr4FUtBHVnwJa0hmg1zN1Aug8fY5fSNCLa0bvbqVY6ZNvUnp4c78Xj0OJ2sbtbNxOe4BDgYqoIbF3oMKlHXw==
X-Received: by 10.107.2.70 with SMTP id 67mr33088717ioc.70.1462045590875; Sat,
	30 Apr 2016 12:46:30 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Sat, 30 Apr 2016 12:46:11 -0700 (PDT)
In-Reply-To: <16137e65f85faac1bf54fc42f50010dab3bb03c9.1462042322.git.chris_larson@mentor.com>
References: <cover.1462042322.git.chris_larson@mentor.com>
	<98d64b9af58521cc7c7b33d5584720e88e673a3e.1462042322.git.chris_larson@mentor.com>
	<16137e65f85faac1bf54fc42f50010dab3bb03c9.1462042322.git.chris_larson@mentor.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Sat, 30 Apr 2016 12:46:11 -0700
X-Google-Sender-Auth: kYW9btnqhy-6ADouB32rOg0p6Sg
Message-ID: <CABcZANkK9N_YzPfSG-mhvwkSPq1Dja9NxvO4u0cjHkFJZWsphg@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [master][PATCH 3/3] bb.fetch.git: add support for shallow mirror tarballs
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
X-List-Received-Date: Sat, 30 Apr 2016 19:46:32 -0000
Content-Type: multipart/alternative; boundary=001a1139681416f59a0531b904f2

--001a1139681416f59a0531b904f2
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 30, 2016 at 12:44 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> This adds support to the git fetcher for fetching and generating mirror
> tarballs of shallow git repositories, with the specified revisions /
> depths.
>
> This implements support for shallow mirror tarballs, not shallow clones.
> Supporting shallow clones directly would be rather more problematic, as
> we'd
> need to hardcode the depth between branch HEAD and the SRCREV, and that
> depth
> would change as the branch is updated. Sadly, git's remote protocol is
> extremely limited.
>
> When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow
> mirror tarball. If the shallow mirror tarball cannot be fetched, it will
> try
> to fetch the full mirror tarball and use that.
>
> Multiple variables exist to exert control over what revisions and refs are
> kept at what are not.
>
> BB_GIT_SHALLOW: enable/disable shallow support as a whole, boolean
> BB_GIT_SHALLOW_DEPTH: specify commit depth for the included refs. defaults
> to 1 (the top commit alone). This can be set to 0 or the empty string.
> BB_GIT_SHALLOW_DEPTH_<name>: specify commit depth for a specific named
> url/branch
> BB_GIT_SHALLOW_REVS: specific revisions whose history should be removed,
> beyond that specified by refs+depth
> BB_GIT_SHALLOW_TRIM_REFS: by default, unused refs/branches are removed.
> set this to 0 or the empty string to keep all refs around. this is required
> for linux-yocto kernel repositories, otherwise the branch checking done by
> the kernel scripts will fail
> BB_GIT_SHALLOW_EXTRA_REFS: additional refs to keep beyond those referenced
> in SRC_URI, when TRIM_REFS is enabled
> BB_GENERATE_SHALLOW_TARBALLS: explicitly control creation of shallow
> mirror tarballs. this defaults to enabled when BB_GENERATE_MIRROR_TARBALLS
> is enabled
>
> Example usage:
>
>     BB_GIT_SHALLOW ?= "1"
>     BB_GIT_SHALLOW_DEPTH ?= "1"
>
>     # Usage in a recipe with multiple named uris or multiple named branches
>     BB_GIT_SHALLOW_DEPTH_doc = ""
>
>     # Remove the upstream history from our kernel repo, keeping our own
>     BB_GIT_SHALLOW_REVS_pn-linux-mel_mx6 = "v3.14"
>     BB_GIT_SHALLOW_DEPTH_pn-linux-mel_mx6 = ""
>
>     # Keep the branches in linux-yocto repositories
>     BB_GIT_SHALLOW_TRIM_REFS_pn-linux-yocto = "0"
>


I'll re-send a v2 of this. I just noticed this accidentally resurrects the
indirectionsymlink.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1139681416f59a0531b904f2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Apr 30, 2016 at 12:44 PM, Christopher Larson <span dir=3D"ltr">&lt;=
<a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":2xe" clas=
s=3D"a3s aXjCH">From: Christopher Larson &lt;<a href=3D"mailto:chris_larson=
@mentor.com">chris_larson@mentor.com</a>&gt;<br>
<br>
This adds support to the git fetcher for fetching and generating mirror<br>
tarballs of shallow git repositories, with the specified revisions / depths=
.<br>
<br>
This implements support for shallow mirror tarballs, not shallow clones.<br=
>
Supporting shallow clones directly would be rather more problematic, as we&=
#39;d<br>
need to hardcode the depth between branch HEAD and the SRCREV, and that dep=
th<br>
would change as the branch is updated. Sadly, git&#39;s remote protocol is<=
br>
extremely limited.<br>
<br>
When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow<b=
r>
mirror tarball. If the shallow mirror tarball cannot be fetched, it will tr=
y<br>
to fetch the full mirror tarball and use that.<br>
<br>
Multiple variables exist to exert control over what revisions and refs are<=
br>
kept at what are not.<br>
<br>
BB_GIT_SHALLOW: enable/disable shallow support as a whole, boolean<br>
BB_GIT_SHALLOW_DEPTH: specify commit depth for the included refs. defaults =
to 1 (the top commit alone). This can be set to 0 or the empty string.<br>
BB_GIT_SHALLOW_DEPTH_&lt;name&gt;: specify commit depth for a specific name=
d url/branch<br>
BB_GIT_SHALLOW_REVS: specific revisions whose history should be removed, be=
yond that specified by refs+depth<br>
BB_GIT_SHALLOW_TRIM_REFS: by default, unused refs/branches are removed. set=
 this to 0 or the empty string to keep all refs around. this is required fo=
r linux-yocto kernel repositories, otherwise the branch checking done by th=
e kernel scripts will fail<br>
BB_GIT_SHALLOW_EXTRA_REFS: additional refs to keep beyond those referenced =
in SRC_URI, when TRIM_REFS is enabled<br>
BB_GENERATE_SHALLOW_TARBALLS: explicitly control creation of shallow mirror=
 tarballs. this defaults to enabled when BB_GENERATE_MIRROR_TARBALLS is ena=
bled<br>
<br>
Example usage:<br>
<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW ?=3D &quot;1&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH ?=3D &quot;1&quot;<br>
<br>
=C2=A0 =C2=A0 # Usage in a recipe with multiple named uris or multiple name=
d branches<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH_doc =3D &quot;&quot;<br>
<br>
=C2=A0 =C2=A0 # Remove the upstream history from our kernel repo, keeping o=
ur own<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_REVS_pn-linux-mel_mx6 =3D &quot;v3.14&quot;<br=
>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_DEPTH_pn-linux-mel_mx6 =3D &quot;&quot;<br>
<br>
=C2=A0 =C2=A0 # Keep the branches in linux-yocto repositories<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_TRIM_REFS_pn-linux-yocto =3D &quot;0&quot;<br>=
</div></blockquote></div><br><br>I&#39;ll re-send a v2 of this. I just noti=
ced this accidentally resurrects the indirectionsymlink.<br>-- <br><div cla=
ss=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br>kergoth at gm=
ail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - =
Tslib<br>Senior Software Engineer, Mentor Graphics</div></div>
</div></div>

--001a1139681416f59a0531b904f2--
