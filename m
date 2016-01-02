Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com
	[209.85.213.172])
	by mail.openembedded.org (Postfix) with ESMTP id 66A556011F
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Jan 2016 19:30:16 +0000 (UTC)
Received: by mail-ig0-f172.google.com with SMTP id mv3so179076944igc.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 02 Jan 2016 11:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=alwU7qgvmZ4hM3HkOrcdigRhiMVA0Aj23xkPO59+gTU=;
	b=KrvISdRef6SP5DWM4mJX9QJduOSkvMwawJ8rN/f8c+naKPwMUpkDQkWoGiyHESjAU6
	GtxescGq0XbNbX0csoG7i3OUiOuticd/PEkvQUu9esWwY92syqKPS0prh03AaH5FxEsz
	cfWmNhTmqBki04xOiUEpYkTsDus4uUzm8NsPL+rcLzKck2C5jGp5vOssL5MIXx+TMaIP
	Cx14MhaocdKa6bzUwlYSRfyZERLivf4RDtEALLyjnBmL9dpvYHjYFoPTHMoZFZjY6Z+v
	f4gSSR4WFDU0GI0UaxMuAfpC36e5XUE1gt8RfctnisYtCtla/4dPaYux1NKTi5wEJz/e
	oe4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kergoth-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=alwU7qgvmZ4hM3HkOrcdigRhiMVA0Aj23xkPO59+gTU=;
	b=W790NWh0jSnLj1pXJcs/vofYtrV3aOUEZDXqydaWIIjTmod87+FHPByfIpGJOS7dTN
	ArL1sBYbCRI3JHvsnjPLJ8CGUILFN+6wlsyctJjPKhun0ETpjPez+uIKf8VLTJqoQMCc
	VG0jHZ9XKs23B1tFfr9/O9sCnUnUddfvBGrP0oz9DVnwqlEefIfKca5bX1nyZ84D6XSv
	IYCahu/7pjqd4elUeXFdaH+bUZElGs8DHQU8uKxxmmPeTcbOnGNmiDEBkixf7tHc1lO+
	Dr6i43qijWDpNnr33mjIfCexKcygl9yf+fDLCGmYOg7Ur5T7epSb+JIt9Cugn8umZ58C
	Toug==
X-Received: by 10.50.131.201 with SMTP id oo9mr36244189igb.68.1451763016563;
	Sat, 02 Jan 2016 11:30:16 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.104.194 with HTTP; Sat, 2 Jan 2016 11:29:57 -0800 (PST)
In-Reply-To: <1451580136-29714-5-git-send-email-ed.bartosh@linux.intel.com>
References: <1451580136-29714-1-git-send-email-ed.bartosh@linux.intel.com>
	<1451580136-29714-5-git-send-email-ed.bartosh@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Sat, 2 Jan 2016 12:29:57 -0700
X-Google-Sender-Auth: Nh9lUAvp3WP4N0PWCAWjAAiRna4
Message-ID: <CABcZANkw_e36yhZgTVcMdVO5fm7=B4UoN-ZxjKOzNOQTvf3-1g@mail.gmail.com>
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 4/4] uievent: refactor retry loop
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
X-List-Received-Date: Sat, 02 Jan 2016 19:30:18 -0000
Content-Type: multipart/alternative; boundary=047d7b2e47c8e6865f05285eea34

--047d7b2e47c8e6865f05285eea34
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 31, 2015 at 9:42 AM, Ed Bartosh <ed.bartosh@linux.intel.com>
wrote:

> +        for count_tries in range(5):
> +
>              self.EventHandle, error =
> self.BBServer.registerEventHandler(self.host, self.port)
>
> -            if (self.EventHandle != None):
> +            if self.EventHandle != None:
>                  break
>
>              errmsg = "Could not register UI event handler. Error: %s, " \
>                       "host %s, port %d" % (error, self.host, self.port)
>              bb.warn("%s, retry" % errmsg)
> -            count_tries += 1
> +            if count_tries == 4:
> +                raise Exception(errmsg)
> +
>

I'd just use the else clause of the for loop here, this is just the sort of
case it's good for. The else clause is run when the loop finished / didn't
break.

for count_tries in range(5):
    # do stuff
    if something:
        break
else:
    # didn't break
    raise Exception(errmsg)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7b2e47c8e6865f05285eea34
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 31, 2015 at 9:42 AM, Ed Bartosh <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ed.bartosh@linux.intel.com" target=3D"_blank">ed.bartosh@linux.i=
ntel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=
=3D":148" class=3D"a3s" style=3D"overflow:hidden">+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 for count_tries in range(5):<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.EventHandle, error =3D=
 self.BBServer.registerEventHandler(self.host, self.port)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (self.EventHandle !=3D None):=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.EventHandle !=3D None:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errmsg =3D &quot;Could not =
register UI event handler. Error: %s, &quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;host %s, port %d&quot; % (error, self.host, self.port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<span class=3D"il">bb</span=
>.warn(&quot;%s, retry&quot; % errmsg)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 count_tries +=3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if count_tries =3D=3D 4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(er=
rmsg)<br>
+</div></blockquote></div><br></div><div class=3D"gmail_extra">I&#39;d just=
 use the else clause of the for loop here, this is just the sort of case it=
&#39;s good for. The else clause is run when the loop finished / didn&#39;t=
 break.<br><br></div><div class=3D"gmail_extra">for count_tries in range(5)=
:<br></div><div class=3D"gmail_extra">=C2=A0=C2=A0=C2=A0 # do stuff<br></di=
v><div class=3D"gmail_extra">=C2=A0=C2=A0=C2=A0 if something:<br></div><div=
 class=3D"gmail_extra">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break<br>=
</div><div class=3D"gmail_extra">else:<br></div><div class=3D"gmail_extra">=
=C2=A0=C2=A0=C2=A0 # didn&#39;t break<br></div><div class=3D"gmail_extra">=
=C2=A0=C2=A0=C2=A0 raise Exception(errmsg)<br>-- <br><div class=3D"gmail_si=
gnature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitB=
ake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engi=
neer, Mentor Graphics</div>
</div></div>

--047d7b2e47c8e6865f05285eea34--
