Return-Path: <uvbapat@gmail.com>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
	[209.85.217.174])
	by mail.openembedded.org (Postfix) with ESMTP id 56C976BE6E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Nov 2013 20:31:16 +0000 (UTC)
Received: by mail-lb0-f174.google.com with SMTP id q8so864382lbi.19
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Nov 2013 12:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=pyVS/VQVAIsR0f52slOKoxJ1vx6GR9Pn7YDFL4DYJ94=;
	b=ZOxXDbFPigrUCo+oMBpwuh8SqZGYcy9RoqV8+oI4h7GVYc7acc0Fm2KVANZtCb8+7I
	BmRRRmSHUCmIvEGT5Ti4NKoWdHwqy8qBRx7ZbrQw7O8iSlv3cF34tKlYGNWbQTnc+xHS
	h7bD5qs8dcySeo1oZDG0WIQ5RN7WkPBH/wykPgXdEA4GgiKcdUCD9xAs1ofw4J7Vo5Xh
	AL7lGoKVTIzJ3gdNU4/JDzByDm1zgxX8ndVtWZ18+eCQV41XE5EfjQtjtu+Ikkw4hv93
	IvR1UFuPrjszoaSPpjG9Dzu0vLF+T+p6cDzvhVKPcsEjz/38qGXmIH/ctBww+uADEAjy
	gJWg==
MIME-Version: 1.0
X-Received: by 10.112.200.170 with SMTP id jt10mr7831067lbc.10.1383856277044; 
	Thu, 07 Nov 2013 12:31:17 -0800 (PST)
Received: by 10.112.14.199 with HTTP; Thu, 7 Nov 2013 12:31:17 -0800 (PST)
Message-ID: <CAJ7NSKrbE9XAN=B+KWY5RD31q-3wwJtX9xdkuyN9QLLq=iUSPg@mail.gmail.com>
From: Udayan Bapat <uvbapat@gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Fri, 20 Dec 2013 09:50:02 +0000
Subject: Regarding CFLAGS in recipe
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
Date: Thu, 07 Nov 2013 20:31:16 -0000
X-Original-Date: Thu, 7 Nov 2013 15:31:17 -0500
X-List-Received-Date: Thu, 07 Nov 2013 20:31:16 -0000
Content-Type: multipart/alternative; boundary=001a11c265b8d0430904ea9c259f

--001a11c265b8d0430904ea9c259f
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

CFLAGS = "${@'${CFLAGS}'.replace('-fPIE','')}"

This doesn't work because same variable can not be referenced twice.

Then I tried this -

CFLAGS_noPIE = "${@'${CFLAGS}'.replace('-fPIE','')}"
CFLAGS = "${CFLAGS_noPIE}"

This fails with an error "maximum recursion depth exceeded for variable
'CFLAGS'"

What is the correct way to doing this?

Thanks
Udayan

--001a11c265b8d0430904ea9c259f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi all,<br><br>I have a Yocto build environment =
where I intend to build all recipes with -fPIE flag. So I have added CFLAGS=
_append +=3D &#39;-fPIE&#39; in the local.conf. However since shared librar=
ies can not be built using -fPIE flag, I would like to remove it from some =
recipes.<br>
<br>So far I have tried this in .bb files - <br><br>CFLAGS_noPIE =3D &quot;=
${@&#39;${CFLAGS}&#39;.replace(&#39;-fPIE&#39;,&#39;&#39;)}&quot;<br><br>do=
_compile_prepend () {<br>=A0=A0=A0 CFLAGS =3D &quot;${CFLAGS_noPIE}&quot;<b=
r>}<br>
<br></div>This throws an error - <br><br>*/zlib-native/1.2.8-r0/temp/run.do=
_compile.23159: line 82: CFLAGS: command not found<br><br></div>I also have=
 tried - <br><br>CFLAGS =3D &quot;${@&#39;${CFLAGS}&#39;.replace(&#39;-fPIE=
&#39;,&#39;&#39;)}&quot;<br>
<br><div><div>This doesn&#39;t work because same variable can not be refere=
nced twice.<br><br></div><div>Then I tried this - <br><br>CFLAGS_noPIE =3D =
&quot;${@&#39;${CFLAGS}&#39;.replace(&#39;-fPIE&#39;,&#39;&#39;)}&quot;<br>
</div><div>CFLAGS =3D &quot;${CFLAGS_noPIE}&quot; </div><div><br></div><div=
>This fails with an error &quot;maximum recursion depth exceeded for variab=
le &#39;CFLAGS&#39;&quot;<br><br></div><div>What is the correct way to doin=
g this?<br>
<br>Thanks<br>Udayan<br></div><div><br></div></div></div>

--001a11c265b8d0430904ea9c259f--
