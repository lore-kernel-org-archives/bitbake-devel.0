Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <aiswaryassn@gmail.com>) id 1Se2VG-0003vI-HT
	for bitbake-devel@lists.openembedded.org;
	Mon, 11 Jun 2012 13:09:46 +0200
Received: by lags15 with SMTP id s15so2389585lag.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Jun 2012 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=8bvAwy9mtKy3am4BOBjhqu47XQmdrEuIAoxwAi/Zxbw=;
	b=V7lTrAIa6XJet+4Pwi28K5s/3k/wp+GDBJES8SvQjWgl6ZkRbpIo/w1vzU7uEtRRyw
	uVZebUPgVWmt+YT5OBY6GNH1njvIjwJlxnHvnakL1v3YSEupiV8J3Vg6Gzr/h4gdD5M3
	GqYIfeIUIFsA6A1KQYlO67UBOlH6QIAPFwooKRcgLrTpQxuU9wcthGCThloWsYODV03X
	GbTzH56BafK+qZcZkaG+Hbmuj0HVAGyGRxEebhvUx3cyXLXhwcwb8Qq2lQdtsWSHldgx
	nLwWqOtVx5tq9vSAazMTmjDYQxPPoqs1pzLLUEquI0YyGw8bT3jkEXO424OaEoLGUNx1
	TeKw==
MIME-Version: 1.0
Received: by 10.112.83.136 with SMTP id q8mr2950097lby.60.1339412353092; Mon,
	11 Jun 2012 03:59:13 -0700 (PDT)
Received: by 10.112.24.100 with HTTP; Mon, 11 Jun 2012 03:59:13 -0700 (PDT)
Date: Mon, 11 Jun 2012 06:59:13 -0400
Message-ID: <CAHqtJk6YhyUPSa_ijguUkXHV6PwS8esexNHDpQK9w+GoNoF8GA@mail.gmail.com>
From: aiswarya mohan <aiswaryassn@gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Thu, 14 Jun 2012 15:17:07 +0200
Subject: Regarding Bitbake parsing error
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
X-List-Received-Date: Mon, 11 Jun 2012 11:09:46 -0000
Content-Type: multipart/alternative; boundary=f46d04016d8f838d8804c2303d45

--f46d04016d8f838d8804c2303d45
Content-Type: text/plain; charset=ISO-8859-1

Hello!

We set the configurations of Openembedded and Bitbake as per the user
manual.
The PATH AND BBPATH values have also been set appropriately.

But then when we tried to build the opie-image.bb (sample from recipes
folder), it lead to the following error:


*enggdesign@ubuntu:~/Desktop/OE/build$ export
BBPATH=/Desktop/OE/build:/Desktop/OE/openembedded
enggdesign@ubuntu:~/Desktop/OE/build$ bitbake opie-image.bb
ERROR: Unable to parse conf/bitbake.conf: file conf/bitbake.conf not found
in /Desktop/OE/build:/Desktop/OE/openembedded*

We also noticed that bitbake.conf was not found in the build/conf directory.

Kindly get back to us as soon as possible.

Regards,
Abhinaya
Aiswarya

--f46d04016d8f838d8804c2303d45
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello!<br><br>We set the configurations of Openembedded and Bitbake as per =
the user manual.<br>The PATH AND BBPATH values have also been set appropria=
tely.<br><br>But then when we tried to build the <a href=3D"http://opie-ima=
ge.bb">opie-image.bb</a> (sample from recipes folder), it lead to the follo=
wing error:<br>
<br><br><b>enggdesign@ubuntu:~/Desktop/OE/build$ export BBPATH=3D/Desktop/O=
E/build:/Desktop/OE/openembedded<br>enggdesign@ubuntu:~/Desktop/OE/build$ b=
itbake <a href=3D"http://opie-image.bb">opie-image.bb</a><br>ERROR: Unable =
to parse conf/bitbake.conf: file conf/bitbake.conf not found in /Desktop/OE=
/build:/Desktop/OE/openembedded</b><br>
<br>We also noticed that bitbake.conf was not found in the build/conf direc=
tory.<br><br>Kindly get back to us as soon as possible.<br><br>Regards,<br>=
Abhinaya<br>Aiswarya<br>

--f46d04016d8f838d8804c2303d45--
