Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA14ACA5FC4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 09:21:03 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7260.1790932853641935617
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Oct 2026 02:20:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dfB/KuBc;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.140, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so42546965e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790932852; x=1791537652; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jPM+wE232YmdYFwoELwyRCJQIX+yKTmNSeShwsk7otc=;
        b=dfB/KuBc3jlHfE/R7Ukfs8dRJoGnCLxg6ehTRMpkHhG+0EEBIg5BiBZ5RHAK63emc9
         2xgqHfEPc7RMHwfa+tz2kNb1GVfA2j2nwSicQTxL8pRKb2dXppxnkPlQ9gY8EBzg5Q8U
         /1Tc3CSOY7CJQb+pCOvQCOe6Ppq0GPJ3H2SgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932852; x=1791537652;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPM+wE232YmdYFwoELwyRCJQIX+yKTmNSeShwsk7otc=;
        b=0LLH/84+jUEl9vGFch70cOvWcCSjOy+uq8Fowl9VnvhvfkhdVmbM4eTacNRktZGfif
         prmby/+3UnaoB9tSQieyqVLjmga0EpczIOuwJ69Pz+kKKR+EfjQS8fwWHXSSLZe6naHR
         9ZmJfXNT8rVTqYu4e8Wsvk0rtEbPUMwZ4SWV6TvWGaVSkL1SoJdOhQlgHnNuRhpVF155
         lGwXBkv7vRy5UMGoUTugLqwD1p7xejricCs4eaWrXD9aHUgV57BOVf5RsVgJJ7bKuLsX
         Pb6LjZ/UFytLMQftVjVSKYMiln7GdZUdn85X8k1BGn0lQS90qoHE7oVYPVljs3EwSzCf
         PIZw==
X-Forwarded-Encrypted: i=1; AKwUvBzVC6iIcvf+ooEiRwdo2jrrFI0po06IuTtAiM50Y4MiuYyMvLONaA7kI/6TNnW//PqTgxntX0tUMBr6TdTu@lists.openembedded.org
X-Gm-Message-State: AFuF++n1B8wYLG0oyyq8Em09a+YdHYHyLWjVuuF1T5yLQzhW1x47/fbj
	G3IAd4Ovkqnp+KztfIZQb6CEBkAZeejrUNF1qp2oWpYOFTwivO5yBBvIujofxb52XCs=
X-Gm-Gg: AYBFou3sbOL3v1keGPQ1ZiKyruK6PPZIn9CY4D851TBrb9Nr4rjZDjy8Xs+4RB5Wc/a
	f9Kwf/jASmJS/bIrQQPkc32n4LJIvK8JE3bkCyoTMTgcmUHvC0gdOJxIIz7FsTpSXojli/nfTp0
	hP0FfDuqCKTF8Owf/llk3Mj9V1eiVqQtxsv5Jt6Xxcu5qZTr1cHc2jFa290uZSD3yhUVlVljsk9
	h8DOKQREsNfOk7v43N6jRMWOP4xJT5qjsOo69Kj4r3GsHv5VTo7tLlnSVneWnMWXWGG+qYKJakI
	OhXRE0AgR0k00BQJzbEuxBonO+L4Y7XqrcDjbDGL7xTamWKWxcdccMSbpQ85U5rIcV3DdjW9hnQ
	I0c3aMAGSG1eSWQu39lXV7niN7tSAkq9TLwCkY+sXClXX596dAYgEzD6RJOH+qkND41YZZLeq4+
	u0YbiHK+3/KTLshkXItXkQwc1xo4kyqibi6Gjt0925NiyF85WwiRncLpkxD8P1UOdk7MHj3oyye
	NtuPOCQg92BqP/b2/0B/VNj8sMCgY+pCjppMLZqpEzpp0ZhxgH2vs7F1mG6Jbs=
