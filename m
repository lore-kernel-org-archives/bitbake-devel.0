Return-Path: <ricardo@foundries.io>
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
	[209.85.167.42])
	by mail.openembedded.org (Postfix) with ESMTP id 53F52799D0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 18:51:33 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id y10-v6so7587338lfj.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Oct 2018 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=foundries-io.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=8eusoiCnpqZRsUBZQNkSLCr2kdxf6RwIqLKrhpwULNA=;
	b=hNjHANZvyDFaNCMBw0Xb7D8VDc4VeezP/Di90tn/K5MzanXeQpybra7dgaNijc5pOy
	haxKJSmXp8VHt1OGAf7mpeJ12rkDnU2PoSvdGCILrc32TWNhTsBovklO1128dA33m/G8
	qt06LsxbFiU2IhFPE0Ap4k1UCQpMSiaLSkwCoPyKBlmOi1FeNACrNHg5tDPqgxFdwn3A
	JxdKt9II6ARsVwWGtYOspyiWixK66b3rcn2JOAqzNsxmUb/yF30hcTnSZEtespjU0/wO
	XxfOJE4ybY5DOjFCuJxY+3Cn8DCc9ocvFsg3b80yxQQFYn1dKLNNBVqGgcPxlkNrlMXs
	zXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=8eusoiCnpqZRsUBZQNkSLCr2kdxf6RwIqLKrhpwULNA=;
	b=J4x/0dUNykeRteJcADfuEECj10mvrTCWCpmMyTmet50yZ7TLvWcToOrhPNAtM5hSO5
	eQ1HAxISabGjEFmTGPXv0ebWpw7wnrvhccexBrkzx474FjZqcu6LndCk631t9vOtQvV1
	I0sxjSv9D9C+SGlO9TIBMYF75tsUVfwa+KXzsndxX57HOwYDXbwxonCBohJhcWavifVE
	9zDkILDmKbApVPFat03B1jd9D6beSM0ktiBfA1muwSzVfefVAehDerRG2uelERGSqK+x
	goi18/TWRMtuaScWQw/bHy+xtXcSgLn1XFUm9NXGj9Ddj3LRlcF7sgUUBGqLpJF0OoJt
	y+8g==
X-Gm-Message-State: ABuFfogMkteihdiomuiesSEwXzSZgew9AXK6cCBTYPS7K5ZUS671t2Mz
	6TlSCAVhovGL98NzH7eklA8jZugA9t1DDa7PFGk8
X-Google-Smtp-Source: ACcGV63oMxncUyTfMavzs4MsUuFjVAqEQhY7oef0Xdx549ae3n2yAab79cUXj3vuhUaorxXmaaqqPSzM/wVTp3JzwM4=
X-Received: by 2002:a19:4e51:: with SMTP id
	c78-v6mr4092018lfb.79.1538679093485; 
	Thu, 04 Oct 2018 11:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <bfa936254124b13689c89dcee2a4e427@agner.ch>
	<5116fcfb-f5b2-dbf3-afd7-ccbfb98e041d@windriver.com>
In-Reply-To: <5116fcfb-f5b2-dbf3-afd7-ccbfb98e041d@windriver.com>
From: Ricardo Salveti <ricardo@foundries.io>
Date: Thu, 4 Oct 2018 15:51:20 -0300
Message-ID: <CAAaKDhF0T6r432bFFDNA=sxU63Axwus83qALpxWFJsmNM+d=PQ@mail.gmail.com>
To: mark.hatle@windriver.com
X-Mailman-Approved-At: Thu, 04 Oct 2018 22:06:09 +0000
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: git submodule fetcher regression
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
X-List-Received-Date: Thu, 04 Oct 2018 18:51:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 4, 2018 at 1:47 PM Mark Hatle <mark.hatle@windriver.com> wrote:
>
> On 10/4/18 11:08 AM, Stefan Agner wrote:
> > [resend, this time with me being subscriber of bitbake-devel]
> >
> > Hi,
> >
> > It seems that 9c6b39adf978 ("fetch2/gitsm.py: Rework the git submodule =
fetcher") broke git submodules in some cases. My particular case is aktuali=
zr from meta-updater (https://github.com/advancedtelematic/meta-updater). F=
etching aktualizr reliably fails for me now:
> >
> > ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_unpack: Fetcher failure=
: Submodule tests/tuf-test-vectors does not exist in /home/ags/oe/downloads=
/git2/github.com.advancedtelematic.aktualizr/modules/tests/tuf-test-vectors=
 or
> > /home/ags/oe/build-colibri-imx7/tmp-oe/work/armv7at2hf-neon-lmp-linux-g=
nueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/git/.git/modules/tests/tuf-tes=
t-vectors.
> > ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_unpack: Function failed=
: base_do_unpack
> > ERROR: Logfile of failure stored in: /home/ags/oe/build-colibri-imx7/tm=
p-oe/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15=
e31f-7/temp/log.do_unpack.35143
> > ERROR: Task (/home/ags/oe/build-colibri-imx7/conf/../../layers/meta-upd=
ater/recipes-sota/aktualizr/aktualizr_git.bb:do_unpack) failed with exit co=
de '1'
> >
> > Any idea what that could be?
>
> See the mailing list archives (or master-next branch).  There are a small=
 series
> of pending patches.  Please try these.
>
> 3 from Laurent Bonnans
> 1 from me

Tested with latest bitbake from master-next and latest aktualizr from
meta-updater and it seems functional again, looks like the patches
from Laurent are already enough (up to the checkout submodules
recursively).

Trying a completely clean build now to see if there are any other regressio=
ns.

Cheers,
--=20
Ricardo Salveti

