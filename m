Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D04CA5FFC
	for <webhook@archiver.kernel.org>; Tue,  6 Oct 2026 21:31:41 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75.1791322298531840673
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Oct 2026 14:31:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=gQsevxe+;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=ZcBT+tN3;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HemJV517349
	for <bitbake-devel@lists.openembedded.org>; Tue, 6 Oct 2026 21:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t7CAyuQgdFHHlYDw13lLU4zeL1Z7ciFyrkTghKM7MaU=; b=gQsevxe+AMcLL3Jc
	Jf3HuSMxF5Fx36klJDpqztNmpxqPjZZ77xz4hqPEmZJKUUQ9/IcGkOiAotwSHZFP
	Ids6CAQ5fTm+TPqSVOgdkr5qI1xRPzCx538BHDfG4Q/VqvNB+gKPCGVtLRSi3zNU
	o9/3N5iwdnEQNt3ZvYYtPcuC0ENUWRzNwwbAm1FQYfoWdkS/52S+swDhIOH46cQn
	yejfEdGQZ+L0Mn9TSmj3c9nciIe/n+TzPDAM5YlWPurTFlAZKtTqlpk+tcZwfuvr
	/dLEvBFwhAlPliOZTkpuyQaMAmf/b/WAV9pj9EiVeNMiPbD/tLkwCohCH77LR4zo
	8i7JbA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53ashmwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 21:31:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df5a65671eso17193395ad.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 14:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791322295; cv=none;
        d=google.com; s=arc-20260327;
        b=StLf87uY6BntF0ZFzHdsyccVq8KUawBV/8p45QJy/KnZt1IWrR0jWjz7urJwNHQuxS
         M7dhZ5qVbmWaLbuPmQGqXxqRFkVxjYFeKoZnk5zOUGVoqbph3dERcI3XolHaSva/FWKY
         fZyQeT1AgK2hxeOSkH5nlm56nOIbW5DUgpBXxdNi4qUN8BMFtbe42Lathjimkoa9iEEW
         nhnp0q6NBx1Uogq8qSWwkKV/vYIDUVdjadnw+vCPdiAQK9tJlz+DjgMoZ3gG1cWLvdvt
         /CYHlky3qOXyUlLRLV2rMpGG5TraeOvpC2kVQaMK3CgCFXNkMcp+HIjeRQ/ioqSlzRf4
         qltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t7CAyuQgdFHHlYDw13lLU4zeL1Z7ciFyrkTghKM7MaU=;
        fh=sGX7768xjpjwPhA5B2xzLJbMvnzu1EDvWk6fV4ULNNM=;
        b=p2V6N183ynzQp+rNv7ItxrzuuoJ4vvLmWRz0H0uBXjkiuuMbw+RptknOjkGYOlFojc
         XiADGyme6ClaIpUKTQqVX3ZcZChkD4XMcU9KCOFtFVp/s/3cEyGn1rJSHvVdxR5+y0RK
         T0Jk6UaHGR/t65C8hclvn/iGHxYrpQOPdRT2JjgROnI+ezEZtRe46IrBcCZdYhnw9THL
         WICVMzrg9gmek0XrGveNNgtb/rBZD8tN3rpWk1ygQOwAnBFVVkvckjoZ0gQQ5WZocdo8
         aCMNRmZSJd48TQ8eEmqEZKz2h5smvAtaIRBb+mWFyPKucKC5gO2qga8yScsA+jfIY6Sq
         HNiw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791322295; x=1791927095; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7CAyuQgdFHHlYDw13lLU4zeL1Z7ciFyrkTghKM7MaU=;
        b=ZcBT+tN3GB1eu6WkG0LSYvgqoTX8xtVjyrdw2abqSKm1UDKZRcr8SwAsKKpkrz69pI
         elCwKDIcsB7oIIC1KEj4/L41YUhOgBjG0yH6ToJsQnRrzzE/9vKU0w3YoiQY6v3KCMTw
         FYRvcD7Sanyc2usadPaiuRT0TAN0ACF8K1ZyTYBgYxoaBySU7fgz2l64dJStUeZtgV8S
         9pUss6cEuqfsHsJ4nwgQNyaFGfi3LsCOZVgPnzK21N0vq1vfAwQMwW2UAIVdKMTDfFIs
         AD4gFmllx01RAwrKGMddU31tfzBRvitK/+YMitRCaYP3pZo7x/rhCPKrcnVtbHuBEihj
         MbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791322295; x=1791927095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7CAyuQgdFHHlYDw13lLU4zeL1Z7ciFyrkTghKM7MaU=;
        b=Tun5Xm+eXAR3Q9ibMZgnXIediDsM2qb+l8OZ+utyzxlqOfqHTonH7/WDAHylnTnooU
         dgNpp94sTRYwJeKWwSGe9Z8FgIDQeFjq1nlIc6vQz5qwCZLIWCTy/HKnaoqpVFtjVInG
         +tPo0Mxkl3WP5mHFrnfypApk9eHChVoc+uOtPQMzXB/jq0ZyappJ/2HC+3I7jdoKPNNB
         yTIWHPn5PxhV14Fe4uc3o/kOviibUlSbNVi3LapsCxPUIY/a06p1CvAQyBMXSSCCxqCA
         ekk67dy9vm0RE9uXhdwbiGkCr6xlka+xMEzfXn+qdABnGlJkl9E3Fp64zbr5Y9W9XGrE
         NJmQ==
