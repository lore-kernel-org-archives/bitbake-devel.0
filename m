Return-Path: <Jhonata.poma@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6F8CA5FA1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:15 +0000 (UTC)
Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3185.1790670184697712008
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Sep 2026 01:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=azodTGXh;
 spf=pass (domain: gmail.com, ip: 74.125.231.171, mailfrom: jhonata.poma@gmail.com)
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b15bca7dfso1837562a34.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 01:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790670184; cv=none;
        d=google.com; s=arc-20260327;
        b=oDWAXrmXKawZVTNB4GlFHvuKRZXYSZcIvrUoz1o7VV1tDs49FTpVuZwcjVjLPC493O
         VwNTI8kfYGdefI3JI7vSjyJxQedtpEySAzhH9R45iyx9PmROC96Q3vHEVXsYlhtDNMvN
         6KkUjQ4ZyatBc+iYwJ/E/rxpkPR7Qal9eqqHVkmKHKoDW5QDQdeURhp4TB1106xdFFhH
         HNgyn9LrCD5SCjcbsYPHJnoY7LVhu7DQocB1LAMJMGfJrN3lf6K5wYlNnDvaUTCDFWgr
         YJqDfCoAkQVGrmX/K5JftGdXJONrjKoU4ela5u8fj6msSdPt7UL6Dr8SDh2yInIdvYTH
         v3zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SGJvf9pJRRYA5M0XIhl9ED2b8/7uLyoQOPCenHWRAls=;
        fh=BFPYLIMXxVkBrhDNlZuRYoSFWxhCs2l3Izj2IajBkOY=;
        b=QVtWMJyxEf9ZAp+q6j2hvPPZ4Ae+gH1ZjEslh3QwmHS3X6vF4rJreMBcY9xpg98Nlc
         5nWj+sLT2F1dlLs3mSaGGf3MUqX01WcJnGJYGu4YNQ/dOJsaKEsvwP0eI5ZjHi2HVs1h
         dOwHCnBT4BfEQtAa0VchQDBCfAGcL0lpsn/pUMpaLqNeErFw0MR5jVFXvJU0nL4dmz9v
         ZKORUgGF6nRpgVVu8jOGhE1sg8TMm42min9x872/jFE/ZH8f1pIUdIAij5N8rb6ashI8
         yeCF0FagpSFqeDkXCizzGRH50fod++1vSMhq9pj/3YVdLVYXrva69cRuUnuiEE8xF5FJ
         KIsg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790670184; x=1791274984; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGJvf9pJRRYA5M0XIhl9ED2b8/7uLyoQOPCenHWRAls=;
        b=azodTGXhrwtBDWSYIKOW+uKhOeet0eMnAhw/Tsd4VPGorCzJBBXLpTkBQshYAZ/IS2
         QViQPK2Of1CqUCQYXWU6ZEYG8vz5teEMfszzSEef1CdkhuOMszQRGEFCpzqPWv9mC9Ad
         aw3luHR3EfLSvneDu0UP4ZhNnhWm/Phy0FIAnHgZOvLKufkhBtiz3MJOjL7SZL/tMwSG
         HhgVeefSRySAaTP7R/cP94/0gClJ+K9Zu0MbumeSUWy2M5tcfUJS2qVmuU6X3Sug75n4
         0VkZR+ouFP4eheWyLONvRIKDyiY2n+hK9Ee1j8uL/QWivu++gVa2boohPsFo+PT3cNMm
         K2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670184; x=1791274984;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SGJvf9pJRRYA5M0XIhl9ED2b8/7uLyoQOPCenHWRAls=;
        b=bfBnEI1EHaBBJgOWrGINIXT7w9kgp/FNvKn5OcOwqM/hxZByNdIFMaY9V68oTsktfp
         o/uZW0WiKwc+ib7JlQqwvrdiyQP9RzRy8WVyGzLnU/9S5cTnaRXj0VYUVnDyn4hYWrau
         UkhdHsCY0uveYEd0vBccQmP848AXuDsdR0eqnAOtjwCrAZ9E0vvcnL22WlFfZ8McbLgx
         Ys/GNmPl+M+ilI4CikPeiifh+15ux8hMEfa8NPb0cvs119TL2jtml9NiPgDU+8Bv896H
         abBdAk6DRk186a4O1IWbUJLUAbAPe6TQzZyGFPfElSNw5P71i3c6arhCAMymunseR8Dg
         QCNw==
