Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
	[209.85.167.42])
	by mail.openembedded.org (Postfix) with ESMTP id 6446F7F3E4
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Oct 2019 21:07:58 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id d17so13062587lfa.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Oct 2019 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3tR3cA3z655GEcS9dYMto37q94/LizYi9+2bQINR3QE=;
	b=sfytJ5rPOz6G1eGByNxyrUrgko8ZQgSmWIJA9a/bmOU2jwo2v4gtHK0WPCD/S9YdnT
	HIK/CfZBTXybqZlQCPt2bPK8kAFbunuaqjulhn/7vLn08PnXoF1WlqoWH984Z6hvXj1w
	brsMiMJXPwxLNV5n9KfTURhB54hLyfXXITChhawwlpaR2Kw7wEeDnpChc+t515eUWIcU
	T2HzNRrqSH3VpikB2yY+JgnS2DH68HOfVhihUkhxRK9pYyr8seaqJv9B94pPpcpTXmV+
	iGvg9qtESotqZo3gIaC/CrUEXYKB+NIUfreIAvUv/G/Z3/Kqot+NrqzWTtxxqgvRNBxH
	cn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3tR3cA3z655GEcS9dYMto37q94/LizYi9+2bQINR3QE=;
	b=GhdWuwq6e5/rpq5Klh8uQjYkb0libIAgrELkS066QwwsIOHkjXOapRfiYypxr8A5XD
	B06WghCBZBXozt4hdBoEPDFn/JiaCOmeOwVVF6SEnC7XXZ+c99U0w79o34bOZGSJ3WR2
	q3J+DLHAl9QwMCr0zDeMjZ5PSxV2euqFACmuC/cpKOrxoOolHNE9KdUeb42nr44NP5RY
	tD2+WadR/a493KABC+CwOURSZqQRVv7yibjnLRf8LRUblhyzWa04KibF28wn6I5kWpem
	8u4Sv90zdhg/AoQoUJCNKbkgwA9iffSt1xySKamI+iFt/3b2Eg7irnnXuv5helszTCFc
	VwuA==
X-Gm-Message-State: APjAAAXza+/kGZQsw3zYEZaTxiSmmwqy31obvNGYDvhCuaPGQ+hJR8Jx
	zcDclljYQkivRVnWzfFRhEOFQ9mnfgm2FsHmpf0QVw==
X-Google-Smtp-Source: APXvYqz8nW9exK1IrxbiiyD1Cet3PyeAZNwmlFyXJl7FoolAQLJCoE3UPBHpK/uqyI3zSIYSOAerQAftrxX/zMBggDE=
X-Received: by 2002:a19:cc15:: with SMTP id c21mr21597634lfg.64.1570568878793; 
	Tue, 08 Oct 2019 14:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191008184512.20130-1-anibal.limon@linaro.org>
	<19592357-2257-5c87-b3e9-5653bd224e9b@kernel.crashing.org>
In-Reply-To: <19592357-2257-5c87-b3e9-5653bd224e9b@kernel.crashing.org>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Tue, 8 Oct 2019 23:07:47 +0200
Message-ID: <CAP71WjzNr8B=Gox5kqE7kWrKCrtPZopCVvpHBDPP7M+DM6LbAA@mail.gmail.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC][WIP][PATCHv1] lib/bb/checksum.py: Speed-up checksum gen when directory is git
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
X-List-Received-Date: Tue, 08 Oct 2019 21:07:58 -0000
Content-Type: multipart/alternative; boundary="0000000000001dbd0705946c9060"

--0000000000001dbd0705946c9060
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 8 oct. 2019 =C3=A0 22:54, Mark Hatle <mark.hatle@kernel.crashing.or=
g> a
=C3=A9crit :

>
>
> On 10/8/19 1:45 PM, An=C3=ADbal Lim=C3=B3n wrote:
> > In some cases people/organizations are using a SRC_URI with
> > file:///PATH_TO_DIR that contains a git repository for different
> > reasons, it is useful when want to do an internal build without
> > clone sources from outside.
> >
> > This could consume a lot of CPU time because the current taskhash
> > generation mechanism didn't identify that the folder is a VCS
> > (git, svn, cvs) and makes the cksum for every file including the
> > .git repository in this case.
> >
> > There are different ways to improve the situation,
> >
> > * Add protocol=3Dgitscm in file:// SRC_URI but the taskhash is
> >   calculated before the fetcher identifies the protocol, will require
> >   some changes in bitbake codebase.
>
> When I have done this before, I've -always- defined it as a git repositor=
y
> by
> SRCURI:
>
> git://<local file path>;protocol=3Dfile
>
> Then it does exactly what this patch appears to do and uses the git logic
> to
> handle everything automatically.  (The file protocol is already
> implemented.)
>
> Wouldn't this be better then specifying file:// and then attempting to
> infer
> what file refers to?


Anibal and I are working on the same use case / problem. Folks who rely on
this setup also use it as a workspace, eg. They make local changes in the
sources workspace. So when doing fetch again the local changes are used. So
this is not strictly equivalent to what you propose, right?

Another major flaw with the current file:// with a git folder is that doing
a git fetch in the source tree will invalidate the fetch task even if the
actual sources haven=E2=80=99t changed!



