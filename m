Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com
	[209.85.213.175])
	by mail.openembedded.org (Postfix) with ESMTP id 3F77F6FF22
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 15:15:48 +0000 (UTC)
Received: by mail-ig0-f175.google.com with SMTP id 5so14986263igt.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 07:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:content-type; bh=YU+DwcztoSB6XI8w7BA15PNSkSnpjs8q3praVlc60Xk=;
	b=i5GMh2vWJSzIKABnq13Nnb5Bmc8XUlpvdI2airlkrgk24tCq0awR1+WIW2qvD47K0X
	42e/XfygNWHWiH/JkOAhNDcx5oi8Uh6q7uDHPs9cRyDjYfIbLjm1biIEdaxpSWaZdrzB
	ormkv3CLMNKtMaoEjKDOFD+7WseWOXHK7qgz/mdC1hRoI0rP49L23sHj1CFfjbElGJRT
	W00TX+P0zz2ysg9RJy1LEpB9d8FZAWLqxguW8mv3KbKFc+lrGb2KopeHQJ3nW/n8kzs+
	bx/FiOlk8SLVTIDVNDfGjdFnBUcEgeBX+gGCYhWAKSGIzWPAnXlMmKdbytZ24jAjLDjK
	USoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:content-type;
	bh=YU+DwcztoSB6XI8w7BA15PNSkSnpjs8q3praVlc60Xk=;
	b=mms75wFzoR/yZMTmB/irpetVR1ECdRj5yld9RpjgWZHzUFy2iQb/nHKsFvVdg8SwGs
	PD8BpCCdMNcWk7JRUnAIGfy0sFstUNyNXyUDhW0895qZ3blfo+W9Ju65P+PQgWBzv9SF
	dYd4rthuVsn+HI5Q60VyGfBM4dLxfKJB0R7k4e0DnO98pYcu1BRkW+jUgoAAoVBtZefx
	426JYZbmmaWEsY8gLHYtfyrsicyXSjTDpH5R5s93ex2rm98Lz0whxfjnAhJZSLa2Nn3c
	Dm5pDJYQlkO/gshP0nVvlByfxdeFbf5Jh/VezV5ec6KRAXy8qN0TTgkK4a0kFawku3ie
	5rzA==
X-Gm-Message-State: AG10YOQBJdAZJbmB+tO5fot3yRsKjG6iwgPIo1/xi+inVAADbuTRIp71Ru7OMdE5Sw2/PU7Dw1TLttudrSAkZA==
X-Received: by 10.50.64.179 with SMTP id p19mr3714543igs.25.1455808549626;
	Thu, 18 Feb 2016 07:15:49 -0800 (PST)
MIME-Version: 1.0
References: <1455795267-8780-1-git-send-email-ismo.puustinen@intel.com>
In-Reply-To: <1455795267-8780-1-git-send-email-ismo.puustinen@intel.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 18 Feb 2016 15:15:39 +0000
Message-ID: <CABcZANnMqu-Q-ZYUa34ovJZeJ4pWr5NOeTh_e-_0HUZG1MeEdw@mail.gmail.com>
To: Ismo Puustinen <ismo.puustinen@intel.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Do not suggest PREFERRED_PROVIDER for runtime providers.
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
X-List-Received-Date: Thu, 18 Feb 2016 15:15:49 -0000
Content-Type: multipart/alternative; boundary=047d7bd75cec762b25052c0cd741

--047d7bd75cec762b25052c0cd741
Content-Type: text/plain; charset=UTF-8

On Thu, Feb 18, 2016 at 4:34 AM Ismo Puustinen <ismo.puustinen@intel.com>
wrote:

> PREFERRED_PROVIDER affects only build-time dependencies. Do not suggest
> the user to set it if the multiple providers are for runtime packages.
>
> Signed-off-by: Ismo Puustinen <ismo.puustinen@intel.com>
>

This is incorrect. Build provider preferences affect runtime provider
resolution. It'd be better if we used a separate variable for it, but
that's not the case now.

--047d7bd75cec762b25052c0cd741
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, Feb 18=
, 2016 at 4:34 AM Ismo Puustinen &lt;<a href=3D"mailto:ismo.puustinen@intel=
.com">ismo.puustinen@intel.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">PREFERRED_PROVIDER affects only build-time dependencies. Do not =
suggest<br>
the user to set it if the multiple providers are for runtime packages.<br>
<br>
Signed-off-by: Ismo Puustinen &lt;<a href=3D"mailto:ismo.puustinen@intel.co=
m" target=3D"_blank">ismo.puustinen@intel.com</a>&gt;<br></blockquote><div>=
<br></div><div>This is incorrect. Build provider preferences affect runtime=
 provider resolution. It&#39;d be better if we used a separate variable for=
 it, but that&#39;s not the case now.</div></div></div>

--047d7bd75cec762b25052c0cd741--
