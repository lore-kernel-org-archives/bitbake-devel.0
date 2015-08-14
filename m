Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id 777AD72A78
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Aug 2015 15:53:47 +0000 (UTC)
Received: by igfj19 with SMTP id j19so15476364igf.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Aug 2015 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=7ok7TNSyHbz6Sam1GZuBbZPv8RsK7xNhD8WIMPMaoro=;
	b=eW+BYEKWYJc+9qvmGMrhOsyCF1rQnUBpyyk9kEu6ALjsnPR05Hh+RVsQqsm4ouLi56
	bvgUTpW//CEPFYju+yLEPXwmcuJlN4hmYFgIlyKcQd3wWb2AU5Y3TZ+Kux1rRba+1p7j
	E4mue2ezW5aDf8UUpyANsVMI6TaXH8f6FHzFRo0mE66NOfD7o2p4OFB4zDmnzScrzkXv
	xU8Gx+zQSVDcptQSLQ/BaeumLHjSH4OVDLBewt7dQfWYYN3q6IjIR22oa/0uauHtjfdZ
	Vgwr9dHvw5ml+vaCUtIdPGdwRDEjEhbSDhp4JiMXe5+nVvhOtVjcK6HdIA95oTltN1rg
	xg2A==
X-Received: by 10.50.153.112 with SMTP id vf16mr3345604igb.79.1439567627077;
	Fri, 14 Aug 2015 08:53:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.100.199 with HTTP; Fri, 14 Aug 2015 08:53:27 -0700 (PDT)
In-Reply-To: <cover.1439509247.git.chris_larson@mentor.com>
References: <cover.1439509247.git.chris_larson@mentor.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Fri, 14 Aug 2015 08:53:27 -0700
Message-ID: <CABcZANkbhMG+JPbXRSmrw9jwYUKNXRqAwgndvRXvA8p5p96KPw@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [RFC PATCH 0/5] Implement git shallow mirror tarball support
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
X-List-Received-Date: Fri, 14 Aug 2015 15:53:53 -0000
Content-Type: multipart/alternative; boundary=089e01536c100ad037051d4775bd

--089e01536c100ad037051d4775bd
Content-Type: text/plain; charset=UTF-8

Some more notes on this implementation:

On Thu, Aug 13, 2015 at 4:46 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> This only implements support for shallow mirror tarballs, not shallow
> clones.
>

Shallow clones from upstream are not implemented, as, first, you can't
shallow clone from a commit, only the HEAD of a branch, and second, we'd
have to hardcode the exact depth from branch HEAD to SRCREV (this is in
addition to clone depth beyond SRCREV which is covered by this patch
series).

The mirror tarball filename includes branch, revision, and depth. To enable,
> use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for specific
> URLs. This variable can hold either a clone depth (e.g. `1` to just get
> SRCREV), or a ref or commit, in which case we keep history up to that
> commit.
>
> The shallow support will not, at this time, function correctly for
> linux-yocto, due to its branching scheme & validation.
>

It'd be possible to support linux-yocto, but only if all the dependent
branches were called out in the URI, so they all get retained.

