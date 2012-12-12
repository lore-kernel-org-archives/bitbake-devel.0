Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eren@hambedded.org>) id 1TirUd-0004IN-Ip
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 19:57:20 +0100
Received: by mail-ee0-f47.google.com with SMTP id e51so691410eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Dec 2012 10:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=date:from:to:subject:message-id:mime-version:content-type
	:content-disposition:user-agent:x-gm-message-state;
	bh=j8Qa1Xt4Mx/tsBiKhUmbQ7Z+PCbxNhrKOJHs8XXLLnc=;
	b=LmIH85CKSyFpixIqR3xQ14O6qNtwZH0vRglEpNgqu3fs4SIv77vFmjV08VpGD/DFRf
	87RW3+xYNdolhKy4L/gICUWhFoQNi1CP+qfTtNihe91bLJyfUDEe/eC5uylzfQMucMue
	T3zVReH8a+gQ62OxDsZutVLzGatQN3QTr4VjI91pqwmFjT87I+sUrJK2n/DCT+kkWWRG
	wah9bgw8xiAYxyhUc7TAqCZ2ar2G1vJM20ijIMHKuGZRRyuhRnql9rTKqTBDbRjEL/tX
	jWQrfnB5lMziFtQTzgPJgu58jRQU3JvG0Z0MuxKhG868Gq1knUodtttYjAmz6vGkfsvj
	/iMg==
Received: by 10.14.178.196 with SMTP id f44mr5057878eem.14.1355337765894;
	Wed, 12 Dec 2012 10:42:45 -0800 (PST)
Received: from gmail.com ([46.196.117.99])
	by mx.google.com with ESMTPS id b2sm57536719eep.9.2012.12.12.10.42.43
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 12 Dec 2012 10:42:44 -0800 (PST)
Date: Wed, 12 Dec 2012 20:42:33 +0200
From: Eren =?iso-8859-1?Q?T=FCrkay?= <eren@hambedded.org>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20121212184156.GA743@gmail.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnuDRk5VPzAUJH0D6AcZsdPya9Bv5EWBceU6xEkEyMAEUYFFXzmi3jO6xwoO+SyR4/Y4Am5
Subject: [PATCH] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Wed, 12 Dec 2012 18:57:20 -0000
X-Groupsio-MsgNum: 3030
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline

--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently, *.bb and *.bbclass files are automatically highlighted and
detected as a bitbake file. Since *.bbappend files are also bitbake
files, vim plugin should automatically detect and highlight it as well.
---
 contrib/vim/ftdetect/bitbake.vim |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitbak=
e.vim
index 179e4d9..6822e24 100644
--- a/contrib/vim/ftdetect/bitbake.vim
+++ b/contrib/vim/ftdetect/bitbake.vim
@@ -11,7 +11,7 @@ if &compatible || version < 600
 endif
=20
 " .bb and .bbclass
-au BufNewFile,BufRead *.b{b,bclass}	set filetype=3Dbitbake
+au BufNewFile,BufRead *.b{b,bappend,bclass}	set filetype=3Dbitbake
=20
 " .inc
 au BufNewFile,BufRead *.inc 		set filetype=3Dbitbake
--=20
1.7.7.5

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Darwin)

iQIcBAEBAgAGBQJQyNAZAAoJEOM7bMm6HhcTTDoP/iN6JxXWe/4H3yGC2jVENMBF
ii2PRT/K67XyXvFxpFa65UOPjyDHhbeKvHNq/RwBgcIjDWeMA7UF5fb03Y9Imkuo
wUhjOKSJ8TmYWcueGbiL1gLVgvgU/ViWeZB8Zykq/cgHSsuQlse9pP+tAS0TLMyB
6KMdnUSCJjeozbSbslz03cH/1VvzChTqmmY+R1QepIQn4chuuYLqZrcjrW/d9qoR
MkS5qqBHmdtBhIbWFz0evMf2NS8vsG29D2PgQ+p+V3N5WIT4Q1M3T3WfmxLv9zGz
CFUlAQO1cti8Gyh1EMWm5VEJmTk+Tc/kAiZVYecFbTBsxjkjoUsZmOj7Lq9AK0Q5
WIH8qAUC/z+a5kiHsPJ2qVRFxNLpMB4LwmtF6zSkFLwnTrCJWcI/z7PFR7537E3R
428Pq6h12cUxYZgYvpJZkH9xBSqlhfh18FlSiXMWLtHqLT0BeHGHI8p9q5i+fKGi
yCHKQYEWwzNyXKxeDK6FW7X8zPwf4o6MDKrs7X++/ADZ1PYcaMSSWpKzs3gg4Pb8
M7abtDo/kJqQWmWHiAibuCYbZD5kVwOA4TLAVWRn1ebTRdgGLCHw6nyF8ZEgFF7J
XTpE4s2Kw98PFZ9LIgdREpcHaoDXbuBGYBXLi2VXOd1PfNZ4iToGXGHLdjRHcO/i
owmWUbureKNA7pmWz9wm
=vu1a
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
