Return-Path: <matt.hoosier@gmail.com>
Received: from mail-yb0-f194.google.com (mail-yb0-f194.google.com
	[209.85.213.194])
	by mail.openembedded.org (Postfix) with ESMTP id F4101719AF
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jun 2018 13:47:44 +0000 (UTC)
Received: by mail-yb0-f194.google.com with SMTP id l2-v6so3231335ybp.8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Jun 2018 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=YU/bUEd5m0AwWI9tJJMfj0AoEMhejghcDqD0B4Ocd6o=;
	b=vN2P5ullxsYuvR5ted7HZm6uAyijzUAsqw+PW4GxbUzFgTFllGS/RbX0YNCnevUQvN
	bRFT1hNtE8oFBtYJkvifcowfi+/bLDTa0luK+xFBRwK6yyTButBUz1NTQOt3w8DXz9vM
	XM91MEojv1xtXkMXklSwwAEvg7T3jy+h9zccKE9YBDsTTpF8G0fZG4tZlWr0epCrK5HQ
	UATzS/67e9x8mDUqBQctwb3ZXHdW/JM4OvSE5fNgeOmBHEnv0IlV27W9npZdl+l2GUFZ
	v4lowcJVonRDeEJZWdaRjrSRf+nIoebb9fe0hTv7N0V4Lvz8z5UO0kDALVFsna7fPT1Y
	ZhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=YU/bUEd5m0AwWI9tJJMfj0AoEMhejghcDqD0B4Ocd6o=;
	b=THtnz3OOjJuug33nEzKLwWPeri5ZxddK0KE0v+irn4hLRFK0DNbDinUCOfUoJzqxPk
	JevOmS4SZy/VKd6lraOULAts47bXHpZHH3nhN3jpE2RL+gHvKB3qUpUu2GEUe8oh7306
	m2pnWs2bilLQ9siFCGS5sN0/r5R8KOOGbbIji8dErJ+URGBU0ak5VBRxOqRKz5vOCewr
	k3RMGEN59OYU6quqKigzw2tMckG4YU9fpBhjLsPJEYJcUa8u/3SEi4B9M8rf20YsiJ7x
	v+TLK0zD3aBgCQiLGt8g7wKiBazG4ZsEJ7QWzmrpHLRHwr97rcCjOr7z324DLnvQhjFl
	DLrQ==
X-Gm-Message-State: APt69E3XkdTqwEMz8yFEYpcOmdFHBia1TV9tlvliLFk322saQlUjnp2H
	ka9J+A0QMbiKAA6QW7P3MmBP7vI7S+HlDJ8on8Y=
X-Google-Smtp-Source: ADUXVKKBT8Fl6hTTMvys1AqkLXmB6KWVYopNIdR4SkqccMXYnEmSDyHNvnRIU67p6oREd/q7qn0ZQ8vdU8AUb/buuII=
X-Received: by 2002:a25:ced0:: with SMTP id
	x199-v6mr1131176ybe.100.1528379265817; 
	Thu, 07 Jun 2018 06:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180525134537.27659-1-matt.hoosier@gmail.com>
	<03bb3ecd46e56bc21799d56f723bc01d966230c8.camel@linuxfoundation.org>
	<CAJgxT3_8t-OKSuAvY_NJKWoiAXfs_YuTmB9S6K-MV9QBYJhh_g@mail.gmail.com>
	<f6d6f5fa735580808180883de3eed143c10d6002.camel@linuxfoundation.org>
	<CAJgxT39m+ex8F+mjaq5+zzxps7DaPO=iUu=1PO=U3SW-NWp5_Q@mail.gmail.com>
In-Reply-To: <CAJgxT39m+ex8F+mjaq5+zzxps7DaPO=iUu=1PO=U3SW-NWp5_Q@mail.gmail.com>
From: Matt Hoosier <matt.hoosier@gmail.com>
Date: Thu, 7 Jun 2018 08:47:08 -0500
Message-ID: <CAJgxT3__308KPPC9MS+xOA9ExnUgYAx6bS82RLfG41A8vk=pBg@mail.gmail.com>
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v5] fetch/gitsm: avoid live submodule fetching during unpack()
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
X-List-Received-Date: Thu, 07 Jun 2018 13:47:45 -0000
Content-Type: multipart/alternative; boundary="00000000000038a13b056e0d87ff"

--00000000000038a13b056e0d87ff
Content-Type: text/plain; charset="UTF-8"

Thanks for the help getting this landed. With this change being part of
Bitbake, what's the procedure for attempting to get it backported to the
final MR of Yocto 2.2? Do I just backport it to a certain maintenance
branch of Bitbake (announced somehow with a prefix on the git-send-email
subject) and it would magically pop up out the corresponding branch of poky
if accepted to Bitbake?

On Wed, Jun 6, 2018 at 12:00 PM Matt Hoosier <matt.hoosier@gmail.com> wrote:

> On Wed, Jun 6, 2018 at 9:03 AM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>
>> On Wed, 2018-06-06 at 08:36 -0500, Matt Hoosier wrote:
>> > Okay, I'll see what's going on with that.
>
>
> I've posted an updated copy at
> http://lists.openembedded.org/pipermail/bitbake-devel/2018-June/009365.html
> that address the usage of the submodule commands that were too new for
> CentOS. Fortunately, their usage was basically unnecessary -- I just
> deleted them outright.
>
>
>> I'm still interested to
>> > know if there's a listing of all the various automated regimens that
>> > are used as CI before accepting Bitbake/Poky patches -- I don't want
>> > to keep wasting the maintainers' time with failures that I could have
>> > uncovered independently.
>>
>> The test matrix is basically encoded into:
>>
>>
>> http://git.yoctoproject.org/cgit.cgi/yocto-autobuilder-helper/tree/config.json
>>
>> run across the various autobuilder workers on https://autobuilder.yocto
>> .io/buildslaves, i.e. centos7, debian8, debian9, fedora26, fedora27,
>> opensuse423, opensuse tumbleweed, ubuntu 1604 and ubuntu 1704
>>
>> I'm not sure its reasonable to expect everyone to test across all those
>> combinations!
>>
>
> Okay, I agree. :)
>
> I think I've managed to test at the new and old ends of each of the major
> distro families there, so I'll be content let the autobuilder sniff out any
> more corner cases.
>
>
>>
>> > Any comments on the aims and overall technique of this change? So far
>> > all I've really gotten back are copy/pastes of automated builder
>> > failures.
>>
>> I strongly believe we should only have network access in do_fetch and
>> that our source mirroring should be functional and I therefore very
>> much support what the patch is doing and appreciate this getting fixed.
>>
>> Sorry for the terse nature of the replies, we're just seeing a lot of
>> patches which are breaking the regression tests and its hard to root
>> cause them back to the underlying patches and help people debug them.
>>
>> I do appreciate the help in getting this issue fixed as it will be a
>> good improvement to the fetcher.
>>
>> Cheers,
>>
>> Richard
>>
>
> Sounds great; thanks, Richard.
>

--00000000000038a13b056e0d87ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the help getting this landed. With this change =
being part of Bitbake, what&#39;s the procedure for attempting to get it ba=
ckported to the final MR of Yocto 2.2? Do I just backport it to a certain m=
aintenance branch of Bitbake (announced somehow with a prefix on the git-se=
nd-email subject) and it would magically pop up out the corresponding branc=
h of poky if accepted to Bitbake?</div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr">On Wed, Jun 6, 2018 at 12:00 PM Matt Hoosier &lt;<a href=3D"mai=
lto:matt.hoosier@gmail.com">matt.hoosier@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote">=
<div dir=3D"ltr">On Wed, Jun 6, 2018 at 9:03 AM Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.pu=
rdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Wed, 2018-06-06 at 08:36 -0500, Matt Hoosier wro=
te:<br>
&gt; Okay, I&#39;ll see what&#39;s going on with that.</blockquote><div><br=
></div><div>I&#39;ve posted an updated copy at=C2=A0<a href=3D"http://lists=
.openembedded.org/pipermail/bitbake-devel/2018-June/009365.html" target=3D"=
_blank">http://lists.openembedded.org/pipermail/bitbake-devel/2018-June/009=
365.html</a> that address the usage of the submodule commands that were too=
 new for CentOS. Fortunately, their usage was basically unnecessary -- I ju=
st deleted them outright.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">I&#39;m still interested to<br>
&gt; know if there&#39;s a listing of all the various automated regimens th=
at<br>
&gt; are used as CI before accepting Bitbake/Poky patches -- I don&#39;t wa=
nt<br>
&gt; to keep wasting the maintainers&#39; time with failures that I could h=
ave<br>
&gt; uncovered independently.<br>
<br>
The test matrix is basically encoded into:<br>
<br>
<a href=3D"http://git.yoctoproject.org/cgit.cgi/yocto-autobuilder-helper/tr=
ee/config.json" rel=3D"noreferrer" target=3D"_blank">http://git.yoctoprojec=
t.org/cgit.cgi/yocto-autobuilder-helper/tree/config.json</a><br>
<br>
run across the various autobuilder workers on <a href=3D"https://autobuilde=
r.yocto" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yocto</a>=
<br>
.io/buildslaves, i.e. centos7, debian8, debian9, fedora26, fedora27,<br>
opensuse423, opensuse tumbleweed, ubuntu 1604 and ubuntu 1704<br>
<br>
I&#39;m not sure its reasonable to expect everyone to test across all those=
<br>
combinations!<br></blockquote><div><br></div><div>Okay, I agree. :)</div><d=
iv><br></div><div>I think I&#39;ve managed to test at the new and old ends =
of each of the major distro families there, so I&#39;ll be content let the =
autobuilder sniff out any more corner cases.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Any comments on the aims and overall technique of this change? So far<=
br>
&gt; all I&#39;ve really gotten back are copy/pastes of automated builder<b=
r>
&gt; failures.<br>
<br>
I strongly believe we should only have network access in do_fetch and<br>
that our source mirroring should be functional and I therefore very<br>
much support what the patch is doing and appreciate this getting fixed.<br>
<br>
Sorry for the terse nature of the replies, we&#39;re just seeing a lot of<b=
r>
patches which are breaking the regression tests and its hard to root<br>
cause them back to the underlying patches and help people debug them.<br>
<br>
I do appreciate the help in getting this issue fixed as it will be a<br>
good improvement to the fetcher.<br>
<br>
Cheers,<br>
<br>
Richard<br></blockquote><div><br></div><div>Sounds great; thanks, Richard.<=
/div></div></div>
</blockquote></div>

--00000000000038a13b056e0d87ff--