X-Gm-Message-State: AFq9FYItqYJpXjW6HLi3pMVtFpHBz88nTQVGipTNVkRvmcBjziS7vezs
	h6sK8DZXoqIc/pBIHFLsj6tnWrxkEihHelJa3t13dMjtIZg8SmMfQYDBf9zWfBfDv6k1jOCgovs
	syyUjRJVfWHNuEdTiVfIo3Nj7OS/8TaxWUBnPZ1qWUmKLUNaI7ZC/8iKv3CZ3mmZ/N6GHNPKRo1
	ysPMIkqDUQIEuvbx8UPGgLomgf+Hh4K3BfG645U991vK+fCG/hRSVj
X-Gm-Gg: AYBFou0CpzRasotppXzA28weGx4dWUfUesiLEG8FNv+7dKMFcu+jE0YBAR4Hiwz8M+b
	UltaKr5v6oJU6gxoLHAknnbFh7P2D2ueHoWs7TmqxduyN+/PuYd8rVoGHM+RinS1i5YQQeT4hIQ
	ybtMd1OEAmhiPazzDZA14SwfbMz7xYHeeYzUIIQKjWa0APw1xxSi3VWwnQOg==
X-Received: by 2002:a17:902:c406:b0:2e5:457d:6c20 with SMTP id d9443c01a7336-2e5c53d8dafmr25802095ad.23.1791322295448;
        Tue, 06 Oct 2026 14:31:35 -0700 (PDT)
X-Received: by 2002:a17:902:c406:b0:2e5:457d:6c20 with SMTP id
 d9443c01a7336-2e5c53d8dafmr25801765ad.23.1791322294482; Tue, 06 Oct 2026
 14:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
 <18DAAB270E5DB286.1715499@lists.openembedded.org> <4dac347fd6bd1f160fbe3646d20504bc6f47b42b.camel@linuxfoundation.org>
