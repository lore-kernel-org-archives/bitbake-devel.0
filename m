Return-Path: <uvbapat@gmail.com>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
	[209.85.215.47])
	by mail.openembedded.org (Postfix) with ESMTP id 4DC716D663
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2013 13:52:32 +0000 (UTC)
Received: by mail-la0-f47.google.com with SMTP id er20so1721704lab.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Nov 2013 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=/fNpCIYfSeOa6BcTlLYyNGRu9IwXQi5Ta2SMs3TNQ1Y=;
	b=z1Dl1zuDy2OCHxLix/8d5DiP7JLUxea+kDG7keucrTcN5il1QlBBwIurrr9F1XFrgJ
	4YY6z/RzEhpTUFm7z4AnT4mYLJj8iG6MsKeL3iJ8YiGl6nVKy2oZ2KDbAocNCsCiG5Vw
	OmhilN9Doxe9dTEjTRIGTxLnbz0KF+5QsbIi0lkaAA36H1ovdTpzAT8YuW7ANyXio3pW
	ylKnj147iSRVmf3oehS+tygVJOHzNKZT+ixv1YdxNPO7iKwf1OobpHP5mNypl37Q/9mf
	J34rFLh9b0UmMDs8HNyTvRMlTaXav5x0rvBc6LEehMSi8gQobk85lX3tq6MPmapIJ4ax
	xrEg==
MIME-Version: 1.0
X-Received: by 10.153.8.163 with SMTP id dl3mr5947290lad.1.1383918752706; Fri,
	08 Nov 2013 05:52:32 -0800 (PST)
Received: by 10.112.14.199 with HTTP; Fri, 8 Nov 2013 05:52:32 -0800 (PST)
Date: Fri, 8 Nov 2013 08:52:32 -0500
Message-ID: <CAJ7NSKp95ngb9yPLNr39eZ7TV7w+BCZrXeSq0-LqfCTk=WE0EA@mail.gmail.com>
From: Udayan Bapat <uvbapat@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: How to strip CFLAGS in the recipe file?
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
X-List-Received-Date: Fri, 08 Nov 2013 13:52:33 -0000
Content-Type: multipart/alternative; boundary=001a11348d34a7345704eaaab114

--001a11348d34a7345704eaaab114
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I have a Yocto build environment where I intend to build all recipes with
-fPIE flag. So I have added CFLAGS_append += '-fPIE' in the local.conf.
However since shared libraries can not be built using -fPIE flag, I would
like to remove it from some recipes.

So far I have tried this in .bb files -

CFLAGS_noPIE = "${@'${CFLAGS}'.replace('-fPIE','')}"

do_compile_prepend () {
    CFLAGS = "${CFLAGS_noPIE}"
}

This throws an error -

*/zlib-native/1.2.8-r0/temp/run.do_compile.23159: line 82: CFLAGS: command
not found

I also have tried -

CFLAGS = "${@'${CFLAGS}'.replace('-
fPIE','')}"

This doesn't work because same variable can not be referenced twice.

Then I tried this -

CFLAGS_noPIE = "${@'${CFLAGS}'.replace('-fPIE','')}"
CFLAGS = "${CFLAGS_noPIE}"

This fails with an error "maximum recursion depth exceeded for variable
'CFLAGS'"

What is the correct way to doing this?

Thanks

--001a11348d34a7345704eaaab114
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi all,<br><br>I have a Yocto build environment =
where I intend
 to build all recipes with -fPIE flag. So I have added CFLAGS_append +=3D=
=20
&#39;-fPIE&#39; in the local.conf. However since shared libraries can not b=
e=20
built using -fPIE flag, I would like to remove it from some recipes.<br>
<br>So far I have tried this in .bb files - <br><br>CFLAGS_noPIE =3D &quot;=
${@&#39;${CFLAGS}&#39;.replace(&#39;-fPIE&#39;,&#39;&#39;)}&quot;<br><br>do=
_compile_prepend () {<br>=A0=A0=A0 CFLAGS =3D &quot;${CFLAGS_noPIE}&quot;<b=
r>}<br>

<br></div>This throws an error - <br><br>*/zlib-native/1.2.8-r0/temp/run.do=
_compile.23159: line 82: CFLAGS: command not found<br><br></div>I also have=
 tried - <br><br>CFLAGS =3D &quot;${@&#39;${CFLAGS}&#39;.replace(&#39;-<div=
 dir=3D"ltr">
fPIE&#39;,&#39;&#39;)}&quot;<br>
<br><div><div>This doesn&#39;t work because same variable can not be refere=
nced twice.<br><br></div><div>Then I tried this - <br><br>CFLAGS_noPIE =3D =
&quot;${@&#39;${CFLAGS}&#39;.replace(&#39;-fPIE&#39;,&#39;&#39;)}&quot;<br>

</div><div>CFLAGS =3D &quot;${CFLAGS_noPIE}&quot; </div><div><br></div><div=
>This fails with an error &quot;maximum recursion depth exceeded for variab=
le &#39;CFLAGS&#39;&quot;<br><br></div><div>What is the correct way to doin=
g this?<br>

<br>Thanks</div></div></div></div>

--001a11348d34a7345704eaaab114--
