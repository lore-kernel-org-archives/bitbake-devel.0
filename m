Return-Path: <elliot.smith@intel.com>
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
	[209.85.223.170])
	by mail.openembedded.org (Postfix) with ESMTP id AD0CC75772
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Sep 2015 08:09:19 +0000 (UTC)
Received: by iofh134 with SMTP id h134so13899414iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Sep 2015 01:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=9Cd/wB/zRuIidTvnBfi/LVbjrL7Z7e0A0HyMjQ6Otdg=;
	b=JsO38d5D6cEYvnZADldnqTeLWsLW8V+qlxen9FeFC4UlM3//mpDWdbCmKWqxR2SCDp
	ZdJ9nXGxanIc2uKHRdNszSY9iTwdhzeW+7MKnznJhhgt2az7G7rqcQuXlFFvyZyJhxeb
	+Th+hxk30Qej+RaKfDXy67C4sGZW5wFW79dCDG/pGziiehjFj/wsU7jbXiq7SOiEA0os
	eZ3//7Xfm7o6gRXErpz/Dxgou+2PJsOfPg9RhtdRCgNZyH92Ua80h2Q/oIag5eqKNeEV
	oGjV6pQiZz+95jxxCT9uCpsJaf8bVzeJoqA1BAYu/JsfSKeD9cJ+dgjDCaGIIozl7m1c
	pzuw==
X-Gm-Message-State: ALoCoQk70kDWG0FjzF5GMWkZIHAUFefsPMbqdXB6A2ujTJfkRhTaG6JijO61HuyN9Vz5uXvu7O/J
MIME-Version: 1.0
X-Received: by 10.107.137.92 with SMTP id l89mr3703821iod.38.1442477359663;
	Thu, 17 Sep 2015 01:09:19 -0700 (PDT)
Received: by 10.64.7.77 with HTTP; Thu, 17 Sep 2015 01:09:19 -0700 (PDT)
In-Reply-To: <1442437842.26666.179.camel@linuxfoundation.org>
References: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
	<fa4a3965a75c8b3c659d7bdce1f5949a2f6f046b.1441904599.git.avery.brian@gmail.com>
	<1442437842.26666.179.camel@linuxfoundation.org>
Date: Thu, 17 Sep 2015 09:09:19 +0100
Message-ID: <CA+1hgUhMZAr9F0Kv-8v3d5g7XDeT16sTtxrjFuXr5jGAbK=EiQ@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/5] toaster: Add tests for /project/X/builds page
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
X-List-Received-Date: Thu, 17 Sep 2015 08:09:22 -0000
Content-Type: multipart/alternative; boundary=001a113ebdb49eca31051fecee8d

--001a113ebdb49eca31051fecee8d
Content-Type: text/plain; charset=UTF-8

Hello Richard,

The branch is:
elliot/toaster/hide_builds-8236

I just rebased it on poky master.

Thanks.
Elliot

On 16 September 2015 at 22:10, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2015-09-10 at 10:05 -0700, brian avery wrote:
> > From: Elliot Smith <elliot.smith@intel.com>
> >
> > Add tests to check whether "in progress" builds are filtered
> > out correctly, and that only builds for the current project
> > are shown.
> >
> > Adds a dependency on BeautifulSoup 4, which is used to simplify
> > writing tests which verify the HTML.
> >
> > Also requires a fix to how a date was converted in the view
> > which only manifested when I wrote the tests.
> >
> > [YOCTO #8236]
> > [YOCTO #8187]
> >
> > Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> > Signed-off-by: brian avery <avery.brian@gmail.com>
>
> Could you rebase this patch and point me at a branch please. I can't
> seem to get it to apply cleanly. I did get the others to work with line
> offset warnings.
>
> Cheers,
>
> Richard
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>



-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--001a113ebdb49eca31051fecee8d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Richard,<div><br></div><div>The branch is:</div><div=
>elliot/toaster/hide_builds-8236<br></div><div><br></div><div>I just rebase=
d it on poky master.</div><div><br></div><div>Thanks.</div><div>Elliot</div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 16 Sept=
ember 2015 at 22:10, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto=
:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linux=
foundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On T=
hu, 2015-09-10 at 10:05 -0700, brian avery wrote:<br>
&gt; From: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.com">ellio=
t.smith@intel.com</a>&gt;<br>
&gt;<br>
&gt; Add tests to check whether &quot;in progress&quot; builds are filtered=
<br>
&gt; out correctly, and that only builds for the current project<br>
&gt; are shown.<br>
&gt;<br>
&gt; Adds a dependency on BeautifulSoup 4, which is used to simplify<br>
&gt; writing tests which verify the HTML.<br>
&gt;<br>
&gt; Also requires a fix to how a date was converted in the view<br>
&gt; which only manifested when I wrote the tests.<br>
&gt;<br>
&gt; [YOCTO #8236]<br>
&gt; [YOCTO #8187]<br>
&gt;<br>
&gt; Signed-off-by: Elliot Smith &lt;<a href=3D"mailto:elliot.smith@intel.c=
om">elliot.smith@intel.com</a>&gt;<br>
&gt; Signed-off-by: brian avery &lt;<a href=3D"mailto:avery.brian@gmail.com=
">avery.brian@gmail.com</a>&gt;<br>
<br>
Could you rebase this patch and point me at a branch please. I can&#39;t<br=
>
seem to get it to apply cleanly. I did get the others to work with line<br>
offset warnings.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Soft=
ware Engineer<br>Intel Open Source Technology Centre</div></div></div>
</div>

--001a113ebdb49eca31051fecee8d--