In-Reply-To: <4dac347fd6bd1f160fbe3646d20504bc6f47b42b.camel@linuxfoundation.org>
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 23:30:58 +0200
X-Gm-Features: AclHuK-7RwNaIB10cl-QT9lxwQh6RqAkPqjUo_ZfGWlVPL2QZncB7Vrv5jHI1w4
Message-ID: <CAA_5youiGgqfXfsrMiLxPHwcNaQTdjUQQ+0us49F8WH3z-F6nQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, jose.quaresma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: MltDUp3aAI_c6Mg3HosYmZn_6-VUC_ni
X-Proofpoint-GUID: MltDUp3aAI_c6Mg3HosYmZn_6-VUC_ni
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac568b9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=LRLYrf9nAAAA:8 a=iGHA9ds3AAAA:8 a=ag1SF4gXAAAA:8
 a=Q4-j1AaZAAAA:8 a=qBiyX2Nd3xcVNd9PyDYA:9 a=lqcHg5cX4UMA:10 a=r-HJ9bD__24A:10
 a=Wpz8ju6o9T4A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=ctNd1-se8QBkj9sPkfQg:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA4NSBTYWx0ZWRfX0BYhM3uwMHXH
 6EdSs6bU1eWQ3zojM4FZp2fvWhEyW2s0bTC/w2DtQhhVbhr0TQqgskGq9JiBspP2GxyIMV3oLXl
 DQ0fkXFc61/xuvzJf7FXSfzFHWzKPWpVPYMQLVtSS9gzJqAG5Nya6u2mEEcLKMPmoyXK6NEiRsd
 wlIo7XC+YLctJ1dcCB6qVBk0EXEDCpcy3EqSKRU9Gp8TphW83Jx9ETGyBEbtWHcdGw9VkRshqUi
 Ds22l0hX4ioawdXKNGoy1ZCCQNvqRPssIWrpvV9HlSIavG2LAKViWqSxAbcFpFTIac6hFayl7zU
 TRFi/NHXLsI0FnlABx63bVpJndcNd0fTbF4lw3DSzdUs3P10s0fZg1WjRvkvzYIu6nkR4AJbT1W
 OHv0sT+zGGFW12njQ1eX/2HWmVU10dtznJXucPnEUuwHYNddyByQBTddBYMsnKGGaIbdNxzUpmT
 PA2IT85v0LJUiOCZVPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA4NSBTYWx0ZWRfXwC1TGkrnxILi
 wx1KyTi6ci19MWMY8+l5E+GNPTBdbLgPfa/FWvA0zgM1hHp3TF9F1dgcW5W5lpAGs7y5z0Wwogw
 PmOicfSgqfKZEXSS8/gKaMJILkH/0Bs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060085
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Oct 2026 21:31:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20300

