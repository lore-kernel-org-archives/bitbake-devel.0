Return-Path: <martin.jansa@gmail.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id C71EE7574D;
	Fri, 29 May 2015 09:18:08 +0000 (UTC)
Received: by wgme6 with SMTP id e6so57221280wgm.2;
	Fri, 29 May 2015 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=fRDSQqDXz3KpDQbVuihnJ4YHt0QcqlNbt8kMxaXOA0I=;
	b=OMLy4OJlq9SgsdudJ+FhwJC8XROhYwy6wPLpftldHrdU3/0RgrPR643OjR0COXv6tY
	aNBV7h0GGKkW5BcMVq16oB26Osl+B61T2KDdAQNlrLEr2FGj75r7Dn4LVCdYjrvwEG0e
	Qzc7RQNmtMpO/liaFxEhDRcqBaPb/UwwELoMHQjNw7XIutkvInldXvMmgsgW2WcNJ8EN
	DIsro+yu/ElhI47062vlA6hr2abeycB2sqzBGdjZmVNgWgVUL9sI3KSLkOTtI4OuXbZR
	1E46Z0Xo8CIeTGIkxAz7bhAZMhnhlc0SGxc91KO8Lzk25gTv2gOopHORyTQ/lDQm5XE+
	cb6Q==
MIME-Version: 1.0
X-Received: by 10.194.90.100 with SMTP id bv4mr12988617wjb.143.1432891088548; 
	Fri, 29 May 2015 02:18:08 -0700 (PDT)
Received: by 10.28.167.73 with HTTP; Fri, 29 May 2015 02:18:08 -0700 (PDT)
In-Reply-To: <CAK8F28mc2C=r4n42xFmNaxNveectuB8esrkt4M2BkSknH-mFxw@mail.gmail.com>
References: <20150427105100.GB2379@jama>
	<1432309170-5575-1-git-send-email-ashcharles@gmail.com>
	<5567C5B1.7010901@windriver.com>
	<CAK8F28mc2C=r4n42xFmNaxNveectuB8esrkt4M2BkSknH-mFxw@mail.gmail.com>
Date: Fri, 29 May 2015 11:18:08 +0200
Message-ID: <CA+chaQe_T9zPjckAm+NZrZpdw5BO81eL-vxrAA-2kYymMRbd1w@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
To: Ash Charles <ashcharles@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-devel <openembedded-devel@lists.openembedded.org>
Subject: Re: [oe] [PATCH] fetch/hg: Disable checksums for archived downloads
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
X-List-Received-Date: Fri, 29 May 2015 09:18:11 -0000
Content-Type: multipart/alternative; boundary=047d7bfceb0655bb10051734f41a

--047d7bfceb0655bb10051734f41a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

FWIW: I see vim unpack failing now in world builds:

NOTE: recipe vim-7.4.481-r0: task do_unpack: Started
ERROR: Function failed: Fetcher failure: Fetch command failed with
exit code 255, output:
abort: repository
/home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim
not found!

