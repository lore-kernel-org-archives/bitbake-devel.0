Subject: SDK deployment of a meta-package
To: bitbake-devel@lists.openembedded.org
From: scinteeb@gmail.com
X-Originating-Location: RO (82.79.95.216)
X-Originating-Platform: Linux Firefox 75
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 08 May 2020 07:32:48 -0700
Message-ID: <ZfeL.1588948368113444766.TdoY@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="HOnSrzAhaelEHGokyo9j"

--HOnSrzAhaelEHGokyo9j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am fairly new on using the Yocto project and I am at the beginning of my=
 learning curve. I have tried to find the information that I need on intern=
et but I couldn't identify any reference. That's why I am trying to get my =
answers here, if somebody is having the time for it.
I am trying to include the Poco library into the toolchain. For that I am =
adding in the local.conf the variable TOOLCHAIN_HOST_TASK_append =3D " poco=
 poco-dev". However, I am getting an error message on poco-dev saying that =
there is nothing to provide a certain poco library. Looking at the poco rec=
ipe file I saw that this is basically splitting the libraries in several rp=
m packages, and the poco rpm which is expected to install the libraries, do=
esn't contain any file, being a meta-package.
The question is: how can I deploy in the SDK the 'meta-package'?

Thanks for your time,
Bogdan.

--HOnSrzAhaelEHGokyo9j
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>&nbsp;&nbsp; Hello,<br /><br />&nbsp; I am fairly new on using the Yocto=
 project and I am at the beginning of my learning curve. I have tried to fi=
nd the information that I need on internet but I couldn't identify any refe=
rence. That's why I am trying to get my answers here, if somebody is having=
 the time for it.<br />I am trying to include the Poco library into the too=
lchain. For that I am adding in the local.conf the variable TOOLCHAIN_HOST_=
TASK_append =3D " poco poco-dev". However, I am getting an error message on=
 poco-dev saying that there is nothing to provide a certain poco library. L=
ooking at the poco recipe file I saw that this is basically splitting the l=
ibraries in several rpm packages, and the poco rpm which is expected to ins=
tall the libraries, doesn't contain any file, being a meta-package.<br />Th=
e question is: how can I deploy in the SDK the 'meta-package'?<br /><br />T=
hanks for your time,<br />Bogdan.</p>
<p>&nbsp;</p>

--HOnSrzAhaelEHGokyo9j--
