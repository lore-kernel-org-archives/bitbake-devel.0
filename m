Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
	[209.85.223.194])
	by mail.openembedded.org (Postfix) with ESMTP id 01482601D3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 May 2016 20:01:22 +0000 (UTC)
Received: by mail-io0-f194.google.com with SMTP id k129so2942831iof.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 May 2016 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=ZZdG3FwCoTz19tfTqcSWA5qaYkrdKTRthjknfnwkJ4Y=;
	b=nTlzuL4yHFWL561Lpi0LNzh3FsHMPkN6/taihV2LtCvvTroYGlIj6ycbqLGAAaM+Rj
	JuEluVJUfSZRgjQLsO3sIMhK6ZxUUB/kRPWw2iOK2CYXnGLbDaYDMBEvUpcbyl8RRL9W
	GswQdr4aK1XJOyojU3A6pzXqVWWHadT45jS3qqJYuppaxR3X5xxSWqACY6lTcrd4kEw0
	iFqK56fZW11/vTssTkotB8zDcKYT/IGdrcc6P1jna2SVAXiCFt8V3VkFs7hPnIXQ9hxf
	Vjmz6c2SHJHUk2jwPTXBjlrzTQlTliBQczu8dzI0atvJChy4wQy5nk75xc5qBbbgpB/X
	UF+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=ZZdG3FwCoTz19tfTqcSWA5qaYkrdKTRthjknfnwkJ4Y=;
	b=g4tAbdXJr8hx82geC+xswHZc+t1v+PmXFFakuX8CxdGvE2gMzJJRw4tNUXF/9UwEIe
	IVdgk6LfkF7K2GTH0q2vTN+RFmoErBzShznTUVdqDifbCWxLqXbzT1PCQBoS22sg2bnV
	feLmagwayZdrbVFQdUyNeR8wx/O28SHOSfPs7JGvpXDG1EeeCqzZibThoUEjpW6V4irt
	t3li79euIEmQxsRKpvtlP+8qdWV5oCjE/f84VvayDEEdoGjx+CkqR5QFPXg6wqtttRk2
	CU8eKV+Ka9XARuBhlFfX7Xwkw3zm9JgPc2fH51uv4C/sD+CVXZXN3JHuo6k2ukrRw+2t
	AcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=ZZdG3FwCoTz19tfTqcSWA5qaYkrdKTRthjknfnwkJ4Y=;
	b=iXzL7zGpxVczOR52wqz0Kijpdez5FoKhZmNfMvgDiGrGEqRz3lpA1q+2RNu1iz3SDq
	0T2xOMqwuW4IUrv8JGupqCUnDKIcglA+W8EkhPYRb+JlzOwN5IHXEJJ/HIBr29GsWN3Q
	8yWbz4w1tWiLfgOgDbU9dy6NNLOwPyuyvmi9LfHWlzE88l8znWrpPnS7RTA/trG6f49j
	TEkCGZQaJJgFxR77Cfi6IQGhd8rBZM+SeGp8T/pY+gEycatr1owOoHviI6V1dSgfjBpO
	/pbB82fXMXlrtF9vizmGBD+QDFqn960lA8G1IB3/nj+VSgy+cRb0dOxc5G2DcpM25u9p
	GHyw==
X-Gm-Message-State: AOPr4FWw0ySi8l4JsbmrnSveOz+LlnpkbvzDpUvexFlVyBE9eHzEGTrIxHJCRKRwyrjvHlRqTmNWj/w2LEtm+g==
X-Received: by 10.36.20.136 with SMTP id 130mr2407835itg.66.1462910483306;
	Tue, 10 May 2016 13:01:23 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.134.70 with HTTP; Tue, 10 May 2016 13:01:03 -0700 (PDT)
In-Reply-To: <1462902849-6940-1-git-send-email-humberto.ibarra.lopez@intel.com>
References: <1462902849-6940-1-git-send-email-humberto.ibarra.lopez@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 10 May 2016 13:01:03 -0700
X-Google-Sender-Auth: OHIH9n4tK3QBxODFquJpPPjwP0o
Message-ID: <CABcZANmPD2snARFqYQrj5NjnkrBCiCX-WDzvxjd4--Z61t56BA@mail.gmail.com>
To: Humberto Ibarra <humberto.ibarra.lopez@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake/lib/bb/cookerdata.py: Check if layer conf files exist before parsing them
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
X-List-Received-Date: Tue, 10 May 2016 20:01:24 -0000
Content-Type: multipart/alternative; boundary=001a11437c6cb21f5105328263a9