ERROR: Logfile of failure stored in:
/home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vim=
/7.4.481-r0/temp/log.do_unpack.28505
Log data follows:
| DEBUG: Executing python function do_unpack
| DEBUG: Executing python function base_do_unpack
| DEBUG: Unpack: creating new hg repository in
'/home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vi=
m/7.4.481-r0/vim'
| DEBUG: Running export
PATH=3D"/home/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jen=
kins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/bin/arm-oe-linux=
-gnueabi:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/qemuarm/usr/bin=
/crossscripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-lin=
ux/usr/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux=
/usr/bin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/sb=
in:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/bin:/hom=
e/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jenkins/oe/worl=
d/shr-core/bitbake/bin:/home/jenkins/bin:/usr/local/sbin:/usr/local/bin:/us=
r/sbin:/usr/bin:/sbin:/bin:/usr/games";
export HOME=3D"/home/jenkins"; /usr/bin/env hg init
/home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vim=
/7.4.481-r0/vim
| DEBUG: Unpack: updating source in
'/home/jenkins/oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vi=
m/7.4.481-r0/vim'
| DEBUG: Running export
PATH=3D"/home/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jen=
kins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/usr/bin/arm-oe-linux=
-gnueabi:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/qemuarm/usr/bin=
/crossscripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-lin=
ux/usr/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux=
/usr/bin:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/sb=
in:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_64-linux/bin:/hom=
e/jenkins/oe/world/shr-core/openembedded-core/scripts:/home/jenkins/oe/worl=
d/shr-core/bitbake/bin:/home/jenkins/bin:/usr/local/sbin:/usr/local/bin:/us=
r/sbin:/usr/bin:/sbin:/bin:/usr/games";
export HOME=3D"/home/jenkins"; /usr/bin/env hg pull
/home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim
| DEBUG: Python function base_do_unpack finished
| DEBUG: Python function do_unpack finished
| ERROR: Function failed: Fetcher failure: Fetch command failed with
exit code 255, output:
| abort: repository
/home/jenkins/oe/world/shr-core/downloads/hg/vim.googlecode.com/hg/vim
not found!
|
NOTE: recipe vim-7.4.481-r0: task do_unpack: Failed
ERROR: Task 5789
(/home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe/recipes-support/=
vim/vim_7.4.481.bb,
do_unpack) failed with exit code '1'



On Fri, May 29, 2015 at 7:46 AM, Ash Charles <ashcharles@gmail.com> wrote:

> > I wonder how did you test the patch, please ? Did you revert the patch:
> >  fetch/hg: support submodules ?
> Hi Robert,
> I tested the patch in a Yocto environment which had a prepopulated
> downloads directory. In particular, I had seen the failure described [1]
> for vim.
> My version of bitbake was slightly older so the submodule patch that was
> breaking the mirroring hadn't yet been applied.
>
> [1]
> https://www.mail-archive.com/openembedded-devel@lists.openembedded.org/ms=
g41328.html
>
> --Ash
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>

--047d7bfceb0655bb10051734f41a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FWIW: I see vim unpack failing now in world builds:<div><b=
r></div><div><pre class=3D"" style=3D"white-space:pre-wrap;word-wrap:break-=
word;margin-top:0px;margin-bottom:0px;color:rgb(51,51,51);font-size:13px">N=
OTE: recipe vim-7.4.481-r0: task do_unpack: Started
ERROR: Function failed: Fetcher failure: Fetch command failed with exit cod=
e 255, output:
abort: repository /home/jenkins/oe/world/shr-core/downloads/hg/<a href=3D"h=
ttp://vim.googlecode.com/hg/vim">vim.googlecode.com/hg/vim</a> not found!