Example:
>
>     BB_GIT_SHALLOW ?= "1"
>     BB_GIT_SHALLOW_pn-linux-yocto = ""
>     BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
>     BB_GIT_SHALLOW_pn-testrepo = "testbranch"
>
> This implementation will attempt to fetch a full mirror tarball if it was
> unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
> `BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a shallow
> tarball will be emitted.
>

I'm not 100% happy with this implementation, at the very least it needs a
little refactoring, to split out a new function or two, and make it a bit
more pythonic, but it might not even be the right approach, which is why
it's an RFC.

The shallow depth control is a variable rather than a URL parameter because
I did the latter initially before realizing that obviously making it a url
parameter would change checksums and cause pointless rebuilds, so the
variable is the best approach there. Opinions on the name of the variable
are welcome. Also open to thoughts on BB_GIT_SHALLOW_<name> vs
BB_GIT_SHALLOW[<name>].

I did attempt to prototype a new fetcher which acted as a premirror for the
git fetcher to handle the shallow logic, but ran into a number of issues. I
don't think any of them are unsurmountable, but it was enough to push me
into trying it this way first:

- The premirror fetcher would need to handle the fetching from the mirrors
itself, since the mirror tarball logic isn't nested, it's only used against
the main urldata, not the mirror urldata.
    - I think this would be fairly straightforward, just a matter of
calling try_mirrors() in download(), with appropriate arguments and
metadata.
- The wrong unpack method gets called. We'd need the premirror fetcher's
unpack method to be called, not the main fetcher's unpack method.
    - I think this could be addressed by passing in the mirror urldata into
the main fetcher's download/unpack methods, so it could call the mirror
unpack() to do the real work instead of handling it itself for cases like
this.
- The try_mirror_uri mirrortarball logic would have to remain, to ensure
that the main fetcher's download method doesn't get called in this context,
which is okay, but then we hit an issue with the symlinking that happens
otherwise, which is used to cover file:// mirrors -- we end up with the
shallow tarball symlinked to ${DL_DIR}/git2/<path>.
    - If we pass the mirror urldata into the main fetcher methods,
presumably we could ditch the try_mirror_uri mirrortarball logic the way I
do in this series, and then the main fetcher download method could simply
punt if it doesn't know how to handle the mirror in question (e.g. not a
non-shallow tarball)
    - Regarding the symlinking, I think we could trivially address that by
making sure the localpath basenames are the same for both urls, and if not,
don't symlink.

So we'll need to consider whether it'd be better to try a prototype of that
approach, addressing the issues, or continue along this path.

All that said, this does do the job, and seemingly does it quite well, so
it's possible we could use this and then improve the underlying
implementation as a secondary step (though, admittedly, doing that tends to
result in never coming back to do it better :).
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e01536c100ad037051d4775bd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_extra">Some=
 more notes on this implementation:</div><div class=3D"gmail_extra"><br></d=
iv><div class=3D"gmail_quote">On Thu, Aug 13, 2015 at 4:46 PM, Christopher =
Larson <span dir=3D"ltr">&lt;<a href=3D"mailto:kergoth@gmail.com" target=3D=
"_blank">kergoth@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":1jd" class=3D"a3s" style=3D"overflow:hidden">This only =
implements support for shallow mirror tarballs, not shallow clones.<br></di=
v></blockquote><div><br></div><div>Shallow clones from upstream are not imp=
lemented, as, first, you can&#39;t shallow clone from a commit, only the HE=
AD of a branch, and second, we&#39;d have to hardcode the exact depth from =
branch HEAD to SRCREV (this is in addition to clone depth beyond SRCREV whi=
ch is covered by this patch series).</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div id=3D":1jd" class=3D"a3s" style=3D"overflow:hidden">
The mirror tarball filename includes branch, revision, and depth. To enable=
,<br>
use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_&lt;name&gt;` for spe=
cific<br>
URLs. This variable can hold either a clone depth (e.g. `1` to just get<br>
SRCREV), or a ref or commit, in which case we keep history up to that commi=
t.<br>
<br>
The shallow support will not, at this time, function correctly for<br>
linux-yocto, due to its branching scheme &amp; validation.<br></div></block=
quote><div><br></div><div>It&#39;d be possible to support linux-yocto, but =
only if all the dependent branches were called out in the URI, so they all =
get retained.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=
=3D":1jd" class=3D"a3s" style=3D"overflow:hidden">
Example:<br>
<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW ?=3D &quot;1&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-linux-yocto =3D &quot;&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-linux-mel_mx6 =3D &quot;v3.14&quot;<br>
=C2=A0 =C2=A0 BB_GIT_SHALLOW_pn-testrepo =3D &quot;testbranch&quot;<br>
<br>
This implementation will attempt to fetch a full mirror tarball if it was<b=
r>
unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and<br>
`BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a shallow<br>
tarball will be emitted.<br></div></blockquote></div><div class=3D"gmail_ex=
tra"><br></div>I&#39;m not 100% happy with this implementation, at the very=
 least it needs a little refactoring, to split out a new function or two, a=
nd make it a bit more pythonic, but it might not even be the right approach=
, which is why it&#39;s an RFC.<br></div><div class=3D"gmail_extra"><br></d=
iv><div class=3D"gmail_extra">The shallow depth control is a variable rathe=
r than a URL parameter because I did the latter initially before realizing =
that obviously making it a url parameter would change checksums and cause p=
ointless rebuilds, so the variable is the best approach there. Opinions on =
the name of the variable are welcome. Also open to thoughts on BB_GIT_SHALL=
OW_&lt;name&gt; vs BB_GIT_SHALLOW[&lt;name&gt;].</div><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">I did attempt to prototype a new=
 fetcher which acted as a premirror for the git fetcher to handle the shall=
ow logic, but ran into a number of issues. I don&#39;t think any of them ar=
e unsurmountable, but it was enough to push me into trying it this way firs=
t:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">- T=
he premirror fetcher would need to handle the fetching from the mirrors its=
elf, since the mirror tarball logic isn&#39;t nested, it&#39;s only used ag=
ainst the main urldata, not the mirror urldata.</div><div class=3D"gmail_ex=
tra">=C2=A0 =C2=A0 - I think this would be fairly straightforward, just a m=
atter of calling try_mirrors() in download(), with appropriate arguments an=
d metadata.</div><div class=3D"gmail_extra">- The wrong unpack method gets =
called. We&#39;d need the premirror fetcher&#39;s unpack method to be calle=
d, not the main fetcher&#39;s unpack method.</div><div class=3D"gmail_extra=
">=C2=A0 =C2=A0 - I think this could be addressed by passing in the mirror =
urldata into the main fetcher&#39;s download/unpack methods, so it could ca=
ll the mirror unpack() to do the real work instead of handling it itself fo=
r cases like this.</div><div class=3D"gmail_extra">- The try_mirror_uri mir=
rortarball logic would have to remain, to ensure that the main fetcher&#39;=
s download method doesn&#39;t get called in this context, which is okay, bu=
t then we hit an issue with the symlinking that happens otherwise, which is=
 used to cover file:// mirrors -- we end up with the shallow tarball symlin=
ked to ${DL_DIR}/git2/&lt;path&gt;.</div><div class=3D"gmail_extra">=C2=A0 =
=C2=A0 - If we pass the mirror urldata into the main fetcher methods, presu=
mably we could ditch the try_mirror_uri mirrortarball logic the way I do in=
 this series, and then the main fetcher download method could simply punt i=
f it doesn&#39;t know how to handle the mirror in question (e.g. not a non-=
shallow tarball)</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 - Regarding =
the symlinking, I think we could trivially address that by making sure the =
localpath basenames are the same for both urls, and if not, don&#39;t symli=
nk.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">So=
 we&#39;ll need to consider whether it&#39;d be better to try a prototype o=
f that approach, addressing the issues, or continue along this path.</div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">All that sai=
d, this does do the job, and seemingly does it quite well, so it&#39;s poss=
ible we could use this and then improve the underlying implementation as a =
secondary step (though, admittedly, doing that tends to result in never com=
ing back to do it better :).</div><div class=3D"gmail_extra">-- <br><div cl=
ass=3D"gmail_signature"><div dir=3D"ltr">Christopher Larson<br>kergoth at g=
mail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer -=
 Tslib<br>Senior Software Engineer, Mentor Graphics</div></div>
</div></div>

--089e01536c100ad037051d4775bd--
