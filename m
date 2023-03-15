Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A496C61DA4
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 15:04:01 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web11.10498.1678892635528562137
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 08:03:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=bP2jVLE8;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: alex.kiernan@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id g6so7925569iov.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678892635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j24uormvPm75O7b75oTstYy3lyV+UFDJYqwC52GfVk=;
        b=bP2jVLE8zPcX9fgrekyDcoRI70e4OmKMrYPRQh3zLmKPyRew3F1paSwwBo9GSIpzHM
         kFqHV2ERFL5Gsb+KvaQZM+97PyL56WPFDDk11xh/DzLcZBLH/pWpeAmjQzU3rYK9Ea1n
         a6fEC0Q8NktWfvApuqY8Kx0GanjFvBOdikstcD8m/zkY5D8GV8EdCRaSmDoe0ZQzEAhf
         ePHcomiVFwAqcDsRRxzF3FodaNEE8e3hGGIsXdvHZY6h5vGhH1b6mfdP1E3E0ENFpy2Q
         k1O1c0dWogUHXCUbXDO0odAoboINe7137pSDYHd+CfRngDr+PI1pexjIOOkqeH5PFquz
         HGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678892635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+j24uormvPm75O7b75oTstYy3lyV+UFDJYqwC52GfVk=;
        b=Rd1Z+JyQJkWJ3zVmnllexV2R6ixg8sUjnc7klpG3f6qpanDlRUtfTn8hJUW6is1Y87
         Kf1oDv5ZXae89eN1CDgKeHY2KaJqeIRyZtOARXeP+CYeuiU1cFOfBJK+BmdivU+ZqHRk
         EV4nwGUQGdN81c8mr4h0Fa6oR7MGsRjAHtrQoj3xgLNiLLQaiFP9bS9S57FsYjdNBqYJ
         Rejr0y5aOszlkreKPU1wZnikKQEL2iKuB1++/UMe5+COB6Az92Ce4yh2IOGxY4DSMegT
         P4aaWfIqKZv92MAaQeeJap+hoPeu+ZB2Svo5ubcOsmcqB/W/HR7mnVcrhi9u9i6BzS75
         8L4Q==
X-Gm-Message-State: AO0yUKW2qTtH+D3xPlIsM6x43PgAaAD4KQcuRt29CxB7bvmfmwh3zAtg
	+hq+TstcmQu0Z9fiW+MlbWpIIeexfOlOR4GB5TXa8zneVZk=
X-Google-Smtp-Source: AK7set/IX9nVrmO03TBcaJNCW4P+qfMDoCZaO3aKfuxJ15gh3qO0ZjU/nIIYGSvPo7VIXmb7dVePPJ+5+6FWnng2xP0=
X-Received: by 2002:a5e:a90f:0:b0:752:ed8d:d015 with SMTP id
 c15-20020a5ea90f000000b00752ed8dd015mr1127102iod.1.1678892634578; Wed, 15 Mar
 2023 08:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
In-Reply-To: <20230315131513.50635-1-frederic.martinsons@gmail.com>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Wed, 15 Mar 2023 15:03:42 +0000
Message-ID: <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Frederic Martinsons <frederic.martinsons@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 15:04:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14565

On Wed, Mar 15, 2023 at 1:15=E2=80=AFPM Frederic Martinsons
<frederic.martinsons@gmail.com> wrote:
>
> From: Frederic Martinsons <frederic.martinsons@gmail.com>
>
> This change brings checksum verification of each crate
> in a recipe, e.g
>
> | SRC_URI +=3D " \
> |     crate://crates.io/aho-corasick/0.7.20 \
> |     crate://crates.io/atomic-waker/1.1.0 \
> |     crate://crates.io/cc/1.0.79 \
> | "
> |
> | SRC_URI[aho-corasick.sha256sum] =3D "cc936419f96fa211c1b9166887b38e5e40=
b19958e5b895be7c1f93adec7071ac"
> | SRC_URI[atomic-waker.sha256sum] =3D "debc29dde2e69f9e47506b525f639ed423=
00fc014a3e007832592448fa8e4599"
> | SRC_URI[cc.sha256sum] =3D "50d30906286121d95be3d479533b458f87493b30a4b5=
f79a607db8f5d11aa91f"
>
> That will require to move the checksum initialization
> after the possible call to urldata_init method in order
> for the crate fetcher to parse the url.
>
> Another way of doing could have been implementing a decodeurl
> method that would have been specific for each fetcher class.
>
> Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>

