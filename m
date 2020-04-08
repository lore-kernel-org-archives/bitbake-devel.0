Subject: Re: subversion authentication "--no-auth-cache"
To: bitbake-devel@lists.openembedded.org
From: daniel.litschauer@ta.co.at
X-Originating-Location: Traiskirchen, Lower Austria, AT (62.212.170.206)
X-Originating-Platform: Linux Firefox 68
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 08 Apr 2020 06:29:18 -0700
References: <d19eee01b70c08e4b66b5c5572677c5d1ba60439.camel@linuxfoundation.org>
In-Reply-To: <d19eee01b70c08e4b66b5c5572677c5d1ba60439.camel@linuxfoundation.org>
Message-ID: <21667.1586352558324810101@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="i2AhKL5KdG836dUrEjKW"

--i2AhKL5KdG836dUrEjKW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your reply!

I did test it now without the "use_auth_cache".

It works with the clear text caching at ~/.subversion/auth , but unfortuna=
tely it doesn't with the encrypted methods. It seems to me that this is the=
 case because svn is depending on another application to retrieve it. Do yo=
u have any clue what I am missing and how I can add it to the HOSTTOOLS (at=
 least I thing it needs to go there).

--i2AhKL5KdG836dUrEjKW
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Thank you for your reply!</p>
<p>I did test it now without the "use_auth_cache".</p>
<p>It works with the clear text caching at <em>~/.subversion/auth</em>, bu=
t unfortunately it doesn't with the encrypted methods. It seems to me that =
this is the case because svn is depending on another application to retriev=
e it. Do you have any clue what I am missing and how I can add it to the HO=
STTOOLS (at least I thing it needs to go there).</p>
<p>&nbsp;</p>

--i2AhKL5KdG836dUrEjKW--
