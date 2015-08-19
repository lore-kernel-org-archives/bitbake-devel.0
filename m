Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f196.google.com (mail-ig0-f196.google.com
	[209.85.213.196])
	by mail.openembedded.org (Postfix) with ESMTP id 974E260043
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 01:41:43 +0000 (UTC)
Received: by igdx6 with SMTP id x6so10580206igd.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 18:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=i1ioYp4+uScCmRVNG2n9t7YruKYY1R1re7y9vQE/COA=;
	b=y6OtggLFVVDd2qvEdvqSlKp3BtO37R3dWvBj7xOrX5dCtBt5hNWvI5qPlYSG0Yo/kI
	KslpezGcQjhz2H5Zk0tJAn50cUahrMHIeQqAw2wqCoz+jALDmcarwzbIZJoa9NoZoZnM
	PWeXaFeaIsBmIuJo9TKkv3kBEo26rKtC5OPe1BtWfl/qd89N26NWBn3U5/WJn+qLfVLD
	GWdImJG/39Wb2sdiVfHC3PQR+IWile3qLK/UxWt2DAi7sAZUWqRIh+aOKGPeMgSdYOs8
	sVIGG7Z8zOmuXEcj3ty8pkASWnfJuMWGlYD03eedFNDzJxwBJSPPuH6CQFMHo6IUMxpJ
	8Oxg==
X-Received: by 10.50.103.71 with SMTP id fu7mr26774007igb.38.1439948503369;
	Tue, 18 Aug 2015 18:41:43 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.118.150 with HTTP; Tue, 18 Aug 2015 18:41:23 -0700 (PDT)
In-Reply-To: <f87bc73e473e8b69734b18d5fb7512af90ed7a49.1439935538.git.avery.brian@gmail.com>
References: <cover.1439935538.git.avery.brian@gmail.com>
	<f87bc73e473e8b69734b18d5fb7512af90ed7a49.1439935538.git.avery.brian@gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 18 Aug 2015 18:41:23 -0700
X-Google-Sender-Auth: D46d3udencfm33QSEPmurjZ4Pvw
Message-ID: <CABcZANn4Jzrb727wz1A=90EiMhk+KEweASe+Vjg+2Ge5i=zP7Q@mail.gmail.com>
To: brian avery <avery.brian@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake: toastergui: Call csrf function in all pages to ensure cookie is sent
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
X-List-Received-Date: Wed, 19 Aug 2015 01:41:46 -0000
Content-Type: multipart/alternative; boundary=047d7b2e11e709cffb051da02301

--047d7b2e11e709cffb051da02301
Content-Type: text/plain; charset=UTF-8

On Tue, Aug 18, 2015 at 3:11 PM, brian avery <avery.brian@gmail.com> wrote:

> From: Michael Wood <michael.g.wood@intel.com>
>
> Not all pages call the csrf token template function so django does not
> bother to send the cookike, this meant that all subsequent ajax calls
> fail. So add this to the base template.
>
> [YOCTO #8175]
>
> Signed-off-by: Michael Wood <michael.g.wood@intel.com>
> Signed-off-by: brian avery <avery.brian@gmail.com>
>

Patches sent to bitbake-devel shouldn't have the 'bitbake:' commit subject
prefix, that's only appropriate in poky.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b2e11e709cffb051da02301
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Aug 18, 2015 at 3:11 PM, brian avery <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:avery.brian@gmail.com" target=3D"_blank">avery.brian@gmail.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":4f9" class=3D=
"a3s" style=3D"overflow:hidden">From: Michael Wood &lt;<a href=3D"mailto:mi=
chael.g.wood@intel.com">michael.g.wood@intel.com</a>&gt;<br>
<br>
Not all pages call the csrf token template function so django does not<br>
bother to send the cookike, this meant that all subsequent ajax calls<br>
fail. So add this to the base template.<br>
<br>
[YOCTO #8175]<br>
<br>
Signed-off-by: Michael Wood &lt;<a href=3D"mailto:michael.g.wood@intel.com"=
>michael.g.wood@intel.com</a>&gt;<br>
Signed-off-by: brian avery &lt;<a href=3D"mailto:avery.brian@gmail.com">ave=
ry.brian@gmail.com</a>&gt;</div></blockquote></div><br>Patches sent to bitb=
ake-devel shouldn&#39;t have the &#39;bitbake:&#39; commit subject prefix, =
that&#39;s only appropriate in poky.<br>-- <br><div class=3D"gmail_signatur=
e">Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake, O=
penEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, =
Mentor Graphics</div>
</div></div>

--047d7b2e11e709cffb051da02301--