I really don't think this is the right direction, at least not by
default. If a crate is your primary build artefact then this is
useful:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012

But doing this for all the dependency crates we're just repeating
what's in the Cargo.lock which should always be part of the primary
artefact.

> ---
>  lib/bb/fetch2/__init__.py | 12 ++++++------
>  lib/bb/tests/fetch.py     | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index cf65727a..3ae83fa8 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1291,18 +1291,13 @@ class FetchData(object):
>
>              if checksum_name in self.parm:
>                  checksum_expected =3D self.parm[checksum_name]
> -            elif self.type not in ["http", "https", "ftp", "ftps", "sftp=
", "s3", "az"]:
> +            elif self.type not in ["http", "https", "ftp", "ftps", "sftp=
", "s3", "az", "crate"]:
>                  checksum_expected =3D None
>              else:
>                  checksum_expected =3D d.getVarFlag("SRC_URI", checksum_n=
ame)
>
>              setattr(self, "%s_expected" % checksum_id, checksum_expected=
)
>
> -        for checksum_id in CHECKSUM_LIST:
> -            configure_checksum(checksum_id)
> -
> -        self.ignore_checksums =3D False
> -
>          self.names =3D self.parm.get("name",'default').split(',')
>
>          self.method =3D None
> @@ -1324,6 +1319,11 @@ class FetchData(object):
>          if hasattr(self.method, "urldata_init"):
>              self.method.urldata_init(self, d)
>
> +        for checksum_id in CHECKSUM_LIST:
> +            configure_checksum(checksum_id)
> +
> +        self.ignore_checksums =3D False
> +
>          if "localpath" in self.parm:
>              # if user sets localpath for file, use it instead.
>              self.localpath =3D self.parm["localpath"]
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 73eefc59..fd089bc8 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -2377,6 +2377,13 @@ class CrateTest(FetcherTest):
>          d =3D self.d
>
>          fetcher =3D bb.fetch2.Fetch(uris, self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "glob")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate=
")
> +
>          fetcher.download()
>          fetcher.unpack(self.tempdir)
>          self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home'=
, 'download' , 'unpacked'])
> @@ -2394,6 +2401,19 @@ class CrateTest(FetcherTest):
>          d =3D self.d
>
>          fetcher =3D bb.fetch2.Fetch(uris, self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "glob")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate=
")
> +
> +        ud =3D fetcher.ud[fetcher.urls[1]]
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "time")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "time-0.1.35.crate=
")
> +
>          fetcher.download()
>          fetcher.unpack(self.tempdir)
>          self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home'=
, 'download' , 'unpacked'])
> @@ -2403,6 +2423,18 @@ class CrateTest(FetcherTest):
>          self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitba=
ke/time-0.1.35/.cargo-checksum.json"))
>          self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitba=
ke/time-0.1.35/src/lib.rs"))
>
> +    @skipIfNoNetwork()
> +    def test_crate_incorrect_cksum(self):
> +        uri =3D "crate://crates.io/aho-corasick/0.7.20"
> +        self.d.setVar('SRC_URI', uri)
> +        self.d.setVarFlag("SRC_URI", "aho-corasick.sha256sum", hashlib.s=
ha256("Invalid".encode("utf-8")).hexdigest())
> +
> +        uris =3D self.d.getVar('SRC_URI').split()
> +
> +        fetcher =3D bb.fetch2.Fetch(uris, self.d)
> +        with self.assertRaisesRegexp(bb.fetch2.FetchError, "Fetcher fail=
ure for URL"):
> +            fetcher.download()
> +
>  class NPMTest(FetcherTest):
>      def skipIfNoNpm():
>          import shutil
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14563): https://lists.openembedded.org/g/bitbake-deve=
l/message/14563
> Mute This Topic: https://lists.openembedded.org/mt/97626961/3618097
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
iernan@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Alex Kiernan

