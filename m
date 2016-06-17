Return-Path: <elliot.smith@intel.com>
Received: from mail-yw0-f178.google.com (mail-yw0-f178.google.com
	[209.85.161.178])
	by mail.openembedded.org (Postfix) with ESMTP id 237F273174
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jun 2016 09:55:49 +0000 (UTC)
Received: by mail-yw0-f178.google.com with SMTP id v78so3168727ywa.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jun 2016 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:date:message-id:subject:from:to;
	bh=+fT5Zei9RtM44zs+INUr5L4/Wd6QS61Wi2/ehkf9hEc=;
	b=pK2AKWKI9yMn0JLGski9lcJGMxHQdIOakEopimVf2jLRJdU0kPG1KrjDBMfSS49AGm
	jOBYGXH6lB8HKHsfuaJ/fdTJszRpdjyN+lO9MvsN+8FVDJ2o5+eLcPzltFe8mBzkVE3A
	BOkADj/BD76gDex+VDS3ZD3iTIacTd8JgFYWFMSOVbeTYhd0N5GJQRmMCPXmmfwXnBX9
	k418lvxeI5JZKnO1RJDZXH2nJM+nPcoO4K2s0WCf8KjDyO2PqxERDggr0n+/CeXYHyOc
	dCoz2K8CDOpvSdz42dAX7WC9lWxUtrasb1A4Tjm9PwxURjofYR5xTy+5tnwev9ybu8wq
	I2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
	bh=+fT5Zei9RtM44zs+INUr5L4/Wd6QS61Wi2/ehkf9hEc=;
	b=J4sAt6e53+hyK6sntqaq9+nVOkmGkmWzuv2/TsPkuuvCyDEIugPU/kpQJOzRjhmHae
	qnvkt5/J2DmNUFNGg2yJYt3SfFH/v3vnbXlRGAzdQwdrp9cD/u7mWMigueTXtpx8xYvN
	xA7SapJqp8wxf3ugMxOrrMZPrHrUwcj2ITl0KvOcZfFqJBn65wKdA5xI5jdGtpcFgCPn
	PSfdXpenHH4rn3rhWmNm9RsLz0LGiWWNikY5E2E1EYY9pxngcBgYM/d5KfyMrSgZWSA+
	CS0W5bTKigAlVEudqErbl3GOXJ9Tr3j0cdlAjlvLR0Us6vqiTVlK517ViYLkZCJDzSZ3
	Iuhg==
X-Gm-Message-State: ALyK8tL7j/EL25MSdIq0PJID+5UxUUltliT+wKqw0md5s4YqOXNIzzj6sXhvyYN6wiqcqIJ7yQJI6OjlxClbHKDD
MIME-Version: 1.0
X-Received: by 10.37.223.66 with SMTP id w63mr532931ybg.172.1466157349960;
	Fri, 17 Jun 2016 02:55:49 -0700 (PDT)
Received: by 10.13.198.193 with HTTP; Fri, 17 Jun 2016 02:55:49 -0700 (PDT)
Date: Fri, 17 Jun 2016 10:55:49 +0100
Message-ID: <CA+1hgUju+pA1c--e=uJervsuEsKA7y_422b0KowkZ8EBejqreQ@mail.gmail.com>
From: "Smith, Elliot" <elliot.smith@intel.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: [PULL] remove last Bootstrap 2 file for Toaster
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
X-List-Received-Date: Fri, 17 Jun 2016 09:55:51 -0000
Content-Type: multipart/alternative; boundary=94eb2c08835c07afb90535765c93

--94eb2c08835c07afb90535765c93
Content-Type: text/plain; charset=UTF-8

The branch

poky-contrib, elliot/submit/bavery/toaster/removeLastBootstrapV2File

contains a single commit for inclusion in master:

f7d8db806167e8d3628456fe8b021cac8b0b6643

(The patch for this commit has lines longer than 998 characters so could
not be submitted as a single patch.)

This commit removes that file.(It is not used afaik, but it does have a
reference to bootstrap v2, which we are no longer supporting).

Elliot

-- 
Elliot Smith
Software Engineer
Intel Open Source Technology Centre

--94eb2c08835c07afb90535765c93
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"font-size:12.8px">The branch</span></d=
iv><div><span style=3D"font-size:12.8px"><br></span></div><div><span style=
=3D"font-size:12.8px">poky-contri</span><span style=3D"font-size:12.8px">b,=
 elliot/submit/bavery/toaster/r</span><span style=3D"font-size:12.8px">emov=
eLastBootstrapV2File</span></div><div><span style=3D"font-size:12.8px"><br>=
</span></div><div><span style=3D"font-size:12.8px">contains a single commit=
 for inclusion in master:</span></div><div><span style=3D"font-size:12.8px"=
><br></span></div><div><span style=3D"font-size:12.8px">f7d8db806167e8d3628=
456fe8b021cac8b0b6643</span><br></div><div><span style=3D"font-size:12.8px"=
><br></span></div><div><span style=3D"font-size:12.8px">(The patch for this=
 commit</span><span style=3D"font-size:12.8px">=C2=A0has lines longer than =
998 characters so could not be submitted as a single patch.)</span></div><d=
iv><span style=3D"font-size:12.8px"><br></span></div><div><span style=3D"fo=
nt-size:12.8px">This commit removes that file.(It is not used afaik, but it=
 does=C2=A0</span><span style=3D"font-size:12.8px">have a reference to boot=
strap v2, which we are no longer supporting).</span></div><div><span style=
=3D"font-size:12.8px"><br></span></div><div><span style=3D"font-size:12.8px=
">Elliot</span></div><div><br></div>-- <br><div class=3D"gmail_signature" d=
ata-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Elliot Smith<br>Sof=
tware Engineer<br>Intel Open Source Technology Centre</div></div></div>
</div>

--94eb2c08835c07afb90535765c93--
