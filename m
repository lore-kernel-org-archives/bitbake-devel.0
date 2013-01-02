Received: from mail-la0-f51.google.com ([209.85.215.51])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TqPPm-0007Nf-Cs
	for bitbake-devel@lists.openembedded.org;
	Wed, 02 Jan 2013 15:35:30 +0100
Received: by mail-la0-f51.google.com with SMTP id fj20so5995385lab.24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Jan 2013 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=vGyo4N/KCe7Q4rIYOdIa+w0jEcTrjfFrX6FCUCyUdhU=;
	b=p6O67yzsV/1ce28qxQubrO2Omp2kcwV2u0bG1D5MuVIITKiBg2dotk52qwwXmJmOZf
	+wqVFK4BjAgyQLD7+UPyp9ESVpyUNegC7gDSY+itkpaCorvCThlpS1Iva+Fv13klfUWU
	VwnBcSZE/rv36NliAWXEsAD6nyoHeEJd9yRISIhFiYepe/g3EJrYaiX0mzs30U6yfWT2
	g+nVfx+yxzLKJV07ob/2diXz1GLiXUnaPs9ezCeNvWZR7gpaodMiJyrIvHfs0by2Aufv
	PcTWMDca/tnQLD0JTYxrYKfW3C7DmIHtCkdrak0lQQ7Jj6ODqTV5HbVIEsO419kE6zYU
	rYMA==
Received: by 10.152.110.229 with SMTP id id5mr43880613lab.36.1357136428020;
	Wed, 02 Jan 2013 06:20:28 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Wed, 2 Jan 2013 06:20:06 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1301020851340.5488@oneiric>
References: <alpine.DEB.2.02.1301020851340.5488@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 2 Jan 2013 07:20:06 -0700
X-Google-Sender-Auth: kQYHT2wiMslBq2gmw7-WUmBAShA
Message-ID: <CABcZANk4gA_ZNEvaBNW4xDh6RFGYqxqCN60k-8MwE2naMKLqwg@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: is bitbake's bitbake.conf even consulted?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 02 Jan 2013 14:35:30 -0000
Content-Type: multipart/alternative; boundary=f46d040713e3b434e604d24ef216

--f46d040713e3b434e604d24ef216
Content-Type: text/plain; charset=UTF-8

On Wed, Jan 2, 2013 at 6:59 AM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

>   prepared to embarrass myself yet again but in writing up something
> about PROVIDES, i was testing values of certain variables and
> concluded that the bitbake.conf file in the bitbake checkout isn't
> consulted, is that correct?
>
>   it seemed pretty obvious when i asked for the value of, for example,
> FETCHCOMMAND_svn, and was told it wasn't set.  (which isn't a bad
> thing since it's deprecated, anyway. :-)
>
>   i'm asking only since someone might be confused by the disparities
> between the two files, such as:
>
> 1) PF = "${PN}-${PV}-${PR}"
> 2) PF = "${PN}-${EXTENDPE}${PV}-${PR}"
>
>   so what is the rationale for bitbake's version of that file?  or am
> i misunderstanding something?
>

bitbake's bitbake.conf is a minimal example intended for anyone who might
want to use it outside of oe/yocto.
-- 
Christopher Larson

--f46d040713e3b434e604d24ef216
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quo=
te">On Wed, Jan 2, 2013 at 6:59 AM, Robert P. J. Day <span dir=3D"ltr">&lt;=
<a href=3D"mailto:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcour=
se.ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":fu">=C2=A0 prepared to embarrass=
 myself yet again but in writing up something<br>
about PROVIDES, i was testing values of certain variables and<br>
concluded that the bitbake.conf file in the bitbake checkout isn&#39;t<br>
consulted, is that correct?<br>
<br>
=C2=A0 it seemed pretty obvious when i asked for the value of, for example,=
<br>
FETCHCOMMAND_svn, and was told it wasn&#39;t set. =C2=A0(which isn&#39;t a =
bad<br>
thing since it&#39;s deprecated, anyway. :-)<br>
<br>
=C2=A0 i&#39;m asking only since someone might be confused by the dispariti=
es<br>
between the two files, such as:<br>
<br>
1) PF =3D &quot;${PN}-${PV}-${PR}&quot;<br>
2) PF =3D &quot;${PN}-${EXTENDPE}${PV}-${PR}&quot;<br>
<br>
=C2=A0 so what is the rationale for bitbake&#39;s version of that file? =C2=
=A0or am<br>
i misunderstanding something?</div></blockquote></div><br>bitbake&#39;s bit=
bake.conf is a minimal example intended for anyone who might want to use it=
 outside of oe/yocto.<br>-- <br>Christopher Larson</div></div>

--f46d040713e3b434e604d24ef216--
