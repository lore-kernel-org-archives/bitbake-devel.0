Return-Path: <raj.khem@gmail.com>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id 0A33960886
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Aug 2013 04:58:13 +0000 (UTC)
Received: by mail-pd0-f173.google.com with SMTP id p11so4097935pdj.32
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Aug 2013 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=content-type:mime-version:subject:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=zuXW8XYPg1Mp9b6BgMRj7QNesC+ZkxGXF5Kn3hVOROM=;
	b=x6tQte+RvrfzB/euA57y2/HkHnOThtspTn3NRoTGsOsnu2ZUAqb9jx7fymaS6J82Rv
	J5ks1K73BVreT1gC0DyrUnu5hg+sQ1CuncIYOWe3GXmk4dUUhY9Xz/4dHMLUWKZfP8rN
	FZxRhIicoTFcT+DB9lFjCC+pAJKvKungOm+zb9fWnzsSIStgSww942bEJakPvYkqsAzh
	nji8zddjGrVvukniO6VQVs9U0a7L4HIG+RBlttmbg4tE/MG2tCef8H7E7z8sDYKC7UPZ
	pCgJpuQErF3/En+J1agESQ7xGyLEbttUhll6z4mBVF3+jttaKngIUqEtJdGK82OpDGL6
	dEJw==
X-Received: by 10.66.218.39 with SMTP id pd7mr1071746pac.148.1375765093726;
	Mon, 05 Aug 2013 21:58:13 -0700 (PDT)
Received: from gourish-sslvpn-nc.jnpr.net (natint3.juniper.net.
	[66.129.224.36])
	by mx.google.com with ESMTPSA id fa5sm2758197pbb.3.2013.08.05.21.58.10
	for <multiple recipients>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 05 Aug 2013 21:58:11 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <1375764715.11349.YahooMailNeo@web162605.mail.bf1.yahoo.com>
Date: Mon, 5 Aug 2013 21:58:09 -0700
Message-Id: <ADEA8F38-F1BB-427C-8864-440A2B8FA6C7@gmail.com>
References: <1375764715.11349.YahooMailNeo@web162605.mail.bf1.yahoo.com>
To: Benix Vincent <benixvincent@yahoo.com>
X-Mailer: Apple Mail (2.1508)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Multiple init script in bitbake file
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
X-List-Received-Date: Tue, 06 Aug 2013 04:58:13 -0000
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_267738B9-2290-4D49-A640-91CCD0E7F495"

--Apple-Mail=_267738B9-2290-4D49-A640-91CCD0E7F495
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On Aug 5, 2013, at 9:51 PM, Benix Vincent <benixvincent@yahoo.com> =
wrote:

>=20
>=20
> Hi
>=20
> I need to launch multiple initscripts (2) for a single package, I =
tried the following;
>=20
>=20
> INITSCRIPT_NAME =3D "diag.sh"
> INITSCRIPT_PARAMS =3D "defaults 16"
>=20
> INITSCRIPT_NAME =3D "drivers-init.sh "
> INITSCRIPT_PARAMS =3D "defaults 14"
>=20
> But the second one overwrites the first and I see just one init script =
in my sandbox.
>=20
> then I even tried this
>=20
>=20
> INITSCRIPT_NAME_diag1 =3D "diag.sh"
> INITSCRIPT_PARAMS_diag1 =3D "defaults 16"
>=20
> INITSCRIPT_NAME_diag2 =3D "drivers-init.sh "
> INITSCRIPT_PARAMS_diag2 =3D "defaults 14"
>=20
>=20
> even this didn't work.


do you have diag1 and diag2 in PACKAGES  variable ? if not then it won't =
work. I would suggest to add additional
package to list of PACKAGES the recipe is generating and then use the =
above syntax.


>=20
> Any help is greatly appreciated.
>=20
> Benix.
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


--Apple-Mail=_267738B9-2290-4D49-A640-91CCD0E7F495
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><br><div><div>On Aug 5, 2013, at 9:51 PM, Benix Vincent &lt;<a =
href=3D"mailto:benixvincent@yahoo.com">benixvincent@yahoo.com</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div><div style=3D"background-color: rgb(255, 255, 255); =
font-family: 'times new roman', 'new york', times, serif; font-size: =
12pt; position: static; z-index: auto; "><div style=3D"font-family: =
'times new roman', 'new york', times, serif; font-size: =
12pt;"><br></div><div style=3D"font-family: 'times new roman', 'new =
york', times, serif; font-size: 16px; background-color: transparent; =
font-style: normal; "><br></div><div style=3D"font-family: 'times new =
roman', 'new york', times, serif; font-size: 16px; background-color: =
transparent; font-style: normal; ">Hi</div><div style=3D"font-family: =
'times new roman', 'new york', times, serif; font-size: 16px; =
background-color: transparent; font-style: normal; "><br></div><div =
style=3D"font-family: 'times new roman', 'new york', times, serif; =
font-size: 16px; background-color: transparent; font-style: normal; ">I =
need to launch multiple initscripts (2) for a single package, I tried =
the
 following;</div><div style=3D"font-family: 'times new roman', 'new =
york', times, serif; font-size: 16px; background-color: transparent; =
font-style: normal; "><br></div><div style=3D"background-color: =
transparent;"><font face=3D"times new roman, new york, times, =
serif"><br></font></div><div style=3D"background-color: =
transparent;"><font face=3D"times new roman, new york, times, =
serif">INITSCRIPT_NAME =3D "diag.sh"</font></div><div =
style=3D"background-color: transparent; font-size: 16px; font-family: =
'times new roman', 'new york', times, serif; font-style: normal; "><font =
face=3D"times new roman, new york, times, serif"><span style=3D"font-size:=
 16px;">INITSCRIPT_PARAMS =3D "defaults 16"</span><br></font></div><div =
