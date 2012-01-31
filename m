Received: from mail-lpp01m020-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1RsFrd-0006O6-8j
	for bitbake-devel@lists.openembedded.org;
	Tue, 31 Jan 2012 16:43:21 +0100
Received: by lbol12 with SMTP id l12so13743lbo.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Jan 2012 07:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=ysg9HLx0sWh3HDVi4r/FZ+r47g0XZS9sgvGxBEGjf3Q=;
	b=j4KVNHF1YAQdjvTGPcNXd+K5BfUYfRxLV/lAOiOQjoITXIFnybUcah1nTkCtz662S5
	O7Pww0phSc71I/58I95jlkE3kBL/ryherftb2+o/7kddmLcTB+jSo1rs+jbS1nonm8ub
	8O48kx5LfEE9skGiZV/DNTkkDOWen4KbovWQ4=
Received: by 10.112.32.1 with SMTP id e1mr5849397lbi.3.1328024127317; Tue, 31
	Jan 2012 07:35:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.152.5.201 with HTTP; Tue, 31 Jan 2012 07:34:57 -0800 (PST)
In-Reply-To: <fe0512a8af642c0b23a9fbbb6aa82953b9e17313.1327990542.git.lianhao.lu@intel.com>
References: <cover.1327990542.git.lianhao.lu@intel.com>
	<fe0512a8af642c0b23a9fbbb6aa82953b9e17313.1327990542.git.lianhao.lu@intel.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 31 Jan 2012 07:34:57 -0800
Message-ID: <CAMKF1spcm_oavug_GV15uwnjGcc-saa=xeCxa1mocEMy4iBt9A@mail.gmail.com>
To: Lianhao Lu <lianhao.lu@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] prserv: Do not ping PRService if not required
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
X-List-Received-Date: Tue, 31 Jan 2012 15:43:21 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2012 at 10:18 PM, Lianhao Lu <lianhao.lu@intel.com> wrote:
> [YOCTO #1942]
> Ping the PRService only if PRSERV_HOST and PRSERV_PORT are set.
>
> Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
> ---
> =C2=A0bitbake/lib/prserv/serv.py | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
> index fa437f9..5567c6f 100644
> --- a/bitbake/lib/prserv/serv.py
> +++ b/bitbake/lib/prserv/serv.py
> @@ -268,7 +268,7 @@ def is_local_special(host, port):
>
> =C2=A0def auto_start(d):
> =C2=A0 =C2=A0 global singleton
> - =C2=A0 =C2=A0if d.getVar('USE_PR_SERV', True) =3D=3D '0':
> + =C2=A0 =C2=A0if (not d.getVar('PRSERV_HOST', True)) or (not d.getVar('P=
RSERV_PORT', True)):


should it warn in case when USE_PR_SERV is set but one of PRSERV_HOST
or PRSERV_PORT are unset

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return True
>
> =C2=A0 =C2=A0 if is_local_special(d.getVar('PRSERV_HOST', True), int(d.ge=
tVar('PRSERV_PORT', True))) and not singleton:
> --
> 1.7.0.4
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


