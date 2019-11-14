Return-Path: <raj.khem@gmail.com>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
	[209.85.222.194])
	by mail.openembedded.org (Postfix) with ESMTP id 81B307F87A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2019 02:54:57 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id z16so3754925qkg.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 18:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=KiCLzI3Av7yUDGpkKw6gh+3yCh093bTx7FXJGOHzc2g=;
	b=bCSyfvGHjT3wWHMSpT7MhcVPyY2jui3hRodZmRt+6lJdoP2bUfACLhtMrYGcikOgJP
	09u7unbmRI8MqjmDh/u4v02gf3RC0P1bYTYmDiIDrNSMIXUWVZUp49nX3/rnUTCeZ0GX
	hHTz8OtMuDRxJrwpD1aa55Hog4y7UIwMk4fE6GZgLmJHbYDzX1kpE8hxdhJONraV8Aqi
	Nl56e44RvC237ZABK83RBDs2M344LQSylwefiwAzHU1KViCAwN28EgSC6PTREMAiz+Dw
	+LEuzz+aX8asImTRqsqBrlx+GGJXLa14qARoPMOwFa+rJUYCQ+4iBjuvMcXUVcyRlnF4
	gS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=KiCLzI3Av7yUDGpkKw6gh+3yCh093bTx7FXJGOHzc2g=;
	b=Fdf55ENE5hgVJD5l7tDiync0CVBqDSggF1+YyJhQm05ZxiG757chFGJND4Og2TeHFH
	6AzoIUAJ+k4Cz+IiPG2risE84LIPoTnLdihhESEX5VHiZGNcPATs5PJOw0JEN4jeDoCF
	PjftpEWVMhYpp4vF/+9NdHw0T/M4y6Q6EMim3lXuNE8spfcdNNm5d9TzvvDbtrH4CLXx
	WxkShSAiPiSaCP033Oi+9tDSAGmoj4E732U4WzEebDLLDWpuvXttne54j1H3xMQNlpVI
	bFpwhPD2lCQ6aeMgGWb60/FoJEucz5+QE4DGYevGWmXVgVTvx0RrEEam1ClG84Skxw3s
	ulmQ==
X-Gm-Message-State: APjAAAVB/ajf+l9h7eGGL/bTgZ3lZ5LeNGvM6cINZ6h46sYhR34FkHNH
	iXbRR2TAek8C6WRTE0pxwcb6yCp0rZiZVVYXADejQwIU
X-Google-Smtp-Source: APXvYqw3hOcoMPzHWQNY2J/GWFni0+eFvximgzYKoHZIo5ZqmkdJDrdr+7CreoVDDC5/ZzPQ9LA6xgveGyL3iCXSP88=
X-Received: by 2002:a05:620a:a9a:: with SMTP id
	v26mr309774qkg.71.1573700098084; 
	Wed, 13 Nov 2019 18:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20191113232303.29047-1-anibal.limon@linaro.org>
In-Reply-To: <20191113232303.29047-1-anibal.limon@linaro.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 13 Nov 2019 18:54:31 -0800
Message-ID: <CAMKF1sqvx_ttxt+AhJ+1r+o4rt-z7VYNfSge5Du3N6mgjaYxJA@mail.gmail.com>
To: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linaro.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 14 Nov 2019 02:54:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 3:23 PM An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro=
.org> wrote:
>
> The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
> of directories to exclude when making taskhash, our specific case
> is using SRC_URI that points local VCS directory.
>
> In OE-Core this variable could be set by default to:
>
> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE =3D ".cvs .git .svn"
>

I like the approach.  perhaps a sane default would be nice.

> Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linaro.org>
> ---
>  lib/bb/checksum.py        | 5 +++--
>  lib/bb/fetch2/__init__.py | 4 ++--
>  lib/bb/siggen.py          | 5 +++--
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
> index 5bc8a8fc..677020f4 100644
> --- a/lib/bb/checksum.py
> +++ b/lib/bb/checksum.py
> @@ -74,7 +74,7 @@ class FileChecksumCache(MultiProcessCache):
>              else:
>                  dest[0][h] =3D source[0][h]
>
> -    def get_checksums(self, filelist, pn):
> +    def get_checksums(self, filelist, pn, localdirsexclude):
>          """Get checksums for a list of files"""
>
>          def checksum_file(f):
> @@ -90,7 +90,8 @@ class FileChecksumCache(MultiProcessCache):
>              if pth =3D=3D "/":
>                  bb.fatal("Refusing to checksum /")
>              dirchecksums =3D []
> -            for root, dirs, files in os.walk(pth):
> +            for root, dirs, files in os.walk(pth, topdown=3DTrue):
> +                [dirs.remove(d) for d in list(dirs) if d in localdirsexc=
lude]
>                  for name in files:
>                      fullpth =3D os.path.join(root, name)
>                      checksum =3D checksum_file(fullpth)
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 07de6c26..731c1608 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1197,14 +1197,14 @@ def get_checksum_file_list(d):
>
>      return " ".join(filelist)
>
> -def get_file_checksums(filelist, pn):
> +def get_file_checksums(filelist, pn, localdirsexclude):
>      """Get a list of the checksums for a list of local files
>
>      Returns the checksums for a list of local files, caching the results=
 as
>      it proceeds
>
>      """
> -    return _checksum_cache.get_checksums(filelist, pn)
> +    return _checksum_cache.get_checksums(filelist, pn, localdirsexclude)
>
>
>  class FetchData(object):
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index a4bb1ff7..f110fd72 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -123,6 +123,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
>
>          self.unihash_cache =3D bb.cache.SimpleCache("1")
>          self.unitaskhashes =3D self.unihash_cache.init_cache(data, "bb_u=
nihashes.dat", {})
> +        self.localdirsexclude =3D (data.getVar("BB_SIGNATURE_LOCAL_DIRS_=
EXCLUDE") or "").split()
>
>      def init_rundepcheck(self, data):
>          self.taskwhitelist =3D data.getVar("BB_HASHTASK_WHITELIST") or N=
one
> @@ -221,9 +222,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
>
>          if task in dataCache.file_checksums[fn]:
>              if self.checksum_cache:
> -                checksums =3D self.checksum_cache.get_checksums(dataCach=
e.file_checksums[fn][task], recipename)
> +                checksums =3D self.checksum_cache.get_checksums(dataCach=
e.file_checksums[fn][task], recipename, self.localdirsexclude)
>              else:
> -                checksums =3D bb.fetch2.get_file_checksums(dataCache.fil=
e_checksums[fn][task], recipename)
> +                checksums =3D bb.fetch2.get_file_checksums(dataCache.fil=
e_checksums[fn][task], recipename, self.localdirsexclude)
>              for (f,cs) in checksums:
>                  self.file_checksum_values[tid].append((f,cs))
>                  if cs:
> --
> 2.24.0
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

