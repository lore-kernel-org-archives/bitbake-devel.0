Return-Path: <martin.jansa@gmail.com>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
	[209.85.208.67])
	by mail.openembedded.org (Postfix) with ESMTP id 8F0B57E6D5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2019 22:43:46 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id a14so12666315edv.12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jun 2019 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=q+cK3ULiCGcWXiW9CSF+Tt/8O0ERm06HcU3eKB9h2/A=;
	b=ssm62gGaCBM5iQNAyrxMo57p7XNF3mNr19ywtpvXM8U0pn9mbGN+1UHZ1WoWwySoFV
	J7UIad2ZqghnaPyoXQ0zs6rnotkSHPkCP65ncA6Q+5bJZ4sUlBTXp2bGAYCD5GpyIUZ4
	tBJOgVQdDLaH47pnkXa2+AjETJFpvhbMSUlIeNhqZLvZNcL8ARBvymuZ/wnEGsi+j5VI
	KX/42Ov4ssOo1qJYWrjh6u9tlcV65dn8DZ/CpNo7CwE2Iih6oqX8xXBeeYj2ISI4OvhC
	e+tf1TtkH3P1WrBU3DC9proWaml/bEP6t8o7wP1/dPmhd4iYm4/2L2TvVPwhbQlCsUQh
	maBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=q+cK3ULiCGcWXiW9CSF+Tt/8O0ERm06HcU3eKB9h2/A=;
	b=a+AA6kVrLFpJPWjT7A2OUj+NatKyrD03ImrW+aSRad4kMHWa6U5p5iqdiAFQHTtXbM
	w4rK7QyymS5JU+wVxiQ33ysvOoyUqoFE2P6ynjYWbMsHTBWfqj6Y2pNNn02AvrBUWMvS
	yxsqluv/e33cXHhrPOl7Lu2g7pYHBSb9UG3blsI9WEEoAS4kNCQ9LrHkqh1+A2+Wkyk0
	vGTlLD1JCVgWbQism4fF4nkP1VQL+vYzI3Mx3w1uT6NKavHQ2SQn6mAiq+aXxJ+6lYax
	AZjzkJsmLTWRO7Ko79vvSowtMyj0ytPkvLYsK4YWRikDA4oc657p9vSO8zpQ5xqIvr7J
	pp7A==
X-Gm-Message-State: APjAAAWljRo8cVuPeP4uSTI9tfIhDyFPDgBBT2IbnHRf13EJDb+O9e53
	c8hSzwBhqVg5yTo4CV++sZFMWU4l+QH2LbYz6p0fxuib
X-Google-Smtp-Source: APXvYqzogS8WS3tP8rtHGf3SJ6h0Ma3g+/O/8gGS8TUb24CCqgq4g198+JEKrnb0ui3uR9ORFHcg6eEHsuKruQCRq40=
X-Received: by 2002:a17:906:2e59:: with SMTP id
	r25mr10805542eji.293.1561761827196; 
	Fri, 28 Jun 2019 15:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJdd5GbvT5NaKsn0MvLLKWaHuo2izHCLxGPW0oN88+EKxO-G2A@mail.gmail.com>
In-Reply-To: <CAJdd5GbvT5NaKsn0MvLLKWaHuo2izHCLxGPW0oN88+EKxO-G2A@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sat, 29 Jun 2019 00:43:35 +0200
Message-ID: <CA+chaQc_b5qNAeSCd=sK6z=x4d70RPsuNPm-LQ0W5tSgoVjUZg@mail.gmail.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: setscene fetch failures are fatal
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
X-List-Received-Date: Fri, 28 Jun 2019 22:43:46 -0000
Content-Type: multipart/alternative; boundary="000000000000ef1285058c6a0295"

--000000000000ef1285058c6a0295
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There are patches for this on the ML from long time ago. They were rejected
that it's just hiding the real infrastructure issue which should be fixed,
but I keep them in my builds as well because as you say, errors like this
triggering the CI build failures of unrelated changes is quite annoying.

https://github.com/shr-distribution/bitbake/commit/75858b7f4f03137646cb934b=
8e3cde0807493eed
+
http://git.openembedded.org/openembedded-core-contrib/commit/?h=3Djansa/mas=
ter&id=3Ddec7674a1cb501ee8e4f864dcb4adc307c10c159

On Sat, Jun 29, 2019 at 12:23 AM Joshua Watt <jpewhacker@gmail.com> wrote:

> I'm having an issue with the _setscene tasks failing to fetch causing
> our builds to fail. For example: we see the following in our CI build
> logs:
>
>  WARNING: flac-1.3.1-r0 do_package_write_ipk_setscene: Failed to fetch
> URL
> file://07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cortex=
a15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.siginfo=
;downloadfilename=3D07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.=
1:r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.=
tgz.siginfo,
> attempting MIRRORS if available
>  ERROR: flac-1.3.1-r0 do_package_write_ipk_setscene: Fetcher failure:
> Unable to find file
>
> file://07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cortex=
a15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.siginfo=
;downloadfilename=3D07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.=
1:r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.=
tgz.siginfo
> anywhere. The paths that were searched were:
>   /tmp/tmp.S3vCIuI7SE/sstate
>
> The build carries on as normal and even builds everything
> successfully, but the final error code returned from bitbake is '1'.
> This is particularly annoying because A) this happens a lot and B) the
> build did actually produce usable outputs so failing isn't really
> accurate.
>
> Near as I can tell, this is caused because the knotty UI treats any
> logging.error() message as fatal and will have a non-zero return code
> if one occurs.
>
> I also realize this is probably mostly caused by an infrastructure
> problem on our end, but I don't seem to be able to get anyone to
> magically make that better so that this failure stops happening :(
>
> Does anyone have any ideas for things that could be done to mitigate
> this? So far, the only thing I've come up with is to modify the
> bitbake Fetch.download() so that an argument can be passed that says
> whether to use logger.error() or logger.warning() when reporting an
> error, but that feels really ugly.
>
> Thanks,
> Joshua Watt
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--000000000000ef1285058c6a0295
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">There are patches for this on the ML from long time ago. T=
hey were rejected that it&#39;s just hiding the real infrastructure issue w=
hich should be fixed, but I keep them in my builds as well because as you s=
ay, errors like this triggering the CI build failures of unrelated changes =
is quite annoying.<div><br></div><div><a href=3D"https://github.com/shr-dis=
tribution/bitbake/commit/75858b7f4f03137646cb934b8e3cde0807493eed">https://=
github.com/shr-distribution/bitbake/commit/75858b7f4f03137646cb934b8e3cde08=
07493eed</a><br></div><div>+</div><div><a href=3D"http://git.openembedded.o=
rg/openembedded-core-contrib/commit/?h=3Djansa/master&amp;id=3Ddec7674a1cb5=
01ee8e4f864dcb4adc307c10c159">http://git.openembedded.org/openembedded-core=
-contrib/commit/?h=3Djansa/master&amp;id=3Ddec7674a1cb501ee8e4f864dcb4adc30=
7c10c159</a><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Sat, Jun 29, 2019 at 12:23 AM Joshua Watt &lt;<a h=
ref=3D"mailto:jpewhacker@gmail.com">jpewhacker@gmail.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">I&#39;m having an i=
ssue with the _setscene tasks failing to fetch causing<br>
our builds to fail. For example: we see the following in our CI build<br>
logs:<br>
<br>
=C2=A0WARNING: flac-1.3.1-r0 do_package_write_ipk_setscene: Failed to fetch=
<br>
URL file://07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cort=
exa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.sigin=
fo;downloadfilename=3D07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.=
3.1:r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ip=
k.tgz.siginfo,<br>
attempting MIRRORS if available<br>
=C2=A0ERROR: flac-1.3.1-r0 do_package_write_ipk_setscene: Fetcher failure:<=
br>
Unable to find file<br>
file://07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cortexa1=
5hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.siginfo;d=
ownloadfilename=3D07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:=
r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tg=
z.siginfo<br>
anywhere. The paths that were searched were:<br>
=C2=A0 /tmp/tmp.S3vCIuI7SE/sstate<br>
<br>
The build carries on as normal and even builds everything<br>
successfully, but the final error code returned from bitbake is &#39;1&#39;=
.<br>
This is particularly annoying because A) this happens a lot and B) the<br>
build did actually produce usable outputs so failing isn&#39;t really<br>
accurate.<br>
<br>
Near as I can tell, this is caused because the knotty UI treats any<br>
logging.error() message as fatal and will have a non-zero return code<br>
if one occurs.<br>
<br>
I also realize this is probably mostly caused by an infrastructure<br>
problem on our end, but I don&#39;t seem to be able to get anyone to<br>
magically make that better so that this failure stops happening :(<br>
<br>
Does anyone have any ideas for things that could be done to mitigate<br>
this? So far, the only thing I&#39;ve come up with is to modify the<br>
bitbake Fetch.download() so that an argument can be passed that says<br>
whether to use logger.error() or logger.warning() when reporting an<br>
error, but that feels really ugly.<br>
<br>
Thanks,<br>
Joshua Watt<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div>

--000000000000ef1285058c6a0295--
