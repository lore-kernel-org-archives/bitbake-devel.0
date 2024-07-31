Return-Path: <tomek.zyje@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2AC3DA7F
	for <webhook@archiver.kernel.org>; Wed, 31 Jul 2024 07:57:36 +0000 (UTC)
Subject: Gitsm and abosulte paths in .gitmodules file
To: bitbake-devel@lists.openembedded.org
From: tomek.zyje@gmail.com
X-Originating-Location: Torun, Kujawsko-Pomorskie, PL (87.205.53.87)
X-Originating-Platform: Linux Chrome 127
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 31 Jul 2024 00:57:31 -0700
Message-ID: <nPKy.1722412651485108083.wDd6@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="NybgNvwpjND1zHBx9BKl"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Jul 2024 07:57:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16441

--NybgNvwpjND1zHBx9BKl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,
I am having an issue with the way gitsm handles aboslute paths from .gitmod=
ules
file if ssh protocol is used.
When I add new module to some repo (as an example, I will use azure devops
here), normally I take the address by cloning it from repo site; example:
```
git@ssh.dev.azure.com:v3/TZ/proj/repo.git
```
Then add it to other repo with command
```
git submodule add git@ssh.dev.azure.com:v3/TZ/proj/repo.git path/repo-ext
```
which creates following entry in .gitmodules
```
[submodule "path/repo-ext"]
path =3D path/repo-ext
url =3D git@ssh.dev.azure.com:v3/TZ/proj/repo.git
```
When bitbake try to fetch it, it will put a warning about `relative ssh
reference`
```
myrecipe-0.1.0-r0 do_unpack: Submodule included by
gitsm://ssh.dev.azure.com/v3/TZ/proj/myrecipe;branch=3Dmain;rev=3Dxxxx;prot=
ocol=3Dssh
refers to relative ssh reference git@ssh.dev.azure.com:v3/TZ/proj/repo.git.
References may fail if not absolute.
```
IIUC the reference is absolute here. After looking at gitsm.py
https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/gitsm.py#n107 I saw=
 it
is looking for `:/`. Is that correct? Why there is distinction between `:` =
and
`:/`?
Or maybe it is a common practice to add submodules with `:/` instead of `:`=
?
I would gladly contribute, but maybe I do not understand the problem here. =
Can I
ask for some guidance?

--NybgNvwpjND1zHBx9BKl
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>
<div>Hello,</div>
<div>I am having an issue with the way gitsm handles aboslute paths from .g=
itmodules<br />file if ssh protocol is used.</div>
<div>When I add new module to some repo (as an example, I will use azure de=
vops<br />here), normally I take the address by cloning it from repo site; =
example:</div>
<div>```<br />git@ssh.dev.azure.com:v3/TZ/proj/repo.git<br />```</div>
<div>Then add it to other repo with command</div>
<div>```<br />git submodule add git@ssh.dev.azure.com:v3/TZ/proj/repo.git p=
ath/repo-ext<br />```</div>
<div>which creates following entry in .gitmodules</div>
<div>```<br />[submodule "path/repo-ext"]<br />&nbsp; &nbsp; path =3D path/=
repo-ext<br />&nbsp; &nbsp; url =3D git@ssh.dev.azure.com:v3/TZ/proj/repo.g=
it<br />```</div>
<div>When bitbake try to fetch it, it will put a warning about `relative ss=
h<br />reference`</div>
<div>```<br />myrecipe-0.1.0-r0 do_unpack: Submodule included by&nbsp;<br /=
>gitsm://ssh.dev.azure.com/v3/TZ/proj/myrecipe;branch=3Dmain;rev=3Dxxxx;pro=
tocol=3Dssh<br />refers to relative ssh reference git@ssh.dev.azure.com:v3/=
TZ/proj/repo.git.<br />References may fail if not absolute.<br />```</div>
<div>IIUC the reference is absolute here. After looking at gitsm.py<br />ht=
tps://git.openembedded.org/bitbake/tree/lib/bb/fetch2/gitsm.py#n107 I saw i=
t<br />is looking for `:/`. Is that correct? Why there is distinction betwe=
en `:` and<br />`:/`?</div>
<div>Or maybe it is a common practice to add submodules with `:/` instead o=
f `:`?</div>
<div>I would gladly contribute, but maybe I do not understand the problem h=
ere. Can I<br />ask for some guidance?</div>
</div>

--NybgNvwpjND1zHBx9BKl--