style=3D"background-color: transparent; font-size: 16px; font-family: =
'times new roman', 'new york', times, serif; font-style: normal; "><font =
face=3D"times new roman, new york, times, serif"><br></font></div><div =
style=3D"background-color: transparent;"><font face=3D"times new roman, =
new york, times, serif">INITSCRIPT_NAME =3D "drivers-init.sh =
"</font></div><div style=3D"background-color: transparent; font-size: =
16px; font-family: 'times new roman', 'new york', times, serif; =
font-style: normal; "><span style=3D"background-color: =
transparent;">INITSCRIPT_PARAMS =3D "defaults 14"</span><br></div><div =
style=3D"background-color: transparent; font-size: 16px; font-family: =
'times new roman', 'new york', times, serif; font-style: normal; "><font =
face=3D"times new roman, new york, times, serif"><br></font></div><div =
style=3D"background-color: transparent; font-size: 16px; font-family: =
'times new roman', 'new york', times, serif; font-style: normal; ">But =
the second one overwrites the first and I see just one init script in my =
sandbox.</div><div style=3D"background-color: transparent; font-size: =
16px; font-family: 'times new roman', 'new york', times, serif; =
font-style: normal; "><br></div><div style=3D"background-color: =
transparent; font-size: 16px; font-family: 'times new roman', 'new =
york', times, serif; font-style: normal; "><span style=3D"font-size: =
16px;">then I even tried this</span><br></div><div =
style=3D"background-color: transparent; font-size: 16px; font-family: =
'times new roman', 'new york', times, serif; font-style: normal; "><span =
style=3D"font-size: 16px;"><br></span></div><div =
style=3D"background-color: transparent;"><font face=3D"times new roman, =
new york, times, serif"><br></font></div><div style=3D"background-color: =
transparent;"><font face=3D"times new roman, new york, times, =
serif">INITSCRIPT_NAME_diag1 =3D "diag.sh"</font></div><div =
style=3D"background-color: transparent; font-size: 16px; font-family: =
'times new roman', 'new york', times, serif; font-style: normal; "><font =
face=3D"times new roman, new york, times, serif"><span style=3D"font-size:=
 16px;">INITSCRIPT_PARAMS_diag1 =3D "defaults =
16"</span><br></font></div><div style=3D"background-color: transparent; =
font-size: 16px; font-family: 'times new roman', 'new york', times, =
serif; font-style: normal; "><font face=3D"times new roman, new york, =
times, serif"><br></font></div><div style=3D"background-color: =
transparent;"><font face=3D"times new roman, new york, times, =
serif">INITSCRIPT_NAME_diag2 =3D "drivers-init.sh "</font></div><div =
style=3D"background-color: transparent;"><span style=3D"font-family: =
'times new roman', 'new york', times, serif; background-color: =
transparent;">INITSCRIPT_PARAMS_diag2 =3D "defaults =
14"</span><br></div><div style=3D"background-color: transparent; =
font-size: 16px; font-family: 'Times New Roman'; font-style: normal; =
"><span style=3D"font-family: 'times
 new roman', 'new york', times, serif; background-color: =
transparent;"><br></span></div><div style=3D"background-color: =
transparent; font-size: 16px; font-family: 'times new roman', 'new =
york', times, serif; font-style: normal; "><span style=3D"font-family: =
'times new roman', 'new york', times, serif; background-color: =
transparent;"><br></span></div><div style=3D"background-color: =
transparent; font-size: 16px; font-family: 'times new roman', 'new =
york', times, serif; font-style: normal; "><span style=3D"font-family: =
'times new roman', 'new york', times, serif; background-color: =
transparent;">even this didn't =
work.</span></div></div></div></blockquote><div><br></div><div><br></div><=
div>do you have diag1 and diag2 in PACKAGES &nbsp;variable ? if not then =
it won't work. I would suggest to add additional</div><div>package to =
list of PACKAGES the recipe is generating and then use the above =
syntax.</div><div><br></div><br><blockquote type=3D"cite"><div><div =
style=3D"background-color: rgb(255, 255, 255); font-family: 'times new =
roman', 'new york', times, serif; font-size: 12pt; position: static; =
z-index: auto; "><div style=3D"background-color: transparent; font-size: =
16px; font-family: 'times new roman', 'new york', times, serif; =
font-style: normal; "><span style=3D"font-family: 'times new roman', =
'new york', times, serif; background-color: =
transparent;"><br></span></div><div style=3D"background-color: =
transparent; font-size: 16px; font-family: 'times new roman', 'new =
york', times, serif; font-style: normal; "><span style=3D"font-family: =
'times new roman', 'new york', times, serif; background-color: =
transparent;">Any help is greatly appreciated.</span></div><div =
style=3D"background-color: transparent; font-size: 16px; font-family: =
'times new roman', 'new york', times, serif; font-style: normal; "><span =
style=3D"font-family: 'times new roman', 'new york', times, serif; =
background-color: transparent;"><br></span></div><div =
style=3D"background-color: transparent; font-size: 16px; font-family: =
'times new roman', 'new york', times, serif; font-style: normal; "><span =
style=3D"font-family: 'times new roman', 'new york', times, serif; =
background-color: =
transparent;">Benix.</span></div></div></div>_____________________________=
__________________<br>bitbake-devel mailing list<br><a =
href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists.o=
penembedded.org</a><br>http://lists.openembedded.org/mailman/listinfo/bitb=
ake-devel<br></blockquote></div><br></body></html>=

--Apple-Mail=_267738B9-2290-4D49-A640-91CCD0E7F495--
