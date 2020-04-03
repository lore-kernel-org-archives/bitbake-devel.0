Subject: Re: Custom variable value: (OVERRIDES?)
To: bitbake-devel@lists.openembedded.org
From: "Duy" <duy.dang.yw@renesas.com>
X-Originating-Location: Ho Chi Minh City, Ho Chi Minh, VN (210.245.28.11)
X-Originating-Platform: Windows Firefox 72
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 03 Apr 2020 04:37:36 -0700
References: <6bce089d-050d-7c57-15ac-a182b548f694@faresoftware.it>
In-Reply-To: <6bce089d-050d-7c57-15ac-a182b548f694@faresoftware.it>
Message-ID: <8546.1585913856048757685@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="MKRDve3vzjzQOMedxDcX"

--MKRDve3vzjzQOMedxDcX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

I assume that you are working with poky/meta layer.
You can use conditional function from oe.utils library like this:

YOUR_VAR =3D "${@oe.utils.conditional("VAR_NAME", "compare_value", "value_=
if_true", "value_if_false", d)}"

myrecipe.bbappend:
FILE_NAME =3D "${@oe.utils.conditional("MY_VAR", "white", "white.txt", "de=
fault.txt", d)}"
do_install_append() {
install -m 0644 ${FILE_NAME} ${D}/etc/value
}

local.conf:
MY_VAR =3D "white"

Another way is using in-line python conditional statement:
FILE_NAME =3D "${@'white.txt' if 'white' in d.getVar('MY_VAR') else 'defau=
lt.txt'}"

If you want more than two values, consider using variable flag:
https://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-=
manual.html#variable-flag-syntax

Regards,
DD

--MKRDve3vzjzQOMedxDcX
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Mauro,<br /><br />I assume that you are working with poky/meta layer.<br=
 />You can use conditional function from oe.utils library like this:<br /><=
br />YOUR_VAR =3D "${@oe.utils.conditional("VAR_NAME", "compare_value", "va=
lue_if_true", "value_if_false", d)}"<br /><br />myrecipe.bbappend:<br />FIL=
E_NAME =3D "${@oe.utils.conditional("MY_VAR", "white", "white.txt", "defaul=
t.txt", d)}"<br />do_install_append() {<br />&nbsp;&nbsp;&nbsp; install -m =
0644 ${FILE_NAME} ${D}/etc/value<br />}<br /><br />local.conf:<br />MY_VAR =
=
=3D "white"<br /><br />Another way is using in-line python conditional sta=
tement:<br />FILE_NAME =3D "${@'white.txt' if 'white' in d.getVar('MY_VAR')=
 else 'default.txt'}"<br /><br /><br />If you want more than two values, co=
nsider using variable flag:<br /><a href=3D"https://www.yoctoproject.org/do=
cs/latest/bitbake-user-manual/bitbake-user-manual.html#variable-flag-syntax=
" target=3D"_blank" rel=3D"noopener">https://www.yoctoproject.org/docs/late=
st/bitbake-user-manual/bitbake-user-manual.html#variable-flag-syntax</a><br=
 /><br />Regards,<br />DD

--MKRDve3vzjzQOMedxDcX--
