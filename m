Return-Path: <ross.burton@intel.com>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
	[209.85.223.175])
	by mail.openembedded.org (Postfix) with ESMTP id CA8E777190
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 14:41:25 +0000 (UTC)
Received: by mail-io0-f175.google.com with SMTP id d63so19152589ioj.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Feb 2016 06:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=8uF9T5caug0HQvdW4fd5Rp6wWu7IZdlY7jQjtZk8R2k=;
	b=aQX3/d61MAsuLktuQ0gvFaLbnpFZ+CHzU6DnGuFVw4QVl2VRhfsu5FLgPfbOvpCjYu
	PAm9D5lNdBDVhnqjdZ574cL/kZOLGq8MfVPJ9g/Djrr1UdAmyj8ZBM8wB5jqpuNIh9BJ
	tmwyaysdhaJD94/5j3a/d51HXsEOOW4pzCHWtkm+YvJTFhLVObs1wLuAvnuNoW8FA0zA
	6fz7sn5yvL7ppCyxjJ8YIdHBjGX/vt8IrxPLztbbJzBNZvq8JHkGNYw2cMCgKyXgncgY
	PSk6m4+IiHw4XH8rIGPKvEBz/Z5o/sR3Y+0fyLZDlwFLIrFNqePWo8kVBx895vDReTu9
	GO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=8uF9T5caug0HQvdW4fd5Rp6wWu7IZdlY7jQjtZk8R2k=;
	b=Pr+cV99Y99lBvcQKZcSOTUAcX+2sl5fcONSWRmY1ipWhiFwDhR3FbYhzjLs+JJdUpH
	tDkmarcxt4aRwtwiz/uRhDBvJu7in31zTI0I/cY8DmZ/xtFzm3KQzTMn6ru06N6k8lCa
	aqqaClG95QcsTQPPuaB/jpTg4d3Ei+7GbUgBpYWdJVkAW/wMpVnTwkJM6fHIEDI5UCUt
	UrOymVyYzNu4f0/LGENsMXiDHDajpSr8ahSjUbO1rffMH5ysmBKGoTp4CyqJ6Sil336k
	fPBD+ev3Rvd6l3AHJBILOPROdoCipC8UBcOz5XD45CUBcAX5laiHcLdXcZU+M3u/1Uiz
	vyxA==
X-Gm-Message-State: AG10YOTJz5mjwxT6gVdnbP1oiQu9uz6yNEQGdnyM+bXNvqkdgGgByY+TaQQR4nmrgTxU6BKc9YtO0uYlZWIqQZUl
X-Received: by 10.107.10.157 with SMTP id 29mr15703936iok.133.1454424086769;
	Tue, 02 Feb 2016 06:41:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.162.70 with HTTP; Tue, 2 Feb 2016 06:41:07 -0800 (PST)
In-Reply-To: <1454422078.27087.76.camel@linuxfoundation.org>
References: <1454422078.27087.76.camel@linuxfoundation.org>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Tue, 2 Feb 2016 14:41:07 +0000
Message-ID: <CAJTo0LanTJT6B4YJ6=xfetCSi882LOBAd5P0gNXeXyC=pqiJLQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] [PATCH] build/data: Don't expand python functions before execution [API change]
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
X-List-Received-Date: Tue, 02 Feb 2016 14:41:26 -0000
Content-Type: multipart/alternative; boundary=001a113f8df80b870f052aca7f8f

--001a113f8df80b870f052aca7f8f
Content-Type: text/plain; charset=UTF-8

On 2 February 2016 at 14:07, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> I propose we default to not expanding python code and then deal with
> any consequences from that if/as/where identified. This will improve
> new user understanding and usability of the system, it also allows
> several long standing weird expansion issues to be fixed.
>

As someone who has had to write classes that do "$" + "{FOO}", this gets a
massive +1 from me.

Ross

--001a113f8df80b870f052aca7f8f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On 2 February 2016 at 14:07, Ri=
chard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:richard.purdie@linuxfo=
undation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<=
/span> wrote:<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div id=3D":41t" class=3D"a3s" style=3D"overflow:hidden">I propose we defau=
lt to not expanding python code and then deal with<br>
any consequences from that if/as/where identified. This will improve<br>
new user understanding and usability of the system, it also allows<br>
several long standing weird expansion issues to be fixed.</div></blockquote=
></div><br>As someone who has had to write classes that do &quot;$&quot; + =
&quot;{FOO}&quot;, this gets a massive +1 from me.</div><div class=3D"gmail=
_extra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a113f8df80b870f052aca7f8f--
