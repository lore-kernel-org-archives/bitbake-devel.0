Subject: Best practice to debug a bbclass customization
To: bitbake-devel@lists.openembedded.org
From: "Marco Cavallini" <cavallini.koan@gmail.com>
X-Originating-Location: Cagliari, Sardinia, IT (79.3.92.72)
X-Originating-Platform: Linux Firefox 75
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 06 May 2020 09:47:28 -0700
Message-ID: <bR66.1588783648151158143.yuJt@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="3aHAm7abG5lRZlMzYyXU"

--3aHAm7abG5lRZlMzYyXU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,
I am experimenting bbclass customization creating a very trivial task call=
ed do_marco() to get a list of the recipes built during a bitbake call.
I need to run this task each time bitbake is taking a recipe into account,=
 adding INHERIT +=3D "mycustom" in local.conf.

The problem is that whenever I modify the task source and I run bitbake I =
have a lot of recipes rebuilt as result.
Is this expected or there is anything to set to avoid that?
What is the best practice to debug a bbclass customization?

# mycustom.bbclass
python do_marco () {
package =3D d.getVar('PN', True)
version =3D d.getVar('PV', True)
s =3D "$ \"{0}\",\"{1}\"\n".format(package,version)
with open("marco.txt", "a") as logFile:
logFile.write(s);
}
do_package[postfuncs] +=3D "do_marco"

Thank you
--
Marco

--3aHAm7abG5lRZlMzYyXU
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,<br />I am experimenting bbclass customization creating a very trivia=
l task called do_marco() to get a list of the recipes built during a bitbak=
e call.<br />I need to run this task each time bitbake is taking a recipe i=
nto account, adding INHERIT +=3D "mycustom" in local.conf.<br /><br />The p=
roblem is that whenever I modify the task source and I run bitbake I have a=
 lot of recipes rebuilt as result.<br />Is this expected or there is anythi=
ng to set to avoid that?<br />What is the best practice to debug a bbclass =
customization?<br /><br /># mycustom.bbclass<br />python do_marco () {<br /=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; package =3D d.getVar('PN', True=
)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; version =3D d.getVar('PV'=
, True)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s =3D "$ \"{0}\",\"=
{1}\"\n".format(package,version)<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; with open("marco.txt", "a") as logFile:<br />&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logFile.=
write(s);<br />}<br />do_package[postfuncs] +=3D "do_marco"<br /><br />Than=
k you<br />--<br />Marco

--3aHAm7abG5lRZlMzYyXU--
