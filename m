Subject: Re: [PATCH] S3 fetcher: add progress handler for S3 cp command
To: bitbake-devel@lists.openembedded.org
From: "Przemyslaw Gorszkowski" <pgorszkowski@gmail.com>
X-Originating-Location: Wroclaw, Lower Silesia, PL (5.39.192.133)
X-Originating-Platform: Linux Firefox 88
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 28 Apr 2021 00:09:05 -0700
References: <fcbceb5b62675b9a4ca21b080acdd7ac07b010b4.camel@linuxfoundation.org>
In-Reply-To: <fcbceb5b62675b9a4ca21b080acdd7ac07b010b4.camel@linuxfoundation.org>
Message-ID: <30508.1619593745487781026@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="lgn1a6u1LzrndqwBmJdt"

--lgn1a6u1LzrndqwBmJdt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I forgot to add that my change depends on my second fix provided in https:/=
/lists.openembedded.org/g/bitbake-devel/message/12267 ([PATCH] LineFilterPr=
ogressHandler: fix parsing line which ends with CR only). Without it the li=
ne log will not be passed to S3ProgressHandler::writeline function.

--lgn1a6u1LzrndqwBmJdt
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I forgot to add that my change depends on my second fix provided in <a href=
=
=3D"https://lists.openembedded.org/g/bitbake-devel/message/12267" target=
=3D"_blank" rel=3D"noopener">https://lists.openembedded.org/g/bitbake-deve=
l/message/12267</a> ([PATCH] LineFilterProgressHandler: fix parsing line wh=
ich ends with CR only). Without it the line log will not be passed to S3Pro=
gressHandler::writeline function.

--lgn1a6u1LzrndqwBmJdt--
