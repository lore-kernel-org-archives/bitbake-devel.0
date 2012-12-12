Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eren@hambedded.org>) id 1TitGA-0008NQ-6O
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 21:50:31 +0100
Received: by mail-ee0-f47.google.com with SMTP id e51so763997eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Dec 2012 12:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=date:from:to:subject:message-id:mime-version:content-type
	:content-disposition:user-agent:x-gm-message-state;
	bh=UIcI/lc3a/t8dA/IfS6TxXU8NRgVq7FnwBXXUz9UvVA=;
	b=OUsqD8IpQhVRQnjyvrS0fws4EphoZKoc70qeJ9gln1lALb3ef5/Br/pziJxJ4E5p7L
	gMvRDUPdJusu6VVsQSoKZxqhma5ibaB9XUdOudGiEHy6Qi6BvfpE7qcY0MUT5Be+eeQW
	0Mfn5w4eX6tNhd3CY/IhEAj72Z+1IDS42UsedGJXY6DOoDeWYPsqw5yNnqr37HxRl1S8
	9hrcwb9M3Fm8ptGLco4eZ+rWqp9PXM96fZt5req4tk7ZXN4q0x4exuCoyl2R9+M/SzU+
	4kvZLpe1anu75pA+GcopzFkZmbj/O+nt5DjuajLztIdSqCtA67kIfND/t5I9AdPPKRei
	X0PQ==
Received: by 10.14.221.9 with SMTP id q9mr5851943eep.3.1355344556419;
	Wed, 12 Dec 2012 12:35:56 -0800 (PST)
Received: from gmail.com ([46.196.117.99])
	by mx.google.com with ESMTPS id q44sm58123228eep.5.2012.12.12.12.35.53
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 12 Dec 2012 12:35:55 -0800 (PST)
Date: Wed, 12 Dec 2012 22:35:50 +0200
From: Eren =?iso-8859-1?Q?T=FCrkay?= <eren@hambedded.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <20121212203550.GD743@gmail.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlF692WmZA5Aue1rvl1ZUMafRoWAzAsvjn0pk+1WI/ggL1TDo1/7Zu+lLVAU86qEhPlf30q
Subject: [PATCH v2] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Wed, 12 Dec 2012 20:50:31 -0000
X-Groupsio-MsgNum: 3035
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Content-Disposition: inline

--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently, *.bb and *.bbclass files are automatically highlighted and
detected as a bitbake file. Since *.bbappend files are also bitbake
files, vim plugin should automatically detect and highlight it as well.
---
 contrib/vim/ftdetect/bitbake.vim |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitbak=
e.vim
index 179e4d9..b9529e6 100644
--- a/contrib/vim/ftdetect/bitbake.vim
+++ b/contrib/vim/ftdetect/bitbake.vim
@@ -10,8 +10,8 @@ if &compatible || version < 600
     finish
 endif
=20
-" .bb and .bbclass
-au BufNewFile,BufRead *.b{b,bclass}	set filetype=3Dbitbake
+" .bb, .bbappend and .bbclass
+au BufNewFile,BufRead *.{bb,bbappend,bbclass}	set filetype=3Dbitbake
=20
 " .inc
 au BufNewFile,BufRead *.inc 		set filetype=3Dbitbake
--=20
1.7.7.5

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)

iQIcBAEBAgAGBQJQyOqmAAoJEOM7bMm6HhcTZUgQAJzkEo/w9yEpn/AeLOmBV8wa
o1LIWGLiMCVHYQR73WSLu4zhJHhP/OhyExqWa9tR9PND479oGKmm8LDXPDtgPCUP
BbvTaEwEoSL4zR+iSWp6LWMN3BISQNKEAdkLo0U8xI26lHdGlVV4zzYsuqo5bQH4
pZMI/M9ZtT3UTNKuof/UJzSPoUadyGx5J6e8GpuLU+KZWxhbVMj+LAjncnP2WNI2
BvTgUOAzMY6NoSSmgGSjRqRQq0Y5AayI/6NhHYqkYl2hUr5WPzbff6eE9gQkGJAa
GY7k665G8DzMP+gT23xWsJQ80xNLbu+PzQWPDxxHztb38iCyKDJgPDQ13DJXTB7k
0dRGW7K9lk7eJn9uWiTxN1nQQiHUmjEUyABjqV+G50PBXp+O5xzarZm4i0oXU1l2
Ce3TD5WxG3j7ig90d9QOvYfn1B7PNICGbqHYfptG59L7q+ruixcHP+tkh2z46NRB
VBxMqySKJYZQmCoYXqGpOuLSfBtmCu6a8a+rrhYQuGdAvZJDuATCLptgWktCcqjO
X2tXJtncCzSQ9O41kePfP+ZqRyCUYrEU8cKv0xgnGM1iiRMI1MdYRNkwfUBZKiLA
zZo6zRV+pi4knQnIxJKmvvuNG1b3oLhnqKROCkTt20GTmcTGIgyUwyFN2SAyKhOq
WuGovP2r1sshva9ewfkI
=F/6w
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--