--001a11437c6cb21f5105328263a9
Content-Type: text/plain; charset=UTF-8

On Tue, May 10, 2016 at 10:54 AM, Humberto Ibarra <
humberto.ibarra.lopez@intel.com> wrote:

> If an invalid layer is added to bblayers.conf, the parsing of said file
> ends with a trace and an "Unable to parse" exception. This is not the
> ideal output, especially considering that we know exactly why this is
> failing.
>
> This patch checks if a layer conf file exists before trying to parse it.
> If it does not, a clear and more concise message is send to the user.
> Otherwise, the parsing continues.
>
> [Yocto #9506]
>
> Signed-off-by: Humberto Ibarra <humberto.ibarra.lopez@intel.com>
> ---
>  bitbake/lib/bb/cookerdata.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
> index 50259a9..28f652e 100644
> --- a/bitbake/lib/bb/cookerdata.py
> +++ b/bitbake/lib/bb/cookerdata.py
> @@ -295,7 +295,11 @@ class CookerDataBuilder(object):
>                  if layer.endswith('/'):
>                      layer = layer.rstrip('/')
>                  data.setVar('LAYERDIR', layer)
> -                data = parse_config_file(os.path.join(layer, "conf",
> "layer.conf"), data)
> +                layer_config_file = os.path.join(layer, "conf", "layer.
> conf")
> +                if not os.path.exists(layer_config_file):
> +                    parselog.critical("Unable to find layer configuration
> file: %s" % layer_config_file)
> +                    sys.exit(1)
> +                data = parse_config_file(layer_config_file, data)
>

This is potentially racy. Better to just try to open and catch the
appropriate exception and check exc.errno for errno.ENOENT.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11437c6cb21f5105328263a9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, May 10, 2016 at 10:54 AM, Humberto Ibarra <span dir=3D"ltr">&lt;<a =
href=3D"mailto:humberto.ibarra.lopez@intel.com" target=3D"_blank">humberto.=
ibarra.lopez@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div id=3D":qk" class=3D"a3s aXjCH">If an invalid layer is added to bbl=
ayers.<span class=3D"il">conf</span>, the parsing of said file<br>
ends with a trace and an &quot;Unable to parse&quot; exception. This is not=
 the<br>
ideal output, especially considering that we know exactly why this is faili=
ng.<br>
<br>
This patch checks if a layer <span class=3D"il">conf</span> file exists bef=
ore trying to parse it.<br>
If it does not, a clear and more concise message is send to the user.<br>
Otherwise, the parsing continues.<br>
<br>
[Yocto #9506]<br>
<br>
Signed-off-by: Humberto Ibarra &lt;<a href=3D"mailto:humberto.ibarra.lopez@=
intel.com">humberto.ibarra.lopez@intel.com</a>&gt;<br>
---<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/co=
okerdata.py | 6 +++++-<br>
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</s=
pan>/cookerdata.py b/<span class=3D"il">bitbake</span>/lib/<span class=3D"i=
l">bb</span>/cookerdata.py<br>
index 50259a9..28f652e 100644<br>
--- a/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/co=
okerdata.py<br>
+++ b/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/co=
okerdata.py<br>
@@ -295,7 +295,11 @@ <span class=3D"il">class</span> CookerDataBuilder(obje=
ct):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if layer.ends=
with(&#39;/&#39;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0layer =3D layer.rstrip(&#39;/&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.setVar(&=
#39;LAYERDIR&#39;, layer)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D parse_con=
fig_file(os.path.join(layer, &quot;<span class=3D"il">conf</span>&quot;, &q=
uot;layer.<span class=3D"il">conf</span>&quot;), data)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_config_file =
=3D os.path.join(layer, &quot;<span class=3D"il">conf</span>&quot;, &quot;l=
ayer.<span class=3D"il">conf</span>&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exi=
sts(layer_config_file):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pars=
elog.critical(&quot;Unable to find layer configuration file: %s&quot; % lay=
er_config_file)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.=
exit(1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D parse_con=
fig_file(layer_config_file, data)</div></blockquote></div><br>This is poten=
tially racy. Better to just try to open and catch the appropriate exception=
 and check exc.errno for errno.ENOENT.<br>-- <br><div class=3D"gmail_signat=
ure">Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake,=
 OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer=
, Mentor Graphics</div>
</div></div>

--001a11437c6cb21f5105328263a9--
