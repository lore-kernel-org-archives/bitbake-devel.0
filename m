Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC8DC6FD20
	for <webhook@archiver.kernel.org>; Tue, 21 Mar 2023 18:35:08 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.22285.1679423703956384178
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Mar 2023 11:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=NtNvzUMA;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id bi9so20294369lfb.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679423702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILHjcADxPRinFM9w2gobqUdgSRkYeT67UfE9sKd13To=;
        b=NtNvzUMAWdfjOq4IfiCVz8Dif6N4Nbp9vsw9VoauM8o14htX3YYQPAeR4sPDxp5xRH
         tEtJJXviF5HVlslWFWLsbR7oiN9spnUvu+busEHffHXjdYRy2YoikVv+udyhzfvWtuju
         DtcssSepH5RkUdCFVli+/6MZ7ssMIvcTS1mn8caQsZLY7Gm5Te9hcRjwLSOaV7kuONU8
         dQw2kn8m917kFb0JDSNdMJlto5yyv6+BWrpfbDWnxBURG5pliGexFTEsAwnmqsIYpTUF
         gVnj+rOA0xnQ1djHhvvFwcGb1AuTPso5ED9KDVz1LTQkZPeo8ik+LFU2SuckJT55KUlJ
         tQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILHjcADxPRinFM9w2gobqUdgSRkYeT67UfE9sKd13To=;
        b=aAHZeZc5nBZ3mNwyrlw4wrIaxn2FGCsnTPwXfN3e0xEGbx+rBpJQxxvASlpToL2gz+
         /vQxeiWZ1HBWUgHVU7dNZLdc4Yrt6ij2+HES1CTxKcFyCCTi/2IKEOUI/wUCXQ5PnOmJ
         ZxeqhbzBDP9hGOjxx59hFhUNo+J6r8vyAkoYpaEOMOpP58kj/mHVuD4vuBbJDi4S0Y97
         r7Ke3Q/vJ73yAiQOYUy2Y5ubO8UHVcbJoaXBXZNDcjT5IeZOtWL8XlaNIcj1SV97/bbM
         V9A4KP+6RDIft3ChcrAHm6VwueK3NeDt2QCLc4VQ9Roi2db3wjWAJ0JsXQaPr8yGDOvS
         KltA==
X-Gm-Message-State: AO0yUKWsWozG4/2wNrw27PdCH8wtoroAzYrF2sbq/WReMrA9GVMp7f69
	e25yLbwahJIWFfu8Own52I88+is3EpOFxArKc8k=
X-Google-Smtp-Source: AK7set8gagWubdTdUmx6Z3hWM7TWigMr1FLJqTxPDbfUdaYQqKZPkxcQDFBxczmcRg7vBUO9XbrTvXUtzhs9yjxFbeI=
X-Received: by 2002:ac2:5625:0:b0:4d5:ca32:6ed5 with SMTP id
 b5-20020ac25625000000b004d5ca326ed5mr1263143lff.3.1679423702043; Tue, 21 Mar
 2023 11:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
 <CA+cAkep0W_Jjvvpg2OEm+DE6SDUB98-OnghOyytijbU1qC1B2A@mail.gmail.com> <CA+cAkeptpiiEmx=JdevFu3_gg5gn0+mBjKs6VJ4wdMgG_79Xsw@mail.gmail.com>
In-Reply-To: <CA+cAkeptpiiEmx=JdevFu3_gg5gn0+mBjKs6VJ4wdMgG_79Xsw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Mar 2023 19:34:50 +0100
Message-ID: <CANNYZj8QH=et-KTCU=d23Dm4Px7RdKjR5HHFctvKgCTBKPYKJw@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2 1/3] fetch2: Add checksum capability for
 crate fetcher
To: Frederic Martinsons <frederic.martinsons@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 18:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14610

I believe all the patches are now in abelloni's staging branch:
https://git.yoctoproject.org/poky-contrib/log/?h=3Dabelloni/master-next

