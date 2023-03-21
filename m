Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A9C6FD20
	for <webhook@archiver.kernel.org>; Tue, 21 Mar 2023 19:51:49 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.24456.1679428301407190071
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Mar 2023 12:51:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=N1Te+N27;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id c29so3107243lfv.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679428299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YSel2L0vP7gzZsMD6PsGl7Y8YrszWUIZL32QJqKa5zw=;
        b=N1Te+N27I4oTFghQHnUs2xmv2mQT0o4OAiLmWkj2Dw2whtxO4xcVC/KEn7twFmaOhE
         Ttk9iB1rq7kZWC5zjjf1Yl+ecbir/jlwp36tY0wdyQ5ZWZ00kL341639NsxQDysYGJo7
         lSQVhCat1kvaYahxPWJw8ogdQko9lFpsqn5EnY947eM3LAJalbxV40dHmUgzwCOFd9F4
         UqOQT2qqEFa7u7g09zuyLSe51ChoQapBqaaPh9mMxpymNRWZ6NEJwWUNc0lZIMljolRI
         AY12PpCeBquM2XEZUgUSBQA5JgtXgoRbnrHO4mLn20a3ndHrOI9hmkNj/Oskx2mI65Xm
         dV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSel2L0vP7gzZsMD6PsGl7Y8YrszWUIZL32QJqKa5zw=;
        b=HVXnwWtZNfrhSUxGk/R30StGIfvK6m3mbOXsraI5ASvsNKT7ADUt5kEBPdgq++MS8s
         fWVsGXxA5d0ywHzlZgWOgN/MDy5qSnblknqGkmfiH7CA907Qw6v0PBxYh99QrC3ofTYS
         3lgh2AxHJ8mHgP4whI1hkomAoBivkWnr87k00WbHkX5l1gRWPM3BiiNvbnXrKwPIdYk0
         lzHCUWwXkMHeu7LYx7JjwVvRjwiWKtIvVHt7CQ0+4oJo9oTJ1vHOR7aY+lHkZfxWv3PZ
         meACl51UfDThGY6sEz4QlapaPggtOqADrjPxKCpGXy49JZHiF8nAKXFxHOp2LkNUvLhU
         tOEw==
X-Gm-Message-State: AO0yUKX+eDKknvP+a9uVPc7kB2vCnjNQ56Y6LKEb7EzpmSRyZ6CEjGsz
	bsoebqWRA1blR0UihCjdLay9slr6y51ftxhz1Tk=
X-Google-Smtp-Source: AK7set/umYxUgSsDbiM7dg5ps8gyCynlishNwKoxjSgDwIHoQ007Ltm+WsbqLTi04ncA2aSwPZZdAkvVof5i2pOpH/w=
X-Received: by 2002:ac2:508b:0:b0:4db:38ba:618d with SMTP id
 f11-20020ac2508b000000b004db38ba618dmr1158405lfm.12.1679428299213; Tue, 21
 Mar 2023 12:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
 <CA+cAkep0W_Jjvvpg2OEm+DE6SDUB98-OnghOyytijbU1qC1B2A@mail.gmail.com>
 <CA+cAkeptpiiEmx=JdevFu3_gg5gn0+mBjKs6VJ4wdMgG_79Xsw@mail.gmail.com> <CANNYZj8QH=et-KTCU=d23Dm4Px7RdKjR5HHFctvKgCTBKPYKJw@mail.gmail.com>
In-Reply-To: <CANNYZj8QH=et-KTCU=d23Dm4Px7RdKjR5HHFctvKgCTBKPYKJw@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Tue, 21 Mar 2023 20:51:27 +0100
Message-ID: <CA+cAkerq3f1naj61+EDLLqa=4_S-nnvFLfcVW=VRdqgk_3ZQBg@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2 1/3] fetch2: Add checksum capability for
 crate fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000003352ee05f76e5fb4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 19:51:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14611

--0000000000003352ee05f76e5fb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm asking because I had a feedback from abelloni about the patch series to
update
openembedded-core concerning a build failure (
https://lists.openembedded.org/g/bitbake-devel/topic/97648804#14600)
and I think there was a misunderstanding about the "applicability" of some
of bitbake's patches that
was required to compile. And I don't know if I managed to clarify that (and
if I understood well).

