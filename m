Return-Path: <alexandru.damian@intel.com>
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id 651B573C8C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 May 2015 16:18:20 +0000 (UTC)
Received: by iepj10 with SMTP id j10so14904849iep.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 May 2015 09:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=3SpkSnoiJfAFL3wzpsG4Wgm27+RYVzOrufaGLFUDwpI=;
	b=KktqDE6x/A4A3vEfP5JrICJurwmM57TCUAj1p+KVaQpjg3QIwCytN4fkuYcWcoHdF/
	DO3WASEJmbAD2J3AAdcer4y9HS01py9jSr71omeVc/OCIiZO9568oNGMud9YUew+UNzd
	vXwl616zPzlpi04i792VAA6dkN3Annfnp+ev9fmKZhJ3araLb5AT/cvanH96hnGtnPpA
	YMA1Nlff53lUtrjtKQwciBoaxCu7BKBKn3lPlSeoQ/ehewXWbRpQMy91WP4jV2xIPu9Q
	qSmSNAqUjgvETdQnyZe3Kr5kv9BX4a7MkDTKEY9v5yT2E4qQxsbbfq7WObm/fofzh/Wq
	U5QQ==
X-Gm-Message-State: ALoCoQmttKipCFu6n+6wCMGw4z0gz3Tmw2ebSAEqoQWQR5WQhUVOkzfhPM9/Mlu8zpG8hgdRvRH6
X-Received: by 10.42.200.8 with SMTP id eu8mr3355228icb.65.1430929101108; Wed,
	06 May 2015 09:18:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.10.67 with HTTP; Wed, 6 May 2015 09:18:00 -0700 (PDT)
In-Reply-To: <cover.1430498382.git.alexandru.damian@intel.com>
References: <cover.1430498382.git.alexandru.damian@intel.com>
From: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 6 May 2015 17:18:00 +0100
Message-ID: <CAJ2CSBsjoXBx+R3LkV8UppqcQx18gxfnq49dGmkc0YxSJ4u68g@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/7] toaster patchset
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
X-List-Received-Date: Wed, 06 May 2015 16:18:22 -0000
Content-Type: multipart/alternative; boundary=90e6ba6148d2c5496705156c2480

--90e6ba6148d2c5496705156c2480
Content-Type: text/plain; charset=UTF-8

Hello,

I've just noticed that the patch email never arrived, not sure why.

Can you please pull from the contrib branch ?

Thank you,
Alex

On Fri, May 1, 2015 at 5:40 PM, Alex DAMIAN <alexandru.damian@intel.com>
wrote:

> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> Hello,
>
> This is a toaster patchset adding UI and build logger fixes.
>
> Cheers,
> Alex
>
> The following changes since commit
> f8590547a198a78334debdf14bf40acb50c22ecc:
>
>   bitbake: reset build mtime cache before the build (2015-04-28 22:28:45
> +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib adamian/20150501-submission-bb
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150501-submission-bb
>
> Alexandru DAMIAN (2):
>   toasterui: proper exit code on toaster errors
>   toasterui: close build on BuildCompleted event
>
> Michael Wood (5):
>   toaster: Move project context variables to common scope
>   toaster: projectapp Implement machine select command
>   toaster: Refactor and expand layer add remove mechanism
>   toaster: Add links to the layer add notification
>   toaster: filtersnippet remove redefinition of filter type key
>
>  bin/toaster-eventreplay                            |  13 +-
>  lib/bb/ui/buildinfohelper.py                       |   5 +-
>  lib/bb/ui/toasterui.py                             |  45 +++--
>  lib/toaster/orm/views.py                           |   8 +-
>  lib/toaster/toastergui/static/css/default.css      |   2 +-
>  .../toastergui/static/html/layer_deps_modal.html   |  17 ++
>  lib/toaster/toastergui/static/js/base.js           |  39 ++--
>  lib/toaster/toastergui/static/js/filtersnippet.js  |   3 +-
>  lib/toaster/toastergui/static/js/importlayer.js    |  20 +-
>  lib/toaster/toastergui/static/js/layerBtn.js       |  63 ++++++
>  lib/toaster/toastergui/static/js/layerDepsModal.js |  90 +++++++++
>  lib/toaster/toastergui/static/js/layerdetails.js   |  99 ++-------
>  lib/toaster/toastergui/static/js/libtoaster.js     |  96 ++++++++-
>  lib/toaster/toastergui/static/js/machines.js       |  97 ---------
>  lib/toaster/toastergui/static/js/projectapp.js     |  31 ++-
>  lib/toaster/toastergui/templates/base.html         |  19 +-
>  lib/toaster/toastergui/templates/importlayer.html  |   6 +-
>  lib/toaster/toastergui/templates/layerdetails.html |   9 +-
>  lib/toaster/toastergui/templates/layers.html       | 223
> +++------------------
>  .../toastergui/templates/layers_dep_modal.html     |  99 ---------
>  lib/toaster/toastergui/templates/machines.html     |  36 ++--
>  lib/toaster/toastergui/templates/targets.html      | 220
> ++++----------------
>  lib/toaster/toastergui/views.py                    |   2 +-
>  23 files changed, 471 insertions(+), 771 deletions(-)
>  create mode 100644
> lib/toaster/toastergui/static/html/layer_deps_modal.html
>  create mode 100644 lib/toaster/toastergui/static/js/layerBtn.js
>  create mode 100644 lib/toaster/toastergui/static/js/layerDepsModal.js
>  delete mode 100644 lib/toaster/toastergui/static/js/machines.js
>  delete mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.html
>
> --
> 1.9.1
>
>


-- 
Alex Damian
Yocto Project
SSG / OTC

--90e6ba6148d2c5496705156c2480
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:tahoma,s=
ans-serif">Hello,</div><div class=3D"gmail_default" style=3D"font-family:ta=
homa,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:tahoma,sans-serif">I&#39;ve just noticed that the patch email never arriv=
ed, not sure why.</div><div class=3D"gmail_default" style=3D"font-family:ta=
homa,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-famil=
y:tahoma,sans-serif">Can you please pull from the contrib branch ?</div><di=
v class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif"><br></div=
><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-serif">Thank=
 you,</div><div class=3D"gmail_default" style=3D"font-family:tahoma,sans-se=
rif">Alex</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, May 1, 2015 at 5:40 PM, Alex DAMIAN <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:alexandru.damian@intel.com" target=3D"_blank">alexandru.damian=
@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Al=
exandru DAMIAN &lt;<a href=3D"mailto:alexandru.damian@intel.com">alexandru.=
damian@intel.com</a>&gt;<br>
<br>
Hello,<br>
<br>
This is a toaster patchset adding UI and build logger fixes.<br>
<br>
Cheers,<br>
Alex<br>
<br>
The following changes since commit f8590547a198a78334debdf14bf40acb50c22ecc=
:<br>
<br>
=C2=A0 bitbake: reset build mtime cache before the build (2015-04-28 22:28:=
45 +0100)<br>
<br>
are available in the git repository at:<br>
<br>
=C2=A0 git://<a href=3D"http://git.yoctoproject.org/poky-contrib" target=3D=
"_blank">git.yoctoproject.org/poky-contrib</a> adamian/20150501-submission-=
bb<br>
=C2=A0 <a href=3D"http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=
=3Dadamian/20150501-submission-bb" target=3D"_blank">http://git.yoctoprojec=
t.org/cgit.cgi/poky-contrib/log/?h=3Dadamian/20150501-submission-bb</a><br>
<br>
Alexandru DAMIAN (2):<br>
=C2=A0 toasterui: proper exit code on toaster errors<br>
=C2=A0 toasterui: close build on BuildCompleted event<br>
<br>
Michael Wood (5):<br>
=C2=A0 toaster: Move project context variables to common scope<br>
=C2=A0 toaster: projectapp Implement machine select command<br>
=C2=A0 toaster: Refactor and expand layer add remove mechanism<br>
=C2=A0 toaster: Add links to the layer add notification<br>
=C2=A0 toaster: filtersnippet remove redefinition of filter type key<br>
<br>
=C2=A0bin/toaster-eventreplay=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 +-<br>
=C2=A0lib/bb/ui/buildinfohelper.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
=C2=A0lib/bb/ui/toasterui.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 45 +++--=
<br>
=C2=A0lib/toaster/orm/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +-<br>
=C2=A0lib/toaster/toastergui/static/css/default.css=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0.../toastergui/static/html/layer_deps_modal.html=C2=A0 =C2=A0|=C2=A0 =
17 ++<br>
=C2=A0lib/toaster/toastergui/static/js/base.js=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 39 ++--<br>
=C2=A0lib/toaster/toastergui/static/js/filtersnippet.js=C2=A0 |=C2=A0 =C2=
=A03 +-<br>
=C2=A0lib/toaster/toastergui/static/js/importlayer.js=C2=A0 =C2=A0 |=C2=A0 =
20 +-<br>
=C2=A0lib/toaster/toastergui/static/js/layerBtn.js=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 63 ++++++<br>
=C2=A0lib/toaster/toastergui/static/js/layerDepsModal.js |=C2=A0 90 +++++++=
++<br>
=C2=A0lib/toaster/toastergui/static/js/layerdetails.js=C2=A0 =C2=A0|=C2=A0 =
99 ++-------<br>
=C2=A0lib/toaster/toastergui/static/js/libtoaster.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 96 ++++++++-<br>
=C2=A0lib/toaster/toastergui/static/js/machines.js=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 97 ---------<br>
=C2=A0lib/toaster/toastergui/static/js/projectapp.js=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 31 ++-<br>
=C2=A0lib/toaster/toastergui/templates/base.html=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 19 +-<br>
=C2=A0lib/toaster/toastergui/templates/importlayer.html=C2=A0 |=C2=A0 =C2=
=A06 +-<br>
=C2=A0lib/toaster/toastergui/templates/layerdetails.html |=C2=A0 =C2=A09 +-=
<br>
=C2=A0lib/toaster/toastergui/templates/layers.html=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 223 +++------------------<br>
=C2=A0.../toastergui/templates/layers_dep_modal.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 99 ---------<br>
=C2=A0lib/toaster/toastergui/templates/machines.html=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 36 ++--<br>
=C2=A0lib/toaster/toastergui/templates/targets.html=C2=A0 =C2=A0 =C2=A0 | 2=
20 ++++----------------<br>
=C2=A0lib/toaster/toastergui/views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A023 files changed, 471 insertions(+), 771 deletions(-)<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/html/layer_deps_moda=
l.html<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/layerBtn.js<br>
=C2=A0create mode 100644 lib/toaster/toastergui/static/js/layerDepsModal.js=
<br>
=C2=A0delete mode 100644 lib/toaster/toastergui/static/js/machines.js<br>
=C2=A0delete mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.=
html<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.9.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr">Alex Damian<div>Yocto Pro=
ject<br></div><div>SSG / OTC=C2=A0</div></div></div>
</div>

--90e6ba6148d2c5496705156c2480--