If they need a rework, or otherwise aren't suitable, you'll get feedback.

Note that we're in the feature freeze now; while this is a
comparatively low risk change (in my view), it may have to wait until
after mickledore's out.

Alex

On Tue, 21 Mar 2023 at 18:26, Frederic Martinsons
<frederic.martinsons@gmail.com> wrote:
>
> If dependencies between bitbake and other layers is an issue, I can suppr=
ess the patch n2 of this
> series to disable the verification of the checksum, and wait for all patc=
hes (bitbake, meta-oe and oe-core)
> to be applied.
> Finally, I would issue a new patch to make the checksum verification mand=
atory.
>
> On Tue, 21 Mar 2023 at 18:02, Fr=C3=A9d=C3=A9ric Martinsons <frederic.mar=
tinsons@gmail.com> wrote:
>>
>> Hello,
>>
>> Should I verify something more for this series?
>> I understood that it is a useful development to have in bitbake fetcher =
(but will break things if series in oe-core and meta-oe are not applied aft=
er this one) and I'm wondering if something block the review / apply ?
>>
>> Please tell me, I'll do all my best to secure this.
>>
>> Have a good day.
>>
>> Le ven. 17 mars 2023, 09:19, <frederic.martinsons@gmail.com> a =C3=A9cri=
t :
>>>
>>> From: Frederic Martinsons <frederic.martinsons@gmail.com>
>>>
>>> This change brings checksum verification of each crate
>>> in a recipe, e.g
>>>
>>> | SRC_URI +=3D " \
>>> |     crate://crates.io/aho-corasick/0.7.20 \
>>> |     crate://crates.io/atomic-waker/1.1.0 \
>>> |     crate://crates.io/cc/1.0.79 \
>>> | "
>>> |
>>> | SRC_URI[aho-corasick.sha256sum] =3D "cc936419f96fa211c1b9166887b38e5e=
40b19958e5b895be7c1f93adec7071ac"
>>> | SRC_URI[atomic-waker.sha256sum] =3D "debc29dde2e69f9e47506b525f639ed4=
2300fc014a3e007832592448fa8e4599"
>>> | SRC_URI[cc.sha256sum] =3D "50d30906286121d95be3d479533b458f87493b30a4=
b5f79a607db8f5d11aa91f"
>>>
>>> That will require to move the checksum initialization
>>> after the possible call to urldata_init method in order
>>> for the crate fetcher to parse the url.
>>>
>>> Another way of doing could have been implementing a decodeurl
>>> method that would have been specific for each fetcher class.
>>>
>>> Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
>>> ---
>>>  lib/bb/fetch2/__init__.py | 12 ++++++------
>>>  lib/bb/tests/fetch.py     | 32 ++++++++++++++++++++++++++++++++
>>>  2 files changed, 38 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>>> index cf65727a..3ae83fa8 100644
>>> --- a/lib/bb/fetch2/__init__.py
>>> +++ b/lib/bb/fetch2/__init__.py
>>> @@ -1291,18 +1291,13 @@ class FetchData(object):
>>>
>>>              if checksum_name in self.parm:
>>>                  checksum_expected =3D self.parm[checksum_name]
>>> -            elif self.type not in ["http", "https", "ftp", "ftps", "sf=
tp", "s3", "az"]:
>>> +            elif self.type not in ["http", "https", "ftp", "ftps", "sf=
tp", "s3", "az", "crate"]:
>>>                  checksum_expected =3D None
>>>              else:
>>>                  checksum_expected =3D d.getVarFlag("SRC_URI", checksum=
_name)
>>>
>>>              setattr(self, "%s_expected" % checksum_id, checksum_expect=
ed)
>>>
>>> -        for checksum_id in CHECKSUM_LIST:
>>> -            configure_checksum(checksum_id)
>>> -
>>> -        self.ignore_checksums =3D False
>>> -
>>>          self.names =3D self.parm.get("name",'default').split(',')
>>>
>>>          self.method =3D None
>>> @@ -1324,6 +1319,11 @@ class FetchData(object):
>>>          if hasattr(self.method, "urldata_init"):
>>>              self.method.urldata_init(self, d)
>>>
>>> +        for checksum_id in CHECKSUM_LIST:
>>> +            configure_checksum(checksum_id)
>>> +
>>> +        self.ignore_checksums =3D False
>>> +
>>>          if "localpath" in self.parm:
>>>              # if user sets localpath for file, use it instead.
>>>              self.localpath =3D self.parm["localpath"]
>>> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
>>> index 73eefc59..fd089bc8 100644
>>> --- a/lib/bb/tests/fetch.py
>>> +++ b/lib/bb/tests/fetch.py
>>> @@ -2377,6 +2377,13 @@ class CrateTest(FetcherTest):
>>>          d =3D self.d
>>>
>>>          fetcher =3D bb.fetch2.Fetch(uris, self.d)
>>> +        ud =3D fetcher.ud[fetcher.urls[0]]
>>> +
>>> +        self.assertIn("name", ud.parm)
>>> +        self.assertEqual(ud.parm["name"], "glob")
>>> +        self.assertIn("downloadfilename", ud.parm)
>>> +        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.cra=
te")
>>> +
>>>          fetcher.download()
>>>          fetcher.unpack(self.tempdir)
>>>          self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_hom=
e', 'download' , 'unpacked'])
>>> @@ -2394,6 +2401,19 @@ class CrateTest(FetcherTest):
>>>          d =3D self.d
>>>
>>>          fetcher =3D bb.fetch2.Fetch(uris, self.d)
>>> +        ud =3D fetcher.ud[fetcher.urls[0]]
>>> +
>>> +        self.assertIn("name", ud.parm)
>>> +        self.assertEqual(ud.parm["name"], "glob")
>>> +        self.assertIn("downloadfilename", ud.parm)
>>> +        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.cra=
te")
>>> +
>>> +        ud =3D fetcher.ud[fetcher.urls[1]]
>>> +        self.assertIn("name", ud.parm)
>>> +        self.assertEqual(ud.parm["name"], "time")
>>> +        self.assertIn("downloadfilename", ud.parm)
>>> +        self.assertEqual(ud.parm["downloadfilename"], "time-0.1.35.cra=
te")
>>> +
>>>          fetcher.download()
>>>          fetcher.unpack(self.tempdir)
>>>          self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_hom=
e', 'download' , 'unpacked'])
>>> @@ -2403,6 +2423,18 @@ class CrateTest(FetcherTest):
>>>          self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bit=
bake/time-0.1.35/.cargo-checksum.json"))
>>>          self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bit=
bake/time-0.1.35/src/lib.rs"))
>>>
>>> +    @skipIfNoNetwork()
>>> +    def test_crate_incorrect_cksum(self):
>>> +        uri =3D "crate://crates.io/aho-corasick/0.7.20"
>>> +        self.d.setVar('SRC_URI', uri)
>>> +        self.d.setVarFlag("SRC_URI", "aho-corasick.sha256sum", hashlib=
.sha256("Invalid".encode("utf-8")).hexdigest())
>>> +
>>> +        uris =3D self.d.getVar('SRC_URI').split()
>>> +
>>> +        fetcher =3D bb.fetch2.Fetch(uris, self.d)
>>> +        with self.assertRaisesRegexp(bb.fetch2.FetchError, "Fetcher fa=
ilure for URL"):
>>> +            fetcher.download()
>>> +
>>>  class NPMTest(FetcherTest):
>>>      def skipIfNoNpm():
>>>          import shutil
>>> --
>>> 2.34.1
>>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14609): https://lists.openembedded.org/g/bitbake-deve=
l/message/14609
> Mute This Topic: https://lists.openembedded.org/mt/97668729/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.k=
anavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