Anyway, I wasn't aware that there is a feature freeze now, I'll wait for
feedback then.

Thanks Alex.

Le mar. 21 mars 2023, 19:35, Alexander Kanavin <alex.kanavin@gmail.com> a
=C3=A9crit :

> I believe all the patches are now in abelloni's staging branch:
> https://git.yoctoproject.org/poky-contrib/log/?h=3Dabelloni/master-next
>
> If they need a rework, or otherwise aren't suitable, you'll get feedback.
>
> Note that we're in the feature freeze now; while this is a
> comparatively low risk change (in my view), it may have to wait until
> after mickledore's out.
>
> Alex
>
> On Tue, 21 Mar 2023 at 18:26, Frederic Martinsons
> <frederic.martinsons@gmail.com> wrote:
> >
> > If dependencies between bitbake and other layers is an issue, I can
> suppress the patch n2 of this
> > series to disable the verification of the checksum, and wait for all
> patches (bitbake, meta-oe and oe-core)
> > to be applied.
> > Finally, I would issue a new patch to make the checksum verification
> mandatory.
> >
> > On Tue, 21 Mar 2023 at 18:02, Fr=C3=A9d=C3=A9ric Martinsons <
> frederic.martinsons@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> Should I verify something more for this series?
> >> I understood that it is a useful development to have in bitbake fetche=
r
> (but will break things if series in oe-core and meta-oe are not applied
> after this one) and I'm wondering if something block the review / apply ?
> >>
> >> Please tell me, I'll do all my best to secure this.
> >>
> >> Have a good day.
> >>
> >> Le ven. 17 mars 2023, 09:19, <frederic.martinsons@gmail.com> a =C3=A9c=
rit :
> >>>
> >>> From: Frederic Martinsons <frederic.martinsons@gmail.com>
> >>>
> >>> This change brings checksum verification of each crate
> >>> in a recipe, e.g
> >>>
> >>> | SRC_URI +=3D " \
> >>> |     crate://crates.io/aho-corasick/0.7.20 \
> >>> |     crate://crates.io/atomic-waker/1.1.0 \
> >>> |     crate://crates.io/cc/1.0.79 \
> >>> | "
> >>> |
> >>> | SRC_URI[aho-corasick.sha256sum] =3D
> "cc936419f96fa211c1b9166887b38e5e40b19958e5b895be7c1f93adec7071ac"
> >>> | SRC_URI[atomic-waker.sha256sum] =3D
> "debc29dde2e69f9e47506b525f639ed42300fc014a3e007832592448fa8e4599"
> >>> | SRC_URI[cc.sha256sum] =3D
> "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"
> >>>
> >>> That will require to move the checksum initialization
> >>> after the possible call to urldata_init method in order
> >>> for the crate fetcher to parse the url.
> >>>
> >>> Another way of doing could have been implementing a decodeurl
> >>> method that would have been specific for each fetcher class.
> >>>
> >>> Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
> >>> ---
> >>>  lib/bb/fetch2/__init__.py | 12 ++++++------
> >>>  lib/bb/tests/fetch.py     | 32 ++++++++++++++++++++++++++++++++
> >>>  2 files changed, 38 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> >>> index cf65727a..3ae83fa8 100644
> >>> --- a/lib/bb/fetch2/__init__.py
> >>> +++ b/lib/bb/fetch2/__init__.py
> >>> @@ -1291,18 +1291,13 @@ class FetchData(object):
> >>>
> >>>              if checksum_name in self.parm:
> >>>                  checksum_expected =3D self.parm[checksum_name]
> >>> -            elif self.type not in ["http", "https", "ftp", "ftps",
> "sftp", "s3", "az"]:
> >>> +            elif self.type not in ["http", "https", "ftp", "ftps",
> "sftp", "s3", "az", "crate"]:
> >>>                  checksum_expected =3D None
> >>>              else:
> >>>                  checksum_expected =3D d.getVarFlag("SRC_URI",
> checksum_name)
> >>>
> >>>              setattr(self, "%s_expected" % checksum_id,
> checksum_expected)
> >>>
> >>> -        for checksum_id in CHECKSUM_LIST:
> >>> -            configure_checksum(checksum_id)
> >>> -
> >>> -        self.ignore_checksums =3D False
> >>> -
> >>>          self.names =3D self.parm.get("name",'default').split(',')
> >>>
> >>>          self.method =3D None
> >>> @@ -1324,6 +1319,11 @@ class FetchData(object):
> >>>          if hasattr(self.method, "urldata_init"):
> >>>              self.method.urldata_init(self, d)
> >>>
> >>> +        for checksum_id in CHECKSUM_LIST:
> >>> +            configure_checksum(checksum_id)
> >>> +
> >>> +        self.ignore_checksums =3D False
> >>> +
> >>>          if "localpath" in self.parm:
> >>>              # if user sets localpath for file, use it instead.
> >>>              self.localpath =3D self.parm["localpath"]
> >>> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> >>> index 73eefc59..fd089bc8 100644
> >>> --- a/lib/bb/tests/fetch.py
> >>> +++ b/lib/bb/tests/fetch.py
> >>> @@ -2377,6 +2377,13 @@ class CrateTest(FetcherTest):
> >>>          d =3D self.d
> >>>
> >>>          fetcher =3D bb.fetch2.Fetch(uris, self.d)
> >>> +        ud =3D fetcher.ud[fetcher.urls[0]]
> >>> +
> >>> +        self.assertIn("name", ud.parm)
> >>> +        self.assertEqual(ud.parm["name"], "glob")
> >>> +        self.assertIn("downloadfilename", ud.parm)
> >>> +        self.assertEqual(ud.parm["downloadfilename"],
> "glob-0.2.11.crate")
> >>> +
> >>>          fetcher.download()
> >>>          fetcher.unpack(self.tempdir)
> >>>          self.assertEqual(sorted(os.listdir(self.tempdir)),
> ['cargo_home', 'download' , 'unpacked'])
> >>> @@ -2394,6 +2401,19 @@ class CrateTest(FetcherTest):
> >>>          d =3D self.d
> >>>
> >>>          fetcher =3D bb.fetch2.Fetch(uris, self.d)
> >>> +        ud =3D fetcher.ud[fetcher.urls[0]]
> >>> +
> >>> +        self.assertIn("name", ud.parm)
> >>> +        self.assertEqual(ud.parm["name"], "glob")
> >>> +        self.assertIn("downloadfilename", ud.parm)
> >>> +        self.assertEqual(ud.parm["downloadfilename"],
> "glob-0.2.11.crate")
> >>> +
> >>> +        ud =3D fetcher.ud[fetcher.urls[1]]
> >>> +        self.assertIn("name", ud.parm)
> >>> +        self.assertEqual(ud.parm["name"], "time")
> >>> +        self.assertIn("downloadfilename", ud.parm)
> >>> +        self.assertEqual(ud.parm["downloadfilename"],
> "time-0.1.35.crate")
> >>> +
> >>>          fetcher.download()
> >>>          fetcher.unpack(self.tempdir)
> >>>          self.assertEqual(sorted(os.listdir(self.tempdir)),
> ['cargo_home', 'download' , 'unpacked'])
> >>> @@ -2403,6 +2423,18 @@ class CrateTest(FetcherTest):
> >>>          self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/time-0.1.35/.cargo-checksum.json"))
> >>>          self.assertTrue(os.path.exists(self.tempdir +
> "/cargo_home/bitbake/time-0.1.35/src/lib.rs"))
> >>>
> >>> +    @skipIfNoNetwork()
> >>> +    def test_crate_incorrect_cksum(self):
> >>> +        uri =3D "crate://crates.io/aho-corasick/0.7.20"
> >>> +        self.d.setVar('SRC_URI', uri)
> >>> +        self.d.setVarFlag("SRC_URI", "aho-corasick.sha256sum",
> hashlib.sha256("Invalid".encode("utf-8")).hexdigest())
> >>> +
> >>> +        uris =3D self.d.getVar('SRC_URI').split()
> >>> +
> >>> +        fetcher =3D bb.fetch2.Fetch(uris, self.d)
> >>> +        with self.assertRaisesRegexp(bb.fetch2.FetchError, "Fetcher
> failure for URL"):
> >>> +            fetcher.download()
> >>> +
> >>>  class NPMTest(FetcherTest):
> >>>      def skipIfNoNpm():
> >>>          import shutil
> >>> --
> >>> 2.34.1
> >>>
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14609):
> https://lists.openembedded.org/g/bitbake-devel/message/14609
> > Mute This Topic: https://lists.openembedded.org/mt/97668729/1686489
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>

