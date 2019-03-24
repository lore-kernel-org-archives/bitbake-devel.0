Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
	[209.85.128.43])
	by mail.openembedded.org (Postfix) with ESMTP id 4232171CBD
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Mar 2019 00:03:15 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id h18so5493741wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 17:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=DGmAiazOJZyTYQR3R94Zn+KQrgdIuje5vgY4lkdIxv4=;
	b=VchyGxMp+MyfLZ4grFPv2Q4BnzjmHZu1Kjau384C4EXtXVfB73MOHODUKki1pXpouP
	kN5/ninN8xmJeKAxSRki6l7VCTQSVebST4EozJrMEj5toyOTMY6Np6wIZsnGkiAwNb3b
	2xOXTPpzXW/PZpOSmCMDfiQAai37r/VBehyj36medMe1WuF75v8UuhQaULVYl9OFV0Qg
	c9DrAEWM6+p3YCgDZSqXerUs8tvxlvWB8hP8KERuAu73UpQHGMa8Hy3phRC7iJ1lOzXd
	89qDSJKJgEOYA7olL0k5gr9OzC54zAhk4/0il+4CL6sD9Ai6UO/af6y2vayT15E8jJMe
	hGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=DGmAiazOJZyTYQR3R94Zn+KQrgdIuje5vgY4lkdIxv4=;
	b=bIiJ/LIRMBo7++1bRhh5igOJQg2mHbgsTu3deMw+bkRnXHBpsoF4kyTSN3chGsx61i
	y7kwwPAJ0klbwyFdoQH4V1M5zVGPLkrpHCjySt81yiDL4urL9G++G5DK4VHIk4HG5iOF
	R1Aoi2Qfxcpb7vJL4QnDrLxGKkwGcrBCY8Sb0LvtTrz0rsm807no6ry4zF9BoudPuHl3
	Jj5h9PVefD5fCvJCF4X7Kf1OL38ZIRJagGBAELix5jO+bjMrDLvEjENuSLAsaJOUntbS
	ssRDEXXU5k0lp25RhMSeX3d9C/+eUfxWUmd01Wj6kgGBiBt8Lq2DChdGiOdh8Q+TIgxL
	iEvA==
X-Gm-Message-State: APjAAAWnFh3urRSstm8GPdY9GlUiE7KO4ZITUltpdiDjWUIDob4zssvF
	YFDAGMrgF219NdWWjxpNkIpWcPtlhmSwd91R2Cc=
X-Google-Smtp-Source: APXvYqwVKqkycWiKxuX2ubHEgoqhj3OnsvzEiDBMu81uYA+46BnzSVMAfv4DKfOxix6nYemyw6U2Owj1LWpceUGXqPE=
X-Received: by 2002:a05:600c:210e:: with SMTP id
	u14mr1173697wml.50.1553385795844; 
	Sat, 23 Mar 2019 17:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553306877.git.akuster808@gmail.com>
	<CA+chaQcb_6aOd7Xv6D-yNtMobrU81MBSvw=0uvqjMr1-HzOS3w@mail.gmail.com>
	<5e7ac387-3a30-6fd3-b593-a2636e0cb93e@mvista.com>
	<CA+chaQdRiXjs-WcFVQ6ppe96LJ=ZehUS045GbQk5ZVHfPxZT3Q@mail.gmail.com>
	<1c5e4301-95c9-c004-681a-1b6c3ccb936f@gmail.com>
In-Reply-To: <1c5e4301-95c9-c004-681a-1b6c3ccb936f@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sun, 24 Mar 2019 01:03:05 +0100
Message-ID: <CA+chaQdD2ntrXWWKScSfs5LHNU71pPOQUX0a_rty+OyxAcLfww@mail.gmail.com>
To: akuster808 <akuster808@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/12] Sumo pull request
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
X-List-Received-Date: Sun, 24 Mar 2019 00:03:15 -0000
Content-Type: multipart/alternative; boundary="0000000000008f7eeb0584cbd019"

--0000000000008f7eeb0584cbd019
Content-Type: text/plain; charset="UTF-8"

This stable/sumo-nmut?
http://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-nmut

I'm sorry, but I still don't see it there.

On Sat, Mar 23, 2019 at 9:58 PM akuster808 <akuster808@gmail.com> wrote:

>
>
> On 3/23/19 1:37 PM, Martin Jansa wrote:
>
> >  Why would I reference patchwork? How does that work if this is the only
> message sent out?
>
> I don't want you to reference patchwork.
>
> I'm only asking why you haven't included this change (
> http://lists.openembedded.org/pipermail/openembedded-core/2019-March/279999.html
> if you don't like the link to patchwork) in the pull request, or in
> sumo-next branch when patchwork status says "sumo-next".
>
>
> its in the next series. I had build failures that put everything on old
> for two weeks while I troubleshot the failures  Adding new changes would
> have just added to the problem.  if you look at stable/sumo-nmut, it has
> your changes and a few more.
>
> - armin
>
>
> On Sat, Mar 23, 2019 at 3:40 PM akuster <akuster@mvista.com> wrote:
>
>>
>>
>> On 3/23/19 1:32 AM, Martin Jansa wrote:
>>
>> Hi,
>>
>> is there a reason for not including
>> https://patchwork.openembedded.org/patch/159465/
>> ?
>>
>> Why would I reference patchwork? How does that work if this is the only
>> message sent out?
>>
>> It says sumo-next on patchwork, but I don't know which sumo-next it is, I
>> don't see it in:
>> http://git.openembedded.org/openembedded-core/log/?h=sumo-next
>>
>> I don't have write access to core.
>>
>> the changes are in contrib:
>> https://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>> - armin
>>
>>
>> On Sat, Mar 23, 2019 at 3:12 AM Armin Kuster <akuster808@gmail.com>
>> wrote:
>>
>>> Please consider this for the next sumo update
>>>
>>> The following changes since commit
>>> 6d56e912fbbaa22830b4da5ab230586a3d15b23e:
>>>
>>>   package_rpm/archiver: Apply bandaid to src.rpm creation (2019-02-25
>>> 22:13:08 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.openembedded.org/openembedded-core-contrib stable/sumo-next
>>>
>>> http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>>>
>>> Chen Qi (2):
>>>   systemd: fix CVE-2018-15686
>>>   systemd: fix CVE-2018-15688
>>>
>>> George McCollister (5):
>>>   systemd: fix CVE-2018-15687
>>>   systemd: Security fix CVE-2018-16864
>>>   systemd: Security fix CVE-2018-16865
>>>   systemd: fix CVE-2018-6954
>>>   systemd: fix CVE-2019-6454
>>>
>>> Marcus Cooper (1):
>>>   systemd: Security fix CVE-2018-16866
>>>
>>> Mingli Yu (1):
>>>   logrotate.py: restore /etc/logrotate.d/wtmp
>>>
>>> ROGEZ Matthieu (1):
>>>   systemd: Fix typo in root home variable.
>>>
>>> Richard Purdie (1):
>>>   oeqa/runtime/dnf: Fix test error when static libs are enabled
>>>
>>> Stefan Agner (1):
>>>   run-postinsts: for dpkg/opkg, do not rely on /etc/*-postinsts
>>>
>>>  meta/lib/oeqa/runtime/cases/dnf.py                 |    2 +-
>>>  meta/lib/oeqa/runtime/cases/logrotate.py           |    6 +-
>>>  ...sive-let-s-rework-the-recursive-logic-to-.patch |  252 +++
>>>  ...eserializing-state-always-use-read_line-L.patch |  250 +++
>>>  ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +
>>>  ...n-t-resolve-pathnames-when-traversing-rec.patch |  643 +++++++
>>>  .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828
>>> ++++++++++++++++++++
>>>  ...-not-store-the-iovec-entry-for-process-co.patch |  193 +++
>>>  ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +
>>>  ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +
>>>  ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +
>>>  .../systemd/systemd/CVE-2019-6454.patch            |  210 +++
>>>  ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +
>>>  meta/recipes-core/systemd/systemd_237.bb           |   13 +-
>>>  .../run-postinsts/run-postinsts/run-postinsts      |   21 +-
>>>  .../run-postinsts/run-postinsts.service            |    1 -
>>>  16 files changed, 3694 insertions(+), 13 deletions(-)
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch
>>>  create mode 100644 meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
>>>  create mode 100644
>>> meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch
>>>
>>> --
>>> 2.7.4
>>>
>>> --
>>> _______________________________________________
>>> bitbake-devel mailing list
>>> bitbake-devel@lists.openembedded.org
>>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>>
>>
>>
>>
>

--0000000000008f7eeb0584cbd019
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">This stable/sumo-nmut?<div><a href=3D"htt=
p://git.openembedded.org/openembedded-core-contrib/log/?h=3Dstable/sumo-nmu=
t">http://git.openembedded.org/openembedded-core-contrib/log/?h=3Dstable/su=
mo-nmut</a><br></div><div><br></div><div>I&#39;m sorry, but I still don&#39=
;t see it there.</div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Mar 23, 2019 at 9:58 PM akuster808 &l=
t;<a href=3D"mailto:akuster808@gmail.com">akuster808@gmail.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <br>
    <br>
    <div class=3D"gmail-m_-6627059004469126089moz-cite-prefix">On 3/23/19 1=
:37 PM, Martin Jansa wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"ltr">&gt;=C2=A0
          Why would I reference patchwork? How does that work if this is
          the only message sent out?
          <div><br>
          </div>
          <div>I don&#39;t want you to reference patchwork.</div>
          <div><br>
          </div>
          <div>I&#39;m only asking why you haven&#39;t included this change=
 (<a href=3D"http://lists.openembedded.org/pipermail/openembedded-core/2019=
-March/279999.html" target=3D"_blank">http://lists.openembedded.org/piperma=
il/openembedded-core/2019-March/279999.html</a>
            if you don&#39;t like the link to patchwork) in the pull
            request, or in sumo-next branch when patchwork status says
            &quot;sumo-next&quot;.</div>
        </div>
      </div>
    </blockquote>
    <br>
    its in the next series. I had build failures that put everything on
    old for two weeks while I troubleshot the failures=C2=A0 Adding new
    changes would have just added to the problem.=C2=A0 if you look at
    stable/sumo-nmut, it has your changes and a few more.<br>
    <br>
    - armin<br>
    <blockquote type=3D"cite"><br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 23, 2019 at 3:40
          PM akuster &lt;<a href=3D"mailto:akuster@mvista.com" target=3D"_b=
lank">akuster@mvista.com</a>&gt; wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div bgcolor=3D"#FFFFFF"> <br>
            <br>
            <div class=3D"gmail-m_-6627059004469126089gmail-m_7305473577171=
404396moz-cite-prefix">On
              3/23/19 1:32 AM, Martin Jansa wrote:<br>
            </div>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">Hi,
                <div><br>
                </div>
                <div>is there a reason for not including</div>
                <div><a href=3D"https://patchwork.openembedded.org/patch/15=
9465/" target=3D"_blank">https://patchwork.openembedded.org/patch/159465/</=
a><br>
                </div>
                <div>?</div>
                <div><br>
                </div>
              </div>
            </blockquote>
            Why would I reference patchwork? How does that work if this
            is the only message sent out?<br>
            <br>
            <blockquote type=3D"cite">
              <div dir=3D"ltr">
                <div>It says sumo-next on patchwork, but I don&#39;t know
                  which sumo-next it is, I don&#39;t see it in:</div>
                <div><a href=3D"http://git.openembedded.org/openembedded-co=
re/log/?h=3Dsumo-next" target=3D"_blank">http://git.openembedded.org/openem=
bedded-core/log/?h=3Dsumo-next</a><br>
                </div>
              </div>
            </blockquote>
            I don&#39;t have write access to core.<br>
            <br>
            the changes are in contrib:
            <a class=3D"gmail-m_-6627059004469126089gmail-m_730547357717140=
4396moz-txt-link-freetext" href=3D"https://git.openembedded.org/openembedde=
d-core-contrib/log/?h=3Dstable/sumo-next" target=3D"_blank">https://git.ope=
nembedded.org/openembedded-core-contrib/log/?h=3Dstable/sumo-next</a><br>
            - armin<br>
            <blockquote type=3D"cite"><br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 23, 2019
                  at 3:12 AM Armin Kuster &lt;<a href=3D"mailto:akuster808@=
gmail.com" target=3D"_blank">akuster808@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Please co=
nsider
                  this for the next sumo update<br>
                  <br>
                  The following changes since commit
                  6d56e912fbbaa22830b4da5ab230586a3d15b23e:<br>
                  <br>
                  =C2=A0 package_rpm/archiver: Apply bandaid to src.rpm
                  creation (2019-02-25 22:13:08 +0000)<br>
                  <br>
                  are available in the git repository at:<br>
                  <br>
                  =C2=A0 git://<a href=3D"http://git.openembedded.org/opene=
mbedded-core-contrib" rel=3D"noreferrer" target=3D"_blank">git.openembedded=
.org/openembedded-core-contrib</a>
                  stable/sumo-next<br>
                  =C2=A0 <a href=3D"http://cgit.openembedded.org/openembedd=
ed-core-contrib/log/?h=3Dstable/sumo-next" rel=3D"noreferrer" target=3D"_bl=
ank">http://cgit.openembedded.org/openembedded-core-contrib/log/?h=3Dstable=
/sumo-next</a><br>
                  <br>
                  Chen Qi (2):<br>
                  =C2=A0 systemd: fix CVE-2018-15686<br>
                  =C2=A0 systemd: fix CVE-2018-15688<br>
                  <br>
                  George McCollister (5):<br>
                  =C2=A0 systemd: fix CVE-2018-15687<br>
                  =C2=A0 systemd: Security fix CVE-2018-16864<br>
                  =C2=A0 systemd: Security fix CVE-2018-16865<br>
                  =C2=A0 systemd: fix CVE-2018-6954<br>
                  =C2=A0 systemd: fix CVE-2019-6454<br>
                  <br>
                  Marcus Cooper (1):<br>
                  =C2=A0 systemd: Security fix CVE-2018-16866<br>
                  <br>
                  Mingli Yu (1):<br>
                  =C2=A0 logrotate.py: restore /etc/logrotate.d/wtmp<br>
                  <br>
                  ROGEZ Matthieu (1):<br>
                  =C2=A0 systemd: Fix typo in root home variable.<br>
                  <br>
                  Richard Purdie (1):<br>
                  =C2=A0 oeqa/runtime/dnf: Fix test error when static libs
                  are enabled<br>
                  <br>
                  Stefan Agner (1):<br>
                  =C2=A0 run-postinsts: for dpkg/opkg, do not rely on
                  /etc/*-postinsts<br>
                  <br>
                  =C2=A0meta/lib/oeqa/runtime/cases/dnf.py=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0
                  =C2=A0 2 +-<br>
                  =C2=A0meta/lib/oeqa/runtime/cases/logrotate.py=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0
                  =C2=A0 6 +-<br>
                  =C2=A0...sive-let-s-rework-the-recursive-logic-to-.patch =
|=C2=A0
                  252 +++<br>
                  =C2=A0...eserializing-state-always-use-read_line-L.patch =
|=C2=A0
                  250 +++<br>
                  =C2=A0...sure-we-have-enough-space-for-the-DHCP6-o.patch =
|=C2=A0
                  =C2=A039 +<br>
                  =C2=A0...n-t-resolve-pathnames-when-traversing-rec.patch =
|=C2=A0
                  643 +++++++<br>
                  =C2=A0.../systemd/systemd/0002-Make-tmpfiles-safe.patch=
=C2=A0 |
                  1828 ++++++++++++++++++++<br>
                  =C2=A0...-not-store-the-iovec-entry-for-process-co.patch =
|=C2=A0
                  193 +++<br>
                  =C2=A0...ld-set-a-limit-on-the-number-of-fields-1k.patch =
|=C2=A0
                  =C2=A060 +<br>
                  =C2=A0...ote-set-a-limit-on-the-number-of-fields-i.patch =
|=C2=A0
                  =C2=A079 +<br>
                  =C2=A0...nal-fix-out-of-bounds-read-CVE-2018-16866.patch =
|=C2=A0
                  =C2=A049 +<br>
                  =C2=A0.../systemd/systemd/CVE-2019-6454.patch=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0
                  210 +++<br>
                  =C2=A0...e-receive-an-invalid-dbus-message-ignore-.patch =
|=C2=A0
                  =C2=A061 +<br>
                  =C2=A0meta/recipes-core/systemd/<a href=3D"http://systemd=
_237.bb" rel=3D"noreferrer" target=3D"_blank">systemd_237.bb</a>=C2=A0
                  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A013 +-<br>
                  =C2=A0.../run-postinsts/run-postinsts/run-postinsts=C2=A0=
 =C2=A0 =C2=A0 |=C2=A0
                  =C2=A021 +-<br>
                  =C2=A0.../run-postinsts/run-postinsts.service=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0
                  =C2=A0 1 -<br>
                  =C2=A016 files changed, 3694 insertions(+), 13 deletions(=
-)<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-rec=
ursive-logic-to-.patch<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always=
-use-read_line-L.patch<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space=
-for-the-DHCP6-o.patch<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-whe=
n-traversing-rec.patch<br>
                  =C2=A0create mode 100644
                  meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe=
.patch<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entr=
y-for-process-co.patch<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-o=
f-fields-1k.patch<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-nu=
mber-of-fields-i.patch<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2=
018-16866.patch<br>
                  =C2=A0create mode 100644
                  meta/recipes-core/systemd/systemd/CVE-2019-6454.patch<br>
                  =C2=A0create mode 100644
meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-mess=
age-ignore-.patch<br>
                  <br>
                  -- <br>
                  2.7.4<br>
                  <br>
                  -- <br>
                  _______________________________________________<br>
                  bitbake-devel mailing list<br>
                  <a href=3D"mailto:bitbake-devel@lists.openembedded.org" t=
arget=3D"_blank">bitbake-devel@lists.openembedded.org</a><br>
                  <a href=3D"http://lists.openembedded.org/mailman/listinfo=
/bitbake-devel" rel=3D"noreferrer" target=3D"_blank">http://lists.openembed=
ded.org/mailman/listinfo/bitbake-devel</a><br>
                </blockquote>
              </div>
              <br>
              <fieldset class=3D"gmail-m_-6627059004469126089gmail-m_730547=
3577171404396mimeAttachmentHeader"></fieldset>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--0000000000008f7eeb0584cbd019--
