Subject: Re: [master][zeus][PATCH 3/3] fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"
To: bitbake-devel@lists.openembedded.org
From: "Khem Raj" <raj.khem@gmail.com>
X-Originating-Location: San Jose, California, US (73.63.224.124)
X-Originating-Platform: Mac Firefox 74
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 21 Mar 2020 14:44:23 -0700
References: <20200215032955.3958-3-pkj@axis.com>
In-Reply-To: <20200215032955.3958-3-pkj@axis.com>
Message-ID: <5532.1584827063458682607@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="c6ahriAqqL6FXGpQ18cC"

--c6ahriAqqL6FXGpQ18cC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

removing

if d.getVar('BB_SRCREV_POLICY') !=3D "cache":

Will cause autorevs to be excluded from policy and its not documented

https://www.yoctoproject.org/docs/2.1/bitbake-user-manual/bitbake-user-man=
ual.html#var-BB_SRCREV_POLICY

did not state that AUTOREVs plus BB_SRCREV_POLICY behavior, this patch is =
regressing the case
where we rely on this behavior to use externalsrc on AUTOREVed recipes.

--c6ahriAqqL6FXGpQ18cC
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

removing <br /><br />if d.getVar('BB_SRCREV_POLICY') !=3D "cache":<br /><br=
 />Will cause autorevs to be excluded from policy and its not documented <b=
r /><br /><a href=3D"https://www.yoctoproject.org/docs/2.1/bitbake-user-man=
ual/bitbake-user-manual.html#var-BB_SRCREV_POLICY" target=3D"_blank" rel=3D=
"noopener">https://www.yoctoproject.org/docs/2.1/bitbake-user-manual/bitbak=
e-user-manual.html#var-BB_SRCREV_POLICY</a><br /><br />did not state that A=
UTOREVs plus BB_SRCREV_POLICY behavior, this patch is regressing the case<b=
r />where we rely on this behavior to use externalsrc on AUTOREVed recipes.

--c6ahriAqqL6FXGpQ18cC--
