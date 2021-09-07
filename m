Subject: Re: [PATCH] cooker: Only warn on potentially incompatible layer
To: bitbake-devel@lists.openembedded.org
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
X-Originating-Location: Imielin, Silesia, PL (178.217.216.129)
X-Originating-Platform: Linux Firefox 91
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 07 Sep 2021 09:38:48 -0700
References: <CANNYZj88WpKLuHORum8vMnhW6UVWqJMYLDM1vz-+MX3uu3Lh7w@mail.gmail.com>
In-Reply-To: <CANNYZj88WpKLuHORum8vMnhW6UVWqJMYLDM1vz-+MX3uu3Lh7w@mail.gmail.com>
Message-ID: <13276.1631032728323594714@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="zfOl6uppEhdxYP3QAoBD"

--zfOl6uppEhdxYP3QAoBD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 7, 2021 at 05:49 PM, Alexander Kanavin wrote:

>Sorry, not possible. If dunfell branch doesn't do what you need it to, the=
 correct solution is to send patches for the branch, or backport the needed=
 changes into your internal copy of that layer. But certainly not to start =
mixing layer revisions from different releases and demand that this must be=
 supported and easy.

Thank you for the hints but they do not scale well in reality and the restr=
ictions LAYERSERIES_COMPAT imposes on the rest of the components simply res=
embles me the "rule of diversity"[0] from the Art of Unix programming.

[0] https://www.linuxtopia.org/online_books/programming_books/art_of_unix_p=
rogramming/ch01s06_15.html ( https://www.linuxtopia.org/online_books/progra=
mming_books/art_of_unix_programming/ch01s06_15.html )

--
Regards,
Damian

--zfOl6uppEhdxYP3QAoBD
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 7, 2021 at 05:49 PM, Alexander Kanavin wrote:<br />
<div class=3D"gmail_quote"><br />&gt;Sorry, not possible. If dunfell branch=
 doesn't do what you need it to, the correct solution is to send patches fo=
r the branch, or backport the needed changes into your internal copy of tha=
t layer. But certainly not to start mixing layer revisions from different r=
eleases and demand that this must be supported and easy.</div>
<div class=3D"gmail_quote"><br />Thank you for the hints but they do not sc=
ale well in reality and the restrictions LAYERSERIES_COMPAT imposes on the =
rest of the components simply resembles me the "rule of diversity"[0] from =
the Art of Unix programming.</div>
<br /><a href=3D"https://www.linuxtopia.org/online_books/programming_books/=
art_of_unix_programming/ch01s06_15.html" target=3D"_blank" rel=3D"noopener"=
>[0] https://www.linuxtopia.org/online_books/programming_books/art_of_unix_=
programming/ch01s06_15.html</a><br /><br />--<br />Regards,<br />Damian

--zfOl6uppEhdxYP3QAoBD--
