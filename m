Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
	[209.85.220.174])
	by mail.openembedded.org (Postfix) with ESMTP id 4528F60102
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jun 2017 10:05:50 +0000 (UTC)
Received: by mail-qk0-f174.google.com with SMTP id d14so53385155qkb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jun 2017 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Leo9pk94Hu5X+T4G0E5zz0pb/efSusKkMVs7XrNwba4=;
	b=uY1x5bkcn1onOX5XE/xvK/4RlmEWp2oZ7o8GzZ40zxLLKU16t9pApqYQVwZhOmtBLu
	y3cuEsdcr3OZEO5E/9/IildzpG5KZMwvVHmdFo/hKA38z2JL28L3AXJ61i/5QVPzUxmN
	ESU6u8VcC4Q6mtIpoO02VIdmbfF29CHCAiWiCbQMzkrkQ7LRS4dOqblOD1yVNhXW8Sd7
	2gSZ/QDLR8oHlTd9nS7WuHPa88RdvtehMFcU4ZW6VPewjfIBpfhLhLnuKpTTLUtaiWv7
	GKCZQ3e4kMdbHsYStLoM68HEpTQ1XsEWrY+WenBq2wxmjoeR1eaw4kiw+1J4apTTAvy1
	nVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Leo9pk94Hu5X+T4G0E5zz0pb/efSusKkMVs7XrNwba4=;
	b=CVYCjgxkiT14bdSu6VrcQ92tUwWMs2y9glTpzmWNVkqqi6AUifNSwTtjB/QZ5fuCOG
	PzbHhdPxEPxunE87WfZHFCg0ftZVeLJw5DVg6SHD17L1I4rSGjKhWXEIAqbOQajaX4FB
	TS5Q8MctDdqvHVQhfCUCXeurcIO9DwRwiT8BniFeRKHKvdzuoDPXid1Zp5E50jDpS0Xy
	pvJqY7jV3CaJNgvEhI9R2cTcDujPdLXcOH83bSXbBnuOgGR1PnWLGNPhaZt6076PZDX1
	hcK1R0B8rREiZvWNupJE1xNGRxkMjLnH46gAfoXLFEGt40cHDrHTQEkT6pJlAn3YIzHK
	w5Zw==
X-Gm-Message-State: AKS2vOwlrRlNZlgsh4ZDC8UI3YaycqWAoyWtOYRsTKUhJfJMOziGEifF
	6eL9l4koKCQTkvC/WhJNoIV7Qmn1+xhT
X-Received: by 10.55.140.193 with SMTP id o184mr33614826qkd.127.1497953152227; 
	Tue, 20 Jun 2017 03:05:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.35.103 with HTTP; Tue, 20 Jun 2017 03:05:31 -0700 (PDT)
In-Reply-To: <1497934470-12092-1-git-send-email-garbados@gmail.com>
References: <1497934470-12092-1-git-send-email-garbados@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 20 Jun 2017 11:05:31 +0100
Message-ID: <CAJTo0LYy-VBcrqnx4k2uF5nETq2bhf75vdpMvxZ7mKrU1du93g@mail.gmail.com>
To: Diana Thayer <garbados@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake : Paginate 'bitbake -e' using less.
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
X-List-Received-Date: Tue, 20 Jun 2017 10:05:51 -0000
Content-Type: multipart/alternative; boundary="001a114f0ce88770520552616503"

--001a114f0ce88770520552616503
Content-Type: text/plain; charset="UTF-8"

On 20 June 2017 at 05:54, Diana Thayer <garbados@gmail.com> wrote:

> +        pager = subprocess.Popen(['less', '-F', '-R', '-S', '-X', '-K'],
> +                                 stdin=subprocess.PIPE,
> +                                 stdout=sys.stdout,
> +                                 universal_newlines=True)
>

What if I'm piping bitbake -e though grep or into a file already?

Ross

--001a114f0ce88770520552616503
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 20 June 2017 at 05:54, Diana Thayer <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:garbados@gmail.com" target=3D"_blank">garbados@gmail.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div id=3D":9ou" class=3D"a3s aXj=
CH m15cc3dafa83f5ef0">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pager =3D subprocess.Pop=
en([&#39;less&#39;, &#39;-F&#39;, &#39;-R&#39;, &#39;-S&#39;, &#39;-X&#39;,=
 &#39;-K&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdin=3Dsubprocess.PIPE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stdout=3Dsys.stdout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0universal_newlines=3DTrue)<br>=
</div></blockquote></div><br>What if I&#39;m piping bitbake -e though grep =
or into a file already?</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">Ross</div></div>

--001a114f0ce88770520552616503--
