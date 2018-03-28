Return-Path: <soemoe.a@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail.openembedded.org (Postfix) with ESMTP id 74BFA784F0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 16:47:35 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id 71-v6so2505766ith.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=34cIH/Qj7d/Uu2raxzYqqf7IPfkir1qi3+fOdeHP7kk=;
	b=t7FaEqzPTlYYHV8VR9elKX7viTC6QbsTRGo0GqF4NjHegbvO14uTmmFfNy0YHzzhYz
	O6z+QkrkOMY571ibUE1QcO+apgvS4uFvWkPbDj+uYBLs6WNN1YKRsBkzLlXEo6LTRZlM
	Tzjsgth5AJPIIjQCJQ0d8AjbabyN1UzuZ6BN21BrzGyF0Y25h4CIRZtetnxG5o2bJ7rZ
	MvsM9nvl3y6VhvOg1RCSvjtvkvUHxIQAlsiSfVpf9n/k1MzOLYzF82TWAVOe82wAb58M
	dCzgIpp7vNqqDe8e+n5JLZaXkzoAfaZz50sTFxJDfv4xnMpkge8aaI92Rlvl4ZmO2Jpu
	4h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=34cIH/Qj7d/Uu2raxzYqqf7IPfkir1qi3+fOdeHP7kk=;
	b=k4eJhbEfM6x3kuRFLyapqO4xvc1HmYGIVZ0HDxdgPT5bHYF9+k4VfQu4C09iIbGuXw
	r51gjUtJ1DcWdtFNpvLPDNpvUDbMLMgn9x6vA+4x+a8I7R1ZRPdouZQ4BXqOYcF7ECL4
	lKaPEtBkm5xbhXCQqFo7jnAEgTvJo0iPUxEHx7ZPppqQH0vXup5J9DYijEoU0IqxPPjj
	DUrvt4Zyo8IvSJeglGG4cyD/rO2xXSSGHkUQ1cQRo7pFqblaM/bdUbFupNBJM1vcMO6E
	Dfh8lpSvZwokLawZwLi0W0eMcUgM81JfZaWxozAeS4vfXaz/B2oisufPjB7tP8DkSulH
	NYeg==
X-Gm-Message-State: AElRT7GCX+pucMW/xEEKGNXau/cUK2IXY+QMmRHMplB2rAr0QeiiMty8
	MM68Xhvy6d1QlBpveOxp1lBCdqc7cUHW5b/N7mo=
X-Google-Smtp-Source: AIpwx4/eW6OfQVIg3fUwJnjYKoiciqerndrYRsSDOLdGLbC9ipiWazM2Cn0369E8zrqglDdTuDHSGo7RCTLsKokbqPc=
X-Received: by 2002:a24:b60f:: with SMTP id
	g15-v6mr4135155itf.125.1522255656716; 
	Wed, 28 Mar 2018 09:47:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.56.65 with HTTP; Wed, 28 Mar 2018 09:47:16 -0700 (PDT)
In-Reply-To: <1522230112838.18244@axis.com>
References: <cover.1522085586.git.soemoe.a@gmail.com>
	<1522230112838.18244@axis.com>
From: Soemoe Aung <soemoe.a@gmail.com>
Date: Wed, 28 Mar 2018 09:47:16 -0700
Message-ID: <CAPTBsuX3NZmgqqE4bGTQ29k=yp7F6Z_Anwawue=W+3ab1fG3Og@mail.gmail.com>
To: Ola x Nilsson <ola.x.nilsson@axis.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PULL] *** Fix build issue with html5lib in bitbake 1.26/1.28 ***
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
X-List-Received-Date: Wed, 28 Mar 2018 16:47:36 -0000
Content-Type: multipart/alternative; boundary="000000000000ad0d9f05687bc383"

--000000000000ad0d9f05687bc383
Content-Type: text/plain; charset="UTF-8"

Yes, that's essentially what I'm asking for. Sorry if that wasn't clear.
That fix is in bitbake 1.30 but seems to be needed in 1.26 and 1.28 as
well. My change literally took the html5lib file from 1.30 and copied it to
the file in 1.26 and submitted it as a patch. Apologies if this was the
wrong way to go about this.

What are the steps to backport this change to 1.26 and 1.28 (and also to
send these changes upstream to yocto-poky)? Is there anything I need to do?

On Wed, Mar 28, 2018 at 2:41 AM, Ola x Nilsson <ola.x.nilsson@axis.com>
wrote:

> This has already been fixed on a few branches with
>
> bitbake: lib/bs4: Fix imports from html5lib >= 0.9999999/1.0b8
>
> It might be better to backport that where needed.
>
> --
> Ola Nilsson
> ________________________________________
> From: bitbake-devel-bounces@lists.openembedded.org <
> bitbake-devel-bounces@lists.openembedded.org> on behalf of Soemoe Aung <
> soemoe.a@gmail.com>
> Sent: Tuesday, March 27, 2018 23:15
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PULL] *** Fix build issue with html5lib in
> bitbake    1.26/1.28 ***
>
> When I was running yocto-poky on the fido and jethro branches, I was
> getting build errors caused by the included html5lib in bitbake. It seems
> like a class is being called incorrectly there. I noticed the issue is
> resolved in the krogoth branch and the html5lib is indeed different there.
>
> yocto-poky fido includes bitbake version 1.26 and jethro includes bitbake
> version 1.28. Looking at the bitbake source repo for these versions
> confirms that these files are the same. yocto-poky krogoth, which has the
> issue fixed, uses bitbake 1.30, which also has the issue fixed in the
> bitbake repo.
>
> I originally created this patch in the yocto-poky contrib repo and was
> directed to send it to bitbake instead. Can someone here take a look at
> this and accept the changes into the 1.26 and 1.28 branches? Can you also
> send these changes upstream to the yocto-poky fido and jethro branches?
>
> Let me know if you need any changes here, like creating this patch from
> the bitbake repo directly instead of indirectly through yocto-poky.
>
> The following changes since commit ea6d21066a7cce2fef08ad66287170
> c5995bb1e2:
>
>   bitbake: bitbake-user-manual: Fixed porno hack for hello world example
> (2018-01-17 22:32:46 +0000)
>
> are available in the Git repository at:
>
>   git://push.yoctoproject.org/poky-contrib saung/bitbake-html5lib
>
> Soemoe Aung (2):
>   fix build error in included html5lib in bitbake
>   fix html5lib fix to be the same as in the krogoth branch
>
>  bitbake/lib/bs4/builder/_html5lib.py | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> --
> 2.17.0.rc0.231.g781580f067-goog
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--000000000000ad0d9f05687bc383
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, that&#39;s essentially what I&#39;m asking for. Sorry=
 if that wasn&#39;t clear. That fix is in bitbake 1.30 but seems to be need=
ed in 1.26 and 1.28 as well. My change literally took the html5lib file fro=
m 1.30 and copied it to the file in 1.26 and submitted it as a patch. Apolo=
gies if this was the wrong way to go about this.<div><br></div><div>What ar=
e the steps to backport this change to 1.26 and 1.28 (and also to send thes=
e changes upstream to yocto-poky)? Is there anything I need to do?</div></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Mar 28=
, 2018 at 2:41 AM, Ola x Nilsson <span dir=3D"ltr">&lt;<a href=3D"mailto:ol=
a.x.nilsson@axis.com" target=3D"_blank">ola.x.nilsson@axis.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">This has already been fixed on =
a few branches with<br>
<br>
bitbake: lib/bs4: Fix imports from html5lib &gt;=3D 0.9999999/1.0b8<br>
<br>
It might be better to backport that where needed.<br>
<br>
--<br>
Ola Nilsson<br>
______________________________<wbr>__________<br>
From: <a href=3D"mailto:bitbake-devel-bounces@lists.openembedded.org">bitba=
ke-devel-bounces@lists.<wbr>openembedded.org</a> &lt;<a href=3D"mailto:bitb=
ake-devel-bounces@lists.openembedded.org">bitbake-devel-bounces@lists.<wbr>=
openembedded.org</a>&gt; on behalf of Soemoe Aung &lt;<a href=3D"mailto:soe=
moe.a@gmail.com">soemoe.a@gmail.com</a>&gt;<br>
Sent: Tuesday, March 27, 2018 23:15<br>
To: <a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@l=
ists.<wbr>openembedded.org</a><br>
Subject: [bitbake-devel] [PULL] *** Fix build issue with html5lib in bitbak=
e=C2=A0 =C2=A0 1.26/1.28 ***<br>
<div><div class=3D"h5"><br>
When I was running yocto-poky on the fido and jethro branches, I was gettin=
g build errors caused by the included html5lib in bitbake. It seems like a =
class is being called incorrectly there. I noticed the issue is resolved in=
 the krogoth branch and the html5lib is indeed different there.<br>
<br>
yocto-poky fido includes bitbake version 1.26 and jethro includes bitbake v=
ersion 1.28. Looking at the bitbake source repo for these versions confirms=
 that these files are the same. yocto-poky krogoth, which has the issue fix=
ed, uses bitbake 1.30, which also has the issue fixed in the bitbake repo.<=
br>
<br>
I originally created this patch in the yocto-poky contrib repo and was dire=
cted to send it to bitbake instead. Can someone here take a look at this an=
d accept the changes into the 1.26 and 1.28 branches? Can you also send the=
se changes upstream to the yocto-poky fido and jethro branches?<br>
<br>
Let me know if you need any changes here, like creating this patch from the=
 bitbake repo directly instead of indirectly through yocto-poky.<br>
<br>
The following changes since commit ea6d21066a7cce2fef08ad66287170<wbr>c5995=
bb1e2:<br>
<br>
=C2=A0 bitbake: bitbake-user-manual: Fixed porno hack for hello world examp=
le (2018-01-17 22:32:46 +0000)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://push.yoctoproject.org/poky-contrib" rel=3D"n=
oreferrer" target=3D"_blank">push.yoctoproject.org/<wbr>poky-contrib</a> sa=
ung/bitbake-html5lib<br>
<br>
Soemoe Aung (2):<br>
=C2=A0 fix build error in included html5lib in bitbake<br>
=C2=A0 fix html5lib fix to be the same as in the krogoth branch<br>
<br>
=C2=A0bitbake/lib/bs4/builder/_<wbr>html5lib.py | 17 ++++++++++++-----<br>
=C2=A01 file changed, 12 insertions(+), 5 deletions(-)<br>
<br>
--<br>
2.17.0.rc0.231.g781580f067-<wbr>goog<br>
<br>
</div></div>--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br></div>

--000000000000ad0d9f05687bc383--
