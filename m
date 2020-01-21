Return-Path: <alex.kanavin@gmail.com>
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
	[209.85.217.48])
	by mail.openembedded.org (Postfix) with ESMTP id 92BA37FD8B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2020 10:49:24 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id p6so1410365vsj.11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2020 02:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=oSmoM2rb3nSOamAzVW1e80pTFWANaKeBexF6+b+d8Rk=;
	b=plXpOhQdQ0sVkT7A0bUcl/qjcF05Ie0TCrrnFtcWUVznfl6ZVQFnvwEjAMdqmRXQe3
	Q12iYDMpabcPh2MjaxSe7IDfMNhM+YwXb426DWC7pwAqeiGMNjVv2Z7LeJ4CC7RMwp0N
	J8mQRJc85+Vu0eGM9eh2oT+IXF+mFllni4mHyOpIY60g7m4+Jq+T/Rlt1oClAWugURKX
	UayPCDC7PRJJ1g5vlUC8nkK2rfGj3bAipYOWuQdHWoKO6r7Ts+jiIfYH+YAo1CfGlkN7
	5+Gzxs1qDn5KRgTZDwH9+ErLU8gFdue/UeISG6TU09E2tj3BNXC5pTtrZUF2G+zRBUDZ
	mDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oSmoM2rb3nSOamAzVW1e80pTFWANaKeBexF6+b+d8Rk=;
	b=OJXtCIlr8GUO+BiE65g6BG7W15riI+wQfUYhajfCk8dJSbakoRQ3BJVRNsKur6cluX
	OoEegiGZR+9OzZtYzZo7lJ8HjECxaGjajh+ozvVnnl76Yvvg/PMwWG8/FOT8nyuhnV3s
	DO/cW8vJNNcWC8DjofFVZnPRFF7HHfvPkia01yTxQEHlfGJcwLfwL0bgwMLZ57jI49fq
	EpUnX+A/b5ZBAulMRtp9ZGMBEureQskjXiu0ur/XuOftVhT08Mk68CmGY/m1A5iC5Uxg
	ZFvKknCVglMLw5gdQFy7pYyWAdiOWQyNKMlY4Ioo7NpJeqwlYqSxtRvS8sl62ZHj0qwY
	raDQ==
X-Gm-Message-State: APjAAAXD8eqtHlGbGg9nJVhLK4G9Xmlg6yf5ved4KdFwp/9T42Lk5vjq
	BGMTHETewE6L3DEL9T8X+fGzFyBqkL/QE/9Zok1D6Q==
X-Google-Smtp-Source: APXvYqxrO1Gu2bVPYlzbkRJMPEIHTXST3njDPRvie517jDHf/c9OtPdAqUJcXRzy1Y4FIXx4avDy1+FYiaIrjFsuIEk=
X-Received: by 2002:a05:6102:405:: with SMTP id
	d5mr2132432vsq.94.1579603765414; 
	Tue, 21 Jan 2020 02:49:25 -0800 (PST)
MIME-Version: 1.0
References: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
In-Reply-To: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Jan 2020 11:49:13 +0100
Message-ID: <CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
To: =?UTF-8?Q?Adrian_Ambro=C5=BCewicz?= <adrian.ambrozewicz@linux.intel.com>
Cc: Bitbake-Devel <bitbake-devel@lists.openembedded.org>
Subject: Re: devtool hardcodes using 'git' patchtool which causes errors
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
X-List-Received-Date: Tue, 21 Jan 2020 10:49:24 -0000
Content-Type: multipart/alternative; boundary="00000000000052ceaf059ca429b2"

--00000000000052ceaf059ca429b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am not entirely sure about this, but I believe devtool is using git to
keep track of patches when modifying or upgrading (e.g. adding, modifying
or rebasing custom recipe patches), so using quilt may not be an option.
Fixing the scenarios that go wrong for you is probably a better path.

Alex

On Tue, 21 Jan 2020 at 10:44, Adrian Ambro=C5=BCewicz <
adrian.ambrozewicz@linux.intel.com> wrote:

> In poky sources i can see that default PATCHTOOL used is 'quilt'
> (
> https://github.com/openembedded/openembedded-core/blob/master/meta/conf/b=
itbake.conf)
>
> and it works flawlessly. Devtool however still defaults to legacy 'git'
> PATCHTOOL, as specified here:
>
> http://git.yoctoproject.org/cgit.cgi/poky/plain/scripts/lib/devtool/stand=
ard.py
>   > f.write('PATCHTOOL =3D "git"\n')
>
> Request:
> I've tried to debug the problem but I'm not very familiar with Bitbake
> code, so I wonder if we could default to 'quilt' for devtool as well?
>
> Rationale:
> 'git' PATCHER doesn't work well when he have nested WORKDIR and
> striplevel used. 'bitbake -c patch [pkg]' works fine, but 'devtool
> modify [pkg]' fails with weird behavior. For example - new files created
> by patches are created in wrong location (WORKDIR instead of nested
> directory) and package doesn't compile until manually fixed.
>
> Regards,
> Adrian
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--00000000000052ceaf059ca429b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I am not entirely sure about this, but I believe devt=
ool is using git to keep track of patches when modifying or upgrading (e.g.=
 adding, modifying or rebasing custom recipe patches), so using quilt may n=
ot be an option. Fixing the scenarios that go wrong for you is probably a b=
etter path.</div><div><br></div><div>Alex<br></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 21 Jan 2020 at 1=
0:44, Adrian Ambro=C5=BCewicz &lt;<a href=3D"mailto:adrian.ambrozewicz@linu=
x.intel.com">adrian.ambrozewicz@linux.intel.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">In poky sources i can see th=
at default PATCHTOOL used is &#39;quilt&#39; <br>
(<a href=3D"https://github.com/openembedded/openembedded-core/blob/master/m=
eta/conf/bitbake.conf" rel=3D"noreferrer" target=3D"_blank">https://github.=
com/openembedded/openembedded-core/blob/master/meta/conf/bitbake.conf</a>) =
<br>
and it works flawlessly. Devtool however still defaults to legacy &#39;git&=
#39; <br>
PATCHTOOL, as specified here:<br>
<a href=3D"http://git.yoctoproject.org/cgit.cgi/poky/plain/scripts/lib/devt=
ool/standard.py" rel=3D"noreferrer" target=3D"_blank">http://git.yoctoproje=
ct.org/cgit.cgi/poky/plain/scripts/lib/devtool/standard.py</a><br>
=C2=A0 &gt; f.write(&#39;PATCHTOOL =3D &quot;git&quot;\n&#39;)<br>
<br>
Request:<br>
I&#39;ve tried to debug the problem but I&#39;m not very familiar with Bitb=
ake <br>
code, so I wonder if we could default to &#39;quilt&#39; for devtool as wel=
l?<br>
<br>
Rationale:<br>
&#39;git&#39; PATCHER doesn&#39;t work well when he have nested WORKDIR and=
 <br>
striplevel used. &#39;bitbake -c patch [pkg]&#39; works fine, but &#39;devt=
ool <br>
modify [pkg]&#39; fails with weird behavior. For example - new files create=
d <br>
by patches are created in wrong location (WORKDIR instead of nested <br>
directory) and package doesn&#39;t compile until manually fixed.<br>
<br>
Regards,<br>
Adrian<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--00000000000052ceaf059ca429b2--
