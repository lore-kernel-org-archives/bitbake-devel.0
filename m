Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Greylist: delayed 451 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 01 Dec 2019 20:14:25 UTC
Received: from mail.cvg.de (mail.cvg.de [193.158.56.148])
	by mail.openembedded.org (Postfix) with ESMTP id 86D9E7F59D
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  1 Dec 2019 20:14:25 +0000 (UTC)
Received: from mail-mta-0.intern.sigma-chemnitz.de
	(mail-mta-0.intern.sigma-chemnitz.de [192.168.12.76])
	by mailout-1.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id
	xB1K6rQ2001055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <bitbake-devel@lists.openembedded.org>;
	Sun, 1 Dec 2019 21:06:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1575230814;
	bh=sgm8LHYOql8CZbMN5mWwcluW/JERQH/T6wdOT7+N8/w=; l=1695;
	h=From:To:Cc:Subject:References:Date;
	b=hIxvRXVVUI4pfvnPV/rTL9qAXcixynEBVL6jSjxq3Lp3Te/FDmC1W1Kj3uIc3r+O3
	ZrSIGEa6ilXChLoXPu7TImY1T07E+eJ2w6NtIXUc1zdjVfjC9W1p4pASXC20v87EF5
	/OTXG5Na/mtqwGTkKE5L8ucOuax9PR70tUIRvcFw=
Received: from reddoxx.intern.sigma-chemnitz.de
	(reddoxx.intern.sigma-chemnitz.de [192.168.0.193])
	by mail-mta-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id
	xB1K6kBF028066 for <bitbake-devel@lists.openembedded.org> from
	enrico.scholz@sigma-chemnitz.de; Sun, 1 Dec 2019 21:06:47 +0100
Received: from mail-msa-0.intern.sigma-chemnitz.de ( [192.168.12.77]) by
	reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 1ABA456CF99;
	Sun, 1 Dec 2019 21:06:46 +0100
Received: from ensc-virt.intern.sigma-chemnitz.de
	(ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-0.intern.sigma-chemnitz.de (8.14.7/8.14.7) with ESMTP id
	xB1K6j3S028063
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO); Sun, 1 Dec 2019 21:06:45 +0100
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim
	4.92.3) (envelope-from <ensc@sigma-chemnitz.de>)
	id 1ibVUT-00054r-Bs; Sun, 01 Dec 2019 21:06:45 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20191102180558.5116-1-richard.purdie@linuxfoundation.org>
Date: Sun, 01 Dec 2019 21:06:45 +0100
Message-ID: <lyy2vv7qui.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: Ensure cached url data is matched to a datastore
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
X-List-Received-Date: Sun, 01 Dec 2019 20:14:26 -0000
Content-Type: text/plain

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> There was a weird error in OE-Core where "devtool modify virtual/kernel"
> was showing basehash mismatch errors. This was due to SRCPV sometimes being:
> AUTOINC+b867b78b50_47b80ef7bd and sometimes
> AUTOINC+b867b78b50_255a750d28.

Hello,

unfortunately, this breaks one of my classes with parses SRC_URI.
E.g. a more or less minimal recipe like

-------
LICENSE = "CLOSED"

SRC_URI = "file://foo;name=bootsplash"

def _find_bootsplash(d):
    fetch = bb.fetch2.Fetch([], d)
    for url in fetch.urls:
        urldata = fetch.ud[url]
        parm = urldata.parm
        if parm.get('name') == 'bootsplash':
            return urldata

    raise Exception("no bootsplash")

def get_bootsplash_convert(d):
    uri = _find_bootsplash(d)

    if not uri.localpath:
        # happens in early parsing stage; skip further processing
        return None

    ## construct an image magick command to rotate/scale bootsplash
    ## ...

    return "true"

LOGO_CONVERT_CMD = "${@get_bootsplash_convert(d)}"

do_unpack[postfuncs] += "do_logo_preprocess do_unpack_logo"

do_logo_preprocess() {
    ${LOGO_CONVERT_CMD}
    false
}
------

fails with

| + None
| .../temp/run.do_logo_preprocess.29898: line 104: None: command not found

after this patch (seen in thud branch; not tested with other ones).
Before the patch, "true" (resp. "convert.im7") was called.

'uri.localpath' seems to be None in early build stages which is now
cached and used in places where it was (re)calculated previously.


Enrico
-- 
SIGMA Chemnitz GmbH       Registergericht:   Amtsgericht Chemnitz HRB 1750
Am Erlenwald 13           Geschaeftsfuehrer: Grit Freitag, Frank Pyritz
09128 Chemnitz