X-Received: by 2002:a05:600c:34d1:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a027579e86mr41431475e9.12.1790932851700;
        Fri, 02 Oct 2026 02:20:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:755a:bfe8:d050:d1c2? ([2001:8b0:aba:5f3c:755a:bfe8:d050:d1c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm94747245e9.11.2026.10.02.02.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:20:50 -0700 (PDT)
Message-ID: <4dac347fd6bd1f160fbe3646d20504bc6f47b42b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ricardo.salveti@oss.qualcomm.com, bitbake-devel@lists.openembedded.org
Cc: jose.quaresma@oss.qualcomm.com
Date: Fri, 02 Oct 2026 10:20:49 +0100
In-Reply-To: <18DAAB270E5DB286.1715499@lists.openembedded.org>
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
	 <18DAAB270E5DB286.1715499@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Oct 2026 09:21:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20291

On Fri, 2026-10-02 at 10:06 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> Hi Ricardo,
>=20
> On Tue, 2026-09-29 at 01:28 +0000, Ricardo Salveti via lists.openembedded=
.org wrote:
> > diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> > index 71b0a63fe..9627b3b1b 100644
> > --- a/lib/bb/tests/fetch.py
> > +++ b/lib/bb/tests/fetch.py
> > @@ -1706,6 +1706,59 @@ class FetchLatestVersionTest(FetcherTest):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D bb.utils.vercmp_string(verstring, v_large=
r)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(r =3D=3D -1, msg=3D"Package %s,=
 version: %s <=3D %s" % (k[0], v_larger, verstring))
> > =C2=A0
> > +class WgetChecksumTest(FetcherTest):
> > +=C2=A0=C2=A0=C2=A0 content =3D b"bitbake wget test data\n" * 64
> > +=C2=A0=C2=A0=C2=A0 # As large as the real file, so wget --continue has=
 nothing left to fetch
> > +=C2=A0=C2=A0=C2=A0 # and keeps it as is
> > +=C2=A0=C2=A0=C2=A0 corrupt =3D b"x" * len(content)
> > +
> > +=C2=A0=C2=A0=C2=A0 def setUp(self):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super().setUp()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.serverdir =3D os.path.=
join(self.tempdir, "server")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for subdir in ["upstream", =
"mirror"]:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.=
makedirs(os.path.join(self.serverdir, subdir))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.server =3D HTTPService=
(self.serverdir, host=3D"127.0.0.1")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.server.start()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.baseurl =3D "http://12=
7.0.0.1:%s" % self.server.port
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.url =3D "%s/upstream/t=
est.bin;sha256sum=3D%s" % (
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f.baseurl, hashlib.sha256(self.content).hexdigest())
> > +
> > +=C2=A0=C2=A0=C2=A0 def tearDown(self):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.server.stop()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super().tearDown()
> > +
> > +=C2=A0=C2=A0=C2=A0 def write(self, path, data):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open(path, "wb") as f:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f.w=
rite(data)
> > +
> > +=C2=A0=C2=A0=C2=A0 def assertDownloaded(self):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open(os.path.join(self=
.dldir, "test.bin"), "rb") as f:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f.assertEqual(f.read(), self.content)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertFalse(os.path.ex=
ists(os.path.join(self.dldir, "test.bin.tmp")))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertTrue(os.path.exi=
sts(os.path.join(self.dldir,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "te=
st.bin_bad-checksum_%s" % hashlib.sha256(self.corrupt).hexdigest())))
> > +
> > +=C2=A0=C2=A0=C2=A0 def test_wget_corrupt_partial_download(self):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.write(os.path.join(sel=
f.serverdir, "upstream", "test.bin"), self.content)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.write(os.path.join(sel=
f.dldir, "test.bin.tmp"), self.corrupt)
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetcher =3D bb.fetch.Fetch(=
[self.url], self.d)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with self.assertRaises(bb.f=
etch.FetchError):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fet=
cher.download()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertFalse(os.path.ex=
ists(os.path.join(self.dldir, "test.bin.tmp")))
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetcher.download()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertDownloaded()
> > +
> > +=C2=A0=C2=A0=C2=A0 def test_wget_mirror_after_checksum_failure(self):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.write(os.path.join(sel=
f.serverdir, "upstream", "test.bin"), self.corrupt)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.write(os.path.join(sel=
f.serverdir, "mirror", "test.bin"), self.content)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.d.setVar("MIRRORS", "%=
s/upstream/ %s/mirror/" % (self.baseurl, self.baseurl))
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetcher =3D bb.fetch.Fetch(=
[self.url], self.d)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetcher.download()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertDownloaded()
> > +
> > =C2=A0class FetchCheckStatusTest(FetcherTest):
> > =C2=A0=C2=A0=C2=A0=C2=A0 test_wget_uris =3D ["https://downloads.yoctopr=
oject.org/releases/sato/sato-engine-0.1.tar.gz",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "https://do=
wnloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
> >=20
>=20
> I merged this but the testcase is intermittently failing, e.g.:
>=20
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4786/s=
teps/14/logs/stdio
>=20
> which I'm struggling to understand why. You can see the rename in the
> logs so it implies the checksum didn't match the expected value, or the
> file was somehow deleted...

I realised this is only happening on fedora45, which we don't have in
main testing yet as we're still validating it works ok, there are some
issues there. I found the checksum of the bad-checksum file was clearly
from. From the debug output I then added:

1472
total 12
drwxr-xr-x. 2 pokybuild pokybuild  100 Oct  2 09:16 .
drwx------. 5 pokybuild pokybuild  100 Oct  2 09:16 ..
-rw-r--r--. 1 pokybuild pokybuild 1472 Oct  2 09:16 test.bin
-rw-r--r--. 1 pokybuild pokybuild 2944 Oct  2 09:16 test.bin_bad-checksum_4=
d10580369033e7582482ddb05c76f38df07ad7daac927cd515909e564e26269
-rw-r--r--. 1 pokybuild pokybuild  545 Oct  2 09:16 test.bin.done
total 4
drwxr-xr-x. 2 pokybuild pokybuild   60 Oct  2 09:16 .
drwxr-xr-x. 4 pokybuild pokybuild   80 Oct  2 09:16 ..
-rw-r--r--. 1 pokybuild pokybuild 1472 Oct  2 09:16 test.bin

which shows the bad-checksum file appears to actually have two copies
of the downloaded data based on the file size. That seems odd.

$ wget --version
GNU Wget2 2.2.1 - multithreaded metalink/file/website downloader

+digest +https +ssl/gnutls +ipv6 +iri +large-file +nls -ntlm -opie +psl -hs=
ts
+iconv +idn2 +zlib -lzma +brotlidec +zstd -bzip2 -lzip +http2 +gpgme

A bug in wget or a bug in httpserver in 3.15?

Cheers,

Richard



