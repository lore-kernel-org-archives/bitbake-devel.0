Subject: subversion authentication "--no-auth-cache"
To: bitbake-devel@lists.openembedded.org
From: daniel.litschauer@ta.co.at
X-Originating-Location: Hoheneich, Lower Austria, AT (62.212.170.206)
X-Originating-Platform: Linux Firefox 68
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 30 Mar 2020 06:15:34 -0700
Message-ID: <CwqZ.1585574134967741661.NXjx@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="xexNAXlN0YwmJqsLxEDq"

--xexNAXlN0YwmJqsLxEDq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I know variations of this question already popped up a few times, but I wa=
sn=E2=80=99t able to find a answer that satisfied my needs.

Authentication when using subversion can be as easy as typing:

SRC_URI =3D "svn://myrepos/proj1;module=3Dvip;protocol=3Dhttp;rev=3D667;us=
er=3Duser;pswd=3Dpassword"

As I said easy, but with the drawback that I have to save my username and =
password to a textfile. Subversion usually tries to find client credentials=
 in a =E2=80=9C GNOME Keyring =E2=80=9D , =E2=80=9C KDE Wallet =E2=80=9D , =
or =E2=80=9C GnuPG Agent =E2=80=9D service and if there is nothing to find =
at ~/.subversion/auth. Read about it if you are interested ( http://svnbook=
.red-bean.com/nightly/en/svn.serverconfig.netmodel.html#svn.serverconfig.ne=
tmodel.credcache ).

But this "system" is blocked by bitbake in the svn.py file ( https://githu=
b.com/openembedded/bitbake/blob/master/lib/bb/fetch2/svn.py ). At line 78 i=
t states: options. append ( "--no-auth-cache" )

Is there a reason for this that I am not thinking about? And if there is n=
o reason for this would it be possible to add a switch for this?

SRC_URI =3D "svn://myrepos/proj1;module=3Dvip;protocol=3Dhttp;rev=3D667;us=
er=3Duser;use_auth_cache=3Dno"

Thank you in advance.

Yours sincerely,

Daniel

--xexNAXlN0YwmJqsLxEDq
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Hello,</p>
<p>I know variations of this question already popped up a few times, but I=
 wasn&rsquo;t able to find a answer that satisfied my needs.</p>
<p>Authentication when using subversion can be as easy as typing:</p>
<pre class=3D"literallayout">SRC_URI =3D "svn://myrepos/proj1;module=3Dvip=
;protocol=3Dhttp;rev=3D667;user=3Duser;pswd=3Dpassword"</pre>
<p>As I said easy, but with the drawback that I have to save my username a=
nd password to a textfile. Subversion usually tries to find client credenti=
als in a <span class=3D"quote">&ldquo;<span class=3D"quote">GNOME Keyring</=
span>&rdquo;</span>, <span class=3D"quote">&ldquo;<span class=3D"quote">KDE=
 Wallet</span>&rdquo;</span>, or <span class=3D"quote">&ldquo;<span class=
=3D"quote">GnuPG Agent</span>&rdquo;</span> service and if there is nothin=
g to find at <em>~/.subversion/auth</em>. <a href=3D"http://svnbook.red-bea=
n.com/nightly/en/svn.serverconfig.netmodel.html#svn.serverconfig.netmodel.c=
redcache" target=3D"_blank" rel=3D"noopener">Read about it if you are inter=
ested</a>.</p>
<p>But this "system" is blocked by bitbake in the <a href=3D"https://githu=
b.com/openembedded/bitbake/blob/master/lib/bb/fetch2/svn.py" target=3D"_bla=
nk" rel=3D"noopener">svn.py file</a>. At line 78 it states:<em> <span class=
=
=3D"pl-s1">options</span>.<span class=3D"pl-en">append</span>(<span class=
=3D"pl-s">"--no-auth-cache"</span>)</em></p>
<p>Is there a reason for this that I am not thinking about? And if there i=
s no reason for this would it be possible to add a switch for this?</p>
<pre class=3D"literallayout">SRC_URI =3D "svn://myrepos/proj1;module=3Dvip=
;protocol=3Dhttp;rev=3D667;user=3Duser;use_auth_cache=3Dno"</pre>
<p>Thank you in advance.</p>
<p>Yours sincerely,</p>
<p>Daniel</p>

--xexNAXlN0YwmJqsLxEDq--