X-Gm-Message-State: AFuF++kr3mcKGMlG0ep+vS7z4DnPr2zIUxS4MKNcme3c2157g3gwVO3T
	wJRzVm8rn9wow+pwu/DstitrstUp9Ad/u6tDKZTPYX0E4j8CjJop0c8SU8Tdpwa6EbHg7ertEuB
	M5D4FP/7x99UXyu7zlbpTCKPN69HTsMU=
X-Gm-Gg: AYBFou00aLMIaF8MaSWAYKRxxaGZ6s7LIKmIRMO+kVT5FmbdFQQNi02A4uf4Dk1mVot
	YgrGzE46DD6VZ/9b7JvXOVJ6DodN3di6QqWSb/sF5xolgf9RlCa3ROTrHgZ+MS1KBnhpn04Y8gA
	fKjtRH2a0q5kvm9vWFnxQGUmMXCmazjU5eN5oj+9jIQ325WUCvsiAZS8vh3q5kIzMA5Si66fFvF
	YguOq19pe6p/YTTFdoxFYuCRN255pCxHje/p/7ZTLNsMYR0GncNpNpvhLVzf4fD66JKuwTZfjvE
	N3idvyOAC5UeFEmtqXVOycYzDxUnnnhQ0T5y4hEGzQMf/lT6v52SwAqxCzMTRZyOzrUMX/7vbzl
	Ka4pB7D8+pciaC0VjQnu6r92OjKJy3JYKGW4mPJg5cw==
X-Received: by 2002:a05:6808:1527:b0:4d6:92c3:adf with SMTP id
 5614622812f47-4d72d3603cfmr14096617b6e.63.1790670183626; Tue, 29 Sep 2026
 01:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <2b5b8d1a56b5db173667efa839208df83188a7ca.camel@pbarker.dev>
 <20260928205940.14169-1-setairidis@gmail.com> <CAKJXz6eaBv_9C9+4O0p=YN_NUJBBLsQo1Q1SN5uos41bcWt7qA@mail.gmail.com>
In-Reply-To: <CAKJXz6eaBv_9C9+4O0p=YN_NUJBBLsQo1Q1SN5uos41bcWt7qA@mail.gmail.com>
From: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
Date: Tue, 29 Sep 2026 10:22:52 +0200
X-Gm-Features: AclHuK8SKrT-VnQhNQ5rsWO2yHvezlrMr-GkKAGtKihs3hXYS2V1_JtmY_XEqnc
Message-ID: <CACgZWq6nkHHwmfihxtyk4hY7mFy8=4p6Jis7CKWBw6k8sP3KTg@mail.gmail.com>
Subject: Re: [PATCH v5] fetch/local: verify checksums for file:// urls
To: Sawas Etairidis <setairidis@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000347b7c065c9ae479"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 08:23:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20278

--000000000000347b7c065c9ae479
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for taking over the patch series. It has been sitting on my to-do
list for quite a while,
it's great that somebody else can push it forward.

Best regards,
Jhonata

Il giorno lun 28 set 2026 alle ore 23:02 Sawas Etairidis <
setairidis@gmail.com> ha scritto:

> Hi,
>
> My bad I assumed that Jhonata stopped working on this based on the ticket
> comments.
> I send him a personal email about this.
>
> Regards,
> Savvas
>
>
> =CE=A3=CF=84=CE=B9=CF=82 =CE=94=CE=B5=CF=85 28 =CE=A3=CE=B5=CF=80 2026 =
=CF=83=CF=84=CE=B9=CF=82 10:59=E2=80=AF=CE=BC.=CE=BC., =CE=BF/=CE=B7 Savvas=
 Etairidis <
