Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
	[209.85.128.47])
	by mail.openembedded.org (Postfix) with ESMTP id E717079ECE
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 20:37:22 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id v14so5273730wmf.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Q0DhjtHH6Gi/rjO0fWMX8g++h+jtlDVn4hPAw9IvJlA=;
	b=Nko+l2W8Xxe8KfemqEeM1wM68501eUw16RGSKZR7uOER4dbE9q4WGaxIlIKmAYuMxA
	87Xm85V6b0kWjUtt0WWZ0frxXvG0ZIkAD5BoMvpsYBJomjdF+1WvS6+ZEC3a3J/n4ZNU
	2wOOU/hkFxeodoS6C72ZqLvU0CTavgf8B42P8n1xUvrlROIkN3EfKAOuR1AkH5KBvb9K
	wHTsenmwdIb1Gc3q92GMU54ePw7ZX9P2eSaId7FXBzifwenDcKHFl5a0R3zY3o73mJgu
	KxosqKFqMvNEJMeqMmYZA5xfRscE7K9Dd+c/63/ubR7kuk0P+j1rkIc0EX4DmSL9Q3GE
	UXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Q0DhjtHH6Gi/rjO0fWMX8g++h+jtlDVn4hPAw9IvJlA=;
	b=tSlSKJBCwyi461StcE/8XxBO7lv/QhG+4U6+Q84dxOtYKMYVuoQeYWZU1Fwwx+39mo
	1JWscv1+jrUp5VGmdLx30Gf4+dLQDrSOHnGINliFMSRx4YwF4siI5BL97If3zlJhxJm0
	RA2jUubOqpsHYioQSqU28YjK9yZfdFydNlPctWJ+jiae0AVYxoa6qJN+XlCjrqKfZ0/Z
	UHkEYIufj9MdzRmk1QhNLWS9OZqJDVChi+9TUzKgClYVMXqcqJBfuB/H0ou8KhAVCnMz
	UF4W5pzJ0IyW1IQWy13q+1RnqH0el39ZhauY1onXJpZl/0+x0Wue9hUmqXbEERbP0u8J
	d2sg==
X-Gm-Message-State: APjAAAU2ZqFltqPR8tqJsGjLvA4e8u01RpvFuXwqw70TWbVsAyB3p76T
	vrV5kSyZiXTj0hX8VhpR8HMFAfuALyp3mraE1/s=
X-Google-Smtp-Source: APXvYqw04+PtoQLizPXUPPAuin8p2xeP+Ed2UEIbI0/StE+bsPEzKhfwhX+fX/qKaQMADL46szG2AVpYh0dzQH0e6Vo=
X-Received: by 2002:a1c:7706:: with SMTP id t6mr840521wmi.141.1553373443530;
	Sat, 23 Mar 2019 13:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553306877.git.akuster808@gmail.com>
	<CA+chaQcb_6aOd7Xv6D-yNtMobrU81MBSvw=0uvqjMr1-HzOS3w@mail.gmail.com>
	<5e7ac387-3a30-6fd3-b593-a2636e0cb93e@mvista.com>
In-Reply-To: <5e7ac387-3a30-6fd3-b593-a2636e0cb93e@mvista.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Sat, 23 Mar 2019 21:37:12 +0100
Message-ID: <CA+chaQdRiXjs-WcFVQ6ppe96LJ=ZehUS045GbQk5ZVHfPxZT3Q@mail.gmail.com>
To: akuster <akuster@mvista.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Armin Kuster <akuster808@gmail.com>
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
X-List-Received-Date: Sat, 23 Mar 2019 20:37:23 -0000
Content-Type: multipart/alternative; boundary="0000000000004e2a7b0584c8f07f"

--0000000000004e2a7b0584c8f07f
Content-Type: text/plain; charset="UTF-8"

>  Why would I reference patchwork? How does that work if this is the only
message sent out?

I don't want you to reference patchwork.