--0000000000003352ee05f76e5fb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m asking because I had a feedback from abelloni=
 about the patch series to update<br></div><div>openembedded-core concernin=
g a build failure (<a href=3D"https://lists.openembedded.org/g/bitbake-deve=
l/topic/97648804#14600">https://lists.openembedded.org/g/bitbake-devel/topi=
c/97648804#14600</a>)</div><div>and I think there was a misunderstanding ab=
out the &quot;applicability&quot; of some of bitbake&#39;s patches that</di=
v><div>was required to compile. And I don&#39;t know if I managed=C2=A0to c=
larify that (and if I understood well).</div><div><br></div><div>Anyway, I =
wasn&#39;t aware that there is a feature freeze now, I&#39;ll wait for feed=
back then.</div><div><br></div><div>Thanks Alex.</div></div><div dir=3D"aut=
o"></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">Le mar. 21 mars 2023, 19:35, Alexander Kanavin &lt;<a href=3D"mailto:ale=
x.kanavin@gmail.com" target=3D"_blank">alex.kanavin@gmail.com</a>&gt; a =C3=
=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I=
 believe all the patches are now in abelloni&#39;s staging branch:<br>
<a href=3D"https://git.yoctoproject.org/poky-contrib/log/?h=3Dabelloni/mast=
er-next" rel=3D"noreferrer noreferrer" target=3D"_blank">https://git.yoctop=
roject.org/poky-contrib/log/?h=3Dabelloni/master-next</a><br>
<br>
If they need a rework, or otherwise aren&#39;t suitable, you&#39;ll get fee=
dback.<br>
<br>
Note that we&#39;re in the feature freeze now; while this is a<br>
comparatively low risk change (in my view), it may have to wait until<br>
after mickledore&#39;s out.<br>
<br>
Alex<br>
<br>
On Tue, 21 Mar 2023 at 18:26, Frederic Martinsons<br>
&lt;<a href=3D"mailto:frederic.martinsons@gmail.com" rel=3D"noreferrer" tar=
get=3D"_blank">frederic.martinsons@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; If dependencies between bitbake and other layers is an issue, I can su=
ppress the patch n2 of this<br>
&gt; series to disable the verification of the checksum, and wait for all p=
atches (bitbake, meta-oe and oe-core)<br>
&gt; to be applied.<br>
&gt; Finally, I would issue a new patch to make the checksum verification m=
andatory.<br>
&gt;<br>
&gt; On Tue, 21 Mar 2023 at 18:02, Fr=C3=A9d=C3=A9ric Martinsons &lt;<a hre=
f=3D"mailto:frederic.martinsons@gmail.com" rel=3D"noreferrer" target=3D"_bl=
ank">frederic.martinsons@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hello,<br>
&gt;&gt;<br>
&gt;&gt; Should I verify something more for this series?<br>
&gt;&gt; I understood that it is a useful development to have in bitbake fe=
tcher (but will break things if series in oe-core and meta-oe are not appli=
ed after this one) and I&#39;m wondering if something block the review / ap=
ply ?<br>
&gt;&gt;<br>
&gt;&gt; Please tell me, I&#39;ll do all my best to secure this.<br>
&gt;&gt;<br>
&gt;&gt; Have a good day.<br>
&gt;&gt;<br>
&gt;&gt; Le ven. 17 mars 2023, 09:19, &lt;<a href=3D"mailto:frederic.martin=
sons@gmail.com" rel=3D"noreferrer" target=3D"_blank">frederic.martinsons@gm=
ail.com</a>&gt; a =C3=A9crit :<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; From: Frederic Martinsons &lt;<a href=3D"mailto:frederic.marti=
nsons@gmail.com" rel=3D"noreferrer" target=3D"_blank">frederic.martinsons@g=
mail.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This change brings checksum verification of each crate<br>
&gt;&gt;&gt; in a recipe, e.g<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; | SRC_URI +=3D &quot; \<br>
&gt;&gt;&gt; |=C2=A0 =C2=A0 =C2=A0crate://<a href=3D"http://crates.io/aho-c=
orasick/0.7.20" rel=3D"noreferrer noreferrer" target=3D"_blank">crates.io/a=
ho-corasick/0.7.20</a> \<br>
&gt;&gt;&gt; |=C2=A0 =C2=A0 =C2=A0crate://<a href=3D"http://crates.io/atomi=
c-waker/1.1.0" rel=3D"noreferrer noreferrer" target=3D"_blank">crates.io/at=
omic-waker/1.1.0</a> \<br>
&gt;&gt;&gt; |=C2=A0 =C2=A0 =C2=A0crate://<a href=3D"http://crates.io/cc/1.=
0.79" rel=3D"noreferrer noreferrer" target=3D"_blank">crates.io/cc/1.0.79</=
a> \<br>
&gt;&gt;&gt; | &quot;<br>
&gt;&gt;&gt; |<br>
&gt;&gt;&gt; | SRC_URI[aho-corasick.sha256sum] =3D &quot;cc936419f96fa211c1=
b9166887b38e5e40b19958e5b895be7c1f93adec7071ac&quot;<br>
&gt;&gt;&gt; | SRC_URI[atomic-waker.sha256sum] =3D &quot;debc29dde2e69f9e47=
506b525f639ed42300fc014a3e007832592448fa8e4599&quot;<br>
&gt;&gt;&gt; | SRC_URI[cc.sha256sum] =3D &quot;50d30906286121d95be3d479533b=
458f87493b30a4b5f79a607db8f5d11aa91f&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; That will require to move the checksum initialization<br>
&gt;&gt;&gt; after the possible call to urldata_init method in order<br>
&gt;&gt;&gt; for the crate fetcher to parse the url.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Another way of doing could have been implementing a decodeurl<=
br>
&gt;&gt;&gt; method that would have been specific for each fetcher class.<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Frederic Martinsons &lt;<a href=3D"mailto:frede=
ric.martinsons@gmail.com" rel=3D"noreferrer" target=3D"_blank">frederic.mar=
tinsons@gmail.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 lib/bb/fetch2/__init__.py | 12 ++++++------<br>
&gt;&gt;&gt;=C2=A0 lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0| 32 ++++++++++=
++++++++++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 2 files changed, 38 insertions(+), 6 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init_=
_.py<br>
&gt;&gt;&gt; index cf65727a..3ae83fa8 100644<br>
&gt;&gt;&gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt;&gt;&gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt;&gt;&gt; @@ -1291,18 +1291,13 @@ class FetchData(object):<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if checksum_na=
me in self.parm:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
checksum_expected =3D self.parm[checksum_name]<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif self.type not =
in [&quot;http&quot;, &quot;https&quot;, &quot;ftp&quot;, &quot;ftps&quot;,=
 &quot;sftp&quot;, &quot;s3&quot;, &quot;az&quot;]:<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif self.type not =
in [&quot;http&quot;, &quot;https&quot;, &quot;ftp&quot;, &quot;ftps&quot;,=
 &quot;sftp&quot;, &quot;s3&quot;, &quot;az&quot;, &quot;crate&quot;]:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
checksum_expected =3D None<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
checksum_expected =3D d.getVarFlag(&quot;SRC_URI&quot;, checksum_name)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setattr(self, =
&quot;%s_expected&quot; % checksum_id, checksum_expected)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 for checksum_id in CHECKSUM_LIST:=
<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 configure_checksum(=
checksum_id)<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ignore_checksums =3D False<b=
r>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.names =3D self.parm.get=
(&quot;name&quot;,&#39;default&#39;).split(&#39;,&#39;)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.method =3D None<br>
&gt;&gt;&gt; @@ -1324,6 +1319,11 @@ class FetchData(object):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if hasattr(self.method, &quo=
t;urldata_init&quot;):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.method.ur=
ldata_init(self, d)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for checksum_id in CHECKSUM_LIST:=
<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 configure_checksum(=
checksum_id)<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ignore_checksums =3D False<b=
r>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;localpath&quot; in =
self.parm:<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # if user sets=
 localpath for file, use it instead.<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.localpath=
 =3D self.parm[&quot;localpath&quot;]<br>
&gt;&gt;&gt; diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br>
&gt;&gt;&gt; index 73eefc59..fd089bc8 100644<br>
&gt;&gt;&gt; --- a/lib/bb/tests/fetch.py<br>
&gt;&gt;&gt; +++ b/lib/bb/tests/fetch.py<br>
&gt;&gt;&gt; @@ -2377,6 +2377,13 @@ class CrateTest(FetcherTest):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d =3D self.d<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch2.Fetch(=
uris, self.d)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[0]=
]<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;name&quot;, u=
d.parm)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;na=
me&quot;], &quot;glob&quot;)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;downloadfilen=
ame&quot;, ud.parm)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;do=
wnloadfilename&quot;], &quot;glob-0.2.11.crate&quot;)<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.unpack(self.tempdir)=
<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(sorted(os.l=
istdir(self.tempdir)), [&#39;cargo_home&#39;, &#39;download&#39; , &#39;unp=
acked&#39;])<br>
&gt;&gt;&gt; @@ -2394,6 +2401,19 @@ class CrateTest(FetcherTest):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d =3D self.d<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch2.Fetch(=
uris, self.d)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[0]=
]<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;name&quot;, u=
d.parm)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;na=
me&quot;], &quot;glob&quot;)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;downloadfilen=
ame&quot;, ud.parm)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;do=
wnloadfilename&quot;], &quot;glob-0.2.11.crate&quot;)<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[1]=
]<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;name&quot;, u=
d.parm)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;na=
me&quot;], &quot;time&quot;)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertIn(&quot;downloadfilen=
ame&quot;, ud.parm)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(ud.parm[&quot;do=
wnloadfilename&quot;], &quot;time-0.1.35.crate&quot;)<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.unpack(self.tempdir)=
<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(sorted(os.l=
istdir(self.tempdir)), [&#39;cargo_home&#39;, &#39;download&#39; , &#39;unp=
acked&#39;])<br>
&gt;&gt;&gt; @@ -2403,6 +2423,18 @@ class CrateTest(FetcherTest):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exis=
ts(self.tempdir + &quot;/cargo_home/bitbake/time-0.1.35/.cargo-checksum.jso=
n&quot;))<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exis=
ts(self.tempdir + &quot;/cargo_home/bitbake/time-0.1.35/src/<a href=3D"http=
://lib.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">lib.rs</a>&quot;=
))<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 @skipIfNoNetwork()<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 def test_crate_incorrect_cksum(self):<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uri =3D &quot;crate://<a href=3D"=
http://crates.io/aho-corasick/0.7.20" rel=3D"noreferrer noreferrer" target=
=3D"_blank">crates.io/aho-corasick/0.7.20</a>&quot;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVar(&#39;SRC_URI&#39;, =
uri)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.d.setVarFlag(&quot;SRC_URI&q=
uot;, &quot;aho-corasick.sha256sum&quot;, hashlib.sha256(&quot;Invalid&quot=
;.encode(&quot;utf-8&quot;)).hexdigest())<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uris =3D self.d.getVar(&#39;SRC_U=
RI&#39;).split()<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch2.Fetch(uris,=
 self.d)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 with self.assertRaisesRegexp(bb.f=
etch2.FetchError, &quot;Fetcher failure for URL&quot;):<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<=
br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 class NPMTest(FetcherTest):<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 def skipIfNoNpm():<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import shutil<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.34.1<br>
&gt;&gt;&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#14609): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/14609" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://lists.openembedded.org/g/bitbake-devel/message/14609</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/97668729=
/1686489" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.ope=
nembedded.org/mt/97668729/1686489</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" rel=3D"noreferrer" target=3D"_blank">bitbake-devel+owner@lists.opene=
mbedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.opene=
mbedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail=
.com" rel=3D"noreferrer" target=3D"_blank">alex.kanavin@gmail.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
</blockquote></div>

--0000000000003352ee05f76e5fb4--