> setairidis@gmail.com> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
>> [YOCTO #9993]
>>
>> Local.urldata_init() always cleared needdonestamp, so a checksum given
>> in a file:// url (e.g. UNINATIVE_CHECKSUM when UNINATIVE_URL points at
>> a local file://) was never verified. Keep the donestamp when the url
>> carries a checksum so verify_checksum runs, and make
>> rename_bad_checksum() a FetchMethod method that Local overrides as a
>> no-op, so a mismatch doesn't rename the user's source file.
>>
>> Based on a patch by Jhonata Poma-Hansen.
>>
>> Signed-off-by: Savvas Etairidis <setairidis@gmail.com>
>>
>> ---
>> changes in v5:
>> - Rebased on top of master, added changelog entry
>>
>> changes in v4:
>> - Rebased on top of master
>>
>> changes in v3:
>> - Cherry-picked the patch from Jhonata Poma-Hansen
>>
>> ---
>> ---
>>  lib/bb/fetch/__init__.py | 36 ++++++++++++++++++------------------
>>  lib/bb/fetch/local.py    | 18 ++++++++++++++++--
>>  lib/bb/tests/fetch.py    | 30 ++++++++++++++++++++++++++++++
>>  3 files changed, 64 insertions(+), 20 deletions(-)
>>
>> diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
>> index 55ab710f3..a9f0add78 100644
>> --- a/lib/bb/fetch/__init__.py
>> +++ b/lib/bb/fetch/__init__.py
>> @@ -742,7 +742,7 @@ def verify_donestamp(ud, d, origud=3DNone):
>>          logger.warning("Checksum mismatch for local file %s\n"
>>                         "Cleaning and trying again." % ud.localpath)
>>          if os.path.exists(ud.localpath):
>> -            rename_bad_checksum(ud, e.checksum)
>> +            ud.method.rename_bad_checksum(ud, e.checksum)
>>          bb.utils.remove(ud.donestamp)
>>      return False
>>
>> @@ -775,7 +775,7 @@ def update_stamp(ud, d):
>>              logger.warning("Checksum mismatch for local file %s\n"
>>                             "Cleaning and trying again." % ud.localpath)
>>              if os.path.exists(ud.localpath):
>> -                rename_bad_checksum(ud, e.checksum)
>> +                ud.method.rename_bad_checksum(ud, e.checksum)
>>              bb.utils.remove(ud.donestamp)
>>              raise
>>
>> @@ -1079,20 +1079,6 @@ def build_mirroruris(origud, mirrors, ld):
>>
>>      return uris, uds
>>
>> -def rename_bad_checksum(ud, suffix):
>> -    """
>> -    Renames files to have suffix from parameter
>> -    """
>> -
>> -    if ud.localpath is None:
>> -        return
>> -
>> -    new_localpath =3D "%s_bad-checksum_%s" % (ud.localpath, suffix)
>> -    bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
>> -    if not bb.utils.movefile(ud.localpath, new_localpath):
>> -        bb.warn("Renaming %s to %s failed, grep movefile in log.do_fetc=
h
>> to see why" % (ud.localpath, new_localpath))
>> -
>> -
>>  def try_mirror_url(fetch, origud, ud, ld, check =3D False):
>>      # Return of None or a value means we're finished
>>      # False means try another url
>> @@ -1163,7 +1149,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =
=3D
>> False):
>>              logger.warning("Mirror checksum failure for url %s (origina=
l
>> url: %s)\nCleaning and trying again." % (ud.url, origud.url))
>>              logger.warning(str(e))
>>              if os.path.exists(ud.localpath):
>> -                rename_bad_checksum(ud, e.checksum)
>> +                ud.method.rename_bad_checksum(ud, e.checksum)
>>          elif isinstance(e, NoChecksumError):
>>              raise
>>          else:
>> @@ -1479,6 +1465,20 @@ class FetchMethod(object):
>>          """
>>          return True
>>
>> +    def rename_bad_checksum(self, ud, suffix):
>> +        """
>> +        Rename ud.localpath with the given suffix on checksum mismatch.
>> +        Local overrides this to a no-op since its localpath points at t=
he
>> +        user's source tree.
>> +        """
>> +        if ud.localpath is None:
>> +            return
>> +
>> +        new_localpath =3D "%s_bad-checksum_%s" % (ud.localpath, suffix)
>> +        bb.warn("Renaming %s to %s" % (ud.localpath, new_localpath))
>> +        if not bb.utils.movefile(ud.localpath, new_localpath):
>> +            bb.warn("Renaming %s to %s failed, grep movefile in
>> log.do_fetch to see why" % (ud.localpath, new_localpath))
>> +
>>      def verify_donestamp(self, ud, d):
>>          """
>>          Verify the donestamp file
>> @@ -1943,7 +1943,7 @@ class Fetch(object):
>>                              logger.warning("Checksum failure encountere=
d
>> with download of %s - will attempt other sources if available" % u)
>>                              logger.debug(str(e))
>>                              if os.path.exists(ud.localpath):
>> -                                rename_bad_checksum(ud, e.checksum)
>> +                                ud.method.rename_bad_checksum(ud,
>> e.checksum)
>>                          elif isinstance(e, NoChecksumError):
>>                              raise
>>                          else:
>> diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py
>> index dfc5b564c..a92c0d267 100644
>> --- a/lib/bb/fetch/local.py
>> +++ b/lib/bb/fetch/local.py
>> @@ -17,7 +17,7 @@ import os
>>  import urllib.request, urllib.parse, urllib.error
>>  import bb
>>  import bb.utils
>> -from   bb.fetch import FetchMethod, FetchError, ParameterError
>> +from   bb.fetch import CHECKSUM_LIST, FetchMethod, FetchError,
>> ParameterError
>>  from   bb.fetch import logger
>>
>>  class Local(FetchMethod):
>> @@ -31,11 +31,25 @@ class Local(FetchMethod):
>>          # We don't set localfile as for this fetcher the file is alread=
y
>> local!
>>          ud.basename =3D os.path.basename(ud.path)
>>          ud.basepath =3D ud.path
>> -        ud.needdonestamp =3D False
>> +        # Honor explicit checksum params (UNINATIVE_CHECKSUM, recipe
>> +        # ;sha256sum=3D) by leaving needdonestamp at FetchData's defaul=
t so
>> +        # verify_checksum runs.
>> +        name =3D ud.parm.get("name")
>> +        ud.needdonestamp =3D any(
>> +            (name and "%s.%ssum" % (name, a) in ud.parm)
>> +            or "%ssum" % a in ud.parm
>> +            for a in CHECKSUM_LIST
>> +        )
>>          if "*" in ud.path:
>>              raise bb.fetch.ParameterError("file:// urls using globbing
>> are no longer supported. Please place the files in a directory and
>> reference that instead.", ud.url)
>>          return
>>
>> +    def rename_bad_checksum(self, ud, suffix):
>> +        # file:// urls point at the user's source tree (recipe-shipped
>> files
>> +        # under FILESPATH or an absolute path the user passed in); skip
>> the
>> +        # rename so a ChecksumError surfaces without mutating their
>> files.
>> +        return
>> +
>>      def localpath(self, urldata, d):
>>          """
>>          Return the local filename of a given url assuming a successful
>> fetch.
>> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
>> index 71b0a63fe..60d356fc6 100644
>> --- a/lib/bb/tests/fetch.py
>> +++ b/lib/bb/tests/fetch.py
>> @@ -876,6 +876,36 @@ class FetcherLocalTest(FetcherTest):
>>              with self.subTest(striplevel=3Drepr(value)):
>>                  self.assertInvalidStriplevel(value)
>>
>> +    def test_local_checksum_match(self):
>> +        # Correct sha256 must run verify_checksum to completion;
>> donestamp
>> +        # lands in DL_DIR.
>> +        import hashlib
>> +        content =3D b"file:// checksum match test\n"
>> +        with open(os.path.join(self.localsrcdir, 'sumfile'), 'wb') as f=
:
>> +            f.write(content)
>> +        good =3D hashlib.sha256(content).hexdigest()
>> +        fetcher =3D bb.fetch.Fetch(['file://sumfile;sha256sum=3D' + goo=
d],
>> self.d)
>> +        ud =3D fetcher.ud[fetcher.urls[0]]
>> +        self.assertTrue(ud.needdonestamp)
>> +        fetcher.download()
>> +        self.assertTrue(os.path.exists(ud.donestamp))
>> +
>> +    def test_local_checksum_mismatch(self):
>> +        # Bad sha256 raises ChecksumError without renaming the user's
>> +        # source file to the <localpath>_bad-checksum_<sha> sibling.
>> +        content =3D b"file:// checksum mismatch test\n"
>> +        srcpath =3D os.path.join(self.localsrcdir, 'sumfile')
>> +        with open(srcpath, 'wb') as f:
>> +            f.write(content)
>> +        bad =3D "0" * 64
>> +        fetcher =3D bb.fetch.Fetch(['file://sumfile;sha256sum=3D' + bad=
],
>> self.d)
>> +        with self.assertRaises(bb.fetch.FetchError):
>> +            fetcher.download()
>> +        self.assertTrue(os.path.exists(srcpath))
>> +        with open(srcpath, 'rb') as f:
>> +            self.assertEqual(f.read(), content)
>> +        self.assertFalse(os.path.exists(srcpath + '_bad-checksum_' +
>> bad))
>> +
>>      def dummyGitTest(self, suffix):
>>          # Create dummy local Git repo
>>          src_dir =3D tempfile.mkdtemp(dir=3Dself.tempdir,
>> --
>> 2.34.1
>>
>>

--000000000000347b7c065c9ae479
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_s=
ignature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr"><div>Hi,<br><br></div><div>Thank you for taking over t=
he patch series. It has been sitting on my to-do list for quite a while,<br=
></div><div>it&#39;s great that somebody else can push it forward.</div><di=
v><br></div></div></div></div></div></div>Best regards,<br></div>Jhonata</d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">Il giorno lun 28 set 2026 alle ore 23:02 Sawas Etairidis=
 &lt;<a href=3D"mailto:setairidis@gmail.com">setairidis@gmail.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr">Hi,<div><br></div><div>My bad I assumed that=C2=A0<span style=
=3D"background-color:transparent">Jhonata</span><span style=3D"background-c=
olor:transparent">=C2=A0stopped working on this based on the ticket comment=
s.</span></div><div><span style=3D"background-color:transparent">I send him=
 a personal email about this.</span></div><div><span style=3D"background-co=
lor:transparent"><br></span></div><div><span style=3D"background-color:tran=
sparent">Regards,</span></div><div><span style=3D"background-color:transpar=
ent">Savvas</span></div><div><span style=3D"background-color:transparent"><=
br></span></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">=CE=A3=CF=84=CE=B9=CF=82 =CE=94=CE=B5=CF=85 28 =CE=A3=CE=B5=
=CF=80 2026 =CF=83=CF=84=CE=B9=CF=82 10:59=E2=80=AF=CE=BC.=CE=BC., =CE=BF/=
=CE=B7 Savvas Etairidis &lt;<a href=3D"mailto:setairidis@gmail.com" target=
=3D"_blank">setairidis@gmail.com</a>&gt; =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=
=B5:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">[YOCTO #999=
3]<br>
<br>
Local.urldata_init() always cleared needdonestamp, so a checksum given<br>
in a file:// url (e.g. UNINATIVE_CHECKSUM when UNINATIVE_URL points at<br>
a local file://) was never verified. Keep the donestamp when the url<br>
carries a checksum so verify_checksum runs, and make<br>
rename_bad_checksum() a FetchMethod method that Local overrides as a<br>
no-op, so a mismatch doesn&#39;t rename the user&#39;s source file.<br>
<br>
Based on a patch by Jhonata Poma-Hansen.<br>
<br>
Signed-off-by: Savvas Etairidis &lt;<a href=3D"mailto:setairidis@gmail.com"=
 target=3D"_blank">setairidis@gmail.com</a>&gt;<br>
<br>
---<br>
changes in v5:<br>
- Rebased on top of master, added changelog entry<br>
<br>
changes in v4:<br>
- Rebased on top of master<br>
<br>
changes in v3:<br>
- Cherry-picked the patch from Jhonata Poma-Hansen<br>
<br>
---<br>
---<br>
=C2=A0lib/bb/fetch/__init__.py | 36 ++++++++++++++++++------------------<br=
>
=C2=A0lib/bb/fetch/local.py=C2=A0 =C2=A0 | 18 ++++++++++++++++--<br>
=C2=A0lib/bb/tests/fetch.py=C2=A0 =C2=A0 | 30 +++++++++++++++++++++++++++++=
+<br>
=C2=A03 files changed, 64 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py<br>
index 55ab710f3..a9f0add78 100644<br>
--- a/lib/bb/fetch/__init__.py<br>
+++ b/lib/bb/fetch/__init__.py<br>
@@ -742,7 +742,7 @@ def verify_donestamp(ud, d, origud=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Checksum mismatch fo=
r local file %s\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Cleaning and trying again.&quot; % ud.localpath)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localpath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename_bad_checksum(ud, e.checks=
um)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.method.rename_bad_checksum(ud=
, e.checksum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remove(ud.donestamp)<br>
=C2=A0 =C2=A0 =C2=A0return False<br>
<br>
@@ -775,7 +775,7 @@ def update_stamp(ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Checks=
um mismatch for local file %s\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Cleaning and trying again.&quot; % ud.localp=
ath)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localp=
ath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename_bad_checksu=
m(ud, e.checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.method.rename_b=
ad_checksum(ud, e.checksum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.remove(ud.donestam=
p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
<br>
@@ -1079,20 +1079,6 @@ def build_mirroruris(origud, mirrors, ld):<br>
<br>
=C2=A0 =C2=A0 =C2=A0return uris, uds<br>
<br>
-def rename_bad_checksum(ud, suffix):<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 Renames files to have suffix from parameter<br>
-=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-<br>
-=C2=A0 =C2=A0 if ud.localpath is None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
-<br>
-=C2=A0 =C2=A0 new_localpath =3D &quot;%s_bad-checksum_%s&quot; % (ud.local=
path, suffix)<br>
-=C2=A0 =C2=A0 bb.warn(&quot;Renaming %s to %s&quot; % (ud.localpath, new_l=
ocalpath))<br>
-=C2=A0 =C2=A0 if not bb.utils.movefile(ud.localpath, new_localpath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Renaming %s to %s failed, grep m=
ovefile in log.do_fetch to see why&quot; % (ud.localpath, new_localpath))<b=
r>
-<br>
-<br>
=C2=A0def try_mirror_url(fetch, origud, ud, ld, check =3D False):<br>
=C2=A0 =C2=A0 =C2=A0# Return of None or a value means we&#39;re finished<br=
>
=C2=A0 =C2=A0 =C2=A0# False means try another url<br>
@@ -1163,7 +1149,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =3D F=
alse):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Mirror=
 checksum failure for url %s (original url: %s)\nCleaning and trying again.=
&quot; % (ud.url, origud.url))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(str(e))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localp=
ath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename_bad_checksu=
m(ud, e.checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.method.rename_b=
ad_checksum(ud, e.checksum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif isinstance(e, NoChecksumError):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
@@ -1479,6 +1465,20 @@ class FetchMethod(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return True<br>
<br>
+=C2=A0 =C2=A0 def rename_bad_checksum(self, ud, suffix):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Rename ud.localpath with the given suffix on c=
hecksum mismatch.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Local overrides this to a no-op since its loca=
lpath points at the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 user&#39;s source tree.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.localpath is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_localpath =3D &quot;%s_bad-checksum_%s&quo=
t; % (ud.localpath, suffix)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Renaming %s to %s&quot; % (ud.lo=
calpath, new_localpath))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not bb.utils.movefile(ud.localpath, new_loc=
alpath):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Renaming %s to %s =
failed, grep movefile in log.do_fetch to see why&quot; % (ud.localpath, new=
_localpath))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def verify_donestamp(self, ud, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Verify the donestamp file<br>
@@ -1943,7 +1943,7 @@ class Fetch(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.warning(&quot;Checksum failure encoun=
tered with download of %s - will attempt other sources if available&quot; %=
 u)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(str(e))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.path.exists(ud.localpath):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rename_bad_checksum(ud, e.checksum)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.method.rename_bad_checksum(ud, e.=
checksum)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0elif isinstance(e, NoChecksumError):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0else:<br>
diff --git a/lib/bb/fetch/local.py b/lib/bb/fetch/local.py<br>
index dfc5b564c..a92c0d267 100644<br>
--- a/lib/bb/fetch/local.py<br>
+++ b/lib/bb/fetch/local.py<br>
@@ -17,7 +17,7 @@ import os<br>
=C2=A0import urllib.request, urllib.parse, urllib.error<br>
=C2=A0import bb<br>
=C2=A0import bb.utils<br>
-from=C2=A0 =C2=A0bb.fetch import FetchMethod, FetchError, ParameterError<b=
r>
+from=C2=A0 =C2=A0bb.fetch import CHECKSUM_LIST, FetchMethod, FetchError, P=
arameterError<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch import logger<br>
<br>
=C2=A0class Local(FetchMethod):<br>
@@ -31,11 +31,25 @@ class Local(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We don&#39;t set localfile as for this =
fetcher the file is already local!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basename =3D os.path.basename(ud.path)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.basepath =3D ud.path<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.needdonestamp =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Honor explicit checksum params (UNINATIVE_CH=
ECKSUM, recipe<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # ;sha256sum=3D) by leaving needdonestamp at F=
etchData&#39;s default so<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify_checksum runs.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D ud.parm.get(&quot;name&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.needdonestamp =3D any(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (name and &quot;%s.%ssum&quot; %=
 (name, a) in ud.parm)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or &quot;%ssum&quot; % a in ud.p=
arm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for a in CHECKSUM_LIST<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;*&quot; in ud.path:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise bb.fetch.ParameterErr=
or(&quot;file:// urls using globbing are no longer supported. Please place =
the files in a directory and reference that instead.&quot;, ud.url)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
<br>
+=C2=A0 =C2=A0 def rename_bad_checksum(self, ud, suffix):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # file:// urls point at the user&#39;s source =
tree (recipe-shipped files<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # under FILESPATH or an absolute path the user=
 passed in); skip the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # rename so a ChecksumError surfaces without m=
utating their files.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def localpath(self, urldata, d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Return the local filename of a given url =
assuming a successful fetch.<br>
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py<br>
index 71b0a63fe..60d356fc6 100644<br>
--- a/lib/bb/tests/fetch.py<br>
+++ b/lib/bb/tests/fetch.py<br>
@@ -876,6 +876,36 @@ class FetcherLocalTest(FetcherTest):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with self.subTest(stripleve=
l=3Drepr(value)):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertIn=
validStriplevel(value)<br>
<br>
+=C2=A0 =C2=A0 def test_local_checksum_match(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Correct sha256 must run verify_checksum to c=
ompletion; donestamp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # lands in DL_DIR.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 import hashlib<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D b&quot;file:// checksum match test=
\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(self.localsrcdir, &#39;=
sumfile&#39;), &#39;wb&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(content)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 good =3D hashlib.sha256(content).hexdigest()<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch.Fetch([&#39;file://sumfil=
e;sha256sum=3D&#39; + good], self.d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud =3D fetcher.ud[fetcher.urls[0]]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(ud.needdonestamp)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exists(ud.donestamp))<=
br>
+<br>
+=C2=A0 =C2=A0 def test_local_checksum_mismatch(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Bad sha256 raises ChecksumError without rena=
ming the user&#39;s<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # source file to the &lt;localpath&gt;_bad-che=
cksum_&lt;sha&gt; sibling.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 content =3D b&quot;file:// checksum mismatch t=
est\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 srcpath =3D os.path.join(self.localsrcdir, &#3=
9;sumfile&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(srcpath, &#39;wb&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(content)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bad =3D &quot;0&quot; * 64<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch.Fetch([&#39;file://sumfil=
e;sha256sum=3D&#39; + bad], self.d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with self.assertRaises(bb.fetch.FetchError):<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(os.path.exists(srcpath))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(srcpath, &#39;rb&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(f.read(), conte=
nt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertFalse(os.path.exists(srcpath + &#39=
;_bad-checksum_&#39; + bad))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def dummyGitTest(self, suffix):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Create dummy local Git repo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_dir =3D tempfile.mkdtemp(dir=3Dself.t=
empdir,<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000347b7c065c9ae479--