I'm only asking why you haven't included this change (
http://lists.openembedded.org/pipermail/openembedded-core/2019-March/279999.html
if you don't like the link to patchwork) in the pull request, or in
sumo-next branch when patchwork status says "sumo-next".

On Sat, Mar 23, 2019 at 3:40 PM akuster <akuster@mvista.com> wrote:

>
>
> On 3/23/19 1:32 AM, Martin Jansa wrote:
>
> Hi,
>
> is there a reason for not including
> https://patchwork.openembedded.org/patch/159465/
> ?
>
> Why would I reference patchwork? How does that work if this is the only
> message sent out?
>
> It says sumo-next on patchwork, but I don't know which sumo-next it is, I
> don't see it in:
> http://git.openembedded.org/openembedded-core/log/?h=sumo-next
>
> I don't have write access to core.
>
> the changes are in contrib:
> https://git.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
> - armin
>
>
> On Sat, Mar 23, 2019 at 3:12 AM Armin Kuster <akuster808@gmail.com> wrote:
>
>> Please consider this for the next sumo update
>>
>> The following changes since commit
>> 6d56e912fbbaa22830b4da5ab230586a3d15b23e:
>>
>>   package_rpm/archiver: Apply bandaid to src.rpm creation (2019-02-25
>> 22:13:08 +0000)
>>
>> are available in the git repository at:
>>
>>   git://git.openembedded.org/openembedded-core-contrib stable/sumo-next
>>
>> http://cgit.openembedded.org/openembedded-core-contrib/log/?h=stable/sumo-next
>>
>> Chen Qi (2):
>>   systemd: fix CVE-2018-15686
>>   systemd: fix CVE-2018-15688
>>
>> George McCollister (5):
>>   systemd: fix CVE-2018-15687
>>   systemd: Security fix CVE-2018-16864
>>   systemd: Security fix CVE-2018-16865
>>   systemd: fix CVE-2018-6954
>>   systemd: fix CVE-2019-6454
>>
>> Marcus Cooper (1):
>>   systemd: Security fix CVE-2018-16866
>>
>> Mingli Yu (1):
>>   logrotate.py: restore /etc/logrotate.d/wtmp
>>
>> ROGEZ Matthieu (1):
>>   systemd: Fix typo in root home variable.
>>
>> Richard Purdie (1):
>>   oeqa/runtime/dnf: Fix test error when static libs are enabled
>>
>> Stefan Agner (1):
>>   run-postinsts: for dpkg/opkg, do not rely on /etc/*-postinsts
>>
>>  meta/lib/oeqa/runtime/cases/dnf.py                 |    2 +-
>>  meta/lib/oeqa/runtime/cases/logrotate.py           |    6 +-
>>  ...sive-let-s-rework-the-recursive-logic-to-.patch |  252 +++
>>  ...eserializing-state-always-use-read_line-L.patch |  250 +++
>>  ...sure-we-have-enough-space-for-the-DHCP6-o.patch |   39 +
>>  ...n-t-resolve-pathnames-when-traversing-rec.patch |  643 +++++++
>>  .../systemd/systemd/0002-Make-tmpfiles-safe.patch  | 1828
>> ++++++++++++++++++++
>>  ...-not-store-the-iovec-entry-for-process-co.patch |  193 +++
>>  ...ld-set-a-limit-on-the-number-of-fields-1k.patch |   60 +
>>  ...ote-set-a-limit-on-the-number-of-fields-i.patch |   79 +
>>  ...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |   49 +
>>  .../systemd/systemd/CVE-2019-6454.patch            |  210 +++
>>  ...e-receive-an-invalid-dbus-message-ignore-.patch |   61 +
>>  meta/recipes-core/systemd/systemd_237.bb           |   13 +-
>>  .../run-postinsts/run-postinsts/run-postinsts      |   21 +-
>>  .../run-postinsts/run-postinsts.service            |    1 -
>>  16 files changed, 3694 insertions(+), 13 deletions(-)
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0001-chown-recursive-let-s-rework-the-recursive-logic-to-.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0001-core-when-deserializing-state-always-use-read_line-L.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0001-dhcp6-make-sure-we-have-enough-space-for-the-DHCP6-o.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0001-tmpfiles-don-t-resolve-pathnames-when-traversing-rec.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0024-journald-do-not-store-the-iovec-entry-for-process-co.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0025-journald-set-a-limit-on-the-number-of-fields-1k.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0026-journal-remote-set-a-limit-on-the-number-of-fields-i.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/0027-journal-fix-out-of-bounds-read-CVE-2018-16866.patch
>>  create mode 100644 meta/recipes-core/systemd/systemd/CVE-2019-6454.patch
>>  create mode 100644
>> meta/recipes-core/systemd/systemd/sd-bus-if-we-receive-an-invalid-dbus-message-ignore-.patch
>>
>> --
>> 2.7.4
>>
>> --
>> _______________________________________________
>> bitbake-devel mailing list
>> bitbake-devel@lists.openembedded.org
>> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>>
>
>
>

--0000000000004e2a7b0584c8f07f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt;=C2=A0

Why would I reference patchwork? How does that work if this is the only mes=
sage sent out?<div><br></div><div>I don&#39;t want you to reference patchwo=
rk.</div><div><br></div><div>I&#39;m only asking why you haven&#39;t includ=
ed this change (<a href=3D"http://lists.openembedded.org/pipermail/openembe=
dded-core/2019-March/279999.html">http://lists.openembedded.org/pipermail/o=
penembedded-core/2019-March/279999.html</a> if you don&#39;t like the link =
to patchwork) in the pull request, or in sumo-next branch when patchwork st=
atus says &quot;sumo-next&quot;.</div></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 23, 2019 at 3:40 PM=
 akuster &lt;<a href=3D"mailto:akuster@mvista.com">akuster@mvista.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <br>
    <br>
    <div class=3D"gmail-m_7305473577171404396moz-cite-prefix">On 3/23/19 1:=
32 AM, Martin Jansa wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">Hi,
        <div><br>
        </div>
        <div>is there a reason for not including</div>
        <div><a href=3D"https://patchwork.openembedded.org/patch/159465/" t=
arget=3D"_blank">https://patchwork.openembedded.org/patch/159465/</a><br>
        </div>
        <div>?</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    Why would I reference patchwork? How does that work if this is the
    only message sent out?<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>It says sumo-next on patchwork, but I don&#39;t know which
          sumo-next it is, I don&#39;t see it in:</div>
        <div><a href=3D"http://git.openembedded.org/openembedded-core/log/?=
h=3Dsumo-next" target=3D"_blank">http://git.openembedded.org/openembedded-c=
ore/log/?h=3Dsumo-next</a><br>
        </div>
      </div>
    </blockquote>
    I don&#39;t have write access to core.<br>
    <br>
    the changes are in contrib:
<a class=3D"gmail-m_7305473577171404396moz-txt-link-freetext" href=3D"https=
://git.openembedded.org/openembedded-core-contrib/log/?h=3Dstable/sumo-next=
" target=3D"_blank">https://git.openembedded.org/openembedded-core-contrib/=
log/?h=3Dstable/sumo-next</a><br>
    - armin<br>
    <blockquote type=3D"cite"><br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 23, 2019 at 3:12
          AM Armin Kuster &lt;<a href=3D"mailto:akuster808@gmail.com" targe=
t=3D"_blank">akuster808@gmail.com</a>&gt; wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Please
          consider this for the next sumo update<br>
          <br>
          The following changes since commit
          6d56e912fbbaa22830b4da5ab230586a3d15b23e:<br>
          <br>
          =C2=A0 package_rpm/archiver: Apply bandaid to src.rpm creation
          (2019-02-25 22:13:08 +0000)<br>
          <br>
          are available in the git repository at:<br>
          <br>
          =C2=A0 git://<a href=3D"http://git.openembedded.org/openembedded-=
core-contrib" rel=3D"noreferrer" target=3D"_blank">git.openembedded.org/ope=
nembedded-core-contrib</a>
          stable/sumo-next<br>
          =C2=A0 <a href=3D"http://cgit.openembedded.org/openembedded-core-=
contrib/log/?h=3Dstable/sumo-next" rel=3D"noreferrer" target=3D"_blank">htt=
p://cgit.openembedded.org/openembedded-core-contrib/log/?h=3Dstable/sumo-ne=
xt</a><br>
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
          =C2=A0 oeqa/runtime/dnf: Fix test error when static libs are
          enabled<br>
          <br>
          Stefan Agner (1):<br>
          =C2=A0 run-postinsts: for dpkg/opkg, do not rely on
          /etc/*-postinsts<br>
          <br>
          =C2=A0meta/lib/oeqa/runtime/cases/dnf.py=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +-<br>
          =C2=A0meta/lib/oeqa/runtime/cases/logrotate.py=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 6 +-<br>
          =C2=A0...sive-let-s-rework-the-recursive-logic-to-.patch |=C2=A0 =
252 +++<br>
          =C2=A0...eserializing-state-always-use-read_line-L.patch |=C2=A0 =
250 +++<br>
          =C2=A0...sure-we-have-enough-space-for-the-DHCP6-o.patch |=C2=A0 =
=C2=A039 +<br>
          =C2=A0...n-t-resolve-pathnames-when-traversing-rec.patch |=C2=A0 =
643
          +++++++<br>
          =C2=A0.../systemd/systemd/0002-Make-tmpfiles-safe.patch=C2=A0 | 1=
828
          ++++++++++++++++++++<br>
          =C2=A0...-not-store-the-iovec-entry-for-process-co.patch |=C2=A0 =
193 +++<br>
          =C2=A0...ld-set-a-limit-on-the-number-of-fields-1k.patch |=C2=A0 =
=C2=A060 +<br>
          =C2=A0...ote-set-a-limit-on-the-number-of-fields-i.patch |=C2=A0 =
=C2=A079 +<br>
          =C2=A0...nal-fix-out-of-bounds-read-CVE-2018-16866.patch |=C2=A0 =
=C2=A049 +<br>
          =C2=A0.../systemd/systemd/CVE-2019-6454.patch=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 210 +++<br>
          =C2=A0...e-receive-an-invalid-dbus-message-ignore-.patch |=C2=A0 =
=C2=A061 +<br>
          =C2=A0meta/recipes-core/systemd/<a href=3D"http://systemd_237.bb"=
 rel=3D"noreferrer" target=3D"_blank">systemd_237.bb</a>=C2=A0
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A013 +-<br>
          =C2=A0.../run-postinsts/run-postinsts/run-postinsts=C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A021 +-<br>
          =C2=A0.../run-postinsts/run-postinsts.service=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 -<br>
          =C2=A016 files changed, 3694 insertions(+), 13 deletions(-)<br>
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
          meta/recipes-core/systemd/systemd/0002-Make-tmpfiles-safe.patch<b=
r>
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
          <a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D=
"_blank">bitbake-devel@lists.openembedded.org</a><br>
          <a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake=
-devel" rel=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/=
mailman/listinfo/bitbake-devel</a><br>
        </blockquote>
      </div>
      <br>
      <fieldset class=3D"gmail-m_7305473577171404396mimeAttachmentHeader"><=
/fieldset>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--0000000000004e2a7b0584c8f07f--
