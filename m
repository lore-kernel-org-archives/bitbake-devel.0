Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
	[209.85.213.180])
	by mail.openembedded.org (Postfix) with ESMTP id 63CB475E81
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 17:51:54 +0000 (UTC)
Received: by igfj19 with SMTP id j19so12113857igf.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=+UwwzM8hKDP5daH7dVoZ65Fs+7i5A48Ydy69ovol4dk=;
	b=ifQuNr+N860pk0xDx78xOt52W0cSgWsF6xMfOiJs+2kBrC8yWD5xGHhKndrBbT7aHx
	wufBFLWBXi7qEOh90RMIKJpXQbcZx7qLArS6BPpu7KDjdXMyyhjyqNneixLCr2NlBOnV
	77ThQSR7tMj3lyVp/Mf9JPJjzlriNAXb7e74iJ2lBffr1p1cJ+b+Xou9zwuxvKZwCegd
	t0rR/p+7zCVRLgsafklf42lBQkcvoEP2dqarZYEwTi7xpVtAeEitsa+7Oqpoh9W0iExF
	S9/881Xh+ccHnlE+aObgLRe5ASQevRSVwPwXr0fU7jX+AVpiikNYvvmt3qK1+uSF+bL1
	wU1w==
X-Received: by 10.50.50.69 with SMTP id a5mr28526511igo.68.1440006714299; Wed,
	19 Aug 2015 10:51:54 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.118.150 with HTTP; Wed, 19 Aug 2015 10:51:35 -0700 (PDT)
In-Reply-To: <9c6e61aab76b3cfad015aab68864bd1f920d9732.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
	<9c6e61aab76b3cfad015aab68864bd1f920d9732.1439990327.git.paul.eggleton@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 19 Aug 2015 10:51:35 -0700
X-Google-Sender-Auth: xyrBeQgHjSQIf4esOHBAutNn4lg
Message-ID: <CABcZANk5hNk0_gWucHdoHWe7m5h0O_tdZ0swJgNhtUGGBy1tNg@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/4] bitbake-layers: remove-layer: accept just layer directory
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
X-List-Received-Date: Wed, 19 Aug 2015 17:51:58 -0000
Content-Type: multipart/alternative; boundary=089e010d9e9eae27c6051dadb07a

--089e010d9e9eae27c6051dadb07a
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 19, 2015 at 6:20 AM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> If the specified layer isn't a path, then just match on the directory.
>
> Fixes [YOCTO #7839].
>
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  bin/bitbake-layers | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/bin/bitbake-layers b/bin/bitbake-layers
> index a0227d4..1b4694b 100755
> --- a/bin/bitbake-layers
> +++ b/bin/bitbake-layers
> @@ -120,6 +120,8 @@ Removes the specified layer from bblayers.conf
>
>          if args.layerdir.startswith('*'):
>              layerdir = args.layerdir
> +        elif not '/' in args.layerdir:
> +            layerdir = '*/%s' % args.layerdir
>          else:
>              layerdir = os.path.abspath(args.layerdir)
>          (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf,
> None, layerdir)
>

Shouldn't this check to see if args.layerdir is an existing path, instead?
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e010d9e9eae27c6051dadb07a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Aug 19, 2015 at 6:20 AM, Paul Eggleton <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton@=
linux.intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><di=
v id=3D":12y" class=3D"a3s" style=3D"overflow:hidden">If the specified laye=
r isn&#39;t a path, then just match on the directory.<br>
<br>
Fixes [YOCTO #7839].<br>
<br>
Signed-off-by: Paul Eggleton &lt;<a href=3D"mailto:paul.eggleton@linux.inte=
l.com">paul.eggleton@linux.intel.com</a>&gt;<br>
---<br>
=C2=A0bin/<span class=3D"il">bitbake</span>-layers | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/bin/<span class=3D"il">bitbake</span>-layers b/bin/<span class=
=3D"il">bitbake</span>-layers<br>
index a0227d4..1b4694b 100755<br>
--- a/bin/<span class=3D"il">bitbake</span>-layers<br>
+++ b/bin/<span class=3D"il">bitbake</span>-layers<br>
@@ -120,6 +120,8 @@ Removes the specified layer from bblayers.<span class=
=3D"il">conf</span><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if args.layerdir.startswith(&#39;*&#39;):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layerdir =3D args.layerdir<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif not &#39;/&#39; in args.layerdir:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layerdir =3D &#39;*/%s&#39; % ar=
gs.layerdir<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layerdir =3D os.path.abspat=
h(args.layerdir)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(_, notremoved) =3D <span class=3D"il">bb=
</span>.utils.edit_bblayers_conf(bblayers_conf, None, layerdir)</div></bloc=
kquote></div><br>Shouldn&#39;t this check to see if args.layerdir is an exi=
sting path, instead?<br>-- <br><div class=3D"gmail_signature">Christopher L=
arson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, Ope=
nZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics<=
/div>
</div></div>

--089e010d9e9eae27c6051dadb07a--
