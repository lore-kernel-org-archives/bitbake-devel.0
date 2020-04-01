Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web10.4926.1585768669642430386
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Apr 2020 12:17:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmx.net header.s=badeba3b8450 header.b=COBS6rR3;
 spf=pass (domain: gmx.at, ip: 212.227.17.22, mailfrom: bernd.bauer@gmx.at)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1585768667;
	bh=HSdb+40f2ASp6dcKxK8H3r6n81UWXCPZYTmr8atwBoo=;
	h=X-UI-Sender-Class:Reply-To:To:From:Subject:Date;
	b=COBS6rR33ohO6c9NKNiULJnduEhxJJwsOMxibj+LHzlaisNJBikw8UWomHeKYIxL1
	 XfPdJx8dNxHOL+Vcl82xw0eObpWiZk6xr5mX/eShLP/Ysk21dfLmPGh4k8VtWc6Bte
	 vY0Kbb4AFsCSDToTWH28ROW5nl2svHqc0YdtSbLM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.120] ([46.57.17.1]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3mt-1jn2Mi1SSx-00TWdN for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Apr 2020 21:17:47 +0200
Reply-To: bernd.bauer@gmx.at
To: bitbake-devel@lists.openembedded.org
From: "Bernd Bauer" <bernd.bauer@gmx.at>
Subject: Gitsm does not use credentials when cloning the submodules
Autocrypt: addr=bernd.bauer@gmx.at; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a8d54563-8041-73dd-e494-b2d087b20d7a@gmx.at>
Date: Wed, 1 Apr 2020 21:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
X-Provags-ID: V03:K1:Pi57Azd7RO9JwUeqoUJDsE4Ado2ZuAeorP3SLzVWHNwooo6JwOV
 0NrM7vw/mWynefwrh7CHjFF5KSRHukPfrn4+PWMR60G80Lodxnp4C74tmXgAPCQPJ85mPNn
 Rb4veFN9OtYfpLsICh8+UKdZt4hHRKmmPscOL4oi6zb1yux10oneCsCa8fDx0/P1UEo2t+Z
 GwPoizTKa942UsCfvfSVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SNx3v8YxoQo=:kIa3sYaRpCCPyd8AZVzlMm
 cZcAO+MNMOFIjl5mK2jRaQihpNsfb5kR37N1zPZpbU0t/kVu7Ge9VJLFB62MwVrAQYTMnjMXz
 23HscEK7z0LmU4W/yzBXVuUQOVUbypTcAmVr8+hRvgFlkKqln4e2m/hb3P6Q81HoebUuxkzDz
 BBXVOJI/wim9Sxcz7Wi3RbBQ9oFVrKUZHT3gPWsMpQM64c4qAHqwSfsVmnVwya1zhb+xDt1jK
 d3Y5idBN1AMu0qWTRINwIo29LESqzo7sl5tUniuapB3bhSmLZh32xHFePlmDzOa8dGGONb8X4
 vw7B9E/PBkT9ZlTsdywID9YxVGUzRg3roThKjXnIsQkATEVwtziCZjQNH4zG5rli/JHyZMZrD
 2+1aEF3/CFFt3lAi5eLgGboNqOw4a5zIFcoF9pRC7HL2gO6Rs6MT9Z1Txdwoua0xsWcwUBIqK
 GsLIX5xSN93u3y3WzhF/nEPieJziA1OjnsSOihEqKzXNQoQn7HsdlyIHPFS2qUJkpFx5oLVUl
 sQWxUGlMm6vWIO0THrNTUWa9nufjLueMdoPVfIy/0G7IqGOLuSiqFrCaRON23eI2CqmG229Bl
 NNTGsrd7B5NsFWEJdVcNfmb0ChY82HE/Dn4oPu/487/AVMMSkU8mvtkAH3Jrc5a8hV7SY6S/7
 GPwJXpxX/Pzk8XtciMhYP7xdAqI/8437oPNikbrcZVwITCdvHSEzIwLJ9/ZKouTbqzUcZuYwQ
 0iFJJgLOr0y0y/NEtFT9ChiDOdjGwSI4iJyLO08LMsftYOdKYAGdbhA4vJJWhxD+IoYHSwceU
 RC/neFQlrZjvgLWpt8WmewROZ4Bl0L1WgihkGQKsyRv2PSPGJnRuq4fXiLxD0Am74WtN2PKk+
 ozuzm6kDDroTz53AKuprXgA4NlysYkdnNowwNIJhWdsSup7fjbRhgpAY8i6wLM/+O0LcDtEwW
 EgvzvV2KAKdbuUxIAuCZ6tsAE+dX7IA3UxuVlI2F0z9t5VnF0Qv2gbWBelmWfUcZxbYNw2oni
 ZisI8h9iaGaBicwPuyIldWq127LMHSBpRcQN0CUnYSvzZp8aHyf2n5n1327IF3BjGtfpxA4nl
 f59aHRHZ8Y3oPB7g+y+Uvco5sDMR60kiRkWVHJUXwzUOS66F1OTvoO0rLj1r85Qh3KKEklEFD
 tSK+W3y4heGv07bFzgBtYHqvWKHCKw7uEiqSrqrT7itUP6lTOvq86z9fRIxpJKWXsMwiBVagS
 bC+MjUcq5LFlHKKoz
X-Groupsio-MsgNum: 11232
Content-Type: multipart/mixed;
 boundary="------------57A32369313C235E0E85DAD5"
Content-Language: de-DE

--------------57A32369313C235E0E85DAD5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I think I have found a bug in the bitbucket git sumbodule fetcher.

In my example I try to clone a repository with submodules using gitsm.
The git server here needs authentication. Also for the submodules.
These credentials are encoded in the URL of the submodule.
See example below.
The main repo can still be cloned because the credentials are stored
in the recipe itself.
But for the submodules, the password is not used.

My patch uses the password if one is available.

I have found the bug in poky warrior branch that I'm currently using.
In the fido branch gitsm works with username and password.
(I know... fido is quite old, but I'm also using this version.)

Example .gitmodules
=2D--------------------------------------------------------
[submodule "sub1"]
        path =3D sub1
        url =3D https://user:password@test.org/url/to/sub1
=2D--------------------------------------------------------

Greets Bernd
=2D-
| |O| | Bauer Bernd
| | |O| Sicher ist vi benutzerfreundlich,
|O|O|O| es ist nur eigen in der Wahl seiner Freunde.

--------------57A32369313C235E0E85DAD5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Add-password-to-repo-url-if-available.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-Add-password-to-repo-url-if-available.patch"

From baa4dd493c2f3787b53dc6a3e8d62a4df71f448c Mon Sep 17 00:00:00 2001
From: Bernd Bauer <bernd.bauer@gmx.at>
Date: Fri, 27 Mar 2020 10:30:49 +0100
Subject: [PATCH] Add password to repo url if available

To clone a repo with submodules the first repo url to fetch
is deposited in the recipe.
But the URLs from the submodules are listed in the .gitmodules
file.
If the submodule url is an https with an username and a password
(or a bitbucket URL token) the password is not in the ud.user
but in the ud.pswd variable.
So in this case the url is made up by ud.user and ud.pswd.

Signed-off-by: Bernd Bauer <bernd.bauer@gmx.at>
---
 bitbake/lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 80caf109b1..09c8bb2f2b 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -572,7 +572,9 @@ class Git(FetchMethod):
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
--
2.22.2


--------------57A32369313C235E0E85DAD5--