On Fri, Oct 2, 2026 at 11:20=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Fri, 2026-10-02 at 10:06 +0100, Richard Purdie via lists.openembedded.=
org wrote:
> > Hi Ricardo,
> >
> > On Tue, 2026-09-29 at 01:28 +0000, Ricardo Salveti via lists.openembedd=
ed.org wrote:
> > > diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> > > index 71b0a63fe..9627b3b1b 100644
> > > --- a/lib/bb/tests/fetch.py
> > > +++ b/lib/bb/tests/fetch.py
> > > @@ -1706,6 +1706,59 @@ class FetchLatestVersionTest(FetcherTest):
> > >                  r =3D bb.utils.vercmp_string(verstring, v_larger)
> > >                  self.assertTrue(r =3D=3D -1, msg=3D"Package %s, vers=
ion: %s <=3D %s" % (k[0], v_larger, verstring))
> > >
> > > +class WgetChecksumTest(FetcherTest):
> > > +    content =3D b"bitbake wget test data\n" * 64
> > > +    # As large as the real file, so wget --continue has nothing left=
 to fetch
> > > +    # and keeps it as is
> > > +    corrupt =3D b"x" * len(content)
> > > +
> > > +    def setUp(self):
> > > +        super().setUp()
> > > +        self.serverdir =3D os.path.join(self.tempdir, "server")
> > > +        for subdir in ["upstream", "mirror"]:
> > > +            os.makedirs(os.path.join(self.serverdir, subdir))
> > > +        self.server =3D HTTPService(self.serverdir, host=3D"127.0.0.=
1")
> > > +        self.server.start()
> > > +        self.baseurl =3D "http://127.0.0.1:%s" % self.server.port
> > > +        self.url =3D "%s/upstream/test.bin;sha256sum=3D%s" % (
> > > +            self.baseurl, hashlib.sha256(self.content).hexdigest())
> > > +
> > > +    def tearDown(self):
> > > +        self.server.stop()
> > > +        super().tearDown()
> > > +
> > > +    def write(self, path, data):
> > > +        with open(path, "wb") as f:
> > > +            f.write(data)
> > > +
> > > +    def assertDownloaded(self):
> > > +        with open(os.path.join(self.dldir, "test.bin"), "rb") as f:
> > > +            self.assertEqual(f.read(), self.content)
> > > +        self.assertFalse(os.path.exists(os.path.join(self.dldir, "te=
st.bin.tmp")))
> > > +        self.assertTrue(os.path.exists(os.path.join(self.dldir,
> > > +            "test.bin_bad-checksum_%s" % hashlib.sha256(self.corrupt=
).hexdigest())))
> > > +
> > > +    def test_wget_corrupt_partial_download(self):
> > > +        self.write(os.path.join(self.serverdir, "upstream", "test.bi=
n"), self.content)
> > > +        self.write(os.path.join(self.dldir, "test.bin.tmp"), self.co=
rrupt)
> > > +
> > > +        fetcher =3D bb.fetch.Fetch([self.url], self.d)
> > > +        with self.assertRaises(bb.fetch.FetchError):
> > > +            fetcher.download()
> > > +        self.assertFalse(os.path.exists(os.path.join(self.dldir, "te=
st.bin.tmp")))
> > > +
> > > +        fetcher.download()
> > > +        self.assertDownloaded()
> > > +
> > > +    def test_wget_mirror_after_checksum_failure(self):
> > > +        self.write(os.path.join(self.serverdir, "upstream", "test.bi=
n"), self.corrupt)
> > > +        self.write(os.path.join(self.serverdir, "mirror", "test.bin"=
), self.content)
> > > +        self.d.setVar("MIRRORS", "%s/upstream/ %s/mirror/" % (self.b=
aseurl, self.baseurl))
> > > +
> > > +        fetcher =3D bb.fetch.Fetch([self.url], self.d)
> > > +        fetcher.download()
> > > +        self.assertDownloaded()
> > > +
> > >  class FetchCheckStatusTest(FetcherTest):
> > >      test_wget_uris =3D ["https://downloads.yoctoproject.org/releases=
/sato/sato-engine-0.1.tar.gz",
> > >                        "https://downloads.yoctoproject.org/releases/s=
ato/sato-engine-0.2.tar.gz",
> > >
> >
> > I merged this but the testcase is intermittently failing, e.g.:
> >
> > https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4786=
/steps/14/logs/stdio
> >
> > which I'm struggling to understand why. You can see the rename in the
> > logs so it implies the checksum didn't match the expected value, or the
> > file was somehow deleted...
>
> I realised this is only happening on fedora45, which we don't have in
> main testing yet as we're still validating it works ok, there are some
> issues there. I found the checksum of the bad-checksum file was clearly
> from. From the debug output I then added:
>
> 1472
> total 12
> drwxr-xr-x. 2 pokybuild pokybuild  100 Oct  2 09:16 .
> drwx------. 5 pokybuild pokybuild  100 Oct  2 09:16 ..
> -rw-r--r--. 1 pokybuild pokybuild 1472 Oct  2 09:16 test.bin
> -rw-r--r--. 1 pokybuild pokybuild 2944 Oct  2 09:16 test.bin_bad-checksum=
_4d10580369033e7582482ddb05c76f38df07ad7daac927cd515909e564e26269
> -rw-r--r--. 1 pokybuild pokybuild  545 Oct  2 09:16 test.bin.done
> total 4
> drwxr-xr-x. 2 pokybuild pokybuild   60 Oct  2 09:16 .
> drwxr-xr-x. 4 pokybuild pokybuild   80 Oct  2 09:16 ..
> -rw-r--r--. 1 pokybuild pokybuild 1472 Oct  2 09:16 test.bin
>
> which shows the bad-checksum file appears to actually have two copies
> of the downloaded data based on the file size. That seems odd.
>
> $ wget --version
> GNU Wget2 2.2.1 - multithreaded metalink/file/website downloader
>
> +digest +https +ssl/gnutls +ipv6 +iri +large-file +nls -ntlm -opie +psl -=
hsts
> +iconv +idn2 +zlib -lzma +brotlidec +zstd -bzip2 -lzip +http2 +gpgme
>
> A bug in wget or a bug in httpserver in 3.15?

Yeah, this seems to be a different behavior in wget2 2.2.1, it ends up
rewriting the file with a successful fetch, let me send another fix.

Thanks,

Ricardo

