Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1RDgo5-0006dF-2I
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Oct 2011 20:12:02 +0200
Received: by qadc1 with SMTP id c1so5189484qad.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Oct 2011 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=5W1pU9dB1uDhfgBFck6fm5FtF/e3n+Kk2BpA5z3Yk54=;
	b=Aphy3erR5rP07G1RvB+VifuyCEvM6E9h8+a97SpyJ5bzdLOZ1m+TrcAvCV5jz/R8RE
	n2FUMzSdpLXc8bz/R3cHqVQfDY7UKKQxnRCiffLeHj9wulNXd8PHHEmJHaSNf3gfm7mA
	7McDcfkM3sAc4aBRT2qzBvkDtYbxDtA5BDQAc=
Received: by 10.68.7.202 with SMTP id l10mr47784936pba.22.1318356374118; Tue,
	11 Oct 2011 11:06:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.49.129 with HTTP; Tue, 11 Oct 2011 11:05:44 -0700 (PDT)
In-Reply-To: <74d583f1aeecf8d112a2b24d4c4a234fbadf8470.1318352470.git.josh@linux.intel.com>
References: <cover.1318352470.git.josh@linux.intel.com>
	<74d583f1aeecf8d112a2b24d4c4a234fbadf8470.1318352470.git.josh@linux.intel.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 11 Oct 2011 11:05:44 -0700
Message-ID: <CAMKF1srRT6hOkzntfOWyTnEm4mBhx6sQu1UwZk74ESe8gayyxg@mail.gmail.com>
To: Joshua Lock <josh@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] fetch2: enable checksum definition as SRC_URI parameter
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
X-List-Received-Date: Tue, 11 Oct 2011 18:12:02 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2011 at 10:07 AM, Joshua Lock <josh@linux.intel.com> wrote:
> URI parameters should be able to be defined as a parameter of the SRC_URI=
,
> this patch enables thus for checksums.
>
> An example;
>
> SRC_URI =3D "http://pkgconfig.freedesktop.org/releases/pkg-config-${PV}.t=
ar.gz;md5sum=3Da3270bab3f4b69b7dc6dbdacbcae9745;sha256sum=3D3ba691ee2431f32=
ccb8efa131e59bf23e37f122dc66791309023ca6dcefcd10e"

this should go into manual/documentation as well.

>
> Addresses the remainder of [YOCTO #1399]
>
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
> =C2=A0lib/bb/fetch2/__init__.py | =C2=A0 10 ++++++++--
> =C2=A01 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index b2b9d5c..6c3886b 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -562,8 +562,14 @@ class FetchData(object):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.md5_name =3D "md5sum"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sha256_name =3D "sha256sum=
"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0self.md5_expected =3D bb.data.getVarFlag("SR=
C_URI", self.md5_name, d)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sha256_expected =3D bb.data.getVarFlag(=
"SRC_URI", self.sha256_name, d)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.md5_name in self.parm:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.md5_expected =3D self.par=
m[self.md5_name]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.md5_expected =3D bb.data.=
getVarFlag("SRC_URI", self.md5_name, d)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.sha256_name in self.parm:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sha256_expected =3D self.=
parm[self.sha256_name]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.sha256_expected =3D bb.da=
ta.getVarFlag("SRC_URI", self.sha256_name, d)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.names =3D self.parm.get("name",'default'=
).split(',')
>
> --
> 1.7.6.4
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>