ERROR: Logfile of failure stored in: /home/jenkins/oe/world/shr-core/tmp-gl=
ibc/work/armv5te-oe-linux-gnueabi/vim/7.4.481-r0/temp/log.do_unpack.28505
Log data follows:
| DEBUG: Executing python function do_unpack
| DEBUG: Executing python function base_do_unpack
| DEBUG: Unpack: creating new hg repository in &#39;/home/jenkins/oe/world/=
shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vim/7.4.481-r0/vim&#39;
| DEBUG: Running export PATH=3D&quot;/home/jenkins/oe/world/shr-core/openem=
bedded-core/scripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_=
64-linux/usr/bin/arm-oe-linux-gnueabi:/home/jenkins/oe/world/shr-core/tmp-g=
libc/sysroots/qemuarm/usr/bin/crossscripts:/home/jenkins/oe/world/shr-core/=
tmp-glibc/sysroots/x86_64-linux/usr/sbin:/home/jenkins/oe/world/shr-core/tm=
p-glibc/sysroots/x86_64-linux/usr/bin:/home/jenkins/oe/world/shr-core/tmp-g=
libc/sysroots/x86_64-linux/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/s=
ysroots/x86_64-linux/bin:/home/jenkins/oe/world/shr-core/openembedded-core/=
scripts:/home/jenkins/oe/world/shr-core/bitbake/bin:/home/jenkins/bin:/usr/=
local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games&quot;; e=
xport HOME=3D&quot;/home/jenkins&quot;; /usr/bin/env hg init /home/jenkins/=
oe/world/shr-core/tmp-glibc/work/armv5te-oe-linux-gnueabi/vim/7.4.481-r0/vi=
m
| DEBUG: Unpack: updating source in &#39;/home/jenkins/oe/world/shr-core/tm=
p-glibc/work/armv5te-oe-linux-gnueabi/vim/7.4.481-r0/vim&#39;
| DEBUG: Running export PATH=3D&quot;/home/jenkins/oe/world/shr-core/openem=
bedded-core/scripts:/home/jenkins/oe/world/shr-core/tmp-glibc/sysroots/x86_=
64-linux/usr/bin/arm-oe-linux-gnueabi:/home/jenkins/oe/world/shr-core/tmp-g=
libc/sysroots/qemuarm/usr/bin/crossscripts:/home/jenkins/oe/world/shr-core/=
tmp-glibc/sysroots/x86_64-linux/usr/sbin:/home/jenkins/oe/world/shr-core/tm=
p-glibc/sysroots/x86_64-linux/usr/bin:/home/jenkins/oe/world/shr-core/tmp-g=
libc/sysroots/x86_64-linux/sbin:/home/jenkins/oe/world/shr-core/tmp-glibc/s=
ysroots/x86_64-linux/bin:/home/jenkins/oe/world/shr-core/openembedded-core/=
scripts:/home/jenkins/oe/world/shr-core/bitbake/bin:/home/jenkins/bin:/usr/=
local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games&quot;; e=
xport HOME=3D&quot;/home/jenkins&quot;; /usr/bin/env hg pull /home/jenkins/=
oe/world/shr-core/downloads/hg/<a href=3D"http://vim.googlecode.com/hg/vim"=
>vim.googlecode.com/hg/vim</a>
| DEBUG: Python function base_do_unpack finished
| DEBUG: Python function do_unpack finished
| ERROR: Function failed: Fetcher failure: Fetch command failed with exit c=
ode 255, output:
| abort: repository /home/jenkins/oe/world/shr-core/downloads/hg/<a href=3D=
"http://vim.googlecode.com/hg/vim">vim.googlecode.com/hg/vim</a> not found!
|=20
NOTE: recipe vim-7.4.481-r0: task do_unpack: Failed
ERROR: Task 5789 (/home/jenkins/oe/world/shr-core/meta-openembedded/meta-oe=
/recipes-support/vim/<a href=3D"http://vim_7.4.481.bb">vim_7.4.481.bb</a>, =
do_unpack) failed with exit code &#39;1&#39;</pre><pre class=3D"" style=3D"=
white-space:pre-wrap;word-wrap:break-word;margin-top:0px;margin-bottom:0px;=
color:rgb(51,51,51);font-size:13px"><br></pre></div></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Fri, May 29, 2015 at 7:46 AM, A=
sh Charles <span dir=3D"ltr">&lt;<a href=3D"mailto:ashcharles@gmail.com" ta=
rget=3D"_blank">ashcharles@gmail.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><p><span class=3D"">&gt; I wonder how did you test the pa=
tch, please ? Did you revert the patch:<br>
&gt; =C2=A0fetch/hg: support submodules ?<br></span>
Hi Robert,<br>
I tested the patch in a Yocto environment which had a prepopulated download=
s directory. In particular, I had seen the failure described [1] for vim.<b=
r>
My version of bitbake was slightly older so the submodule patch that was br=
eaking the mirroring hadn&#39;t yet been applied.</p>
<p>[1] <a href=3D"https://www.mail-archive.com/openembedded-devel@lists.ope=
nembedded.org/msg41328.html" target=3D"_blank">https://www.mail-archive.com=
/openembedded-devel@lists.openembedded.org/msg41328.html</a></p><span class=
=3D"HOEnZb"><font color=3D"#888888">
<p>--Ash</p>
</font></span><br>--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br>
<br></blockquote></div><br></div>

--047d7bfceb0655bb10051734f41a--
