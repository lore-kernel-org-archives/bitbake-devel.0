Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by mx.groups.io with SMTP id smtpd.web12.3103.1585857069683917378
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Apr 2020 12:51:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmx.net header.s=badeba3b8450 header.b=Zkl1bfIw;
 spf=pass (domain: gmx.at, ip: 212.227.15.15, mailfrom: bernd.bauer@gmx.at)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1585857068;
	bh=+v2oAwcM6LjAZ+EAC6iKXyc9FVaRIXwwH9ZMOxffuHY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=Zkl1bfIwGxvim4aAOkBh3PhyCP6IVa/KDA3+Uwu25sXfz0fvL0LyTILAvEEUaOvx0
	 ldAX/1IW5XbqkOX1tOQJoV8vw5HWHsJ5EgY3e8K5VG2vokMNcUfKESR10uvcpWv4iD
	 lTRQ1Ys0WKNPXZ5eC2pjJP74utQXdXjd+FbKWXpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from berndtp.lan ([46.57.17.1]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1jQRWa2ACR-007Qtj; Thu, 02
 Apr 2020 21:51:07 +0200
From: "Bernd Bauer" <bernd.bauer@gmx.at>
To: bitbake-devel@lists.openembedded.org
Cc: Bernd Bauer <bernd.bauer@gmx.at>
Subject: [PATCH] Gitsm does not use credentials when cloning submodules
Date: Thu,  2 Apr 2020 21:51:04 +0200
Message-Id: <20200402195104.2405-1-bernd.bauer@gmx.at>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Provags-ID: V03:K1:Nb6hniQwnQRUaS3dq9Nt7b6KHODhIaflA3ovhVdFl17i2DsypbN
 br7bTi3kFtG/wlkQcN7+CfOJee/SUNuaSQKcYhP56bzPgk7sggx4cO5QGTe2r7SQfruD8HK
 3Ha8fg25oIYhz2MukSOonTmwKiKyOGzvV5fVmJZVSvIosykeInL9AutLfw03oSji94gm33L
 XNhb717433pNiMqFUmzfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8vjvDvSK9Tw=:HOURJDjA5AU0HQytBEvGId
 pCxOkCZCxtlsBsU6cFu3Bm/LHHrdN0dhlr1D3hmRUp3+NzmDLW2r9EpVl1ZYY7Y/u7B8+bzpM
 5nTBgJumfzpaLQfRtehLWbk6wXNXJLZsB75rxIvSThMoVfKrQjH72R9Wf/FBIml7U9BBqzfiu
 r9YGB4uI4Co4Z5W1m7eWrs6TnVEluMMrGRzd1Ts7CieD3EQ8TkQzocddQxFwqSswTkEg2Y59d
 b8irczjqh+Qcht7O6jZNkhaMrEsUK7cPbQ+wIQp4+MZKNrC896HtJr0uFN0+EzFZzC20VoH80
 fadgGEpUR7cF98NuQum6WXjfA2BU3EB+XcV4J+Lisat9pGI6QSrPqY91uDfCvxCSrT/qz2IAV
 jZ3vq2vQkokhDYMr+D5LuMo3WRivVXr0i9kFawoG20mAmaocokXP59943ntPuuReLWRI2e0UP
 xgilZHixLaWl8NyOt8+UZD39AjhGMs+1PhyxB9megACiBgRh9SAfKvWecGUEBk/xMTxEaz45J
 x9dy0fiO8mjLlUUtsXmyppE2BLABmODOLijOTyf9dton9/1+NRvLISSOz4L05wxGv8CLKmHEl
 5GmTnfpbdef6sqtGmSqQ3FItKYQqV7dzur/almf16qvFQvwDx4GeKrfFoOGyoM/rGhFq4kNlm
 79OFVG5sOIDc88k+vbB/OyDXKPUfxkZ43wliFWe/sJo5khLU4JjO+0XbFaCJbmYG0S9klv+s0
 eACX5bj1uByTZ9GVmFz4fi8hv+xeMaat7GKN7XRn9WWki6S0h8+Ko3FtYTM2c2xkOPGUqKxzj
 tdYwaC9n7g+K5RqomyxxttVfeEJI8WrbXfIvpYVG9cyllvKNobJwOMgW8oWHSWOC0av4RTnc5
 7ma6eq6oV9A/rDW2hpJJA0PD6RqMJge2SeVgvORvD+tvk3rGFUIa5ETbuF2FwEpx6XC96J0Q1
 xLEixsuJNoZVLig9IqudYw31qHN+PoQJhMTatMUMELhwJn6at2PcmnQ2q/RJDeKDa77qKWm1D
 rVqoco2lw9LTH6v1LvaoYfqF+t64j9BB+A/yYUu1X/hpK51B9LYye0QniT96T9GsftSBMAwdH
 kWxeae9zpDYCJKP3wDu04ng8dZS+2YmkFL7JQXly+PN9Ja8NJm4kwLQslaFcbO2yni0QdFVc0
 lpO/UuqTEFl31Mk0ODaJllvj47+BIXu8lROOKuabZ3svN8cw1D92Fw3af8vswX8Ks3jurvHfi
 d4fIGnHx+XQAiClYM
Content-Transfer-Encoding: quoted-printable

If the git server needs authentication the credentials are
encoded in the URL of the repositories.
The credentials from the main repository are deposited in the
recipe so main repository can still be cloned.

But the URLs from the submodules are listed in the .gitmodules
file.
The submodule url is encoded with an username and a password
or a bitbucket URL token. See example.

The password is not stored in the ud.user but in the ud.pswd
variable. So in this case the url is made up by ud.user and
ud.pswd.

Example:
[submodule "sub1"]
        path =3D sub1
        url =3D https://user:password@test.org/url/to/sub1

Signed-off-by: Bernd Bauer <bernd.bauer@gmx.at>
=2D--
 bitbake/lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5b3793a705..dc8f37b6c3 100644
=2D-- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -584,7 +584,9 @@ class Git(FetchMethod):
         """
         Return the repository URL
         """
-        if ud.user:
+        if ud.user and ud.pswd:
+            username =3D ud.user + ':' + ud.pswd + '@'
+        elif ud.user:
             username =3D ud.user + '@'
         else:
             username =3D ""
=2D-
2.17.1