>
> --MArk
>
> > * This patch: When directory is a git repository (contains .git)
> >   use HEAD rev + git diff to calculate checksum instead of do it
> >   in every file, that is hackish because make some assumptions about
> >   .git directory contents.
> > * Variant of this patch: Make a list of VCS directories (.git, .svn,
> >   .cvs) and take out for cksum calculations, same as before making
> >   assumptions about the . folders content.
> >
> > Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
> > ---
> >  lib/bb/checksum.py | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
> > index 5bc8a8fc..ee125cb5 100644
> > --- a/lib/bb/checksum.py
> > +++ b/lib/bb/checksum.py
> > @@ -86,6 +86,19 @@ class FileChecksumCache(MultiProcessCache):
> >              return checksum
> >
> >          def checksum_dir(pth):
> > +            git_dir =3D os.path.join(pth, '.git')
> > +            if os.path.exists(git_dir):
> > +                import subprocess, hashlib
> > +                m =3D hashlib.md5()
> > +                head =3D subprocess.check_output("cd %s && git rev-par=
se
> HEAD" % pth, shell=3DTrue)
> > +                diff =3D subprocess.check_output("cd %s && git diff" %
> pth, shell=3DTrue)
> > +                m.update(head)
> > +                if diff:
> > +                    m.update(diff)
> > +
> > +                return [(pth, m.hexdigest())]
> > +
> > +
> >              # Handle directories recursively
> >              if pth =3D=3D "/":
> >                  bb.fatal("Refusing to checksum /")
> >
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--0000000000001dbd0705946c9060
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Le=C2=A0mar. 8 oct. 2019 =C3=A0 22:54, Mark Hatle &lt;<a hr=
ef=3D"mailto:mark.hatle@kernel.crashing.org">mark.hatle@kernel.crashing.org=
</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 10/8/19 1:45 PM, An=C3=ADbal Lim=C3=B3n wrote:<br>
&gt; In some cases people/organizations are using a SRC_URI with<br>
&gt; file:///PATH_TO_DIR that contains a git repository for different<br>
&gt; reasons, it is useful when want to do an internal build without<br>
&gt; clone sources from outside.<br>
&gt; <br>
&gt; This could consume a lot of CPU time because the current taskhash<br>
&gt; generation mechanism didn&#39;t identify that the folder is a VCS<br>
&gt; (git, svn, cvs) and makes the cksum for every file including the<br>
&gt; .git repository in this case.<br>
&gt; <br>
&gt; There are different ways to improve the situation,<br>
&gt; <br>
&gt; * Add protocol=3Dgitscm in file:// SRC_URI but the taskhash is<br>
&gt;=C2=A0 =C2=A0calculated before the fetcher identifies the protocol, wil=
l require<br>
&gt;=C2=A0 =C2=A0some changes in bitbake codebase.<br>
<br>
When I have done this before, I&#39;ve -always- defined it as a git reposit=
ory by<br>
SRCURI:<br>
<br>
git://&lt;local file path&gt;;protocol=3Dfile<br>
<br>
Then it does exactly what this patch appears to do and uses the git logic t=
o<br>
handle everything automatically.=C2=A0 (The file protocol is already implem=
ented.)<br>
<br>
Wouldn&#39;t this be better then specifying file:// and then attempting to =
infer<br>
what file refers to?</blockquote><div dir=3D"auto"><br></div><div dir=3D"au=
to">Anibal and I are working on the same use case / problem. Folks who rely=
 on this setup also use it as a workspace, eg. They make local changes in t=
he sources workspace. So when doing fetch again the local changes are used.=
 So this is not strictly equivalent to what you propose, right?</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Another major flaw with the current=
 file:// with a git folder is that doing a git fetch in the source tree wil=
l invalidate the fetch task even if the actual sources haven=E2=80=99t chan=
ged!</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><br>
<br>
--MArk<br>
<br>
&gt; * This patch: When directory is a git repository (contains .git)<br>
&gt;=C2=A0 =C2=A0use HEAD rev + git diff to calculate checksum instead of d=
o it<br>
&gt;=C2=A0 =C2=A0in every file, that is hackish because make some assumptio=
ns about<br>
&gt;=C2=A0 =C2=A0.git directory contents.<br>
&gt; * Variant of this patch: Make a list of VCS directories (.git, .svn,<b=
r>
&gt;=C2=A0 =C2=A0.cvs) and take out for cksum calculations, same as before =
making<br>
&gt;=C2=A0 =C2=A0assumptions about the . folders content.<br>
&gt; <br>
&gt; Signed-off-by: An=C3=ADbal Lim=C3=B3n &lt;<a href=3D"mailto:anibal.lim=
on@linaro.org" target=3D"_blank">anibal.limon@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/checksum.py | 13 +++++++++++++<br>
&gt;=C2=A0 1 file changed, 13 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py<br>
&gt; index 5bc8a8fc..ee125cb5 100644<br>
&gt; --- a/lib/bb/checksum.py<br>
&gt; +++ b/lib/bb/checksum.py<br>
&gt; @@ -86,6 +86,19 @@ class FileChecksumCache(MultiProcessCache):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return checksum<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def checksum_dir(pth):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_dir =3D os.path.join(pt=
h, &#39;.git&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(git_dir):=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import subpro=
cess, hashlib<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m =3D hashlib=
.md5()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 head =3D subp=
rocess.check_output(&quot;cd %s &amp;&amp; git rev-parse HEAD&quot; % pth, =
shell=3DTrue)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 diff =3D subp=
rocess.check_output(&quot;cd %s &amp;&amp; git diff&quot; % pth, shell=3DTr=
ue)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m.update(head=
)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if diff:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 m.update(diff)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return [(pth,=
 m.hexdigest())]<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Handle directories r=
ecursively<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if pth =3D=3D &quot;/&=
quot;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fatal=
(&quot;Refusing to checksum /&quot;)<br>
&gt; <br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div></div>

--0000000000001dbd0705946c9060--
